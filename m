From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] remove OP_{AND,OR}_BOOL instructions
Date: Wed, 12 Apr 2017 21:33:44 +0200
Message-ID: <20170412193344.95935-7-luc.vanoostenryck@gmail.com>
References: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36684 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755129AbdDLTeA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 15:34:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id o21so5715046wrb.3
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 12:33:58 -0700 (PDT)
In-Reply-To: <20170412193344.95935-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that OP_AND_BOOL and OP_OR_BOOL are not generated anymore
we can remove all related code & defines.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c       |  4 +---
 example.c   |  3 ---
 linearize.c |  2 --
 linearize.h |  4 +---
 simplify.c  | 24 ------------------------
 5 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/cse.c b/cse.c
index cd1e8942c..0ea9b3241 100644
--- a/cse.c
+++ b/cse.c
@@ -61,8 +61,7 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_AND: case OP_OR:
 
 	/* Binary logical */
-	case OP_XOR: case OP_AND_BOOL:
-	case OP_OR_BOOL:
+	case OP_XOR:
 
 	/* Binary comparison */
 	case OP_SET_EQ: case OP_SET_NE:
@@ -192,7 +191,6 @@ static int insn_compare(const void *_i1, const void *_i2)
 	/* commutative binop */
 	case OP_ADD:
 	case OP_MULU: case OP_MULS:
-	case OP_AND_BOOL: case OP_OR_BOOL:
 	case OP_AND: case OP_OR:
 	case OP_XOR:
 	case OP_SET_EQ: case OP_SET_NE:
diff --git a/example.c b/example.c
index 69e00b325..ca1077876 100644
--- a/example.c
+++ b/example.c
@@ -46,8 +46,6 @@ static const char *opcodes[] = {
 	[OP_AND] = "and",
 	[OP_OR] = "or",
 	[OP_XOR] = "xor",
-	[OP_AND_BOOL] = "and-bool",
-	[OP_OR_BOOL] = "or-bool",
 
 	/* Binary comparison */
 	[OP_SET_EQ] = "seteq",
@@ -1406,7 +1404,6 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 
 	case OP_ADD: case OP_MULU: case OP_MULS:
 	case OP_AND: case OP_OR: case OP_XOR:
-	case OP_AND_BOOL: case OP_OR_BOOL:
 		generate_commutative_binop(state, insn);
 		break;
 
diff --git a/linearize.c b/linearize.c
index e6b77ec01..8e8c99e4a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -199,8 +199,6 @@ static const char *opcodes[] = {
 	[OP_AND] = "and",
 	[OP_OR] = "or",
 	[OP_XOR] = "xor",
-	[OP_AND_BOOL] = "and-bool",
-	[OP_OR_BOOL] = "or-bool",
 
 	/* Binary comparison */
 	[OP_SET_EQ] = "seteq",
diff --git a/linearize.h b/linearize.h
index 24cbcf94d..12a8fe3a7 100644
--- a/linearize.h
+++ b/linearize.h
@@ -175,9 +175,7 @@ enum opcode {
 	OP_AND,
 	OP_OR,
 	OP_XOR,
-	OP_AND_BOOL,
-	OP_OR_BOOL,
-	OP_BINARY_END = OP_OR_BOOL,
+	OP_BINARY_END = OP_XOR,
 
 	/* floating-point comparison */
 	OP_FPCMP,
diff --git a/simplify.c b/simplify.c
index 30bbc9b99..f730dc8ce 100644
--- a/simplify.c
+++ b/simplify.c
@@ -475,11 +475,6 @@ static int simplify_constant_rightside(struct instruction *insn)
 	long long bits = sbit | (sbit - 1);
 
 	switch (insn->opcode) {
-	case OP_OR_BOOL:
-		if (value == 1)
-			return replace_with_pseudo(insn, insn->src2);
-		goto case_neutral_zero;
-
 	case OP_OR:
 		if ((value & bits) == bits)
 			return replace_with_pseudo(insn, insn->src2);
@@ -518,10 +513,6 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
 
-	case OP_AND_BOOL:
-		if (value == 1)
-			return replace_with_pseudo(insn, insn->src1);
-	/* Fall through */
 	case OP_AND:
 		if ((value & bits) == bits)
 			return replace_with_pseudo(insn, insn->src1);
@@ -631,13 +622,6 @@ static int simplify_constant_binop(struct instruction *insn)
 	case OP_XOR:
 		res = left ^ right;
 		break;
-	case OP_AND_BOOL:
-		res = left && right;
-		break;
-	case OP_OR_BOOL:
-		res = left || right;
-		break;
-			       
 	/* Binary comparison */
 	case OP_SET_EQ:
 		res = left == right;
@@ -701,13 +685,6 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 	case OP_OR:
 		return replace_with_pseudo(insn, arg);
 
-	case OP_AND_BOOL:
-	case OP_OR_BOOL:
-		remove_usage(arg, &insn->src2);
-		insn->src2 = value_pseudo(0);
-		insn->opcode = OP_SET_NE;
-		return REPEAT_CSE;
