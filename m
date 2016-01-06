From: Lance Richardson <lrichard@redhat.com>
Subject: [PATCH] sparse: add support for static assert
Date: Wed,  6 Jan 2016 13:35:17 -0500
Message-ID: <1452105317-5828-1-git-send-email-lrichard@redhat.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbcAFSfS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Jan 2016 13:35:18 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 96B861204AB
	for <linux-sparse@vger.kernel.org>; Wed,  6 Jan 2016 18:35:18 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: lrichard@redhat.com

This patch introduces support for _Static_assert() in global,
function, and struct/union declaration contexts (as currently supported
by gcc).

Tested via:
   - kernel build with C=1 CF=-D__CHECK_ENDIAN__
   - build/check large code base making heavy use of _Static_assert()
   - "make check" with added test case for static assert support

Signed-off-by: Lance Richardson <lrichard@redhat.com>
---
 parse.c                    | 33 ++++++++++++++++++++++++++++++++-
 validation/static_assert.c | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 validation/static_assert.c

diff --git a/parse.c b/parse.c
index b43d683..0b1a7f2 100644
--- a/parse.c
+++ b/parse.c
@@ -57,7 +57,8 @@ static declarator_t
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
-	thread_specifier, const_qualifier, volatile_qualifier;
+	thread_specifier, const_qualifier, volatile_qualifier,
+	static_assert_specifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -308,6 +309,11 @@ static struct symbol_op asm_op = {
 	.toplevel = toplevel_asm_declaration,
 };
 
+static struct symbol_op static_assert_op = {
+	.type = KW_ATTRIBUTE,
+	.declarator = static_assert_specifier,
+};
+
 static struct symbol_op packed_op = {
 	.attribute = attribute_packed,
 };
@@ -437,6 +443,10 @@ static struct init_keyword {
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict__",	NS_TYPEDEF, .op = &restrict_op},
 
+
+	/* Static assertion */
+	{ "_Static_assert", NS_TYPEDEF, .op = &static_assert_op },
+
 	/* Storage class */
 	{ "auto",	NS_TYPEDEF, .op = &auto_op },
 	{ "register",	NS_TYPEDEF, .op = &register_op },
@@ -2004,6 +2014,27 @@ static struct token *parse_asm_declarator(struct token *token, struct decl_state
 	return token;
 }
 
+
+static struct token *static_assert_specifier(struct token *token, struct decl_state *ctx)
+{
+	struct expression *expr = NULL;
+	int val;
+
+	token = constant_expression(token->next, &expr);
+	if (!expr)
+		sparse_error(token->pos, "Expected constant expression");
+	val = get_expression_value(expr);
+	token = expect(token, ',', "after first argument of _Static_assert");
+	token = parse_expression(token, &expr);
+	token = expect(token, ')', "after second argument of _Static_assert");
+
+	if (!val)
+		sparse_error(token->pos, "static assertion failed: %s",
+                             show_string(expr->string));
+
+	return token;
+}
+
 /* Make a statement out of an expression */
 static struct statement *make_statement(struct expression *expr)
 {
diff --git a/validation/static_assert.c b/validation/static_assert.c
new file mode 100644
index 0000000..baab346
--- /dev/null
+++ b/validation/static_assert.c
@@ -0,0 +1,20 @@
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
+_Static_assert(0, "expected failure");
+/*
+ * check-name: static assertion
+ *
+ * check-error-start
+static_assert.c:12:38: error: static assertion failed: "expected failure"
+ * check-error-end
+ */
+
-- 
2.5.0

