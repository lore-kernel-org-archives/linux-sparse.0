From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH v4] sparse: add support for _Static_assert
Date: Wed,  3 May 2017 12:55:18 -0400
Message-ID: <20170503165518.7625-1-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751394AbdECQzU (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 12:55:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B87E69969
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2017 16:55:20 +0000 (UTC)
Received: from thinkcentre.localdomain.com (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F30D9189CB
        for <linux-sparse@vger.kernel.org>; Wed,  3 May 2017 16:55:19 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This patch introduces support for the C11 _Static_assert() construct.

Per the N1539 draft standard, the syntax changes for this construct
include:

    declaration:
        <declaration-specifiers> <init-declarator-list>[opt] ;
        <static_assert-declaration>

    struct-declaration:
        <specifier-qualifier-list> <struct-declarator-list>[opt] ;
        <static_assert-declaration>

    static_assert-declaration:
        _Static_assert ( <constant-expression> , <string-literal> ) ;

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
v4: Addressed feedback, simplified and restructured to better model
    description in draft standard.

v3:
    - Removed bogus test case introduced in v2 (static assertion on sizeof
      a structure within the definition of the structure).

v2: 
    - Added additional test cases.
    - Added additional validation for parameters to _Static_assert().
    - Reworked implementation to avoid impacting struct/union definition
      handling ( the v1 implementation, which treated _Static_assert()
      as an NS_TYPEDEF term, had the unfortunate side-effect of
      leaving an unnamed field with unknown size attached to structure
      definitions when a static assert was inside a structure definition).

 parse.c                    | 65 +++++++++++++++++++++++++++++++++++++++++-----
 validation/static_assert.c | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 7 deletions(-)
 create mode 100644 validation/static_assert.c

diff --git a/parse.c b/parse.c
index b52c6ab..f1b96cc 100644
--- a/parse.c
+++ b/parse.c
@@ -73,6 +73,7 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
+static struct token *parse_static_assert(struct token *token, struct symbol_list **unused);
 
 typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
@@ -308,6 +309,10 @@ static struct symbol_op asm_op = {
 	.toplevel = toplevel_asm_declaration,
 };
 
+static struct symbol_op static_assert_op = {
+	.toplevel = parse_static_assert,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -437,6 +442,9 @@ static struct init_keyword {
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
+	/* Static assertion */
+	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
+
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
 	{ "register",	NS_TYPEDEF, .op = &register_op },
@@ -1864,13 +1872,21 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
 {
 	while (!match_op(token, '}')) {
-		if (!match_op(token, ';'))
-			token = declaration_list(token, list);
-		if (!match_op(token, ';')) {
-			sparse_error(token->pos, "expected ; at end of declaration");
-			break;
+		struct symbol *keyword = NULL;
+
+		if (token_type(token) == TOKEN_IDENT)
+			keyword = lookup_keyword(token->ident, NS_KEYWORD);
+		if (keyword && keyword->op == &static_assert_op)
+			token = parse_static_assert(token, NULL);
+		else {
+			if (!match_op(token, ';'))
+				token = declaration_list(token, list);
+			if (!match_op(token, ';')) {
+				sparse_error(token->pos, "expected ; at end of declaration");
+				break;
+			}
+			token = token->next;
 		}
-		token = token->next;
 	}
 	return token;
 }
@@ -2012,6 +2028,36 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
 	return token;
 }
 
+
+static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
+{
+	struct expression *expr1 = NULL, *expr2 = NULL;
+	int val;
+
+	token = expect(token->next, '(', "after _Static_assert");
+	token = constant_expression(token, &expr1);
+	token = expect(token, ',', "after first argument of _Static_assert");
+	token = parse_expression(token, &expr2);
+	token = expect(token, ')', "after second argument of _Static_assert");
+
+        token = expect(token, ';', "after _Static_assert()");
+
+	if (!expr1 || !expr2)
+		return token;
+
+	val = const_expression_value(expr1);
+
+	if (expr2->type != EXPR_STRING)
+		sparse_error(expr2->pos, "bad string literal");
+	else if (expr1 && (expr1->type == EXPR_VALUE)) {
+		if (!val)
+			sparse_error(expr1->pos, "static assertion failed: %s",
+				     show_string(expr2->string));
+	}
+
+	return token;
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
@@ -2378,6 +2424,7 @@ static struct token * statement_list(struct token *token, struct statement_list
 		token = label_statement(token->next);
 	for (;;) {
 		struct statement * stmt;
+		struct symbol *keyword;
 		if (eof_token(token))
 			break;
 		if (match_op(token, '}'))
@@ -2389,6 +2436,10 @@ static struct token * statement_list(struct token *token, struct statement_list
 			}
 			stmt = alloc_statement(token->pos, STMT_DECLARATION);
 			token = external_declaration(token, &stmt->declaration);
+		} else if (token_type(token) == TOKEN_IDENT &&
+			   (keyword = lookup_keyword(token->ident, NS_KEYWORD)) &&
+			   keyword->op == &static_assert_op) {
+			token = parse_static_assert(token, NULL);
 		} else {
 			seen_statement = Wdeclarationafterstatement;
 			token = statement(token, &stmt);
@@ -2726,7 +2777,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	unsigned long mod;
 	int is_typedef;
 
-	/* Top-level inline asm? */
+	/* Top-level inline asm or static assertion? */
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_keyword(token->ident, NS_KEYWORD);
 		if (s && s->op->toplevel)
diff --git a/validation/static_assert.c b/validation/static_assert.c
new file mode 100644
index 0000000..a1ef68f
--- /dev/null
+++ b/validation/static_assert.c
@@ -0,0 +1,57 @@
+_Static_assert(1, "global ok");
+
+struct foo {
+	_Static_assert(1, "struct ok");
+};
+
+void bar(void)
+{
+	_Static_assert(1, " func ok");
+}
+
+_Static_assert(0, "expected assertion failure");
+
+static int f;
+_Static_assert(f, "non-constant expression");
+
+static int *p;
+_Static_assert(p, "non-integer expression");
+
+_Static_assert(0.1, "float expression");
+        
+_Static_assert(!0 == 1, "non-trivial expression");
+        
+static char array[4];
+_Static_assert(sizeof(array) == 4, "sizeof expression");
+        
+static const char non_literal_string[] = "non literal string";
+_Static_assert(0, non_literal_string);
+
+_Static_assert(1 / 0, "invalid expression: should not show up?");
+
+struct s {
+	char arr[16];
+	_Static_assert(1, "inside struct");
+};
+
+union u {
+	char c;
+	int  i;
+	_Static_assert(1, "inside union");
+};
+
+_Static_assert(sizeof(struct s) == 16, "sizeof assertion");
+
+/*
+ * check-name: static assertion
+ *
+ * check-error-start
+static_assert.c:12:16: error: static assertion failed: "expected assertion failure"
+static_assert.c:15:16: error: bad constant expression
+static_assert.c:18:16: error: bad constant expression
+static_assert.c:20:16: error: bad constant expression
+static_assert.c:28:19: error: bad string literal
+static_assert.c:30:18: error: bad constant expression
+ * check-error-end
+ */
+
-- 
2.9.3

