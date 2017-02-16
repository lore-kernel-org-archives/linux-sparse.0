From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/16] add killing of OP_SLICEs
Date: Thu, 16 Feb 2017 05:56:53 +0100
Message-ID: <20170216045708.50661-2-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35763 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752760AbdBPE5Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:16 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so628417wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:16 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c              |  1 +
 validation/kill-slice.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 validation/kill-slice.c

diff --git a/simplify.c b/simplify.c
index 2a1f0b200..90e45bf1a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -203,6 +203,7 @@ void kill_instruction(struct instruction *insn)
 	case OP_PTRCAST:
 	case OP_SETVAL:
 	case OP_NOT: case OP_NEG:
+	case OP_SLICE:
 		kill_use(&insn->src1);
 		break;
 
diff --git a/validation/kill-slice.c b/validation/kill-slice.c
new file mode 100644
index 000000000..00db0e0f7
--- /dev/null
+++ b/validation/kill-slice.c
@@ -0,0 +1,19 @@
+struct bar {
+	int x;
+	int y[2];
+};
+struct bar bar(void);
+
+int foo(void)
+{
+	int x = bar().x;
+	return x & 0;
+}
+
+/*
+ * check-name: kill-slice
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: slice\\.
+ */
-- 
2.11.0

