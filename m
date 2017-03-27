From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 49/52] llvm: add support for OP_FPCAST
Date: Mon, 27 Mar 2017 23:24:13 +0200
Message-ID: <20170327212416.18536-50-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33733 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdC0V1T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so17045348wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:18 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c             | 22 +++++++++++++++++++++-
 validation/backend/cast.c |  5 +++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 840e8c6ba..604b96842 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -934,6 +934,26 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 	insn->target->priv = target;
 }
 
+static void output_op_fpcast(struct function *fn, struct instruction *insn)
+{
+	LLVMTypeRef dtype = symbol_type(insn->type);
+	LLVMValueRef src, target;
+	struct symbol *otype = insn->orig_type;
+	char name[64];
+
+	assert(is_float_type(insn->type));
+
+	pseudo_name(insn->target, name);
+	src = get_operand(fn, otype, insn->src);
+	if (is_float_type(otype))
+		target = LLVMBuildFPCast(fn->builder, src, dtype, name);
+	else if (is_signed_type(otype))
+		target = LLVMBuildSIToFP(fn->builder, src, dtype, name);
+	else
+		target = LLVMBuildUIToFP(fn->builder, src, dtype, name);
+	insn->target->priv = target;
+}
+
 static void output_op_setval(struct function *fn, struct instruction *insn)
 {
 	struct expression *val = insn->val;
@@ -1008,7 +1028,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		output_op_cast(fn, insn, LLVMSExt);
 		break;
 	case OP_FPCAST:
-		assert(0);
+		output_op_fpcast(fn, insn);
 		break;
 	case OP_PTRCAST:
 		output_op_ptrcast(fn, insn);
diff --git a/validation/backend/cast.c b/validation/backend/cast.c
index 598b16aab..4c308dfe8 100644
--- a/validation/backend/cast.c
+++ b/validation/backend/cast.c
@@ -1,4 +1,5 @@
 typedef _Bool bool;
+typedef   signed char schar;
 typedef unsigned char uchar;
 typedef unsigned short ushort;
 typedef unsigned int uint;
@@ -14,6 +15,7 @@ typedef unsigned long long ulonglong;
 #define DEFINE_CASTS(from)			\
 	DEFINE_CAST(from, bool)			\
 	DEFINE_CAST(from, char)			\
+	DEFINE_CAST(from, schar)		\
 	DEFINE_CAST(from, uchar)		\
 	DEFINE_CAST(from, short)		\
 	DEFINE_CAST(from, ushort)		\
@@ -23,13 +25,12 @@ typedef unsigned long long ulonglong;
 	DEFINE_CAST(from, ulong)		\
 	DEFINE_CAST(from, longlong)		\
 	DEFINE_CAST(from, ulonglong)		\
-/*
 	DEFINE_CAST(from, float)		\
 	DEFINE_CAST(from, double)
-*/
 
 DEFINE_CASTS(bool)
 DEFINE_CASTS(char)
+DEFINE_CASTS(schar)
 DEFINE_CASTS(uchar)
 DEFINE_CASTS(short)
 DEFINE_CASTS(ushort)
-- 
2.12.0

