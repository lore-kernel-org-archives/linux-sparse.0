From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/16] fix killing of rewritten loads
Date: Thu, 16 Feb 2017 05:57:05 +0100
Message-ID: <20170216045708.50661-14-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbdBPE51 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so1298721wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:27 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_LOADs removed by rewrite_load_instruction() had their ->bb simply
set to NULL the usage of its operand was not adjusted.

Fix that by calling kill_instruction().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                           |  2 +-
 validation/kill-rewritten-load.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 validation/kill-rewritten-load.c

diff --git a/flow.c b/flow.c
index 8409fac60..fbac9336c 100644
--- a/flow.c
+++ b/flow.c
@@ -401,7 +401,7 @@ void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *domi
 	 * pseudo.
 	 */
 	FOR_EACH_PTR(dominators, phi) {
-		phi->def->bb = NULL;
+		kill_instruction(phi->def);
 	} END_FOR_EACH_PTR(phi);
 	convert_load_instruction(insn, new);
 	return;
diff --git a/validation/kill-rewritten-load.c b/validation/kill-rewritten-load.c
new file mode 100644
index 000000000..31b895e53
--- /dev/null
+++ b/validation/kill-rewritten-load.c
@@ -0,0 +1,16 @@
+int foo(int i)
+{
+	i++;
+	if (i && 0)
+		i;
+	return 0;
+}
+
+
+/*
+ * check-name: kill-rewritten-load
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: add\\.
+ */
-- 
2.11.0

