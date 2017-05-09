From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH v7] sparse: add support for _Static_assert
Date: Tue,  9 May 2017 14:46:30 -0400
Message-ID: <20170509184630.24086-1-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdEISqc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 14:46:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D264A3D953
        for <linux-sparse@vger.kernel.org>; Tue,  9 May 2017 18:46:31 +0000 (UTC)
Received: from thinkcentre.localdomain.com (ovpn-122-120.rdu2.redhat.com [10.10.122.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 970DB18A44
        for <linux-sparse@vger.kernel.org>; Tue,  9 May 2017 18:46:31 +0000 (UTC)
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
v7: Incorporated additional feedback from Christopher Li and
    Luc van Oostenryck. Tested via "make check", also redefined
    Linux compiletime_assert() to use _Static_assert() when
    running sparse (gcc had issues with _Static_assert() in
    *.s files), no additional warnings were emitted.
v6: Incorporated feedback from Christopher Li, improved tests.
    - rebased on sparse-next branch
    - use match_ident(), eliminated match_static_assert()
    - reworked parse_static_assert() for better error reporting.
      introduced "errtok" variable to accurately report error
      column.
    - Moved static assert parsing in statement_list() for better
      readability, use "continue" to avoid duplicating lines.
    - Fixed whitespace issues (from "git am") in static_assert.c.
    - Added test cases for missing conditional expression and
      missing diagnostic string.
v5: Incorporated feedback from Christopher Li and Luc van Oostenryck:
    - Made _Static_assert a reserved identifier
    - Simplified check for _Static_assert keyword, consolidated into
      a common function.
    - Improved the "static assert within a function body" test case
      by adding a static assertion intermingled with code and adding
      a static assertion within a compound statement block.
    - Fixed use of initialized stmt variable.
    Tested by using sparse on entire kernel tree and a similarly-sized
    code tree which makes use of _Static_assert().

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

 ident-list.h               |  1 +
 parse.c                    | 45 ++++++++++++++++++++++++++++-
 validation/static_assert.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100644 validation/static_assert.c

diff --git a/ident-list.h b/ident-list.h
index 8cc66a5..3c75477 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -16,6 +16,7 @@ IDENT_RESERVED(for);
 IDENT_RESERVED(while);
 IDENT_RESERVED(do);
 IDENT_RESERVED(goto);
+IDENT_RESERVED(_Static_assert);
 
 /* C typenames. They get marked as reserved when initialized */
 IDENT(struct);
diff --git a/parse.c b/parse.c
index 80f0337..5c26ffd 100644
--- a/parse.c
+++ b/parse.c
@@ -73,6 +73,7 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
+static struct token *parse_static_assert(struct token *token, struct symbol_list **unused);
 
 typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
@@ -328,6 +329,10 @@ static struct symbol_op asm_op = {
 	.toplevel = toplevel_asm_declaration,
 };
 
+static struct symbol_op static_assert_op = {
+	.toplevel = parse_static_assert,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -466,6 +471,9 @@ static struct init_keyword {
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
+	/* Static assertion */
+	{ "_Static_assert", NS_KEYWORD, .op = &static_assert_op },
+
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
 	{ "register",	NS_TYPEDEF, .op = &register_op },
@@ -1945,6 +1953,10 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 static struct token *struct_declaration_list(struct token *token, struct symbol_list **list)
 {
 	while (!match_op(token, '}')) {
+		if (match_ident(token, &_Static_assert_ident)) {
+			token = parse_static_assert(token, NULL);
+			continue;
+		}
 		if (!match_op(token, ';'))
 			token = declaration_list(token, list);
 		if (!match_op(token, ';')) {
@@ -2093,6 +2105,33 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
 	return token;
 }
 
+static struct token *parse_static_assert(struct token *token, struct symbol_list **unused)
+{
+	struct expression *cond = NULL, *message = NULL;
+
+	token = expect(token->next, '(', "after _Static_assert");
+	token = constant_expression(token, &cond);
+	if (!cond)
+		sparse_error(token->pos, "Expected constant expression");
+	token = expect(token, ',', "after conditional expression in _Static_assert");
+	token = parse_expression(token, &message);
+	if (!message || message->type != EXPR_STRING) {
+		struct position pos;
+
+		pos = message ? message->pos : token->pos;
+		sparse_error(pos, "bad or missing string literal");
+		cond = NULL;
+	}
+	token = expect(token, ')', "after diagnostic message in _Static_assert");
+
+	token = expect(token, ';', "after _Static_assert()");
+
+	if (cond && !const_expression_value(cond) && cond->type == EXPR_VALUE)
+		sparse_error(cond->pos, "static assertion failed: %s",
+			     show_string(message->string));
+	return token;
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
@@ -2474,6 +2513,10 @@ static struct token * statement_list(struct token *token, struct statement_list
 			break;
 		if (match_op(token, '}'))
 			break;
+		if (match_ident(token, &_Static_assert_ident)) {
+			token = parse_static_assert(token, NULL);
+			continue;
+		}
 		if (lookup_type(token)) {
 			if (seen_statement) {
 				warning(token->pos, "mixing declarations and code");
@@ -2819,7 +2862,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	unsigned long mod;
 	int is_typedef;
 
-	/* Top-level inline asm? */
+	/* Top-level inline asm or static assertion? */
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_keyword(token->ident, NS_KEYWORD);
 		if (s && s->op->toplevel)
diff --git a/validation/static_assert.c b/validation/static_assert.c
new file mode 100644
index 0000000..d9e9629
--- /dev/null
+++ b/validation/static_assert.c
@@ -0,0 +1,71 @@
+_Static_assert(1, "global ok");
+
+struct foo {
+	_Static_assert(1, "struct ok");
+};
+
+void bar(void)
+{
+	_Static_assert(1, " func1 ok");
+	int i;
+	i = 0;
+	_Static_assert(1, " func2 ok");
+
+	if (1) {
+		_Static_assert(1, " func3 ok");
+	}
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
+_Static_assert(1, );
+_Static_assert(, "");
+_Static_assert(,);
+
+/*
+ * check-name: static assertion
+ *
+ * check-error-start
+static_assert.c:19:16: error: static assertion failed: "expected assertion failure"
+static_assert.c:22:16: error: bad constant expression
+static_assert.c:25:16: error: bad constant expression
+static_assert.c:27:16: error: bad constant expression
+static_assert.c:35:19: error: bad or missing string literal
+static_assert.c:37:18: error: bad constant expression
+static_assert.c:52:19: error: bad or missing string literal
+static_assert.c:53:16: error: Expected constant expression
+static_assert.c:54:16: error: Expected constant expression
+static_assert.c:54:17: error: bad or missing string literal
+ * check-error-end
+ */
-- 
2.9.3

