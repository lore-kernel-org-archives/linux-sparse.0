From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH] use OP_PUSH + OP_CALL
Date: Fri, 17 Mar 2017 12:30:39 +0100
Message-ID: <20170317113039.32507-1-luc.vanoostenryck@gmail.com>
References: <CA+55aFzKqWTZBdDG+ecedw40HxEs0FezqJBuc=VRTvj1Bmps7Q@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36848 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdCQLar (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Mar 2017 07:30:47 -0400
Received: by mail-wr0-f194.google.com with SMTP id l37so9172833wrc.3
        for <linux-sparse@vger.kernel.org>; Fri, 17 Mar 2017 04:30:46 -0700 (PDT)
In-Reply-To: <CA+55aFzKqWTZBdDG+ecedw40HxEs0FezqJBuc=VRTvj1Bmps7Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Here is the introduction of a new instruction
very similar to 'push' instructions in real CPU
which purpose is to give a correct type to function
arguments.

It seems to work well but I still need to check
liveness & DCE.

sparse-llvm is fine with it too but it will need
to be first integrated with the other changes.


-- Luc Van Oostenryck

---
 example.c                  |  4 ++--
 linearize.c                | 29 +++++++++++++++++++++--------
 linearize.h                |  7 ++++++-
 liveness.c                 | 14 ++++++++------
 simplify.c                 | 11 ++++++++++-
 sparse-llvm.c              |  4 ++--
 validation/call-variadic.c | 31 +++++++++++++++++++++++++++++++
 7 files changed, 80 insertions(+), 20 deletions(-)
 create mode 100644 validation/call-variadic.c

diff --git a/example.c b/example.c
index 691e0f97c..69e00b325 100644
--- a/example.c
+++ b/example.c
@@ -1121,11 +1121,11 @@ static void generate_ret(struct bb_state *state, struct instruction *ret)
  */
 static void generate_call(struct bb_state *state, struct instruction *insn)
 {
+	struct instruction *arg;
 	int offset = 0;
-	pseudo_t arg;
 
 	FOR_EACH_PTR(insn->arguments, arg) {
-		output_insn(state, "pushl %s", generic(state, arg));
+		output_insn(state, "pushl %s", generic(state, arg->src));
 		offset += 4;
 	} END_FOR_EACH_PTR(arg);
 	flush_reg(state, hardregs+0);
diff --git a/linearize.c b/linearize.c
index 5199b6b02..d5ac71f3d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -233,6 +233,7 @@ static const char *opcodes[] = {
 	[OP_FPCAST] = "fpcast",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_INLINED_CALL] = "# call",
+	[OP_PUSH] = "push",
 	[OP_CALL] = "call",
 	[OP_VANEXT] = "va_next",
 	[OP_VAARG] = "va_arg",
@@ -407,17 +408,15 @@ const char *show_instruction(struct instruction *insn)
 	case OP_STORE: case OP_SNOP:
 		buf += sprintf(buf, "%s -> %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
+	case OP_PUSH:
+		buf += sprintf(buf, "%s", show_pseudo(insn->src));
+		break;
 	case OP_INLINED_CALL:
-	case OP_CALL: {
-		struct pseudo *arg;
+	case OP_CALL:
 		if (insn->target && insn->target != VOID)
 			buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 		buf += sprintf(buf, "%s", show_pseudo(insn->func));
-		FOR_EACH_PTR(insn->arguments, arg) {
-			buf += sprintf(buf, ", %s", show_pseudo(arg));
-		} END_FOR_EACH_PTR(arg);
 		break;
-	}
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_FPCAST:
@@ -1197,6 +1196,20 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 	return value;
 }
 
+/*
+ * Add an argument for a call.
+ *   -) insn->opcode == O_CALL | OP_INLINE_CALL
+ *   -) ctype = typeof(arg)
+ */
+static void push_argument(struct entrypoint *ep, struct instruction *insn, pseudo_t arg, struct symbol *ctype)
+{
+	struct instruction *push = alloc_typed_instruction(OP_PUSH, ctype);
+	push->call = insn;
+	use_pseudo(push, arg, &push->src);
+	add_instruction(&insn->arguments, push);
+	add_one_insn(ep, push);
+}
+
 static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expression *expr)
 {
 	struct expression *arg, *fn;
@@ -1213,7 +1226,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 
 	FOR_EACH_PTR(expr->args, arg) {
 		pseudo_t new = linearize_expression(ep, arg);
-		use_pseudo(insn, new, add_pseudo(&insn->arguments, new));
+		push_argument(ep, insn, new, arg->ctype);
 	} END_FOR_EACH_PTR(arg);
 
 	fn = expr->fn;
@@ -1680,7 +1693,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
 		concat_symbol_list(args->declaration, &ep->syms);
 		FOR_EACH_PTR(args->declaration, sym) {
 			pseudo_t value = linearize_one_symbol(ep, sym);
-			use_pseudo(insn, value, add_pseudo(&insn->arguments, value));
+			push_argument(ep, insn, value, sym);
 		} END_FOR_EACH_PTR(sym);
 	}
 
diff --git a/linearize.h b/linearize.h
index bac82d7ff..7b6e53fc5 100644
--- a/linearize.h
+++ b/linearize.h
@@ -112,9 +112,13 @@ struct instruction {
 		};
 		struct /* call */ {
 			pseudo_t func;
-			struct pseudo_list *arguments;
+			struct instruction_list *arguments;
 			struct symbol *fntype;
 		};
+		struct /* push/arg */ {
+			pseudo_t arg;			/* same as src, src1 & symbol */
+			struct instruction *call;
+		};
 		struct /* context */ {
 			int increment;
 			int check;
@@ -201,6 +205,7 @@ enum opcode {
 	OP_FPCAST,
 	OP_PTRCAST,
 	OP_INLINED_CALL,
+	OP_PUSH,
 	OP_CALL,
 	OP_VANEXT,
 	OP_VAARG,
diff --git a/liveness.c b/liveness.c
index 7461738b4..7b5b1693a 100644
--- a/liveness.c
+++ b/liveness.c
@@ -46,13 +46,12 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	void (*def)(struct basic_block *, pseudo_t),
 	void (*use)(struct basic_block *, pseudo_t))
 {
-	pseudo_t pseudo;
-
 	#define USES(x)		use(bb, insn->x)
 	#define DEFINES(x)	def(bb, insn->x)
 
 	switch (insn->opcode) {
 	case OP_RET:
+	case OP_PUSH:
 		USES(src);
 		break;
 
@@ -118,14 +117,17 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		USES(src); DEFINES(target);
 		break;
 
-	case OP_CALL:
+	case OP_CALL: {
+		struct instruction *arg;
+
 		USES(func);
 		if (insn->target != VOID)
 			DEFINES(target);
-		FOR_EACH_PTR(insn->arguments, pseudo) {
-			use(bb, pseudo);
-		} END_FOR_EACH_PTR(pseudo);
+		FOR_EACH_PTR(insn->arguments, arg) {
+			use(bb, arg->src);
+		} END_FOR_EACH_PTR(arg);
 		break;
+	}
 
 	case OP_SLICE:
 		USES(base); DEFINES(target);
diff --git a/simplify.c b/simplify.c
index 5d00937f1..9a3abdff4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -182,6 +182,14 @@ static void kill_use_list(struct pseudo_list *list)
 	} END_FOR_EACH_PTR(p);
 }
 
+static void kill_insn_list(struct instruction_list *list)
+{
+	struct instruction *insn;
+	FOR_EACH_PTR(list, insn) {
+		kill_insn(insn, 0);
+	} END_FOR_EACH_PTR(insn);
+}
+
 /*
  * kill an instruction:
  * - remove it from its bb
@@ -213,6 +221,7 @@ void kill_insn(struct instruction *insn, int force)
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
 	case OP_SLICE:
+	case OP_PUSH:
 		kill_use(&insn->src1);
 		break;
 
@@ -240,7 +249,7 @@ void kill_insn(struct instruction *insn, int force)
 			if (!(insn->func->sym->ctype.modifiers & MOD_PURE))
 				return;
 		}
-		kill_use_list(insn->arguments);
+		kill_insn_list(insn->arguments);
 		if (insn->func->type == PSEUDO_REG)
 			kill_use(&insn->func);
 		break;
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f362b3ed..ecc4f032f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -707,7 +707,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 {
 	LLVMValueRef target, func;
 	int n_arg = 0, i;
-	struct pseudo *arg;
+	struct instruction *arg;
 	LLVMValueRef *args;
 
 	FOR_EACH_PTR(insn->arguments, arg) {
@@ -718,7 +718,7 @@ static void output_op_call(struct function *fn, struct instruction *insn)
 
 	i = 0;
 	FOR_EACH_PTR(insn->arguments, arg) {
-		args[i++] = pseudo_to_value(fn, insn, arg);
+		args[i++] = pseudo_to_value(fn, arg, arg->src);
 	} END_FOR_EACH_PTR(arg);
 
 	func = pseudo_to_value(fn, insn, insn->func);
diff --git a/validation/call-variadic.c b/validation/call-variadic.c
new file mode 100644
index 000000000..372c8fc7d
--- /dev/null
+++ b/validation/call-variadic.c
@@ -0,0 +1,31 @@
+#define NULL	((void*)0)
+
+extern int print(const char *msg, ...);
+
+int foo(int a, long l, int *p)
+{
+	print("msg %c: %d %d/%ld %ld/%p %p\n", 'x', a, __LINE__, l, 0L, p, NULL);
+}
+
+/*
+ * check-name: call-variadic
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+foo:
+.L0:
+	<entry-point>
+	push.64     "msg %c: %d %d/%ld %ld/%p %p\n"
+	push.32     $120
+	push.32     %arg1
+	push.32     $7
+	push.64     %arg2
+	push.64     $0
+	push.64     %arg3
+	push.64     $0
+	call.32     %r5 <- print
+	ret.32      %r5
+
+
+ * check-output-end
+ */
-- 
2.12.0

