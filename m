From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/16] add killing of OP_PHISOURCEs
Date: Thu, 16 Feb 2017 05:56:54 +0100
Message-ID: <20170216045708.50661-3-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36582 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBPE5R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id k90so624616wrc.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:17 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c               |  3 +++
 validation/kill-phisrc.c | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/kill-phisrc.c

diff --git a/simplify.c b/simplify.c
index 90e45bf1a..ced63bfa3 100644
--- a/simplify.c
+++ b/simplify.c
@@ -210,6 +210,9 @@ void kill_instruction(struct instruction *insn)
 	case OP_PHI:
 		clear_phi(insn);
 		break;
+	case OP_PHISOURCE:
+		kill_use(&insn->phi_src);
+		break;
 
 	case OP_SYMADDR:
 		repeat_phase |= REPEAT_SYMBOL_CLEANUP;
diff --git a/validation/kill-phisrc.c b/validation/kill-phisrc.c
new file mode 100644
index 000000000..f00dbed24
--- /dev/null
+++ b/validation/kill-phisrc.c
@@ -0,0 +1,21 @@
+int foo(int a, int b)
+{
+	int r = a + b;
+
+	if (a && 0) {
+		int s = r;
+		if (b)
+			s = 0;
+		(void) s;
+	}
+
+	return 0;
+}
+
+/*
+ * check-name: kill-phisrc
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: add\\.
+ */
-- 
2.11.0

