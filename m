From: Al Viro <viro@ftp.linux.org.uk>
Subject: Fix declaration_specifiers() handling of typedef name shadowed by NS_SYMBOL
Date: Mon, 09 Mar 2009 23:32:26 +0000
Message-ID: <E1LgoxO-0005xA-Bx@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40517 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbZCIXc2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 19:32:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgoxO-0005xA-Bx
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 23:32:26 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Doing lookup_symbol() with NS_TYPEDEF will happily skip the redeclarations
of the same identifier with NS_SYMBOL.  We need to check that we are not
dealing with something like
typedef int T;
void f(int T)
{
	static T a; /* not a valid declaration - T is not a typedef name */
or similar (e.g. enum member shadowing a typedef, etc.).

While we are at it, microoptimize similar code in lookup_type() - instead
of sym->namespace == NS_TYPEDEF we can do sym->namespace & NS_TYPEDEF;
the former will turn into "fetch 32bit value, mask all but 9 bits, compare
with NS_TYPEDEF", the latter - "check that one bit in 32bit value is set".
We never mix NS_TYPEDEF with anything in whatever->namespace, so the
tests are equivalent.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 expression.h                |    2 +-
 parse.c                     |    5 +++--
 validation/typedef_shadow.c |   12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 validation/typedef_shadow.c

diff --git a/expression.h b/expression.h
index 5136b9b..2e12b12 100644
--- a/expression.h
+++ b/expression.h
@@ -199,7 +199,7 @@ static inline int lookup_type(struct token *token)
 {
 	if (token->pos.type == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
-		return sym && sym->namespace == NS_TYPEDEF;
+		return sym && (sym->namespace & NS_TYPEDEF);
 	}
 	return 0;
 }
diff --git a/parse.c b/parse.c
index c19822c..00469b2 100644
--- a/parse.c
+++ b/parse.c
@@ -1321,8 +1321,9 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 	int size = 0;
 
 	while (token_type(token) == TOKEN_IDENT) {
-		struct symbol *s = lookup_symbol(token->ident, NS_TYPEDEF);
-		if (!s)
+		struct symbol *s = lookup_symbol(token->ident,
+						 NS_TYPEDEF | NS_SYMBOL);
+		if (!s || !(s->namespace & NS_TYPEDEF))
 			break;
 		if (s->type != SYM_KEYWORD) {
 			if (seen & Set_Any)
diff --git a/validation/typedef_shadow.c b/validation/typedef_shadow.c
new file mode 100644
index 0000000..c72cec7
--- /dev/null
+++ b/validation/typedef_shadow.c
@@ -0,0 +1,12 @@
+typedef int T;
+static void f(int T)
+{
+	static T a;
+}
+/*
+ * check-name: typedef shadowing
+ * check-error-start:
+typedef_shadow.c:4:18: error: Expected ; at end of declaration
+typedef_shadow.c:4:18: error: got a
+ * check-error-end:
+ */
-- 
1.5.6.5


