From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add OP_SETFVAL
Date: Wed, 12 Apr 2017 11:29:26 +0200
Message-ID: <20170412092927.23884-2-luc.vanoostenryck@gmail.com>
References: <20170412092927.23884-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35289 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdDLJbe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 05:31:34 -0400
Received: by mail-wm0-f67.google.com with SMTP id d79so5170872wmi.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 02:31:33 -0700 (PDT)
In-Reply-To: <20170412092927.23884-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_SETVAL is used to create floating-point and string
as well as labels-as-values. This multi-purpose aspect
sometimes make things a bit more complicated.

Change this by using a new instruction for the direct
creation of floating-point literals without needing
to have an intermediate EXPR_FVALUE.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/instructions.txt      | 12 ++++++----
 linearize.c                         | 18 ++++++++++----
 linearize.h                         |  4 ++++
 liveness.c                          |  1 +
 simplify.c                          |  1 +
 sparse-llvm.c                       | 16 +++++++++----
 validation/cast-constant-to-float.c |  6 ++---
 validation/cast-constants.c         | 20 ++++++++--------
 validation/fp-ops.c                 |  2 +-
 validation/optim/bool-context-fp.c  | 47 +++++++++++++++++++++++++++++++++++++
 10 files changed, 100 insertions(+), 27 deletions(-)
 create mode 100644 validation/optim/bool-context-fp.c

diff --git a/Documentation/instructions.txt b/Documentation/instructions.txt
index b8d3d6bbc..236811daf 100644
--- a/Documentation/instructions.txt
+++ b/Documentation/instructions.txt
@@ -199,11 +199,15 @@ Create a pseudo corresponding to the address of a symbol.
 - .symbol: (pseudo_t) input symbol (alias .src)
 - .target: symbol's address
 
+=== OP_SETFVAL ===
+Create a pseudo corresponding to a floating-point literal.
+- .fvalue: the literal's value (long double)
+- .target: the corresponding pseudo
+- .type: type of the literal & .target
+
 === OP_SETVAL ===
-Create a pseudo corresponding to a value.
-The value is given as an expression EXPR_STRING, EXPR_FVALUE or
-EXPR_LABEL (pseudos for integral constants are directly created
-at linearization and doesn't need this instruction)
+Create a pseudo corresponding to a string literal or a label-as-value.
+The value is given as an expression EXPR_STRING or EXPR_LABEL.
 - .val: (expression) input expression
 - .target: the resulting value
 - .type: type of .target, the value
diff --git a/linearize.c b/linearize.c
index 902d45087..9fda0a1ad 100644
--- a/linearize.c
+++ b/linearize.c
@@ -245,6 +245,7 @@ static const char *opcodes[] = {
 	[OP_LOAD] = "load",
 	[OP_STORE] = "store",
 	[OP_SETVAL] = "set",
+	[OP_SETFVAL] = "setfval",
 	[OP_SYMADDR] = "symaddr",
 	[OP_GET_ELEMENT_PTR] = "getelem",
 
@@ -386,6 +387,11 @@ const char *show_instruction(struct instruction *insn)
 		}
 		break;
 	}
+	case OP_SETFVAL:
+		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
+		buf += sprintf(buf, "%Lf", insn->fvalue);
+		break;
+
 	case OP_SWITCH: {
 		struct multijmp *jmp;
 		buf += sprintf(buf, "%s", show_pseudo(insn->cond));
@@ -1018,12 +1024,10 @@ static pseudo_t add_setval(struct entrypoint *ep, struct symbol *ctype, struct e
 
 static pseudo_t add_setfval(struct entrypoint *ep, struct symbol *ctype, long double fval)
 {
-	struct instruction *insn = alloc_typed_instruction(OP_SETVAL, ctype);
-	struct expression *expr = alloc_expression(insn->pos, EXPR_FVALUE);
+	struct instruction *insn = alloc_typed_instruction(OP_SETFVAL, ctype);
 	pseudo_t target = alloc_pseudo(insn);
 	insn->target = target;
-	insn->val = expr;
-	expr->fvalue = fval;
+	insn->fvalue = fval;
 	add_one_insn(ep, insn);
 	return target;
 }
@@ -1629,9 +1633,13 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 	case EXPR_VALUE:
 		return value_pseudo(expr->value);
 
-	case EXPR_STRING: case EXPR_FVALUE: case EXPR_LABEL:
+	case EXPR_STRING:
+	case EXPR_LABEL:
 		return add_setval(ep, expr->ctype, expr);
 
+	case EXPR_FVALUE:
+		return add_setfval(ep, expr->ctype, expr->fvalue);
+
 	case EXPR_STATEMENT:
 		return linearize_statement(ep, expr->statement);
 
diff --git a/linearize.h b/linearize.h
index 7e8c0eb2c..6f4298f33 100644
--- a/linearize.h
+++ b/linearize.h
@@ -111,6 +111,9 @@ struct instruction {
 			pseudo_t symbol;		/* Subtle: same offset as "src" !! */
 			struct expression *val;
 		};
+		struct /* setfval */ {
+			long double fvalue;
+		};
 		struct /* call */ {
 			pseudo_t func;
 			union {
@@ -223,6 +226,7 @@ enum opcode {
 	OP_LOAD,
 	OP_STORE,
 	OP_SETVAL,
+	OP_SETFVAL,
 	OP_SYMADDR,
 	OP_GET_ELEMENT_PTR,
 
diff --git a/liveness.c b/liveness.c
index f7c0414b5..9a95851f8 100644
--- a/liveness.c
+++ b/liveness.c
@@ -90,6 +90,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		break;
 
 	case OP_SETVAL:
+	case OP_SETFVAL:
 		DEFINES(target);
 		break;
 
diff --git a/simplify.c b/simplify.c
index 256a68b22..5e3d57470 100644
--- a/simplify.c
+++ b/simplify.c
@@ -272,6 +272,7 @@ void kill_insn(struct instruction *insn, int force)
 		return;
 
 	case OP_BR:
+	case OP_SETFVAL:
 	default:
 		break;
 	}
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 415f29607..da9f2ce25 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -955,13 +955,9 @@ static void output_op_fpcast(struct function *fn, struct instruction *insn)
 static void output_op_setval(struct function *fn, struct instruction *insn)
 {
 	struct expression *val = insn->val;
-	LLVMTypeRef dtype = symbol_type(insn->type);
 	LLVMValueRef target;
 
 	switch (val->type) {
-	case EXPR_FVALUE:
-		target = LLVMConstReal(dtype, val->fvalue);
-		break;
 	case EXPR_LABEL:
 		target = LLVMBlockAddress(fn->fn, val->symbol->bb_target->priv);
 		break;
@@ -972,6 +968,15 @@ static void output_op_setval(struct function *fn, struct instruction *insn)
 	insn->target->priv = target;
 }
 
+static void output_op_setfval(struct function *fn, struct instruction *insn)
+{
+	LLVMTypeRef dtype = symbol_type(insn->type);
+	LLVMValueRef target;
+
+	target = LLVMConstReal(dtype, insn->fvalue);
+	insn->target->priv = target;
+}
+
 static void output_insn(struct function *fn, struct instruction *insn)
 {
 	switch (insn->opcode) {
@@ -990,6 +995,9 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_SETVAL:
 		output_op_setval(fn, insn);
 		break;
+	case OP_SETFVAL:
+		output_op_setfval(fn, insn);
+		break;
 	case OP_SWITCH:
 		output_op_switch(fn, insn);
 		break;
diff --git a/validation/cast-constant-to-float.c b/validation/cast-constant-to-float.c
index 86b7ac0f7..ef7892f17 100644
--- a/validation/cast-constant-to-float.c
+++ b/validation/cast-constant-to-float.c
@@ -13,21 +13,21 @@ double f3(void) { return -1.0; }
 f1:
 .L0:
 	<entry-point>
-	set.64      %r1 <- -1.000000
+	setfval.64  %r1 <- -1.000000
 	ret.64      %r1
 
 
 f2:
 .L2:
 	<entry-point>
-	set.64      %r3 <- -1.000000
+	setfval.64  %r3 <- -1.000000
 	ret.64      %r3
 
 
 f3:
 .L4:
 	<entry-point>
-	set.64      %r5 <- -1.000000
+	setfval.64  %r5 <- -1.000000
 	ret.64      %r5
 
 
diff --git a/validation/cast-constants.c b/validation/cast-constants.c
index f47d6fd34..9e2006724 100644
--- a/validation/cast-constants.c
+++ b/validation/cast-constants.c
@@ -286,70 +286,70 @@ vptr_2_iptr:
 int_2_float:
 .L76:
 	<entry-point>
-	set.32      %r39 <- 123.000000
+	setfval.32  %r39 <- 123.000000
 	ret.32      %r39
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	set.32      %r41 <- 123.000000
+	setfval.32  %r41 <- 123.000000
 	ret.32      %r41
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	set.32      %r43 <- 123.000000
+	setfval.32  %r43 <- 123.000000
 	ret.32      %r43
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	set.32      %r45 <- 123.000000
+	setfval.32  %r45 <- 123.000000
 	ret.32      %r45
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	set.32      %r47 <- 1.123000
+	setfval.32  %r47 <- 1.123000
 	ret.32      %r47
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	set.64      %r49 <- 123.000000
+	setfval.64  %r49 <- 123.000000
 	ret.64      %r49
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	set.64      %r51 <- 123.000000
+	setfval.64  %r51 <- 123.000000
 	ret.64      %r51
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	set.64      %r53 <- 123.000000
+	setfval.64  %r53 <- 123.000000
 	ret.64      %r53
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	set.64      %r55 <- 123.000000
+	setfval.64  %r55 <- 123.000000
 	ret.64      %r55
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	set.64      %r57 <- 1.123000
+	setfval.64  %r57 <- 1.123000
 	ret.64      %r57
 
 
diff --git a/validation/fp-ops.c b/validation/fp-ops.c
index 7f58a72fc..14bb12462 100644
--- a/validation/fp-ops.c
+++ b/validation/fp-ops.c
@@ -48,7 +48,7 @@ fneg:
 ftst:
 .L10:
 	<entry-point>
-	set.64      %r21 <- 0.000000
+	setfval.64  %r21 <- 0.000000
 	fcmpoeq.1   %r23 <- %arg1, %r21
 	ret.1       %r23
 
diff --git a/validation/optim/bool-context-fp.c b/validation/optim/bool-context-fp.c
new file mode 100644
index 000000000..ad075c56e
--- /dev/null
+++ b/validation/optim/bool-context-fp.c
@@ -0,0 +1,47 @@
+#define	bool	_Bool
+
+bool bfimp(float a) { return a; }
+bool bfexp(float a) { return (bool)a; }
+
+bool bfnot(float a) { return !a; }
+int  ifnot(float a) { return !a; }
+
+/*
+ * check-name: bool context fp
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+bfimp:
+.L0:
+	<entry-point>
+	setfval.32  %r2 <- 0.000000
+	fcmpune.1   %r3 <- %arg1, %r2
+	ret.1       %r3
+
+
+bfexp:
+.L2:
+	<entry-point>
+	setfval.32  %r6 <- 0.000000
+	fcmpune.1   %r7 <- %arg1, %r6
+	ret.1       %r7
+
+
+bfnot:
+.L4:
+	<entry-point>
+	setfval.32  %r10 <- 0.000000
+	fcmpoeq.1   %r12 <- %arg1, %r10
+	ret.1       %r12
+
+
+ifnot:
+.L6:
+	<entry-point>
+	setfval.32  %r15 <- 0.000000
+	fcmpoeq.32  %r16 <- %arg1, %r15
+	ret.32      %r16
+
+
+ * check-output-end
+ */
-- 
2.12.0

