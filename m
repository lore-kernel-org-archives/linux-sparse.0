From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 7/8] div0: warn also during simplification
Date: Sat,  3 Jun 2017 10:01:34 +0200
Message-ID: <20170603080135.46477-8-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34812 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFCIBu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so22056614wmf.1
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:49 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse now warn about divion by zero during linearization
but during simplification some expression can become constants
and so some new divisions by zero can appears.

Warn also on those new and to avoid to warn also here on the old
ones, mark the instructions for wich we have already be warned.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c              | 17 +++++++++++++++++
 simplify.c               | 12 ++++++++++++
 validation/div-by-zero.c |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/linearize.c b/linearize.c
index 7313e72d8..1d21ea105 100644
--- a/linearize.c
+++ b/linearize.c
@@ -959,6 +959,21 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 	return value;
 }
 
+static void warn_undef_insn(struct instruction *insn)
+{
+	switch (insn->opcode) {
+	case OP_DIVU:
+	case OP_DIVS:
+	case OP_MODU:
+	case OP_MODS:
+		if (is_pseudo_value(insn->src2, 0))
+			insn->warned = 1;
+		break;
+	default:
+		break;
+	}
+}
+
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right)
 {
 	struct instruction *insn = alloc_typed_instruction(op, ctype);
@@ -1208,6 +1223,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		oldvalue = cast_pseudo(ep, oldvalue, target->ctype, ctype);
 		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], ctype);
 		dst = add_binary_op(ep, ctype, opcode, oldvalue, value);
+		warn_undef_insn(dst->def);
 		value = cast_pseudo(ep, dst, ctype, expr->ctype);
 	}
 	value = linearize_store_gen(ep, value, &ad);
@@ -1323,6 +1339,7 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 	src2 = linearize_expression(ep, expr->right);
 	op = opcode_sign(opcode[expr->op], expr->ctype);
 	dst = add_binary_op(ep, expr->ctype, op, src1, src2);
+	warn_undef_insn(dst->def);
 	return dst;
 }
 
diff --git a/simplify.c b/simplify.c
index a141ddd43..40e1c253b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -404,6 +404,15 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 	return 0;
 }
 
+static void check_divide_by_zero(struct instruction *insn, long long value)
+{
+	if (value != 0 || insn->warned)
+		return;
+	if (Wdiv_by_zero)
+		warning(insn->pos, "division by zero");
+	insn->warned = 1;
+}
+
 static int simplify_mul_div(struct instruction *insn, long long value)
 {
 	unsigned long long sbit = 1ULL << (insn->size - 1);
@@ -525,9 +534,12 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_MODU: case OP_MODS:
 		if (value == 1)
 			return replace_with_pseudo(insn, value_pseudo(0));
+		check_divide_by_zero(insn, value);
 		return 0;
 
 	case OP_DIVU: case OP_DIVS:
+		check_divide_by_zero(insn, value);
+		/* Fall through */
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
 
diff --git a/validation/div-by-zero.c b/validation/div-by-zero.c
index bd8d0dfdf..b7c4770e6 100644
--- a/validation/div-by-zero.c
+++ b/validation/div-by-zero.c
@@ -60,8 +60,10 @@ div-by-zero.c:18:30: warning: division by zero
 div-by-zero.c:19:30: warning: division by zero
 div-by-zero.c:21:42: warning: division by zero
 div-by-zero.c:22:30: warning: division by zero
+div-by-zero.c:23:38: warning: division by zero
 div-by-zero.c:25:42: warning: division by zero
 div-by-zero.c:26:30: warning: division by zero
+div-by-zero.c:27:38: warning: division by zero
 div-by-zero.c:29:42: warning: division by zero
 div-by-zero.c:30:42: warning: division by zero
 div-by-zero.c:35:37: warning: division by zero
-- 
2.13.0

