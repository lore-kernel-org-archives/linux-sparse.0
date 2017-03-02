From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] llvm: stores does not create or modify their target
Date: Thu,  2 Mar 2017 21:40:04 +0100
Message-ID: <20170302204004.1212-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33458 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdCBUsS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 15:48:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so219384wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 12:47:32 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In sparse-llvm the field 'struct pseudo:priv' is used to store
the LLVMValueRef corresponding to this pseudo. This field is
normaly assigned when processing the instruction that produce
the speudo.

In output_op_store(), the field insn->target->priv is overwritten
by the LLVMValueRef returned by LLVMBuildStore().
I have no idea to what this return value can be but:
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
index 9f362b3ed..edd0615ec 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -622,16 +622,14 @@ static void output_op_load(struct function *fn, struct instruction *insn)
 
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
2.11.1

