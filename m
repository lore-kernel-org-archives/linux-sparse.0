From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 21/52] llvm: add support for OP_SETVAL with labels
Date: Mon, 27 Mar 2017 23:23:45 +0200
Message-ID: <20170327212416.18536-22-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34772 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdC0V0r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:47 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so14203810wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:45 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                       |  3 +++
 validation/backend/label-as-value.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 validation/backend/label-as-value.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index abd1d04c2..9633941e7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -876,6 +876,9 @@ static void output_op_setval(struct function *fn, struct instruction *insn)
 	case EXPR_FVALUE:
 		target = LLVMConstReal(dtype, val->fvalue);
 		break;
+	case EXPR_LABEL:
+		target = LLVMBlockAddress(fn->fn, val->symbol->bb_target->priv);
+		break;
 	default:
 		assert(0);
 	}
diff --git a/validation/backend/label-as-value.c b/validation/backend/label-as-value.c
new file mode 100644
index 000000000..6888c6613
--- /dev/null
+++ b/validation/backend/label-as-value.c
@@ -0,0 +1,13 @@
+void *foo(void *def);
+void *foo(void *def)
+{
+	if (!def)
+yes:		return &&yes;
+
+	return def;
+}
+
+/*
+ * check-name: label-as-value
+ * check-command: ./sparsec -c $file -o tmp.o
+ */
-- 
2.12.0

