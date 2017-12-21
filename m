From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] fix linearize (*fun)()
Date: Thu, 21 Dec 2017 01:06:42 +0100
Message-ID: <20171221000642.56954-4-luc.vanoostenryck@gmail.com>
References: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34902 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756614AbdLUAIv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Dec 2017 19:08:51 -0500
Received: by mail-wm0-f67.google.com with SMTP id f9so12880453wmh.0
        for <linux-sparse@vger.kernel.org>; Wed, 20 Dec 2017 16:08:50 -0800 (PST)
In-Reply-To: <20171221000642.56954-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A function call via a function pointer can be written like:
	fp(), (fp)() or (*fp)()
In the latter case the dereference is unneeded but legal and
idiomatic.

However, the linearization doesn't handle this unneeded deref
and leads to the generation of a load of the pointer:

	int foo(int a, int (*fun)(int))
	{
		(*fun)(a);
	}

gives something like:
	foo:
		load        %r2 <- 0[%arg2]
		call.32     %r3 <- %r2, %arg1
		ret.32      %r3

This happens because, at linearization, the deref is dropped
but only if the sub-expression is a symbol and the test for
node is not done.

Fix this by using is_func_type() to test the type of all call
expressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                             | 10 +++-------
 validation/linear/call-basic.c          |  1 -
 validation/linear/call-casted-pointer.c |  1 -
 validation/linear/call-indirect.c       |  1 -
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 7ad348c00..2e146de7a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1291,13 +1291,9 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 		add_symbol(&insn->fntypes, arg->ctype);
 	} END_FOR_EACH_PTR(arg);
 
-	if (fn->type == EXPR_PREOP) {
-		if (fn->unop->type == EXPR_SYMBOL) {
-			struct symbol *sym = fn->unop->symbol;
-			if (sym->ctype.base_type->type == SYM_FN)
-				fn = fn->unop;
-		}
-	}
+	if (fn->type == EXPR_PREOP && fn->op == '*' && is_func_type(fn->ctype))
+		fn = fn->unop;
+
 	if (fn->type == EXPR_SYMBOL) {
 		call = symbol_pseudo(ep, fn->symbol);
 	} else {
diff --git a/validation/linear/call-basic.c b/validation/linear/call-basic.c
index 235b443d2..60517e2e3 100644
--- a/validation/linear/call-basic.c
+++ b/validation/linear/call-basic.c
@@ -23,7 +23,6 @@ int builtin(int a)
 /*
  * check-name: basic function calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-start
 symbol:
diff --git a/validation/linear/call-casted-pointer.c b/validation/linear/call-casted-pointer.c
index e66f69990..610d67482 100644
--- a/validation/linear/call-casted-pointer.c
+++ b/validation/linear/call-casted-pointer.c
@@ -23,7 +23,6 @@ int quz(void *a, void *fun)
 /*
  * check-name: call via casted function pointer
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
diff --git a/validation/linear/call-indirect.c b/validation/linear/call-indirect.c
index 8ab78676b..f5f2adaf1 100644
--- a/validation/linear/call-indirect.c
+++ b/validation/linear/call-indirect.c
@@ -6,7 +6,6 @@ int g1(int (*fun)(void)) { return (*fun)(); }	// C99,C11 6.5.3.2p4
 /*
  * check-name: indirect calls
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
-- 
2.15.0

