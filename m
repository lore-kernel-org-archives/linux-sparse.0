From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 33/63] llvm: add support for OP_SETVAL with labels
Date: Tue, 21 Mar 2017 01:15:37 +0100
Message-ID: <20170321001607.75169-34-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36071 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755706AbdCUAQ4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so253897wmf.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:55 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                       |  3 +++
 validation/backend/label-as-value.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 validation/backend/label-as-value.c

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 29cb11ee3..87850d2be 100644
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

