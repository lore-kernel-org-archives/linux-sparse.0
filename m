From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 28/29] sssa: switch to the new SSA construction
Date: Wed, 16 Aug 2017 17:34:54 +0200
Message-ID: <20170816153455.97693-29-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37238 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPf6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id z91so652256wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:57 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This patch makes the needed changes in the linearization
to use the new SA construction method.

The main changes are:
- hook into add_load() & add_store() to directly get the
  variables's SSA form if the variable is 'simple enough'
- sprinkle calls to seal_bb() each time we know the current
  can't possibly have another parent. In this case the paper
  talk of the BB being 'sealed' hence the name.
- a minor simplification can be done for returns.
- labels need a bit more care
- when reaching the end f the function, we can seal all the BB
  which are the target of a goto.
- last but not least we can unhook the previous method of
  SSA construction: simplify_one_symbol().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                             |  73 +++++++++------
 validation/cast-constant-to-float.c     |   8 +-
 validation/cast-constants.c             |  40 ++++----
 validation/cast-kinds.c                 | 160 ++++++++++++++++----------------
 validation/context.c                    |   2 +-
 validation/linear/bitfield-init-zero.c  |  24 ++---
 validation/linear/struct-init-partial.c |   8 +-
 validation/loop-linearization.c         |  60 ++++++------
 validation/memops-volatile.c            |   4 +-
 validation/optim/bool-simplify.c        |  12 +--
 10 files changed, 204 insertions(+), 187 deletions(-)

diff --git a/linearize.c b/linearize.c
index f47748b38..8d907c5ca 100644
--- a/linearize.c
+++ b/linearize.c
@@ -21,6 +21,7 @@
 #include "linearize.h"
 #include "flow.h"
 #include "target.h"
+#include "ssa.h"
 
 pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt);
 pseudo_t linearize_expression(struct entrypoint *ep, struct expression *expr);
@@ -722,7 +723,7 @@ static struct basic_block * add_label(struct entrypoint *ep, struct symbol *labe
 		return bb;
 	}
 	bb = ep->active;
-	if (!bb_reachable(bb) || !bb_empty(bb)) {
+	if (!bb_reachable(bb) || !bb_empty(bb) || bb->sealed) {
 		bb = alloc_basic_block(ep, label->pos);
 		set_activeblock(ep, bb);
 	}
@@ -966,9 +967,18 @@ static inline struct symbol *simple_access(struct access_data *ad)
 
 static pseudo_t add_load(struct entrypoint *ep, struct access_data *ad)
 {
+	struct basic_block *bb = ep->active;
 	struct instruction *insn;
+	struct symbol *var;
 	pseudo_t new;
 
+	if (!bb)
+		return VOID;
+	if ((var = simple_access(ad))) {
+		new = load_var(bb, var);
+		return new;
+	}
+
 	insn = alloc_typed_instruction(OP_LOAD, ad->source_type);
 	new = alloc_pseudo(insn);
 
@@ -983,10 +993,16 @@ static void add_store(struct entrypoint *ep, struct access_data *ad, pseudo_t va
 {
 	struct basic_block *bb = ep->active;
 	struct instruction *store;
+	struct symbol *var;
 
 	if (!bb)
 		return;
 
+	if ((var = simple_access(ad))) {
+		store_var(bb, var, value);
+		return;
+	}
+
 	store = alloc_typed_instruction(OP_STORE, ad->source_type);
 	store->offset = ad->offset;
 	use_pseudo(store, value, &store->target);
@@ -1447,9 +1463,11 @@ static pseudo_t linearize_short_conditional(struct entrypoint *ep, struct expres
 	phi1 = alloc_phi(ep->active, src1, expr->ctype);
 	add_branch(ep, expr, src1, merge, bb_false);
 
+	seal_bb(bb_false);
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
 	phi2 = alloc_phi(ep->active, src2, expr->ctype);
+	seal_bb(merge);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1472,14 +1490,17 @@ static pseudo_t linearize_conditional(struct entrypoint *ep, struct expression *
 
 	linearize_cond_branch(ep, cond, bb_true, bb_false);
 
+	seal_bb(bb_true);
 	set_activeblock(ep, bb_true);
 	src1 = linearize_expression(ep, expr_true);
 	phi1 = alloc_phi(ep->active, src1, expr->ctype);
 	add_goto(ep, merge); 
 
+	seal_bb(bb_false);
 	set_activeblock(ep, bb_false);
 	src2 = linearize_expression(ep, expr_false);
 	phi2 = alloc_phi(ep->active, src2, expr->ctype);
+	seal_bb(merge);
 	set_activeblock(ep, merge);
 
 	return add_join_conditional(ep, expr, phi1, phi2);
@@ -1568,6 +1589,7 @@ static pseudo_t linearize_logical_branch(struct entrypoint *ep, struct expressio
 		linearize_cond_branch(ep, expr->left, bb_true, next);
 	else
 		linearize_cond_branch(ep, expr->left, next, bb_false);
+	seal_bb(next);
 	set_activeblock(ep, next);
 	linearize_cond_branch(ep, expr->right, bb_true, bb_false);
 	return VOID;
@@ -1754,17 +1776,11 @@ static pseudo_t linearize_compound_statement(struct entrypoint *ep, struct state
 
 	if (ret) {
 		struct basic_block *bb = add_label(ep, ret);
-		struct instruction *phi_node = first_instruction(bb->insns);
 
-		if (!phi_node)
-			return pseudo;
-
-		if (pseudo_list_size(phi_node->phi_list)==1) {
-			pseudo = first_pseudo(phi_node->phi_list);
-			assert(pseudo->type == PSEUDO_PHI);
-			return pseudo->def->src1;
-		}
-		return phi_node->target;
+		seal_bb(bb);
+		pseudo = VOID;
+		if (!is_void_type(ret))
+			pseudo = load_var(bb, ret);
 	}
 
 	return pseudo;
@@ -1970,17 +1986,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
 	pseudo_t src = linearize_expression(ep, expr);
 	active = ep->active;
 	if (active && src != VOID) {
-		struct instruction *phi_node = first_instruction(bb_return->insns);
-		pseudo_t phi;
-		if (!phi_node) {
-			phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-			phi_node->target = alloc_pseudo(phi_node);
-			phi_node->bb = bb_return;
-			add_instruction(&bb_return->insns, phi_node);
-		}
-		phi = alloc_phi(active, src, expr->ctype);
-		phi->ident = &return_ident;
-		use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
+		store_var(active, stmt->ret_target, src);
 	}
 	add_goto(ep, bb_return);
 	return VOID;
@@ -2028,6 +2034,7 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 		}
 		add_multijmp(&switch_ins->multijmp_list, jmp);
 		add_bb(&bb_case->parents, active);
+		seal_bb(bb_case);
 		add_bb(&active->children, bb_case);
 	} END_FOR_EACH_PTR(sym);
 
@@ -2035,6 +2042,7 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 
 	/* And linearize the actual statement */
 	linearize_statement(ep, stmt->switch_statement);
+	seal_bb(switch_end);
 	set_activeblock(ep, switch_end);
 
 	if (!default_case)
@@ -2044,6 +2052,7 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 	add_multijmp(&switch_ins->multijmp_list, jmp);
 	add_bb(&default_case->parents, active);
 	add_bb(&active->children, default_case);
+	seal_bb(default_case);
 	sort_switch_cases(switch_ins);
 
 	return VOID;
@@ -2085,12 +2094,16 @@ static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt
 	linearize_statement(ep, statement);
 	add_goto(ep, loop_continue);
 
+	seal_bb(loop_continue);
 	set_activeblock(ep, loop_continue);
 	linearize_statement(ep, post_statement);
 	if (!post_condition)
 		add_goto(ep, loop_top);
 	else
 		linearize_cond_branch(ep, post_condition, loop_top, loop_end);
+	seal_bb(loop_body);	// FIXME: can be early if precond
+	seal_bb(loop_top);
+	seal_bb(loop_end);
 	set_activeblock(ep, loop_end);
 
 	return VOID;
@@ -2140,7 +2153,11 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		struct symbol *label = stmt->label_identifier;
 
 		if (label->used) {
-			add_label(ep, label);
+			bb = add_label(ep, label);
+			// label's bb must not be sealed if some
+			// goto to this label hasn't been issued yet
+			assert(!bb->sealed);
+			bb->unsealable = 1;
 		}
 		return linearize_statement(ep, stmt->label_statement);
 	}
@@ -2206,15 +2223,18 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 
  		linearize_cond_branch(ep, cond, bb_true, bb_false);
 
+		seal_bb(bb_true);
 		set_activeblock(ep, bb_true);
  		linearize_statement(ep, stmt->if_true);
  
  		if (stmt->if_false) {
 			endif = alloc_basic_block(ep, stmt->pos);
 			add_goto(ep, endif);
+			seal_bb(bb_false);
 			set_activeblock(ep, bb_false);
  			linearize_statement(ep, stmt->if_false);
 		}
+		seal_bb(endif);
 		set_activeblock(ep, endif);
 		break;
 	}
@@ -2248,6 +2268,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	
 	ep->name = sym;
 	sym->ep = ep;
+	seal_bb(bb);
 	set_activeblock(ep, bb);
 
 	entry = alloc_instruction(OP_ENTRY, 0);
@@ -2268,6 +2289,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	} END_FOR_EACH_PTR(arg);
 
 	result = linearize_statement(ep, base_type->stmt);
+	seal_gotos(ep);
 	if (bb_reachable(ep->active) && !bb_terminated(ep->active)) {
 		struct symbol *ret_type = base_type->ctype.base_type;
 		struct instruction *insn = alloc_typed_instruction(OP_RET, ret_type);
@@ -2289,11 +2311,6 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 	 */
 	kill_unreachable_bbs(ep);
 
-	/*
-	 * Turn symbols into pseudos
-	 */
-	simplify_symbol_usage(ep);
-
 repeat:
 	/*
 	 * Remove trivial instructions, and try to CSE
diff --git a/validation/cast-constant-to-float.c b/validation/cast-constant-to-float.c
index 86b7ac0f7..d4d2bc426 100644
--- a/validation/cast-constant-to-float.c
+++ b/validation/cast-constant-to-float.c
@@ -20,15 +20,15 @@ f1:
 f2:
 .L2:
 	<entry-point>
-	set.64      %r3 <- -1.000000
-	ret.64      %r3
+	set.64      %r2 <- -1.000000
+	ret.64      %r2
 
 
 f3:
 .L4:
 	<entry-point>
-	set.64      %r5 <- -1.000000
-	ret.64      %r5
+	set.64      %r3 <- -1.000000
+	ret.64      %r3
 
 
  * check-output-end
diff --git a/validation/cast-constants.c b/validation/cast-constants.c
index f47d6fd34..30350aaec 100644
--- a/validation/cast-constants.c
+++ b/validation/cast-constants.c
@@ -286,71 +286,71 @@ vptr_2_iptr:
 int_2_float:
 .L76:
 	<entry-point>
-	set.32      %r39 <- 123.000000
-	ret.32      %r39
+	set.32      %r1 <- 123.000000
+	ret.32      %r1
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	set.32      %r41 <- 123.000000
-	ret.32      %r41
+	set.32      %r2 <- 123.000000
+	ret.32      %r2
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	set.32      %r43 <- 123.000000
-	ret.32      %r43
+	set.32      %r3 <- 123.000000
+	ret.32      %r3
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	set.32      %r45 <- 123.000000
-	ret.32      %r45
+	set.32      %r4 <- 123.000000
+	ret.32      %r4
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	set.32      %r47 <- 1.123000
-	ret.32      %r47
+	set.32      %r5 <- 1.123000
+	ret.32      %r5
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	set.64      %r49 <- 123.000000
-	ret.64      %r49
+	set.64      %r6 <- 123.000000
+	ret.64      %r6
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	set.64      %r51 <- 123.000000
-	ret.64      %r51
+	set.64      %r7 <- 123.000000
+	ret.64      %r7
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	set.64      %r53 <- 123.000000
-	ret.64      %r53
+	set.64      %r8 <- 123.000000
+	ret.64      %r8
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	set.64      %r55 <- 123.000000
-	ret.64      %r55
+	set.64      %r9 <- 123.000000
+	ret.64      %r9
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	set.64      %r57 <- 1.123000
-	ret.64      %r57
+	set.64      %r10 <- 1.123000
+	ret.64      %r10
 
 
  * check-output-end
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 697f9735e..5fb55a994 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -64,29 +64,29 @@ uint_2_int:
 long_2_int:
 .L2:
 	<entry-point>
-	scast.32    %r5 <- (64) %arg1
-	ret.32      %r5
+	scast.32    %r2 <- (64) %arg1
+	ret.32      %r2
 
 
 ulong_2_int:
 .L4:
 	<entry-point>
-	cast.32     %r8 <- (64) %arg1
-	ret.32      %r8
+	cast.32     %r3 <- (64) %arg1
+	ret.32      %r3
 
 
 vptr_2_int:
 .L6:
 	<entry-point>
-	cast.32     %r11 <- (64) %arg1
-	ret.32      %r11
+	cast.32     %r4 <- (64) %arg1
+	ret.32      %r4
 
 
 iptr_2_int:
 .L8:
 	<entry-point>
-	cast.32     %r14 <- (64) %arg1
-	ret.32      %r14
+	cast.32     %r5 <- (64) %arg1
+	ret.32      %r5
 
 
 float_2_int:
@@ -98,8 +98,8 @@ float_2_int:
 double_2_int:
 .L12:
 	<entry-point>
-	cast.32     %r20 <- (64) %arg1
-	ret.32      %r20
+	cast.32     %r7 <- (64) %arg1
+	ret.32      %r7
 
 
 int_2_uint:
@@ -111,29 +111,29 @@ int_2_uint:
 long_2_uint:
 .L16:
 	<entry-point>
-	scast.32    %r26 <- (64) %arg1
-	ret.32      %r26
+	scast.32    %r9 <- (64) %arg1
+	ret.32      %r9
 
 
 ulong_2_uint:
 .L18:
 	<entry-point>
-	cast.32     %r29 <- (64) %arg1
-	ret.32      %r29
+	cast.32     %r10 <- (64) %arg1
+	ret.32      %r10
 
 
 vptr_2_uint:
 .L20:
 	<entry-point>
-	cast.32     %r32 <- (64) %arg1
-	ret.32      %r32
+	cast.32     %r11 <- (64) %arg1
+	ret.32      %r11
 
 
 iptr_2_uint:
 .L22:
 	<entry-point>
-	cast.32     %r35 <- (64) %arg1
-	ret.32      %r35
+	cast.32     %r12 <- (64) %arg1
+	ret.32      %r12
 
 
 float_2_uint:
@@ -145,22 +145,22 @@ float_2_uint:
 double_2_uint:
 .L26:
 	<entry-point>
-	cast.32     %r41 <- (64) %arg1
-	ret.32      %r41
+	cast.32     %r14 <- (64) %arg1
+	ret.32      %r14
 
 
 int_2_long:
 .L28:
 	<entry-point>
-	scast.64    %r44 <- (32) %arg1
-	ret.64      %r44
+	scast.64    %r15 <- (32) %arg1
+	ret.64      %r15
 
 
 uint_2_long:
 .L30:
 	<entry-point>
-	cast.64     %r47 <- (32) %arg1
-	ret.64      %r47
+	cast.64     %r16 <- (32) %arg1
+	ret.64      %r16
 
 
 ulong_2_long:
@@ -172,22 +172,22 @@ ulong_2_long:
 vptr_2_long:
 .L34:
 	<entry-point>
-	cast.64     %r53 <- (64) %arg1
-	ret.64      %r53
+	cast.64     %r18 <- (64) %arg1
+	ret.64      %r18
 
 
 iptr_2_long:
 .L36:
 	<entry-point>
-	cast.64     %r56 <- (64) %arg1
-	ret.64      %r56
+	cast.64     %r19 <- (64) %arg1
+	ret.64      %r19
 
 
 float_2_long:
 .L38:
 	<entry-point>
-	cast.64     %r59 <- (32) %arg1
-	ret.64      %r59
+	cast.64     %r20 <- (32) %arg1
+	ret.64      %r20
 
 
 double_2_long:
@@ -199,15 +199,15 @@ double_2_long:
 int_2_ulong:
 .L42:
 	<entry-point>
-	scast.64    %r65 <- (32) %arg1
-	ret.64      %r65
+	scast.64    %r22 <- (32) %arg1
+	ret.64      %r22
 
 
 uint_2_ulong:
 .L44:
 	<entry-point>
-	cast.64     %r68 <- (32) %arg1
-	ret.64      %r68
+	cast.64     %r23 <- (32) %arg1
+	ret.64      %r23
 
 
 long_2_ulong:
@@ -219,22 +219,22 @@ long_2_ulong:
 vptr_2_ulong:
 .L48:
 	<entry-point>
-	cast.64     %r74 <- (64) %arg1
-	ret.64      %r74
+	cast.64     %r25 <- (64) %arg1
+	ret.64      %r25
 
 
 iptr_2_ulong:
 .L50:
 	<entry-point>
-	cast.64     %r77 <- (64) %arg1
-	ret.64      %r77
+	cast.64     %r26 <- (64) %arg1
+	ret.64      %r26
 
 
 float_2_ulong:
 .L52:
 	<entry-point>
-	cast.64     %r80 <- (32) %arg1
-	ret.64      %r80
+	cast.64     %r27 <- (32) %arg1
+	ret.64      %r27
 
 
 double_2_ulong:
@@ -246,141 +246,141 @@ double_2_ulong:
 int_2_vptr:
 .L56:
 	<entry-point>
-	scast.64    %r86 <- (32) %arg1
-	ret.64      %r86
+	scast.64    %r29 <- (32) %arg1
+	ret.64      %r29
 
 
 uint_2_vptr:
 .L58:
 	<entry-point>
-	cast.64     %r89 <- (32) %arg1
-	ret.64      %r89
+	cast.64     %r30 <- (32) %arg1
+	ret.64      %r30
 
 
 long_2_vptr:
 .L60:
 	<entry-point>
-	scast.64    %r92 <- (64) %arg1
-	ret.64      %r92
+	scast.64    %r31 <- (64) %arg1
+	ret.64      %r31
 
 
 ulong_2_vptr:
 .L62:
 	<entry-point>
-	cast.64     %r95 <- (64) %arg1
-	ret.64      %r95
+	cast.64     %r32 <- (64) %arg1
+	ret.64      %r32
 
 
 iptr_2_vptr:
 .L64:
 	<entry-point>
-	cast.64     %r98 <- (64) %arg1
-	ret.64      %r98
+	cast.64     %r33 <- (64) %arg1
+	ret.64      %r33
 
 
 int_2_iptr:
 .L66:
 	<entry-point>
-	ptrcast.64  %r101 <- (32) %arg1
-	ret.64      %r101
+	ptrcast.64  %r34 <- (32) %arg1
+	ret.64      %r34
 
 
 uint_2_iptr:
 .L68:
 	<entry-point>
-	ptrcast.64  %r104 <- (32) %arg1
-	ret.64      %r104
+	ptrcast.64  %r35 <- (32) %arg1
+	ret.64      %r35
 
 
 long_2_iptr:
 .L70:
 	<entry-point>
-	ptrcast.64  %r107 <- (64) %arg1
-	ret.64      %r107
+	ptrcast.64  %r36 <- (64) %arg1
+	ret.64      %r36
 
 
 ulong_2_iptr:
 .L72:
 	<entry-point>
-	ptrcast.64  %r110 <- (64) %arg1
-	ret.64      %r110
+	ptrcast.64  %r37 <- (64) %arg1
+	ret.64      %r37
 
 
 vptr_2_iptr:
 .L74:
 	<entry-point>
-	ptrcast.64  %r113 <- (64) %arg1
-	ret.64      %r113
+	ptrcast.64  %r38 <- (64) %arg1
+	ret.64      %r38
 
 
 int_2_float:
 .L76:
 	<entry-point>
-	fpcast.32   %r116 <- (32) %arg1
-	ret.32      %r116
+	fpcast.32   %r39 <- (32) %arg1
+	ret.32      %r39
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	fpcast.32   %r119 <- (32) %arg1
-	ret.32      %r119
+	fpcast.32   %r40 <- (32) %arg1
+	ret.32      %r40
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	fpcast.32   %r122 <- (64) %arg1
-	ret.32      %r122
+	fpcast.32   %r41 <- (64) %arg1
+	ret.32      %r41
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	fpcast.32   %r125 <- (64) %arg1
-	ret.32      %r125
+	fpcast.32   %r42 <- (64) %arg1
+	ret.32      %r42
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	fpcast.32   %r128 <- (64) %arg1
-	ret.32      %r128
+	fpcast.32   %r43 <- (64) %arg1
+	ret.32      %r43
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	fpcast.64   %r131 <- (32) %arg1
-	ret.64      %r131
+	fpcast.64   %r44 <- (32) %arg1
+	ret.64      %r44
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	fpcast.64   %r134 <- (32) %arg1
-	ret.64      %r134
+	fpcast.64   %r45 <- (32) %arg1
+	ret.64      %r45
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	fpcast.64   %r137 <- (64) %arg1
-	ret.64      %r137
+	fpcast.64   %r46 <- (64) %arg1
+	ret.64      %r46
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	fpcast.64   %r140 <- (64) %arg1
-	ret.64      %r140
+	fpcast.64   %r47 <- (64) %arg1
+	ret.64      %r47
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	fpcast.64   %r143 <- (32) %arg1
-	ret.64      %r143
+	fpcast.64   %r48 <- (32) %arg1
+	ret.64      %r48
 
 
  * check-output-end
diff --git a/validation/context.c b/validation/context.c
index b9500dc75..9d82456b4 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -327,7 +327,7 @@ context.c:131:12: warning: context imbalance in 'warn_if1' - wrong count at exit
 context.c:140:12: warning: context imbalance in 'warn_if2' - different lock contexts for basic block
 context.c:202:9: warning: context imbalance in 'warn_while1' - different lock contexts for basic block
 context.c:210:17: warning: context imbalance in 'warn_while2' - unexpected unlock
-context.c:216:9: warning: context imbalance in 'warn_while3' - wrong count at exit
+context.c:214:13: warning: context imbalance in 'warn_while3' - wrong count at exit
 context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong count at exit
 context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong count at exit
 context.c:300:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block
diff --git a/validation/linear/bitfield-init-zero.c b/validation/linear/bitfield-init-zero.c
index 39a64345e..1f7882751 100644
--- a/validation/linear/bitfield-init-zero.c
+++ b/validation/linear/bitfield-init-zero.c
@@ -57,17 +57,17 @@ int bfs_get0(void)
 bfuu_init:
 .L0:
 	<entry-point>
-	cast.9      %r2 <- (32) %arg1
-	shl.32      %r4 <- %r2, $11
-	ret.32      %r4
+	cast.9      %r1 <- (32) %arg1
+	shl.32      %r2 <- %r1, $11
+	ret.32      %r2
 
 
 bfus_init:
 .L2:
 	<entry-point>
-	scast.9     %r10 <- (32) %arg1
-	shl.32      %r12 <- %r10, $11
-	ret.32      %r12
+	scast.9     %r5 <- (32) %arg1
+	shl.32      %r6 <- %r5, $11
+	ret.32      %r6
 
 
 bfu_get0:
@@ -79,17 +79,17 @@ bfu_get0:
 bfsu_init:
 .L6:
 	<entry-point>
-	cast.9      %r23 <- (32) %arg1
-	shl.32      %r25 <- %r23, $11
-	ret.32      %r25
+	cast.9      %r12 <- (32) %arg1
+	shl.32      %r13 <- %r12, $11
+	ret.32      %r13
 
 
 bfss_init:
 .L8:
 	<entry-point>
-	scast.9     %r31 <- (32) %arg1
-	shl.32      %r33 <- %r31, $11
-	ret.32      %r33
+	scast.9     %r16 <- (32) %arg1
+	shl.32      %r17 <- %r16, $11
+	ret.32      %r17
 
 
 bfs_get0:
diff --git a/validation/linear/struct-init-partial.c b/validation/linear/struct-init-partial.c
index 1f5078bfa..a80031a5b 100644
--- a/validation/linear/struct-init-partial.c
+++ b/validation/linear/struct-init-partial.c
@@ -24,8 +24,8 @@ s_init_first:
 	<entry-point>
 	store.96    $0 -> 0[s]
 	store.32    %arg1 -> 0[s]
-	load.96     %r2 <- 0[s]
-	ret.96      %r2
+	load.96     %r1 <- 0[s]
+	ret.96      %r1
 
 
 s_init_third:
@@ -33,8 +33,8 @@ s_init_third:
 	<entry-point>
 	store.96    $0 -> 0[s]
 	store.32    %arg1 -> 8[s]
-	load.96     %r5 <- 0[s]
-	ret.96      %r5
+	load.96     %r2 <- 0[s]
+	ret.96      %r2
 
 
  * check-output-end
diff --git a/validation/loop-linearization.c b/validation/loop-linearization.c
index 25c6dfb87..0c829ff18 100644
--- a/validation/loop-linearization.c
+++ b/validation/loop-linearization.c
@@ -39,11 +39,11 @@ static int fdo(void)
 ffor:
 .L0:
 	<entry-point>
-	phisrc.32   %phi5(i) <- $0
+	phisrc.32   %phi2(i) <- $0
 	br          .L4
 
 .L4:
-	phi.32      %r1(i) <- %phi5(i), %phi6(i)
+	phi.32      %r1(i) <- %phi2(i), %phi3(i)
 	setlt.32    %r2 <- %r1(i), $10
 	cbr         %r2, .L1, .L3
 
@@ -52,84 +52,84 @@ ffor:
 	cbr         %r4, .L2, .L5
 
 .L5:
-	phisrc.32   %phi1(return) <- $0
+	phisrc.32   %phi4(return) <- $0
 	br          .L7
 
 .L2:
-	add.32      %r7 <- %r1(i), $1
-	phisrc.32   %phi6(i) <- %r7
+	add.32      %r5 <- %r1(i), $1
+	phisrc.32   %phi3(i) <- %r5
 	br          .L4
 
 .L3:
-	phisrc.32   %phi2(return) <- $1
+	phisrc.32   %phi5(return) <- $1
 	br          .L7
 
 .L7:
-	phi.32      %r5 <- %phi1(return), %phi2(return)
-	ret.32      %r5
+	phi.32      %r6(return) <- %phi4(return), %phi5(return)
+	ret.32      %r6(return)
 
 
 fwhile:
 .L8:
 	<entry-point>
-	phisrc.32   %phi11(i) <- $0
+	phisrc.32   %phi7(i) <- $0
 	br          .L12
 
 .L12:
-	phi.32      %r8(i) <- %phi11(i), %phi12(i)
-	setlt.32    %r9 <- %r8(i), $10
-	cbr         %r9, .L9, .L11
+	phi.32      %r7(i) <- %phi7(i), %phi8(i)
+	setlt.32    %r8 <- %r7(i), $10
+	cbr         %r8, .L9, .L11
 
 .L9:
-	call.32     %r11 <- p, %r8(i)
-	cbr         %r11, .L14, .L13
+	call.32     %r10 <- p, %r7(i)
+	cbr         %r10, .L14, .L13
 
 .L13:
-	phisrc.32   %phi7(return) <- $0
+	phisrc.32   %phi9(return) <- $0
 	br          .L15
 
 .L14:
-	add.32      %r14 <- %r8(i), $1
-	phisrc.32   %phi12(i) <- %r14
+	add.32      %r11 <- %r7(i), $1
+	phisrc.32   %phi8(i) <- %r11
 	br          .L12
 
 .L11:
-	phisrc.32   %phi8(return) <- $1
+	phisrc.32   %phi10(return) <- $1
 	br          .L15
 
 .L15:
-	phi.32      %r12 <- %phi7(return), %phi8(return)
-	ret.32      %r12
+	phi.32      %r12(return) <- %phi9(return), %phi10(return)
+	ret.32      %r12(return)
 
 
 fdo:
 .L16:
 	<entry-point>
-	phisrc.32   %phi16(i) <- $0
+	phisrc.32   %phi11(i) <- $0
 	br          .L17
 
 .L17:
-	phi.32      %r15(i) <- %phi16(i), %phi17(i)
-	call.32     %r16 <- p, %r15(i)
-	cbr         %r16, .L18, .L20
+	phi.32      %r13(i) <- %phi11(i), %phi12(i)
+	call.32     %r14 <- p, %r13(i)
+	cbr         %r14, .L18, .L20
 
 .L20:
 	phisrc.32   %phi13(return) <- $0
 	br          .L22
 
 .L18:
-	add.32      %r19 <- %r15(i), $1
-	setlt.32    %r20 <- %r15(i), $10
-	phisrc.32   %phi17(i) <- %r19
-	cbr         %r20, .L17, .L19
+	add.32      %r15 <- %r13(i), $1
+	setlt.32    %r16 <- %r13(i), $10
+	phisrc.32   %phi12(i) <- %r15
+	cbr         %r16, .L17, .L19
 
 .L19:
 	phisrc.32   %phi14(return) <- $1
 	br          .L22
 
 .L22:
-	phi.32      %r17 <- %phi13(return), %phi14(return)
-	ret.32      %r17
+	phi.32      %r17(return) <- %phi13(return), %phi14(return)
+	ret.32      %r17(return)
 
 
  * check-output-end
diff --git a/validation/memops-volatile.c b/validation/memops-volatile.c
index 0f3e12ad2..069aa73f3 100644
--- a/validation/memops-volatile.c
+++ b/validation/memops-volatile.c
@@ -13,8 +13,8 @@ foo:
 .L0:
 	<entry-point>
 	store.32    %arg2 -> 0[%arg1]
-	load.32     %r5 <- 0[%arg1]
-	ret.32      %r5
+	load.32     %r2 <- 0[%arg1]
+	ret.32      %r2
 
 
  * check-output-end
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
index 05be11497..0c8cddbb8 100644
--- a/validation/optim/bool-simplify.c
+++ b/validation/optim/bool-simplify.c
@@ -32,17 +32,17 @@ and_0:
 and_1:
 .L2:
 	<entry-point>
-	setne.1     %r8 <- %arg1, $0
-	cast.32     %r11 <- (1) %r8
-	ret.32      %r11
+	setne.1     %r5 <- %arg1, $0
+	cast.32     %r8 <- (1) %r5
+	ret.32      %r8
 
 
 or_0:
 .L4:
 	<entry-point>
-	setne.1     %r14 <- %arg1, $0
-	cast.32     %r17 <- (1) %r14
-	ret.32      %r17
+	setne.1     %r9 <- %arg1, $0
+	cast.32     %r12 <- (1) %r9
+	ret.32      %r12
 
 
 or_1:
-- 
2.14.0

