From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 11/52] llvm: fix translation of PSEUDO_VALs into a ValueRefs
Date: Mon, 27 Mar 2017 23:23:35 +0200
Message-ID: <20170327212416.18536-12-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33300 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbdC0V0m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so17042098wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:41 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm there is the assumption that a PSEUDO_VAL is always
of integer type. But this is not always the case: constant pointers,
like NULL, are also of the PSEUDO_VAL kind.

Fix this by adding a helper 'val_to_value()' and using the
instruction's type where this pseudo is used as the type of the value.

Note: while this patch improve the situation, like for example for the
test cases added here, it's still not correct because now we're making
the assumption that 'insn->type' is the type we need for the pseudo.
This is often true, but certainly not always.
For example this is not true for:
- OP_STORE/OP_LOAD's insn->src
- OP_SET{EQ,...}'s   insn->src[12]
- probably some  others ones
- in general, obviously, for any instructions where the target has
  a different type than the operands.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                         | 31 ++++++++++++++++++++++++++++++-
 validation/backend/constant-pointer.c | 24 ++++++++++++++++++++++++
 validation/backend/type-constant.c    | 23 +++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/constant-pointer.c
 create mode 100644 validation/backend/type-constant.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 1b19721c8..d0ae829f2 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -348,6 +348,35 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 	return result;
 }
 
+static LLVMValueRef constant_value(unsigned long long val, LLVMTypeRef dtype)
+{
+	LLVMTypeRef itype;
+	LLVMValueRef result;
+
+	switch (LLVMGetTypeKind(dtype)) {
+	case LLVMPointerTypeKind:
+		itype = LLVMIntType(bits_in_pointer);
+		result = LLVMConstInt(itype, val, 1);
+		result = LLVMConstIntToPtr(result, dtype);
+		break;
+	case LLVMIntegerTypeKind:
+		result = LLVMConstInt(dtype, val, 1);
+		break;
+	default:
+		assert(0);
+	}
+	return result;
+}
+
+static LLVMValueRef val_to_value(unsigned long long val, struct symbol *ctype)
+{
+	LLVMTypeRef dtype;
+
+	assert(ctype);
+	dtype = symbol_type(ctype);
+	return constant_value(val, dtype);
+}
+
 static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
 	LLVMValueRef result = NULL;
@@ -360,7 +389,7 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 		result = get_sym_value(fn, pseudo->sym);
 		break;
 	case PSEUDO_VAL:
-		result = LLVMConstInt(insn_symbol_type(insn), pseudo->value, 1);
+		result = val_to_value(pseudo->value, insn->type);
 		break;
 	case PSEUDO_ARG: {
 		result = LLVMGetParam(fn->fn, pseudo->nr - 1);
diff --git a/validation/backend/constant-pointer.c b/validation/backend/constant-pointer.c
new file mode 100644
index 000000000..9012c7843
--- /dev/null
+++ b/validation/backend/constant-pointer.c
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
+ * check-name: constant pointers
+ * check-command: sparse-llvm $file
+ * check-output-ignore
+ */
diff --git a/validation/backend/type-constant.c b/validation/backend/type-constant.c
new file mode 100644
index 000000000..cded7f2ea
--- /dev/null
+++ b/validation/backend/type-constant.c
@@ -0,0 +1,23 @@
+char creti(void) { return 3; }
+int  ireti(void) { return 3; }
+long lreti(void) { return 3; }
+
+char cinii(void) { char r = 3; return r; }
+int  iinii(void) { int  r = 3; return r; }
+long linii(void) { long r = 3; return r; }
+
+
+void *vretn(void) { return (void*)0; }
+char *cretn(void) { return (void*)0; }
+int  *iretn(void) { return (void*)0; }
+long *lretn(void) { return (void*)0; }
+
+void *vinin(void) { void *r = (void*)0; return r; }
+char *cinin(void) { char *r = (void*)0; return r; }
+int  *iinin(void) { int  *r = (void*)0; return r; }
+long *linin(void) { long *r = (void*)0; return r; }
+
+/*
+ * check-name: type-constant
+ * check-command: ./sparsec -Wno-decl -c $file -o r.o
+ */
-- 
2.12.0

