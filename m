From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] simplify ((A & M') | B ) & M when M' & M == 0
Date: Mon,  7 Aug 2017 03:33:38 +0200
Message-ID: <20170807013338.46211-4-luc.vanoostenryck@gmail.com>
References: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33217 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGBdv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 21:33:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id q189so12145653wmd.0
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 18:33:50 -0700 (PDT)
In-Reply-To: <20170807013338.46211-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index cfb6b2cda..3fb2c8d8f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -532,6 +532,46 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	}
 }
 
+static int simplify_and_or_mask(struct instruction *insn, pseudo_t and, pseudo_t other, unsigned long long mask)
+{
+	struct instruction *def = and->def;
+	pseudo_t old;
+
+	if (!constant(def->src2))
+		return 0;
+	if (def->src2->value & mask)
+		return 0;
+	old = insn->src1;
+	use_pseudo(insn, other, &insn->src1);
+	remove_usage(old, &insn->src1);
+	return REPEAT_CSE;
+}
+
+static int simplify_constant_mask(struct instruction *insn, unsigned long long mask)
+{
+	struct instruction *left;
+	pseudo_t src1, src2;
+
+	switch (def_opcode(insn->src1)) {
+	case OP_OR:
+		// Let's handle ((A & M') | B ) & M
+		// or           (B | (A & M')) & M
+		// when M' & M == 0
+		left = insn->src1->def;
+		src1 = left->src1;
+		src2 = left->src2;
+		if (def_opcode(src1) == OP_AND)
+			return simplify_and_or_mask(insn, src1, src2, mask);
+		if (def_opcode(src2) == OP_AND)
+			return simplify_and_or_mask(insn, src2, src1, mask);
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -576,7 +616,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_AND:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src2);
-		return 0;
+		return simplify_constant_mask(insn, value);
 
 	case OP_SET_NE:
 	case OP_SET_EQ:
-- 
2.13.2

