From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 2/2] no need for signed & unsigned multiplication
Date: Sun, 18 Feb 2018 10:15:19 +0100
Message-ID: <20180218091519.6708-3-luc.vanoostenryck@gmail.com>
References: <20180218091519.6708-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54601 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBRJPa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Feb 2018 04:15:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id z81so10046799wmb.4
        for <linux-sparse@vger.kernel.org>; Sun, 18 Feb 2018 01:15:30 -0800 (PST)
In-Reply-To: <20180218091519.6708-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, we have OP_MULS & OP_MULU but unless it's full,
widening multiplication both must give exactly the same
result (the world run on 2's complement CPUs now, right?).
Also, the IR doesn't have widening multiplication but
only instruction where both operands and the result have
the same size.

So, since theer is no reasons to keep 2 instructions,
merge OP_MULS & OP_MULU into a single one: OP_MUL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md |  7 ++-----
 cse.c               |  4 ++--
 example.c           |  5 ++---
 linearize.c         |  9 ++++-----
 linearize.h         |  2 +-
 opcode.c            |  3 +--
 simplify.c          | 15 +++++----------
 sparse-llvm.c       |  6 +-----
 validation/int128.c |  2 +-
 9 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index f18d3507d..959318e2d 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -54,11 +54,8 @@ Integer addition.
 #### OP_SUB
 Integer subtraction.
 
-#### OP_MULU
-Integer unsigned multiplication.
-
-#### OP_MULS
-Integer signed multiplication.
+#### OP_MUL
+Integer multiplication.
 
 #### OP_DIVU
 Integer unsigned division.
diff --git a/cse.c b/cse.c
index 269f03ba6..538556806 100644
--- a/cse.c
+++ b/cse.c
@@ -53,7 +53,7 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 
 	/* Binary arithmetic */
 	case OP_ADD: case OP_SUB:
-	case OP_MULU: case OP_MULS:
+	case OP_MUL:
 	case OP_DIVU: case OP_DIVS:
 	case OP_MODU: case OP_MODS:
 	case OP_SHL:
@@ -192,7 +192,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 
 	/* commutative binop */
 	case OP_ADD:
-	case OP_MULU: case OP_MULS:
+	case OP_MUL:
 	case OP_AND_BOOL: case OP_OR_BOOL:
 	case OP_AND: case OP_OR:
 	case OP_XOR:
diff --git a/example.c b/example.c
index 691e0f97c..755f0700e 100644
--- a/example.c
+++ b/example.c
@@ -32,8 +32,7 @@ static const char *opcodes[] = {
 	/* Binary */
 	[OP_ADD] = "add",
 	[OP_SUB] = "sub",
-	[OP_MULU] = "mulu",
-	[OP_MULS] = "muls",
+	[OP_MUL] = "mul",
 	[OP_DIVU] = "divu",
 	[OP_DIVS] = "divs",
 	[OP_MODU] = "modu",
@@ -1404,7 +1403,7 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		generate_copy(state, insn);
 		break;
 
-	case OP_ADD: case OP_MULU: case OP_MULS:
+	case OP_ADD: case OP_MUL:
 	case OP_AND: case OP_OR: case OP_XOR:
 	case OP_AND_BOOL: case OP_OR_BOOL:
 		generate_commutative_binop(state, insn);
diff --git a/linearize.c b/linearize.c
index c2a129f5d..eb4e68c21 100644
--- a/linearize.c
+++ b/linearize.c
@@ -183,8 +183,7 @@ static const char *opcodes[] = {
 	/* Binary */
 	[OP_ADD] = "add",
 	[OP_SUB] = "sub",
-	[OP_MULU] = "mulu",
-	[OP_MULS] = "muls",
+	[OP_MUL] = "mul",
 	[OP_DIVU] = "divu",
 	[OP_DIVS] = "divs",
 	[OP_MODU] = "modu",
@@ -1192,7 +1191,7 @@ static int map_opcode(int opcode, struct symbol *ctype)
 		return opcode_table[opcode].to_float;
 	if (ctype && (ctype->ctype.modifiers & MOD_SIGNED)) {
 		switch(opcode) {
-		case OP_MULU: case OP_DIVU: case OP_MODU: case OP_LSR:
+		case OP_DIVU: case OP_MODU: case OP_LSR:
 			opcode++;
 		}
 	}
@@ -1236,7 +1235,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		static const int op_trans[] = {
 			[SPECIAL_ADD_ASSIGN - SPECIAL_BASE] = OP_ADD,
 			[SPECIAL_SUB_ASSIGN - SPECIAL_BASE] = OP_SUB,
-			[SPECIAL_MUL_ASSIGN - SPECIAL_BASE] = OP_MULU,
+			[SPECIAL_MUL_ASSIGN - SPECIAL_BASE] = OP_MUL,
 			[SPECIAL_DIV_ASSIGN - SPECIAL_BASE] = OP_DIVU,
 			[SPECIAL_MOD_ASSIGN - SPECIAL_BASE] = OP_MODU,
 			[SPECIAL_SHL_ASSIGN - SPECIAL_BASE] = OP_SHL,
@@ -1347,7 +1346,7 @@ static pseudo_t linearize_binop(struct entrypoint *ep, struct expression *expr)
 	pseudo_t src1, src2, dst;
 	static const int opcode[] = {
 		['+'] = OP_ADD, ['-'] = OP_SUB,
-		['*'] = OP_MULU, ['/'] = OP_DIVU,
+		['*'] = OP_MUL, ['/'] = OP_DIVU,
 		['%'] = OP_MODU, ['&'] = OP_AND,
 		['|'] = OP_OR,  ['^'] = OP_XOR,
 		[SPECIAL_LEFTSHIFT] = OP_SHL,
diff --git a/linearize.h b/linearize.h
index fc00041d7..e27de8592 100644
--- a/linearize.h
+++ b/linearize.h
@@ -151,7 +151,7 @@ enum opcode {
 	OP_BINARY,
 	OP_ADD = OP_BINARY,
 	OP_SUB,
-	OP_MULU, OP_MULS,
+	OP_MUL,
 	OP_DIVU, OP_DIVS,
 	OP_MODU, OP_MODS,
 	OP_SHL,
diff --git a/opcode.c b/opcode.c
index b5eaae6ad..d872556e4 100644
--- a/opcode.c
+++ b/opcode.c
@@ -54,8 +54,7 @@ const struct opcode_table opcode_table[OP_LAST] = {
 
 	[OP_ADD] = {	.to_float = OP_FADD, },
 	[OP_SUB] = {	.to_float = OP_FSUB, },
-	[OP_MULS] = {	.to_float = OP_FMUL, },
-	[OP_MULU] = {	.to_float = OP_FMUL, },
+	[OP_MUL] = {	.to_float = OP_FMUL, },
 	[OP_DIVS] = {	.to_float = OP_FDIV, },
 	[OP_DIVU] = {	.to_float = OP_FDIV, },
 	[OP_NEG] = {	.to_float = OP_FNEG, },
diff --git a/simplify.c b/simplify.c
index a20cc7e7c..72f4da8a1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -415,12 +415,9 @@ static pseudo_t eval_insn(struct instruction *insn)
 	case OP_SUB:
 		res = left - right;
 		break;
-	case OP_MULU:
+	case OP_MUL:
 		res = ul * ur;
 		break;
-	case OP_MULS:
-		res = left * right;
-		break;
 	case OP_DIVU:
 		if (!ur)
 			goto undef;
@@ -536,8 +533,7 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 		return replace_with_pseudo(insn, insn->src1);
 
 	switch (insn->opcode) {
-	case OP_MULS:
-	case OP_MULU:
+	case OP_MUL:
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
 	/* Fall through */
@@ -627,7 +623,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 		return 0;
 
 	case OP_DIVU: case OP_DIVS:
-	case OP_MULU: case OP_MULS:
+	case OP_MUL:
 		return simplify_mul_div(insn, value);
 
 	case OP_AND_BOOL:
@@ -659,7 +655,7 @@ static int simplify_constant_leftside(struct instruction *insn)
 	case OP_SHL:
 	case OP_LSR: case OP_ASR:
 	case OP_AND:
-	case OP_MULU: case OP_MULS:
+	case OP_MUL:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
 		return 0;
@@ -1167,8 +1163,7 @@ int simplify_instruction(struct instruction *insn)
 	if (!insn->bb)
 		return 0;
 	switch (insn->opcode) {
-	case OP_ADD: case OP_MULS:
-	case OP_MULU:
+	case OP_ADD: case OP_MUL:
 	case OP_AND: case OP_OR: case OP_XOR:
 	case OP_AND_BOOL: case OP_OR_BOOL:
 		canonicalize_commutative(insn);
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 2f296ead4..692c49f84 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -542,11 +542,7 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	case OP_SUB:
 		target = LLVMBuildSub(fn->builder, lhs, rhs, target_name);
 		break;
-	case OP_MULU:
-		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
-		break;
-	case OP_MULS:
-		assert(!is_float_type(insn->type));
+	case OP_MUL:
 		target = LLVMBuildMul(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_DIVU:
diff --git a/validation/int128.c b/validation/int128.c
index 53d678e2c..adc733492 100644
--- a/validation/int128.c
+++ b/validation/int128.c
@@ -30,7 +30,7 @@ u64 foo(u64 a, u64 b, u64 c, u32 s)
  * check-output-ignore
  *
  * check-output-contains: ret\\..*\\$16
- * check-output-contains: mulu\\.128
+ * check-output-contains: mul\\.128
  * check-output-contains: add\\.128
  *
  * check-error-start
-- 
2.16.0

