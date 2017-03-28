From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/4] fix linearize_inc_dec() with floats
Date: Tue, 28 Mar 2017 16:18:26 +0200
Message-ID: <20170328141829.21421-2-luc.vanoostenryck@gmail.com>
References: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36450 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdC1O1j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:27:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so11500wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:27:28 -0700 (PDT)
In-Reply-To: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Using the pre or post increment or decrement operator on
floating-point values mix the addition of a floating-point
value with an *integral* constant 1 or -1.

Fix this by checking if we're dealing with fp or not and using
the proper fp constants (1.0 or -1.0) if it is the case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                | 18 ++++++++++++++++--
 validation/inc-dec-float.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 validation/inc-dec-float.c

diff --git a/linearize.c b/linearize.c
index 209bd2bf3..ed649a86a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -991,6 +991,18 @@ static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct e
 	return target;
 }
 
+static pseudo_t add_setfval(struct entrypoint *ep, struct symbol *ctype, long double fval)
+{
+	struct instruction *insn = alloc_typed_instruction(OP_SETVAL, ctype);
+	struct expression *expr = alloc_expression(insn->pos, EXPR_FVALUE);
+	pseudo_t target = alloc_pseudo(insn);
+	insn->target = target;
+	insn->val = expr;
+	expr->fvalue = fval;
+	add_one_insn(ep, insn);
+	return target;
+}
+
 static pseudo_t add_symbol_address(struct entrypoint *ep, struct symbol *sym)
 {
 	struct instruction *insn = alloc_instruction(OP_SYMADDR, bits_in_pointer);
@@ -1028,7 +1040,6 @@ static pseudo_t linearize_access(struct entrypoint *ep, struct expression *expr)
 	return value;
 }
 
-/* FIXME: FP */
 static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr, int postop)
 {
 	struct access_data ad = { NULL, };
@@ -1039,7 +1050,10 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 		return VOID;
 
 	old = linearize_load_gen(ep, &ad);
-	one = value_pseudo(expr->op_value);
+	if (is_float_type(expr->ctype))
+		one = add_setfval(ep, expr->ctype, expr->op_value);
+	else
+		one = value_pseudo(expr->op_value);
 	new = add_binary_op(ep, expr->ctype, op, old, one);
 	linearize_store_gen(ep, new, &ad);
 	finish_address_gen(ep, &ad);
diff --git a/validation/inc-dec-float.c b/validation/inc-dec-float.c
new file mode 100644
index 000000000..3cac8f3ee
--- /dev/null
+++ b/validation/inc-dec-float.c
@@ -0,0 +1,13 @@
+double fincpre(double a)  { ++a; return a; }
+double fdecpre(double a)  { --a; return a; }
+double fincpost(double a) { a++; return a; }
+double fdecpost(double a) { a--; return a; }
+
+/*
+ * check-name: float inc & dec
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: \\$1$
+ * check-output-excludes: \\$-1$
+ */
-- 
2.12.0

