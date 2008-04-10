From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 15:25:20 +0200
Message-ID: <20080410132617.720109000@sipsolutions.net>
References: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:56460 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbYDJOl1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 10:41:27 -0400
Content-Disposition: inline; filename=contexts.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

The sparse man page promises that it will check this:

   Functions with the extended attribute
	__attribute__((context(expression,in_context,out_context))
   require the context expression (for instance, a lock) to have the
   value in_context (a constant nonnegative integer) when called,
   and return with the value out_context (a constant nonnegative
   integer).

It doesn't keep that promise though, nor can it, especially with
contexts that can be acquired recursively (like RCU in the kernel.)


This patch makes sparse track different contexts, and also follows
up on that promise, but with slightly different semantics:

  * the "require the context to have the value" is changed to require
    it to have /at least/ the value if 'in_context',
  * an exact_context(...) attribute is introduced with the previously
    described semantics (to be used for non-recursive contexts),
  * the __context__ statement is extended to also include a required
    context argument (same at least semantics),

Unfortunately, I wasn't able to keep the same output, so now you'll
see different messages from sparse, especially when trying to unlock
a lock that isn't locked you'll see a message pointing to the unlock
function rather than complaining about the basic block, you can see
that in the test suite changes.

This patch also contains test updates and a lot of new tests for the
new functionality. Except for the changed messages, old functionality
should not be affected.

However, the kernel use of __attribute__((context(...)) is actually
wrong, the kernel often does things like:

    static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)
            __acquires(dev_base_lock)
    {
            [...]
            read_lock(&dev_base_lock);
            [...]
    }

rather than

    static void *dev_mc_seq_start(struct seq_file *seq, loff_t * pos)
            __acquires(dev_base_lock)
    {
            [...]
            __acquire__(dev_base_lock);
            read_lock(&dev_base_lock);
            [...]
    }

(and possibly more when read_lock() is annotated appropriately, such
as dropping whatever context read_lock() returns to convert the context
to the dev_base_lock one.)

Currently, sparse doesn't care, but if it's going to check the context
of functions contained within another function then we need to put the
actual __acquire__ together with acquiring the context.

The great benefit of this patch is that you can now document at least
some locking assumptions in a machine-readable way:

before:
    /* requires mylock held */
    static void myfunc(void)
    {...}

after:
    static void myfunc(void)
            __requires(mylock)
    {...}

where, for sparse,
    #define __requires(x) __attribute__((context(x,1,1)))

Doing so may result in lots of other functions that need to be annoated
along with it because they also have the same locking requirements, but
ultimately sparse can check a lot of locking assumptions that way.


I have already used this patch and identify a number of kernel bugs by
marking things to require certain locks or RCU-protection and checking
sparse output. To do that, you need a few kernel patches which I'll
send separately.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 inline.c                       |   12 
 linearize.c                    |   10 
 linearize.h                    |    2 
 parse.c                        |   82 +++++-
 parse.h                        |    3 
 sparse.1                       |   32 +-
 sparse.c                       |  209 +++++++++++++----
 symbol.h                       |    1 
 validation/context-named.c     |  496 +++++++++++++++++++++++++++++++++++++++++
 validation/context-statement.c |   58 ++++
 validation/context.c           |   40 ++-
 11 files changed, 860 insertions(+), 85 deletions(-)

--- sparse.orig/sparse.c	2008-04-10 11:02:06.000000000 +0200
+++ sparse/sparse.c	2008-04-10 11:02:42.000000000 +0200
@@ -24,77 +24,184 @@
 #include "expression.h"
 #include "linearize.h"
 
-static int context_increase(struct basic_block *bb, int entry)
+struct context_check {
+	int val;
+	char name[32];
+};
+
+DECLARE_ALLOCATOR(context_check);
+DECLARE_PTR_LIST(context_check_list, struct context_check);
+ALLOCATOR(context_check, "context check list");
+
+static const char *unnamed_context = "<unnamed>";
+
+static const char *context_name(struct context *context)
 {
-	int sum = 0;
-	struct instruction *insn;
+	if (context->context && context->context->symbol_name)
+		return show_ident(context->context->symbol_name);
+	return unnamed_context;
+}
 
-	FOR_EACH_PTR(bb->insns, insn) {
-		int val;
-		if (insn->opcode != OP_CONTEXT)
-			continue;
-		val = insn->increment;
-		if (insn->check) {
-			int current = sum + entry;
-			if (!val) {
-				if (!current)
-					continue;
-			} else if (current >= val)
-				continue;
-			warning(insn->pos, "context check failure");
+static void context_add(struct context_check_list **ccl, const char *name, int offs)
+{
+	struct context_check *check, *found = NULL;
+
+	FOR_EACH_PTR(*ccl, check) {
+		if (strcmp(name, check->name))
 			continue;
-		}
-		sum += val;
-	} END_FOR_EACH_PTR(insn);
-	return sum;
+		found = check;
+		break;
+	} END_FOR_EACH_PTR(check);
+
+	if (!found) {
+		found = __alloc_context_check(0);
+		strncpy(found->name, name, sizeof(found->name));
+		found->name[sizeof(found->name) - 1] = '\0';
+		add_ptr_list(ccl, found);
+	}
+	found->val += offs;
 }
 
-static int imbalance(struct entrypoint *ep, struct basic_block *bb, int entry, int exit, const char *why)
+static int imbalance(struct entrypoint *ep, struct position pos, const char *name, const char *why)
 {
 	if (Wcontext) {
 		struct symbol *sym = ep->name;
-		warning(bb->pos, "context imbalance in '%s' - %s", show_ident(sym->ident), why);
+		if (strcmp(name, unnamed_context))
+			warning(pos, "context imbalance in '%s' - %s (%s)", show_ident(sym->ident), why, name);
+		else
+			warning(pos, "context imbalance in '%s' - %s", show_ident(sym->ident), why);
 	}
 	return -1;
 }
 
-static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int entry, int exit);
+static int context_list_check(struct entrypoint *ep, struct position pos,
+			      struct context_check_list *ccl_cur,
+			      struct context_check_list *ccl_target)
+{
+	struct context_check *c1, *c2;
+	int cur, tgt;
+
+	/* make sure the loop below checks all */
+	FOR_EACH_PTR(ccl_target, c1) {
+		context_add(&ccl_cur, c1->name, 0);
+	} END_FOR_EACH_PTR(c1);
+
+	FOR_EACH_PTR(ccl_cur, c1) {
+		cur = c1->val;
+		tgt = 0;
+
+		FOR_EACH_PTR(ccl_target, c2) {
+			if (strcmp(c2->name, c1->name))
+				continue;
+			tgt = c2->val;
+			break;
+		} END_FOR_EACH_PTR(c2);
+
+		if (cur > tgt)
+			return imbalance(ep, pos, c1->name, "wrong count at exit");
+		else if (cur < tgt)
+			return imbalance(ep, pos, c1->name, "unexpected unlock");
+	} END_FOR_EACH_PTR(c1);
 
-static int check_children(struct entrypoint *ep, struct basic_block *bb, int entry, int exit)
+	return 0;
+}
+
+static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
+			    struct context_check_list *ccl_in,
+			    struct context_check_list *ccl_target)
 {
+	struct context_check_list *combined = NULL;
+	struct context_check *c;
 	struct instruction *insn;
 	struct basic_block *child;
+	struct context *ctx;
+	const char *name;
+	int ok, val;
+
+	/* recurse in once to catch bad loops */
+	if (bb->context > 0)
+		return 0;
+
+	bb->context++;
+
+	FOR_EACH_PTR(ccl_in, c) {
+		context_add(&combined, c->name, c->val);
+	} END_FOR_EACH_PTR(c);
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		switch (insn->opcode) {
+		case OP_CALL:
+			if (!insn->func || !insn->func->sym || insn->func->type != PSEUDO_SYM)
+				break;
+			FOR_EACH_PTR(insn->func->sym->ctype.contexts, ctx) {
+				name = context_name(ctx);
+				val = 0;
+
+				FOR_EACH_PTR(combined, c) {
+					if (strcmp(c->name, name) == 0) {
+						val = c->val;
+						break;
+					}
+				} END_FOR_EACH_PTR(c);
+
+				if (ctx->exact)
+					ok = ctx->in == val;
+				else
+					ok = ctx->in <= val;
+
+				if (!ok) {
+					const char *call = strdup(show_ident(insn->func->ident));
+					warning(insn->pos, "context problem in '%s' - function '%s' expected different context",
+						show_ident(ep->name->ident), call);
+					free((void *)call);
+					return -1;
+				}
+			} END_FOR_EACH_PTR (ctx);
+			break;
+		case OP_CONTEXT:
+			val = 0;
+
+			name = unnamed_context;
+			if (insn->context_expr)
+				name = show_ident(insn->context_expr->symbol_name);
+
+			FOR_EACH_PTR(combined, c) {
+				if (strcmp(c->name, name) == 0) {
+					val = c->val;
+					break;
+				}
+			} END_FOR_EACH_PTR(c);
+
+			ok = insn->required <= val;
+
+			if (!ok) {
+				name = strdup(name);
+				imbalance(ep, insn->pos, name, "__context__ statement expected different lock context");
+				free((void *)name);
+				return -1;
+			}
+			context_add(&combined, name, insn->increment);
+			break;
+ 		}
+	} END_FOR_EACH_PTR(insn);
 
 	insn = last_instruction(bb->insns);
 	if (!insn)
 		return 0;
 	if (insn->opcode == OP_RET)
-		return entry != exit ? imbalance(ep, bb, entry, exit, "wrong count at exit") : 0;
+		return context_list_check(ep, insn->pos, combined, ccl_target);
 
 	FOR_EACH_PTR(bb->children, child) {
-		if (check_bb_context(ep, child, entry, exit))
+		if (check_bb_context(ep, child, combined, ccl_target))
 			return -1;
 	} END_FOR_EACH_PTR(child);
-	return 0;
-}
 
-static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, int entry, int exit)
-{
-	if (!bb)
-		return 0;
-	if (bb->context == entry)
-		return 0;
+	/* contents will be freed once we return out of recursion */
+	free_ptr_list(&combined);
 
-	/* Now that's not good.. */
-	if (bb->context >= 0)
-		return imbalance(ep, bb, entry, bb->context, "different lock contexts for basic block");
-
-	bb->context = entry;
-	entry += context_increase(bb, entry);
-	if (entry < 0)
-		return imbalance(ep, bb, entry, exit, "unexpected unlock");
-
-	return check_children(ep, bb, entry, exit);
+	return 0;
 }
 
 static void check_cast_instruction(struct instruction *insn)
@@ -235,7 +342,7 @@ static void check_context(struct entrypo
 {
 	struct symbol *sym = ep->name;
 	struct context *context;
-	unsigned int in_context = 0, out_context = 0;
+	struct context_check_list *ccl_in = NULL, *ccl_target = NULL;
 
 	if (Wuninitialized && verbose && ep->entry->bb->needs) {
 		pseudo_t pseudo;
@@ -249,10 +356,16 @@ static void check_context(struct entrypo
 	check_instructions(ep);
 
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		in_context += context->in;
-		out_context += context->out;
+		const char *name = context_name(context);
+
+		context_add(&ccl_in, name, context->in);
+		context_add(&ccl_target, name, context->out);
 	} END_FOR_EACH_PTR(context);
-	check_bb_context(ep, ep->entry->bb, in_context, out_context);
+
+	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target);
+	free_ptr_list(&ccl_in);
+	free_ptr_list(&ccl_target);
+	clear_context_check_alloc();
 }
 
 static void check_symbols(struct symbol_list *list)
--- sparse.orig/validation/context.c	2008-04-10 11:02:06.000000000 +0200
+++ sparse/validation/context.c	2008-04-10 11:02:42.000000000 +0200
@@ -314,23 +314,35 @@ static void warn_cond_lock1(void)
         condition2 = 1; /* do stuff */
     r();
 }
+
+static void warn_odd_looping(void)
+{
+    int i;
+
+    for (i = 0; i < 2; i++)
+        a();
+    for (i = 0; i < 2; i++)
+        r();
+}
+
 /*
  * check-name: Check -Wcontext
  *
  * check-error-start
-context.c:69:13: warning: context imbalance in 'warn_lock1' - wrong count at exit
-context.c:74:13: warning: context imbalance in 'warn_lock2' - wrong count at exit
-context.c:81:13: warning: context imbalance in 'warn_lock3' - wrong count at exit
-context.c:88:13: warning: context imbalance in 'warn_unlock1' - unexpected unlock
-context.c:93:13: warning: context imbalance in 'warn_unlock2' - unexpected unlock
-context.c:131:12: warning: context imbalance in 'warn_if1' - wrong count at exit
-context.c:140:12: warning: context imbalance in 'warn_if2' - different lock contexts for basic block
-context.c:202:2: warning: context imbalance in 'warn_while1' - different lock contexts for basic block
-context.c:210:3: warning: context imbalance in 'warn_while2' - unexpected unlock
-context.c:216:2: warning: context imbalance in 'warn_while3' - wrong count at exit
-context.c:274:13: warning: context imbalance in 'warn_goto1' - wrong count at exit
-context.c:283:13: warning: context imbalance in 'warn_goto2' - wrong count at exit
-context.c:300:5: warning: context imbalance in 'warn_goto3' - different lock contexts for basic block
-context.c:315:5: warning: context imbalance in 'warn_cond_lock1' - different lock contexts for basic block
+context.c:71:3: warning: context imbalance in 'warn_lock1' - wrong count at exit
+context.c:78:3: warning: context imbalance in 'warn_lock2' - wrong count at exit
+context.c:85:3: warning: context imbalance in 'warn_lock3' - wrong count at exit
+context.c:90:3: warning: context problem in 'warn_unlock1' - function 'r' expected different context
+context.c:97:3: warning: context problem in 'warn_unlock2' - function 'r' expected different context
+context.c:137:9: warning: context imbalance in 'warn_if1' - wrong count at exit
+context.c:147:9: warning: context imbalance in 'warn_if2' - wrong count at exit
+context.c:203:4: warning: context imbalance in 'warn_while1' - wrong count at exit
+context.c:210:4: warning: context problem in 'warn_while2' - function 'r' expected different context
+context.c:220:4: warning: context imbalance in 'warn_while3' - wrong count at exit
+context.c:280:5: warning: context imbalance in 'warn_goto1' - wrong count at exit
+context.c:290:6: warning: context imbalance in 'warn_goto2' - wrong count at exit
+context.c:300:6: warning: context problem in 'warn_goto3' - function 'r' expected different context
+context.c:315:6: warning: context problem in 'warn_cond_lock1' - function 'r' expected different context
+context.c:325:10: warning: context problem in 'warn_odd_looping' - function 'r' expected different context
  * check-error-end
  */
--- sparse.orig/parse.c	2008-04-10 11:02:06.000000000 +0200
+++ sparse/parse.c	2008-04-10 11:02:42.000000000 +0200
@@ -66,6 +66,7 @@ static struct token *attribute_address_s
 static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
 
@@ -184,6 +185,10 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
+static struct symbol_op exact_context_op = {
+	.attribute = attribute_exact_context,
+};
+
 static struct symbol_op transparent_union_op = {
 	.attribute = attribute_transparent_union,
 };
@@ -265,6 +270,7 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "exact_context",	NS_KEYWORD,	.op = &exact_context_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
@@ -863,7 +869,7 @@ static struct token *attribute_mode(stru
 	return token;
 }
 
-static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+static struct token *_attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype, int exact)
 {
 	struct context *context = alloc_context();
 	struct expression *args[3];
@@ -877,6 +883,8 @@ static struct token *attribute_context(s
 			break;
 		if (argc < 3)
 			args[argc++] = expr;
+		else
+			argc++;
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -898,8 +906,13 @@ static struct token *attribute_context(s
 		context->in = get_expression_value(args[1]);
 		context->out = get_expression_value(args[2]);
 		break;
+	default:
+		sparse_error(token->pos, "too many arguments to context attribute");
+		break;
 	}
 
+	context->exact = exact;
+
 	if (argc)
 		add_ptr_list(&ctype->contexts, context);
 
@@ -907,6 +920,16 @@ static struct token *attribute_context(s
 	return token;
 }
 
+static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	return _attribute_context(token, attr, ctype, 0);
+}
+
+static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	return _attribute_context(token, attr, ctype, 1);
+}
+
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	if (Wtransparent_union)
@@ -1738,17 +1761,56 @@ static struct token *parse_goto_statemen
 
 static struct token *parse_context_statement(struct token *token, struct statement *stmt)
 {
+	struct expression *args[3];
+	int argc = 0;
+
 	stmt->type = STMT_CONTEXT;
-	token = parse_expression(token->next, &stmt->expression);
-	if(stmt->expression->type == EXPR_PREOP
-	   && stmt->expression->op == '('
-	   && stmt->expression->unop->type == EXPR_COMMA) {
-		struct expression *expr;
-		expr = stmt->expression->unop;
-		stmt->context = expr->left;
-		stmt->expression = expr->right;
+	token = token->next;
+	token = expect(token, '(', "after __context__ statement");
+	while (!match_op(token, ')')) {
+		struct expression *expr = NULL;
+		token = conditional_expression(token, &expr);
+		if (!expr)
+			break;
+		if (argc < 3)
+			args[argc++] = expr;
+		else
+			argc++;
+		if (!match_op(token, ','))
+			break;
+		token = token->next;
 	}
-	return expect(token, ';', "at end of statement");
+
+	stmt->expression = args[0];
+	stmt->context = NULL;
+
+	switch (argc) {
+	case 0:
+		sparse_error(token->pos, "__context__ statement needs argument(s)");
+		return token;
+	case 1:
+		/* already done */
+		break;
+	case 2:
+		if (args[0]->type != STMT_EXPRESSION) {
+			stmt->context = args[0];
+			stmt->expression = args[1];
+		} else {
+			stmt->expression = args[0];
+			stmt->required = args[1];
+		}
+		break;
+	case 3:
+		stmt->context = args[0];
+		stmt->expression = args[1];
+		stmt->required = args[2];
+		break;
+	default:
+		sparse_error(token->pos, "too many arguments for __context__ statement");
+		return token->next;
+	}
+
+	return expect(token, ')', "at end of __context__");
 }
 
 static struct token *parse_range_statement(struct token *token, struct statement *stmt)
--- sparse.orig/symbol.h	2008-04-10 11:02:06.000000000 +0200
+++ sparse/symbol.h	2008-04-10 11:02:42.000000000 +0200
@@ -72,6 +72,7 @@ enum keyword {
 struct context {
 	struct expression *context;
 	unsigned int in, out;
+	int exact;
 };
 
 extern struct context *alloc_context(void);
--- sparse.orig/sparse.1	2008-04-10 11:02:07.000000000 +0200
+++ sparse/sparse.1	2008-04-10 11:02:42.000000000 +0200
@@ -73,20 +73,34 @@ Warn about potential errors in synchroni
 Sparse supports several means of designating functions or statements that
 delimit contexts, such as synchronization.  Functions with the extended
 attribute
-.BI __attribute__((context( expression , in_context , out_context ))
-require the context \fIexpression\fR (for instance, a lock) to have the value
+.BI __attribute__((context( [expression ,] in_context , out_context ))
+require the context \fIexpression\fR (for instance, a lock) to have at least the value
 \fIin_context\fR (a constant nonnegative integer) when called, and return with
-the value \fIout_context\fR (a constant nonnegative integer).  For APIs
-defined via macros, use the statement form
-.BI __context__( expression , in_value , out_value )
-in the body of the macro.
+the value adjusted by \fIout_context - in_context\fR (where
+\fIout_context\fR is a constant nonnegative integer).  To change the value
+of a context (for example in macros), use the statement
+.BI __context__( [expression , ]adjust_value[ , required] )
+where \fIadjust_value\fR is a constant integer and \fIrequired\fR is a
+constant nonnegative integer. Not giving \fIrequired\fR is equivalent to
+giving zero and means that the statement does not need the context as a
+precondition, when given it means that the context must at least have the
+value of \fIrequired\fR.
+
+To indicate that a function requires
+.BI exactly
+a certain lock context (not "at least" as above), use the form
+.BI __attribute__((exact_context( [expression ,] in_context , out_context ))
+There currently is no corresponding
+.BI __exact_context__( [expression , ]adjust_value[ , required] )
+statement.
 
-With \fB-Wcontext\fR Sparse will warn when it sees a function change the
-context without indicating this with a \fBcontext\fR attribute, either by
+Sparse will warn when it sees a function change a
+context without indicating this with a \fBcontext\fR or \fBexact_context\fR attribute, either by
 decreasing a context below zero (such as by releasing a lock without acquiring
 it), or returning with a changed context (such as by acquiring a lock without
 releasing it).  Sparse will also warn about blocks of code which may
-potentially execute with different contexts.
+potentially execute with different contexts and about functions that are
+executed without a lock they require.
 
 Sparse issues these warnings by default.  To turn them off, use
 \fB\-Wno\-context\fR.
--- sparse.orig/inline.c	2008-04-10 11:02:06.000000000 +0200
+++ sparse/inline.c	2008-04-10 11:02:42.000000000 +0200
@@ -331,10 +331,18 @@ static struct statement *copy_one_statem
 	case STMT_CONTEXT:
 	case STMT_EXPRESSION: {
 		struct expression *expr = copy_expression(stmt->expression);
+		struct statement *newstmt;
 		if (expr == stmt->expression)
 			break;
-		stmt = dup_statement(stmt);
-		stmt->expression = expr;
+		newstmt = dup_statement(stmt);
+		newstmt->expression = expr;
+		if (stmt->required) {
+			expr = copy_expression(stmt->required);
+			if (expr == stmt->required)
+				break;
+			newstmt->required = expr;
+		}
+		stmt = newstmt;
 		break;
 	}
 	case STMT_RANGE: {
--- sparse.orig/linearize.c	2008-04-10 11:02:07.000000000 +0200
+++ sparse/linearize.c	2008-04-10 11:02:42.000000000 +0200
@@ -1247,6 +1247,7 @@ static pseudo_t linearize_call_expressio
 			if (check || context_diff) {
 				insn = alloc_instruction(OP_CONTEXT, 0);
 				insn->increment = context_diff;
+				/* what's check for? */
 				insn->check = check;
 				insn->context_expr = context->context;
 				add_one_insn(ep, insn);
@@ -1683,6 +1684,15 @@ static pseudo_t linearize_context(struct
 		value = expr->value;
 
 	insn->increment = value;
+
+	expr = stmt->required;
+	value = 0;
+
+	if (expr && expr->type == EXPR_VALUE)
+		value = expr->value;
+
+	insn->required = value;
+
 	insn->context_expr = stmt->context;
 	add_one_insn(ep, insn);
 	return VOID;
--- sparse.orig/linearize.h	2008-04-10 11:02:07.000000000 +0200
+++ sparse/linearize.h	2008-04-10 11:02:42.000000000 +0200
@@ -116,7 +116,7 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment;
+			int increment, required;
 			int check;
 			struct expression *context_expr;
 		};
--- sparse.orig/parse.h	2008-04-10 11:02:07.000000000 +0200
+++ sparse/parse.h	2008-04-10 11:02:42.000000000 +0200
@@ -39,9 +39,10 @@ struct statement {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
-		struct {
+		struct { /* __context__ */
 			struct expression *expression;
 			struct expression *context;
+			struct expression *required;
 		};
 		struct /* return_statement */ {
 			struct expression *ret_value;
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-statement.c	2008-04-10 11:02:42.000000000 +0200
@@ -0,0 +1,58 @@
+#define a() __context__(LOCK, 1)
+#define r() __context__(LOCK, -1)
+#define m() __context__(LOCK, 0, 1)
+#define m2() __context__(LOCK, 0, 2)
+
+static void good_ar(void)
+{
+    a();
+    r();
+}
+
+static void bad_arr(void)
+{
+    a();
+    r();
+    r();
+}
+
+static void good_macro1(void)
+{
+    a();
+    m();
+    r();
+}
+
+static void good_macro2(void)
+{
+    a();
+    a();
+    m();
+    m2();
+    r();
+    r();
+}
+
+static void bad_macro1(void)
+{
+    m();
+    a();
+    r();
+}
+
+static void bad_macro2(void)
+{
+    a();
+    r();
+    m();
+}
+
+/*
+ * check-name: Check __context__ statement with required context
+ *
+ * check-error-start
+context-statement.c:16:8: warning: context imbalance in 'bad_arr' - unexpected unlock (LOCK)
+context-statement.c:38:5: warning: context imbalance in 'bad_macro1' - __context__ statement expected different lock context (LOCK)
+context-statement.c:47:5: warning: context imbalance in 'bad_macro2' - __context__ statement expected different lock context (LOCK)
+ * check-error-end
+ */
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-named.c	2008-04-10 11:02:42.000000000 +0200
@@ -0,0 +1,496 @@
+static void a(void) __attribute__((context(TEST,0,1)))
+{
+	__context__(TEST,1);
+}
+
+static void r(void) __attribute__((context(TEST,1,0)))
+{
+	__context__(TEST,-1,1);
+}
+
+static void a2(void) __attribute__((context(TEST2,0,1)))
+{
+	__context__(TEST2,1);
+}
+
+static void r2(void) __attribute__((context(TEST2,1,0)))
+{
+	__context__(TEST2,-1,1);
+}
+
+#define check_test2() __context__(TEST2,0,1)
+
+static void good_paired1(void)
+{
+	a();
+	a2();
+	r();
+	r2();
+}
+
+static void good_paired2(void)
+{
+	a();
+	r();
+	a();
+	r();
+	a2();
+	r2();
+}
+
+static void good_paired3(void)
+{
+	a();
+	a();
+	r();
+	r();
+	a2();
+	a2();
+	r2();
+	r2();
+}
+
+static void good_lock1(void) __attribute__((context(TEST,0,1)))
+{
+	a();
+}
+
+static void good_lock2(void) __attribute__((context(TEST,0,1)))
+{
+	a();
+	r();
+	a();
+}
+
+static void good_lock3(void) __attribute__((context(TEST,0,1)))
+{
+	a();
+	a();
+	r();
+}
+
+static void good_unlock1(void) __attribute__((context(TEST,1,0)))
+{
+	r();
+}
+
+static void good_unlock2(void) __attribute__((context(TEST,1,0)))
+{
+	a();
+	r();
+	r();
+}
+
+static void warn_lock1(void)
+{
+	a();
+}
+
+static void warn_lock2(void)
+{
+	a();
+	r();
+	a();
+}
+
+static void warn_lock3(void)
+{
+	a();
+	a();
+	r();
+}
+
+static void warn_unlock1(void)
+{
+	r();
+}
+
+static void warn_unlock2(void)
+{
+	a();
+	r();
+	r();
+}
+
+extern int condition, condition2;
+
+static int good_if1(void)
+{
+	a();
+	if(condition) {
+		r();
+		return -1;
+	}
+	r();
+	return 0;
+}
+
+static void good_if2(void)
+{
+	if(condition) {
+		a();
+		r();
+	}
+}
+
+static void good_if3(void)
+{
+	a();
+	if(condition) {
+		a();
+		r();
+	}
+	r();
+}
+
+static int warn_if1(void)
+{
+	a();
+	if(condition)
+		return -1;
+	r();
+	return 0;
+}
+
+static int warn_if2(void)
+{
+	a();
+	if(condition) {
+		r();
+		return -1;
+	}
+	return 0;
+}
+
+static void good_while1(void)
+{
+	a();
+	while(condition)
+		;
+	r();
+}
+
+static void good_while2(void)
+{
+	while(condition) {
+		a();
+		r();
+	}
+}
+
+static void good_while3(void)
+{
+	while(condition) {
+		a();
+		r();
+		if(condition2)
+			break;
+		a();
+		r();
+	}
+}
+
+static void good_while4(void)
+{
+	a();
+	while(1) {
+		if(condition2) {
+			r();
+			break;
+		}
+	}
+}
+
+static void good_while5(void)
+{
+	a();
+	while(1) {
+		r();
+		if(condition2)
+			break;
+		a();
+	}
+}
+
+static void warn_while1(void)
+{
+	while(condition) {
+		a();
+	}
+}
+
+static void warn_while2(void)
+{
+	while(condition) {
+		r();
+	}
+}
+
+static void warn_while3(void)
+{
+	while(condition) {
+		a();
+		if(condition2)
+			break;
+		r();
+	}
+}
+
+static void good_goto1(void)
+{
+    a();
+    goto label;
+label:
+    r();
+}
+
+static void good_goto2(void)
+{
+    a();
+    goto label;
+    a();
+    r();
+label:
+    r();
+}
+
+static void good_goto3(void)
+{
+    a();
+    if(condition)
+        goto label;
+    a();
+    r();
+label:
+    r();
+}
+
+static void good_goto4(void)
+{
+    if(condition)
+        goto label;
+    a();
+    r();
+label:
+    ;
+}
+
+static void good_goto5(void)
+{
+    a();
+    if(condition)
+        goto label;
+    r();
+    return;
+label:
+    r();
+}
+
+static void warn_goto1(void)
+{
+    a();
+    goto label;
+    r();
+label:
+    ;
+}
+
+static void warn_goto2(void)
+{
+    a();
+    goto label;
+    r();
+label:
+    a();
+    r();
+}
+
+static void warn_goto3(void)
+{
+    a();
+    if(condition)
+        goto label;
+    r();
+label:
+    r();
+}
+
+static void warn_multiple1(void)
+{
+    a();
+    a2();
+}
+
+static void warn_multiple2(void)
+{
+    a2();
+    a();
+}
+
+static void warn_mixed1(void)
+{
+    a2();
+    r();
+}
+
+static void warn_mixed2(void)
+{
+    a2();
+    if (condition) {
+        a();
+        r2();
+    }
+    r();
+}
+
+static void warn_mixed3(void)
+{
+    a2();
+    if (condition) {
+        r2();
+        return;
+    }
+    r();
+}
+
+static void warn_mixed4(void)
+{
+    a2();
+    if (condition) {
+        a();
+        r();
+        return;
+    }
+    r();
+}
+
+static void good_mixed1(void)
+{
+    if (condition) {
+        a();
+        r();
+    } else {
+        a2();
+        r2();
+    }
+}
+
+static void good_mixed2(void)
+{
+    if (condition) {
+        a();
+        r();
+    }
+    a2();
+    r2();
+}
+
+static int need_lock(void) __attribute__((context(TEST,1,1)))
+{
+}
+
+static void need_lock_exact(void) __attribute__((exact_context(TEST,1,1)))
+{
+}
+
+static void need_lock2(void) __attribute__((context(TEST,1,1)))
+{
+    need_lock();
+}
+
+static void good_fn(void)
+{
+    a();
+    need_lock();
+    r();
+}
+
+static void good_fn2(void)
+{
+    a();
+    a();
+    need_lock();
+    r();
+    r();
+}
+
+static void good_fn2(void)
+{
+    a();
+    if (condition)
+        need_lock();
+    r();
+}
+
+static void good_fn3(void) __attribute__((context(TEST,1,1)))
+{
+    if (condition)
+        need_lock2();
+}
+
+static void warn_fn(void)
+{
+    a2();
+    need_lock();
+    r2();
+}
+
+static void warn_fn2(void)
+{
+    a2();
+    need_lock2();
+    r2();
+}
+
+static void good_exact_fn(void)
+{
+    a();
+    need_lock_exact();
+    r();
+}
+
+static void warn_exact_fn1(void)
+{
+    a();
+    a();
+    need_lock_exact();
+    r();
+    r();
+}
+
+static void warn_exact_fn2(void)
+{
+    a2();
+    need_lock_exact();
+    r2();
+}
+
+/*
+ * check-name: Check -Wcontext with lock names
+ *
+ * check-error-start
+context-named.c:86:3: warning: context imbalance in 'warn_lock1' - wrong count at exit (TEST)
+context-named.c:93:3: warning: context imbalance in 'warn_lock2' - wrong count at exit (TEST)
+context-named.c:100:3: warning: context imbalance in 'warn_lock3' - wrong count at exit (TEST)
+context-named.c:105:3: warning: context problem in 'warn_unlock1' - function 'r' expected different context
+context-named.c:112:3: warning: context problem in 'warn_unlock2' - function 'r' expected different context
+context-named.c:152:9: warning: context imbalance in 'warn_if1' - wrong count at exit (TEST)
+context-named.c:162:9: warning: context imbalance in 'warn_if2' - wrong count at exit (TEST)
+context-named.c:218:4: warning: context imbalance in 'warn_while1' - wrong count at exit (TEST)
+context-named.c:225:4: warning: context problem in 'warn_while2' - function 'r' expected different context
+context-named.c:235:4: warning: context imbalance in 'warn_while3' - wrong count at exit (TEST)
+context-named.c:295:5: warning: context imbalance in 'warn_goto1' - wrong count at exit (TEST)
+context-named.c:305:6: warning: context imbalance in 'warn_goto2' - wrong count at exit (TEST)
+context-named.c:315:6: warning: context problem in 'warn_goto3' - function 'r' expected different context
+context-named.c:321:7: warning: context imbalance in 'warn_multiple1' - wrong count at exit (TEST)
+context-named.c:327:6: warning: context imbalance in 'warn_multiple2' - wrong count at exit (TEST2)
+context-named.c:333:6: warning: context problem in 'warn_mixed1' - function 'r' expected different context
+context-named.c:343:6: warning: context problem in 'warn_mixed2' - function 'r' expected different context
+context-named.c:353:6: warning: context problem in 'warn_mixed3' - function 'r' expected different context
+context-named.c:364:6: warning: context imbalance in 'warn_mixed4' - wrong count at exit (TEST2)
+context-named.c:434:14: warning: context problem in 'warn_fn' - function 'need_lock' expected different context
+context-named.c:441:15: warning: context problem in 'warn_fn2' - function 'need_lock2' expected different context
+context-named.c:456:20: warning: context problem in 'warn_exact_fn1' - function 'need_lock_exact' expected different context
+context-named.c:464:20: warning: context problem in 'warn_exact_fn2' - function 'need_lock_exact' expected different context
+ * check-error-end
+ */

-- 

