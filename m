From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 12/27] llvm: fix output OP_ADD mixed with pointers
Date: Sat, 11 Mar 2017 10:06:51 +0100
Message-ID: <20170311090706.17171-13-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36021 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbdCKJHf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id v190so2299387wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:33 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse, pointer arithmetic and accessing the field
of a structure or an array is simply done via OP_ADD,
the offset being calculated at evaluation time.
On the other hand, LLVM allows addition only on two
integers and pointer arithmetic/member access must be
done either via 'getelementptr' or the pointer must be
casted to and for an integer.

sparse-llvm didn't took this in account which resulted
in type error in 'add' instructions.

Fix this by catching addition involving pointer and
the already existing helper calc_gep() for these.

Originally-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    |  4 +++
 validation/backend/pointer-add.c | 54 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 validation/backend/pointer-add.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 5ea0e5229..e3c8cafed 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -475,6 +475,10 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 	case OP_ADD:
 		if (symbol_is_fp_type(insn->type))
 			target = LLVMBuildFAdd(fn->builder, lhs, rhs, target_name);
+		else if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMPointerTypeKind)
+			target = calc_gep(fn->builder, lhs, rhs);
+		else if (LLVMGetTypeKind(LLVMTypeOf(rhs)) == LLVMPointerTypeKind)
+			target = calc_gep(fn->builder, rhs, lhs);
 		else
 			target = LLVMBuildAdd(fn->builder, lhs, rhs, target_name);
 		break;
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
-- 
2.11.1

