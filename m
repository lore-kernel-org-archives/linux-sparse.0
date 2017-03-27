From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 10/15] insure that all OP_PUSHs are just before their OP_CALL
Date: Mon, 27 Mar 2017 19:34:00 +0200
Message-ID: <20170327173405.11405-11-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35587 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbdC0RhN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so12377259wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:23 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

These OP_PUSH doesn't really operate on a stack, they're
there just to give the args to the call. As such, we want
to have all of them just before their corresponding OP_CALL.

Currently, it's not the case as we push the args as soon as
they're linearized. So code like:
	int foo(int a, int b, int c) { return f(a, f(b, c)); }
is linearized as something like:
	foo:
		push	%arg1
		push	%arg2
		push	%arg3
		call	%r1 <- f
		push	%r1
		call	%r2 <- f
		ret	%r2
while we want something like:
	foo:
		push	%arg2
		push	%arg3
		call	%r1 <- f
		push	%arg1
		push	%r1
		call	%r2 <- f
		ret	%r2

Fix this by first linearizing all the arguments and only then
adding the OP_PUSH instructions instead of pushing each arg
as soon as it is linearized.

Note: this is purely for the readability of the generated code,
      the push instructions being anyway linked by their
      respective OP_CALL.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c            | 14 +++++++++++---
 validation/push-call.c | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 validation/push-call.c

diff --git a/linearize.c b/linearize.c
index f1f98947f..d4610de8f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1210,19 +1210,19 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
  *   -) insn->opcode == O_CALL | OP_INLINE_CALL
  *   -) ctype = typeof(arg)
  */
-static void push_argument(struct entrypoint *ep, struct instruction *insn, pseudo_t arg, struct symbol *ctype)
+static void push_argument(struct instruction *insn, pseudo_t arg, struct symbol *ctype)
 {
 	struct instruction *push = alloc_typed_instruction(OP_PUSH, ctype);
 	push->call = insn;
 	use_pseudo(push, arg, &push->src);
 	add_instruction(&insn->arguments, push);
-	add_one_insn(ep, push);
 }
 
 static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expression *expr)
 {
 	struct expression *arg, *fn;
 	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
+	struct instruction *push;
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
 	struct symbol *fntype;
@@ -1233,11 +1233,19 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 		return VOID;
 	}
 
+	// first generate all the parameters
 	FOR_EACH_PTR(expr->args, arg) {
 		pseudo_t new = linearize_expression(ep, arg);
-		push_argument(ep, insn, new, arg->ctype);
+		push_argument(insn, new, arg->ctype);
 	} END_FOR_EACH_PTR(arg);
 
+	// and push them all just before the actual call
+	// (because the linearization of the arguments can
+	//  create other calls)
+	FOR_EACH_PTR(insn->arguments, push) {
+		add_one_insn(ep, push);
+	} END_FOR_EACH_PTR(push);
+
 	fn = expr->fn;
 
 	if (fn->ctype)
diff --git a/validation/push-call.c b/validation/push-call.c
new file mode 100644
index 000000000..8151e0c70
--- /dev/null
+++ b/validation/push-call.c
@@ -0,0 +1,26 @@
+int f(int a, int b);
+
+int fun(int a, int b, int c)
+{
+	return f(a, f(b, c));
+}
+
+/*
+ * check-name: push-call
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+fun:
+.L0:
+	<entry-point>
+	push.32     %arg2
+	push.32     %arg3
+	call.32     %r4 <- f
+	push.32     %arg1
+	push.32     %r4
+	call.32     %r5 <- f
+	ret.32      %r5
+
+
+ * check-output-end
+ */
-- 
2.12.0

