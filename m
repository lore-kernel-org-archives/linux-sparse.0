From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 6/9 v2] check context expressions as expressions
Date: Wed, 10 Sep 2008 09:33:23 +0200
Message-ID: <1221032003.12266.4.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085516.930777000@sipsolutions.net>
	 (sfid-20080529_110356_474634_0A297920)
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:57962 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbYIJHdg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Sep 2008 03:33:36 -0400
In-Reply-To: <20080529085516.930777000@sipsolutions.net> (sfid-20080529_110356_474634_0A297920)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>

This patch makes sparse evaluate context expressions allowing this:

    struct test {
        lock_t lock;
        int i;
    };

    extern void r(struct test *t) __attribute__((context(&t->lock,0,1)));
    extern struct test *find(int i) __attribute__((context(&RESULT->lock,1,0)));

    void test(void)
    {
       struct test *x = find(42);
       r(x);
       r(x);
    }

to work the way you think it would.

This works by rewriting the given attribute expression into __context__
statements and evaluating those in the caller scope.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Somewhat inspired by Philipp's patch. When it warns, the expression is
given as evaluated, e.g. in above case would result in a warning about
"**x+0". We can fix that later by keeping the original expression and
not expanding/evaluating it, but we need to do both for it to work.

Note that there's a problem: You cannot give RESULT on a static function
that is declared there without getting an error in the function itself...

v2: Harvey found a bug in this by running it on the Linux kernel and
    I also cleaned up some functions and made them static.

 evaluate.c                |   18 ++-
 expand.c                  |    6 +
 expression.c              |  271 +++++++++++++++++++++++++++++++++++++++++++++-
 expression.h              |    5 
 ident-list.h              |    1 
 inline.c                  |    4 
 linearize.c               |   63 ++++++----
 linearize.h               |    1 
 parse.c                   |   17 ++
 parse.h                   |    1 
 sparse.c                  |  144 ++++++------------------
 symbol.h                  |    4 
 validation/context-vars.c |  171 +++++++++++++++++++++++++++++
 13 files changed, 572 insertions(+), 134 deletions(-)

--- sparse.orig/expression.c	2008-09-10 08:56:01.000000000 +0200
+++ sparse/expression.c	2008-09-10 09:27:43.000000000 +0200
@@ -27,6 +27,8 @@
 #include "expression.h"
 #include "target.h"
 
+struct expression *current_assignment_expression = NULL;
+
 static int match_oplist(int op, ...)
 {
 	va_list args;
@@ -509,6 +511,63 @@ static struct token *expression_list(str
 	return token;
 }
 
+static int ident_equal(struct ident *ident1, struct ident *ident2)
+{
+	if (ident1 == ident2)
+		return 1;
+	if (!ident1 || !ident2)
+		return 0;
+
+	return ident1->len == ident2->len &&
+		!strncmp(ident1->name, ident2->name, ident1->len);
+}
+
+/* TODO: this is probably not complete */
+static void replace_ident(struct expression **_in, struct ident *s, struct expression *r)
+{
+	struct expression *in = *_in;
+
+	switch (in->type) {
+	case EXPR_SYMBOL:
+		if (ident_equal(in->symbol_name, s))
+			*_in = r;
+		break;
+	case EXPR_IDENTIFIER:
+		if (ident_equal(in->expr_ident, s))
+			*_in = r;
+		break;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_ASSIGNMENT:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+		replace_ident(&in->left, s, r);
+		replace_ident(&in->right, s, r);
+		break;
+	case EXPR_DEREF:
+		replace_ident(&in->deref, s, r);
+		break;
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		replace_ident(&in->unop, s, r);
+		break;
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+	case EXPR_SIZEOF:
+		replace_ident(&in->cast_expression, s, r);
+		break;
+	case EXPR_SLICE:
+		replace_ident(&in->base, s, r);
+		break;
+	case EXPR_CONDITIONAL:
+		replace_ident(&in->conditional, s, r);
+		replace_ident(&in->cond_true, s, r);
+		replace_ident(&in->cond_false, s, r);
+		break;
+	}
+}
+
 /*
  * extend to deal with the ambiguous C grammar for parsing
  * a cast expressions followed by an initializer.
@@ -570,10 +629,49 @@ static struct token *postfix_expression(
 
 		case '(': {			/* Function call */
 			struct expression *call = alloc_expression(token->pos, EXPR_CALL);
+			struct symbol *fn = NULL;
+			struct context *c;
+
+			if (expr->symbol_name)
+				fn = lookup_symbol(expr->symbol_name, NS_SYMBOL);
 			call->op = '(';
 			call->fn = expr;
 			token = expression_list(token->next, &call->args);
 			token = expect(token, ')', "in function call");
+			if (fn && fn->ctype.base_type) {
+				FOR_EACH_PTR(fn->ctype.contexts, c) {
+					struct context *copy = alloc_context();
+					struct symbol *fn_arg;
+					struct expression *passed_arg;
+
+					copy->in = c->in;
+					copy->out = c->out;
+					copy->exact = c->exact;
+					add_ptr_list(&call->contexts, copy);
+
+					if (!c->token)
+						continue;
+
+					/* re-parse the token at this place */
+					conditional_expression(c->token, &copy->context);
+
+					copy->context->pos = expr->pos;
+
+					if (current_assignment_expression)
+						replace_ident(&copy->context, &RESULT_ident,
+							      current_assignment_expression);
+
+					/* and replace the arg */
+					PREPARE_PTR_LIST(fn->ctype.base_type->arguments, fn_arg);
+					FOR_EACH_PTR(call->args, passed_arg);
+					if (fn_arg && passed_arg->type != EXPR_CALL)
+						replace_ident(&copy->context, fn_arg->ident, passed_arg);
+					NEXT_PTR_LIST(fn_arg);
+					END_FOR_EACH_PTR(passed_arg);
+					FINISH_PTR_LIST(fn_arg);
+				} END_FOR_EACH_PTR(c);
+			}
+
 			expr = call;
 			continue;
 		}
@@ -894,6 +992,7 @@ struct token *conditional_expression(str
 
 struct token *assignment_expression(struct token *token, struct expression **tree)
 {
+	struct expression *old_cae = current_assignment_expression;
 	token = conditional_expression(token, tree);
 	if (*tree && token_type(token) == TOKEN_SPECIAL) {
 		static const int assignments[] = {
@@ -904,15 +1003,19 @@ struct token *assignment_expression(stru
 			SPECIAL_SHR_ASSIGN, SPECIAL_AND_ASSIGN,
 			SPECIAL_OR_ASSIGN,  SPECIAL_XOR_ASSIGN };
 		int i, op = token->special;
+		if (op == '=')
+			current_assignment_expression = *tree;
 		for (i = 0; i < sizeof(assignments)/sizeof(int); i++)
 			if (assignments[i] == op) {
 				struct expression * expr = alloc_expression(token->pos, EXPR_ASSIGNMENT);
 				expr->left = *tree;
 				expr->op = op;
 				*tree = expr;
-				return assignment_expression(token->next, &expr->right);
+				token = assignment_expression(token->next, &expr->right);
+				break;
 			}
 	}
+	current_assignment_expression = old_cae;
 	return token;
 }
 
@@ -929,4 +1032,170 @@ struct token *parse_expression(struct to
 	return comma_expression(token,tree);
 }
 
+int expressions_equal(const struct expression *expr1,
+		      const struct expression *expr2)
+{
+	if (expr1 == expr2)
+		return 1;
+
+	if (expr1 == NULL || expr2 == NULL)
+		return 0;
 
+	/* Is this the right way to handle casts? */
+	if (expr1->type == EXPR_CAST ||
+	    expr1->type == EXPR_FORCE_CAST ||
+	    expr1->type == EXPR_IMPLIED_CAST)
+		return expressions_equal(expr1->cast_expression, expr2);
+
+	if (expr2->type == EXPR_CAST ||
+	    expr2->type == EXPR_FORCE_CAST ||
+	    expr2->type == EXPR_IMPLIED_CAST)
+		return expressions_equal(expr2->cast_expression, expr1);
+
+	if (expr1->type != expr2->type)
+		return 0;
+
+	switch (expr1->type) {
+	case EXPR_SYMBOL:
+		return ident_equal(expr1->symbol_name, expr2->symbol_name);
+
+	case EXPR_VALUE:
+		return expr1->value == expr2->value;
+
+	case EXPR_FVALUE:
+		return expr1->fvalue == expr2->fvalue;
+
+	case EXPR_STRING:
+		return expr1->string->length == expr2->string->length &&
+			!strncmp(expr1->string->data, expr2->string->data, expr1->string->length);
+
+	case EXPR_BINOP:
+		return expr1->op == expr2->op &&
+			expressions_equal(expr1->left, expr2->left) &&
+			expressions_equal(expr1->right, expr2->right);
+
+	case EXPR_COMMA:
+	case EXPR_ASSIGNMENT:
+		return expressions_equal(expr1->left, expr2->left) &&
+			expressions_equal(expr1->right, expr2->right);
+
+	case EXPR_DEREF:
+		return expressions_equal(expr1->deref, expr2->deref) &&
+			ident_equal(expr1->member, expr2->member);
+
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		return expr1->op == expr2->op &&
+			expressions_equal(expr1->unop, expr2->unop);
+
+	/* Not needed right now, but for sake of completness ...
+	case EXPR_LABEL:
+	case EXPR_STATEMENT:
+	case EXPR_CALL:
+	case EXPR_LOGICAL:
+	case EXPR_COMPARE:
+	case EXPR_SELECT:
+	case EXPR_CONDITIONAL:
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+	case EXPR_SLICE:
+	case EXPR_INITIALIZER:
+	case EXPR_POS:
+	*/
+
+	default:
+		/* nothing, we should already have had a warning */
+		;
+	}
+
+	return 0;
+}
+
+static int ident_str(struct ident *ident, char *buffer, int length)
+{
+	if (!ident)
+		return 0;
+	return snprintf(buffer, length, "%.*s", ident->len, ident->name);
+}
+
+int expression_str(const struct expression *expr,
+		   char *buffer, int length)
+{
+	int n;
+
+	memset(buffer, 0, length);
+
+	if (!expr)
+		return 0;
+
+	/* TODO, think about necessary parentheses () */
+
+	switch (expr->type) {
+	case EXPR_SYMBOL:
+		return ident_str(expr->symbol_name, buffer, length);
+
+	case EXPR_VALUE:
+		return snprintf(buffer, length, "%llu", expr->value);
+
+	case EXPR_FVALUE:
+		return snprintf(buffer, length, "%Lf", expr->fvalue);
+
+	case EXPR_STRING:
+		return snprintf(buffer, length, "\"%.*s\"", expr->string->length, expr->string->data);
+
+	case EXPR_BINOP:
+		n  = expression_str(expr->left, buffer, length);
+		n += snprintf(buffer+n, length-n, "%c", expr->op);
+		n += expression_str(expr->right, buffer+n, length-n);
+		return n;
+
+	case EXPR_COMMA:
+		n  = expression_str(expr->left, buffer, length);
+		n += snprintf(buffer+n, length-n, ",");
+		n += expression_str(expr->right, buffer+n, length-n);
+		return n;
+
+	case EXPR_ASSIGNMENT:
+		n  = expression_str(expr->left, buffer, length);
+		n += snprintf(buffer+n, length-n, "=");
+		n += expression_str(expr->right, buffer+n, length-n);
+		return n;
+
+	case EXPR_DEREF:
+		if (expr->left->type == EXPR_PREOP &&
+		    expr->left->op == '*') {
+			n  = expression_str(expr->left->unop, buffer, length);
+			n += snprintf(buffer+n, length-n, "->");
+			n += ident_str(expr->member, buffer+n, length-n);
+		} else {
+			n  = expression_str(expr->left, buffer, length);
+			n += snprintf(buffer+n, length-n, ".");
+			n += ident_str(expr->member, buffer+n, length-n);
+		}
+		return n;
+
+	case EXPR_PREOP:
+		n  = snprintf(buffer, length, "%c", expr->op);
+		n += expression_str(expr->unop, buffer+n, length-n);
+		return n;
+
+	case EXPR_POSTOP:
+		n  = expression_str(expr->unop, buffer, length);
+		n += snprintf(buffer+n, length-n, "%c", expr->op);
+		return n;
+
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+		/* todo: print out the cast type's ctype */
+		*buffer++ = '('; length--;
+		*buffer++ = ')'; length--;
+		return expression_str(expr->cast_expression, buffer, length) + 2;
+
+	default:
+		printf("Missing code in expression_str for %d\n", expr->type);
+	}
+
+	return 0;
+}
--- sparse.orig/expression.h	2008-09-10 08:56:01.000000000 +0200
+++ sparse/expression.h	2008-09-10 09:06:18.000000000 +0200
@@ -121,6 +121,7 @@ struct expression {
 		struct /* call_expr */ {
 			struct expression *fn;
 			struct expression_list *args;
+			struct context_list *contexts;
 		};
 		// EXPR_LABEL
 		struct /* label_expr */ {
@@ -216,4 +217,8 @@ struct token *compound_statement(struct 
 void cast_value(struct expression *expr, struct symbol *newtype,
 	struct expression *old, struct symbol *oldtype);
 
+int expressions_equal(const struct expression *expr1,
+		      const struct expression *expr2);
+int expression_str(const struct expression *, char *buf, int buflen);
+extern struct expression *current_assignment_expression;
 #endif
--- sparse.orig/sparse.c	2008-09-10 08:56:02.000000000 +0200
+++ sparse/sparse.c	2008-09-10 09:13:55.000000000 +0200
@@ -26,7 +26,7 @@
 
 struct context_check {
 	int val;
-	char name[32];
+	const struct expression *expr;
 };
 
 DECLARE_ALLOCATOR(context_check);
@@ -34,22 +34,15 @@ DECLARE_PTR_LIST(context_check_list, str
 DECLARE_PTR_LIST(context_list_list, struct context_check_list);
 ALLOCATOR(context_check, "context check list");
 
-static const char *unnamed_context = "<unnamed>";
 
-static const char *context_name(struct context *context)
-{
-	if (context->context && context->context->symbol_name)
-		return show_ident(context->context->symbol_name);
-	return unnamed_context;
-}
-
-static void context_add(struct context_check_list **ccl, const char *name,
+static void context_add(struct context_check_list **ccl,
+			const struct expression *expr,
 			int offs)
 {
 	struct context_check *check, *found = NULL;
 
 	FOR_EACH_PTR(*ccl, check) {
-		if (strcmp(name, check->name))
+		if (!expressions_equal(expr, check->expr))
 			continue;
 		found = check;
 		break;
@@ -57,8 +50,7 @@ static void context_add(struct context_c
 
 	if (!found) {
 		found = __alloc_context_check(0);
-		strncpy(found->name, name, sizeof(found->name));
-		found->name[sizeof(found->name) - 1] = '\0';
+		found->expr = expr;
 		add_ptr_list(ccl, found);
 	}
 	found->val += offs;
@@ -70,7 +62,7 @@ static int context_list_has(struct conte
 	struct context_check *check;
 
 	FOR_EACH_PTR(ccl, check) {
-		if (strcmp(c->name, check->name))
+		if (!expressions_equal(c->expr, check->expr))
 			continue;
 		return check->val == c->val;
 	} END_FOR_EACH_PTR(check);
@@ -105,7 +97,7 @@ static struct context_check_list *checke
 	struct context_check *c;
 
 	FOR_EACH_PTR(ccl, c) {
-		context_add(&result, c->name, c->val);
+		context_add(&result, c->expr, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	return result;
@@ -115,15 +107,15 @@ static struct context_check_list *checke
 #define CONTEXT_PROB "context problem in '%s': "
 #define DEFAULT_CONTEXT_DESCR "   default context: "
 
-static void get_context_string(char **buf, const char **name)
+static const char *get_context_string(char **buf, const char *name)
 {
-	if (strcmp(*name, unnamed_context)) {
-		*buf = malloc(strlen(*name) + 16);
-		sprintf(*buf, "   context '%s': ", *name);
-		*name = *buf;
+	if (strlen(name)) {
+		*buf = malloc(strlen(name) + 16);
+		sprintf(*buf, "   context '%s': ", name);
+		return *buf;
 	} else {
-		*name = DEFAULT_CONTEXT_DESCR;
 		*buf = NULL;
+		return DEFAULT_CONTEXT_DESCR;
 	}
 }
 
@@ -133,12 +125,13 @@ static int context_list_check(struct ent
 {
 	struct context_check *c1, *c2;
 	int cur, tgt;
-	const char *name;
+	char name[1000];
 	char *buf;
+	const char *pname;
 
 	/* make sure the loop below checks all */
 	FOR_EACH_PTR(ccl_target, c1) {
-		context_add(&ccl_cur, c1->name, 0);
+		context_add(&ccl_cur, c1->expr, 0);
 	} END_FOR_EACH_PTR(c1);
 
 	FOR_EACH_PTR(ccl_cur, c1) {
@@ -146,7 +139,7 @@ static int context_list_check(struct ent
 		tgt = 0;
 
 		FOR_EACH_PTR(ccl_target, c2) {
-			if (strcmp(c2->name, c1->name))
+			if (!expressions_equal(c1->expr, c2->expr))
 				continue;
 			tgt = c2->val;
 			break;
@@ -162,11 +155,11 @@ static int context_list_check(struct ent
 			warning(pos, IMBALANCE_IN "unexpected unlock",
 				show_ident(ep->name->ident));
 
-		name = c1->name;
-		get_context_string(&buf, &name);
+		expression_str(c1->expr, name, sizeof(name));
+		pname = get_context_string(&buf, name);
 
 		info(pos, "%swanted %d, got %d",
-		     name, tgt, cur);
+		     pname, tgt, cur);
 
 		free(buf);
 
@@ -176,83 +169,21 @@ static int context_list_check(struct ent
 	return 0;
 }
 
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
-		}
-	} END_FOR_EACH_PTR (ctx);
-
-	return 0;
-}
-
 static int handle_context(struct entrypoint *ep, struct basic_block *bb,
 			  struct instruction *insn,
 			  struct context_check_list **combined)
 {
 	struct context_check *c;
-	const char *name, *cmp;
+	const char *cmp, *pname;
 	char *buf;
+	char name[1000];
 	int val, ok;
 
 	val = 0;
 
-	name = unnamed_context;
-	if (insn->context_expr)
-		name = show_ident(insn->context_expr->symbol_name);
-
 	FOR_EACH_PTR(*combined, c) {
-		if (strcmp(c->name, name) == 0) {
+		if (expressions_equal(c->expr, insn->context_expr))
 			val = c->val;
-			break;
-		}
 	} END_FOR_EACH_PTR(c);
 
 	if (insn->exact) {
@@ -264,7 +195,8 @@ static int handle_context(struct entrypo
 	}
 
 	if (!ok && Wcontext) {
-		get_context_string(&buf, &name);
+		expression_str(insn->context_expr, name, sizeof(name));
+		pname = get_context_string(&buf, name);
 
 		if (insn->access_var) {
 			char *symname = strdup(show_ident(insn->access_var->ident));
@@ -273,6 +205,13 @@ static int handle_context(struct entrypo
 				"access to '%s' requires different context",
 				show_ident(ep->name->ident), symname);
 			free(symname);
+		} else if (insn->called_fn) {
+			char *symname = strdup(show_ident(insn->called_fn->ident));
+			warning(insn->pos,
+				CONTEXT_PROB
+				"'%s' expected different context",
+				show_ident(ep->name->ident), symname);
+			free(symname);
 		} else {
 			warning(insn->pos,
 				CONTEXT_PROB
@@ -281,13 +220,13 @@ static int handle_context(struct entrypo
 		}
 
 		info(insn->pos, "%swanted %s%d, got %d",
-		     name, cmp, insn->required, val);
+		     pname, cmp, insn->required, val);
 
 		free(buf);
 		return -1;
 	}
 
-	context_add(combined, name, insn->increment);
+	context_add(combined, insn->context_expr, insn->increment);
 
 	return 0;
 }
@@ -324,7 +263,7 @@ static int check_bb_context(struct entry
 	 * for the conditional_context() attribute.
 	 */
 	FOR_EACH_PTR(ccl_in, c) {
-		context_add(&combined, c->name, c->val);
+		context_add(&combined, c->expr, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	/* Add the new context to the list of already-checked contexts */
@@ -338,11 +277,6 @@ static int check_bb_context(struct entry
 	 */
 	FOR_EACH_PTR(bb->insns, insn) {
 		switch (insn->opcode) {
-		case OP_INLINED_CALL:
-		case OP_CALL:
-			if (handle_call(ep, bb, insn, combined))
-				goto out;
-			break;
 		case OP_CONTEXT:
 			if (handle_context(ep, bb, insn, &combined))
 				goto out;
@@ -571,10 +505,10 @@ static void check_context(struct entrypo
 	check_instructions(ep);
 
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		const char *name = context_name(context);
-
-		context_add(&ccl_in, name, context->in);
-		context_add(&ccl_target, name, context->out);
+		context_add(&ccl_in, context->in_fn,
+			    context->in);
+		context_add(&ccl_target, context->in_fn,
+			    context->out);
 	} END_FOR_EACH_PTR(context);
 
 	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target);
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-vars.c	2008-09-10 09:13:56.000000000 +0200
@@ -0,0 +1,171 @@
+static void a(void *p) __attribute__((context(p,0,1)))
+{
+    __context__(p,1);
+}
+
+static void r(void *p) __attribute__((context(p,1,0)))
+{
+    __context__(p,-1,1);
+}
+
+extern void *l1, *l2;
+
+static void good_paired1(void)
+{
+    a(l1);
+    r(l1);
+}
+
+static void good_paired2(void)
+{
+    a(l1);
+    r(l1);
+    a(l1);
+    r(l1);
+    a(l2);
+    r(l2);
+}
+
+static void good_paired3(void)
+{
+    a(l1);
+    a(l2);
+    r(l2);
+    r(l1);
+}
+
+static void good_lock1(void *lp) __attribute__((context(lp,0,1)))
+{
+    a(lp);
+}
+
+static void good_lock2(void *lp) __attribute__((context(lp,0,1)))
+{
+    a(lp);
+    r(lp);
+    a(lp);
+}
+
+extern void **v;
+
+static void warn_lock1(void)
+{
+    a(v[1]);
+}
+
+extern int condition;
+
+static void good_lock3(void)
+{
+    a(v[1]);
+    if (condition) {
+        a(v[2]);
+        r(v[2]);
+    }
+    r(v[1]);
+}
+
+#define cond_lock(x, c)\
+  ((c) ? ({ __context__(x,1); 1; }) : 0)
+
+#define trylock(x) \
+    cond_lock(x, _try_lock(x))
+
+extern void _try_lock(int *x);
+
+static int good_condlock1(void)
+{
+    if (trylock(v[0]))
+        r(v[0]);
+}
+
+static int good_condlock2(void)
+{
+    if (trylock(&condition))
+        r((void*)&condition);
+}
+
+extern void ai(int *p) __attribute__((context(p,0,1)));
+extern void ri(int *p) __attribute__((context(p,1,0)));
+
+struct test {
+    int lock;
+};
+
+static inline void unlock(struct test *y)
+    __attribute__((context(&y->lock,1,0)))
+{
+    ri(&y->lock);
+}
+
+static void good_lock4(struct test *t)
+    __attribute__((context(&t->lock,0,1)))
+{
+    ai(&t->lock);
+}
+
+extern int *find_locked(void) __attribute__((context(RESULT,0,1)));
+
+static void good_find_release1(void)
+{
+    int *p;
+
+    p = find_locked();
+    ri(p);
+}
+
+extern struct test *find_locked_struct(void) __attribute__((context(&RESULT->lock,0,1)));
+
+static void good_find_release2(void)
+{
+    struct test *t;
+
+    t = find_locked_struct();
+    unlock(t);
+}
+
+static void good_find_release3(void)
+{
+    struct test *t = find_locked_struct();
+    unlock(t);
+}
+
+static void warn_unlock(void)
+{
+    struct test *t;
+    /* check that the warning is here, not at the unlock definition */
+    unlock(t);
+}
+
+extern int _locked_struct_test(struct test *ls, int *flags);
+#define locked_struct_test(ls, flags) (( _locked_struct_test((ls), (flags)) ) ? ({ __context__(&ls->lock,1); 1;}) : 0)
+
+static inline void unlock2(struct test *y)
+    __attribute__((context(&y->lock,1,0)))
+{
+    unlock(y);
+}
+
+static void good_locked_val(void)
+{
+    struct test *t;
+    int flags;
+
+    if (!t || !locked_struct_test(t, &flags))
+        goto out;
+
+    unlock2(t);
+ out:
+    ;
+}
+
+/*
+ * check-name: Check -Wcontext with lock variables
+ *
+ * check-error-start
+context-vars.c:53:7: warning: context imbalance in 'warn_lock1': wrong count at exit
+context-vars.c:53:7:    context '**v+4': wanted 0, got 1
+context-vars.c:137:11: warning: context problem in 'warn_unlock': 'unlock' expected different context
+context-vars.c:137:11:    context '*t+0': wanted >= 1, got 0
+ * check-error-end
+ */
--- sparse.orig/evaluate.c	2008-09-10 08:56:02.000000000 +0200
+++ sparse/evaluate.c	2008-09-10 08:56:34.000000000 +0200
@@ -2954,8 +2954,16 @@ struct symbol *evaluate_expression(struc
 		return evaluate_alignof(expr);
 	case EXPR_DEREF:
 		return evaluate_member_dereference(expr);
-	case EXPR_CALL:
+	case EXPR_CALL: {
+		struct context *c;
+		FOR_EACH_PTR(expr->contexts, c) {
+			if (c->context &&
+			    (c->context->type != EXPR_SYMBOL ||
+			     c->context->symbol))
+				evaluate_expression(c->context);
+		} END_FOR_EACH_PTR(c);
 		return evaluate_call(expr);
+	}
 	case EXPR_SELECT:
 	case EXPR_CONDITIONAL:
 		return evaluate_conditional_expression(expr);
@@ -3025,6 +3033,7 @@ static void check_duplicates(struct symb
 static struct symbol *evaluate_symbol(struct symbol *sym)
 {
 	struct symbol *base_type;
+	struct context *c;
 
 	if (!sym)
 		return sym;
@@ -3054,6 +3063,13 @@ static struct symbol *evaluate_symbol(st
 			evaluate_statement(base_type->stmt);
 
 		current_fn = curr;
+
+		FOR_EACH_PTR(sym->ctype.contexts, c) {
+		if (c->in_fn &&
+		    (c->in_fn->type != EXPR_SYMBOL ||
+		     c->in_fn->symbol))
+			evaluate_expression(c->in_fn);
+		} END_FOR_EACH_PTR(c);
 	}
 
 	return base_type;
--- sparse.orig/expand.c	2008-09-10 08:56:02.000000000 +0200
+++ sparse/expand.c	2008-09-10 08:56:34.000000000 +0200
@@ -1034,8 +1034,14 @@ int expand_symbol(struct symbol *sym)
 	retval = expand_expression(sym->initializer);
 	/* expand the body of the symbol */
 	if (base_type->type == SYM_FN) {
+		struct context *c;
+
 		if (base_type->stmt)
 			expand_statement(base_type->stmt);
+
+		FOR_EACH_PTR(sym->ctype.contexts, c) {
+			expand_expression(c->in_fn);
+		} END_FOR_EACH_PTR(c);
 	}
 	return retval;
 }
--- sparse.orig/parse.c	2008-09-10 08:56:01.000000000 +0200
+++ sparse/parse.c	2008-09-10 08:56:34.000000000 +0200
@@ -879,12 +879,13 @@ static struct token *_attribute_context(
 	struct context *context = alloc_context();
 	struct expression *args[4];
 	int argc = 0;
-	struct token *last = NULL;
+	struct token *first = NULL, *last = NULL;
 
 	token = expect(token, '(', "after context attribute");
 	while (!match_op(token, ')')) {
 		struct expression *expr = NULL;
 		last = token;
+		first = first ? : token;
 		token = conditional_expression(token, &expr);
 		if (!expr)
 			break;
@@ -910,12 +911,14 @@ static struct token *_attribute_context(
 		break;
 	case 3:
 		context->context = args[0];
+		context->token = first;
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 		break;
 	case 4: {
 		const char *rw;
 		context->context = args[0];
+		context->token = first;
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 
@@ -2096,6 +2099,7 @@ static struct token *parse_function_body
 	struct symbol *base_type = decl->ctype.base_type;
 	struct statement *stmt, **p;
 	struct symbol *arg;
+	struct context *c;
 
 	old_symbol_list = function_symbol_list;
 	if (decl->ctype.modifiers & MOD_INLINE) {
@@ -2124,6 +2128,11 @@ static struct token *parse_function_body
 
 	token = compound_statement(token->next, stmt);
 
+	FOR_EACH_PTR(decl->ctype.contexts, c) {
+		if (c->token)
+			conditional_expression(c->token, &c->in_fn);
+	} END_FOR_EACH_PTR(c);
+
 	end_function(decl);
 	if (!(decl->ctype.modifiers & MOD_INLINE))
 		add_symbol(list, decl);
@@ -2286,11 +2295,17 @@ struct token *external_declaration(struc
 
 	for (;;) {
 		if (!is_typedef && match_op(token, '=')) {
+			struct expression *old_cae = current_assignment_expression;
 			if (decl->ctype.modifiers & MOD_EXTERN) {
 				warning(decl->pos, "symbol with external linkage has initializer");
 				decl->ctype.modifiers &= ~MOD_EXTERN;
 			}
+			current_assignment_expression = alloc_expression(token->pos, EXPR_SYMBOL);
+			current_assignment_expression->symbol_name = decl->ident;
+			current_assignment_expression->symbol =
+				lookup_symbol(decl->ident, NS_SYMBOL | NS_TYPEDEF);
 			token = initializer(&decl->initializer, token->next);
+			current_assignment_expression = old_cae;
 		}
 		if (!is_typedef) {
 			if (!(decl->ctype.modifiers & (MOD_EXTERN | MOD_INLINE))) {
--- sparse.orig/symbol.h	2008-09-10 08:56:01.000000000 +0200
+++ sparse/symbol.h	2008-09-10 08:56:34.000000000 +0200
@@ -77,6 +77,10 @@ enum context_read_write_specifier {
 
 struct context {
 	struct expression *context;
+	/* store the token pointer */
+	struct token *token;
+	/* to re-evaluate this context within the function it is for */
+	struct expression *in_fn;
 	unsigned int in, out;
 	int exact;
 	enum context_read_write_specifier rws;
--- sparse.orig/inline.c	2008-09-10 08:56:01.000000000 +0200
+++ sparse/inline.c	2008-09-10 09:00:00.000000000 +0200
@@ -56,7 +56,7 @@ static struct symbol_list *copy_symbol_l
 	return dst;
 }
 
-static struct expression * copy_expression(struct expression *expr)
+static struct expression *copy_expression(struct expression *expr)
 {
 	if (!expr)
 		return NULL;
@@ -474,6 +474,7 @@ void copy_statement(struct statement *sr
 	dst->args = copy_one_statement(src->args);
 	dst->ret = copy_symbol(src->pos, src->ret);
 	dst->inline_fn = src->inline_fn;
+	dst->inlined_fn_expr = src->inlined_fn_expr;
 }
 
 static struct symbol *create_copy_symbol(struct symbol *orig)
@@ -555,6 +556,7 @@ int inline_function(struct expression *e
 		stmt->args = decl;
 	}
 	stmt->inline_fn = sym;
+	stmt->inlined_fn_expr = expr;
 
 	unset_replace_list(fn_symbol_list);
 
--- sparse.orig/linearize.c	2008-09-10 08:56:02.000000000 +0200
+++ sparse/linearize.c	2008-09-10 09:13:56.000000000 +0200
@@ -35,6 +35,7 @@ static pseudo_t linearize_initializer(st
 struct pseudo void_pseudo = {};
 
 static struct position current_pos;
+static int in_inline_skip_context = 0;
 
 ALLOCATOR(pseudo_user, "pseudo_user");
 
@@ -436,9 +437,15 @@ const char *show_instruction(struct inst
 		buf += sprintf(buf, "%s <- %s", show_pseudo(insn->target), show_pseudo(insn->src1));
 		break;
 
-	case OP_CONTEXT:
+	case OP_CONTEXT: {
+		char ctxbuf[100];
+		if (insn->context_expr) {
+			expression_str(insn->context_expr, ctxbuf, sizeof(ctxbuf));
+			buf += sprintf(buf, "%s, ", ctxbuf);
+		}
 		buf += sprintf(buf, "%d", insn->increment);
 		break;
+	}
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
 		break;
@@ -1280,7 +1287,7 @@ static pseudo_t linearize_call_expressio
 	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
-	struct context *context;
+	struct context *c;
 
 	if (!expr->ctype) {
 		warning(expr->pos, "call with no type!");
@@ -1316,29 +1323,17 @@ static pseudo_t linearize_call_expressio
 	insn->target = retval;
 	add_one_insn(ep, insn);
 
-	if (ctype) {
-		FOR_EACH_PTR(ctype->contexts, context) {
-			int in = context->in;
-			int out = context->out;
-			int check = 0;
-			int context_diff;
-			if (in < 0) {
-				check = 1;
-				in = 0;
-			}
-			if (out < 0) {
-				check = 0;
-				out = 0;
-			}
-			context_diff = out - in;
-			if (check || context_diff) {
-				insn = alloc_instruction(OP_CONTEXT, 0);
-				insn->increment = context_diff;
-				insn->context_expr = context->context;
-				add_one_insn(ep, insn);
-			}
-		} END_FOR_EACH_PTR(context);
-	}
+	if (!in_inline_skip_context)
+		FOR_EACH_PTR(expr->contexts, c) {
+			struct instruction *tmp = alloc_instruction(OP_CONTEXT, 0);
+			tmp->increment = c->out - c->in;
+			tmp->exact = c->exact;
+			tmp->context_expr = c->context;
+			tmp->required = c->in;
+			tmp->called_fn = call->sym;
+			tmp->pos = insn->pos;
+			add_one_insn(ep, tmp);
+		} END_FOR_EACH_PTR(c);
 
 	return retval;
 }
@@ -1712,6 +1707,8 @@ static pseudo_t linearize_compound_state
 
 	pseudo = VOID;
 	FOR_EACH_PTR(stmt->stmts, s) {
+		if (in_inline_skip_context && s->type == STMT_CONTEXT)
+			continue;
 		pseudo = linearize_statement(ep, s);
 	} END_FOR_EACH_PTR(s);
 
@@ -1739,6 +1736,7 @@ static pseudo_t linearize_inlined_call(s
 	struct statement *args = stmt->args;
 	struct basic_block *bb;
 	pseudo_t pseudo;
+	struct context *c;
 
 	if (args) {
 		struct symbol *sym;
@@ -1750,12 +1748,27 @@ static pseudo_t linearize_inlined_call(s
 		} END_FOR_EACH_PTR(sym);
 	}
 
+	in_inline_skip_context++;
 	insn->target = pseudo = linearize_compound_statement(ep, stmt);
+	in_inline_skip_context--;
 	use_pseudo(insn, symbol_pseudo(ep, stmt->inline_fn), &insn->func);
 	bb = ep->active;
 	if (bb && !bb->insns)
 		bb->pos = stmt->pos;
 	add_one_insn(ep, insn);
+
+	if (!in_inline_skip_context)
+		FOR_EACH_PTR(stmt->inlined_fn_expr->contexts, c) {
+			struct instruction *tmp = alloc_instruction(OP_CONTEXT, 0);
+			tmp->increment = c->out - c->in;
+			tmp->exact = c->exact;
+			tmp->context_expr = c->context;
+			tmp->required = c->in;
+			tmp->called_fn = stmt->inline_fn;
+			tmp->pos = insn->pos;
+			add_one_insn(ep, tmp);
+		} END_FOR_EACH_PTR(c);
+
 	return pseudo;
 }
 
--- sparse.orig/parse.h	2008-09-10 08:56:02.000000000 +0200
+++ sparse/parse.h	2008-09-10 08:56:34.000000000 +0200
@@ -61,6 +61,7 @@ struct statement {
 			struct symbol *ret;
 			struct symbol *inline_fn;
 			struct statement *args;
+			struct expression *inlined_fn_expr;
 		};
 		struct /* labeled_struct */ {
 			struct symbol *label_identifier;
--- sparse.orig/linearize.h	2008-09-10 08:56:02.000000000 +0200
+++ sparse/linearize.h	2008-09-10 08:56:34.000000000 +0200
@@ -119,6 +119,7 @@ struct instruction {
 			int increment, required, exact;
 			struct expression *context_expr;
 			struct symbol *access_var;
+			struct symbol *called_fn;
 		};
 		struct /* asm */ {
 			const char *string;
--- sparse.orig/ident-list.h	2008-09-10 08:56:02.000000000 +0200
+++ sparse/ident-list.h	2008-09-10 08:56:34.000000000 +0200
@@ -98,6 +98,7 @@ __IDENT(__PRETTY_FUNCTION___ident, "__PR
 IDENT_RESERVED(__context__);
 IDENT_RESERVED(__exact_context__);
 IDENT_RESERVED(__range__);
+IDENT_RESERVED(RESULT);
 
 /* Magic function names we recognize */
 IDENT(memset); IDENT(memcpy);


