From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 20/52] llvm: add support for OP_SETVAL with floats
Date: Mon, 27 Mar 2017 23:23:44 +0200
Message-ID: <20170327212416.18536-21-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35037 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdC0V0q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so14120184wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:45 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
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
index a06ecdb82..abd1d04c2 100644
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

