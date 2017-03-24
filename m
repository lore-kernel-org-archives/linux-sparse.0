From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 20/51] llvm: add support for OP_SETVAL with floats
Date: Sat, 25 Mar 2017 00:20:26 +0100
Message-ID: <20170324232057.15033-21-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34265 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934542AbdCXXXr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id u132so809897wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:46 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c               | 19 ++++++++++++++++++-
 validation/backend/setval.c |  7 +++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 validation/backend/setval.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6cc01cdd9..29cb11ee3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -866,6 +866,23 @@ static void output_op_cast(struct function *fn, struct instruction *insn, LLVMOp
 	insn->target->priv = target;
 }
 
+static void output_op_setval(struct function *fn, struct instruction *insn)
+{
+	struct expression *val = insn->val;
+	LLVMTypeRef dtype = symbol_type(insn->type);
+	LLVMValueRef target;
+
+	switch (val->type) {
+	case EXPR_FVALUE:
+		target = LLVMConstReal(dtype, val->fvalue);
+		break;
+	default:
+		assert(0);
+	}
+
+	insn->target->priv = target;
+}
+
 static void output_insn(struct function *fn, struct instruction *insn)
 {
 	switch (insn->opcode) {
@@ -882,7 +899,7 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		assert(0);
 		break;
 	case OP_SETVAL:
-		assert(0);
+		output_op_setval(fn, insn);
 		break;
 	case OP_SWITCH:
 		output_op_switch(fn, insn);
diff --git a/validation/backend/setval.c b/validation/backend/setval.c
new file mode 100644
index 000000000..e3557571d
--- /dev/null
+++ b/validation/backend/setval.c
@@ -0,0 +1,7 @@
+double setfval64(void) { return 1.23; }
+float  setfval32(void) { return 1.23F; }
+
+/*
+ * check-name: setval-float
+ * check-command: ./sparsec -Wno-decl -c $file -o tmp.o
+ */
-- 
2.12.0

