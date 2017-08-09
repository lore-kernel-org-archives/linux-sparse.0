From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 7/9] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Wed,  9 Aug 2017 21:38:04 +0200
Message-ID: <20170809193806.30975-8-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33418 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHITjH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:39:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id q189so631246wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:39:06 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is especially usefull when simplifying code
accessing bitfields.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                 | 29 ++++++++++++++++++++++++++++-
 validation/bitfield-size.c |  4 +---
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index 40d4f0068..e8bf1c171 100644
--- a/simplify.c
+++ b/simplify.c
@@ -411,6 +411,32 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 	return 0;
 }
 
+static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long value)
+{
+	struct instruction *def;
+	unsigned long long mask;
+
+	if (!value)
+		return replace_with_pseudo(insn, pseudo);
+	switch (def_opcode(insn->src1)) {
+	case OP_AND:
+		// replace (A & M) >> S
+		// by      (A >> S) & (M >> S)
+		def = insn->src1->def;
+		if (!constant(def->src2))
+			break;
+		if (nbr_pseudo_users(insn->src1) > 1)
+			break;
+		mask = def->src2->value;
+		def->opcode = OP_LSR;
+		def->src2 = value_pseudo(value);
+		insn->opcode = OP_AND;
+		insn->src2 = value_pseudo(mask >> value);
+		return REPEAT_CSE;
+	}
+	return 0;
+}
+
 static int simplify_mul_div(struct instruction *insn, long long value)
 {
 	unsigned long long sbit = 1ULL << (insn->size - 1);
@@ -561,13 +587,14 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_ADD:
 	case OP_OR: case OP_XOR:
 	case OP_SHL:
-	case OP_LSR:
 	case_neutral_zero:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
 		return 0;
 	case OP_ASR:
 		return simplify_asr(insn, insn->src1, value);
+	case OP_LSR:
+		return simplify_lsr(insn, insn->src1, value);
 
 	case OP_MODU: case OP_MODS:
 		if (value == 1)
diff --git a/validation/bitfield-size.c b/validation/bitfield-size.c
index c8c94bb15..34400479a 100644
--- a/validation/bitfield-size.c
+++ b/validation/bitfield-size.c
@@ -36,8 +36,6 @@ unsigned int get_pbfi_b(struct bfi *bf) { return bf->b; }
  * check-output-ignore
  *
  * check-output-excludes: cast\\.4
- * check-output-pattern-6-times: cast\\.
  * check-output-pattern-6-times: lsr\\..*\\$6
- * check-output-pattern-6-times: and\\..*\\$15
- * check-output-pattern-6-times: and\\..*\\$960
+ * check-output-pattern-12-times: and\\..*\\$15
  */
-- 
2.14.0

