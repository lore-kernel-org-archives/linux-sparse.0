From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 17/30] llvm: fix output_op_store() which modify its operand
Date: Sun, 19 Mar 2017 02:42:14 +0100
Message-ID: <20170319014227.8833-18-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35304 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751398AbdCSBm4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id u108so13841309wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:55 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm the field 'priv' of a pseudo is used to store
the corresponding LLVMValueRef. This field is normaly assigned
when processing the instruction that produces the speudo.

In output_op_store(), the field insn->target->priv is overwritten
by the LLVMValueRef returned by LLVMBuildStore().
It's unclear what this return value is:
- this corrupts the pseudo, making it unusable in subsequent
  instructions.
- there is no reason to change this field anyway.

Fix this by removing the assignment to insn->target->priv
in output_op_store().

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                 |  6 ++----
 validation/backend/store-x2.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 validation/backend/store-x2.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 94ebc9577..e01406281 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -651,16 +651,14 @@ static void output_op_load(struct function *fn, struct instruction *insn)
 
 static void output_op_store(struct function *fn, struct instruction *insn)
 {
-	LLVMValueRef addr, target, target_in;
+	LLVMValueRef addr, target_in;
 
 	addr = calc_memop_addr(fn, insn);
 
 	target_in = pseudo_to_value(fn, insn, insn->target);
 
 	/* perform store */
-	target = LLVMBuildStore(fn->builder, target_in, addr);
-
-	insn->target->priv = target;
+	LLVMBuildStore(fn->builder, target_in, addr);
 }
 
 static LLVMValueRef bool_value(struct function *fn, LLVMValueRef value)
diff --git a/validation/backend/store-x2.c b/validation/backend/store-x2.c
new file mode 100644
index 000000000..5ccc9b43a
--- /dev/null
+++ b/validation/backend/store-x2.c
@@ -0,0 +1,16 @@
+void foo(int *p, int a, int b);
+void foo(int *p, int a, int b)
+{
+	int c = a + b;
+
+	p[0] = c;
+	p[1] = c;
+}
+
+/*
+ * check-name: store-x2
+ * check-command: sparsec -c $file -o tmp.o
+ * check-description: Verify in output_op_store() that
+ *	the first store doesn't mess anymore with the
+ *	'target' and thus making the second store unusable.
+ */
-- 
2.12.0

