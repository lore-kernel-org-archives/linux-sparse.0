From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 07/63] give function's arguments a type via OP_PUSH
Date: Tue, 21 Mar 2017 01:15:11 +0100
Message-ID: <20170321001607.75169-8-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34252 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755432AbdCUAQ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:28 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so20449137wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:27 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The linearized code, sparse's IR, have no use of C's complex type
system. Those types are checked in previous phases and the pseudos
doesn't a type directly attached to them as all needed type info
are now conveyed by the instructions (like (register) size,
signedness (OP_DIVU vs OP_DIVS), ...).

In particular, PSEUDO_VAL (used for integer and address constants)
are completely typeless.
There is a problem with this when calling a variadic function
with a constant argument as in this case there is no type in the
function prototype (for the variadic part, of course) and there is
no defining instructions holding the type of the argument.

Fix this by adding a new instruction, OP_PUSH, which will be used
to pass arguments to function calls and whose purpose is to give
a correct type/size to function's arguments.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Idea-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 example.c                       |  4 ++--
 linearize.c                     | 35 +++++++++++++++++++++++++++--------
 linearize.h                     | 10 +++++++++-
 liveness.c                      | 14 ++++++++------
 simplify.c                      | 11 ++++++++++-
 sparse-llvm.c                   |  4 ++--
 validation/call-variadic.c      | 31 +++++++++++++++++++++++++++++++
 validation/loop-linearization.c |  9 ++++++---
 8 files changed, 95 insertions(+), 23 deletions(-)
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
index 66d5204d7..34a5125a0 100644
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
@@ -407,17 +408,21 @@ const char *show_instruction(struct instruction *insn)
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
+		if (opcode == OP_INLINED_CALL) {
+			struct pseudo *arg;
+			FOR_EACH_PTR(insn->inlined_args, arg) {
+				buf += sprintf(buf, ", %s", show_pseudo(arg));
+			} END_FOR_EACH_PTR(arg);
+		}
 		break;
-	}
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_FPCAST:
@@ -1197,6 +1202,20 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
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
@@ -1213,7 +1232,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 
 	FOR_EACH_PTR(expr->args, arg) {
 		pseudo_t new = linearize_expression(ep, arg);
-		use_pseudo(insn, new, add_pseudo(&insn->arguments, new));
+		push_argument(ep, insn, new, arg->ctype);
 	} END_FOR_EACH_PTR(arg);
 
 	fn = expr->fn;
@@ -1680,7 +1699,7 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
 		concat_symbol_list(args->declaration, &ep->syms);
 		FOR_EACH_PTR(args->declaration, sym) {
 			pseudo_t value = linearize_one_symbol(ep, sym);
-			add_pseudo(&insn->arguments, value);
+			add_pseudo(&insn->inlined_args, value);
 		} END_FOR_EACH_PTR(sym);
 	}
 
diff --git a/linearize.h b/linearize.h
index bac82d7ff..0cdd0fa9a 100644
--- a/linearize.h
+++ b/linearize.h
@@ -112,9 +112,16 @@ struct instruction {
 		};
 		struct /* call */ {
 			pseudo_t func;
-			struct pseudo_list *arguments;
+			union {
+				struct instruction_list *arguments;
+				struct pseudo_list *inlined_args;
+			};
 			struct symbol *fntype;
 		};
+		struct /* push/arg */ {
+			pseudo_t arg;			/* same as src, src1 & symbol */
+			struct instruction *call;
+		};
 		struct /* context */ {
 			int increment;
 			int check;
@@ -201,6 +208,7 @@ enum opcode {
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
index da40caa65..3f398196d 100644
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
index 000000000..cbb8aa68b
--- /dev/null
+++ b/validation/call-variadic.c
@@ -0,0 +1,31 @@
+#define NULL	((void*)0)
+
+extern int print(const char *msg, ...);
+
+int foo(const char *fmt, int a, long l, int *p)
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
+	push.32     %arg2
+	push.32     $7
+	push.64     %arg3
+	push.64     $0
+	push.64     %arg4
+	push.64     $0
+	call.32     %r5 <- print
+	ret.32      %r5
+
+
+ * check-output-end
+ */
diff --git a/validation/loop-linearization.c b/validation/loop-linearization.c
index 25c6dfb87..d53366bde 100644
--- a/validation/loop-linearization.c
+++ b/validation/loop-linearization.c
@@ -48,7 +48,8 @@ ffor:
 	cbr         %r2, .L1, .L3
 
 .L1:
-	call.32     %r4 <- p, %r1(i)
+	push.32     %r1(i)
+	call.32     %r4 <- p
 	cbr         %r4, .L2, .L5
 
 .L5:
@@ -81,7 +82,8 @@ fwhile:
 	cbr         %r9, .L9, .L11
 
 .L9:
-	call.32     %r11 <- p, %r8(i)
+	push.32     %r8(i)
+	call.32     %r11 <- p
 	cbr         %r11, .L14, .L13
 
 .L13:
@@ -110,7 +112,8 @@ fdo:
 
 .L17:
 	phi.32      %r15(i) <- %phi16(i), %phi17(i)
-	call.32     %r16 <- p, %r15(i)
+	push.32     %r15(i)
+	call.32     %r16 <- p
 	cbr         %r16, .L18, .L20
 
 .L20:
-- 
2.12.0

