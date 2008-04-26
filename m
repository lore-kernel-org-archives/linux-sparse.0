From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 1/2] evaluate context expressions
Date: Sat, 26 Apr 2008 17:20:26 +0200
Message-ID: <1209223226.10943.11.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:49680 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYDZPwS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 26 Apr 2008 11:52:18 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse <linux-sparse@vger.kernel.org>

This patch makes sparse evaluate context expressions allowing this:

    struct test {
        lock_t lock;
    };

    static void a(struct test *t) __attribute__((context(&t->lock,1,0)))
    {  
        __context__(&t->lock, 1);
    }

to work the way you think it would.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Heavily inspired by Philipp's patch :) When it warns, the expression is
given as evaluated, e.g. in above case would result in a warning about
"**t+0". We can fix that later by keeping the original expression and
not expanding/evaluating it, but we need to do both for it to work.

 evaluate.c                |    8 ++
 example.c                 |    4 -
 expand.c                  |    6 +
 expression.c              |  177 ++++++++++++++++++++++++++++++++++++++++++++++
 expression.h              |    3 
 linearize.c               |   76 +++++++++++++++++--
 linearize.h               |   11 ++
 liveness.c                |    8 +-
 parse.c                   |    9 ++
 sparse.c                  |  147 ++++++++++++++++++++++++--------------
 symbol.h                  |    4 +
 validation/context-vars.c |  141 ++++++++++++++++++++++++++++++++++++
 12 files changed, 526 insertions(+), 68 deletions(-)

--- sparse.orig/expression.c	2008-04-25 22:24:19.000000000 +0200
+++ sparse/expression.c	2008-04-25 22:24:24.000000000 +0200
@@ -929,4 +929,181 @@ struct token *parse_expression(struct to
 	return comma_expression(token,tree);
 }
 
+static int ident_equal(struct ident *ident1, struct ident *ident2)
+{
+	if (ident1 == ident2)
+		return 1;
+	if (!ident1 || !ident2)
+		return 0;
 
+	return ident1->len == ident2->len &&
+		!strncmp(ident1->name, ident2->name, ident1->len);
+}
+
+int expressions_equal(const struct expression *expr1,
+		      const struct expression *expr2)
+{
+	if (expr1 == expr2)
+		return 1;
+
+	if (expr1 == NULL || expr2 == NULL)
+		return 0;
+
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
--- sparse.orig/expression.h	2008-04-25 22:24:19.000000000 +0200
+++ sparse/expression.h	2008-04-26 17:07:58.000000000 +0200
@@ -216,4 +216,7 @@ struct token *compound_statement(struct 
 void cast_value(struct expression *expr, struct symbol *newtype,
 	struct expression *old, struct symbol *oldtype);
 
+int expressions_equal(const struct expression *expr1,
+		      const struct expression *expr2);
+int expression_str(const struct expression *, char *buf, int buflen);
 #endif
--- sparse.orig/sparse.c	2008-04-25 22:24:24.000000000 +0200
+++ sparse/sparse.c	2008-04-26 17:12:18.000000000 +0200
@@ -26,7 +26,7 @@
 
 struct context_check {
 	int val, val_false;
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
 			int offs, int offs_false)
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
@@ -71,7 +63,7 @@ static int context_list_has(struct conte
 	struct context_check *check;
 
 	FOR_EACH_PTR(ccl, check) {
-		if (strcmp(c->name, check->name))
+		if (!expressions_equal(c->expr, check->expr))
 			continue;
 		return check->val == c->val &&
 		       check->val_false == c->val_false;
@@ -107,7 +99,7 @@ static struct context_check_list *checke
 	struct context_check *c;
 
 	FOR_EACH_PTR(ccl, c) {
-		context_add(&result, c->name, c->val_false, c->val_false);
+		context_add(&result, c->expr, c->val_false, c->val_false);
 	} END_FOR_EACH_PTR(c);
 
 	return result;
@@ -117,15 +109,15 @@ static struct context_check_list *checke
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
 
@@ -135,12 +127,13 @@ static int context_list_check(struct ent
 {
 	struct context_check *c1, *c2;
 	int cur, tgt;
-	const char *name;
+	char name[1000];
 	char *buf;
+	const char *pname;
 
 	/* make sure the loop below checks all */
 	FOR_EACH_PTR(ccl_target, c1) {
-		context_add(&ccl_cur, c1->name, 0, 0);
+		context_add(&ccl_cur, c1->expr, 0, 0);
 	} END_FOR_EACH_PTR(c1);
 
 	FOR_EACH_PTR(ccl_cur, c1) {
@@ -148,7 +141,7 @@ static int context_list_check(struct ent
 		tgt = 0;
 
 		FOR_EACH_PTR(ccl_target, c2) {
-			if (strcmp(c2->name, c1->name))
+			if (!expressions_equal(c1->expr, c2->expr))
 				continue;
 			tgt = c2->val;
 			break;
@@ -164,11 +157,11 @@ static int context_list_check(struct ent
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
 
@@ -180,13 +173,15 @@ static int context_list_check(struct ent
 
 static int handle_call(struct entrypoint *ep, struct basic_block *bb,
 		       struct instruction *insn,
-		       struct context_check_list *combined)
+		       struct context_check_list **combined)
 {
 	struct context *ctx;
 	struct context_check *c;
-	const char *name, *call, *cmp;
+	const char *call, *cmp, *pname;
 	char *buf;
+	char name[1000];
 	int val, ok;
+	struct argument *arg;
 
 	if (!insn->func || !insn->func->sym ||
 	    insn->func->type != PSEUDO_SYM)
@@ -196,11 +191,19 @@ static int handle_call(struct entrypoint
 	 * Check all contexts the function wants.
 	 */
 	FOR_EACH_PTR(insn->func->sym->ctype.contexts, ctx) {
-		name = context_name(ctx);
+		int skip = 0;
 		val = 0;
 
-		FOR_EACH_PTR(combined, c) {
-			if (strcmp(c->name, name) == 0) {
+		FOR_EACH_PTR(insn->arguments, arg) {
+			if (arg->c == ctx)
+				skip = 1;
+		} END_FOR_EACH_PTR(arg);
+
+		if (skip)
+			continue;
+
+		FOR_EACH_PTR(*combined, c) {
+			if (expressions_equal(c->expr, ctx->in_fn)) {
 				val = c->val;
 				break;
 			}
@@ -215,7 +218,8 @@ static int handle_call(struct entrypoint
 		}
 
 		if (!ok && Wcontext) {
-			get_context_string(&buf, &name);
+			expression_str(ctx->context, name, sizeof(name));
+			pname = get_context_string(&buf, name);
 			call = strdup(show_ident(insn->func->ident));
 
 			warning(insn->pos, "context problem in '%s': "
@@ -223,7 +227,7 @@ static int handle_call(struct entrypoint
 				show_ident(ep->name->ident), call);
 
 			info(insn->pos, "%swanted %s%d, got %d",
-			     name, cmp, ctx->in, val);
+			     pname, cmp, ctx->in, val);
 
 			free((void *)call);
 			free(buf);
@@ -232,6 +236,49 @@ static int handle_call(struct entrypoint
 		}
 	} END_FOR_EACH_PTR (ctx);
 
+	FOR_EACH_PTR(insn->arguments, arg) {
+		val = 0;
+		ctx = arg->c;
+
+		if (!arg->c)
+			continue;
+
+		FOR_EACH_PTR(*combined, c) {
+			if (expressions_equal(arg->e, c->expr))
+				val = c->val;
+		} END_FOR_EACH_PTR(c);
+
+		if (ctx->exact) {
+			ok = ctx->in == val;
+			cmp = "";
+		} else {
+			ok = ctx->in <= val;
+			cmp = ">= ";
+		}
+
+		if (!ok && Wcontext) {
+			expression_str(arg->e, name, sizeof(name));
+			pname = get_context_string(&buf, name);
+			call = strdup(show_ident(insn->func->ident));
+
+			warning(insn->pos, "context problem in '%s': "
+				"'%s' expected different context",
+				show_ident(ep->name->ident), call);
+
+			info(insn->pos, "%swanted %s%d, got %d",
+			     pname, cmp, ctx->in, val);
+
+			free((void *)call);
+			free(buf);
+
+			return -1;
+		}
+
+		context_add(combined, arg->e,
+			    ctx->out - ctx->in,
+			    ctx->out_false - ctx->in);
+	} END_FOR_EACH_PTR(arg);
+
 	return 0;
 }
 
@@ -240,21 +287,16 @@ static int handle_context(struct entrypo
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
@@ -266,7 +308,8 @@ static int handle_context(struct entrypo
 	}
 
 	if (!ok && Wcontext) {
-		get_context_string(&buf, &name);
+		expression_str(insn->context_expr, name, sizeof(name));
+		pname = get_context_string(&buf, name);
 
 		if (insn->access_var) {
 			char *symname = strdup(show_ident(insn->access_var->ident));
@@ -283,13 +326,13 @@ static int handle_context(struct entrypo
 		}
 
 		info(insn->pos, "%swanted %s%d, got %d",
-		     name, cmp, insn->required, val);
+		     pname, cmp, insn->required, val);
 
 		free(buf);
 		return -1;
 	}
 
-	context_add(combined, name, insn->increment, insn->inc_false);
+	context_add(combined, insn->context_expr, insn->increment, insn->inc_false);
 
 	return 0;
 }
@@ -328,9 +371,9 @@ static int check_bb_context(struct entry
 	 */
 	FOR_EACH_PTR(ccl_in, c) {
 		if (in_false)
-			context_add(&combined, c->name, c->val_false, c->val_false);
+			context_add(&combined, c->expr, c->val_false, c->val_false);
 		else
-			context_add(&combined, c->name, c->val, c->val);
+			context_add(&combined, c->expr, c->val, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	/* Add the new context to the list of already-checked contexts */
@@ -346,7 +389,7 @@ static int check_bb_context(struct entry
 		switch (insn->opcode) {
 		case OP_INLINED_CALL:
 		case OP_CALL:
-			if (handle_call(ep, bb, insn, combined))
+			if (handle_call(ep, bb, insn, &combined))
 				goto out;
 			break;
 		case OP_CONTEXT:
@@ -577,10 +620,10 @@ static void check_context(struct entrypo
 	check_instructions(ep);
 
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		const char *name = context_name(context);
-
-		context_add(&ccl_in, name, context->in, context->in);
-		context_add(&ccl_target, name, context->out, context->out_false);
+		context_add(&ccl_in, context->in_fn,
+			    context->in, context->in);
+		context_add(&ccl_target, context->in_fn,
+			    context->out, context->out_false);
 		/* we don't currently check the body of trylock functions */
 		if (context->out != context->out_false)
 			return;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-vars.c	2008-04-26 17:15:23.000000000 +0200
@@ -0,0 +1,141 @@
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
+
+    /*
+     * &lock points to the lock within this struct
+     */
+    int val __attribute__((context(&lock,1,1)));
+};
+
+static inline void unlock(struct test *t)
+    __attribute__((context(&t->lock,1,0)))
+{
+    ri(&t->lock);
+}
+
+static void good_lock4(struct test *t)
+    __attribute__((context(&t->lock,0,1)))
+{
+    ai(&t->lock);
+}
+
+/*
+ * This test would currently fail with:
+ *
+context-vars.c:118:5: warning: context problem in 'good_use': access to 'val' requires different context
+context-vars.c:118:5:    context '&lock': wanted >= 1, got 0
+ *
+ * and
+ *
+context-vars.c:103:7: warning: context problem in 'good_use': 'ri' expected different context
+context-vars.c:103:7:    context '*t+0': wanted >= 1, got 0
+ *
+ * because arguments aren't bound properly nor does the &lock declaration
+ * within structs work the way you might thing it does.
+ *
+static void good_use(struct test *x)
+{
+    good_lock4(x);
+    x->val = 7;
+    unlock(x);
+}
+ */
+
+/*
+ * check-name: Check -Wcontext with lock variables
+ *
+ * check-error-start
+context-vars.c:53:7: warning: context imbalance in 'warn_lock1': wrong count at exit
+context-vars.c:53:7:    context '**v+4': wanted 0, got 1
+ * check-error-end
+ */
--- sparse.orig/example.c	2008-04-25 22:24:19.000000000 +0200
+++ sparse/example.c	2008-04-25 22:24:24.000000000 +0200
@@ -1121,10 +1121,10 @@ static void generate_ret(struct bb_state
 static void generate_call(struct bb_state *state, struct instruction *insn)
 {
 	int offset = 0;
-	pseudo_t arg;
+	struct argument *arg;
 
 	FOR_EACH_PTR(insn->arguments, arg) {
-		output_insn(state, "pushl %s", generic(state, arg));
+		output_insn(state, "pushl %s", generic(state, arg->p));
 		offset += 4;
 	} END_FOR_EACH_PTR(arg);
 	flush_reg(state, hardregs+0);
--- sparse.orig/linearize.c	2008-04-25 22:24:24.000000000 +0200
+++ sparse/linearize.c	2008-04-26 17:07:58.000000000 +0200
@@ -36,6 +36,13 @@ struct pseudo void_pseudo = {};
 
 static struct position current_pos;
 
+ALLOCATOR(argument, "arguments");
+
+static struct argument *alloc_argument(void)
+{
+	return __alloc_argument(0);
+}
+
 ALLOCATOR(pseudo_user, "pseudo_user");
 
 static struct instruction *alloc_instruction(int opcode, int size)
@@ -400,12 +407,12 @@ const char *show_instruction(struct inst
 		break;
 	case OP_INLINED_CALL:
 	case OP_CALL: {
-		struct pseudo *arg;
+		struct argument *arg;
 		if (insn->target && insn->target != VOID)
 			buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 		buf += sprintf(buf, "%s", show_pseudo(insn->func));
 		FOR_EACH_PTR(insn->arguments, arg) {
-			buf += sprintf(buf, ", %s", show_pseudo(arg));
+			buf += sprintf(buf, ", %s", show_pseudo(arg->p));
 		} END_FOR_EACH_PTR(arg);
 		break;
 	}
@@ -437,7 +444,11 @@ const char *show_instruction(struct inst
 		break;
 
 	case OP_CONTEXT:
-		buf += sprintf(buf, "%s%d,%d", "", insn->increment, insn->inc_false);
+		if (insn->context_expr) {
+			buf += expression_str(insn->context_expr, buf, 1000);
+			buf += sprintf(buf, ", ");
+		}
+		buf += sprintf(buf, "%d, %d", insn->increment, insn->inc_false);
 		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
@@ -1263,22 +1274,58 @@ static pseudo_t linearize_call_expressio
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
 	struct context *context;
+	struct symbol *sym, *found = NULL;
+	struct argument *narg;
+	int argnum = 0, i;
 
 	if (!expr->ctype) {
 		warning(expr->pos, "call with no type!");
 		return VOID;
 	}
 
-	FOR_EACH_PTR(expr->args, arg) {
-		pseudo_t new = linearize_expression(ep, arg);
-		use_pseudo(insn, new, add_pseudo(&insn->arguments, new));
-	} END_FOR_EACH_PTR(arg);
-
 	fn = expr->fn;
 
 	if (fn->ctype)
 		ctype = &fn->ctype->ctype;
 
+	FOR_EACH_PTR(expr->args, arg) {
+		char *ident;
+		pseudo_t new = linearize_expression(ep, arg);
+
+		narg = alloc_argument();
+		narg->e = arg;
+
+		add_ptr_list(&insn->arguments, narg);
+		use_pseudo(insn, new, &narg->p);
+		argnum++;
+
+		if (!ctype)
+			continue;
+
+		i = 0;
+
+		FOR_EACH_PTR(ctype->base_type->arguments, sym) {
+			if (i == argnum - 1)
+				found = sym;
+			i++;
+		} END_FOR_EACH_PTR(sym);
+
+		if (!found)
+			continue;
+
+		ident = strdup(show_ident(found->ident));
+
+		/* now get the context and link it to the arg */
+		FOR_EACH_PTR(ctype->contexts, context) {
+			if (context->context->type != EXPR_SYMBOL)
+				continue;
+			if (strcmp(show_ident(context->context->symbol_name),
+			           ident) == 0)
+				narg->c = context;
+		} END_FOR_EACH_PTR(context);
+		free(ident);
+	} END_FOR_EACH_PTR(arg);
+
 	if (fn->type == EXPR_PREOP) {
 		if (fn->unop->type == EXPR_SYMBOL) {
 			struct symbol *sym = fn->unop->symbol;
@@ -1302,6 +1349,15 @@ static pseudo_t linearize_call_expressio
 		FOR_EACH_PTR(ctype->contexts, context) {
 			int in = context->in;
 			int out = context->out;
+			int skip = 0;
+
+			FOR_EACH_PTR(insn->arguments, narg) {
+				if (context == narg->c)
+					skip = 1;
+			} END_FOR_EACH_PTR(narg);
+
+			if (skip)
+				continue;
 
 			if (out - in || context->out_false - in) {
 				insn = alloc_instruction(OP_CONTEXT, 0);
@@ -1719,7 +1775,9 @@ static pseudo_t linearize_inlined_call(s
 		concat_symbol_list(args->declaration, &ep->syms);
 		FOR_EACH_PTR(args->declaration, sym) {
 			pseudo_t value = linearize_one_symbol(ep, sym);
-			use_pseudo(insn, value, add_pseudo(&insn->arguments, value));
+			struct argument *narg = alloc_argument();
+			add_ptr_list(&insn->arguments, narg);
+			use_pseudo(insn, value, &narg->p);
 		} END_FOR_EACH_PTR(sym);
 	}
 
--- sparse.orig/linearize.h	2008-04-25 22:24:24.000000000 +0200
+++ sparse/linearize.h	2008-04-26 17:07:58.000000000 +0200
@@ -40,6 +40,15 @@ struct pseudo {
 	};
 };
 
+struct argument {
+	struct pseudo *p;
+	struct context *c;
+	struct expression *e;
+};
+
+DECLARE_PTR_LIST(argument_list, struct argument);
+DECLARE_ALLOCATOR(argument);
+
 extern struct pseudo void_pseudo;
 
 #define VOID (&void_pseudo)
@@ -113,7 +122,7 @@ struct instruction {
 		};
 		struct /* call */ {
 			pseudo_t func;
-			struct pseudo_list *arguments;
+			struct argument_list *arguments;
 		};
 		struct /* context */ {
 			int increment, required, inc_false, exact;
--- sparse.orig/liveness.c	2008-04-25 22:24:19.000000000 +0200
+++ sparse/liveness.c	2008-04-25 22:24:24.000000000 +0200
@@ -50,7 +50,7 @@ static void track_instruction_usage(stru
 	void (*def)(struct basic_block *, struct instruction *, pseudo_t),
 	void (*use)(struct basic_block *, struct instruction *, pseudo_t))
 {
-	pseudo_t pseudo;
+	struct argument *arg;
 
 	#define USES(x)		use(bb, insn, insn->x)
 	#define DEFINES(x)	def(bb, insn, insn->x)
@@ -125,9 +125,9 @@ static void track_instruction_usage(stru
 		USES(func);
 		if (insn->target != VOID)
 			DEFINES(target);
-		FOR_EACH_PTR(insn->arguments, pseudo) {
-			use(bb, insn, pseudo);
-		} END_FOR_EACH_PTR(pseudo);
+		FOR_EACH_PTR(insn->arguments, arg) {
+			use(bb, insn, arg->p);
+		} END_FOR_EACH_PTR(arg);
 		break;
 
 	case OP_SLICE:
--- sparse.orig/evaluate.c	2008-04-26 17:12:11.000000000 +0200
+++ sparse/evaluate.c	2008-04-26 17:12:18.000000000 +0200
@@ -3025,6 +3025,7 @@ static void check_duplicates(struct symb
 static struct symbol *evaluate_symbol(struct symbol *sym)
 {
 	struct symbol *base_type;
+	struct context *c;
 
 	if (!sym)
 		return sym;
@@ -3054,6 +3055,13 @@ static struct symbol *evaluate_symbol(st
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
--- sparse.orig/expand.c	2008-04-26 17:12:10.000000000 +0200
+++ sparse/expand.c	2008-04-26 17:12:18.000000000 +0200
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
--- sparse.orig/parse.c	2008-04-26 17:12:10.000000000 +0200
+++ sparse/parse.c	2008-04-26 17:12:18.000000000 +0200
@@ -884,11 +884,13 @@ static struct token *_attribute_context(
 {
 	struct context *context = alloc_context();
 	struct expression *args[3];
+	struct token *tok = NULL;
 	int argc = 0;
 
 	token = expect(token, '(', "after context attribute");
 	while (!match_op(token, ')')) {
 		struct expression *expr = NULL;
+		tok = tok ? : token;
 		token = conditional_expression(token, &expr);
 		if (!expr)
 			break;
@@ -914,6 +916,7 @@ static struct token *_attribute_context(
 		break;
 	case 3:
 		context->context = args[0];
+		context->token = tok;
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 		break;
@@ -2127,6 +2130,7 @@ static struct token *parse_function_body
 	struct symbol *base_type = decl->ctype.base_type;
 	struct statement *stmt, **p;
 	struct symbol *arg;
+	struct context *c;
 
 	old_symbol_list = function_symbol_list;
 	if (decl->ctype.modifiers & MOD_INLINE) {
@@ -2155,6 +2159,11 @@ static struct token *parse_function_body
 
 	token = compound_statement(token->next, stmt);
 
+	FOR_EACH_PTR(decl->ctype.contexts, c) {
+		if (c->token)
+			conditional_expression(c->token, &c->in_fn);
+	} END_FOR_EACH_PTR(c);
+
 	end_function(decl);
 	if (!(decl->ctype.modifiers & MOD_INLINE))
 		add_symbol(list, decl);
--- sparse.orig/symbol.h	2008-04-26 17:12:10.000000000 +0200
+++ sparse/symbol.h	2008-04-26 17:12:18.000000000 +0200
@@ -71,6 +71,10 @@ enum keyword {
 
 struct context {
 	struct expression *context;
+	/* store the token pointer */
+	struct token *token;
+	/* to re-evaluate this context within the function it is for */
+	struct expression *in_fn;
 	unsigned int in, out, out_false;
 	int exact;
 };


