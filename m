From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH v2] sparse: add support for static assert
Date: Mon, 11 Jan 2016 17:31:22 -0500
Message-ID: <1452551482-1250-1-git-send-email-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49256 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758738AbcAKWbX (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Jan 2016 17:31:23 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 4B3FFA37FC
	for <linux-sparse@vger.kernel.org>; Mon, 11 Jan 2016 22:31:23 +0000 (UTC)
Received: from Corsair.redhat.com (vpn-49-24.rdu2.redhat.com [10.10.49.24])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u0BMVMSU000390
	for <linux-sparse@vger.kernel.org>; Mon, 11 Jan 2016 17:31:22 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This patch introduces support for _Static_assert() in global,
function, and struct/union declaration contexts (as currently supported
by gcc).

Tested via:
   - kernel build with C=1 CF=-D__CHECK_ENDIAN__
   - build/check large code base making heavy use of _Static_assert()
   - "make check" with added test cases for static assert support

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
v2: add additional test cases
    add additional validation for parameters to _Static_assert()
    rework implementation to avoid impacting struct/union definition handling

 parse.c                    | 65 +++++++++++++++++++++++++++++++++++++++++++++-
 symbol.h                   |  1 +
 validation/static_assert.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 validation/static_assert.c

diff --git a/parse.c b/parse.c
index b43d683..866c99d 100644
--- a/parse.c
+++ b/parse.c
@@ -57,7 +57,8 @@ static declarator_t
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
-	thread_specifier, const_qualifier, volatile_qualifier;
+	thread_specifier, const_qualifier, volatile_qualifier,
+	static_assert_declarator;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -73,6 +74,8 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
+static struct token *parse_static_assert_statement(struct token *token, struct statement *stmt);
+static struct token *toplevel_static_assert(struct token *token, struct symbol_list **list);
 
 typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
@@ -308,6 +311,13 @@ static struct symbol_op asm_op = {
 	.toplevel = toplevel_asm_declaration,
 };
 
+static struct symbol_op static_assert_op = {
+	.type = KW_ST_ASSERT,
+	.declarator = static_assert_declarator,
+	.statement = parse_static_assert_statement,
+	.toplevel = toplevel_static_assert,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -437,6 +447,10 @@ static struct init_keyword {
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
+
+	/* Static assertion */
+	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
+
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
 	{ "register",	NS_TYPEDEF, .op = &register_op },
@@ -1856,6 +1870,13 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
 {
 	while (!match_op(token, '}')) {
+		struct symbol *keyword;
+
+		if (token_type(token) == TOKEN_IDENT) {
+			keyword = lookup_keyword(token->ident, NS_KEYWORD);
+			if (keyword && keyword->op->type == KW_ST_ASSERT)
+				token = keyword->op->declarator(token, NULL);
+		}
 		if (!match_op(token, ';'))
 			token = declaration_list(token, list);
 		if (!match_op(token, ';')) {
@@ -2004,6 +2025,48 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
 	return token;
 }
 
+
+static struct token *parse_static_assert(struct token *token, int expect_semi)
+{
+	struct expression *expr1 = NULL, *expr2 = NULL;
+	int val;
+
+	token = expect(token, '(', "after _Static_assert");
+	token = constant_expression(token, &expr1);
+	token = expect(token, ',', "after first argument of _Static_assert");
+	token = parse_expression(token, &expr2);
+	token = expect(token, ')', "after second argument of _Static_assert");
+
+	if (expect_semi)
+		token = expect(token, ';', "after _Static_assert()");
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
+static struct token *static_assert_declarator(struct token *token, struct decl_state *ctx)
+{
+	return parse_static_assert(token->next, 0);
+}
+
+static struct token *parse_static_assert_statement(struct token *token, struct statement *stmt)
+{
+	return parse_static_assert(token->next, 1);
+}
+static struct token *toplevel_static_assert(struct token *token, struct symbol_list **list)
+{
+	return parse_static_assert(token->next, 1);
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
diff --git a/symbol.h b/symbol.h
index ccb5dcb..2822b0a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -86,6 +86,7 @@ enum keyword {
 	KW_SHORT	= 1 << 7,
 	KW_LONG		= 1 << 8,
 	KW_EXACT	= 1 << 9,
+	KW_ST_ASSERT	= 1 << 10,
 };
 
 struct context {
diff --git a/validation/static_assert.c b/validation/static_assert.c
new file mode 100644
index 0000000..d3da954
--- /dev/null
+++ b/validation/static_assert.c
@@ -0,0 +1,62 @@
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
+struct s2 {
+	char c;
+	_Static_assert(sizeof(struct s2) == 1, "struct sizeof");
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
1.9.1

