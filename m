From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 06/14] cast: specialize floats to integer conversion
Date: Thu, 17 Aug 2017 06:05:21 +0200
Message-ID: <20170817040529.7289-7-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34606 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id x43so6181447wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:51 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, casts from floats to integers are processed like
integers (or any other type) to integers. This is simple but
rather uncovenient as it correspond to different operations
tat may obey to different rules and which later need extra checks.

Change this by directly using specific instructions:
- FCVTU for floats to unsigned integer
- FCVTS for floats to signed integer

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md           |  6 ++++++
 example.c                     |  3 +++
 linearize.c                   |  5 +++++
 linearize.h                   |  1 +
 liveness.c                    |  1 +
 simplify.c                    |  3 +++
 sparse-llvm.c                 |  1 +
 validation/cast-kinds-check.c |  2 --
 validation/cast-kinds.c       | 20 ++++++++++++--------
 9 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 2d23e65d3..0bfd9765c 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -166,6 +166,12 @@ Cast to signed integer.
 ### OP_PTRCAST
 Cast to pointer.
 
+### OP_FCVTU
+Conversion from float type to unsigned integer.
+
+### OP_FCVTS
+Conversion from float type to signed integer.
+
 ### OP_UCVTF
 Conversion from unsigned integer to a float type.
 
diff --git a/example.c b/example.c
index 30e91bbf6..0349a7e20 100644
--- a/example.c
+++ b/example.c
@@ -83,6 +83,8 @@ static const char *opcodes[] = {
 	[OP_COPY] = "copy",
 	[OP_CAST] = "cast",
 	[OP_SCAST] = "scast",
+	[OP_FCVTU] = "fcvtu",
+	[OP_FCVTS] = "fcvts",
 	[OP_UCVTF] = "ucvtf",
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
@@ -1423,6 +1425,7 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		break;
 
 	case OP_CAST: case OP_SCAST: case OP_PTRCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 		generate_cast(state, insn);
diff --git a/linearize.c b/linearize.c
index 3f8d955c5..75b200c4b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -230,6 +230,8 @@ static const char *opcodes[] = {
 	[OP_PHISOURCE] = "phisrc",
 	[OP_CAST] = "cast",
 	[OP_SCAST] = "scast",
+	[OP_FCVTU] = "fcvtu",
+	[OP_FCVTS] = "fcvts",
 	[OP_UCVTF] = "ucvtf",
 	[OP_SCVTF] = "scvtf",
 	[OP_FCVTF] = "fcvtf",
@@ -427,6 +429,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 	case OP_CAST:
 	case OP_SCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
@@ -1176,6 +1179,8 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 	case MTYPE_UINT:
 	case MTYPE_SINT:
 		switch (stype) {
+		case MTYPE_FLOAT:
+			return dtype == MTYPE_UINT ? OP_FCVTU : OP_FCVTS;
 		case MTYPE_SINT:
 			return OP_SCAST;
 		default:
diff --git a/linearize.h b/linearize.h
index 0ec42e588..600bae598 100644
--- a/linearize.h
+++ b/linearize.h
@@ -198,6 +198,7 @@ enum opcode {
 	OP_PHISOURCE,
 	OP_CAST,
 	OP_SCAST,
+	OP_FCVTU, OP_FCVTS,
 	OP_UCVTF, OP_SCVTF,
 	OP_FCVTF,
 	OP_PTRCAST,
diff --git a/liveness.c b/liveness.c
index b3e0a8326..3bd95fe5b 100644
--- a/liveness.c
+++ b/liveness.c
@@ -113,6 +113,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 
 	case OP_CAST:
 	case OP_SCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
diff --git a/simplify.c b/simplify.c
index e0f31ad45..365811b96 100644
--- a/simplify.c
+++ b/simplify.c
@@ -238,6 +238,7 @@ void kill_insn(struct instruction *insn, int force)
 
 	case OP_CAST:
 	case OP_SCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
@@ -341,6 +342,7 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	case OP_SYMADDR:
 	case OP_CAST:
 	case OP_SCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
@@ -1203,6 +1205,7 @@ int simplify_instruction(struct instruction *insn)
 		return replace_with_pseudo(insn, insn->symbol);
 	case OP_CAST:
 	case OP_SCAST:
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index c45729ef4..04efc6637 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -855,6 +855,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_SCAST:
 		output_op_cast(fn, insn, LLVMSExt);
 		break;
+	case OP_FCVTU: case OP_FCVTS:
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 		assert(0);
diff --git a/validation/cast-kinds-check.c b/validation/cast-kinds-check.c
index f3ece313a..be6b684b4 100644
--- a/validation/cast-kinds-check.c
+++ b/validation/cast-kinds-check.c
@@ -9,12 +9,10 @@ cast-kinds.c:5:45: warning: cast drops bits
 cast-kinds.c:6:47: warning: cast drops bits
 cast-kinds.c:7:46: warning: cast drops bits
 cast-kinds.c:8:45: warning: cast drops bits
-cast-kinds.c:10:49: warning: cast drops bits
 cast-kinds.c:12:48: warning: cast drops bits
 cast-kinds.c:13:50: warning: cast drops bits
 cast-kinds.c:14:49: warning: cast drops bits
 cast-kinds.c:15:48: warning: cast drops bits
-cast-kinds.c:17:52: warning: cast drops bits
 cast-kinds.c:21:49: warning: cast wasn't removed
 cast-kinds.c:22:48: warning: cast wasn't removed
 cast-kinds.c:28:52: warning: cast wasn't removed
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 0312bc92b..d07a94190 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -95,13 +95,14 @@ iptr_2_int:
 float_2_int:
 .L10:
 	<entry-point>
-	ret.32      %arg1
+	fcvts.32    %r17 <- (32) %arg1
+	ret.32      %r17
 
 
 double_2_int:
 .L12:
 	<entry-point>
-	cast.32     %r20 <- (64) %arg1
+	fcvts.32    %r20 <- (64) %arg1
 	ret.32      %r20
 
 
@@ -142,13 +143,14 @@ iptr_2_uint:
 float_2_uint:
 .L24:
 	<entry-point>
-	ret.32      %arg1
+	fcvtu.32    %r38 <- (32) %arg1
+	ret.32      %r38
 
 
 double_2_uint:
 .L26:
 	<entry-point>
-	cast.32     %r41 <- (64) %arg1
+	fcvtu.32    %r41 <- (64) %arg1
 	ret.32      %r41
 
 
@@ -189,14 +191,15 @@ iptr_2_long:
 float_2_long:
 .L38:
 	<entry-point>
-	cast.64     %r59 <- (32) %arg1
+	fcvts.64    %r59 <- (32) %arg1
 	ret.64      %r59
 
 
 double_2_long:
 .L40:
 	<entry-point>
-	ret.64      %arg1
+	fcvts.64    %r62 <- (64) %arg1
+	ret.64      %r62
 
 
 int_2_ulong:
@@ -236,14 +239,15 @@ iptr_2_ulong:
 float_2_ulong:
 .L52:
 	<entry-point>
-	cast.64     %r80 <- (32) %arg1
+	fcvtu.64    %r80 <- (32) %arg1
 	ret.64      %r80
 
 
 double_2_ulong:
 .L54:
 	<entry-point>
-	ret.64      %arg1
+	fcvtu.64    %r83 <- (64) %arg1
+	ret.64      %r83
 
 
 int_2_vptr:
-- 
2.14.0

