From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] extract extract eval_insn() from simplify_constant_binop()
Date: Mon,  5 Feb 2018 23:34:38 +0100
Message-ID: <20180205223438.24060-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42897 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeBEWer (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Feb 2018 17:34:47 -0500
Received: by mail-wr0-f194.google.com with SMTP id 41so29888301wrc.9
        for <linux-sparse@vger.kernel.org>; Mon, 05 Feb 2018 14:34:47 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For some optimizations, t's interesting to be able to do
directly the evaluation of constant operations and not to
have to wait a cyle of optimization or to have to allocate
an new instruction.

So, extract extract the part dealing exclusively with
the evalution into a separate function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 241 ++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 128 insertions(+), 113 deletions(-)

diff --git a/simplify.c b/simplify.c
index 4c48559e4..087b35222 100644
--- a/simplify.c
+++ b/simplify.c
@@ -392,6 +392,131 @@ static unsigned int operand_size(struct instruction *insn, pseudo_t pseudo)
 	return size;
 }
 
+static pseudo_t eval_insn(struct instruction *insn)
+{
+	/* FIXME! Verify signs and sizes!! */
+	unsigned int size = insn->size;
+	long long left = insn->src1->value;
+	long long right = insn->src2->value;
+	unsigned long long ul, ur;
+	long long res, mask, bits;
+
+	mask = 1ULL << (size-1);
+	bits = mask | (mask-1);
+
+	if (left & mask)
+		left |= ~bits;
+	if (right & mask)
+		right |= ~bits;
+	ul = left & bits;
+	ur = right & bits;
+
+	switch (insn->opcode) {
+	case OP_ADD:
+		res = left + right;
+		break;
+	case OP_SUB:
+		res = left - right;
+		break;
+	case OP_MULU:
+		res = ul * ur;
+		break;
+	case OP_MULS:
+		res = left * right;
+		break;
+	case OP_DIVU:
+		if (!ur)
+			goto undef;
+		res = ul / ur;
+		break;
+	case OP_DIVS:
+		if (!right)
+			goto undef;
+		if (left == mask && right == -1)
+			goto undef;
+		res = left / right;
+		break;
+	case OP_MODU:
+		if (!ur)
+			goto undef;
+		res = ul % ur;
+		break;
+	case OP_MODS:
+		if (!right)
+			goto undef;
+		if (left == mask && right == -1)
+			goto undef;
+		res = left % right;
+		break;
+	case OP_SHL:
+		res = left << right;
+		break;
+	case OP_LSR:
+		res = ul >> ur;
+		break;
+	case OP_ASR:
+		res = left >> right;
+		break;
+       /* Logical */
+	case OP_AND:
+		res = left & right;
+		break;
+	case OP_OR:
+		res = left | right;
+		break;
+	case OP_XOR:
+		res = left ^ right;
+		break;
+	case OP_AND_BOOL:
+		res = left && right;
+		break;
+	case OP_OR_BOOL:
+		res = left || right;
+		break;
+
+	/* Binary comparison */
+	case OP_SET_EQ:
+		res = left == right;
+		break;
+	case OP_SET_NE:
+		res = left != right;
+		break;
+	case OP_SET_LE:
+		res = left <= right;
+		break;
+	case OP_SET_GE:
+		res = left >= right;
+		break;
+	case OP_SET_LT:
+		res = left < right;
+		break;
+	case OP_SET_GT:
+		res = left > right;
+		break;
+	case OP_SET_B:
+		res = ul < ur;
+		break;
+	case OP_SET_A:
+		res = ul > ur;
+		break;
+	case OP_SET_BE:
+		res = ul <= ur;
+		break;
+	case OP_SET_AE:
+		res = ul >= ur;
+		break;
+	default:
+		return NULL;
+	}
+	res &= bits;
+
+	return value_pseudo(res);
+
+undef:
+	return NULL;
+}
+
+
 static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long value)
 {
 	unsigned int size = operand_size(insn, pseudo);
@@ -547,122 +672,12 @@ static int simplify_constant_leftside(struct instruction *insn)
 
 static int simplify_constant_binop(struct instruction *insn)
 {
-	/* FIXME! Verify signs and sizes!! */
-	long long left = insn->src1->value;
-	long long right = insn->src2->value;
-	unsigned long long ul, ur;
-	long long res, mask, bits;
-
-	mask = 1ULL << (insn->size-1);
-	bits = mask | (mask-1);
-
-	if (left & mask)
-		left |= ~bits;
-	if (right & mask)
-		right |= ~bits;
-	ul = left & bits;
-	ur = right & bits;
+	pseudo_t res = eval_insn(insn);
 
-	switch (insn->opcode) {
-	case OP_ADD:
-		res = left + right;
-		break;
-	case OP_SUB:
-		res = left - right;
-		break;
-	case OP_MULU:
-		res = ul * ur;
-		break;
-	case OP_MULS:
-		res = left * right;
-		break;
-	case OP_DIVU:
-		if (!ur)
-			return 0;
-		res = ul / ur;
-		break;
-	case OP_DIVS:
-		if (!right)
-			return 0;
-		if (left == mask && right == -1)
-			return 0;
-		res = left / right;
-		break;
-	case OP_MODU:
-		if (!ur)
-			return 0;
-		res = ul % ur;
-		break;
-	case OP_MODS:
-		if (!right)
-			return 0;
-		if (left == mask && right == -1)
-			return 0;
-		res = left % right;
-		break;
-	case OP_SHL:
-		res = left << right;
-		break;
-	case OP_LSR:
-		res = ul >> ur;
-		break;
-	case OP_ASR:
-		res = left >> right;
-		break;
-       /* Logical */
-	case OP_AND:
-		res = left & right;
-		break;
-	case OP_OR:
-		res = left | right;
-		break;
-	case OP_XOR:
-		res = left ^ right;
-		break;
-	case OP_AND_BOOL:
-		res = left && right;
-		break;
-	case OP_OR_BOOL:
-		res = left || right;
-		break;
-			       
-	/* Binary comparison */
-	case OP_SET_EQ:
-		res = left == right;
-		break;
-	case OP_SET_NE:
-		res = left != right;
-		break;
-	case OP_SET_LE:
-		res = left <= right;
-		break;
-	case OP_SET_GE:
-		res = left >= right;
-		break;
-	case OP_SET_LT:
-		res = left < right;
-		break;
-	case OP_SET_GT:
-		res = left > right;
-		break;
-	case OP_SET_B:
-		res = ul < ur;
-		break;
-	case OP_SET_A:
-		res = ul > ur;
-		break;
-	case OP_SET_BE:
-		res = ul <= ur;
-		break;
-	case OP_SET_AE:
-		res = ul >= ur;
-		break;
-	default:
+	if (!res)
 		return 0;
-	}
-	res &= bits;
 
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_pseudo(insn, res);
 	return REPEAT_CSE;
 }
 
-- 
2.16.0

