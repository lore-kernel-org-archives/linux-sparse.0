From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v0 4/4] give a type to PSEUDO_VALs
Date: Sat, 11 Mar 2017 16:47:25 +0100
Message-ID: <20170311154725.87906-5-luc.vanoostenryck@gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33386 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755495AbdCKPto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 10:49:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so3374075wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 07:49:36 -0800 (PST)
In-Reply-To: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      |  2 +-
 linearize.c | 17 +++++++++--------
 linearize.h |  2 +-
 memops.c    |  2 +-
 simplify.c  | 18 +++++++++---------
 5 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/flow.c b/flow.c
index 6878c0b4c..8013628c8 100644
--- a/flow.c
+++ b/flow.c
@@ -474,7 +474,7 @@ found:
 		if (!local)
 			return 0;
 		check_access(insn);
-		convert_load_instruction(insn, value_pseudo(0));
+		convert_load_instruction(insn, value_pseudo(0, insn->type));
 		return 1;
 	}
 
diff --git a/linearize.c b/linearize.c
index 255231c60..16dd8b3f3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -779,7 +779,7 @@ static pseudo_t symbol_pseudo(struct entrypoint *ep, struct symbol *sym)
 	return pseudo;
 }
 
-pseudo_t value_pseudo(long long val)
+pseudo_t value_pseudo(long long val, struct symbol *type)
 {
 #define MAX_VAL_HASH 64
 	static struct pseudo_list *prev[MAX_VAL_HASH];
@@ -788,13 +788,14 @@ pseudo_t value_pseudo(long long val)
 	pseudo_t pseudo;
 
 	FOR_EACH_PTR(*list, pseudo) {
-		if (pseudo->value == val)
+		if (pseudo->value == val && pseudo->sym == type)
 			return pseudo;
 	} END_FOR_EACH_PTR(pseudo);
 
 	pseudo = __alloc_pseudo(0);
 	pseudo->type = PSEUDO_VAL;
 	pseudo->value = val;
+	pseudo->sym = type;
 	add_pseudo(list, pseudo);
 
 	/* Value pseudos have neither nr, usage nor def */
@@ -951,10 +952,10 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 		unsigned long long mask = (1ULL << ad->bit_size)-1;
 
 		if (shift) {
-			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(shift));
+			store = add_binary_op(ep, ad->source_type, OP_SHL, value, value_pseudo(shift, &int_ctype));
 			mask <<= shift;
 		}
-		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask));
+		orig = add_binary_op(ep, ad->source_type, OP_AND, orig, value_pseudo(~mask, ad->source_type));
 		store = add_binary_op(ep, ad->source_type, OP_OR, orig, store);
 	}
 	add_store(ep, ad, store);
@@ -999,7 +1000,7 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 	pseudo_t new = add_load(ep, ad);
 
 	if (ad->bit_offset) {
-		pseudo_t shift = value_pseudo(ad->bit_offset);
+		pseudo_t shift = value_pseudo(ad->bit_offset, &int_ctype);
 		pseudo_t newval = add_binary_op(ep, ad->source_type, OP_LSR, new, shift);
 		new = newval;
 	}
@@ -1031,7 +1032,7 @@ static pseudo_t linearize_inc_dec(struct entrypoint *ep, struct expression *expr
 		return VOID;
 
 	old = linearize_load_gen(ep, &ad);
-	one = value_pseudo(expr->op_value);
+	one = value_pseudo(expr->op_value, expr->ctype);
 	new = add_binary_op(ep, expr->ctype, op, old, one);
 	linearize_store_gen(ep, new, &ad);
 	finish_address_gen(ep, &ad);
@@ -1070,7 +1071,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
 	case '+':
 		return pre;
 	case '!': {
-		pseudo_t zero = value_pseudo(0);
+		pseudo_t zero = value_pseudo(0, expr->unop->ctype);
 		return add_binary_op(ep, expr->ctype, OP_SET_EQ, pre, zero);
 	}
 	case '~':
@@ -1556,7 +1557,7 @@ pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr)
 		return add_symbol_address(ep, expr);
 
 	case EXPR_VALUE:
-		return value_pseudo(expr->value);
+		return value_pseudo(expr->value, expr->ctype);
 
 	case EXPR_STRING: case EXPR_FVALUE: case EXPR_LABEL:
 		return add_setval(ep, expr->ctype, expr);
diff --git a/linearize.h b/linearize.h
index a14733bd9..6a6eb1448 100644
--- a/linearize.h
+++ b/linearize.h
@@ -351,7 +351,7 @@ extern void insert_branch(struct basic_block *bb, struct instruction *br, struct
 
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, struct symbol *type);
 pseudo_t alloc_pseudo(struct instruction *def);
-pseudo_t value_pseudo(long long val);
+pseudo_t value_pseudo(long long val, struct symbol *type);
 
 struct entrypoint *linearize_symbol(struct symbol *sym);
 int unssa(struct entrypoint *ep);
diff --git a/memops.c b/memops.c
index 187a63284..05ce698c8 100644
--- a/memops.c
+++ b/memops.c
@@ -125,7 +125,7 @@ static void simplify_loads(struct basic_block *bb)
 				if (!dominators) {
 					if (local) {
 						assert(pseudo->type != PSEUDO_ARG);
-						convert_load_instruction(insn, value_pseudo(0));
+						convert_load_instruction(insn, value_pseudo(0, insn->type));
 					}
 					goto next_load;
 				}
diff --git a/simplify.c b/simplify.c
index a84e4787f..c9969531a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -368,7 +368,7 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 
 	if (value >= size) {
 		warning(insn->pos, "right shift by bigger than source value");
-		return replace_with_pseudo(insn, value_pseudo(0));
+		return replace_with_pseudo(insn, value_pseudo(0, insn->type));
 	}
 	if (!value)
 		return replace_with_pseudo(insn, pseudo);
@@ -478,7 +478,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
-			insn->src2 = value_pseudo(-value);
+			insn->src2 = value_pseudo(-value, insn->src2->sym);
 			return REPEAT_CSE;
 		}
 	/* Fall through */
@@ -495,7 +495,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 
 	case OP_MODU: case OP_MODS:
 		if (value == 1)
-			return replace_with_pseudo(insn, value_pseudo(0));
+			return replace_with_pseudo(insn, value_pseudo(0, insn->type));
 		return 0;
 
 	case OP_DIVU: case OP_DIVS:
@@ -656,7 +656,7 @@ static int simplify_constant_binop(struct instruction *insn)
 	}
 	res &= bits;
 
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_pseudo(insn, value_pseudo(res, insn->type));
 	return REPEAT_CSE;
 }
 
@@ -670,14 +670,14 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 			warning(insn->pos, "self-comparison always evaluates to false");
 	case OP_SUB:
 	case OP_XOR:
-		return replace_with_pseudo(insn, value_pseudo(0));
+		return replace_with_pseudo(insn, value_pseudo(0, insn->type));
 
 	case OP_SET_EQ:
 	case OP_SET_LE: case OP_SET_GE:
 	case OP_SET_BE: case OP_SET_AE:
 		if (Wtautological_compare)
 			warning(insn->pos, "self-comparison always evaluates to true");
-		return replace_with_pseudo(insn, value_pseudo(1));
+		return replace_with_pseudo(insn, value_pseudo(1, insn->type));
 
 	case OP_AND:
 	case OP_OR:
@@ -686,7 +686,7 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 	case OP_AND_BOOL:
 	case OP_OR_BOOL:
 		remove_usage(arg, &insn->src2);
-		insn->src2 = value_pseudo(0);
+		insn->src2 = value_pseudo(0, pseudo_type(insn->src1));
 		insn->opcode = OP_SET_NE;
 		return REPEAT_CSE;
 
@@ -789,7 +789,7 @@ static int simplify_constant_unop(struct instruction *insn)
 	mask = 1ULL << (insn->size-1);
 	res &= mask | (mask-1);
 	
-	replace_with_pseudo(insn, value_pseudo(res));
+	replace_with_pseudo(insn, value_pseudo(res, insn->type));
 	return REPEAT_CSE;
 }
 
@@ -913,7 +913,7 @@ static int simplify_cast(struct instruction *insn)
 	if (constant(src)) {
 		int sign = orig_type->ctype.modifiers & MOD_SIGNED;
 		long long val = get_cast_value(src->value, orig_size, size, sign);
-		src = value_pseudo(val);
+		src = value_pseudo(val, insn->type);
 		goto simplify;
 	}
 
-- 
2.11.1

