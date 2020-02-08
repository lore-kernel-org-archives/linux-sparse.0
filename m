From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] do the tree inlining during expansion phase
Date: Sun,  9 Feb 2020 00:57:18 +0100
Message-ID: <20200208235718.96389-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54046 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbgBHX71 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Feb 2020 18:59:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so6127767wmh.3
        for <linux-sparse@vger.kernel.org>; Sat, 08 Feb 2020 15:59:25 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the tree inlining is done very early, during the
evaluation phase. This means that the inlining is done even
if the corresponding call belong to a sub-expression that
will be discarded during the expansion phase.
Usually this is not a problem but in some pathological
cases it can lead to a huge waste of memory and CPU time.

So, move this inline expansion to ... the expansion phase.
Also, re-expand the resulting expression since constant
arguments may create new opportunities for simplification.

Note: the motivation for thsi is a pathological case in the
      kernel where a combination of max_t() + const_ilog2() +
      roundup_pow_of_two() + cpumask_weight() + __const_hweight*()
      caused Sparse to use 2.3Gb of memory. With this patch
      the memory consumption is down to 247Mb.

Link: https://marc.info/?l=linux-sparse&m=158098958501220
Link: https://lore.kernel.org/netdev/CAHk-=whvS9x5NKtOqcUgJeTY7dfdAHc
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Originally-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 16 ----------------
 expand.c   | 19 +++++++++++++++++++
 inline.c   |  5 -----
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f1a266beccfd..b7bb1f52aa91 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3107,22 +3107,6 @@ static int evaluate_symbol_call(struct expression *expr)
 	if (ctype->op && ctype->op->evaluate)
 		return ctype->op->evaluate(expr);
 
-	if (ctype->ctype.modifiers & MOD_INLINE) {
-		int ret;
-		struct symbol *curr = current_fn;
-
-		if (ctype->definition)
-			ctype = ctype->definition;
-
-		current_fn = ctype->ctype.base_type;
-
-		ret = inline_function(expr, ctype);
-
-		/* restore the old function */
-		current_fn = curr;
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/expand.c b/expand.c
index 36612c8672dd..e75598781b6c 100644
--- a/expand.c
+++ b/expand.c
@@ -910,6 +910,25 @@ static int expand_symbol_call(struct expression *expr, int cost)
 	if (fn->type != EXPR_PREOP)
 		return SIDE_EFFECTS;
 
+	if (ctype->ctype.modifiers & MOD_INLINE) {
+		struct symbol *def;
+
+		def = ctype->definition ? ctype->definition : ctype;
+		if (inline_function(expr, def)) {
+			struct symbol *fn = def->ctype.base_type;
+			struct symbol *curr = current_fn;
+
+			current_fn = fn;
+			evaluate_statement(expr->statement);
+			current_fn = curr;
+
+			fn->expanding = 1;
+			cost = expand_expression(expr);
+			fn->expanding = 0;
+			return cost;
+		}
+	}
+
 	if (ctype->op && ctype->op->expand)
 		return ctype->op->expand(expr, cost);
 
diff --git a/inline.c b/inline.c
index 6f73a30556bc..a959728013f1 100644
--- a/inline.c
+++ b/inline.c
@@ -519,8 +519,6 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	if (fn->expanding)
 		return 0;
 
-	fn->expanding = 1;
-
 	name_list = fn->arguments;
 
 	expr->type = EXPR_STATEMENT;
@@ -558,9 +556,6 @@ int inline_function(struct expression *expr, struct symbol *sym)
 
 	unset_replace_list(fn_symbol_list);
 
-	evaluate_statement(stmt);
