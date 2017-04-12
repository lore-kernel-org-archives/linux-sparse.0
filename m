From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] simplify 'x ^ ~0' to '~x'
Date: Wed, 12 Apr 2017 16:18:01 +0200
Message-ID: <20170412141802.81231-3-luc.vanoostenryck@gmail.com>
References: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33545 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753244AbdDLOUS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 10:20:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so6736414wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 07:20:12 -0700 (PDT)
In-Reply-To: <20170412141802.81231-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 8 +++++++-
 validation/optim/bool-not-zero.c | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index e4ccb6c5f..775c1e2dd 100644
--- a/simplify.c
+++ b/simplify.c
@@ -467,6 +467,13 @@ static int simplify_constant_rightside(struct instruction *insn)
 			return replace_with_pseudo(insn, insn->src2);
 		goto case_neutral_zero;
 
+	case OP_XOR:
+		if ((value & bits) == bits) {
+			insn->opcode = OP_NOT;
+			return REPEAT_CSE;
+		}
+		goto case_neutral_zero;
+
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
@@ -475,7 +482,6 @@ static int simplify_constant_rightside(struct instruction *insn)
 		}
 	/* Fall through */
 	case OP_ADD:
-	case OP_XOR:
 	case OP_SHL:
 	case OP_LSR:
 	case_neutral_zero:
diff --git a/validation/optim/bool-not-zero.c b/validation/optim/bool-not-zero.c
index ce74705e8..189fe3311 100644
--- a/validation/optim/bool-not-zero.c
+++ b/validation/optim/bool-not-zero.c
@@ -1,5 +1,6 @@
 int  or_not0(int a) { return a | ~0; }
 int and_not0(int a) { return a & ~0; }
+int xor_not0(int a) { return a ^ ~0; }
 
 /*
  * check-name: bool-not-zero
@@ -18,5 +19,12 @@ and_not0:
 	ret.32      %arg1
 
 
+xor_not0:
+.L4:
+	<entry-point>
+	not.32      %r8 <- %arg1
+	ret.32      %r8
+
+
  * check-output-end
  */
-- 
2.12.0

