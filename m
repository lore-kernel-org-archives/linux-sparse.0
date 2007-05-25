From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] better recovery from bad operations on bitwise
Date: Fri, 25 May 2007 04:57:54 +0100
Message-ID: <E1HrQw6-000194-JQ@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58097 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbXEYD5z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQw6-000194-JQ
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:54 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


degrade to integer type, generate a warning and move on...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e44426b..80ac7d1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -582,16 +582,32 @@ static int ptr_object_size(struct symbol *ptr_type)
 	return ptr_type->bit_size;
 }
 
+static inline int want_int(struct expression **expr, struct symbol **ctype)
+{
+	int class = classify_type((*expr)->ctype, ctype);
+
+	if (!(class & TYPE_NUM))
+		return 0;
+	if (!(class & TYPE_RESTRICT))
+		return 1;
+	warning((*expr)->pos, "restricted degrades to integer");
+	if (class & TYPE_FOULED)	/* unfoul it first */
+		(*ctype) = (*ctype)->ctype.base_type;
+	(*ctype) = (*ctype)->ctype.base_type;	/* get to arithmetic type */
+	*expr = cast_to(*expr, *ctype);
+	return 1;
+}
+
 static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *ctype, struct expression **ip)
 {
 	struct expression *i = *ip;
-	struct symbol *ptr_type = ctype;
+	struct symbol *ptr_type = ctype, *itype;
 	int bit_size;
 
 	if (ptr_type->type == SYM_NODE)
 		ptr_type = ptr_type->ctype.base_type;
 
-	if (!is_int_type(i->ctype))
+	if (!want_int(&i, &itype))
 		return bad_expr_type(expr);
 
 	examine_symbol_type(ctype);
@@ -943,14 +959,9 @@ static struct symbol *evaluate_logical(struct expression *expr)
 
 static struct symbol *evaluate_shift(struct expression *expr)
 {
-	struct expression *left = expr->left, *right = expr->right;
-	struct symbol *ltype = left->ctype, *rtype = right->ctype;
+	struct symbol *ltype, *rtype;
 
-	if (ltype->type == SYM_NODE)
-		ltype = ltype->ctype.base_type;
-	if (rtype->type == SYM_NODE)
-		rtype = rtype->ctype.base_type;
-	if (is_int_type(ltype) && is_int_type(rtype)) {
+	if (want_int(&expr->left, &ltype) && want_int(&expr->right, &rtype)) {
 		struct symbol *ctype = integer_promotion(ltype);
 		expr->left = cast_to(expr->left, ctype);
 		expr->ctype = ctype;
-- 
1.5.0-rc2.GIT
