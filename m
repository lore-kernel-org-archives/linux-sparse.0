From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 5/3] improve -Wcontext code and messages
Date: Fri, 11 Apr 2008 13:08:32 +0200
Message-ID: <1207912112.13354.56.camel@johannes.berg>
References: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:37348 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756958AbYDKMIf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 11 Apr 2008 08:08:35 -0400
In-Reply-To: <20080410132519.049821000@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

This builds on my previous code improving the code and the messages,
the messages now always tell you the expected and actual context
value. Also add another test since I had mentioned that case.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
I can also roll this into the other patches if wanted.

 sparse.c                       |  234 +++++++++++++++++++++++++++--------------
 validation/context-dynamic.c   |   14 ++
 validation/context-named.c     |   72 ++++++++----
 validation/context-statement.c |   17 ++
 validation/context.c           |   90 +++++++++++++--
 5 files changed, 307 insertions(+), 120 deletions(-)

--- sparse.orig/sparse.c	2008-04-11 12:43:44.000000000 +0200
+++ sparse/sparse.c	2008-04-11 12:54:45.000000000 +0200
@@ -42,7 +42,8 @@ static const char *context_name(struct c
 	return unnamed_context;
 }
 
-static void context_add(struct context_check_list **ccl, const char *name, int offs, int offs_false)
+static void context_add(struct context_check_list **ccl, const char *name,
+			int offs, int offs_false)
 {
 	struct context_check *check, *found = NULL;
 
@@ -63,16 +64,19 @@ static void context_add(struct context_c
 	found->val_false += offs_false;
 }
 
-static int imbalance(struct entrypoint *ep, struct position pos, const char *name, const char *why)
+#define IMBALANCE_IN "context imbalance in '%s': "
+#define DEFAULT_CONTEXT_DESCR "   default context: "
+
+static void get_context_string(char **buf, const char **name)
 {
-	if (Wcontext) {
-		struct symbol *sym = ep->name;
-		if (strcmp(name, unnamed_context))
-			warning(pos, "context imbalance in '%s' - %s (%s)", show_ident(sym->ident), why, name);
-		else
-			warning(pos, "context imbalance in '%s' - %s", show_ident(sym->ident), why);
+	if (strcmp(*name, unnamed_context)) {
+		*buf = malloc(strlen(*name) + 16);
+		sprintf(*buf, "   context '%s': ", *name);
+		*name = *buf;
+	} else {
+		*name = DEFAULT_CONTEXT_DESCR;
+		*buf = NULL;
 	}
-	return -1;
 }
 
 static int context_list_check(struct entrypoint *ep, struct position pos,
@@ -81,6 +85,8 @@ static int context_list_check(struct ent
 {
 	struct context_check *c1, *c2;
 	int cur, tgt;
+	const char *name;
+	char *buf;
 
 	/* make sure the loop below checks all */
 	FOR_EACH_PTR(ccl_target, c1) {
@@ -98,15 +104,131 @@ static int context_list_check(struct ent
 			break;
 		} END_FOR_EACH_PTR(c2);
 
+		if (cur == tgt || !Wcontext)
+			continue;
+
 		if (cur > tgt)
-			return imbalance(ep, pos, c1->name, "wrong count at exit");
+			warning(pos, IMBALANCE_IN "wrong count at exit",
+				show_ident(ep->name->ident));
 		else if (cur < tgt)
-			return imbalance(ep, pos, c1->name, "unexpected unlock");
+			warning(pos, IMBALANCE_IN "unexpected unlock",
+				show_ident(ep->name->ident));
+
+		name = c1->name;
+		get_context_string(&buf, &name);
+
+		info(pos, "%swanted %d, got %d",
+		     name, tgt, cur);
+
+		free(buf);
+
+		return -1;
 	} END_FOR_EACH_PTR(c1);
 
 	return 0;
 }
 
+static int handle_call(struct entrypoint *ep, struct basic_block *bb,
+		       struct instruction *insn,
+		       struct context_check_list *combined)
+{
+	struct context *ctx;
+	struct context_check *c;
+	const char *name, *call, *cmp;
+	char *buf;
+	int val, ok;
+
+	if (!insn->func || !insn->func->sym ||
+	    insn->func->type != PSEUDO_SYM)
+		return 0;
+
+	/*
+	 * Check all contexts the function wants.
+	 */
+	FOR_EACH_PTR(insn->func->sym->ctype.contexts, ctx) {
+		name = context_name(ctx);
+		val = 0;
+
+		FOR_EACH_PTR(combined, c) {
+			if (strcmp(c->name, name) == 0) {
+				val = c->val;
+				break;
+			}
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
+			get_context_string(&buf, &name);
+			call = strdup(show_ident(insn->func->ident));
+
+			warning(insn->pos, "context problem in '%s': "
+				"'%s' expected different context",
+				show_ident(ep->name->ident), call);
+
+			info(insn->pos, "%swanted %s%d, got %d",
+			     name, cmp, ctx->in, val);
+
+			free((void *)call);
+			free(buf);
+
+			return -1;
+		}
+	} END_FOR_EACH_PTR (ctx);
+
+	return 0;
+}
+
+static int handle_context(struct entrypoint *ep, struct basic_block *bb,
+			  struct instruction *insn,
+			  struct context_check_list **combined)
+{
+	struct context_check *c;
+	const char *name;
+	char *buf;
+	int val, ok;
+
+	val = 0;
+
+	name = unnamed_context;
+	if (insn->context_expr)
+		name = show_ident(insn->context_expr->symbol_name);
+
+	FOR_EACH_PTR(*combined, c) {
+		if (strcmp(c->name, name) == 0) {
+			val = c->val;
+			break;
+		}
+	} END_FOR_EACH_PTR(c);
+
+	ok = insn->required <= val;
+
+	if (!ok && Wcontext) {
+		get_context_string(&buf, &name);
+
+		warning(insn->pos,
+			IMBALANCE_IN
+			"__context__ statement expected different context",
+			show_ident(ep->name->ident));
+
+		info(insn->pos, "%swanted >= %d, got %d",
+		     name, insn->required, val);
+
+		free(buf);
+		return -1;
+	}
+
+	context_add(combined, name, insn->increment, insn->inc_false);
+
+	return 0;
+}
+
 static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
 			    struct context_check_list *ccl_in,
 			    struct context_check_list *ccl_target,
@@ -116,16 +238,21 @@ static int check_bb_context(struct entry
 	struct context_check *c;
 	struct instruction *insn;
 	struct multijmp *mj;
-	struct context *ctx;
-	const char *name;
-	int ok, val;
 
-	/* recurse in once to catch bad loops */
+	/*
+	 * recurse in once to catch bad loops,
+	 * bb->context is initialised to -1.
+	 */
 	if (bb->context > 0)
 		return 0;
-
 	bb->context++;
 
+	/*
+	 * We're starting with a completely new local list of contexts, so
+	 * initialise it according to what we got from the parent block.
+	 * That may use either the 'false' or the 'true' part of the context
+	 * for the conditional_context() attribute.
+	 */
 	FOR_EACH_PTR(ccl_in, c) {
 		if (in_false)
 			context_add(&combined, c->name, c->val_false, c->val_false);
@@ -133,76 +260,37 @@ static int check_bb_context(struct entry
 			context_add(&combined, c->name, c->val, c->val);
 	} END_FOR_EACH_PTR(c);
 
+	/*
+	 * Now walk the instructions for this block, recursing into any
+	 * instructions that have children. We need to have the right
+	 * order so we cannot iterate bb->children instead.
+	 */
 	FOR_EACH_PTR(bb->insns, insn) {
-		if (!insn->bb)
-			continue;
 		switch (insn->opcode) {
 		case OP_INLINED_CALL:
 		case OP_CALL:
-			if (!insn->func || !insn->func->sym || insn->func->type != PSEUDO_SYM)
-				break;
-			FOR_EACH_PTR(insn->func->sym->ctype.contexts, ctx) {
-				name = context_name(ctx);
-				val = 0;
-
-				FOR_EACH_PTR(combined, c) {
-					if (strcmp(c->name, name) == 0) {
-						val = c->val;
-						break;
-					}
-				} END_FOR_EACH_PTR(c);
-
-				if (ctx->exact)
-					ok = ctx->in == val;
-				else
-					ok = ctx->in <= val;
-
-				if (!ok) {
-					const char *call = strdup(show_ident(insn->func->ident));
-					warning(insn->pos, "context problem in '%s' - function '%s' expected different context",
-						show_ident(ep->name->ident), call);
-					free((void *)call);
-					return -1;
-				}
-			} END_FOR_EACH_PTR (ctx);
+			if (handle_call(ep, bb, insn, combined))
+				return -1;
 			break;
 		case OP_CONTEXT:
-			val = 0;
-
-			name = unnamed_context;
-			if (insn->context_expr)
-				name = show_ident(insn->context_expr->symbol_name);
-
-			FOR_EACH_PTR(combined, c) {
-				if (strcmp(c->name, name) == 0) {
-					val = c->val;
-					break;
-				}
-			} END_FOR_EACH_PTR(c);
-
-			ok = insn->required <= val;
-
-			if (!ok) {
-				name = strdup(name);
-				imbalance(ep, insn->pos, name, "__context__ statement expected different lock context");
-				free((void *)name);
+			if (handle_context(ep, bb, insn, &combined))
 				return -1;
-			}
-
-			context_add(&combined, name, insn->increment, insn->inc_false);
 			break;
 		case OP_BR:
 			if (insn->bb_true)
-				if (check_bb_context(ep, insn->bb_true, combined, ccl_target, 0))
+				if (check_bb_context(ep, insn->bb_true,
+						     combined, ccl_target, 0))
 					return -1;
 			if (insn->bb_false)
-				if (check_bb_context(ep, insn->bb_false, combined, ccl_target, 1))
+				if (check_bb_context(ep, insn->bb_false,
+						     combined, ccl_target, 1))
 					return -1;
 			break;
 		case OP_SWITCH:
 		case OP_COMPUTEDGOTO:
 			FOR_EACH_PTR(insn->multijmp_list, mj) {
-				if (check_bb_context(ep, mj->target, combined, ccl_target, 0))
+				if (check_bb_context(ep, mj->target,
+					             combined, ccl_target, 0))
 					return -1;
 			} END_FOR_EACH_PTR(mj);
 			break;
@@ -212,16 +300,10 @@ static int check_bb_context(struct entry
 	insn = last_instruction(bb->insns);
 	if (!insn)
 		return 0;
+
 	if (insn->opcode == OP_RET)
 		return context_list_check(ep, insn->pos, combined, ccl_target);
 
-	FOR_EACH_PTR(bb->insns, insn) {
-		if (!insn->bb)
-			continue;
-		switch (insn->opcode) {
-		}
-	} END_FOR_EACH_PTR(insn);
-
 	/* contents will be freed once we return out of recursion */
 	free_ptr_list(&combined);
 
--- sparse.orig/validation/context-dynamic.c	2008-04-11 12:43:44.000000000 +0200
+++ sparse/validation/context-dynamic.c	2008-04-11 12:47:44.000000000 +0200
@@ -151,11 +151,21 @@ static int good_switch(void)
     r();
 }
 
+static void bad_lock1(void)
+{
+    r();
+    a();
+}
+
 /*
  * check-name: Check -Wcontext with lock trylocks
  *
  * check-error-start
-context-dynamic.c:83:6: warning: context problem in 'bad_trylock1' - function 'r' expected different context
-context-dynamic.c:133:6: warning: context problem in 'bad_trylock2' - function 'r' expected different context
+context-dynamic.c:83:6: warning: context problem in 'bad_trylock1': 'r' expected different context
+context-dynamic.c:83:6:    context 'A': wanted >= 1, got 0
+context-dynamic.c:133:6: warning: context problem in 'bad_trylock2': 'r' expected different context
+context-dynamic.c:133:6:    context 'A': wanted >= 1, got 0
+context-dynamic.c:156:6: warning: context problem in 'bad_lock1': 'r' expected different context
+context-dynamic.c:156:6:    context 'A': wanted >= 1, got 0
  * check-error-end
  */
--- sparse.orig/validation/context-named.c	2008-04-11 12:46:36.000000000 +0200
+++ sparse/validation/context-named.c	2008-04-11 12:54:45.000000000 +0200
@@ -501,29 +501,53 @@ static void good_mixed_with_if(void)
  * check-name: Check -Wcontext with lock names
  *
  * check-error-start
-context-named.c:86:3: warning: context imbalance in 'warn_lock1' - wrong count at exit (TEST)
-context-named.c:93:3: warning: context imbalance in 'warn_lock2' - wrong count at exit (TEST)
-context-named.c:100:3: warning: context imbalance in 'warn_lock3' - wrong count at exit (TEST)
-context-named.c:105:3: warning: context problem in 'warn_unlock1' - function 'r' expected different context
-context-named.c:112:3: warning: context problem in 'warn_unlock2' - function 'r' expected different context
-context-named.c:152:9: warning: context imbalance in 'warn_if1' - wrong count at exit (TEST)
-context-named.c:162:9: warning: context imbalance in 'warn_if2' - wrong count at exit (TEST)
-context-named.c:218:4: warning: context imbalance in 'warn_while1' - wrong count at exit (TEST)
-context-named.c:225:4: warning: context problem in 'warn_while2' - function 'r' expected different context
-context-named.c:235:4: warning: context imbalance in 'warn_while3' - wrong count at exit (TEST)
-context-named.c:295:5: warning: context imbalance in 'warn_goto1' - wrong count at exit (TEST)
-context-named.c:305:6: warning: context imbalance in 'warn_goto2' - wrong count at exit (TEST)
-context-named.c:315:6: warning: context problem in 'warn_goto3' - function 'r' expected different context
-context-named.c:321:7: warning: context imbalance in 'warn_multiple1' - wrong count at exit (TEST)
-context-named.c:327:6: warning: context imbalance in 'warn_multiple2' - wrong count at exit (TEST2)
-context-named.c:333:6: warning: context problem in 'warn_mixed1' - function 'r' expected different context
-context-named.c:343:6: warning: context problem in 'warn_mixed2' - function 'r' expected different context
-context-named.c:353:6: warning: context problem in 'warn_mixed3' - function 'r' expected different context
-context-named.c:364:6: warning: context imbalance in 'warn_mixed4' - wrong count at exit (TEST2)
-context-named.c:434:14: warning: context problem in 'warn_fn' - function 'need_lock' expected different context
-context-named.c:441:15: warning: context problem in 'warn_fn2' - function 'need_lock2' expected different context
-context-named.c:456:20: warning: context problem in 'warn_exact_fn1' - function 'need_lock_exact' expected different context
-context-named.c:464:20: warning: context problem in 'warn_exact_fn2' - function 'need_lock_exact' expected different context
-context-named.c:475:15: warning: context problem in 'warn_fn3' - function 'need_lock3' expected different context
+context-named.c:86:3: warning: context imbalance in 'warn_lock1': wrong count at exit
+context-named.c:86:3:    context 'TEST': wanted 0, got 1
+context-named.c:93:3: warning: context imbalance in 'warn_lock2': wrong count at exit
+context-named.c:93:3:    context 'TEST': wanted 0, got 1
+context-named.c:100:3: warning: context imbalance in 'warn_lock3': wrong count at exit
+context-named.c:100:3:    context 'TEST': wanted 0, got 1
+context-named.c:105:3: warning: context problem in 'warn_unlock1': 'r' expected different context
+context-named.c:105:3:    context 'TEST': wanted >= 1, got 0
+context-named.c:112:3: warning: context problem in 'warn_unlock2': 'r' expected different context
+context-named.c:112:3:    context 'TEST': wanted >= 1, got 0
+context-named.c:152:9: warning: context imbalance in 'warn_if1': wrong count at exit
+context-named.c:152:9:    context 'TEST': wanted 0, got 1
+context-named.c:162:9: warning: context imbalance in 'warn_if2': wrong count at exit
+context-named.c:162:9:    context 'TEST': wanted 0, got 1
+context-named.c:218:4: warning: context imbalance in 'warn_while1': wrong count at exit
+context-named.c:218:4:    context 'TEST': wanted 0, got 1
+context-named.c:225:4: warning: context problem in 'warn_while2': 'r' expected different context
+context-named.c:225:4:    context 'TEST': wanted >= 1, got 0
+context-named.c:235:4: warning: context imbalance in 'warn_while3': wrong count at exit
+context-named.c:235:4:    context 'TEST': wanted 0, got 1
+context-named.c:295:5: warning: context imbalance in 'warn_goto1': wrong count at exit
+context-named.c:295:5:    context 'TEST': wanted 0, got 1
+context-named.c:305:6: warning: context imbalance in 'warn_goto2': wrong count at exit
+context-named.c:305:6:    context 'TEST': wanted 0, got 1
+context-named.c:315:6: warning: context problem in 'warn_goto3': 'r' expected different context
+context-named.c:315:6:    context 'TEST': wanted >= 1, got 0
+context-named.c:321:7: warning: context imbalance in 'warn_multiple1': wrong count at exit
+context-named.c:321:7:    context 'TEST': wanted 0, got 1
+context-named.c:327:6: warning: context imbalance in 'warn_multiple2': wrong count at exit
+context-named.c:327:6:    context 'TEST2': wanted 0, got 1
+context-named.c:333:6: warning: context problem in 'warn_mixed1': 'r' expected different context
+context-named.c:333:6:    context 'TEST': wanted >= 1, got 0
+context-named.c:343:6: warning: context problem in 'warn_mixed2': 'r' expected different context
+context-named.c:343:6:    context 'TEST': wanted >= 1, got 0
+context-named.c:353:6: warning: context problem in 'warn_mixed3': 'r' expected different context
+context-named.c:353:6:    context 'TEST': wanted >= 1, got 0
+context-named.c:364:6: warning: context imbalance in 'warn_mixed4': wrong count at exit
+context-named.c:364:6:    context 'TEST2': wanted 0, got 1
+context-named.c:434:14: warning: context problem in 'warn_fn': 'need_lock' expected different context
+context-named.c:434:14:    context 'TEST': wanted >= 1, got 0
+context-named.c:441:15: warning: context problem in 'warn_fn2': 'need_lock2' expected different context
+context-named.c:441:15:    context 'TEST': wanted >= 1, got 0
+context-named.c:456:20: warning: context problem in 'warn_exact_fn1': 'need_lock_exact' expected different context
+context-named.c:456:20:    context 'TEST': wanted 1, got 2
+context-named.c:464:20: warning: context problem in 'warn_exact_fn2': 'need_lock_exact' expected different context
+context-named.c:464:20:    context 'TEST': wanted 1, got 0
+context-named.c:475:15: warning: context problem in 'warn_fn3': 'need_lock3' expected different context
+context-named.c:475:15:    context 'TEST': wanted >= 1, got 0
  * check-error-end
  */
--- sparse.orig/validation/context-statement.c	2008-04-11 12:43:44.000000000 +0200
+++ sparse/validation/context-statement.c	2008-04-11 12:47:44.000000000 +0200
@@ -47,12 +47,23 @@ static void bad_macro2(void)
     m();
 }
 
+static void bad_macro3(void)
+{
+    r();
+    a();
+}
+
 /*
  * check-name: Check __context__ statement with required context
  *
  * check-error-start
-context-statement.c:16:8: warning: context imbalance in 'bad_arr' - unexpected unlock (LOCK)
-context-statement.c:38:5: warning: context imbalance in 'bad_macro1' - __context__ statement expected different lock context (LOCK)
-context-statement.c:47:5: warning: context imbalance in 'bad_macro2' - __context__ statement expected different lock context (LOCK)
+context-statement.c:16:8: warning: context imbalance in 'bad_arr': unexpected unlock
+context-statement.c:16:8:    context 'LOCK': wanted 0, got -1
+context-statement.c:38:5: warning: context imbalance in 'bad_macro1': __context__ statement expected different context
+context-statement.c:38:5:    context 'LOCK': wanted >= 1, got 0
+context-statement.c:47:5: warning: context imbalance in 'bad_macro2': __context__ statement expected different context
+context-statement.c:47:5:    context 'LOCK': wanted >= 1, got 0
+context-statement.c:53:5: warning: context imbalance in 'bad_macro3': __context__ statement expected different context
+context-statement.c:53:5:    context 'LOCK': wanted >= 0, got -1
  * check-error-end
  */
--- sparse.orig/validation/context.c	2008-04-11 12:43:44.000000000 +0200
+++ sparse/validation/context.c	2008-04-11 12:47:44.000000000 +0200
@@ -325,24 +325,84 @@ static void warn_odd_looping(void)
         r();
 }
 
+static void warn_huge_switch(void)
+{
+    a();
+
+    switch(condition) {
+    case 1:
+        r();
+        break;
+    case 2:
+        r();
+        break;
+    case 3:
+        r();
+        break;
+    case 4:
+        r();
+        break;
+    case 5:
+        r();
+        break;
+    case 11:
+        r();
+        break;
+    case 12:
+        r();
+        break;
+    case 13:
+        r();
+        break;
+    case 14:
+        r();
+    case 15:
+        r();
+        break;
+    case 16:
+        r();
+        break;
+    case 17:
+        r();
+        break;
+    }
+}
+
 /*
  * check-name: Check -Wcontext
  *
  * check-error-start
-context.c:71:3: warning: context imbalance in 'warn_lock1' - wrong count at exit
-context.c:78:3: warning: context imbalance in 'warn_lock2' - wrong count at exit
-context.c:85:3: warning: context imbalance in 'warn_lock3' - wrong count at exit
-context.c:90:3: warning: context problem in 'warn_unlock1' - function 'r' expected different context
-context.c:97:3: warning: context problem in 'warn_unlock2' - function 'r' expected different context
-context.c:137:9: warning: context imbalance in 'warn_if1' - wrong count at exit
-context.c:147:9: warning: context imbalance in 'warn_if2' - wrong count at exit
-context.c:203:4: warning: context imbalance in 'warn_while1' - wrong count at exit
-context.c:210:4: warning: context problem in 'warn_while2' - function 'r' expected different context
-context.c:220:4: warning: context imbalance in 'warn_while3' - wrong count at exit
-context.c:280:5: warning: context imbalance in 'warn_goto1' - wrong count at exit
-context.c:290:6: warning: context imbalance in 'warn_goto2' - wrong count at exit
-context.c:300:6: warning: context problem in 'warn_goto3' - function 'r' expected different context
-context.c:315:6: warning: context problem in 'warn_cond_lock1' - function 'r' expected different context
-context.c:325:10: warning: context problem in 'warn_odd_looping' - function 'r' expected different context
+context.c:71:3: warning: context imbalance in 'warn_lock1': wrong count at exit
+context.c:71:3:    default context: wanted 0, got 1
+context.c:78:3: warning: context imbalance in 'warn_lock2': wrong count at exit
+context.c:78:3:    default context: wanted 0, got 1
+context.c:85:3: warning: context imbalance in 'warn_lock3': wrong count at exit
+context.c:85:3:    default context: wanted 0, got 1
+context.c:90:3: warning: context problem in 'warn_unlock1': 'r' expected different context
+context.c:90:3:    default context: wanted >= 1, got 0
+context.c:97:3: warning: context problem in 'warn_unlock2': 'r' expected different context
+context.c:97:3:    default context: wanted >= 1, got 0
+context.c:137:9: warning: context imbalance in 'warn_if1': wrong count at exit
+context.c:137:9:    default context: wanted 0, got 1
+context.c:147:9: warning: context imbalance in 'warn_if2': wrong count at exit
+context.c:147:9:    default context: wanted 0, got 1
+context.c:203:4: warning: context imbalance in 'warn_while1': wrong count at exit
+context.c:203:4:    default context: wanted 0, got 1
+context.c:210:4: warning: context problem in 'warn_while2': 'r' expected different context
+context.c:210:4:    default context: wanted >= 1, got 0
+context.c:220:4: warning: context imbalance in 'warn_while3': wrong count at exit
+context.c:220:4:    default context: wanted 0, got 1
+context.c:280:5: warning: context imbalance in 'warn_goto1': wrong count at exit
+context.c:280:5:    default context: wanted 0, got 1
+context.c:290:6: warning: context imbalance in 'warn_goto2': wrong count at exit
+context.c:290:6:    default context: wanted 0, got 1
+context.c:300:6: warning: context problem in 'warn_goto3': 'r' expected different context
+context.c:300:6:    default context: wanted >= 1, got 0
+context.c:315:6: warning: context problem in 'warn_cond_lock1': 'r' expected different context
+context.c:315:6:    default context: wanted >= 1, got 0
+context.c:325:10: warning: context problem in 'warn_odd_looping': 'r' expected different context
+context.c:325:10:    default context: wanted >= 1, got 0
+context.c:360:10: warning: context problem in 'warn_huge_switch': 'r' expected different context
+context.c:360:10:    default context: wanted >= 1, got 0
  * check-error-end
  */


