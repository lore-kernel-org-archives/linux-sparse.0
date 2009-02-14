From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/7] More nested declarator fixes
Date: Sat, 14 Feb 2009 12:25:25 +0000
Message-ID: <E1LYJaH-0001nA-Kl@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37433 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbZBNMZ0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 14 Feb 2009 07:25:26 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LYJaH-0001nA-Kl
	for linux-sparse@vger.kernel.org; Sat, 14 Feb 2009 12:25:25 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


no nested declarators after [...] or (parameters)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c                        |    2 ++
 validation/nested-declarator.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/parse.c b/parse.c
index 86e26aa..1678d80 100644
--- a/parse.c
+++ b/parse.c
@@ -1295,6 +1295,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			token = parameter_type_list(next, sym, p);
 			token = expect(token, ')', "in function declarator");
 			sym->endpos = token->pos;
+			dont_nest = 1;
 			continue;
 		}
 		if (token->special == '[') {
@@ -1303,6 +1304,7 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			token = expect(token, ']', "in abstract_array_declarator");
 			array->endpos = token->pos;
 			ctype = &array->ctype;
+			dont_nest = 1;
 			continue;
 		}
 		break;
diff --git a/validation/nested-declarator.c b/validation/nested-declarator.c
index 24ed833..1e69823 100644
--- a/validation/nested-declarator.c
+++ b/validation/nested-declarator.c
@@ -6,6 +6,22 @@ static void g(int x)
 	T = x;
 	f(T);
 }
+static void h(void)
+{
+	static int [2](T)[3];
+}
+static int [2](*p)[3];
+int i(void (void)(*f));
+int j(int [2](*));
 /*
  * check-name: nested declarator vs. parameters
+ * check-error-start:
+nested-declarator.c:11:22: warning: missing identifier in declaration
+nested-declarator.c:13:16: error: Expected ) in function declarator
+nested-declarator.c:13:16: error: got *
+nested-declarator.c:14:19: error: Expected ) in function declarator
+nested-declarator.c:14:19: error: got *
+nested-declarator.c:15:15: error: Expected ) in function declarator
+nested-declarator.c:15:15: error: got *
+ * check-error-end:
  */
-- 
1.5.6.6


