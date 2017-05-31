From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] div0: warn on division by zero - general case
Date: Wed, 31 May 2017 05:22:02 +0200
Message-ID: <20170531032207.95830-5-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36520 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdEaDWV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id n104so301227wrb.3
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:20 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse warn about division by zero but only in plain
expression: no checks are done when the division is
part of a compound assignement.

Change this by adding the appropriate check and warning
during linearization and take care to avoid warning twice.

Note: if should be simpler to drop the checks done at
      expansion time but some expressions are discarded
      before reaching linearization and we want to check
      and warn for those too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c              | 19 +++++++++++++++++++
 validation/div-by-zero.c | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/linearize.c b/linearize.c
index 7313e72d8..7760ea996 100644
--- a/linearize.c
+++ b/linearize.c
@@ -959,6 +959,23 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 	return value;
 }
 
+static void warn_undef_insn(struct instruction *insn, int warn)
+{
+	switch (insn->opcode) {
+	case OP_DIVU:
+	case OP_DIVS:
+	case OP_MODU:
+	case OP_MODS:
+		if (is_pseudo_value(insn->src2, 0)) {
+			if (warn)
+				warning(insn->pos, "division by zero");
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 static pseudo_t add_binary_op(struct entrypoint *ep, struct symbol *ctype, int op, pseudo_t left, pseudo_t right)
 {
 	struct instruction *insn = alloc_typed_instruction(op, ctype);
@@ -1208,6 +1225,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		oldvalue = cast_pseudo(ep, oldvalue, target->ctype, ctype);
 		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], ctype);
 		dst = add_binary_op(ep, ctype, opcode, oldvalue, value);
+		warn_undef_insn(dst->def, 1);
 		value = cast_pseudo(ep, dst, ctype, expr->ctype);
 	}
 	value = linearize_store_gen(ep, value, &ad);
@@ -1323,6 +1341,7 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 	src2 = linearize_expression(ep, expr->right);
 	op = opcode_sign(opcode[expr->op], expr->ctype);
 	dst = add_binary_op(ep, expr->ctype, op, src1, src2);
+	warn_undef_insn(dst->def, 0);
 	return dst;
 }
 
diff --git a/validation/div-by-zero.c b/validation/div-by-zero.c
index 786e48298..a06944a58 100644
--- a/validation/div-by-zero.c
+++ b/validation/div-by-zero.c
@@ -18,6 +18,14 @@ int isvmod(int a) { return a % (int) 0; }
 int lsvmod(int a) { return a % (long) 0; }
 int usvmod(int a) { return a % (unsigned int) 0; }
 
+int xsvdiv(int a) { if (a && 0) return a / 0; return 0; }
+int asvdiv(int a) { return a /= 0; }
+int osvdiv(int a) { return a / (a && 0); }
+
+int xsvmod(int a) { if (a && 0) return a % 0; return 0; }
+int asvmod(int a) { return a %= 0; }
+int osvmod(int a) { return a % (a && 0); }
+
 /*
  * check-name: div-by-zero.c
  * check-command: sparse -Wno-decl $file
@@ -39,5 +47,9 @@ div-by-zero.c:16:30: warning: division by zero
 div-by-zero.c:17:30: warning: division by zero
 div-by-zero.c:18:30: warning: division by zero
 div-by-zero.c:19:30: warning: division by zero
+div-by-zero.c:21:42: warning: division by zero
+div-by-zero.c:22:33: warning: division by zero
+div-by-zero.c:25:42: warning: division by zero
+div-by-zero.c:26:33: warning: division by zero
  * check-error-end
  */
-- 
2.13.0

