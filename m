From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix boolean context for OP_AND_BOOL & OP_OR_BOOL
Date: Fri, 12 May 2017 01:37:49 +0200
Message-ID: <20170511233749.9500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33422 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932267AbdEKXjz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 19:39:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id w50so5519181wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 16:39:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Current simplifications of 'x && 1 --> x' and its dual
'x || 0 --> x' are wrong because the '||' and '&&' operators
demand that their operands are first compared against zero
which then always give a boolean valued result.
For example: '3 && 1' is not equal to '3' but to '1' (or 'true').
The correct simplification is thus 'x && 1 --> x != 0' and
'x || 0 --> x != 0'.

Fix this by always first doing the comparison against zero
before generating the OP_AND_BOOL and OP_OR_BOOL instructions.

Note: of course, we could decide that the semantic of OP_AND_BOOL
      and OP_OR_BOOL is that these ops take care themselves of
      making a boolean context (which was, I think, why these
      ops were created) but then these simplifications cannot be
      done (or when they are done, we need to add the comparison
      against zero).

Fixes: b85ec4bb7f5b1c522d7c71782dbd9cf1c4c49b2f
Fixes: a0886db12307d2633b04ec44342099a2955794a5
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

 Note: this patch is essentially a respin of a previous patch
       but stripped of its dependences on all the LLVM,
       floating point & optimization changes which will be
       upstreamed later.

 linearize.c                      | 37 +++++++++++++++++++++++++++++++++++--
 validation/optim/bool-context.c  | 12 ++++++++++++
 validation/optim/bool-simplify.c |  8 ++++++--
 3 files changed, 53 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/bool-context.c

diff --git a/linearize.c b/linearize.c
index a9f36b823..236d37a31 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1156,6 +1156,26 @@ static int opcode_sign(int opcode, struct symbol *ctype)
 	return opcode;
 }
 
+static inline pseudo_t add_convert_to_bool(struct entrypoint *ep, pseudo_t src, struct symbol *type)
+{
+	pseudo_t zero;
+	int op;
+
+	if (is_bool_type(type))
+		return src;
+	zero = value_pseudo(0);
+	op = OP_SET_NE;
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
@@ -1276,6 +1296,19 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
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
@@ -1286,8 +1319,6 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 		['|'] = OP_OR,  ['^'] = OP_XOR,
 		[SPECIAL_LEFTSHIFT] = OP_SHL,
 		[SPECIAL_RIGHTSHIFT] = OP_LSR,
-		[SPECIAL_LOGICAL_AND] = OP_AND_BOOL,
-		[SPECIAL_LOGICAL_OR] = OP_OR_BOOL,
 	};
 	int op;
 
@@ -1570,6 +1601,8 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 		return linearize_call_expression(ep, expr);
 
 	case EXPR_BINOP:
+		if (expr->op == SPECIAL_LOGICAL_AND || expr->op == SPECIAL_LOGICAL_OR)
+			return linearize_binop_bool(ep, expr);
 		return linearize_binop(ep, expr);
 
 	case EXPR_LOGICAL:
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
2.12.2

