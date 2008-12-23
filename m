From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 10:59:22 +0100
Message-ID: <1230026362.3046.4.camel@johannes>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 <1229990125.11628.0.camel@johannes>
	 <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com>
	 <1229992670.11628.4.camel@johannes>
	 <70318cbf0812221725p583010d6u2c4cafb9d3215546@mail.gmail.com>
	 (sfid-20081223_022553_504158_8D960AA5)
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:34748 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbYLWJ7e (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 04:59:34 -0500
In-Reply-To: <70318cbf0812221725p583010d6u2c4cafb9d3215546@mail.gmail.com> (sfid-20081223_022553_504158_8D960AA5)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Alexey Zaytsev <alexey.zaytsev@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Mon, 2008-12-22 at 17:25 -0800, Christopher Li wrote:

> Do you want to resend your change which revert the context changes?
> Make it base on Josh's git's tree and I will merge your changes in my
> branch.

Below. Or I can give it to you in git if you prefer. I still think we
should redo this in some form so that annotations with different
contexts can work properly, but I don't have time to take care of it
right now.

> It will take me a while to get up to speed with the git goodness.
> I will start with merging Alexey's resend patches.

Mind you, he sent a few of my patches, so ignore those.

johannes

From ca95b62edf1600a2b55ed9ca0515d049807a84fc Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 23 Dec 2008 10:53:19 +0100
Subject: [PATCH] Revert context tracking code

---
 inline.c                       |   12 +-
 linearize.c                    |   31 ++-
 linearize.h                    |    7 +-
 parse.c                        |  134 +---------
 parse.h                        |    3 +-
 sparse.1                       |   41 +---
 sparse.c                       |  424 ++++---------------------------
 symbol.h                       |    3 +-
 validation/context-dynamic.c   |  171 -------------
 validation/context-named.c     |  553 ----------------------------------------
 validation/context-statement.c |   69 -----
 validation/context.c           |  114 +-------
 12 files changed, 107 insertions(+), 1455 deletions(-)
 delete mode 100644 validation/context-dynamic.c
 delete mode 100644 validation/context-named.c
 delete mode 100644 validation/context-statement.c

diff --git a/inline.c b/inline.c
index 09d176a..860c0ee 100644
--- a/inline.c
+++ b/inline.c
@@ -331,18 +331,10 @@ static struct statement *copy_one_statement(struct statement *stmt)
 	case STMT_CONTEXT:
 	case STMT_EXPRESSION: {
 		struct expression *expr = copy_expression(stmt->expression);
-		struct statement *newstmt;
 		if (expr == stmt->expression)
 			break;
-		newstmt = dup_statement(stmt);
-		newstmt->expression = expr;
-		if (stmt->required) {
-			expr = copy_expression(stmt->required);
-			if (expr == stmt->required)
-				break;
-			newstmt->required = expr;
-		}
-		stmt = newstmt;
+		stmt = dup_statement(stmt);
+		stmt->expression = expr;
 		break;
 	}
 	case STMT_RANGE: {
diff --git a/linearize.c b/linearize.c
index 526a710..1a19214 100644
--- a/linearize.c
+++ b/linearize.c
@@ -68,6 +68,7 @@ static struct entrypoint *alloc_entrypoint(void)
 static struct basic_block *alloc_basic_block(struct entrypoint *ep, struct position pos)
 {
 	struct basic_block *bb = __alloc_basic_block(0);
+	bb->context = -1;
 	bb->pos = pos;
 	bb->ep = ep;
 	return bb;
@@ -440,7 +441,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_CONTEXT:
-		buf += sprintf(buf, "%s%d,%d", "", insn->increment, insn->inc_false);
+		buf += sprintf(buf, "%s%d", insn->check ? "check: " : "", insn->increment);
 		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
@@ -1234,12 +1235,22 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 		FOR_EACH_PTR(ctype->contexts, context) {
 			int in = context->in;
 			int out = context->out;
-
-			if (out - in || context->out_false - in) {
+			int check = 0;
+			int context_diff;
+			if (in < 0) {
+				check = 1;
+				in = 0;
+			}
+			if (out < 0) {
+				check = 0;
+				out = 0;
+			}
+			context_diff = out - in;
+			if (check || context_diff) {
 				insn = alloc_instruction(OP_CONTEXT, 0);
-				insn->increment = out - in;
+				insn->increment = context_diff;
+				insn->check = check;
 				insn->context_expr = context->context;
-				insn->inc_false = context->out_false - in;
 				add_one_insn(ep, insn);
 			}
 		} END_FOR_EACH_PTR(context);
@@ -1674,16 +1685,6 @@ static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 		value = expr->value;
 
 	insn->increment = value;
-	insn->inc_false = value;
-
-	expr = stmt->required;
-	value = 0;
-
-	if (expr && expr->type == EXPR_VALUE)
-		value = expr->value;
-
-	insn->required = value;
-
 	insn->context_expr = stmt->context;
 	add_one_insn(ep, insn);
 	return VOID;
diff --git a/linearize.h b/linearize.h
index 0c5e4ef..2205082 100644
--- a/linearize.h
+++ b/linearize.h
@@ -117,7 +117,8 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment, required, inc_false;
+			int increment;
+			int check;
 			struct expression *context_expr;
 		};
 		struct /* asm */ {
@@ -220,13 +221,11 @@ enum opcode {
 
 struct basic_block_list;
 struct instruction_list;
-struct context_list_list;
 
 struct basic_block {
 	struct position pos;
 	unsigned long generation;
-	int context_check_recursion;
-	struct context_list_list *checked_contexts;
+	int context;
 	struct entrypoint *ep;
 	struct basic_block_list *parents; /* sources */
 	struct basic_block_list *children; /* destinations */
diff --git a/parse.c b/parse.c
index eb31871..a78012a 100644
--- a/parse.c
+++ b/parse.c
@@ -64,8 +64,6 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_conditional_context(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
 
@@ -184,14 +182,6 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
-static struct symbol_op conditional_context_op = {
-	.attribute = attribute_conditional_context,
-};
-
-static struct symbol_op exact_context_op = {
-	.attribute = attribute_exact_context,
-};
-
 static struct symbol_op transparent_union_op = {
 	.attribute = attribute_transparent_union,
 };
@@ -273,8 +263,6 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
-	{ "conditional_context",	NS_KEYWORD,	.op = &conditional_context_op },
-	{ "exact_context",	NS_KEYWORD,	.op = &exact_context_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
@@ -875,7 +863,7 @@ static struct token *attribute_mode(struct token *token, struct symbol *attr, st
 	return token;
 }
 
-static struct token *_attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype, int exact)
+static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	struct context *context = alloc_context();
 	struct expression *args[3];
@@ -889,8 +877,6 @@ static struct token *_attribute_context(struct token *token, struct symbol *attr
 			break;
 		if (argc < 3)
 			args[argc++] = expr;
-		else
-			argc++;
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -912,14 +898,8 @@ static struct token *_attribute_context(struct token *token, struct symbol *attr
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 		break;
-	default:
-		sparse_error(token->pos, "too many arguments to context attribute");
-		break;
 	}
 
-	context->exact = exact;
-	context->out_false = context->out;
-
 	if (argc)
 		add_ptr_list(&ctype->contexts, context);
 
@@ -927,61 +907,6 @@ static struct token *_attribute_context(struct token *token, struct symbol *attr
 	return token;
 }
 
-static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
-{
-	return _attribute_context(token, attr, ctype, 0);
-}
-
-static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype)
-{
-	return _attribute_context(token, attr, ctype, 1);
-}
-
-static struct token *attribute_conditional_context(struct token *token, struct symbol *attr, struct ctype *ctype)
-{
-	struct context *context = alloc_context();
-	struct expression *args[4];
-	int argc = 0;
-
-	token = expect(token, '(', "after conditional_context attribute");
-	while (!match_op(token, ')')) {
-		struct expression *expr = NULL;
-		token = conditional_expression(token, &expr);
-		if (!expr)
-			break;
-		if (argc < 4)
-			args[argc++] = expr;
-		else
-			argc++;
-		if (!match_op(token, ','))
-			break;
-		token = token->next;
-	}
-
-	switch(argc) {
-	case 3:
-		context->in = get_expression_value(args[0]);
-		context->out = get_expression_value(args[1]);
-		context->out_false = get_expression_value(args[2]);
-		break;
-	case 4:
-		context->context = args[0];
-		context->in = get_expression_value(args[1]);
-		context->out = get_expression_value(args[2]);
-		context->out_false = get_expression_value(args[3]);
-		break;
-	default:
-		sparse_error(token->pos, "invalid number of arguments to conditional_context attribute");
-		break;
-	}
-
-	if (argc)
-		add_ptr_list(&ctype->contexts, context);
-
-	token = expect(token, ')', "after conditional_context attribute");
-	return token;
-}
-
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	if (Wtransparent_union)
@@ -1813,56 +1738,17 @@ static struct token *parse_goto_statement(struct token *token, struct statement
 
 static struct token *parse_context_statement(struct token *token, struct statement *stmt)
 {
-	struct expression *args[3];
-	int argc = 0;
-
 	stmt->type = STMT_CONTEXT;
-	token = token->next;
-	token = expect(token, '(', "after __context__ statement");
-	while (!match_op(token, ')')) {
-		struct expression *expr = NULL;
-		token = conditional_expression(token, &expr);
-		if (!expr)
-			break;
-		if (argc < 3)
-			args[argc++] = expr;
-		else
-			argc++;
-		if (!match_op(token, ','))
-			break;
-		token = token->next;
-	}
-
-	stmt->expression = args[0];
-	stmt->context = NULL;
-
-	switch (argc) {
-	case 0:
-		sparse_error(token->pos, "__context__ statement needs argument(s)");
-		return token;
-	case 1:
-		/* already done */
-		break;
-	case 2:
-		if (args[0]->type != STMT_EXPRESSION) {
-			stmt->context = args[0];
-			stmt->expression = args[1];
-		} else {
-			stmt->expression = args[0];
-			stmt->required = args[1];
-		}
-		break;
-	case 3:
-		stmt->context = args[0];
-		stmt->expression = args[1];
-		stmt->required = args[2];
-		break;
-	default:
-		sparse_error(token->pos, "too many arguments for __context__ statement");
-		return token->next;
+	token = parse_expression(token->next, &stmt->expression);
+	if(stmt->expression->type == EXPR_PREOP
+	   && stmt->expression->op == '('
+	   && stmt->expression->unop->type == EXPR_COMMA) {
+		struct expression *expr;
+		expr = stmt->expression->unop;
+		stmt->context = expr->left;
+		stmt->expression = expr->right;
 	}
-
-	return expect(token, ')', "at end of __context__");
+	return expect(token, ';', "at end of statement");
 }
 
 static struct token *parse_range_statement(struct token *token, struct statement *stmt)
diff --git a/parse.h b/parse.h
index a2b9aa3..609910f 100644
--- a/parse.h
+++ b/parse.h
@@ -39,10 +39,9 @@ struct statement {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
-		struct { /* __context__ */
+		struct {
 			struct expression *expression;
 			struct expression *context;
-			struct expression *required;
 		};
 		struct /* return_statement */ {
 			struct expression *ret_value;
diff --git a/sparse.1 b/sparse.1
index 92a1cae..c44e3a5 100644
--- a/sparse.1
+++ b/sparse.1
@@ -73,43 +73,20 @@ Warn about potential errors in synchronization or other delimited contexts.
 Sparse supports several means of designating functions or statements that
 delimit contexts, such as synchronization.  Functions with the extended
 attribute
-.BI __attribute__((context( [expression ,] in_context , out_context ))
-require the context \fIexpression\fR (for instance, a lock) to have at least the value
+.BI __attribute__((context( expression , in_context , out_context ))
+require the context \fIexpression\fR (for instance, a lock) to have the value
 \fIin_context\fR (a constant nonnegative integer) when called, and return with
-the value adjusted by \fIout_context - in_context\fR (where
-\fIout_context\fR is a constant nonnegative integer).  To change the value
-of a context (for example in macros), use the statement
-.BI __context__( [expression , ]adjust_value[ , required] )
-where \fIadjust_value\fR is a constant integer and \fIrequired\fR is a
-constant nonnegative integer. Not giving \fIrequired\fR is equivalent to
-giving zero and means that the statement does not need the context as a
-precondition, when given it means that the context must at least have the
-value of \fIrequired\fR.
-
-To indicate that a function requires
-.BI exactly
-a certain lock context (not "at least" as above), use the form
-.BI __attribute__((exact_context( [expression ,] in_context , out_context ))
-There currently is no corresponding
-.BI __exact_context__( [expression , ]adjust_value[ , required] )
-statement.
-
-To indicate that a certain function acquires a context depending on its
-return value, use
-.BI __attribute__((conditional_context( [expression ,] in_context , out_success , out_failure ))
-where \fIout_success\fR and \fIout_failure\fR indicate the context change
-done depending on success (non-zero) or failure (zero) return of the
-function. Note that currently, using this attribute on a function means that
-the function itself won't be checked for context handling at all. See the
-testsuite for examples.
-
-Sparse will warn when it sees a function change a
-context without indicating this with a \fBcontext\fR or \fBexact_context\fR attribute, either by
+the value \fIout_context\fR (a constant nonnegative integer).  For APIs
+defined via macros, use the statement form
+.BI __context__( expression , in_value , out_value )
+in the body of the macro.
+
+With \fB-Wcontext\fR Sparse will warn when it sees a function change the
+context without indicating this with a \fBcontext\fR attribute, either by
 decreasing a context below zero (such as by releasing a lock without acquiring
 it), or returning with a changed context (such as by acquiring a lock without
 releasing it).  Sparse will also warn about blocks of code which may
-potentially execute with different contexts and about functions that are
-executed without a lock they require.
+potentially execute with different contexts.
 
 Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-context\fR.
diff --git a/sparse.c b/sparse.c
index 785a6f6..4026ba7 100644
--- a/sparse.c
+++ b/sparse.c
@@ -24,389 +24,77 @@
 #include "expression.h"
 #include "linearize.h"
 
-struct context_check {
-	int val, val_false;
-	char name[32];
-};
-
-DECLARE_ALLOCATOR(context_check);
-DECLARE_PTR_LIST(context_check_list, struct context_check);
-DECLARE_PTR_LIST(context_list_list, struct context_check_list);
-ALLOCATOR(context_check, "context check list");
-
-static const char *unnamed_context = "<unnamed>";
-
-static const char *context_name(struct context *context)
-{
-	if (context->context && context->context->symbol_name)
-		return show_ident(context->context->symbol_name);
-	return unnamed_context;
-}
-
-static void context_add(struct context_check_list **ccl, const char *name,
-			int offs, int offs_false)
-{
-	struct context_check *check, *found = NULL;
-
-	FOR_EACH_PTR(*ccl, check) {
-		if (strcmp(name, check->name))
-			continue;
-		found = check;
-		break;
-	} END_FOR_EACH_PTR(check);
-
-	if (!found) {
-		found = __alloc_context_check(0);
-		strncpy(found->name, name, sizeof(found->name));
-		found->name[sizeof(found->name) - 1] = '\0';
-		add_ptr_list(ccl, found);
-	}
-	found->val += offs;
-	found->val_false += offs_false;
-}
-
-static int context_list_has(struct context_check_list *ccl,
-			    struct context_check *c)
+static int context_increase(struct basic_block *bb, int entry)
 {
-	struct context_check *check;
+	int sum = 0;
+	struct instruction *insn;
 
-	FOR_EACH_PTR(ccl, check) {
-		if (strcmp(c->name, check->name))
+	FOR_EACH_PTR(bb->insns, insn) {
+		int val;
+		if (insn->opcode != OP_CONTEXT)
 			continue;
-		return check->val == c->val &&
-		       check->val_false == c->val_false;
-	} END_FOR_EACH_PTR(check);
-
-	/* not found is equal to 0 */
-	return c->val == 0 && c->val_false == 0;
-}
-
-static int context_lists_equal(struct context_check_list *ccl1,
-			       struct context_check_list *ccl2)
-{
-	struct context_check *check;
-
-	/* can be optimised... */
-
-	FOR_EACH_PTR(ccl1, check) {
-		if (!context_list_has(ccl2, check))
-			return 0;
-	} END_FOR_EACH_PTR(check);
-
-	FOR_EACH_PTR(ccl2, check) {
-		if (!context_list_has(ccl1, check))
-			return 0;
-	} END_FOR_EACH_PTR(check);
-
-	return 1;
-}
-
-static struct context_check_list *checked_copy(struct context_check_list *ccl)
-{
-	struct context_check_list *result = NULL;
-	struct context_check *c;
-
-	FOR_EACH_PTR(ccl, c) {
-		context_add(&result, c->name, c->val_false, c->val_false);
-	} END_FOR_EACH_PTR(c);
-
-	return result;
-}
-
-#define IMBALANCE_IN "context imbalance in '%s': "
-#define DEFAULT_CONTEXT_DESCR "   default context: "
-
-static void get_context_string(char **buf, const char **name)
-{
-	if (strcmp(*name, unnamed_context)) {
-		*buf = malloc(strlen(*name) + 16);
-		sprintf(*buf, "   context '%s': ", *name);
-		*name = *buf;
-	} else {
-		*name = DEFAULT_CONTEXT_DESCR;
-		*buf = NULL;
-	}
-}
-
-static int context_list_check(struct entrypoint *ep, struct position pos,
-			      struct context_check_list *ccl_cur,
-			      struct context_check_list *ccl_target)
-{
-	struct context_check *c1, *c2;
-	int cur, tgt;
-	const char *name;
-	char *buf;
-
-	/* make sure the loop below checks all */
-	FOR_EACH_PTR(ccl_target, c1) {
-		context_add(&ccl_cur, c1->name, 0, 0);
-	} END_FOR_EACH_PTR(c1);
-
-	FOR_EACH_PTR(ccl_cur, c1) {
-		cur = c1->val;
-		tgt = 0;
-
-		FOR_EACH_PTR(ccl_target, c2) {
-			if (strcmp(c2->name, c1->name))
+		val = insn->increment;
+		if (insn->check) {
+			int current = sum + entry;
+			if (!val) {
+				if (!current)
+					continue;
+			} else if (current >= val)
 				continue;
-			tgt = c2->val;
-			break;
-		} END_FOR_EACH_PTR(c2);
-
-		if (cur == tgt || !Wcontext)
+			warning(insn->pos, "context check failure");
 			continue;
-
-		if (cur > tgt)
-			warning(pos, IMBALANCE_IN "wrong count at exit",
-				show_ident(ep->name->ident));
-		else if (cur < tgt)
-			warning(pos, IMBALANCE_IN "unexpected unlock",
-				show_ident(ep->name->ident));
-
-		name = c1->name;
-		get_context_string(&buf, &name);
-
-		info(pos, "%swanted %d, got %d",
-		     name, tgt, cur);
-
-		free(buf);
-
-		return -1;
-	} END_FOR_EACH_PTR(c1);
-
-	return 0;
-}
-
-static int handle_call(struct entrypoint *ep, struct basic_block *bb,
-		       struct instruction *insn,
-		       struct context_check_list *combined)
-{
-	struct context *ctx;
-	struct context_check *c;
-	const char *name, *call, *cmp;
-	char *buf;
-	int val, ok;
-
-	if (!insn->func || !insn->func->sym ||
-	    insn->func->type != PSEUDO_SYM)
-		return 0;
-
-	/*
-	 * Check all contexts the function wants.
-	 */
-	FOR_EACH_PTR(insn->func->sym->ctype.contexts, ctx) {
-		name = context_name(ctx);
-		val = 0;
-
-		FOR_EACH_PTR(combined, c) {
-			if (strcmp(c->name, name) == 0) {
-				val = c->val;
-				break;
-			}
-		} END_FOR_EACH_PTR(c);
-
-		if (ctx->exact) {
-			ok = ctx->in == val;
-			cmp = "";
-		} else {
-			ok = ctx->in <= val;
-			cmp = ">= ";
-		}
-
-		if (!ok && Wcontext) {
-			get_context_string(&buf, &name);
-			call = strdup(show_ident(insn->func->ident));
-
-			warning(insn->pos, "context problem in '%s': "
-				"'%s' expected different context",
-				show_ident(ep->name->ident), call);
-
-			info(insn->pos, "%swanted %s%d, got %d",
-			     name, cmp, ctx->in, val);
-
-			free((void *)call);
-			free(buf);
-
-			return -1;
 		}
-	} END_FOR_EACH_PTR (ctx);
-
-	return 0;
+		sum += val;
+	} END_FOR_EACH_PTR(insn);
+	return sum;
 }
 
-static int handle_context(struct entrypoint *ep, struct basic_block *bb,
-			  struct instruction *insn,
-			  struct context_check_list **combined)
+static int imbalance(struct entrypoint *ep, struct basic_block *bb, int entry, int exit, const char *why)
 {
-	struct context_check *c;
-	const char *name;
-	char *buf;
-	int val, ok;
-
-	val = 0;
-
-	name = unnamed_context;
-	if (insn->context_expr)
-		name = show_ident(insn->context_expr->symbol_name);
-
-	FOR_EACH_PTR(*combined, c) {
-		if (strcmp(c->name, name) == 0) {
-			val = c->val;
-			break;
-		}
-	} END_FOR_EACH_PTR(c);
-
-	ok = insn->required <= val;
-
-	if (!ok && Wcontext) {
-		get_context_string(&buf, &name);
-
-		warning(insn->pos,
-			IMBALANCE_IN
-			"__context__ statement expected different context",
-			show_ident(ep->name->ident));
-
-		info(insn->pos, "%swanted >= %d, got %d",
-		     name, insn->required, val);
-
-		free(buf);
-		return -1;
+	if (Wcontext) {
+		struct symbol *sym = ep->name;
+		warning(bb->pos, "context imbalance in '%s' - %s", show_ident(sym->ident), why);
 	}
-
-	context_add(combined, name, insn->increment, insn->inc_false);
-
-	return 0;
+	return -1;
 }
 
-static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
-			    struct context_check_list *ccl_in,
-			    struct context_check_list *ccl_target,
-			    int in_false)
+static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int entry, int exit);
+
+static int check_children(struct entrypoint *ep, struct basic_block *bb, int entry, int exit)
 {
-	struct context_check_list *combined = NULL, *done;
-	struct context_check *c;
 	struct instruction *insn;
-	struct multijmp *mj;
-	int err = -1;
-
-	/*
-	 * Recurse in once to catch bad loops.
-	 */
-	if (bb->context_check_recursion > 1)
-		return 0;
-	bb->context_check_recursion++;
-
-	/*
-	 * Abort if we have already checked this block out of the same context.
-	 */
-	FOR_EACH_PTR(bb->checked_contexts, done) {
-		if (context_lists_equal(done, ccl_in))
-			return 0;
-	} END_FOR_EACH_PTR(done);
-
-	/*
-	 * We're starting with a completely new local list of contexts, so
-	 * initialise it according to what we got from the parent block.
-	 * That may use either the 'false' or the 'true' part of the context
-	 * for the conditional_context() attribute.
-	 */
-	FOR_EACH_PTR(ccl_in, c) {
-		if (in_false)
-			context_add(&combined, c->name, c->val_false, c->val_false);
-		else
-			context_add(&combined, c->name, c->val, c->val);
-	} END_FOR_EACH_PTR(c);
-
-	/* Add the new context to the list of already-checked contexts */
-	done = checked_copy(combined);
-	add_ptr_list(&bb->checked_contexts, done);
-
-	/*
-	 * Now walk the instructions for this block, recursing into any
-	 * instructions that have children. We need to have the right
-	 * order so we cannot iterate bb->children instead.
-	 */
-	FOR_EACH_PTR(bb->insns, insn) {
-		switch (insn->opcode) {
-		case OP_INLINED_CALL:
-		case OP_CALL:
-			if (handle_call(ep, bb, insn, combined))
-				goto out;
-			break;
-		case OP_CONTEXT:
-			if (handle_context(ep, bb, insn, &combined))
-				goto out;
-			break;
-		case OP_BR:
-			if (insn->bb_true)
-				if (check_bb_context(ep, insn->bb_true,
-						     combined, ccl_target, 0))
-					goto out;
-			if (insn->bb_false)
-				if (check_bb_context(ep, insn->bb_false,
-						     combined, ccl_target, 1))
-					goto out;
-			break;
-		case OP_SWITCH:
-		case OP_COMPUTEDGOTO:
-			FOR_EACH_PTR(insn->multijmp_list, mj) {
-				if (check_bb_context(ep, mj->target,
-					             combined, ccl_target, 0))
-					goto out;
-			} END_FOR_EACH_PTR(mj);
-			break;
-		}
-	} END_FOR_EACH_PTR(insn);
+	struct basic_block *child;
 
 	insn = last_instruction(bb->insns);
 	if (!insn)
-		goto out_good;
-
-	if (insn->opcode == OP_RET) {
-		err = context_list_check(ep, insn->pos, combined, ccl_target);
-		goto out;
-	}
+		return 0;
+	if (insn->opcode == OP_RET)
+		return entry != exit ? imbalance(ep, bb, entry, exit, "wrong count at exit") : 0;
 
- out_good:
-	err = 0;
- out:
-	/* contents will be freed once we return out of recursion */
-	free_ptr_list(&combined);
-	bb->context_check_recursion--;
-	return err;
+	FOR_EACH_PTR(bb->children, child) {
+		if (check_bb_context(ep, child, entry, exit))
+			return -1;
+	} END_FOR_EACH_PTR(child);
+	return 0;
 }
 
-static void free_bb_context_lists(struct basic_block *bb)
+static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int entry, int exit)
 {
-	struct context_check_list *done;
-	struct instruction *insn;
-	struct multijmp *mj;
-
-	if (!bb->checked_contexts)
-		return;
+	if (!bb)
+		return 0;
+	if (bb->context == entry)
+		return 0;
 
-	FOR_EACH_PTR(bb->checked_contexts, done) {
-		free_ptr_list(&done);
-	} END_FOR_EACH_PTR(done);
+	/* Now that's not good.. */
+	if (bb->context >= 0)
+		return imbalance(ep, bb, entry, bb->context, "different lock contexts for basic block");
 
-	free_ptr_list(&bb->checked_contexts);
+	bb->context = entry;
+	entry += context_increase(bb, entry);
+	if (entry < 0)
+		return imbalance(ep, bb, entry, exit, "unexpected unlock");
 
-	FOR_EACH_PTR(bb->insns, insn) {
-		switch (insn->opcode) {
-		case OP_BR:
-			if (insn->bb_true)
-				free_bb_context_lists(insn->bb_true);
-			if (insn->bb_false)
-				free_bb_context_lists(insn->bb_false);
-			break;
-		case OP_SWITCH:
-		case OP_COMPUTEDGOTO:
-			FOR_EACH_PTR(insn->multijmp_list, mj) {
-				free_bb_context_lists(mj->target);
-			} END_FOR_EACH_PTR(mj);
-			break;
-		}
-	} END_FOR_EACH_PTR(insn);
+	return check_children(ep, bb, entry, exit);
 }
 
 static void check_cast_instruction(struct instruction *insn)
@@ -547,7 +235,7 @@ static void check_context(struct entrypoint *ep)
 {
 	struct symbol *sym = ep->name;
 	struct context *context;
-	struct context_check_list *ccl_in = NULL, *ccl_target = NULL;
+	unsigned int in_context = 0, out_context = 0;
 
 	if (Wuninitialized && verbose && ep->entry->bb->needs) {
 		pseudo_t pseudo;
@@ -561,20 +249,10 @@ static void check_context(struct entrypoint *ep)
 	check_instructions(ep);
 
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		const char *name = context_name(context);
-
-		context_add(&ccl_in, name, context->in, context->in);
-		context_add(&ccl_target, name, context->out, context->out_false);
-		/* we don't currently check the body of trylock functions */
-		if (context->out != context->out_false)
-			return;
+		in_context += context->in;
+		out_context += context->out;
 	} END_FOR_EACH_PTR(context);
-
-	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target, 0);
-	free_ptr_list(&ccl_in);
-	free_ptr_list(&ccl_target);
-	free_bb_context_lists(ep->entry->bb);
-	clear_context_check_alloc();
+	check_bb_context(ep, ep->entry->bb, in_context, out_context);
 }
 
 static void check_symbols(struct symbol_list *list)
diff --git a/symbol.h b/symbol.h
index c4d7f28..4155b46 100644
--- a/symbol.h
+++ b/symbol.h
@@ -71,8 +71,7 @@ enum keyword {
 
 struct context {
 	struct expression *context;
-	unsigned int in, out, out_false;
-	int exact;
+	unsigned int in, out;
 };
 
 extern struct context *alloc_context(void);
diff --git a/validation/context-dynamic.c b/validation/context-dynamic.c
deleted file mode 100644
index 5e172f0..0000000
--- a/validation/context-dynamic.c
+++ /dev/null
@@ -1,171 +0,0 @@
-static void a(void) __attribute__ ((context(A, 0, 1)))
-{
-    __context__(A, 1);
-}
-
-static void r(void) __attribute__ ((context(A, 1, 0)))
-{
-    __context__(A, -1);
-}
-
-extern int condition, condition2;
-
-static int tl(void) __attribute__ ((conditional_context(A, 0, 1, 0)))
-{
-    if (condition) {
-        a();
-        return 1;
-    }
-    return 0;
-}
-
-static int tl2(void) __attribute__ ((conditional_context(A, 0, 0, 1)))
-{
-    if (condition) {
-        a();
-        return 1;
-    }
-    return 0;
-}
-
-static int dummy(void)
-{
-    return condition + condition2;
-}
-
-static int good_trylock1(void)
-{
-    if (tl()) {
-        r();
-    }
-}
-
-static int good_trylock2(void)
-{
-    if (tl()) {
-        r();
-    }
-
-    if (tl()) {
-        r();
-    }
-}
-static int good_trylock3(void)
-{
-    a();
-    if (tl()) {
-        r();
-    }
-    r();
-    if (tl()) {
-        r();
-    }
-}
-
-static int good_trylock4(void)
-{
-    a();
-    if (tl()) {
-        r();
-    }
-    if (tl()) {
-        r();
-    }
-    r();
-}
-
-static void bad_trylock1(void)
-{
-    a();
-    if (dummy()) {
-        r();
-    }
-    r();
-}
-
-static int good_trylock5(void)
-{
-    if (!tl2()) {
-        r();
-    }
-}
-
-static int good_trylock6(void)
-{
-    if (!tl2()) {
-        r();
-    }
-
-    if (!tl2()) {
-        r();
-    }
-}
-static int good_trylock7(void)
-{
-    a();
-    if (!tl2()) {
-        r();
-    }
-    r();
-    if (!tl2()) {
-        r();
-    }
-}
-
-static int good_trylock8(void)
-{
-    a();
-    if (!tl2()) {
-        r();
-    }
-    if (!tl2()) {
-        r();
-    }
-    r();
-}
-
-static void bad_trylock2(void)
-{
-    a();
-    if (!dummy()) {
-        r();
-    }
-    r();
-}
-
-static int good_switch(void)
-{
-    switch (condition) {
-    case 1:
-        a();
-        break;
-    case 2:
-        a();
-        break;
-    case 3:
-        a();
-        break;
-    default:
-        a();
-    }
-    r();
-}
-
-static void bad_lock1(void)
-{
-    r();
-    a();
-}
-
-/*
- * check-name: Check -Wcontext with lock trylocks
- *
- * check-error-start
-context-dynamic.c:83:6: warning: context problem in 'bad_trylock1': 'r' expected different context
-context-dynamic.c:83:6:    context 'A': wanted >= 1, got 0
-context-dynamic.c:133:6: warning: context problem in 'bad_trylock2': 'r' expected different context
-context-dynamic.c:133:6:    context 'A': wanted >= 1, got 0
-context-dynamic.c:156:6: warning: context problem in 'bad_lock1': 'r' expected different context
-context-dynamic.c:156:6:    context 'A': wanted >= 1, got 0
- * check-error-end
- */
diff --git a/validation/context-named.c b/validation/context-named.c
deleted file mode 100644
index 58310e9..0000000
--- a/validation/context-named.c
+++ /dev/null
@@ -1,553 +0,0 @@
-static void a(void) __attribute__((context(TEST,0,1)))
-{
-	__context__(TEST,1);
-}
-
-static void r(void) __attribute__((context(TEST,1,0)))
-{
-	__context__(TEST,-1,1);
-}
-
-static void a2(void) __attribute__((context(TEST2,0,1)))
-{
-	__context__(TEST2,1);
-}
-
-static void r2(void) __attribute__((context(TEST2,1,0)))
-{
-	__context__(TEST2,-1,1);
-}
-
-#define check_test2() __context__(TEST2,0,1)
-
-static void good_paired1(void)
-{
-	a();
-	a2();
-	r();
-	r2();
-}
-
-static void good_paired2(void)
-{
-	a();
-	r();
-	a();
-	r();
-	a2();
-	r2();
-}
-
-static void good_paired3(void)
-{
-	a();
-	a();
-	r();
-	r();
-	a2();
-	a2();
-	r2();
-	r2();
-}
-
-static void good_lock1(void) __attribute__((context(TEST,0,1)))
-{
-	a();
-}
-
-static void good_lock2(void) __attribute__((context(TEST,0,1)))
-{
-	a();
-	r();
-	a();
-}
-
-static void good_lock3(void) __attribute__((context(TEST,0,1)))
-{
-	a();
-	a();
-	r();
-}
-
-static void good_unlock1(void) __attribute__((context(TEST,1,0)))
-{
-	r();
-}
-
-static void good_unlock2(void) __attribute__((context(TEST,1,0)))
-{
-	a();
-	r();
-	r();
-}
-
-static void warn_lock1(void)
-{
-	a();
-}
-
-static void warn_lock2(void)
-{
-	a();
-	r();
-	a();
-}
-
-static void warn_lock3(void)
-{
-	a();
-	a();
-	r();
-}
-
-static void warn_unlock1(void)
-{
-	r();
-}
-
-static void warn_unlock2(void)
-{
-	a();
-	r();
-	r();
-}
-
-extern int condition, condition2;
-
-static int good_if1(void)
-{
-	a();
-	if(condition) {
-		r();
-		return -1;
-	}
-	r();
-	return 0;
-}
-
-static void good_if2(void)
-{
-	if(condition) {
-		a();
-		r();
-	}
-}
-
-static void good_if3(void)
-{
-	a();
-	if(condition) {
-		a();
-		r();
-	}
-	r();
-}
-
-static int warn_if1(void)
-{
-	a();
-	if(condition)
-		return -1;
-	r();
-	return 0;
-}
-
-static int warn_if2(void)
-{
-	a();
-	if(condition) {
-		r();
-		return -1;
-	}
-	return 0;
-}
-
-static void good_while1(void)
-{
-	a();
-	while(condition)
-		;
-	r();
-}
-
-static void good_while2(void)
-{
-	while(condition) {
-		a();
-		r();
-	}
-}
-
-static void good_while3(void)
-{
-	while(condition) {
-		a();
-		r();
-		if(condition2)
-			break;
-		a();
-		r();
-	}
-}
-
-static void good_while4(void)
-{
-	a();
-	while(1) {
-		if(condition2) {
-			r();
-			break;
-		}
-	}
-}
-
-static void good_while5(void)
-{
-	a();
-	while(1) {
-		r();
-		if(condition2)
-			break;
-		a();
-	}
-}
-
-static void warn_while1(void)
-{
-	while(condition) {
-		a();
-	}
-}
-
-static void warn_while2(void)
-{
-	while(condition) {
-		r();
-	}
-}
-
-static void warn_while3(void)
-{
-	while(condition) {
-		a();
-		if(condition2)
-			break;
-		r();
-	}
-}
-
-static void good_goto1(void)
-{
-    a();
-    goto label;
-label:
-    r();
-}
-
-static void good_goto2(void)
-{
-    a();
-    goto label;
-    a();
-    r();
-label:
-    r();
-}
-
-static void good_goto3(void)
-{
-    a();
-    if(condition)
-        goto label;
-    a();
-    r();
-label:
-    r();
-}
-
-static void good_goto4(void)
-{
-    if(condition)
-        goto label;
-    a();
-    r();
-label:
-    ;
-}
-
-static void good_goto5(void)
-{
-    a();
-    if(condition)
-        goto label;
-    r();
-    return;
-label:
-    r();
-}
-
-static void warn_goto1(void)
-{
-    a();
-    goto label;
-    r();
-label:
-    ;
-}
-
-static void warn_goto2(void)
-{
-    a();
-    goto label;
-    r();
-label:
-    a();
-    r();
-}
-
-static void warn_goto3(void)
-{
-    a();
-    if(condition)
-        goto label;
-    r();
-label:
-    r();
-}
-
-static void warn_multiple1(void)
-{
-    a();
-    a2();
-}
-
-static void warn_multiple2(void)
-{
-    a2();
-    a();
-}
-
-static void warn_mixed1(void)
-{
-    a2();
-    r();
-}
-
-static void warn_mixed2(void)
-{
-    a2();
-    if (condition) {
-        a();
-        r2();
-    }
-    r();
-}
-
-static void warn_mixed3(void)
-{
-    a2();
-    if (condition) {
-        r2();
-        return;
-    }
-    r();
-}
-
-static void warn_mixed4(void)
-{
-    a2();
-    if (condition) {
-        a();
-        r();
-        return;
-    }
-    r();
-}
-
-static void good_mixed1(void)
-{
-    if (condition) {
-        a();
-        r();
-    } else {
-        a2();
-        r2();
-    }
-}
-
-static void good_mixed2(void)
-{
-    if (condition) {
-        a();
-        r();
-    }
-    a2();
-    r2();
-}
-
-static int need_lock(void) __attribute__((context(TEST,1,1)))
-{
-}
-
-static void need_lock_exact(void) __attribute__((exact_context(TEST,1,1)))
-{
-}
-
-static void need_lock2(void) __attribute__((context(TEST,1,1)))
-{
-    need_lock();
-}
-
-static void good_fn(void)
-{
-    a();
-    need_lock();
-    r();
-}
-
-static void good_fn2(void)
-{
-    a();
-    a();
-    need_lock();
-    r();
-    r();
-}
-
-static void good_fn2(void)
-{
-    a();
-    if (condition)
-        need_lock();
-    r();
-}
-
-static void good_fn3(void) __attribute__((context(TEST,1,1)))
-{
-    if (condition)
-        need_lock2();
-}
-
-static void warn_fn(void)
-{
-    a2();
-    need_lock();
-    r2();
-}
-
-static void warn_fn2(void)
-{
-    a2();
-    need_lock2();
-    r2();
-}
-
-static void good_exact_fn(void)
-{
-    a();
-    need_lock_exact();
-    r();
-}
-
-static void warn_exact_fn1(void)
-{
-    a();
-    a();
-    need_lock_exact();
-    r();
-    r();
-}
-
-static void warn_exact_fn2(void)
-{
-    a2();
-    need_lock_exact();
-    r2();
-}
-
-static inline void need_lock3(void) __attribute__((context(TEST,1,1)))
-{
-}
-
-static void warn_fn3(void)
-{
-    a2();
-    need_lock3();
-    r2();
-}
-
-#define __acquire(x)	__context__(x,1)
-#define __release(x)	__context__(x,-1)
-
-#define rl() \
-  do { __acquire(RCU); } while (0)
-
-#define ru() \
-  do { __release(RCU); } while (0)
-
-static void good_mixed_with_if(void)
-{
-    rl();
-
-    if (condition) {
-        a();
-        r();
-    }
-
-    ru();
-}
-
-/*
- * check-name: Check -Wcontext with lock names
- *
- * check-error-start
-context-named.c:86:3: warning: context imbalance in 'warn_lock1': wrong count at exit
-context-named.c:86:3:    context 'TEST': wanted 0, got 1
-context-named.c:93:3: warning: context imbalance in 'warn_lock2': wrong count at exit
-context-named.c:93:3:    context 'TEST': wanted 0, got 1
-context-named.c:100:3: warning: context imbalance in 'warn_lock3': wrong count at exit
-context-named.c:100:3:    context 'TEST': wanted 0, got 1
-context-named.c:105:3: warning: context problem in 'warn_unlock1': 'r' expected different context
-context-named.c:105:3:    context 'TEST': wanted >= 1, got 0
-context-named.c:112:3: warning: context problem in 'warn_unlock2': 'r' expected different context
-context-named.c:112:3:    context 'TEST': wanted >= 1, got 0
-context-named.c:152:9: warning: context imbalance in 'warn_if1': wrong count at exit
-context-named.c:152:9:    context 'TEST': wanted 0, got 1
-context-named.c:162:9: warning: context imbalance in 'warn_if2': wrong count at exit
-context-named.c:162:9:    context 'TEST': wanted 0, got 1
-context-named.c:218:4: warning: context imbalance in 'warn_while1': wrong count at exit
-context-named.c:218:4:    context 'TEST': wanted 0, got 1
-context-named.c:225:4: warning: context problem in 'warn_while2': 'r' expected different context
-context-named.c:225:4:    context 'TEST': wanted >= 1, got 0
-context-named.c:235:4: warning: context imbalance in 'warn_while3': wrong count at exit
-context-named.c:235:4:    context 'TEST': wanted 0, got 1
-context-named.c:295:5: warning: context imbalance in 'warn_goto1': wrong count at exit
-context-named.c:295:5:    context 'TEST': wanted 0, got 1
-context-named.c:305:6: warning: context imbalance in 'warn_goto2': wrong count at exit
-context-named.c:305:6:    context 'TEST': wanted 0, got 1
-context-named.c:315:6: warning: context problem in 'warn_goto3': 'r' expected different context
-context-named.c:315:6:    context 'TEST': wanted >= 1, got 0
-context-named.c:321:7: warning: context imbalance in 'warn_multiple1': wrong count at exit
-context-named.c:321:7:    context 'TEST': wanted 0, got 1
-context-named.c:327:6: warning: context imbalance in 'warn_multiple2': wrong count at exit
-context-named.c:327:6:    context 'TEST2': wanted 0, got 1
-context-named.c:333:6: warning: context problem in 'warn_mixed1': 'r' expected different context
-context-named.c:333:6:    context 'TEST': wanted >= 1, got 0
-context-named.c:343:6: warning: context problem in 'warn_mixed2': 'r' expected different context
-context-named.c:343:6:    context 'TEST': wanted >= 1, got 0
-context-named.c:353:6: warning: context problem in 'warn_mixed3': 'r' expected different context
-context-named.c:353:6:    context 'TEST': wanted >= 1, got 0
-context-named.c:364:6: warning: context imbalance in 'warn_mixed4': wrong count at exit
-context-named.c:364:6:    context 'TEST2': wanted 0, got 1
-context-named.c:434:14: warning: context problem in 'warn_fn': 'need_lock' expected different context
-context-named.c:434:14:    context 'TEST': wanted >= 1, got 0
-context-named.c:441:15: warning: context problem in 'warn_fn2': 'need_lock2' expected different context
-context-named.c:441:15:    context 'TEST': wanted >= 1, got 0
-context-named.c:456:20: warning: context problem in 'warn_exact_fn1': 'need_lock_exact' expected different context
-context-named.c:456:20:    context 'TEST': wanted 1, got 2
-context-named.c:464:20: warning: context problem in 'warn_exact_fn2': 'need_lock_exact' expected different context
-context-named.c:464:20:    context 'TEST': wanted 1, got 0
-context-named.c:475:15: warning: context problem in 'warn_fn3': 'need_lock3' expected different context
-context-named.c:475:15:    context 'TEST': wanted >= 1, got 0
- * check-error-end
- */
diff --git a/validation/context-statement.c b/validation/context-statement.c
deleted file mode 100644
index fd79a6a..0000000
--- a/validation/context-statement.c
+++ /dev/null
@@ -1,69 +0,0 @@
-#define a() __context__(LOCK, 1)
-#define r() __context__(LOCK, -1)
-#define m() __context__(LOCK, 0, 1)
-#define m2() __context__(LOCK, 0, 2)
-
-static void good_ar(void)
-{
-    a();
-    r();
-}
-
-static void bad_arr(void)
-{
-    a();
-    r();
-    r();
-}
-
-static void good_macro1(void)
-{
-    a();
-    m();
-    r();
-}
-
-static void good_macro2(void)
-{
-    a();
-    a();
-    m();
-    m2();
-    r();
-    r();
-}
-
-static void bad_macro1(void)
-{
-    m();
-    a();
-    r();
-}
-
-static void bad_macro2(void)
-{
-    a();
-    r();
-    m();
-}
-
-static void bad_macro3(void)
-{
-    r();
-    a();
-}
-
-/*
- * check-name: Check __context__ statement with required context
- *
- * check-error-start
-context-statement.c:16:8: warning: context imbalance in 'bad_arr': unexpected unlock
-context-statement.c:16:8:    context 'LOCK': wanted 0, got -1
-context-statement.c:38:5: warning: context imbalance in 'bad_macro1': __context__ statement expected different context
-context-statement.c:38:5:    context 'LOCK': wanted >= 1, got 0
-context-statement.c:47:5: warning: context imbalance in 'bad_macro2': __context__ statement expected different context
-context-statement.c:47:5:    context 'LOCK': wanted >= 1, got 0
-context-statement.c:53:5: warning: context imbalance in 'bad_macro3': __context__ statement expected different context
-context-statement.c:53:5:    context 'LOCK': wanted >= 0, got -1
- * check-error-end
- */
diff --git a/validation/context.c b/validation/context.c
index 0b45ba3..4b15e75 100644
--- a/validation/context.c
+++ b/validation/context.c
@@ -314,109 +314,23 @@ static void warn_cond_lock1(void)
         condition2 = 1; /* do stuff */
     r();
 }
-
-static void warn_odd_looping(void)
-{
-    int i;
-
-    for (i = 0; i < 2; i++)
-        a();
-    for (i = 0; i < 2; i++)
-        r();
-}
-
-static void warn_huge_switch(void)
-{
-    a();
-
-    switch(condition) {
-    case 1:
-        r();
-        break;
-    case 2:
-        r();
-        break;
-    case 3:
-        r();
-        break;
-    case 4:
-        r();
-        break;
-    case 5:
-        r();
-        break;
-    case 11:
-        r();
-        break;
-    case 12:
-        r();
-        break;
-    case 13:
-        r();
-        break;
-    case 14:
-        r();
-    case 15:
-        r();
-        break;
-    case 16:
-        r();
-        break;
-    case 17:
-        r();
-        break;
-    }
-}
-
-static int warn_conditional(void)
-{
-    if (condition)
-        return 0;
-
-    a();
-    if (condition == 0)
-        return 1;
-    r();
-    return 0;
-}
-
 /*
  * check-name: Check -Wcontext
  *
  * check-error-start
-context.c:71:3: warning: context imbalance in 'warn_lock1': wrong count at exit
-context.c:71:3:    default context: wanted 0, got 1
-context.c:78:3: warning: context imbalance in 'warn_lock2': wrong count at exit
-context.c:78:3:    default context: wanted 0, got 1
-context.c:85:3: warning: context imbalance in 'warn_lock3': wrong count at exit
-context.c:85:3:    default context: wanted 0, got 1
-context.c:90:3: warning: context problem in 'warn_unlock1': 'r' expected different context
-context.c:90:3:    default context: wanted >= 1, got 0
-context.c:97:3: warning: context problem in 'warn_unlock2': 'r' expected different context
-context.c:97:3:    default context: wanted >= 1, got 0
-context.c:137:9: warning: context imbalance in 'warn_if1': wrong count at exit
-context.c:137:9:    default context: wanted 0, got 1
-context.c:147:9: warning: context imbalance in 'warn_if2': wrong count at exit
-context.c:147:9:    default context: wanted 0, got 1
-context.c:203:4: warning: context imbalance in 'warn_while1': wrong count at exit
-context.c:203:4:    default context: wanted 0, got 1
-context.c:210:4: warning: context problem in 'warn_while2': 'r' expected different context
-context.c:210:4:    default context: wanted >= 1, got 0
-context.c:220:4: warning: context imbalance in 'warn_while3': wrong count at exit
-context.c:220:4:    default context: wanted 0, got 1
-context.c:280:5: warning: context imbalance in 'warn_goto1': wrong count at exit
-context.c:280:5:    default context: wanted 0, got 1
-context.c:290:6: warning: context imbalance in 'warn_goto2': wrong count at exit
-context.c:290:6:    default context: wanted 0, got 1
-context.c:300:6: warning: context problem in 'warn_goto3': 'r' expected different context
-context.c:300:6:    default context: wanted >= 1, got 0
-context.c:315:6: warning: context problem in 'warn_cond_lock1': 'r' expected different context
-context.c:315:6:    default context: wanted >= 1, got 0
-context.c:325:10: warning: context problem in 'warn_odd_looping': 'r' expected different context
-context.c:325:10:    default context: wanted >= 1, got 0
-context.c:360:10: warning: context problem in 'warn_huge_switch': 'r' expected different context
-context.c:360:10:    default context: wanted >= 1, got 0
-context.c:380:12: warning: context imbalance in 'warn_conditional': wrong count at exit
-context.c:380:12:    default context: wanted 0, got 1
+context.c:69:13: warning: context imbalance in 'warn_lock1' - wrong count at exit
+context.c:74:13: warning: context imbalance in 'warn_lock2' - wrong count at exit
+context.c:81:13: warning: context imbalance in 'warn_lock3' - wrong count at exit
+context.c:88:13: warning: context imbalance in 'warn_unlock1' - unexpected unlock
+context.c:93:13: warning: context imbalance in 'warn_unlock2' - unexpected unlock
+context.c:131:12: warning: context imbalance in 'warn_if1' - wrong count at exit
+context.c:140:12: warning: context imbalance in 'warn_if2' - different lock contexts for basic block
+context.c:202:2: warning: context imbalance in 'warn_while1' - different lock contexts for basic block
+context.c:210:3: warning: context imbalance in 'warn_while2' - unexpected unlock
+context.c:216:2: warning: context imbalance in 'warn_while3' - wrong count at exit
+context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong count at exit
+context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong count at exit
+context.c:300:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block
+context.c:315:5: warning: context imbalance in 'warn_cond_lock1' - different lock contexts for basic block
  * check-error-end
  */
-- 
1.6.0.6



