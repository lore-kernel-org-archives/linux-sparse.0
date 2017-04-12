From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] fix boolean context for OP_AND_BOOL & OP_OR_BOOL
Date: Wed, 12 Apr 2017 21:33:39 +0200
Message-ID: <20170412193344.95935-2-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35129 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755092AbdDLTdy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:33:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so8562516wmi.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:53 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Current simplification of 'x && 1 --> x' and its dual
'x || 0 --> x' are wrong because the '||' and '&&' operators
demand that their operands are first compared against zero
which then always give a boolean valued result.
For example: '3 && 1' is not equal to '3' but to '1'.
The correct simplification is thus 'x && 1 --> x != 0' and
'x || 0 --> x != 0'.

Fix this by always first doing the comparison against zero
before generating the OP_AND_BOOL and OP_OR_BOOL instructions.

Note: of course, we could decide that the semantic of OP_AND_BOOL
      and OP_OR_BOOL is that these ops take care themselves of
      making a boolean context (which I think was why these
      ops were created) but then these simplifications cannot be
      done (or when they are done, we need to add the comparison
      against zero).

Fixes: b85ec4bb7f5b1c522d7c71782dbd9cf1c4c49b2f
Fixes: a0886db12307d2633b04ec44342099a2955794a5
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                        | 42 +++++++++++++++++++++++++++++++--
 validation/optim/bool-context-fp.c | 48 ++++++++++++++++++++++++++++++++++++++
 validation/optim/bool-context.c    | 12 ++++++++++
 validation/optim/bool-simplify.c   |  8 +++++--
 4 files changed, 106 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/bool-context.c

diff --git a/linearize.c b/linearize.c
index 9fda0a1ad..e730ab56f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1209,6 +1209,31 @@ static int map_opcode(int opcode, struct symbol *ctype)
 	return opcode;
 }
 
+static inline pseudo_t add_convert_to_bool(struct entrypoint *ep, pseudo_t src, struct symbol *type)
+{
+	pseudo_t zero;
+	int op;
+
+	if (is_bool_type(type))
+		return src;
+	if (is_float_type(type)) {
+		zero = add_setfval(ep, type, 0.0);
+		op = map_opcode(OP_SET_NE, type);
+	} else {
+		zero = value_pseudo(0);
+		op = OP_SET_NE;
+	}
+	return add_binary_op(ep, &bool_ctype, op, src, zero);
+}
+
+static pseudo_t linearize_expression_to_bool(struct entrypoint *ep, struct expression *expr)
+{
+	pseudo_t dst;
+	dst = linearize_expression(ep, expr);
+	dst = add_convert_to_bool(ep, dst, expr->ctype);
+	return dst;
+}
+
 static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *expr)
 {
 	struct access_data ad = { NULL, };
@@ -1351,6 +1376,19 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 	return retval;
 }
 
+static pseudo_t linearize_binop_bool(struct entrypoint *ep, struct expression *expr)
+{
+	pseudo_t src1, src2, dst;
+	int op = (expr->op == SPECIAL_LOGICAL_OR) ? OP_OR_BOOL : OP_AND_BOOL;
+
+	src1 = linearize_expression_to_bool(ep, expr->left);
+	src2 = linearize_expression_to_bool(ep, expr->right);
+	dst = add_binary_op(ep, &bool_ctype, op, src1, src2);
+	if (expr->ctype != &bool_ctype)
+		dst = cast_pseudo(ep, dst, &bool_ctype, expr->ctype);
+	return dst;
+}
+
 static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 {
 	pseudo_t src1, src2, dst;
@@ -1361,8 +1399,6 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 		['|'] = OP_OR,  ['^'] = OP_XOR,
 		[SPECIAL_LEFTSHIFT] = OP_SHL,
 		[SPECIAL_RIGHTSHIFT] = OP_LSR,
-		[SPECIAL_LOGICAL_AND] = OP_AND_BOOL,
-		[SPECIAL_LOGICAL_OR] = OP_OR_BOOL,
 	};
 	int op;
 
@@ -1647,6 +1683,8 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 		return linearize_call_expression(ep, expr);
 
 	case EXPR_BINOP:
+		if (expr->op == SPECIAL_LOGICAL_AND || expr->op == SPECIAL_LOGICAL_OR)
+			return linearize_binop_bool(ep, expr);
 		return linearize_binop(ep, expr);
 
 	case EXPR_LOGICAL:
diff --git a/validation/optim/bool-context-fp.c b/validation/optim/bool-context-fp.c
index ad075c56e..6b3e8d181 100644
--- a/validation/optim/bool-context-fp.c
+++ b/validation/optim/bool-context-fp.c
@@ -5,6 +5,10 @@ bool bfexp(float a) { return (bool)a; }
 
 bool bfnot(float a) { return !a; }
 int  ifnot(float a) { return !a; }
+bool bfior(float a, float b) { return a || b; }
+int  ifior(float a, float b) { return a || b; }
+bool bfand(float a, float b) { return a && b; }
+int  ifand(float a, float b) { return a && b; }
 
 /*
  * check-name: bool context fp
@@ -43,5 +47,49 @@ ifnot:
 	ret.32      %r16
 
 
+bfior:
+.L8:
+	<entry-point>
+	setfval.32  %r19 <- 0.000000
+	fcmpune.1   %r20 <- %arg1, %r19
+	fcmpune.1   %r23 <- %arg2, %r19
+	or-bool.1   %r24 <- %r23, %r20
+	setne.1     %r26 <- %r24, $0
+	ret.1       %r26
+
+
+ifior:
+.L10:
+	<entry-point>
+	setfval.32  %r29 <- 0.000000
+	fcmpune.1   %r30 <- %arg1, %r29
+	fcmpune.1   %r33 <- %arg2, %r29
+	or-bool.1   %r34 <- %r33, %r30
+	cast.32     %r35 <- (1) %r34
+	ret.32      %r35
+
+
+bfand:
+.L12:
+	<entry-point>
+	setfval.32  %r38 <- 0.000000
+	fcmpune.1   %r39 <- %arg1, %r38
+	fcmpune.1   %r42 <- %arg2, %r38
+	and-bool.1  %r43 <- %r42, %r39
+	setne.1     %r45 <- %r43, $0
+	ret.1       %r45
+
+
+ifand:
+.L14:
+	<entry-point>
+	setfval.32  %r48 <- 0.000000
+	fcmpune.1   %r49 <- %arg1, %r48
+	fcmpune.1   %r52 <- %arg2, %r48
+	and-bool.1  %r53 <- %r52, %r49
+	cast.32     %r54 <- (1) %r53
+	ret.32      %r54
+
+
  * check-output-end
  */
diff --git a/validation/optim/bool-context.c b/validation/optim/bool-context.c
new file mode 100644
index 000000000..11326d391
--- /dev/null
+++ b/validation/optim/bool-context.c
@@ -0,0 +1,12 @@
+#define bool _Bool
+
+bool bool_ior(int a, int b) { return a || b; }
+bool bool_and(int a, int b) { return a && b; }
+
+/*
+ * check-name: bool-context
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-pattern-4-times: setne\\..* %arg[12]
+ */
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
index e0ff1c2d4..05be11497 100644
--- a/validation/optim/bool-simplify.c
+++ b/validation/optim/bool-simplify.c
@@ -32,13 +32,17 @@ and_0:
 and_1:
 .L2:
 	<entry-point>
-	ret.32      %arg1
+	setne.1     %r8 <- %arg1, $0
+	cast.32     %r11 <- (1) %r8
+	ret.32      %r11
 
 
 or_0:
 .L4:
 	<entry-point>
-	ret.32      %arg1
+	setne.1     %r14 <- %arg1, $0
+	cast.32     %r17 <- (1) %r14
+	ret.32      %r17
 
 
 or_1:
-- 
2.12.0

