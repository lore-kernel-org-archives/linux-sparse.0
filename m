From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 2/7] Separate parsing of identifier-list (in K&R-style declarations)
Date: Sat, 14 Feb 2009 12:25:15 +0000
Message-ID: <E1LYJa7-0001mV-KZ@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37432 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbZBNMZQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:16 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJa7-0001mV-KZ
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:15 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Don't mix it with parameter-type-list, add saner checks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                      |   28 ++++++++++++++++++++++++++--
 validation/identifier_list.c |   18 ++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 validation/identifier_list.c

diff --git a/parse.c b/parse.c
index 6100fc2..86e26aa 100644
--- a/parse.c
+++ b/parse.c
@@ -1948,12 +1948,36 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn,
 		return token;
 	}
 
+	if (match_op(token, SPECIAL_ELLIPSIS)) {
+		warning(token->pos, "variadic functions must have one named argument");
+		fn->variadic = 1;
+		return token->next;
+	}
+
+	if (token_type(token) != TOKEN_IDENT)
+		return token;
+
+	if (!lookup_type(token)) {
+		/* K&R */
+		for (;;) {
+			struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
+			sym->ident = token->ident;
+			token = token->next;
+			sym->endpos = token->pos;
+			add_symbol(list, sym);
+			if (!match_op(token, ',') ||
+			    token_type(token->next) != TOKEN_IDENT ||
+			    lookup_type(token->next))
+				break;
+			token = token->next;
+		}
+		return token;
+	}
+
 	for (;;) {
 		struct symbol *sym;
 
 		if (match_op(token, SPECIAL_ELLIPSIS)) {
-			if (!*list)
-				warning(token->pos, "variadic functions must have one named argument");
 			fn->variadic = 1;
 			token = token->next;
 			break;
diff --git a/validation/identifier_list.c b/validation/identifier_list.c
new file mode 100644
index 0000000..4691989
--- /dev/null
+++ b/validation/identifier_list.c
@@ -0,0 +1,18 @@
+typedef int T;
+void f(...);
+void g(*);
+void h(x,int);
+void i_OK(T);
+void j(x,T);
+/*
+ * check-name: identifier-list parsing
+ * check-error-start
+identifier_list.c:2:8: warning: variadic functions must have one named argument
+identifier_list.c:3:8: error: Expected ) in function declarator
+identifier_list.c:3:8: error: got *
+identifier_list.c:4:9: error: Expected ) in function declarator
+identifier_list.c:4:9: error: got ,
+identifier_list.c:6:9: error: Expected ) in function declarator
+identifier_list.c:6:9: error: got ,
+ * check-error-end
+ */
-- 
1.5.6.6


