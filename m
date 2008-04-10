From: Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [PATCH 1/3] make sparse keep its promise about context tracking
Date: Thu, 10 Apr 2008 17:24:26 +0200
Message-ID: <200804101724.27382.philipp.reisner@linbit.com>
References: <20080410132519.049821000@sipsolutions.net> <20080410132617.720109000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from aug.linbit.com ([212.69.162.22]:59647 "EHLO mail.linbit.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758066AbYDJPYb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 11:24:31 -0400
In-Reply-To: <20080410132617.720109000@sipsolutions.net>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

Am Donnerstag, 10. April 2008 15:25:20 schrieb Johannes Berg:
> The sparse man page promises that it will check this:
>
>    Functions with the extended attribute
> 	__attribute__((context(expression,in_context,out_context))
>    require the context expression (for instance, a lock) to have the
>    value in_context (a constant nonnegative integer) when called,
>    and return with the value out_context (a constant nonnegative
>    integer).
>
> It doesn't keep that promise though, nor can it, especially with
> contexts that can be acquired recursively (like RCU in the kernel.)
>

Hi Josh,
Hi Johannes,

I just have implemented nearly the same here. Hopefully Josh will
decide for one of these patches soon.

diff --git a/expression.c b/expression.c
index 289927a..00cfb00 100644
--- a/expression.c
+++ b/expression.c
@@ -929,4 +929,76 @@ struct token *parse_expression(struct token *token, 
struct expression **tree)
 	return comma_expression(token,tree);
 }
 
+int ident_equal(struct ident *ident1, struct ident *ident2)
+{
+	return ident1->len == ident2->len &&
+		!strncmp(ident1->name, ident2->name, ident1->len);
+}
+
+int expressions_equal(struct expression *expr1, struct expression *expr2)
+{
+	if (expr1 == expr2)
+		return 1;
+
+	if (expr1 == NULL || expr2 == NULL)
+		return 0;
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
+		printf("Missing code in expressions_equal for %d\n", expr1->type);
+	}
+
+	return 0;
+}
 
diff --git a/expression.h b/expression.h
index 5136b9b..e89ddb7 100644
--- a/expression.h
+++ b/expression.h
@@ -216,4 +216,5 @@ struct token *compound_statement(struct token *, struct 
statement *);
 void cast_value(struct expression *expr, struct symbol *newtype,
 	struct expression *old, struct symbol *oldtype);
 
+extern int expressions_equal(struct expression *expr1, struct expression 
*expr2);
 #endif
diff --git a/linearize.c b/linearize.c
index 8a68f05..5aae3d6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -67,6 +67,7 @@ static struct basic_block *alloc_basic_block(struct 
entrypoint *ep, struct posit
 {
 	struct basic_block *bb = __alloc_basic_block(0);
 	bb->context = -1;
+	bb->context_expr = NULL;
 	bb->pos = pos;
 	bb->ep = ep;
 	return bb;
diff --git a/linearize.h b/linearize.h
index 7b2961b..a71f9aa 100644
--- a/linearize.h
+++ b/linearize.h
@@ -225,6 +225,7 @@ struct basic_block {
 	struct position pos;
 	unsigned long generation;
 	int context;
+	struct expression *context_expr;
 	struct entrypoint *ep;
 	struct basic_block_list *parents; /* sources */
 	struct basic_block_list *children; /* destinations */
diff --git a/sparse.c b/sparse.c
index 4026ba7..50c5e51 100644
--- a/sparse.c
+++ b/sparse.c
@@ -24,7 +24,110 @@
 #include "expression.h"
 #include "linearize.h"
 
-static int context_increase(struct basic_block *bb, int entry)
+
+int ident_str(struct ident *ident, char *buffer, int length)
+{
+	return snprintf(buffer, length, "%.*s", ident->len, ident->name);
+}
+
+
+int expression_str(struct expression *expr, char *buffer, int length)
+{
+	int n;
+
+	if (!expr) {
+		buffer[0] = 0;
+		return 0;
+	}
+
+	/* TODO, think about necessary braces () */
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
+		return snprintf(buffer, length, "%.*s", expr->string->length, 
expr->string->data);
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
+		printf("Missing code in expression_str for %d\n", expr->type);
+	}
+
+	return 0;
+}
+
+char *expression_sstr(struct expression *expr)
+{
+	static char expr_string[37] = " for ";
+	static char empty[] = "";
+
+	return expression_str(expr, expr_string+5, 32) ? expr_string : empty;
+}
+
+static int context_increase(struct basic_block *bb, struct expression *expr, 
int entry)
 {
 	int sum = 0;
 	struct instruction *insn;
@@ -33,6 +136,8 @@ static int context_increase(struct basic_block *bb, int 
entry)
 		int val;
 		if (insn->opcode != OP_CONTEXT)
 			continue;
+		if (!expressions_equal(expr, insn->context_expr))
+			continue;
 		val = insn->increment;
 		if (insn->check) {
 			int current = sum + entry;
@@ -49,18 +154,19 @@ static int context_increase(struct basic_block *bb, int 
entry)
 	return sum;
 }
 
-static int imbalance(struct entrypoint *ep, struct basic_block *bb, int 
entry, int exit, const char *why)
+static int imbalance(struct basic_block *bb, struct expression *expr, int 
entry, int exit, const char *why)
 {
 	if (Wcontext) {
-		struct symbol *sym = ep->name;
-		warning(bb->pos, "context imbalance in '%s' - %s", show_ident(sym->ident), 
why);
+		struct symbol *sym = bb->ep->name;
+		warning(bb->pos, "context imbalance in '%s' - %s%s", 
show_ident(sym->ident), why,
+			expression_sstr(expr));
 	}
 	return -1;
 }
 
-static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, 
int entry, int exit);
+static int check_bb_context(struct basic_block *bb, struct expression *expr, 
int entry, int exit);
 
-static int check_children(struct entrypoint *ep, struct basic_block *bb, int 
entry, int exit)
+static int check_children(struct basic_block *bb, struct expression *expr, 
int entry, int exit)
 {
 	struct instruction *insn;
 	struct basic_block *child;
@@ -69,32 +175,36 @@ static int check_children(struct entrypoint *ep, struct 
basic_block *bb, int ent
 	if (!insn)
 		return 0;
 	if (insn->opcode == OP_RET)
-		return entry != exit ? imbalance(ep, bb, entry, exit, "wrong count at 
exit") : 0;
+		return entry != exit ? imbalance(bb, expr, entry, exit, "wrong count at 
exit") : 0;
 
 	FOR_EACH_PTR(bb->children, child) {
-		if (check_bb_context(ep, child, entry, exit))
+		if (check_bb_context(child, expr, entry, exit))
 			return -1;
 	} END_FOR_EACH_PTR(child);
 	return 0;
 }
 
-static int check_bb_context(struct entrypoint *ep, struct basic_block *bb, 
int entry, int exit)
+static int check_bb_context(struct basic_block *bb, struct expression *expr, 
int entry, int exit)
 {
+	int eq;
+
 	if (!bb)
 		return 0;
-	if (bb->context == entry)
+	eq = expressions_equal(expr, bb->context_expr);
+	if (eq && bb->context == entry)
 		return 0;
 
 	/* Now that's not good.. */
-	if (bb->context >= 0)
-		return imbalance(ep, bb, entry, bb->context, "different lock contexts for 
basic block");
+	if (eq && bb->context >= 0)
+		return imbalance(bb, expr, entry, bb->context, "different lock contexts for 
basic block");
 
 	bb->context = entry;
-	entry += context_increase(bb, entry);
+	bb->context_expr = expr;
+	entry += context_increase(bb, expr, entry);
 	if (entry < 0)
-		return imbalance(ep, bb, entry, exit, "unexpected unlock");
+		return imbalance(bb, expr, entry, exit, "unexpected unlock");
 
-	return check_children(ep, bb, entry, exit);
+	return check_children(bb, expr, entry, exit);
 }
 
 static void check_cast_instruction(struct instruction *insn)
@@ -195,7 +305,31 @@ static void check_call_instruction(struct instruction 
*insn)
 	}
 }
 
-static void check_one_instruction(struct instruction *insn)
+static void add_expression_once(struct expression_list **expr_list, struct 
expression* expr)
+{
+	struct expression *e;
+
+	FOR_EACH_PTR(*expr_list, e) {
+		if (expressions_equal(e, expr))
+			return;
+	} END_FOR_EACH_PTR(e);
+
+	add_expression(expr_list, expr);
+}
+
+static void remove_expression(struct expression_list **expr_list, struct 
expression* expr)
+{
+	struct expression *e;
+
+	FOR_EACH_PTR(*expr_list, e) {
+		if (expressions_equal(e, expr)) {
+			DELETE_CURRENT_PTR(e);
+			return;
+		}
+	} END_FOR_EACH_PTR(e);
+}
+
+static void check_one_instruction(struct instruction *insn, struct 
expression_list **expr_list)
 {
 	switch (insn->opcode) {
 	case OP_CAST: case OP_SCAST:
@@ -208,26 +342,29 @@ static void check_one_instruction(struct instruction 
*insn)
 	case OP_CALL:
 		check_call_instruction(insn);
 		break;
+	case OP_CONTEXT:
+		add_expression_once(expr_list, insn->context_expr);
+		break;
 	default:
 		break;
 	}
 }
 
-static void check_bb_instructions(struct basic_block *bb)
+static void check_bb_instructions(struct basic_block *bb, struct 
expression_list **expr_list)
 {
 	struct instruction *insn;
 	FOR_EACH_PTR(bb->insns, insn) {
 		if (!insn->bb)
 			continue;
-		check_one_instruction(insn);
+		check_one_instruction(insn, expr_list);
 	} END_FOR_EACH_PTR(insn);
 }
 
-static void check_instructions(struct entrypoint *ep)
+static void check_instructions(struct entrypoint *ep, struct expression_list 
**expr_list)
 {
 	struct basic_block *bb;
 	FOR_EACH_PTR(ep->bbs, bb) {
-		check_bb_instructions(bb);
+		check_bb_instructions(bb, expr_list);
 	} END_FOR_EACH_PTR(bb);
 }
 
@@ -235,7 +372,8 @@ static void check_context(struct entrypoint *ep)
 {
 	struct symbol *sym = ep->name;
 	struct context *context;
-	unsigned int in_context = 0, out_context = 0;
+	struct expression_list *expr_list = NULL;
+	struct expression *expr;
 
 	if (Wuninitialized && verbose && ep->entry->bb->needs) {
 		pseudo_t pseudo;
@@ -246,13 +384,16 @@ static void check_context(struct entrypoint *ep)
 		} END_FOR_EACH_PTR(pseudo);
 	}
 
-	check_instructions(ep);
+	check_instructions(ep, &expr_list);
 
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
-		in_context += context->in;
-		out_context += context->out;
+		remove_expression(&expr_list, context->context);
+		check_bb_context(ep->entry->bb, context->context, context->in, 
context->out);
 	} END_FOR_EACH_PTR(context);
-	check_bb_context(ep, ep->entry->bb, in_context, out_context);
+
+	FOR_EACH_PTR(expr_list, expr) {
+		check_bb_context(ep->entry->bb, expr, 0, 0);
+	} END_FOR_EACH_PTR(expr);
 }
 
 static void check_symbols(struct symbol_list *list)
diff --git a/validation/named_context.c b/validation/named_context.c
new file mode 100644
index 0000000..9b6d77f
--- /dev/null
+++ b/validation/named_context.c
@@ -0,0 +1,32 @@
+#ifdef __CHECKER__
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
+#else
+# define __acquires(x)
+# define __releases(x)
+# define __acquire(x) (void)0
+# define __release(x) (void)0
+#endif
+
+static void invalid1(void)
+{
+	__acquire(lock1);
+	__release(lock2);
+}
+
+static void global_lock(void) __acquires(lock1) __acquires(lock2)
+{
+	__acquire(lock1);
+	__acquire(lock2);
+}
+
+/*
+ * check-name: Check -Wcontext
+ *
+ * check-error-start
+named_context.c:13:13: warning: context imbalance in 'invalid1' - wrong count 
at exit for lock1
+named_context.c:13:13: warning: context imbalance in 'invalid1' - unexpected 
unlock for lock2
+ * check-error-end
+ */


-- 
: Dipl-Ing Philipp Reisner                      Tel +43-1-8178292-50 :
: LINBIT Information Technologies GmbH          Fax +43-1-8178292-82 :
: Vivenotgasse 48, 1120 Vienna, Austria        http://www.linbit.com :
