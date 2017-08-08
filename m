From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 7/8] transform (A << S) >> S into A & (-1 >> S)
Date: Wed,  9 Aug 2017 01:06:33 +0200
Message-ID: <20170808230634.16227-8-luc.vanoostenryck@gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33794 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752475AbdHHXHB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:07:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id x64so4929617wmg.1
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:07:00 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index f1a898700..23cdd19ae 100644
--- a/simplify.c
+++ b/simplify.c
@@ -416,6 +416,8 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
 {
 	struct instruction *def;
 	unsigned long long mask;
+	unsigned int width;
+	pseudo_t old;
 
 	if (!value)
 		return replace_with_pseudo(insn, pseudo);
@@ -434,6 +436,21 @@ static int simplify_lsr(struct instruction *insn, pseudo_t pseudo, long long val
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
2.13.2

