From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 12/16] Revert the conditional_context patch
Date: Fri, 19 Dec 2008 01:34:26 +0300
Message-ID: <20081218223414.23692.94766.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:11774 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYLRWZO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:25:14 -0500
Received: by nf-out-0910.google.com with SMTP id d3so99942nfc.21
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:25:12 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

This patch removes the conditional_context attribute again, it turned
out that my attempt to do this was rather misguided and contrary to
what I thought we do not gain anything at all over using macros for
it as the kernel and the tests have been doing for a while.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 linearize.c                  |   32 +++++---
 linearize.h                  |    2 
 parse.c                      |   52 -------------
 sparse.1                     |    9 --
 sparse.c                     |   39 ++++------
 symbol.h                     |    2 
 validation/context-dynamic.c |  171 ------------------------------------------
 7 files changed, 37 insertions(+), 270 deletions(-)
 delete mode 100644 validation/context-dynamic.c

diff --git a/linearize.c b/linearize.c
index 8e9775d..34922e9 100644
--- a/linearize.c
+++ b/linearize.c
@@ -439,7 +439,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_CONTEXT:
-		buf += sprintf(buf, "%s%d,%d", "", insn->increment, insn->inc_false);
+		buf += sprintf(buf, "%d", insn->increment);
 		break;
 	case OP_RANGE:
 		buf += sprintf(buf, "%s between %s..%s", show_pseudo(insn->src1), show_pseudo(insn->src2), show_pseudo(insn->src3));
@@ -960,7 +960,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 			continue;
 		insn = alloc_instruction(OP_CONTEXT, 0);
 		insn->required = context->in;
-		insn->increment = insn->inc_false = context->out - context->in;
+		insn->increment = context->out - context->in;
 		insn->context_expr = context->context;
 		insn->access_var = ad->source_type;
 		insn->exact = context->exact;
@@ -973,7 +973,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 			continue;
 		insn = alloc_instruction(OP_CONTEXT, 0);
 		insn->required = context->in;
-		insn->increment = insn->inc_false = context->out - context->in;
+		insn->increment = context->out - context->in;
 		insn->context_expr = context->context;
 		insn->access_var = ad->result_type;
 		insn->exact = context->exact;
@@ -988,7 +988,7 @@ static pseudo_t linearize_store_gen(struct entrypoint *ep,
 				continue;
 			insn = alloc_instruction(OP_CONTEXT, 0);
 			insn->required = context->in;
-			insn->increment = insn->inc_false = context->out - context->in;
+			insn->increment = context->out - context->in;
 			insn->context_expr = context->context;
 			insn->access_var = ad->address->sym;
 			insn->exact = context->exact;
@@ -1049,7 +1049,7 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 			continue;
 		insn = alloc_instruction(OP_CONTEXT, 0);
 		insn->required = context->in;
-		insn->increment = insn->inc_false = context->out - context->in;
+		insn->increment = context->out - context->in;
 		insn->context_expr = context->context;
 		insn->access_var = ad->source_type;
 		insn->exact = context->exact;
@@ -1062,7 +1062,7 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 			continue;
 		insn = alloc_instruction(OP_CONTEXT, 0);
 		insn->required = context->in;
-		insn->increment = insn->inc_false = context->out - context->in;
+		insn->increment = context->out - context->in;
 		insn->context_expr = context->context;
 		insn->access_var = ad->result_type;
 		insn->exact = context->exact;
@@ -1077,7 +1077,7 @@ static pseudo_t linearize_load_gen(struct entrypoint *ep, struct access_data *ad
 				continue;
 			insn = alloc_instruction(OP_CONTEXT, 0);
 			insn->required = context->in;
-			insn->increment = insn->inc_false = context->out - context->in;
+			insn->increment = context->out - context->in;
 			insn->context_expr = context->context;
 			insn->access_var = ad->address->sym;
 			insn->exact = context->exact;
@@ -1322,12 +1322,21 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
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
 				insn->context_expr = context->context;
-				insn->inc_false = context->out_false - in;
 				add_one_insn(ep, insn);
 			}
 		} END_FOR_EACH_PTR(context);
@@ -1757,7 +1766,6 @@ static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 	struct instruction *insn = alloc_instruction(OP_CONTEXT, 0);
 
 	insn->increment = stmt->change;
-	insn->inc_false = stmt->change;
 
 	insn->required = stmt->required;
 	insn->exact = stmt->exact;
diff --git a/linearize.h b/linearize.h
index 4e9100d..3bd5098 100644
--- a/linearize.h
+++ b/linearize.h
@@ -117,7 +117,7 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment, required, inc_false, exact;
+			int increment, required, exact;
 			struct expression *context_expr;
 			struct symbol *access_var;
 		};
diff --git a/parse.c b/parse.c
index fdb7efb..5e3354c 100644
--- a/parse.c
+++ b/parse.c
@@ -65,7 +65,6 @@ static struct token *attribute_address_space(struct token *token, struct symbol
 static struct token *attribute_aligned(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_mode(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_context(struct token *token, struct symbol *attr, struct ctype *ctype);
-static struct token *attribute_conditional_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_exact_context(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype);
 static struct token *ignore_attribute(struct token *token, struct symbol *attr, struct ctype *ctype);
@@ -189,10 +188,6 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
-static struct symbol_op conditional_context_op = {
-	.attribute = attribute_conditional_context,
-};
-
 static struct symbol_op exact_context_op = {
 	.attribute = attribute_exact_context,
 };
@@ -279,7 +274,6 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
-	{ "conditional_context",	NS_KEYWORD,	.op = &conditional_context_op },
 	{ "exact_context",	NS_KEYWORD,	.op = &exact_context_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 
@@ -945,7 +939,6 @@ static struct token *_attribute_context(struct token *token, struct symbol *attr
 	}
 
 	context->exact = exact;
-	context->out_false = context->out;
 
 	if (argc)
 		add_ptr_list(&ctype->contexts, context);
@@ -964,51 +957,6 @@ static struct token *attribute_exact_context(struct token *token, struct symbol
 	return _attribute_context(token, attr, ctype, 1);
 }
 
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
diff --git a/sparse.1 b/sparse.1
index 61c40b8..ebe62f0 100644
--- a/sparse.1
+++ b/sparse.1
@@ -101,15 +101,6 @@ be required on both reads and writes) by using either the token "read" or
 the token "write" for an optional fourth argument:
 .BI __attribute__((context( expression , in_context , out_context , read|write )).
 
-To indicate that a certain function acquires a context depending on its
-return value, use
-.BI __attribute__((conditional_context( [expression ,] in_context , out_success , out_failure ))
-where \fIout_success\fR and \fIout_failure\fR indicate the context change
-done depending on success (non-zero) or failure (zero) return of the
-function. Note that currently, using this attribute on a function means that
-the function itself won't be checked for context handling at all. See the
-testsuite for examples.
-
 Sparse will warn when it sees a function change a
 context without indicating this with a \fBcontext\fR or \fBexact_context\fR attribute, either by
 decreasing a context below zero (such as by releasing a lock without acquiring
diff --git a/sparse.c b/sparse.c
index 1149244..76b1db2 100644
--- a/sparse.c
+++ b/sparse.c
@@ -25,7 +25,7 @@
 #include "linearize.h"
 
 struct context_check {
-	int val, val_false;
+	int val;
 	char name[32];
 };
 
@@ -44,7 +44,7 @@ static const char *context_name(struct context *context)
 }
 
 static void context_add(struct context_check_list **ccl, const char *name,
-			int offs, int offs_false)
+			int offs)
 {
 	struct context_check *check, *found = NULL;
 
@@ -62,7 +62,6 @@ static void context_add(struct context_check_list **ccl, const char *name,
 		add_ptr_list(ccl, found);
 	}
 	found->val += offs;
-	found->val_false += offs_false;
 }
 
 static int context_list_has(struct context_check_list *ccl,
@@ -73,12 +72,11 @@ static int context_list_has(struct context_check_list *ccl,
 	FOR_EACH_PTR(ccl, check) {
 		if (strcmp(c->name, check->name))
 			continue;
-		return check->val == c->val &&
-		       check->val_false == c->val_false;
+		return check->val == c->val;
 	} END_FOR_EACH_PTR(check);
 
 	/* not found is equal to 0 */
-	return c->val == 0 && c->val_false == 0;
+	return c->val == 0;
 }
 
 static int context_lists_equal(struct context_check_list *ccl1,
@@ -107,7 +105,7 @@ static struct context_check_list *checked_copy(struct context_check_list *ccl)
 	struct context_check *c;
 
 	FOR_EACH_PTR(ccl, c) {
-		context_add(&result, c->name, c->val_false, c->val_false);
+		context_add(&result, c->name, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	return result;
@@ -140,7 +138,7 @@ static int context_list_check(struct entrypoint *ep, struct position pos,
 
 	/* make sure the loop below checks all */
 	FOR_EACH_PTR(ccl_target, c1) {
-		context_add(&ccl_cur, c1->name, 0, 0);
+		context_add(&ccl_cur, c1->name, 0);
 	} END_FOR_EACH_PTR(c1);
 
 	FOR_EACH_PTR(ccl_cur, c1) {
@@ -289,15 +287,14 @@ static int handle_context(struct entrypoint *ep, struct basic_block *bb,
 		return -1;
 	}
 
-	context_add(combined, name, insn->increment, insn->inc_false);
+	context_add(combined, name, insn->increment);
 
 	return 0;
 }
 
 static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
 			    struct context_check_list *ccl_in,
-			    struct context_check_list *ccl_target,
-			    int in_false)
+			    struct context_check_list *ccl_target)
 {
 	struct context_check_list *combined = NULL, *done;
 	struct context_check *c;
@@ -327,10 +324,7 @@ static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
 	 * for the conditional_context() attribute.
 	 */
 	FOR_EACH_PTR(ccl_in, c) {
-		if (in_false)
-			context_add(&combined, c->name, c->val_false, c->val_false);
-		else
-			context_add(&combined, c->name, c->val, c->val);
+		context_add(&combined, c->name, c->val);
 	} END_FOR_EACH_PTR(c);
 
 	/* Add the new context to the list of already-checked contexts */
@@ -356,18 +350,18 @@ static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
 		case OP_BR:
 			if (insn->bb_true)
 				if (check_bb_context(ep, insn->bb_true,
-						     combined, ccl_target, 0))
+						     combined, ccl_target))
 					goto out;
 			if (insn->bb_false)
 				if (check_bb_context(ep, insn->bb_false,
-						     combined, ccl_target, 1))
+						     combined, ccl_target))
 					goto out;
 			break;
 		case OP_SWITCH:
 		case OP_COMPUTEDGOTO:
 			FOR_EACH_PTR(insn->multijmp_list, mj) {
 				if (check_bb_context(ep, mj->target,
-					             combined, ccl_target, 0))
+					             combined, ccl_target))
 					goto out;
 			} END_FOR_EACH_PTR(mj);
 			break;
@@ -579,14 +573,11 @@ static void check_context(struct entrypoint *ep)
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
 		const char *name = context_name(context);
 
-		context_add(&ccl_in, name, context->in, context->in);
-		context_add(&ccl_target, name, context->out, context->out_false);
-		/* we don't currently check the body of trylock functions */
-		if (context->out != context->out_false)
-			return;
+		context_add(&ccl_in, name, context->in);
+		context_add(&ccl_target, name, context->out);
 	} END_FOR_EACH_PTR(context);
 
-	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target, 0);
+	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target);
 	free_ptr_list(&ccl_in);
 	free_ptr_list(&ccl_target);
 	free_bb_context_lists(ep->entry->bb);
diff --git a/symbol.h b/symbol.h
index f79674f..4e605c2 100644
--- a/symbol.h
+++ b/symbol.h
@@ -77,7 +77,7 @@ enum context_read_write_specifier {
 
 struct context {
 	struct expression *context;
-	unsigned int in, out, out_false;
+	unsigned int in, out;
 	int exact;
 	enum context_read_write_specifier rws;
 };
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
