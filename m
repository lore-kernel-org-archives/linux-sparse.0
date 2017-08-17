From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 07/14] cast: specialize casts from unsigned to pointers
Date: Thu, 17 Aug 2017 06:05:22 +0200
Message-ID: <20170817040529.7289-8-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33034 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id n88so6176941wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:53 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently all casts to pointers are processed alike. This is
but rather uncovenient as it correspond to different operations
that may obey to different rules and which later need extra checks.

Change this by using a specific instructions (OP_UTPTR) for
unsigned integer to pointers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md           |  3 +++
 cse.c                         |  2 ++
 example.c                     |  2 ++
 lib.c                         |  2 ++
 lib.h                         |  1 +
 linearize.c                   | 20 +++++++++++++++++-
 linearize.h                   |  1 +
 liveness.c                    |  1 +
 simplify.c                    |  3 +++
 sparse-llvm.c                 |  1 +
 validation/cast-kinds-check.c |  2 ++
 validation/cast-kinds.c       | 13 ++++++++----
 validation/cast-weirds.c      | 49 +++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 95 insertions(+), 5 deletions(-)
 create mode 100644 validation/cast-weirds.c

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 0bfd9765c..039bdb097 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -163,6 +163,9 @@ Cast to unsigned integer (and to void pointer).
 ### OP_SCAST
 Cast to signed integer.
 
+### OP_UTPTR
+Cast from unsigned integer to pointer type.
+
 ### OP_PTRCAST
 Cast to pointer.
 
diff --git a/cse.c b/cse.c
index 17b3da01a..3e5d493d1 100644
--- a/cse.c
+++ b/cse.c
@@ -89,6 +89,7 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
+	case OP_UTPTR:
 		/*
 		 * This is crap! Many "orig_types" are the
 		 * same as far as casts go, we should generate
@@ -233,6 +234,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
+	case OP_UTPTR:
 		/*
 		 * This is crap! See the comments on hashing.
 		 */
diff --git a/example.c b/example.c
index 0349a7e20..18eef6627 100644
--- a/example.c
+++ b/example.c
@@ -88,6 +88,7 @@ static const char *opcodes[] = {
 	[OP_UCVTF] = "ucvtf",
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
+	[OP_UTPTR] = "utptr",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_CALL] = "call",
 	[OP_VANEXT] = "va_next",
@@ -1425,6 +1426,7 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		break;
 
 	case OP_CAST: case OP_SCAST: case OP_PTRCAST:
+	case OP_UTPTR:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
diff --git a/lib.c b/lib.c
index 73e9a2fe6..1c67e1912 100644
--- a/lib.c
+++ b/lib.c
@@ -230,6 +230,7 @@ int Wdefault_bitfield_sign = 0;
 int Wdesignated_init = 1;
 int Wdo_while = 0;
 int Winit_cstring = 0;
+int Wint_to_pointer_cast = 1;
 int Wenum_mismatch = 1;
 int Wsparse_error = 0;
 int Wmemcpy_max_count = 1;
@@ -523,6 +524,7 @@ static const struct warning {
 	{ "do-while", &Wdo_while },
 	{ "enum-mismatch", &Wenum_mismatch },
 	{ "init-cstring", &Winit_cstring },
+	{ "int-to-pointer-cast", &Wint_to_pointer_cast },
 	{ "memcpy-max-count", &Wmemcpy_max_count },
 	{ "non-pointer-null", &Wnon_pointer_null },
 	{ "old-initializer", &Wold_initializer },
diff --git a/lib.h b/lib.h
index 307ccaeb2..010317970 100644
--- a/lib.h
+++ b/lib.h
@@ -125,6 +125,7 @@ extern int Wdo_while;
 extern int Wenum_mismatch;
 extern int Wsparse_error;
 extern int Winit_cstring;
+extern int Wint_to_pointer_cast;
 extern int Wmemcpy_max_count;
 extern int Wnon_pointer_null;
 extern int Wold_initializer;
diff --git a/linearize.c b/linearize.c
index 75b200c4b..85d472ca6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -235,6 +235,7 @@ static const char *opcodes[] = {
 	[OP_UCVTF] = "ucvtf",
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
+	[OP_UTPTR] = "utptr",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_INLINED_CALL] = "# call",
 	[OP_CALL] = "call",
@@ -432,6 +433,7 @@ const char *show_instruction(struct instruction *insn)
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
+	case OP_UTPTR:
 	case OP_PTRCAST:
 		buf += sprintf(buf, "%s <- (%d) %s",
 			show_pseudo(insn->target),
@@ -1175,7 +1177,17 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 			return OP_BADOP;
 		}
 	case MTYPE_PTR:
-		return OP_PTRCAST;
+		switch (stype) {
+		case MTYPE_UINT:
+		case MTYPE_SINT:
+			if (is_ptr_type(src))	// must be a void pointer
+				return OP_PTRCAST;// FIXME: to be removed?
+			return OP_UTPTR;
+		case MTYPE_PTR:
+			return OP_PTRCAST;
+		default:
+			return OP_BADOP;
+		}
 	case MTYPE_UINT:
 	case MTYPE_SINT:
 		switch (stype) {
@@ -1208,6 +1220,12 @@ static pseudo_t cast_pseudo(struct entrypoint *ep, pseudo_t src, struct symbol *
 	switch (opcode) {
 	case OP_NOP:
 		return src;
+	case OP_UTPTR:
+		if (from->bit_size == to->bit_size)
+			break;
+		if (Wint_to_pointer_cast)
+			warning(to->pos, "non size-preserving integer to pointer cast");
+		break;
 	default:
 		break;
 	}
diff --git a/linearize.h b/linearize.h
index 600bae598..3570f1507 100644
--- a/linearize.h
+++ b/linearize.h
@@ -201,6 +201,7 @@ enum opcode {
 	OP_FCVTU, OP_FCVTS,
 	OP_UCVTF, OP_SCVTF,
 	OP_FCVTF,
+	OP_UTPTR,
 	OP_PTRCAST,
 	OP_INLINED_CALL,
 	OP_CALL,
diff --git a/liveness.c b/liveness.c
index 3bd95fe5b..b9c6e4017 100644
--- a/liveness.c
+++ b/liveness.c
@@ -116,6 +116,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
+	case OP_UTPTR:
 	case OP_PTRCAST:
 		USES(src); DEFINES(target);
 		break;
diff --git a/simplify.c b/simplify.c
index 365811b96..f8222d31b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -241,6 +241,7 @@ void kill_insn(struct instruction *insn, int force)
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
+	case OP_UTPTR:
 	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
@@ -345,6 +346,7 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
+	case OP_UTPTR:
 	case OP_PTRCAST:
 		kill_use(&insn->src1);
 		break;
@@ -1208,6 +1210,7 @@ int simplify_instruction(struct instruction *insn)
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
+	case OP_UTPTR:
 	case OP_PTRCAST:
 		return simplify_cast(insn);
 	case OP_PHI:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 04efc6637..f4567a5f7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -860,6 +860,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_FCVTF:
 		assert(0);
 		break;
+	case OP_UTPTR:
 	case OP_PTRCAST:
 		output_op_ptrcast(fn, insn);
 		break;
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index be6b684b4..365fe6e40 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -20,5 +20,7 @@ cast-kinds.c:29:51: warning: cast wasn't removed
 cast-kinds.c:34:52: warning: cast wasn't removed
 cast-kinds.c:35:54: warning: cast wasn't removed
 cast-kinds.c:36:52: warning: cast wasn't removed
+cast-kinds.c:37:42: warning: non size-preserving integer to pointer cast
+cast-kinds.c:38:44: warning: non size-preserving integer to pointer cast
  * check-error-end
  */
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index d07a94190..e5b64b768 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -57,6 +57,11 @@ static double double_2_double(double a) { return a; }
  * check-name: cast-kinds
  * check-command: test-linearize -m64 $file
  *
+ * check-error-start
+cast-kinds.c:37:42: warning: non size-preserving integer to pointer cast
+cast-kinds.c:38:44: warning: non size-preserving integer to pointer cast
+ * check-error-end
+ *
  * check-output-start
 uint_2_int:
 .L0:
@@ -288,28 +293,28 @@ iptr_2_vptr:
 int_2_iptr:
 .L66:
 	<entry-point>
-	ptrcast.64  %r101 <- (32) %arg1
+	utptr.64    %r101 <- (32) %arg1
 	ret.64      %r101
 
 
 uint_2_iptr:
 .L68:
 	<entry-point>
-	ptrcast.64  %r104 <- (32) %arg1
+	utptr.64    %r104 <- (32) %arg1
 	ret.64      %r104
 
 
 long_2_iptr:
 .L70:
 	<entry-point>
-	ptrcast.64  %r107 <- (64) %arg1
+	utptr.64    %r107 <- (64) %arg1
 	ret.64      %r107
 
 
 ulong_2_iptr:
 .L72:
 	<entry-point>
-	ptrcast.64  %r110 <- (64) %arg1
+	utptr.64    %r110 <- (64) %arg1
 	ret.64      %r110
 
 
diff --git a/validation/cast-weirds.c b/validation/cast-weirds.c
new file mode 100644
index 000000000..136137b4c
--- /dev/null
+++ b/validation/cast-weirds.c
@@ -0,0 +1,49 @@
+typedef unsigned int uint;
+typedef unsigned long ulong;
+
+static int * int_2_iptr(int a) { return (int *)a; }
+static int * uint_2_iptr(uint a) { return (int *)a; }
+
+static void * int_2_vptr(int a) { return (void *)a; }
+static void * uint_2_vptr(uint a) { return (void *)a; }
+
+/*
+ * check-name: cast-weirds
+ * check-command: test-linearize -m64 $file
+ *
+ * check-error-start
+cast-weirds.c:4:42: warning: non size-preserving integer to pointer cast
+cast-weirds.c:5:44: warning: non size-preserving integer to pointer cast
+ * check-error-end
+ *
+ * check-output-start
+int_2_iptr:
+.L0:
+	<entry-point>
+	utptr.64    %r2 <- (32) %arg1
+	ret.64      %r2
+
+
+uint_2_iptr:
+.L2:
+	<entry-point>
+	utptr.64    %r5 <- (32) %arg1
+	ret.64      %r5
+
+
+int_2_vptr:
+.L4:
+	<entry-point>
+	scast.64    %r8 <- (32) %arg1
+	ret.64      %r8
+
+
+uint_2_vptr:
+.L6:
+	<entry-point>
+	cast.64     %r11 <- (32) %arg1
+	ret.64      %r11
+
+
+ * check-output-end
+ */
-- 
2.14.0

