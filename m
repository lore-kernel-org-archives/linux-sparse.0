From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 8/9] transform (A << S) >> S into A & (-1 >> S)
Date: Wed,  9 Aug 2017 21:38:05 +0200
Message-ID: <20170809193806.30975-9-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33422 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751932AbdHITjI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:39:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id q189so631296wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:39:07 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

More exactly, transform it into:
	A & (Mask(size) >> S)
which is equivalent to:
	A & Mask(size - S)
where Mask(X) is ((1 << X) - 1)

This transformation is especially usefull when simplifying code
accessing bitfields or for other masking manipulations.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/simplify.c b/simplify.c
index e8bf1c171..370d4cb81 100644
--- a/simplify.c
+++ b/simplify.c
@@ -415,6 +415,8 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
 {
 	struct instruction *def;
 	unsigned long long mask;
+	unsigned int width;
+	pseudo_t old;
 
 	if (!value)
 		return replace_with_pseudo(insn, pseudo);
@@ -433,6 +435,21 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
 		insn->opcode = OP_AND;
 		insn->src2 = value_pseudo(mask >> value);
 		return REPEAT_CSE;
+	case OP_SHL:
+		// replace (A << S) >> S
+		// by      A & (Mask(size) >> S)
+		def = insn->src1->def;
+		if (!constant(def->src2))
+			break;
+		if (def->src2->value != value)
+			break;
+		width = insn->size - value;
+		insn->src2 = value_pseudo((1ULL << width) - 1);
+		insn->opcode = OP_AND;
+		old = insn->src1;
+		use_pseudo(insn, def->src1, &insn->src1);
+		remove_usage(old, &insn->src1);
+		return REPEAT_CSE;
 	}
 	return 0;
 }
-- 
2.14.0

