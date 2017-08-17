From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 11/14] cast: specialize cast from pointers
Date: Thu, 17 Aug 2017 06:05:26 +0200
Message-ID: <20170817040529.7289-12-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33076 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdHQEGD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:06:03 -0400
Received: by mail-wr0-f194.google.com with SMTP id n88so6177295wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:06:02 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently all casts to pointers are processed alike. This is
simple creating the cast but rather uncovenient in later phases
as this correspond to different operations that may obey to
different rules and which later need extra checks.

Change this by using a specific instructions (OP_UTPTR) for
[unsigned] integer to pointers.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md     | 10 ++++++++--
 cse.c                   |  4 ++--
 example.c               |  2 ++
 linearize.c             |  7 +++++++
 linearize.h             |  1 +
 liveness.c              |  1 +
 simplify.c              |  3 +++
 sparse-llvm.c           |  1 +
 sparse.c                |  1 +
 validation/cast-kinds.c |  8 ++++----
 10 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index a1a32c562..8f7083ea4 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -157,8 +157,11 @@ They all have the following signature:
 - `.target`: result value
 - `.type`: type of `.target`
 
+Currently, a cast to a void pointer is treated like a
+cast to an unsigned integer of the same size.
+
 ### OP_CAST
-Cast to unsigned integer (and to void pointer).
+Cast to unsigned integer.
 
 ### OP_SCAST
 Cast to signed integer.
@@ -166,8 +169,11 @@ Cast to signed integer.
 ### OP_UTPTR
 Cast from pointer-sized unsigned integer to pointer type.
 
+### OP_PTRTU
+Cast from pointer type to unsigned integer.
+
 ### OP_PTRCAST
-Cast to pointer.
+Cast between pointer.
 
 ### OP_FCVTU
 Conversion from float type to unsigned integer.
diff --git a/cse.c b/cse.c
index 3e5d493d1..166b7cda6 100644
--- a/cse.c
+++ b/cse.c
@@ -89,7 +89,7 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
-	case OP_UTPTR:
+	case OP_UTPTR: case OP_PTRTU:
 		/*
 		 * This is crap! Many "orig_types" are the
 		 * same as far as casts go, we should generate
@@ -234,7 +234,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_CAST:
 	case OP_SCAST:
 	case OP_PTRCAST:
-	case OP_UTPTR:
+	case OP_UTPTR: case OP_PTRTU:
 		/*
 		 * This is crap! See the comments on hashing.
 		 */
diff --git a/example.c b/example.c
index 18eef6627..3a0ec0747 100644
--- a/example.c
+++ b/example.c
@@ -89,6 +89,7 @@ static const char *opcodes[] = {
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
 	[OP_UTPTR] = "utptr",
+	[OP_PTRTU] = "utptr",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_CALL] = "call",
 	[OP_VANEXT] = "va_next",
@@ -1427,6 +1428,7 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 
 	case OP_CAST: case OP_SCAST: case OP_PTRCAST:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
diff --git a/linearize.c b/linearize.c
index 01e6abde8..a1b647864 100644
--- a/linearize.c
+++ b/linearize.c
@@ -236,6 +236,7 @@ static const char *opcodes[] = {
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
 	[OP_UTPTR] = "utptr",
+	[OP_PTRTU] = "ptrtu",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_INLINED_CALL] = "# call",
 	[OP_CALL] = "call",
@@ -434,6 +435,7 @@ const char *show_instruction(struct instruction *insn)
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 		buf += sprintf(buf, "%s <- (%d) %s",
 			show_pseudo(insn->target),
@@ -1204,6 +1206,11 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 		switch (stype) {
 		case MTYPE_FLOAT:
 			return dtype == MTYPE_UINT ? OP_FCVTU : OP_FCVTS;
+		case MTYPE_PTR:
+			return OP_PTRTU;
+		case MTYPE_VPTR:
+		case MTYPE_UINT:
+			return OP_CAST;
 		case MTYPE_SINT:
 			return OP_SCAST;
 		default:
diff --git a/linearize.h b/linearize.h
index 3570f1507..165d2b579 100644
--- a/linearize.h
+++ b/linearize.h
@@ -202,6 +202,7 @@ enum opcode {
 	OP_UCVTF, OP_SCVTF,
 	OP_FCVTF,
 	OP_UTPTR,
+	OP_PTRTU,
 	OP_PTRCAST,
 	OP_INLINED_CALL,
 	OP_CALL,
diff --git a/liveness.c b/liveness.c
index b9c6e4017..ef2030f3e 100644
--- a/liveness.c
+++ b/liveness.c
@@ -117,6 +117,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 		USES(src); DEFINES(target);
 		break;
diff --git a/simplify.c b/simplify.c
index f8222d31b..86512cc84 100644
--- a/simplify.c
+++ b/simplify.c
@@ -242,6 +242,7 @@ void kill_insn(struct instruction *insn, int force)
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
@@ -347,6 +348,7 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 		kill_use(&insn->src1);
 		break;
@@ -1211,6 +1213,7 @@ int simplify_instruction(struct instruction *insn)
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 		return simplify_cast(insn);
 	case OP_PHI:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index f4567a5f7..8dd6a5185 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -861,6 +861,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		assert(0);
 		break;
 	case OP_UTPTR:
+	case OP_PTRTU:
 	case OP_PTRCAST:
 		output_op_ptrcast(fn, insn);
 		break;
diff --git a/sparse.c b/sparse.c
index bceacd94e..9f9611e25 100644
--- a/sparse.c
+++ b/sparse.c
@@ -215,6 +215,7 @@ static void check_one_instruction(struct instruction *insn)
 {
 	switch (insn->opcode) {
 	case OP_CAST: case OP_SCAST:
+	case OP_PTRTU:
 		if (verbose)
 			check_cast_instruction(insn);
 		break;
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index aa9f9bb29..f60013e68 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -93,7 +93,7 @@ vptr_2_int:
 iptr_2_int:
 .L8:
 	<entry-point>
-	cast.32     %r14 <- (64) %arg1
+	ptrtu.32    %r14 <- (64) %arg1
 	ret.32      %r14
 
 
@@ -141,7 +141,7 @@ vptr_2_uint:
 iptr_2_uint:
 .L22:
 	<entry-point>
-	cast.32     %r35 <- (64) %arg1
+	ptrtu.32    %r35 <- (64) %arg1
 	ret.32      %r35
 
 
@@ -189,7 +189,7 @@ vptr_2_long:
 iptr_2_long:
 .L36:
 	<entry-point>
-	cast.64     %r56 <- (64) %arg1
+	ptrtu.64    %r56 <- (64) %arg1
 	ret.64      %r56
 
 
@@ -237,7 +237,7 @@ vptr_2_ulong:
 iptr_2_ulong:
 .L50:
 	<entry-point>
-	cast.64     %r77 <- (64) %arg1
+	ptrtu.64    %r77 <- (64) %arg1
 	ret.64      %r77
 
 
-- 
2.14.0

