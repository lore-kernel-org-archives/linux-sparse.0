From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/3] sparse: simple conditional context tracking
Date: Thu, 10 Apr 2008 15:25:22 +0200
Message-ID: <20080410132618.733861000@sipsolutions.net>
References: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:56465 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236AbYDJOl3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 10:41:29 -0400
Content-Disposition: inline; filename=conditional.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

This patch enables a very simple form of conditional context tracking,
namely something like

if (spin_trylock(...)) {
	[...]
	spin_unlock(...);
}

Note that
__ret = spin_trylock(...);
if (__ret) {
	[...]
	spin_unlock(...);
}

does /not/ work since that would require tracking the variable and doing
extra checks to ensure the variable isn't globally accessible or similar
which could lead to race conditions.

To declare a trylock, one uses:

int spin_trylock(...) __attribute__((conditional_context(spinlock,0,1,0)))
{...}

Note that doing this currently excludes that function itself from context
checking completely.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 linearize.c                  |   22 +----
 linearize.h                  |    3 
 parse.c                      |   52 +++++++++++++
 sparse.1                     |    9 ++
 sparse.c                     |   54 ++++++++++----
 symbol.h                     |    2 
 validation/context-dynamic.c |  161 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 270 insertions(+), 33 deletions(-)

--- sparse.orig/sparse.c	2008-04-10 15:21:21.000000000 +0200
+++ sparse/sparse.c	2008-04-10 15:23:33.000000000 +0200
@@ -25,7 +25,7 @@
 #include "linearize.h"
 
 struct context_check {
-	int val;
+	int val, val_false;
 	char name[32];
 };
 
@@ -42,7 +42,7 @@ static const char *context_name(struct c
 	return unnamed_context;
 }
 
-static void context_add(struct context_check_list **ccl, const char *name, int offs)
+static void context_add(struct context_check_list **ccl, const char *name, int offs, int offs_false)
 {
 	struct context_check *check, *found = NULL;
 
@@ -60,6 +60,7 @@ static void context_add(struct context_c
 		add_ptr_list(ccl, found);
 	}
 	found->val += offs;
+	found->val_false += offs_false;
 }
 
 static int imbalance(struct entrypoint *ep, struct position pos, const char *name, const char *why)
@@ -83,7 +84,7 @@ static int context_list_check(struct ent
 
 	/* make sure the loop below checks all */
 	FOR_EACH_PTR(ccl_target, c1) {
-		context_add(&ccl_cur, c1->name, 0);
+		context_add(&ccl_cur, c1->name, 0, 0);
 	} END_FOR_EACH_PTR(c1);
 
 	FOR_EACH_PTR(ccl_cur, c1) {
@@ -108,12 +109,13 @@ static int context_list_check(struct ent
 
 static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
 			    struct context_check_list *ccl_in,
-			    struct context_check_list *ccl_target)
+			    struct context_check_list *ccl_target,
+			    int in_false)
 {
 	struct context_check_list *combined = NULL;
 	struct context_check *c;
 	struct instruction *insn;
-	struct basic_block *child;
+	struct multijmp *mj;
 	struct context *ctx;
 	const char *name;
 	int ok, val;
@@ -125,7 +127,10 @@ static int check_bb_context(struct entry
 	bb->context++;
 
 	FOR_EACH_PTR(ccl_in, c) {
-		context_add(&combined, c->name, c->val);
+		if (in_false)
+			context_add(&combined, c->name, c->val_false, c->val_false);
+		else
+			context_add(&combined, c->name, c->val, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	FOR_EACH_PTR(bb->insns, insn) {
@@ -182,7 +187,23 @@ static int check_bb_context(struct entry
 				free((void *)name);
 				return -1;
 			}
-			context_add(&combined, name, insn->increment);
+
+			context_add(&combined, name, insn->increment, insn->inc_false);
+			break;
+		case OP_BR:
+			if (insn->bb_true)
+				if (check_bb_context(ep, insn->bb_true, combined, ccl_target, 0))
+					return -1;
+			if (insn->bb_false)
+				if (check_bb_context(ep, insn->bb_false, combined, ccl_target, 1))
+					return -1;
+			break;
+		case OP_SWITCH:
+		case OP_COMPUTEDGOTO:
+			FOR_EACH_PTR(insn->multijmp_list, mj) {
+				if (check_bb_context(ep, mj->target, combined, ccl_target, 0))
+					return -1;
+			} END_FOR_EACH_PTR(mj);
 			break;
  		}
 	} END_FOR_EACH_PTR(insn);
@@ -193,10 +214,12 @@ static int check_bb_context(struct entry
 	if (insn->opcode == OP_RET)
 		return context_list_check(ep, insn->pos, combined, ccl_target);
 
-	FOR_EACH_PTR(bb->children, child) {
-		if (check_bb_context(ep, child, combined, ccl_target))
-			return -1;
-	} END_FOR_EACH_PTR(child);
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		switch (insn->opcode) {
+		}
+	} END_FOR_EACH_PTR(insn);
 
 	/* contents will be freed once we return out of recursion */
 	free_ptr_list(&combined);
@@ -358,11 +381,14 @@ static void check_context(struct entrypo
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
 		const char *name = context_name(context);
 
-		context_add(&ccl_in, name, context->in);
-		context_add(&ccl_target, name, context->out);
+		context_add(&ccl_in, name, context->in, context->in);
+		context_add(&ccl_target, name, context->out, context->out_false);
+		/* we don't currently check the body of trylock functions */
+		if (context->out != context->out_false)
+			return;
 	} END_FOR_EACH_PTR(context);
 
-	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target);
+	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target, 0);
 	free_ptr_list(&ccl_in);
 	free_ptr_list(&ccl_target);
 	clear_context_check_alloc();
--- sparse.orig/symbol.h	2008-04-10 15:21:21.000000000 +0200
+++ sparse/symbol.h	2008-04-10 15:22:43.000000000 +0200
@@ -71,7 +71,7 @@ enum keyword {
 
 struct context {
 	struct expression *context;
-	unsigned int in, out;
+	unsigned int in, out, out_false;
 	int exact;
 };
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ sparse/validation/context-dynamic.c	2008-04-10 15:22:43.000000000 +0200
@@ -0,0 +1,161 @@
+static void a(void) __attribute__ ((context(A, 0, 1)))
+{
+    __context__(A, 1);
+}
+
+static void r(void) __attribute__ ((context(A, 1, 0)))
+{
+    __context__(A, -1);
+}
+
+extern int condition, condition2;
+
+static int tl(void) __attribute__ ((conditional_context(A, 0, 1, 0)))
+{
+    if (condition) {
+        a();
+        return 1;
+    }
+    return 0;
+}
+
+static int tl2(void) __attribute__ ((conditional_context(A, 0, 0, 1)))
+{
+    if (condition) {
+        a();
+        return 1;
+    }
+    return 0;
+}
+
+static int dummy(void)
+{
+    return condition + condition2;
+}
+
+static int good_trylock1(void)
+{
+    if (tl()) {
+        r();
+    }
+}
+
+static int good_trylock2(void)
+{
+    if (tl()) {
+        r();
+    }
+
+    if (tl()) {
+        r();
+    }
+}
+static int good_trylock3(void)
+{
+    a();
+    if (tl()) {
+        r();
+    }
+    r();
+    if (tl()) {
+        r();
+    }
+}
+
+static int good_trylock4(void)
+{
+    a();
+    if (tl()) {
+        r();
+    }
+    if (tl()) {
+        r();
+    }
+    r();
+}
+
+static void bad_trylock1(void)
+{
+    a();
+    if (dummy()) {
+        r();
+    }
+    r();
+}
+
+static int good_trylock5(void)
+{
+    if (!tl2()) {
+        r();
+    }
+}
+
+static int good_trylock6(void)
+{
+    if (!tl2()) {
+        r();
+    }
+
+    if (!tl2()) {
+        r();
+    }
+}
+static int good_trylock7(void)
+{
+    a();
+    if (!tl2()) {
+        r();
+    }
+    r();
+    if (!tl2()) {
+        r();
+    }
+}
+
+static int good_trylock8(void)
+{
+    a();
+    if (!tl2()) {
+        r();
+    }
+    if (!tl2()) {
+        r();
+    }
+    r();
+}
+
+static void bad_trylock2(void)
+{
+    a();
+    if (!dummy()) {
+        r();
+    }
+    r();
+}
+
+static int good_switch(void)
+{
+    switch (condition) {
+    case 1:
+        a();
+        break;
+    case 2:
+        a();
+        break;
+    case 3:
+        a();
+        break;
+    default:
+        a();
+    }
+    r();
+}
+
+/*
+ * check-name: Check -Wcontext with lock trylocks
+ *
+ * check-error-start
+context-dynamic.c:83:6: warning: context problem in 'bad_trylock1' - function 'r' expected different context
+context-dynamic.c:133:6: warning: context problem in 'bad_trylock2' - function 'r' expected different context
+ * check-error-end
+ */
--- sparse.orig/linearize.c	2008-04-10 15:21:21.000000000 +0200
+++ sparse/linearize.c	2008-04-10 15:23:22.000000000 +0200
@@ -439,7 +439,7 @@ const char *show_instruction(struct inst
 		break;
 
 	case OP_CONTEXT:
-		buf += sprintf(buf, "%s%d", insn->check ? "check: " : "", insn->increment);
+		buf += sprintf(buf, "%s%d,%d", "", insn->increment, insn->inc_false);
 		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
@@ -1233,23 +1233,12 @@ static pseudo_t linearize_call_expressio
 		FOR_EACH_PTR(ctype->contexts, context) {
 			int in = context->in;
 			int out = context->out;
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
+
+			if (out - in || context->out_false - in) {
 				insn = alloc_instruction(OP_CONTEXT, 0);
-				insn->increment = context_diff;
-				/* what's check for? */
-				insn->check = check;
+				insn->increment = out - in;
 				insn->context_expr = context->context;
+				insn->inc_false = context->out_false - in;
 				add_one_insn(ep, insn);
 			}
 		} END_FOR_EACH_PTR(context);
@@ -1684,6 +1673,7 @@ static pseudo_t linearize_context(struct
 		value = expr->value;
 
 	insn->increment = value;
+	insn->inc_false = value;
 
 	expr = stmt->required;
 	value = 0;
--- sparse.orig/linearize.h	2008-04-10 15:21:21.000000000 +0200
+++ sparse/linearize.h	2008-04-10 15:22:43.000000000 +0200
@@ -116,8 +116,7 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment, required;
-			int check;
+			int increment, required, inc_false;
 			struct expression *context_expr;
 		};
 		struct /* asm */ {
--- sparse.orig/parse.c	2008-04-10 15:21:21.000000000 +0200
+++ sparse/parse.c	2008-04-10 15:22:43.000000000 +0200
@@ -66,6 +66,7 @@ static struct token *attribute_address_s
 static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
+static struct token *attribute_conditional_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
@@ -185,6 +186,10 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
+static struct symbol_op conditional_context_op = {
+	.attribute = attribute_conditional_context,
+};
+
 static struct symbol_op exact_context_op = {
 	.attribute = attribute_exact_context,
 };
@@ -270,6 +275,7 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "conditional_context",	NS_KEYWORD,	.op = &conditional_context_op },
 	{ "exact_context",	NS_KEYWORD,	.op = &exact_context_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
@@ -912,6 +918,7 @@ static struct token *_attribute_context(
 	}
 
 	context->exact = exact;
+	context->out_false = context->out;
 
 	if (argc)
 		add_ptr_list(&ctype->contexts, context);
@@ -930,6 +937,51 @@ static struct token *attribute_exact_con
 	return _attribute_context(token, attr, ctype, 1);
 }
 
+static struct token *attribute_conditional_context(struct token *token, struct symbol *attr, struct ctype *ctype)
+{
+	struct context *context = alloc_context();
+	struct expression *args[4];
+	int argc = 0;
+
+	token = expect(token, '(', "after conditional_context attribute");
+	while (!match_op(token, ')')) {
+		struct expression *expr = NULL;
+		token = conditional_expression(token, &expr);
+		if (!expr)
+			break;
+		if (argc < 4)
+			args[argc++] = expr;
+		else
+			argc++;
+		if (!match_op(token, ','))
+			break;
+		token = token->next;
+	}
+
+	switch(argc) {
+	case 3:
+		context->in = get_expression_value(args[0]);
+		context->out = get_expression_value(args[1]);
+		context->out_false = get_expression_value(args[2]);
+		break;
+	case 4:
+		context->context = args[0];
+		context->in = get_expression_value(args[1]);
+		context->out = get_expression_value(args[2]);
+		context->out_false = get_expression_value(args[3]);
+		break;
+	default:
+		sparse_error(token->pos, "invalid number of arguments to conditional_context attribute");
+		break;
+	}
+
+	if (argc)
+		add_ptr_list(&ctype->contexts, context);
+
+	token = expect(token, ')', "after conditional_context attribute");
+	return token;
+}
+
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	if (Wtransparent_union)
--- sparse.orig/sparse.1	2008-04-10 15:21:21.000000000 +0200
+++ sparse/sparse.1	2008-04-10 15:22:43.000000000 +0200
@@ -94,6 +94,15 @@ There currently is no corresponding
 .BI __exact_context__( [expression , ]adjust_value[ , required] )
 statement.
 
+To indicate that a certain function acquires a context depending on its
+return value, use
+.BI __attribute__((conditional_context( [expression ,] in_context , out_success , out_failure ))
+where \fIout_success\fR and \fIout_failure\fR indicate the context change
+done depending on success (non-zero) or failure (zero) return of the
+function. Note that currently, using this attribute on a function means that
+the function itself won't be checked for context handling at all. See the
+testsuite for examples.
+
 Sparse will warn when it sees a function change a
 context without indicating this with a \fBcontext\fR or \fBexact_context\fR attribute, either by
 decreasing a context below zero (such as by releasing a lock without acquiring

-- 

