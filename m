From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] IR: remove now unused OP_LNOP & OP_SNOP
Date: Wed, 14 Feb 2018 02:08:40 +0100
Message-ID: <20180214010843.23651-3-luc.vanoostenryck@gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55338 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBK4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:10:56 -0500
Received: by mail-wm0-f65.google.com with SMTP id a84so8032613wmi.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:10:56 -0800 (PST)
In-Reply-To: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No instructions has an opcode set to OP_[LS]NOP anymore
so we can now remove all remaining traces of these opcode.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md | 6 ------
 example.c           | 2 --
 flow.c              | 4 +---
 linearize.c         | 6 ++----
 linearize.h         | 2 --
 liveness.c          | 2 --
 sparse-llvm.c       | 6 ------
 7 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index f212fe6c4..1612f3390 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -354,12 +354,6 @@ Invalid operation (should never be generated).
 #### OP_NOP
 No-op (should never be generated).
 
-#### OP_SNOP
-Store no-op (removed store operation).
-
-#### OP_LNOP
-Load no-op (removed load operation).
-
 #### OP_DEATHNOTE
 Annotation telling the pseudo will be death after the next
 instruction (other than some other annotation, that is).
diff --git a/example.c b/example.c
index 691e0f97c..e3d2a6c26 100644
--- a/example.c
+++ b/example.c
@@ -89,8 +89,6 @@ static const char *opcodes[] = {
 	[OP_VANEXT] = "va_next",
 	[OP_VAARG] = "va_arg",
 	[OP_SLICE] = "slice",
-	[OP_SNOP] = "snop",
-	[OP_LNOP] = "lnop",
 	[OP_NOP] = "nop",
 	[OP_DEATHNOTE] = "dead",
 	[OP_ASM] = "asm",
diff --git a/flow.c b/flow.c
index 495b118d2..aa3671af9 100644
--- a/flow.c
+++ b/flow.c
@@ -690,8 +690,6 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 			mod |= MOD_ADDRESSABLE;
 			goto external_visibility;
 		case OP_NOP:
-		case OP_SNOP:
-		case OP_LNOP:
 		case OP_PHI:
 			continue;
 		default:
@@ -964,7 +962,7 @@ void pack_basic_blocks(struct entrypoint *ep)
 			if (!first->bb)
 				continue;
 			switch (first->opcode) {
-			case OP_NOP: case OP_LNOP: case OP_SNOP:
+			case OP_NOP:
 			case OP_INLINED_CALL:
 				continue;
 			case OP_CBR:
diff --git a/linearize.c b/linearize.c
index 3b4b0d9b4..7cc60c4f1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -261,8 +261,6 @@ static const char *opcodes[] = {
 	[OP_VANEXT] = "va_next",
 	[OP_VAARG] = "va_arg",
 	[OP_SLICE] = "slice",
-	[OP_SNOP] = "snop",
-	[OP_LNOP] = "lnop",
 	[OP_NOP] = "nop",
 	[OP_DEATHNOTE] = "dead",
 	[OP_ASM] = "asm",
@@ -437,10 +435,10 @@ const char *show_instruction(struct instruction *insn)
 		} END_FOR_EACH_PTR(phi);
 		break;
 	}	
-	case OP_LOAD: case OP_LNOP:
+	case OP_LOAD:
 		buf += sprintf(buf, "%s <- %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
-	case OP_STORE: case OP_SNOP:
+	case OP_STORE:
 		buf += sprintf(buf, "%s -> %d[%s]", show_pseudo(insn->target), insn->offset, show_pseudo(insn->src));
 		break;
 	case OP_INLINED_CALL:
diff --git a/linearize.h b/linearize.h
index 15a6be9c9..6640fcf2e 100644
--- a/linearize.h
+++ b/linearize.h
@@ -235,8 +235,6 @@ enum opcode {
 	OP_VANEXT,
 	OP_VAARG,
 	OP_SLICE,
-	OP_SNOP,
-	OP_LNOP,
 	OP_NOP,
 	OP_DEATHNOTE,
 	OP_ASM,
diff --git a/liveness.c b/liveness.c
index 424979656..07a95d68b 100644
--- a/liveness.c
+++ b/liveness.c
@@ -150,8 +150,6 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 	case OP_GET_ELEMENT_PTR:
 	case OP_VANEXT:
 	case OP_VAARG:
-	case OP_SNOP:
-	case OP_LNOP:
 	case OP_NOP:
 	case OP_CONTEXT:
 		break;
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a1778083..beb3a5f24 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1029,15 +1029,9 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	case OP_LOAD:
 		output_op_load(fn, insn);
 		break;
-	case OP_LNOP:
-		assert(0);
-		break;
 	case OP_STORE:
 		output_op_store(fn, insn);
 		break;
-	case OP_SNOP:
-		assert(0);
-		break;
 	case OP_INLINED_CALL:
 		break;
 	case OP_CALL:
-- 
2.16.0

