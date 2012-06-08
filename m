From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix casts when linearizing compound assignments
Date: Fri,  8 Jun 2012 06:47:40 -0400
Message-ID: <1339152460-17411-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39212 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2FHKry (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 06:47:54 -0400
Received: by qcro28 with SMTP id o28so767918qcr.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 03:47:53 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

linearize_assignment() emits confusing casts for compound assignments.
Consider p += 1, where p is a pointer.

	oldvalue = cast_pseudo(ep, oldvalue, src->ctype, expr->ctype);
	opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], src->ctype);
	dst = add_binary_op(ep, src->ctype, opcode, oldvalue, value);
	value = cast_pseudo(ep, dst, expr->ctype, src->ctype);

It would make more sense to swap src->ctype and expr->ctype in both
cast_pseudo(ep, pseudo, from, to) calls:

In the first call, `oldvalue' is a pointer (expr->ctype), but it is
converted from an integer (src->ctype) to a pointer (expr->ctype);

In the second call, `dst' is an integer (src->ctype), but it is
converted from a pointer (expr->ctype) to an integer (src->ctype).

This patch instead converts `value' from an integer (src->ctype) to a
pointer (expr->ctype) so as to emit fewer casts.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 linearize.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/linearize.c b/linearize.c
index 1d15cfd..d186387 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1161,7 +1161,6 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		return value;
 	if (expr->op != '=') {
 		pseudo_t oldvalue = linearize_load_gen(ep, &ad);
-		pseudo_t dst;
 		static const int op_trans[] = {
 			[SPECIAL_ADD_ASSIGN - SPECIAL_BASE] = OP_ADD,
 			[SPECIAL_SUB_ASSIGN - SPECIAL_BASE] = OP_SUB,
@@ -1179,10 +1178,9 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		if (!src)
 			return VOID;
 
-		oldvalue = cast_pseudo(ep, oldvalue, src->ctype, expr->ctype);
-		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], src->ctype);
-		dst = add_binary_op(ep, src->ctype, opcode, oldvalue, value);
-		value = cast_pseudo(ep, dst, expr->ctype, src->ctype);
+		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], expr->ctype);
+		value = cast_pseudo(ep, value, src->ctype, expr->ctype);
+		value = add_binary_op(ep, expr->ctype, opcode, oldvalue, value);
 	}
 	value = linearize_store_gen(ep, value, &ad);
 	finish_address_gen(ep, &ad);
-- 
1.7.9.5

