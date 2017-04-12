From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] generate plain OP_{AND,OR} instead of OP_{AND,OR}_BOOL
Date: Wed, 12 Apr 2017 21:33:42 +0200
Message-ID: <20170412193344.95935-5-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32827 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755113AbdDLTd5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so8546480wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:57 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that OP_AND_BOOL and OP_OR_BOOL are always given boolean
operands, they are just a special case of 1 bit OP_AND & OP_OR.

To avoid to have to repeat CSE, simplification patterns, ...
better to simply generate OP_AND & OP_OR instructions instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                        |  2 +-
 validation/optim/bool-context-fp.c |  8 ++++----
 validation/optim/bool-simplify.c   | 24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/linearize.c b/linearize.c
index e730ab56f..e6b77ec01 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1379,7 +1379,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 static pseudo_t linearize_binop_bool(struct entrypoint *ep, struct expression *expr)
 {
 	pseudo_t src1, src2, dst;
-	int op = (expr->op == SPECIAL_LOGICAL_OR) ? OP_OR_BOOL : OP_AND_BOOL;
+	int op = (expr->op == SPECIAL_LOGICAL_OR) ? OP_OR : OP_AND;
 
 	src1 = linearize_expression_to_bool(ep, expr->left);
 	src2 = linearize_expression_to_bool(ep, expr->right);
diff --git a/validation/optim/bool-context-fp.c b/validation/optim/bool-context-fp.c
index 2f15fe94d..3ce1574b9 100644
--- a/validation/optim/bool-context-fp.c
+++ b/validation/optim/bool-context-fp.c
@@ -53,7 +53,7 @@ bfior:
 	setfval.32  %r19 <- 0.000000
 	fcmpune.1   %r20 <- %arg1, %r19
 	fcmpune.1   %r23 <- %arg2, %r19
-	or-bool.1   %r24 <- %r23, %r20
+	or.1        %r24 <- %r23, %r20
 	ret.1       %r24
 
 
@@ -63,7 +63,7 @@ ifior:
 	setfval.32  %r29 <- 0.000000
 	fcmpune.1   %r30 <- %arg1, %r29
 	fcmpune.1   %r33 <- %arg2, %r29
-	or-bool.1   %r34 <- %r33, %r30
+	or.1        %r34 <- %r33, %r30
 	cast.32     %r35 <- (1) %r34
 	ret.32      %r35
 
@@ -74,7 +74,7 @@ bfand:
 	setfval.32  %r38 <- 0.000000
 	fcmpune.1   %r39 <- %arg1, %r38
 	fcmpune.1   %r42 <- %arg2, %r38
-	and-bool.1  %r43 <- %r42, %r39
+	and.1       %r43 <- %r42, %r39
 	ret.1       %r43
 
 
@@ -84,7 +84,7 @@ ifand:
 	setfval.32  %r48 <- 0.000000
 	fcmpune.1   %r49 <- %arg1, %r48
 	fcmpune.1   %r52 <- %arg2, %r48
-	and-bool.1  %r53 <- %r52, %r49
+	and.1       %r53 <- %r52, %r49
 	cast.32     %r54 <- (1) %r53
 	ret.32      %r54
 
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
index 2014d344c..b872764ca 100644
--- a/validation/optim/bool-simplify.c
+++ b/validation/optim/bool-simplify.c
@@ -18,6 +18,17 @@ int or_1(int a)
 	return a || 1;
 }
 
+// try again but with something true but != 1
+int and_2(int a)
+{
+	return a && 2;
+}
+
+int or_2(int a)
+{
+	return a || 2;
+}
+
 /*
  * check-name: bool-simplify
  * check-command: test-linearize -Wno-decl $file
@@ -49,5 +60,18 @@ or_1:
 	ret.32      $1
 
 
+and_2:
+.L8:
+	<entry-point>
+	setne.32    %r29 <- %arg1, $0
+	ret.32      %r29
+
+
+or_2:
+.L10:
+	<entry-point>
+	ret.32      $1
+
+
  * check-output-end
  */
-- 
2.12.0

