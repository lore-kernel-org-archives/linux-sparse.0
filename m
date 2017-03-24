From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 34/51] llvm: make value_to_ivalue() more flexible
Date: Sat, 25 Mar 2017 00:20:40 +0100
Message-ID: <20170324232057.15033-35-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35007 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936122AbdCXXYA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:24:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so809028wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:59 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                      | 15 ++++++++++-----
 validation/backend/shift-special.c | 13 +++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)
 create mode 100644 validation/backend/shift-special.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 58bddf216..8cf65c1d3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -413,13 +413,18 @@ static LLVMValueRef pseudo_to_rvalue(struct function *fn, struct instruction *in
 	return LLVMBuildBitCast(fn->builder, val, dtype, name);
 }
 
-static LLVMValueRef value_to_ivalue(struct function *fn, LLVMValueRef val)
+static LLVMValueRef value_to_ivalue(struct function *fn, struct symbol *ctype, LLVMValueRef val)
 {
+	const char *name = LLVMGetValueName(val);
+	LLVMTypeRef dtype = symbol_type(ctype);
+
 	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMPointerTypeKind) {
 		LLVMTypeRef dtype = LLVMIntType(bits_in_pointer);
-		const char *name = LLVMGetValueName(val);
 		val = LLVMBuildPtrToInt(fn->builder, val, dtype, name);
 	}
+	if (ctype && is_int_type(ctype)) {
+		val = LLVMBuildIntCast(fn->builder, val, dtype, name);
+	}
 	return val;
 }
 
@@ -445,7 +450,7 @@ static LLVMValueRef value_to_pvalue(struct function *fn, struct symbol *ctype, L
 static LLVMValueRef adjust_type(struct function *fn, struct symbol *ctype, LLVMValueRef val)
 {
 	if (is_int_type(ctype))
-		return value_to_ivalue(fn, val);
+		return value_to_ivalue(fn, ctype, val);
 	if (is_ptr_type(ctype))
 		return value_to_pvalue(fn, ctype, val);
 	return val;
@@ -511,10 +516,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	char target_name[64];
 
 	lhs = pseudo_to_value(fn, insn, insn->src1);
-	lhs = value_to_ivalue(fn, lhs);
+	lhs = value_to_ivalue(fn, insn->type, lhs);
 
 	rhs = pseudo_to_value(fn, insn, insn->src2);
-	rhs = value_to_ivalue(fn, rhs);
+	rhs = value_to_ivalue(fn, insn->type, rhs);
 
 	pseudo_name(insn->target, target_name);
 
diff --git a/validation/backend/shift-special.c b/validation/backend/shift-special.c
new file mode 100644
index 000000000..d5e4d3d32
--- /dev/null
+++ b/validation/backend/shift-special.c
@@ -0,0 +1,13 @@
+long shift(long a, short b);
+long shift(long a, short b)
+{
+	long r1 = a << b;
+	long r2 = b << a;
+
+	return r1 + r2;
+}
+
+/*
+ * check-name: shift-special
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.12.0

