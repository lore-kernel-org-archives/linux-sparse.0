From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: fix getting type of values
Date: Thu,  2 Mar 2017 08:02:08 +0100
Message-ID: <20170302070208.13478-1-luc.vanoostenryck@gmail.com>
References: <CACXZuxdFQD+6yPcisZ=hJssO5fyxm9LYJbvVHsvnjRz87cCjrQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33252 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdCBHDT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 02:03:19 -0500
Received: by mail-wr0-f194.google.com with SMTP id g10so8201436wrg.0
        for <linux-sparse@vger.kernel.org>; Wed, 01 Mar 2017 23:02:18 -0800 (PST)
In-Reply-To: <CACXZuxdFQD+6yPcisZ=hJssO5fyxm9LYJbvVHsvnjRz87cCjrQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

In sparse-llvm: there was the assumption that the type
of a PSEUDO_VAL was always one of the integer type.
But this is not always the case: constant pointers,
like NULL, are also of the PSEUDO_VAL kind.

Fix this by using the type associated with the concerned
instruction to retrieve and use the correct type.

Note: while this patch improve the situation, like for example
the test cases added here, it's still not correct since now
we're make the assumption that insn->type is the type we need
for the pseudo. This is maybe often true, but certainly not
always. For example this is not true for:
- OP_STORE/OP_LOAD's insn->src
- OP_SET{EQ,...}'s   insn->src[12]
- in general for any instructions the target have a different type
  than the operands (when we're insterested in the operands).
- probably some  others ones

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Some-parts-also-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c             | 16 +++++++++++++++-
 validation/backend/null.c | 24 ++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/null.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f362b3ed..ff66a96a7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -305,6 +305,7 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 
 static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
+	LLVMTypeRef type, iptr_type;
 	LLVMValueRef result = NULL;
 
 	switch (pseudo->type) {
@@ -360,7 +361,20 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		break;
 	}
 	case PSEUDO_VAL:
-		result = LLVMConstInt(insn_symbol_type(fn->module, insn), pseudo->value, 1);
+		type = insn_symbol_type(fn->module, insn);
+		switch (LLVMGetTypeKind(type)) {
+		case LLVMPointerTypeKind:
+			iptr_type = LLVMIntType(bits_in_pointer);
+			result = LLVMConstInt(iptr_type, pseudo->value, 1);
+			result = LLVMConstIntToPtr(result, type);
+			break;
+		case LLVMIntegerTypeKind:
+			result = LLVMConstInt(type, pseudo->value, 1);
+			break;
+		default:
+			assert(0);
+		}
+
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
diff --git a/validation/backend/null.c b/validation/backend/null.c
new file mode 100644
index 000000000..5c595c70b
--- /dev/null
+++ b/validation/backend/null.c
@@ -0,0 +1,24 @@
+extern int *ip[];
+
+void foo(void);
+void foo(void)
+{
+	ip[0] = (void *)0L;
+	ip[1] = (int *)0L;
+	ip[2] = (void *)0;
+	ip[3] = (int *)0;
+	ip[4] = (void *)(long)0;
+	ip[5] = (int *)(long)0;
+	ip[6] = (void *)123;
+	ip[7] = (int *)123;
+	ip[8] = (void *)123L;
+	ip[9] = (int *)123L;
+	ip[10] = (void *)(long)123;
+	ip[11] = (int *)(long)123;
+}
+
+/*
+ * check-name: store constants to pointer
+ * check-command: sparse-llvm $file
+ * check-output-ignore
+ */
-- 
2.11.1

