From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 6/8] fix the sanity check in evaluate_ptr_sub()
Date: Fri, 13 Jul 2007 18:45:17 +0100
Message-ID: <E1I9PCf-0000F5-5e@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49741 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbXGMRpR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:45:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PCf-0000F5-5e
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:45:17 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


We are checking the wrong thing - the arguments have already
degenerated, so we won't see SYM_FN there (or SYM_ARRAY, for
that matter).  That check should be done to the target of
pointer, not to the pointer itself and it should simply check
for SYM_FN - that's what we'll get there both from decayed
functions _and_ pointers to functions.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 44a4da4..8df2042 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -785,24 +785,25 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 	struct symbol *ltype, *rtype;
 	struct expression *l = expr->left;
 	struct expression *r = expr->right;
+	struct symbol *lbase, *rbase;
 
-	ltype = degenerate(l);
-	rtype = degenerate(r);
+	classify_type(degenerate(l), &ltype);
+	classify_type(degenerate(r), &rtype);
 
-	ctype = ltype;
+	lbase = get_base_type(ltype);
+	rbase = get_base_type(rtype);
 	typediff = type_difference(ltype, rtype, ~MOD_SIZE, ~MOD_SIZE);
 	if (typediff)
 		expression_error(expr, "subtraction of different types can't work (%s)", typediff);
-	examine_symbol_type(ctype);
 
+	ctype = lbase;
 	/* Figure out the base type we point to */
 	if (ctype->type == SYM_NODE)
 		ctype = ctype->ctype.base_type;
-	if (ctype->type != SYM_PTR && ctype->type != SYM_ARRAY) {
+	if (ctype->type == SYM_FN) {
 		expression_error(expr, "subtraction of functions? Share your drugs");
 		return NULL;
 	}
-	ctype = get_base_type(ctype);
 
 	expr->ctype = ssize_t_ctype;
 	if (ctype->bit_size > bits_in_char) {
-- 
1.5.0-rc2.GIT
