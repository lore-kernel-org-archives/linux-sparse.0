From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] cleanup kill_instruction()
Date: Thu, 17 Nov 2016 15:35:07 +0100
Message-ID: <20161117143507.3598-9-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33770 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933967AbcKQRKf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:10:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so23122885wmu.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:10:35 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes:
- factorize out the '->bb = NULL' and '|= REPEAT_CSE'.
- fall through the switch cases for ternary/bunary/unary ops.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/simplify.c b/simplify.c
index afbbb7b6..fc69def1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -188,12 +188,14 @@ void kill_instruction(struct instruction *insn)
 		return;
 
 	switch (insn->opcode) {
+	case OP_SEL:
+	case OP_RANGE:
+		kill_use(&insn->src3);
+		/* fall through */
+
 	case OP_BINARY ... OP_BINCMP_END:
-		insn->bb = NULL;
-		kill_use(&insn->src1);
 		kill_use(&insn->src2);
-		repeat_phase |= REPEAT_CSE;
-		return;
+		/* fall through */
 
 	case OP_CAST:
 	case OP_SCAST:
@@ -201,42 +203,34 @@ void kill_instruction(struct instruction *insn)
 	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
-		insn->bb = NULL;
 		kill_use(&insn->src1);
-		repeat_phase |= REPEAT_CSE;
-		return;
+		break;
 
 	case OP_PHI:
 		clear_phi(insn);
-		insn->bb = NULL;
-		repeat_phase |= REPEAT_CSE;
-		return;
+		break;
 
 	case OP_SYMADDR:
-		insn->bb = NULL;
-		repeat_phase |= REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
-		return;
+		repeat_phase |= REPEAT_SYMBOL_CLEANUP;
+		break;
 
-	case OP_SEL:
-	case OP_RANGE:
-		insn->bb = NULL;
-		repeat_phase |= REPEAT_CSE;
-		kill_use(&insn->src1);
-		kill_use(&insn->src2);
-		kill_use(&insn->src3);
-		return;
 	case OP_BR:
+		if (!insn->cond)
+			break;
+		/* fall through */
+
 	case OP_COMPUTEDGOTO:
-		insn->bb = NULL;
-		repeat_phase |= REPEAT_CSE;
-		if (insn->cond)
-			kill_use(&insn->cond);
-		return;
+		kill_use(&insn->cond);
+		break;
 
 	case OP_ENTRY:
 		/* ignore */
 		return;
 	}
+
+	insn->bb = NULL;
+	repeat_phase |= REPEAT_CSE;
+	return;
 }
 
 /*
-- 
2.10.2

