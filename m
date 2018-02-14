From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] IR: remove never-generated instructions
Date: Wed, 14 Feb 2018 02:08:41 +0100
Message-ID: <20180214010843.23651-4-luc.vanoostenryck@gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51347 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBK6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:10:58 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so19394587wmd.1
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:10:57 -0800 (PST)
In-Reply-To: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some of the IR instructions have been defined but are
never generated.

Remove them as they have no purposes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md | 10 ----------
 example.c           |  8 --------
 linearize.c         |  8 --------
 linearize.h         | 10 +---------
 liveness.c          |  8 --------
 5 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 1612f3390..27adc91a6 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -357,13 +357,3 @@ No-op (should never be generated).
 #### OP_DEATHNOTE
 Annotation telling the pseudo will be death after the next
 instruction (other than some other annotation, that is).
-
-### Unused ops
-#### OP_VANEXT
-#### OP_VAARG
-#### OP_MALLOC
-#### OP_FREE
-#### OP_ALLOCA
-#### OP_GET_ELEMENT_PTR
-#### OP_INVOKE
-#### OP_UNWIND
diff --git a/example.c b/example.c
index e3d2a6c26..7aa8f8c17 100644
--- a/example.c
+++ b/example.c
@@ -25,9 +25,7 @@ static const char *opcodes[] = {
 	[OP_BR] = "br",
 	[OP_CBR] = "cbr",
 	[OP_SWITCH] = "switch",
-	[OP_INVOKE] = "invoke",
 	[OP_COMPUTEDGOTO] = "jmp *",
-	[OP_UNWIND] = "unwind",
 	
 	/* Binary */
 	[OP_ADD] = "add",
@@ -69,13 +67,9 @@ static const char *opcodes[] = {
 	[OP_SEL] = "select",
 	
 	/* Memory */
-	[OP_MALLOC] = "malloc",
-	[OP_FREE] = "free",
-	[OP_ALLOCA] = "alloca",
 	[OP_LOAD] = "load",
 	[OP_STORE] = "store",
 	[OP_SETVAL] = "set",
-	[OP_GET_ELEMENT_PTR] = "getelem",
 
 	/* Other */
 	[OP_PHI] = "phi",
@@ -86,8 +80,6 @@ static const char *opcodes[] = {
 	[OP_FPCAST] = "fpcast",
 	[OP_PTRCAST] = "ptrcast",
 	[OP_CALL] = "call",
-	[OP_VANEXT] = "va_next",
-	[OP_VAARG] = "va_arg",
 	[OP_SLICE] = "slice",
 	[OP_NOP] = "nop",
 	[OP_DEATHNOTE] = "dead",
diff --git a/linearize.c b/linearize.c
index 7cc60c4f1..0fa12c36f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -172,9 +172,7 @@ static const char *opcodes[] = {
 	[OP_BR] = "br",
 	[OP_CBR] = "cbr",
 	[OP_SWITCH] = "switch",
-	[OP_INVOKE] = "invoke",
 	[OP_COMPUTEDGOTO] = "jmp *",
-	[OP_UNWIND] = "unwind",
 	
 	/* Binary */
 	[OP_ADD] = "add",
@@ -239,15 +237,11 @@ static const char *opcodes[] = {
 	[OP_SEL] = "select",
 	
 	/* Memory */
-	[OP_MALLOC] = "malloc",
-	[OP_FREE] = "free",
-	[OP_ALLOCA] = "alloca",
 	[OP_LOAD] = "load",
 	[OP_STORE] = "store",
 	[OP_SETVAL] = "set",
 	[OP_SETFVAL] = "setfval",
 	[OP_SYMADDR] = "symaddr",
-	[OP_GET_ELEMENT_PTR] = "getelem",
 
 	/* Other */
 	[OP_PHI] = "phi",
@@ -258,8 +252,6 @@ static const char *opcodes[] = {
 	[OP_PTRCAST] = "ptrcast",
 	[OP_INLINED_CALL] = "# call",
 	[OP_CALL] = "call",
-	[OP_VANEXT] = "va_next",
-	[OP_VAARG] = "va_arg",
 	[OP_SLICE] = "slice",
 	[OP_NOP] = "nop",
 	[OP_DEATHNOTE] = "dead",
diff --git a/linearize.h b/linearize.h
index 6640fcf2e..8ff40948c 100644
--- a/linearize.h
+++ b/linearize.h
@@ -143,10 +143,8 @@ enum opcode {
 	OP_BR,
 	OP_CBR,
 	OP_SWITCH,
-	OP_INVOKE,
 	OP_COMPUTEDGOTO,
-	OP_UNWIND,
-	OP_TERMINATOR_END = OP_UNWIND,
+	OP_TERMINATOR_END = OP_COMPUTEDGOTO,
 	
 	/* Binary */
 	OP_BINARY,
@@ -213,15 +211,11 @@ enum opcode {
 	OP_SEL,
 	
 	/* Memory */
-	OP_MALLOC,
-	OP_FREE,
-	OP_ALLOCA,
 	OP_LOAD,
 	OP_STORE,
 	OP_SETVAL,
 	OP_SETFVAL,
 	OP_SYMADDR,
-	OP_GET_ELEMENT_PTR,
 
 	/* Other */
 	OP_PHI,
@@ -232,8 +226,6 @@ enum opcode {
 	OP_PTRCAST,
 	OP_INLINED_CALL,
 	OP_CALL,
-	OP_VANEXT,
-	OP_VAARG,
 	OP_SLICE,
 	OP_NOP,
 	OP_DEATHNOTE,
diff --git a/liveness.c b/liveness.c
index 07a95d68b..0c525112b 100644
--- a/liveness.c
+++ b/liveness.c
@@ -142,14 +142,6 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		break;
 
 	case OP_BADOP:
-	case OP_INVOKE:
-	case OP_UNWIND:
-	case OP_MALLOC:
-	case OP_FREE:
-	case OP_ALLOCA:
-	case OP_GET_ELEMENT_PTR:
-	case OP_VANEXT:
-	case OP_VAARG:
 	case OP_NOP:
 	case OP_CONTEXT:
 		break;
-- 
2.16.0

