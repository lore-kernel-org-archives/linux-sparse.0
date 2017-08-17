From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 04/14] cast: specialize FPCAST into [USF]CVTF
Date: Thu, 17 Aug 2017 06:05:19 +0200
Message-ID: <20170817040529.7289-5-luc.vanoostenryck@gmail.com>
References: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37322 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdHQEFr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 00:05:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id z91so3126737wrc.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 21:05:47 -0700 (PDT)
In-Reply-To: <20170817040529.7289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, all cast to a floating point type use OP_FPCAST.
This is aybe simple but rather uncovenient as it correspond
to several quite different operation that later need extra
checks.

Change this by directly using different instructions for the
different case:
- FCVTF for float-float conversions
- UCVTF for unsigned integer to floats
- SCVTF for signed integer to floats
and reject attempts to cast a pointer to a float.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md     | 12 +++++++++---
 example.c               |  8 ++++++--
 linearize.c             | 18 +++++++++++++++---
 linearize.h             |  3 ++-
 liveness.c              |  3 ++-
 simplify.c              | 11 +++++++----
 sparse-llvm.c           |  3 ++-
 validation/cast-kinds.c | 20 ++++++++++----------
 8 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 7e13e740d..2d23e65d3 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -163,12 +163,18 @@ Cast to unsigned integer (and to void pointer).
 ### OP_SCAST
 Cast to signed integer.
 
-### OP_FPCAST
-Cast to floating-point.
-
 ### OP_PTRCAST
 Cast to pointer.
 
+### OP_UCVTF
+Conversion from unsigned integer to a float type.
+
+### OP_SCVTF
+Conversion from signed integer to a float type.
+
+### OP_FCVTF
+Conversion between float types.
+
 ## Ternary ops
 ### OP_SEL
 - `.src1`: condition, must be of integral type
diff --git a/example.c b/example.c
index 691e0f97c..30e91bbf6 100644
--- a/example.c
+++ b/example.c
@@ -83,7 +83,9 @@ static const char *opcodes[] = {
 	[OP_COPY] = "copy",
 	[OP_CAST] = "cast",
 	[OP_SCAST] = "scast",
-	[OP_FPCAST] = "fpcast",
+	[OP_UCVTF] = "ucvtf",
+	[OP_SCVTF] = "scvtf",
+	[OP_FCVTF] = "fcvtf",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_CALL] = "call",
 	[OP_VANEXT] = "va_next",
@@ -1420,7 +1422,9 @@ static void generate_one_insn(struct instruction *insn, struct bb_state *state)
 		generate_compare(state, insn);
 		break;
 
-	case OP_CAST: case OP_SCAST: case OP_FPCAST: case OP_PTRCAST:
+	case OP_CAST: case OP_SCAST: case OP_PTRCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 		generate_cast(state, insn);
 		break;
 
diff --git a/linearize.c b/linearize.c
index c77a3c2df..7f8dbc64a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -230,7 +230,9 @@ static const char *opcodes[] = {
 	[OP_PHISOURCE] = "phisrc",
 	[OP_CAST] = "cast",
 	[OP_SCAST] = "scast",
-	[OP_FPCAST] = "fpcast",
+	[OP_UCVTF] = "ucvtf",
+	[OP_SCVTF] = "scvtf",
+	[OP_FCVTF] = "fcvtf",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_INLINED_CALL] = "# call",
 	[OP_CALL] = "call",
@@ -425,7 +427,8 @@ const char *show_instruction(struct instruction *insn)
 	}
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 	case OP_PTRCAST:
 		buf += sprintf(buf, "%s <- (%d) %s",
 			show_pseudo(insn->target),
@@ -1156,7 +1159,16 @@ static int get_cast_opcode(struct symbol *dst, struct symbol *src)
 
 	switch (dtype) {
 	case MTYPE_FLOAT:
-		return  OP_FPCAST;
+		switch (stype) {
+		case MTYPE_FLOAT:
+			return OP_FCVTF;
+		case MTYPE_UINT:
+			return OP_UCVTF;
+		case MTYPE_SINT:
+			return OP_SCVTF;
+		default:
+			return OP_BADOP;
+		}
 	case MTYPE_PTR:
 		return OP_PTRCAST;
 	case MTYPE_UINT:
diff --git a/linearize.h b/linearize.h
index bac82d7ff..0ec42e588 100644
--- a/linearize.h
+++ b/linearize.h
@@ -198,7 +198,8 @@ enum opcode {
 	OP_PHISOURCE,
 	OP_CAST,
 	OP_SCAST,
-	OP_FPCAST,
+	OP_UCVTF, OP_SCVTF,
+	OP_FCVTF,
 	OP_PTRCAST,
 	OP_INLINED_CALL,
 	OP_CALL,
diff --git a/liveness.c b/liveness.c
index 7461738b4..b3e0a8326 100644
--- a/liveness.c
+++ b/liveness.c
@@ -113,7 +113,8 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 	case OP_PTRCAST:
 		USES(src); DEFINES(target);
 		break;
diff --git a/simplify.c b/simplify.c
index 2bc86f53e..e0f31ad45 100644
--- a/simplify.c
+++ b/simplify.c
@@ -238,7 +238,8 @@ void kill_insn(struct instruction *insn, int force)
 
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
@@ -340,7 +341,8 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	case OP_SYMADDR:
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 	case OP_PTRCAST:
 		kill_use(&insn->src1);
 		break;
@@ -973,7 +975,7 @@ static int simplify_cast(struct instruction *insn)
 		int op = (orig_type->ctype.modifiers & MOD_SIGNED) ? OP_SCAST : OP_CAST;
 		if (insn->opcode == op)
 			goto simplify;
-		if (insn->opcode == OP_FPCAST && is_float_type(orig_type))
+		if (insn->opcode == OP_FCVTF)
 			goto simplify;
 	}
 
@@ -1201,7 +1203,8 @@ int simplify_instruction(struct instruction *insn)
 		return replace_with_pseudo(insn, insn->symbol);
 	case OP_CAST:
 	case OP_SCAST:
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 	case OP_PTRCAST:
 		return simplify_cast(insn);
 	case OP_PHI:
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 29fb65f15..c45729ef4 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -855,7 +855,8 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_SCAST:
 		output_op_cast(fn, insn, LLVMSExt);
 		break;
-	case OP_FPCAST:
+	case OP_UCVTF: case OP_SCVTF:
+	case OP_FCVTF:
 		assert(0);
 		break;
 	case OP_PTRCAST:
diff --git a/validation/cast-kinds.c b/validation/cast-kinds.c
index 697f9735e..34bf685d2 100644
--- a/validation/cast-kinds.c
+++ b/validation/cast-kinds.c
@@ -316,70 +316,70 @@ vptr_2_iptr:
 int_2_float:
 .L76:
 	<entry-point>
-	fpcast.32   %r116 <- (32) %arg1
+	scvtf.32    %r116 <- (32) %arg1
 	ret.32      %r116
 
 
 uint_2_float:
 .L78:
 	<entry-point>
-	fpcast.32   %r119 <- (32) %arg1
+	ucvtf.32    %r119 <- (32) %arg1
 	ret.32      %r119
 
 
 long_2_float:
 .L80:
 	<entry-point>
-	fpcast.32   %r122 <- (64) %arg1
+	scvtf.32    %r122 <- (64) %arg1
 	ret.32      %r122
 
 
 ulong_2_float:
 .L82:
 	<entry-point>
-	fpcast.32   %r125 <- (64) %arg1
+	ucvtf.32    %r125 <- (64) %arg1
 	ret.32      %r125
 
 
 double_2_float:
 .L84:
 	<entry-point>
-	fpcast.32   %r128 <- (64) %arg1
+	fcvtf.32    %r128 <- (64) %arg1
 	ret.32      %r128
 
 
 int_2_double:
 .L86:
 	<entry-point>
-	fpcast.64   %r131 <- (32) %arg1
+	scvtf.64    %r131 <- (32) %arg1
 	ret.64      %r131
 
 
 uint_2_double:
 .L88:
 	<entry-point>
-	fpcast.64   %r134 <- (32) %arg1
+	ucvtf.64    %r134 <- (32) %arg1
 	ret.64      %r134
 
 
 long_2_double:
 .L90:
 	<entry-point>
-	fpcast.64   %r137 <- (64) %arg1
+	scvtf.64    %r137 <- (64) %arg1
 	ret.64      %r137
 
 
 ulong_2_double:
 .L92:
 	<entry-point>
-	fpcast.64   %r140 <- (64) %arg1
+	ucvtf.64    %r140 <- (64) %arg1
 	ret.64      %r140
 
 
 float_2_double:
 .L94:
 	<entry-point>
-	fpcast.64   %r143 <- (32) %arg1
+	fcvtf.64    %r143 <- (32) %arg1
 	ret.64      %r143
 
 
-- 
2.14.0

