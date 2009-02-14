From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/7] Fix handling of ident-less declarations
Date: Sat, 14 Feb 2009 12:25:05 +0000
Message-ID: <E1LYJZx-0001ls-Nn@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37431 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZBNMZH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:07 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJZx-0001ls-Nn
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:05 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


The rule for ident-less declaration is
	declaration -> declaration-specifiers ;
not
	declaration -> declaration-specifiers abstract-declarator;

IOW, struct foo; is OK and so's struct foo {int x; int y;} (and even
simply int; is allowed by syntax - it's rejected by constraints, but
that's a separate story), but not struct foo (void); and its ilk.

See C99 6.7p1 for syntax; C90 is the same in that area and gcc also
behaves the same way.  Unlike gcc I've made it a warning (gcc produces
a hard error for those).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                    |   10 +++++++++-
 validation/missing-ident.c |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletions(-)
 create mode 100644 validation/missing-ident.c

diff --git a/parse.c b/parse.c
index 73e7b65..6100fc2 100644
--- a/parse.c
+++ b/parse.c
@@ -2265,14 +2265,22 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	token = declaration_specifiers(token, &ctype, 0);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	decl->ctype = ctype;
+	/* Just a type declaration? */
+	if (match_op(token, ';')) {
+		apply_modifiers(token->pos, &decl->ctype);
+		return token->next;
+	}
+
 	token = declarator(token, decl, &ident, 0);
 	apply_modifiers(token->pos, &decl->ctype);
 
 	decl->endpos = token->pos;
 
 	/* Just a type declaration? */
-	if (!ident)
+	if (!ident) {
+		warning(token->pos, "missing identifier in declaration");
 		return expect(token, ';', "end of type declaration");
+	}
 
 	/* type define declaration? */
 	is_typedef = (ctype.modifiers & MOD_TYPEDEF) != 0;
diff --git a/validation/missing-ident.c b/validation/missing-ident.c
new file mode 100644
index 0000000..ce73983
--- /dev/null
+++ b/validation/missing-ident.c
@@ -0,0 +1,18 @@
+int [2];
+int *;
+int (*);
+int ();
+int;
+struct foo;
+union bar {int x; int y;};
+struct baz {int x, :3, y:2;};
+/*
+ * check-name: handling of identifier-less declarations
+ *
+ * check-error-start
+missing-ident.c:1:8: warning: missing identifier in declaration
+missing-ident.c:2:6: warning: missing identifier in declaration
+missing-ident.c:3:8: warning: missing identifier in declaration
+missing-ident.c:4:7: warning: missing identifier in declaration
+ * check-error-end
+ */
-- 
1.5.6.6


