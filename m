From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] fix bug in context tracking code
Date: Wed, 23 Apr 2008 12:24:49 +0200
Message-ID: <1208946289.31429.66.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:51394 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYDWKZ1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 Apr 2008 06:25:27 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

My optimisation to avoid recursion into BBs when checking contexts
lead to a failure in a case like this:

    static int warn_conditional(void)
    {
        if (condition)
            return 0;

        a();
        if (condition == 0)
            return 1;
        r();
        return 0;
    }

because some blocks are called with different contexts and thus
need to be checked multiple times.

The obvious fix would be to decrease the recursion depth at the
end of the BB check function, but that, while correct, leads to
extremely long sparse runtimes on somewhat complex functions.
Thus, this patch also makes sparse cache which contexts it has
checked a block in and avoid the re-checking in that case.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 linearize.c          |    1 
 linearize.h          |    4 +
 sparse.c             |  128 +++++++++++++++++++++++++++++++++++++++++++++------
 validation/context.c |   14 +++++
 4 files changed, 131 insertions(+), 16 deletions(-)

--- sparse.orig/linearize.c	2008-04-23 12:17:18.000000000 +0200
+++ sparse/linearize.c	2008-04-23 12:17:20.000000000 +0200
@@ -66,7 +66,6 @@ static struct entrypoint *alloc_entrypoi
 static struct basic_block *alloc_basic_block(struct entrypoint *ep, struct position pos)
 {
 	struct basic_block *bb = __alloc_basic_block(0);
-	bb->context = -1;
 	bb->pos = pos;
 	bb->ep = ep;
 	return bb;
--- sparse.orig/linearize.h	2008-04-23 12:17:18.000000000 +0200
+++ sparse/linearize.h	2008-04-23 12:17:20.000000000 +0200
@@ -219,11 +219,13 @@ enum opcode {
 
 struct basic_block_list;
 struct instruction_list;
+struct context_list_list;
 
 struct basic_block {
 	struct position pos;
 	unsigned long generation;
-	int context;
+	int context_check_recursion;
+	struct context_list_list *checked_contexts;
 	struct entrypoint *ep;
 	struct basic_block_list *parents; /* sources */
 	struct basic_block_list *children; /* destinations */
--- sparse.orig/sparse.c	2008-04-23 12:17:18.000000000 +0200
+++ sparse/sparse.c	2008-04-23 12:17:20.000000000 +0200
@@ -31,6 +31,7 @@ struct context_check {
 
 DECLARE_ALLOCATOR(context_check);
 DECLARE_PTR_LIST(context_check_list, struct context_check);
+DECLARE_PTR_LIST(context_list_list, struct context_check_list);
 ALLOCATOR(context_check, "context check list");
 
 static const char *unnamed_context = "<unnamed>";
@@ -64,6 +65,54 @@ static void context_add(struct context_c
 	found->val_false += offs_false;
 }
 
+static int context_list_has(struct context_check_list *ccl,
+			    struct context_check *c)
+{
+	struct context_check *check;
+
+	FOR_EACH_PTR(ccl, check) {
+		if (strcmp(c->name, check->name))
+			continue;
+		return check->val == c->val &&
+		       check->val_false == c->val_false;
+	} END_FOR_EACH_PTR(check);
+
+	/* not found is equal to 0 */
+	return c->val == 0 && c->val_false == 0;
+}
+
+static int context_lists_equal(struct context_check_list *ccl1,
+			       struct context_check_list *ccl2)
+{
+	struct context_check *check;
+
+	/* can be optimised... */
+
+	FOR_EACH_PTR(ccl1, check) {
+		if (!context_list_has(ccl2, check))
+			return 0;
+	} END_FOR_EACH_PTR(check);
+
+	FOR_EACH_PTR(ccl2, check) {
+		if (!context_list_has(ccl1, check))
+			return 0;
+	} END_FOR_EACH_PTR(check);
+
+	return 1;
+}
+
+static struct context_check_list *checked_copy(struct context_check_list *ccl)
+{
+	struct context_check_list *result = NULL;
+	struct context_check *c;
+
+	FOR_EACH_PTR(ccl, c) {
+		context_add(&result, c->name, c->val_false, c->val_false);
+	} END_FOR_EACH_PTR(c);
+
+	return result;
+}
+
 #define IMBALANCE_IN "context imbalance in '%s': "
 #define DEFAULT_CONTEXT_DESCR "   default context: "
 
@@ -234,18 +283,26 @@ static int check_bb_context(struct entry
 			    struct context_check_list *ccl_target,
 			    int in_false)
 {
-	struct context_check_list *combined = NULL;
+	struct context_check_list *combined = NULL, *done;
 	struct context_check *c;
 	struct instruction *insn;
 	struct multijmp *mj;
+	int err = -1;
 
 	/*
-	 * recurse in once to catch bad loops,
-	 * bb->context is initialised to -1.
+	 * Recurse in once to catch bad loops.
 	 */
-	if (bb->context > 0)
+	if (bb->context_check_recursion > 1)
 		return 0;
-	bb->context++;
+	bb->context_check_recursion++;
+
+	/*
+	 * Abort if we have already checked this block out of the same context.
+	 */
+	FOR_EACH_PTR(bb->checked_contexts, done) {
+		if (context_lists_equal(done, ccl_in))
+			return 0;
+	} END_FOR_EACH_PTR(done);
 
 	/*
 	 * We're starting with a completely new local list of contexts, so
@@ -260,6 +317,10 @@ static int check_bb_context(struct entry
 			context_add(&combined, c->name, c->val, c->val);
 	} END_FOR_EACH_PTR(c);
 
+	/* Add the new context to the list of already-checked contexts */
+	done = checked_copy(combined);
+	add_ptr_list(&bb->checked_contexts, done);
+
 	/*
 	 * Now walk the instructions for this block, recursing into any
 	 * instructions that have children. We need to have the right
@@ -270,28 +331,28 @@ static int check_bb_context(struct entry
 		case OP_INLINED_CALL:
 		case OP_CALL:
 			if (handle_call(ep, bb, insn, combined))
-				return -1;
+				goto out;
 			break;
 		case OP_CONTEXT:
 			if (handle_context(ep, bb, insn, &combined))
-				return -1;
+				goto out;
 			break;
 		case OP_BR:
 			if (insn->bb_true)
 				if (check_bb_context(ep, insn->bb_true,
 						     combined, ccl_target, 0))
-					return -1;
+					goto out;
 			if (insn->bb_false)
 				if (check_bb_context(ep, insn->bb_false,
 						     combined, ccl_target, 1))
-					return -1;
+					goto out;
 			break;
 		case OP_SWITCH:
 		case OP_COMPUTEDGOTO:
 			FOR_EACH_PTR(insn->multijmp_list, mj) {
 				if (check_bb_context(ep, mj->target,
 					             combined, ccl_target, 0))
-					return -1;
+					goto out;
 			} END_FOR_EACH_PTR(mj);
 			break;
 		}
@@ -299,15 +360,53 @@ static int check_bb_context(struct entry
 
 	insn = last_instruction(bb->insns);
 	if (!insn)
-		return 0;
+		goto out_good;
 
-	if (insn->opcode == OP_RET)
-		return context_list_check(ep, insn->pos, combined, ccl_target);
+	if (insn->opcode == OP_RET) {
+		err = context_list_check(ep, insn->pos, combined, ccl_target);
+		goto out;
+	}
 
+ out_good:
+	err = 0;
+ out:
 	/* contents will be freed once we return out of recursion */
 	free_ptr_list(&combined);
+	bb->context_check_recursion--;
+	return err;
+}
 
-	return 0;
+static void free_bb_context_lists(struct basic_block *bb)
+{
+	struct context_check_list *done;
+	struct instruction *insn;
+	struct multijmp *mj;
+
+	if (!bb->checked_contexts)
+		return;
+
+	FOR_EACH_PTR(bb->checked_contexts, done) {
+		free_ptr_list(&done);
+	} END_FOR_EACH_PTR(done);
+
+	free_ptr_list(&bb->checked_contexts);
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		switch (insn->opcode) {
+		case OP_BR:
+			if (insn->bb_true)
+				free_bb_context_lists(insn->bb_true);
+			if (insn->bb_false)
+				free_bb_context_lists(insn->bb_false);
+			break;
+		case OP_SWITCH:
+		case OP_COMPUTEDGOTO:
+			FOR_EACH_PTR(insn->multijmp_list, mj) {
+				free_bb_context_lists(mj->target);
+			} END_FOR_EACH_PTR(mj);
+			break;
+		}
+	} END_FOR_EACH_PTR(insn);
 }
 
 static void check_cast_instruction(struct instruction *insn)
@@ -474,6 +573,7 @@ static void check_context(struct entrypo
 	check_bb_context(ep, ep->entry->bb, ccl_in, ccl_target, 0);
 	free_ptr_list(&ccl_in);
 	free_ptr_list(&ccl_target);
+	free_bb_context_lists(ep->entry->bb);
 	clear_context_check_alloc();
 }
 
--- sparse.orig/validation/context.c	2008-04-23 12:17:18.000000000 +0200
+++ sparse/validation/context.c	2008-04-23 12:17:20.000000000 +0200
@@ -368,6 +368,18 @@ static void warn_huge_switch(void)
     }
 }
 
+static int warn_conditional(void)
+{
+    if (condition)
+        return 0;
+
+    a();
+    if (condition == 0)
+        return 1;
+    r();
+    return 0;
+}
+
 /*
  * check-name: Check -Wcontext
  *
@@ -404,5 +416,7 @@ context.c:325:10: warning: context probl
 context.c:325:10:    default context: wanted >= 1, got 0
 context.c:360:10: warning: context problem in 'warn_huge_switch': 'r' expected different context
 context.c:360:10:    default context: wanted >= 1, got 0
+context.c:380:12: warning: context imbalance in 'warn_conditional': wrong count at exit
+context.c:380:12:    default context: wanted 0, got 1
  * check-error-end
  */


