From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH] parse: support c99 [static ...] in abstract array declarators
Date: Tue, 15 Apr 2014 16:08:57 -0700
Message-ID: <1397603337-28016-1-git-send-email-cody@linux.vnet.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:55855 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217AbaDOXJF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 19:09:05 -0400
Received: from /spool/local
	by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Tue, 15 Apr 2014 19:09:04 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0EAE86E801F
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 19:08:55 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3FN910K1769764
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 23:09:01 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3FN90A5023426
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 19:09:01 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>

Makes sparse a little more accepting than the standard: we accept any
number of ["static", "restrict"] repeated in any order, while the n1570
specifies (in 6.7.6.2.3) that either type-qualifiers (ie: "restrict")
come first and are followed by "static" or the opposite ("static" then
type-qualifiers).

Also add a test.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 ident-list.h                                  | 1 +
 parse.c                                       | 2 +-
 validation/abstract-array-declarator-static.c | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 validation/abstract-array-declarator-static.c

diff --git a/ident-list.h b/ident-list.h
index e93aae7..c0fc18f 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -91,6 +91,7 @@ IDENT(artificial); IDENT(__artificial__);
 IDENT(leaf); IDENT(__leaf__);
 IDENT(vector_size); IDENT(__vector_size__);
 IDENT(error); IDENT(__error__);
+IDENT(static);
 
 
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the keyword
diff --git a/parse.c b/parse.c
index 9cc5f65..cbe3af4 100644
--- a/parse.c
+++ b/parse.c
@@ -1532,7 +1532,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 {
 	struct expression *expr = NULL;
 
-	if (match_idents(token, &restrict_ident, &__restrict_ident, NULL))
+	while (match_idents(token, &restrict_ident, &__restrict_ident, &static_ident, NULL))
 		token = token->next;
 	token = parse_expression(token, &expr);
 	sym->array_size = expr;
diff --git a/validation/abstract-array-declarator-static.c b/validation/abstract-array-declarator-static.c
new file mode 100644
index 0000000..23cbae0
--- /dev/null
+++ b/validation/abstract-array-declarator-static.c
@@ -0,0 +1,6 @@
+
+extern void f(int g[static 1]);
+
+/*
+ * check-name: abstract array declarator static
+ */
-- 
1.9.2

