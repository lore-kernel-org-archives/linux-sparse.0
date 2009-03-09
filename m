From: Al Viro <viro@ftp.linux.org.uk>
Subject: Fix enumeration constants' scope beginning
Date: Mon, 09 Mar 2009 23:32:16 +0000
Message-ID: <E1LgoxE-0005wC-Bf@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40473 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749AbZCIXcS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 19:32:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgoxE-0005wC-Bf
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 23:32:16 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


It starts after the end of enumerator; i.e. if we have
enum {
	...
	Foo = expression,
	...
};
the scope of Foo starts only after the end of expression.
Rationale: 6.2.1p7.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                 |    7 +++----
 validation/enum_scope.c |   11 +++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 validation/enum_scope.c

diff --git a/parse.c b/parse.c
index bffb690..c19822c 100644
--- a/parse.c
+++ b/parse.c
@@ -804,10 +804,6 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 		struct token *next = token->next;
 		struct symbol *sym;
 
-		sym = alloc_symbol(token->pos, SYM_NODE);
-		bind_symbol(sym, token->ident, NS_SYMBOL);
-		sym->ctype.modifiers &= ~MOD_ADDRESSABLE;
-
 		if (match_op(next, '=')) {
 			next = constant_expression(next->next, &expr);
 			lastval = get_expression_value(expr);
@@ -828,6 +824,9 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 			expr->ctype = ctype;
 		}
 
+		sym = alloc_symbol(token->pos, SYM_NODE);
+		bind_symbol(sym, token->ident, NS_SYMBOL);
+		sym->ctype.modifiers &= ~MOD_ADDRESSABLE;
 		sym->initializer = expr;
 		sym->enum_member = 1;
 		sym->ctype.base_type = parent;
diff --git a/validation/enum_scope.c b/validation/enum_scope.c
new file mode 100644
index 0000000..92ffc8e
--- /dev/null
+++ b/validation/enum_scope.c
@@ -0,0 +1,11 @@
+enum {A = 12};
+
+static void f(void)
+{
+	enum {A = A + 1, B};
+	char s[1 - 2 * (B != 14)];
+}
+
+/*
+ * check-name: enumeration constants' scope [6.2.1p7]
+ */
-- 
1.5.6.5


