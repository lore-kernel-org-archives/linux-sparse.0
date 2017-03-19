From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 27/30] llvm: give correct type to binops
Date: Sun, 19 Mar 2017 02:42:24 +0100
Message-ID: <20170319014227.8833-28-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36188 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdCSBnH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so13792319wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:43:05 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Pointer arithmetic and/or simplification can mixup pointer
and integer types.

Fix this by adding casts before all non-floating point binops
and adjust the result type if needed to match the instructio.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    | 30 ++++++++++++++++++++++
 validation/backend/pointer-add.c | 54 ++++++++++++++++++++++++++++++++++++++++
 validation/backend/pointer-sub.c | 18 ++++++++++++++
 validation/backend/symaddr.c     |  8 ++++++
 4 files changed, 110 insertions(+)
 create mode 100644 validation/backend/pointer-add.c
 create mode 100644 validation/backend/pointer-sub.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index fda9484d7..332a5e2a1 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -416,6 +416,33 @@ static LLVMValueRef pseudo_to_rvalue(struct function *fn, struct instruction *in
 	return LLVMBuildBitCast(fn->builder, val, dtype, "");
 }
 
+static LLVMValueRef value_to_ivalue(struct function *fn, LLVMValueRef val)
+{
+	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMPointerTypeKind) {
+		LLVMTypeRef dtype = LLVMIntType(bits_in_pointer);
+		val = LLVMBuildPtrToInt(fn->builder, val, dtype, "");
+	}
+	return val;
+}
+
+static LLVMValueRef value_to_pvalue(struct function *fn, struct symbol *ctype, LLVMValueRef val)
+{
+	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMIntegerTypeKind) {
+		LLVMTypeRef dtype = symbol_type(ctype);
+		val = LLVMBuildIntToPtr(fn->builder, val, dtype, "");
+	}
+	return val;
+}
+
+static LLVMValueRef adjust_type(struct function *fn, struct symbol *ctype, LLVMValueRef val)
+{
+	if (is_int_type(ctype))
+		return value_to_ivalue(fn, val);
+	if (is_ptr_type(ctype))
+		return value_to_pvalue(fn, ctype, val);
+	return val;
+}
+
 static LLVMValueRef calc_gep(LLVMBuilderRef builder, LLVMValueRef base, LLVMValueRef off)
 {
 	LLVMTypeRef type = LLVMTypeOf(base);
@@ -475,8 +502,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	char target_name[64];
 
 	lhs = pseudo_to_value(fn, insn, insn->src1);
+	lhs = value_to_ivalue(fn, lhs);
 
 	rhs = pseudo_to_value(fn, insn, insn->src2);
+	rhs = value_to_ivalue(fn, rhs);
 
 	pseudo_name(insn->target, target_name);
 
@@ -577,6 +606,7 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		break;
 	}
 
+	target = adjust_type(fn, insn->type, target);
 	insn->target->priv = target;
 }
 
diff --git a/validation/backend/pointer-add.c b/validation/backend/pointer-add.c
new file mode 100644
index 000000000..f92c892b8
--- /dev/null
+++ b/validation/backend/pointer-add.c
@@ -0,0 +1,54 @@
+char *caddv(char *p, int o) { char *r = p; r = r + o; return r; }
+void *vaddv(void *p, int o) { void *r = p; r = r + o; return r; }
+int  *iaddv(int  *p, int o) { int  *r = p; r = r + o; return r; }
+
+char *caddc(char *p, int o) { char *r = p; r = r + 3; return r; }
+void *vaddc(void *p, int o) { void *r = p; r = r + 3; return r; }
+int  *iaddc(int  *p, int o) { int  *r = p; r = r + 3; return r; }
+
+char *cincv(char *p, int o) { char *r = p; r += o; return r; }
+void *vincv(void *p, int o) { void *r = p; r += o; return r; }
+int  *iincv(int  *p, int o) { int  *r = p; r += o; return r; }
+
+char *cincc(char *p, int o) { char *r = p; r += 3; return r; }
+void *vincc(void *p, int o) { void *r = p; r += 3; return r; }
+int  *iincc(int  *p, int o) { int  *r = p; r += 3; return r; }
+
+
+char *ciniaddv(char *p, int o) { char *r = p + o; return r; }
+void *viniaddv(void *p, int o) { void *r = p + o; return r; }
+int  *iiniaddv(int  *p, int o) { int  *r = p + o; return r; }
+
+char *ciniaddc(char *p, int o) { char *r = p + 3; return r; }
+void *viniaddc(void *p, int o) { void *r = p + 3; return r; }
+int  *iiniaddc(int  *p, int o) { int  *r = p + 3; return r; }
+
+char *ciniincv(char *p, int o) { char *r = p += o; return r; }
+void *viniincv(void *p, int o) { void *r = p += o; return r; }
+int  *iiniincv(int  *p, int o) { int  *r = p += o; return r; }
+
+char *ciniincc(char *p, int o) { char *r = p += 3; return r; }
+void *viniincc(void *p, int o) { void *r = p += 3; return r; }
+int  *iiniincc(int  *p, int o) { int  *r = p += 3; return r; }
+
+
+char *cretaddv(char *p, int o) { return p + o; }
+void *vretaddv(void *p, int o) { return p + o; }
+int  *iretaddv(int  *p, int o) { return p + o; }
+
+char *cretaddc(char *p, int o) { return p + 3; }
+void *vretaddc(void *p, int o) { return p + 3; }
+int  *iretaddc(int  *p, int o) { return p + 3; }
+
+char *cretincv(char *p, int o) { return p += o; }
+void *vretincv(void *p, int o) { return p += o; }
+int  *iretincv(int  *p, int o) { return p += o; }
+
+char *cretincc(char *p, int o) { return p += 3; }
+void *vretincc(void *p, int o) { return p += 3; }
+int  *iretincc(int  *p, int o) { return p += 3; }
+
+/*
+ * check-name: pointer-add
+ * check-command: ./sparsec -Wno-decl -c $file -o r.o
+ */
diff --git a/validation/backend/pointer-sub.c b/validation/backend/pointer-sub.c
new file mode 100644
index 000000000..4017faf69
--- /dev/null
+++ b/validation/backend/pointer-sub.c
@@ -0,0 +1,18 @@
+long subv0(void *p, int   a) { return p - ((void*)0); }
+long subvc(void *p, int   a) { return p - ((void*)8); }
+long subva(void *p, int   a) { return p - ((void*)a); }
+long subvq(void *p, void *q) { return p - q; }
+
+long subi0(int  *p, int   a) { return p - ((int *)0); }
+long subic(int  *p, int   a) { return p - ((int *)8); }
+long subia(int  *p, int   a) { return p - ((int *)a); }
+long subiq(int  *p, int  *q) { return p - q; }
+
+long subvm3(void *p, int   a) { return (p - ((void*)0)) * 3; }
+long subvx3(void *p, int   a) { return (p - ((void*)0)) ^ 3; }
+
+/*
+ * check-name: pointer-sub
+ * check-command: sparsec -Wno-decl -c $file -o tmp.o
+ * check-known-to-fail
+ */
diff --git a/validation/backend/symaddr.c b/validation/backend/symaddr.c
index 71bca2d76..71fb9deff 100644
--- a/validation/backend/symaddr.c
+++ b/validation/backend/symaddr.c
@@ -10,7 +10,9 @@ void lfoo(int *p, int a)
 	useip(p);
 	useip(larra);
 	useip(larrb + 1);
+	useip(larrc + a);
 	useip(&larrd[1]);
+	useip(&larre[a]);
 	useia(&larrf);
 }
 
@@ -22,7 +24,9 @@ void sfoo(int *p, int a)
 	useip(&s);
 	useip(sarra);
 	useip(sarrb + 1);
+	useip(sarrc + a);
 	useip(&sarrd[1]);
+	useip(&sarre[a]);
 	useia(&sarrf);
 	usevp(sfun);
 	usevp(&spun);
@@ -36,7 +40,9 @@ void xfoo(int *p, int a)
 	useip(&x);
 	useip(xarra);
 	useip(xarrb + 1);
+	useip(xarrc + a);
 	useip(&xarrd[1]);
+	useip(&xarre[a]);
 	useia(&xarrf);
 	usevp(xfun);
 	usevp(&xpun);
@@ -50,7 +56,9 @@ void gfoo(int *p, int a)
 	useip(&g);
 	useip(garra);
 	useip(garrb + 1);
+	useip(garrc + a);
 	useip(&garrd[1]);
+	useip(&garre[a]);
 	useia(&garrf);
 	usevp(gfun);
 	usevp(&gpun);
-- 
2.12.0

