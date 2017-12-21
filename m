From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] avoid unneeded alloc on error path
Date: Thu, 21 Dec 2017 01:19:14 +0100
Message-ID: <20171221001915.57047-3-luc.vanoostenryck@gmail.com>
References: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39722 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755846AbdLUAV0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:21:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so12805175wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:21:25 -0800 (PST)
In-Reply-To: <20171221001915.57047-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In evaluate_dereference(), a node is allocated but
is not used if there is an error.

Fix this by allocating the node after the error checks.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 6b3e2c257..e6dbe3d8d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1776,7 +1776,6 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 	if (ctype->type == SYM_NODE)
 		ctype = ctype->ctype.base_type;
 
-	node = alloc_symbol(expr->pos, SYM_NODE);
 	target = ctype->ctype.base_type;
 
 	switch (ctype->type) {
@@ -1784,6 +1783,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 		expression_error(expr, "cannot dereference this type");
 		return NULL;
 	case SYM_PTR:
+		node = alloc_symbol(expr->pos, SYM_NODE);
 		node->ctype.modifiers = target->ctype.modifiers & MOD_SPECIFIER;
 		merge_type(node, ctype);
 		break;
@@ -1801,6 +1801,7 @@ static struct symbol *evaluate_dereference(struct expression *expr)
 		 * When an array is dereferenced, we need to pick
 		 * up the attributes of the original node too..
 		 */
+		node = alloc_symbol(expr->pos, SYM_NODE);
 		merge_type(node, op->ctype);
 		merge_type(node, ctype);
 		break;
-- 
2.15.0

