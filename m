From: Bernd Petrovitsch <bernd@petrovitsch.priv.at>
Subject: Re: including sparse headers in C++ code
Date: Wed, 13 Oct 2010 16:45:10 +0200
Message-ID: <1286981110.14103.86.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin> <201010101352.10864.kdudka@redhat.com>
	 <1286790249.24953.14.camel@thorin>
	 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	 <20101011191219.GD8537@feather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-duiMdDuJF6vwHCOp5/Vn"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:2862 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750754Ab0JMOpe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Oct 2010 10:45:34 -0400
In-Reply-To: <20101011191219.GD8537@feather>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>


--=-duiMdDuJF6vwHCOp5/Vn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2010-10-11 at 12:12 -0700, Josh Triplett wrote:
[...] 
> Actually, Sparse seems to use "true" and "false" as variable names in
> several cases; for instance:
> 
> static struct symbol *evaluate_conditional_expression(struct expression *expr)
> {
>         struct expression **true;
> [...]
>         true = &expr->conditional;
> 
> 
> I think this only works because evaluate.c doesn't include stdbool.h.
> And sure enough, if I include stdbool.h from evaluate.c:
> 
>      CC       evaluate.o
> evaluate.c: In function ‘evaluate_conditional_expression’:
> evaluate.c:1081: error: expected identifier or ‘(’ before numeric constant
> evaluate.c:1095: error: lvalue required as left operand of assignment
> evaluate.c:1101: error: lvalue required as left operand of assignment
> evaluate.c:1106: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1114: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1116: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1116: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1122: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1126: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1126: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1133: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1134: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1134: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1202: error: invalid type argument of ‘unary *’ (have ‘int’)
> evaluate.c:1202: error: invalid type argument of ‘unary *’ (have ‘int’)

FWIW, the attached patch should fix that.

Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at

--=-duiMdDuJF6vwHCOp5/Vn
Content-Disposition: attachment; filename="0001-avoid-the-use-of-true-and-false-as-variable-names.patch"
Content-Type: text/x-patch; name="0001-avoid-the-use-of-true-and-false-as-variable-names.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

rename the local variables "true" and "false" to "if_true" and "if_false",
respectively to not clash with the well-known "keywords" defined by C99.
This is similar to commit 0be55c9.

Signed-off-by: Bernd Petrovitsch <bernd@sysprog.at>
---
 compile-i386.c |   18 +++++++++---------
 evaluate.c     |   22 +++++++++++-----------
 expand.c       |   18 +++++++++---------
 flow.c         |   18 +++++++++---------
 inline.c       |   26 +++++++++++++-------------
 linearize.c    |   12 ++++++------
 pre-process.c  |    4 ++--
 show-parse.c   |    6 +++---
 simplify.c     |   16 ++++++++--------
 9 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index abe9313..0770147 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1542,7 +1542,7 @@ static struct storage *emit_return_stmt(struct statement *stmt)
 
 static struct storage *emit_conditional_expr(struct expression *expr)
 {
-	struct storage *cond, *true = NULL, *false = NULL;
+	struct storage *cond, *if_true = NULL, *if_false = NULL;
 	struct storage *new = stack_alloc(expr->ctype->bit_size / 8);
 	int target_false, cond_end;
 
@@ -1551,16 +1551,16 @@ static struct storage *emit_conditional_expr(struct expression *expr)
 	target_false = emit_conditional_test(cond);
 
 	/* handle if-true part of the expression */
-	true = x86_expression(expr->cond_true);
+	if_true = x86_expression(expr->cond_true);
 
-	emit_copy(new, true, expr->ctype);
+	emit_copy(new, if_true, expr->ctype);
 
 	cond_end = emit_conditional_end(target_false);
 
 	/* handle if-false part of the expression */
-	false = x86_expression(expr->cond_false);
+	if_false = x86_expression(expr->cond_false);
 
-	emit_copy(new, false, expr->ctype);
+	emit_copy(new, if_false, expr->ctype);
 
 	/* end of conditional; jump target for if-true branch */
 	emit_label(cond_end, "end conditional");
@@ -1571,15 +1571,15 @@ static struct storage *emit_conditional_expr(struct expression *expr)
 static struct storage *emit_select_expr(struct expression *expr)
 {
 	struct storage *cond = x86_expression(expr->conditional);
-	struct storage *true = x86_expression(expr->cond_true);
-	struct storage *false = x86_expression(expr->cond_false);
+	struct storage *if_true = x86_expression(expr->cond_true);
+	struct storage *if_false = x86_expression(expr->cond_false);
 	struct storage *reg_cond, *reg_true, *reg_false;
 	struct storage *new = stack_alloc(4);
 
 	emit_comment("begin SELECT");
 	reg_cond = get_reg_value(cond, get_regclass(expr->conditional));
-	reg_true = get_reg_value(true, get_regclass(expr));
-	reg_false = get_reg_value(false, get_regclass(expr));
+	reg_true = get_reg_value(if_true, get_regclass(expr));
+	reg_false = get_reg_value(if_false, get_regclass(expr));
 
 	/*
 	 * Do the actual select: check the conditional for zero,
diff --git a/evaluate.c b/evaluate.c
index f8343c2..e243be5 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1077,7 +1077,7 @@ OK:
  */
 static struct symbol *evaluate_conditional_expression(struct expression *expr)
 {
-	struct expression **true;
+	struct expression **if_true;
 	struct symbol *ctype, *ltype, *rtype, *lbase, *rbase;
 	int lclass, rclass;
 	const char * typediff;
@@ -1091,18 +1091,18 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	ctype = degenerate(expr->conditional);
 	rtype = degenerate(expr->cond_false);
 
-	true = &expr->conditional;
+	if_true = &expr->conditional;
 	ltype = ctype;
 	if (expr->cond_true) {
 		if (!evaluate_expression(expr->cond_true))
 			return NULL;
 		ltype = degenerate(expr->cond_true);
-		true = &expr->cond_true;
+		if_true = &expr->cond_true;
 	}
 
 	if (expr->flags) {
 		int flags = expr->conditional->flags & Int_const_expr;
-		flags &= (*true)->flags & expr->cond_false->flags;
+		flags &= (*if_true)->flags & expr->cond_false->flags;
 		if (!flags)
 			expr->flags = 0;
 	}
@@ -1110,27 +1110,27 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
 	if (lclass & rclass & TYPE_NUM) {
-		ctype = usual_conversions('?', *true, expr->cond_false,
+		ctype = usual_conversions('?', *if_true, expr->cond_false,
 					  lclass, rclass, ltype, rtype);
-		*true = cast_to(*true, ctype);
+		*if_true = cast_to(*if_true, ctype);
 		expr->cond_false = cast_to(expr->cond_false, ctype);
 		goto out;
 	}
 
 	if ((lclass | rclass) & TYPE_PTR) {
-		int is_null1 = is_null_pointer_constant(*true);
+		int is_null1 = is_null_pointer_constant(*if_true);
 		int is_null2 = is_null_pointer_constant(expr->cond_false);
 
 		if (is_null1 && is_null2) {
-			*true = cast_to(*true, &ptr_ctype);
+			*if_true = cast_to(*if_true, &ptr_ctype);
 			expr->cond_false = cast_to(expr->cond_false, &ptr_ctype);
 			ctype = &ptr_ctype;
 			goto out;
 		}
 		if (is_null1 && (rclass & TYPE_PTR)) {
 			if (is_null1 == 2)
-				bad_null(*true);
-			*true = cast_to(*true, rtype);
+				bad_null(*if_true);
+			*if_true = cast_to(*if_true, rtype);
 			ctype = rtype;
 			goto out;
 		}
@@ -1198,7 +1198,7 @@ Qual:
 		sym->ctype.modifiers |= qual;
 		ctype = sym;
 	}
-	*true = cast_to(*true, ctype);
+	*if_true = cast_to(*if_true, ctype);
 	expr->cond_false = cast_to(expr->cond_false, ctype);
 	goto out;
 }
diff --git a/expand.c b/expand.c
index b965dc3..8d7de3e 100644
--- a/expand.c
+++ b/expand.c
@@ -508,27 +508,27 @@ static int expand_compare(struct expression *expr)
 static int expand_conditional(struct expression *expr)
 {
 	struct expression *cond = expr->conditional;
-	struct expression *true = expr->cond_true;
-	struct expression *false = expr->cond_false;
+	struct expression *if_true = expr->cond_true;
+	struct expression *if_false = expr->cond_false;
 	int cost, cond_cost;
 
 	cond_cost = expand_expression(cond);
 	if (cond->type == EXPR_VALUE) {
 		unsigned flags = expr->flags;
 		if (!cond->value)
-			true = false;
-		if (!true)
-			true = cond;
-		cost = expand_expression(true);
-		*expr = *true;
+			if_true = if_false;
+		if (!if_true)
+			if_true = cond;
+		cost = expand_expression(if_true);
+		*expr = *if_true;
 		expr->flags = flags;
 		if (expr->type == EXPR_VALUE)
 			expr->taint |= cond->taint;
 		return cost;
 	}
 
-	cost = expand_expression(true);
-	cost += expand_expression(false);
+	cost = expand_expression(if_true);
+	cost += expand_expression(if_false);
 
 	if (cost < SELECT_COST) {
 		expr->type = EXPR_SELECT;
diff --git a/flow.c b/flow.c
index 5bd9a1d..1df8646 100644
--- a/flow.c
+++ b/flow.c
@@ -100,7 +100,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		struct basic_block *source, *target;
 		pseudo_t pseudo;
 		struct instruction *br;
-		int true;
+		int if_true;
 
 		if (!def)
 			continue;
@@ -113,10 +113,10 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 			continue;
 		if (br->opcode != OP_BR)
 			continue;
-		true = pseudo_truth_value(pseudo);
-		if (true < 0)
+		if_true = pseudo_truth_value(pseudo);
+		if (if_true < 0)
 			continue;
-		target = true ? second->bb_true : second->bb_false;
+		target = if_true ? second->bb_true : second->bb_false;
 		if (bb_depends_on(target, bb))
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
@@ -165,7 +165,7 @@ static int simplify_phi_branch(struct basic_block *bb, struct instruction *br)
 }
 
 static int simplify_branch_branch(struct basic_block *bb, struct instruction *br,
-	struct basic_block **target_p, int true)
+	struct basic_block **target_p, int if_true)
 {
 	struct basic_block *target = *target_p, *final;
 	struct instruction *insn;
@@ -181,7 +181,7 @@ static int simplify_branch_branch(struct basic_block *bb, struct instruction *br
 	 * Now we just need to see if we can rewrite the branch..
 	 */
 	retval = 0;
-	final = true ? insn->bb_true : insn->bb_false;
+	final = if_true ? insn->bb_true : insn->bb_false;
 	if (bb_has_side_effects(target))
 		goto try_to_rewrite_target;
 	if (bb_depends_on(final, target))
@@ -823,13 +823,13 @@ static struct basic_block * rewrite_branch_bb(struct basic_block *bb, struct ins
 {
 	struct basic_block *parent;
 	struct basic_block *target = br->bb_true;
-	struct basic_block *false = br->bb_false;
+	struct basic_block *if_false = br->bb_false;
 
-	if (target && false) {
+	if (target && if_false) {
 		pseudo_t cond = br->cond;
 		if (cond->type != PSEUDO_VAL)
 			return NULL;
-		target = cond->value ? target : false;
+		target = cond->value ? target : if_false;
 	}
 
 	/*
diff --git a/inline.c b/inline.c
index 860c0ee..612b843 100644
--- a/inline.c
+++ b/inline.c
@@ -162,14 +162,14 @@ static struct expression * copy_expression(struct expression *expr)
 	case EXPR_SELECT:
 	case EXPR_CONDITIONAL: {
 		struct expression *cond = copy_expression(expr->conditional);
-		struct expression *true = copy_expression(expr->cond_true);
-		struct expression *false = copy_expression(expr->cond_false);
-		if (cond == expr->conditional && true == expr->cond_true && false == expr->cond_false)
+		struct expression *if_true = copy_expression(expr->cond_true);
+		struct expression *if_false = copy_expression(expr->cond_false);
+		if (cond == expr->conditional && if_true == expr->cond_true && if_false == expr->cond_false)
 			break;
 		expr = dup_expression(expr);
 		expr->conditional = cond;
-		expr->cond_true = true;
-		expr->cond_false = false;
+		expr->cond_true = if_true;
+		expr->cond_false = if_false;
 		break;
 	}
 
@@ -353,20 +353,20 @@ static struct statement *copy_one_statement(struct statement *stmt)
 	}
 	case STMT_IF: {
 		struct expression *cond = stmt->if_conditional;
-		struct statement *true = stmt->if_true;
-		struct statement *false = stmt->if_false;
+		struct statement *if_true = stmt->if_true;
+		struct statement *if_false = stmt->if_false;
 
 		cond = copy_expression(cond);
-		true = copy_one_statement(true);
-		false = copy_one_statement(false);
+		if_true = copy_one_statement(if_true);
+		if_false = copy_one_statement(if_false);
 		if (stmt->if_conditional == cond &&
-		    stmt->if_true == true &&
-		    stmt->if_false == false)
+		    stmt->if_true == if_true &&
+		    stmt->if_false == if_false)
 			break;
 		stmt = dup_statement(stmt);
 		stmt->if_conditional = cond;
-		stmt->if_true = true;
-		stmt->if_false = false;
+		stmt->if_true = if_true;
+		stmt->if_false = if_false;
 		break;
 	}
 	case STMT_RETURN: {
diff --git a/linearize.c b/linearize.c
index f2034ce..d29efce 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1287,19 +1287,19 @@ pseudo_t linearize_cond_branch(struct entrypoint *ep, struct expression *expr, s
 
 static pseudo_t linearize_select(struct entrypoint *ep, struct expression *expr)
 {
-	pseudo_t cond, true, false, res;
+	pseudo_t cond, if_true, if_false, res;
 	struct instruction *insn;
 
-	true = linearize_expression(ep, expr->cond_true);
-	false = linearize_expression(ep, expr->cond_false);
+	if_true = linearize_expression(ep, expr->cond_true);
+	if_false = linearize_expression(ep, expr->cond_false);
 	cond = linearize_expression(ep, expr->conditional);
 
 	insn = alloc_typed_instruction(OP_SEL, expr->ctype);
 	if (!expr->cond_true)
-		true = cond;
+		if_true = cond;
 	use_pseudo(insn, cond, &insn->src1);
-	use_pseudo(insn, true, &insn->src2);
-	use_pseudo(insn, false, &insn->src3);
+	use_pseudo(insn, if_true, &insn->src2);
+	use_pseudo(insn, if_false, &insn->src3);
 
 	res = alloc_pseudo(insn);
 	insn->target = res;
diff --git a/pre-process.c b/pre-process.c
index 656acaa..7317d57 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1236,13 +1236,13 @@ static int handle_strong_undef(struct stream *stream, struct token **line, struc
 	return do_handle_undef(stream, line, token, SYM_ATTR_STRONG);
 }
 
-static int preprocessor_if(struct stream *stream, struct token *token, int true)
+static int preprocessor_if(struct stream *stream, struct token *token, int if_true)
 {
 	token_type(token) = false_nesting ? TOKEN_SKIP_GROUPS : TOKEN_IF;
 	free_preprocessor_line(token->next);
 	token->next = stream->top_if;
 	stream->top_if = token;
-	if (false_nesting || true != 1)
+	if (false_nesting || if_true != 1)
 		false_nesting++;
 	return 0;
 }
diff --git a/show-parse.c b/show-parse.c
index c97debe..d47d832 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -1001,11 +1001,11 @@ static int show_label_expr(struct expression *expr)
 static int show_conditional_expr(struct expression *expr)
 {
 	int cond = show_expression(expr->conditional);
-	int true = show_expression(expr->cond_true);
-	int false = show_expression(expr->cond_false);
+	int if_true = show_expression(expr->cond_true);
+	int if_false = show_expression(expr->cond_false);
 	int new = new_pseudo();
 
-	printf("[v%d]\tcmov.%d\t\tv%d,v%d,v%d\n", cond, expr->ctype->bit_size, new, true, false);
+	printf("[v%d]\tcmov.%d\t\tv%d,v%d,v%d\n", cond, expr->ctype->bit_size, new, if_true, if_false);
 	return new;
 }
 
diff --git a/simplify.c b/simplify.c
index 8200584..2d70743 100644
--- a/simplify.c
+++ b/simplify.c
@@ -780,10 +780,10 @@ static int simplify_cond_branch(struct instruction *br, pseudo_t cond, struct in
 	use_pseudo(br, *pp, &br->cond);
 	remove_usage(cond, &br->cond);
 	if (def->opcode == OP_SET_EQ) {
-		struct basic_block *true = br->bb_true;
-		struct basic_block *false = br->bb_false;
-		br->bb_false = true;
-		br->bb_true = false;
+		struct basic_block *if_true = br->bb_true;
+		struct basic_block *if_false = br->bb_false;
+		br->bb_false = if_true;
+		br->bb_true = if_false;
 	}
 	return REPEAT_CSE;
 }
@@ -836,10 +836,10 @@ static int simplify_branch(struct instruction *insn)
 					return REPEAT_CSE;
 				}
 				if (val2) {
-					struct basic_block *true = insn->bb_true;
-					struct basic_block *false = insn->bb_false;
-					insn->bb_false = true;
-					insn->bb_true = false;
+					struct basic_block *if_true = insn->bb_true;
+					struct basic_block *if_false = insn->bb_false;
+					insn->bb_false = if_true;
+					insn->bb_true = if_false;
 				}
 				use_pseudo(insn, def->src1, &insn->cond);
 				remove_usage(cond, &insn->cond);
-- 
1.7.2.3


--=-duiMdDuJF6vwHCOp5/Vn--

