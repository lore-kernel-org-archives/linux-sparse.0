From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: including sparse headers in C++ code
Date: Fri, 29 Oct 2010 15:22:40 +0200
Message-ID: <1288358560.7795.34.camel@thorin>
References: <AANLkTinGSRQYqR2h+V0nAB+vn4xWCGxgbmGHuMm-xHyB@mail.gmail.com>
	 <AANLkTinaDZZmyeaK+rAvLCdZ-90n17WhABRsZGUBBcSH@mail.gmail.com>
	 <1286710919.24953.2.camel@thorin> <201010101352.10864.kdudka@redhat.com>
	 <1286790249.24953.14.camel@thorin>
	 <AANLkTin00gg79Zdg1JJgaaK+2wzgu9Xpr719MYOebQ+J@mail.gmail.com>
	 <20101011191219.GD8537@feather> <1286981110.14103.86.camel@thorin>
	 <20101020072945.GA3232@ZenIV.linux.org.uk> <1287567544.7542.7.camel@thorin>
	 <AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-QNCxE5A9XGayUpIR+y09"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4527 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756910Ab0J2NXH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 29 Oct 2010 09:23:07 -0400
In-Reply-To: <AANLkTikBMpuwHZpAsSmcP_5MC3GJQNZE3SrRT6VQ8boS@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kamil Dudka <kdudka@redhat.com>, Tomas Klacko <tomas.klacko@gmail.com>, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>


--=-QNCxE5A9XGayUpIR+y09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mit, 2010-10-20 at 08:34 -0700, Christopher Li wrote: 
> On Wed, Oct 20, 2010 at 2:39 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> >> certainly reek of IOCCC.  I'd rather avoid "if_true" as replacement, though.
> >> If anything, true_expr and false_expr would make more sense.
> >
> > I have no strong feelings about the replacement and just followed the
> > change in the referenced commit.
> > Chris, should I respin the patch with *_expr?
> 
> Please do. As far as I can remember, Al is always right.

Voila.

Bernd
-- 
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services

--=-QNCxE5A9XGayUpIR+y09
Content-Disposition: attachment; filename*0=0001-Rename-the-local-variables-true-and-false-to-true_ex.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-Rename-the-local-variables-true-and-false-to-true_ex.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rename the local variables "true" and "false" to "true_expr" and
"false_expr" (or another context-sensitive name), respectively to
not clash with the identical  "keywords" defined by C99.

The commit 0be55c9 was a step in that direction for .h files only.
Now it is complete.

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
index abe9313..1aaf98f 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1542,7 +1542,7 @@ static struct storage *emit_return_stmt(struct statement *stmt)
 
 static struct storage *emit_conditional_expr(struct expression *expr)
 {
-	struct storage *cond, *true = NULL, *false = NULL;
+	struct storage *cond, *true_expr = NULL, *false_expr = NULL;
 	struct storage *new = stack_alloc(expr->ctype->bit_size / 8);
 	int target_false, cond_end;
 
@@ -1551,16 +1551,16 @@ static struct storage *emit_conditional_expr(struct expression *expr)
 	target_false = emit_conditional_test(cond);
 
 	/* handle if-true part of the expression */
-	true = x86_expression(expr->cond_true);
+	true_expr = x86_expression(expr->cond_true);
 
-	emit_copy(new, true, expr->ctype);
+	emit_copy(new, true_expr, expr->ctype);
 
 	cond_end = emit_conditional_end(target_false);
 
 	/* handle if-false part of the expression */
-	false = x86_expression(expr->cond_false);
+	false_expr = x86_expression(expr->cond_false);
 
-	emit_copy(new, false, expr->ctype);
+	emit_copy(new, false_expr, expr->ctype);
 
 	/* end of conditional; jump target for if-true branch */
 	emit_label(cond_end, "end conditional");
@@ -1571,15 +1571,15 @@ static struct storage *emit_conditional_expr(struct expression *expr)
 static struct storage *emit_select_expr(struct expression *expr)
 {
 	struct storage *cond = x86_expression(expr->conditional);
-	struct storage *true = x86_expression(expr->cond_true);
-	struct storage *false = x86_expression(expr->cond_false);
+	struct storage *true_expr = x86_expression(expr->cond_true);
+	struct storage *false_expr = x86_expression(expr->cond_false);
 	struct storage *reg_cond, *reg_true, *reg_false;
 	struct storage *new = stack_alloc(4);
 
 	emit_comment("begin SELECT");
 	reg_cond = get_reg_value(cond, get_regclass(expr->conditional));
-	reg_true = get_reg_value(true, get_regclass(expr));
-	reg_false = get_reg_value(false, get_regclass(expr));
+	reg_true = get_reg_value(true_expr, get_regclass(expr));
+	reg_false = get_reg_value(false_expr, get_regclass(expr));
 
 	/*
 	 * Do the actual select: check the conditional for zero,
diff --git a/evaluate.c b/evaluate.c
index f8343c2..a3ac414 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1077,7 +1077,7 @@ OK:
  */
 static struct symbol *evaluate_conditional_expression(struct expression *expr)
 {
-	struct expression **true;
+	struct expression **true_expr;
 	struct symbol *ctype, *ltype, *rtype, *lbase, *rbase;
 	int lclass, rclass;
 	const char * typediff;
@@ -1091,18 +1091,18 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	ctype = degenerate(expr->conditional);
 	rtype = degenerate(expr->cond_false);
 
-	true = &expr->conditional;
+	true_expr = &expr->conditional;
 	ltype = ctype;
 	if (expr->cond_true) {
 		if (!evaluate_expression(expr->cond_true))
 			return NULL;
 		ltype = degenerate(expr->cond_true);
-		true = &expr->cond_true;
+		true_expr = &expr->cond_true;
 	}
 
 	if (expr->flags) {
 		int flags = expr->conditional->flags & Int_const_expr;
-		flags &= (*true)->flags & expr->cond_false->flags;
+		flags &= (*true_expr)->flags & expr->cond_false->flags;
 		if (!flags)
 			expr->flags = 0;
 	}
@@ -1110,27 +1110,27 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
 	if (lclass & rclass & TYPE_NUM) {
-		ctype = usual_conversions('?', *true, expr->cond_false,
+		ctype = usual_conversions('?', *true_expr, expr->cond_false,
 					  lclass, rclass, ltype, rtype);
-		*true = cast_to(*true, ctype);
+		*true_expr = cast_to(*true_expr, ctype);
 		expr->cond_false = cast_to(expr->cond_false, ctype);
 		goto out;
 	}
 
 	if ((lclass | rclass) & TYPE_PTR) {
-		int is_null1 = is_null_pointer_constant(*true);
+		int is_null1 = is_null_pointer_constant(*true_expr);
 		int is_null2 = is_null_pointer_constant(expr->cond_false);
 
 		if (is_null1 && is_null2) {
-			*true = cast_to(*true, &ptr_ctype);
+			*true_expr = cast_to(*true_expr, &ptr_ctype);
 			expr->cond_false = cast_to(expr->cond_false, &ptr_ctype);
 			ctype = &ptr_ctype;
 			goto out;
 		}
 		if (is_null1 && (rclass & TYPE_PTR)) {
 			if (is_null1 == 2)
-				bad_null(*true);
-			*true = cast_to(*true, rtype);
+				bad_null(*true_expr);
+			*true_expr = cast_to(*true_expr, rtype);
 			ctype = rtype;
 			goto out;
 		}
@@ -1198,7 +1198,7 @@ Qual:
 		sym->ctype.modifiers |= qual;
 		ctype = sym;
 	}
-	*true = cast_to(*true, ctype);
+	*true_expr = cast_to(*true_expr, ctype);
 	expr->cond_false = cast_to(expr->cond_false, ctype);
 	goto out;
 }
diff --git a/expand.c b/expand.c
index b965dc3..b7a7a67 100644
--- a/expand.c
+++ b/expand.c
@@ -508,27 +508,27 @@ static int expand_compare(struct expression *expr)
 static int expand_conditional(struct expression *expr)
 {
 	struct expression *cond = expr->conditional;
-	struct expression *true = expr->cond_true;
-	struct expression *false = expr->cond_false;
+	struct expression *true_expr = expr->cond_true;
+	struct expression *false_expr = expr->cond_false;
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
+			true_expr = false_expr;
+		if (!true_expr)
+			true_expr = cond;
+		cost = expand_expression(true_expr);
+		*expr = *true_expr;
 		expr->flags = flags;
 		if (expr->type == EXPR_VALUE)
 			expr->taint |= cond->taint;
 		return cost;
 	}
 
-	cost = expand_expression(true);
-	cost += expand_expression(false);
+	cost = expand_expression(true_expr);
+	cost += expand_expression(false_expr);
 
 	if (cost < SELECT_COST) {
 		expr->type = EXPR_SELECT;
diff --git a/flow.c b/flow.c
index 5bd9a1d..aafca03 100644
--- a/flow.c
+++ b/flow.c
@@ -100,7 +100,7 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		struct basic_block *source, *target;
 		pseudo_t pseudo;
 		struct instruction *br;
-		int true;
+		int true_value;
 
 		if (!def)
 			continue;
@@ -113,10 +113,10 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 			continue;
 		if (br->opcode != OP_BR)
 			continue;
-		true = pseudo_truth_value(pseudo);
-		if (true < 0)
+		true_value = pseudo_truth_value(pseudo);
+		if (true_value < 0)
 			continue;
-		target = true ? second->bb_true : second->bb_false;
+		target = true_value ? second->bb_true : second->bb_false;
 		if (bb_depends_on(target, bb))
 			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
@@ -165,7 +165,7 @@ static int simplify_phi_branch(struct basic_block *bb, struct instruction *br)
 }
 
 static int simplify_branch_branch(struct basic_block *bb, struct instruction *br,
-	struct basic_block **target_p, int true)
+	struct basic_block **target_p, int true_expr)
 {
 	struct basic_block *target = *target_p, *final;
 	struct instruction *insn;
@@ -181,7 +181,7 @@ static int simplify_branch_branch(struct basic_block *bb, struct instruction *br
 	 * Now we just need to see if we can rewrite the branch..
 	 */
 	retval = 0;
-	final = true ? insn->bb_true : insn->bb_false;
+	final = true_expr ? insn->bb_true : insn->bb_false;
 	if (bb_has_side_effects(target))
 		goto try_to_rewrite_target;
 	if (bb_depends_on(final, target))
@@ -823,13 +823,13 @@ static struct basic_block * rewrite_branch_bb(struct basic_block *bb, struct ins
 {
 	struct basic_block *parent;
 	struct basic_block *target = br->bb_true;
-	struct basic_block *false = br->bb_false;
+	struct basic_block *false_expr = br->bb_false;
 
-	if (target && false) {
+	if (target && false_expr) {
 		pseudo_t cond = br->cond;
 		if (cond->type != PSEUDO_VAL)
 			return NULL;
-		target = cond->value ? target : false;
+		target = cond->value ? target : false_expr;
 	}
 
 	/*
diff --git a/inline.c b/inline.c
index 860c0ee..8fa5a7a 100644
--- a/inline.c
+++ b/inline.c
@@ -162,14 +162,14 @@ static struct expression * copy_expression(struct expression *expr)
 	case EXPR_SELECT:
 	case EXPR_CONDITIONAL: {
 		struct expression *cond = copy_expression(expr->conditional);
-		struct expression *true = copy_expression(expr->cond_true);
-		struct expression *false = copy_expression(expr->cond_false);
-		if (cond == expr->conditional && true == expr->cond_true && false == expr->cond_false)
+		struct expression *true_expr = copy_expression(expr->cond_true);
+		struct expression *false_expr = copy_expression(expr->cond_false);
+		if (cond == expr->conditional && true_expr == expr->cond_true && false_expr == expr->cond_false)
 			break;
 		expr = dup_expression(expr);
 		expr->conditional = cond;
-		expr->cond_true = true;
-		expr->cond_false = false;
+		expr->cond_true = true_expr;
+		expr->cond_false = false_expr;
 		break;
 	}
 
@@ -353,20 +353,20 @@ static struct statement *copy_one_statement(struct statement *stmt)
 	}
 	case STMT_IF: {
 		struct expression *cond = stmt->if_conditional;
-		struct statement *true = stmt->if_true;
-		struct statement *false = stmt->if_false;
+		struct statement *true_expr = stmt->if_true;
+		struct statement *false_expr = stmt->if_false;
 
 		cond = copy_expression(cond);
-		true = copy_one_statement(true);
-		false = copy_one_statement(false);
+		true_expr = copy_one_statement(true_expr);
+		false_expr = copy_one_statement(false_expr);
 		if (stmt->if_conditional == cond &&
-		    stmt->if_true == true &&
-		    stmt->if_false == false)
+		    stmt->if_true == true_expr &&
+		    stmt->if_false == false_expr)
 			break;
 		stmt = dup_statement(stmt);
 		stmt->if_conditional = cond;
-		stmt->if_true = true;
-		stmt->if_false = false;
+		stmt->if_true = true_expr;
+		stmt->if_false = false_expr;
 		break;
 	}
 	case STMT_RETURN: {
diff --git a/linearize.c b/linearize.c
index f2034ce..94d5ea2 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1287,19 +1287,19 @@ pseudo_t linearize_cond_branch(struct entrypoint *ep, struct expression *expr, s
 
 static pseudo_t linearize_select(struct entrypoint *ep, struct expression *expr)
 {
-	pseudo_t cond, true, false, res;
+	pseudo_t cond, true_expr, false_expr, res;
 	struct instruction *insn;
 
-	true = linearize_expression(ep, expr->cond_true);
-	false = linearize_expression(ep, expr->cond_false);
+	true_expr = linearize_expression(ep, expr->cond_true);
+	false_expr = linearize_expression(ep, expr->cond_false);
 	cond = linearize_expression(ep, expr->conditional);
 
 	insn = alloc_typed_instruction(OP_SEL, expr->ctype);
 	if (!expr->cond_true)
-		true = cond;
+		true_expr = cond;
 	use_pseudo(insn, cond, &insn->src1);
-	use_pseudo(insn, true, &insn->src2);
-	use_pseudo(insn, false, &insn->src3);
+	use_pseudo(insn, true_expr, &insn->src2);
+	use_pseudo(insn, false_expr, &insn->src3);
 
 	res = alloc_pseudo(insn);
 	insn->target = res;
diff --git a/pre-process.c b/pre-process.c
index 656acaa..56ddcb6 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1236,13 +1236,13 @@ static int handle_strong_undef(struct stream *stream, struct token **line, struc
 	return do_handle_undef(stream, line, token, SYM_ATTR_STRONG);
 }
 
-static int preprocessor_if(struct stream *stream, struct token *token, int true)
+static int preprocessor_if(struct stream *stream, struct token *token, int condition_is_true)
 {
 	token_type(token) = false_nesting ? TOKEN_SKIP_GROUPS : TOKEN_IF;
 	free_preprocessor_line(token->next);
 	token->next = stream->top_if;
 	stream->top_if = token;
-	if (false_nesting || true != 1)
+	if (false_nesting || condition_is_true != 1)
 		false_nesting++;
 	return 0;
 }
diff --git a/show-parse.c b/show-parse.c
index c97debe..fb84bdc 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -1001,11 +1001,11 @@ static int show_label_expr(struct expression *expr)
 static int show_conditional_expr(struct expression *expr)
 {
 	int cond = show_expression(expr->conditional);
-	int true = show_expression(expr->cond_true);
-	int false = show_expression(expr->cond_false);
+	int true_expr = show_expression(expr->cond_true);
+	int false_expr = show_expression(expr->cond_false);
 	int new = new_pseudo();
 
-	printf("[v%d]\tcmov.%d\t\tv%d,v%d,v%d\n", cond, expr->ctype->bit_size, new, true, false);
+	printf("[v%d]\tcmov.%d\t\tv%d,v%d,v%d\n", cond, expr->ctype->bit_size, new, true_expr, false_expr);
 	return new;
 }
 
diff --git a/simplify.c b/simplify.c
index 8200584..68eeb45 100644
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
+		struct basic_block *true_expr = br->bb_true;
+		struct basic_block *false_expr = br->bb_false;
+		br->bb_false = true_expr;
+		br->bb_true = false_expr;
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
+					struct basic_block *true_expr = insn->bb_true;
+					struct basic_block *false_expr = insn->bb_false;
+					insn->bb_false = true_expr;
+					insn->bb_true = false_expr;
 				}
 				use_pseudo(insn, def->src1, &insn->cond);
 				remove_usage(cond, &insn->cond);
-- 
1.7.2.3


--=-QNCxE5A9XGayUpIR+y09--

