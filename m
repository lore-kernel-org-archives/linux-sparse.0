From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 4/7] fix crash when ep->active is NULL
Date: Mon, 31 Jul 2017 22:36:21 +0200
Message-ID: <20170731203624.58971-5-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38564 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdGaUgi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:38 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so15233090wrd.5
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:38 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                  |  9 +++++++--
 validation/crash-ep-active.c | 12 ++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 validation/crash-ep-active.c

diff --git a/linearize.c b/linearize.c
index a36720779..12209492b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -820,10 +820,15 @@ static pseudo_t argument_pseudo(struct entrypoint *ep, int nr)
 
 pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
 {
-	struct instruction *insn = alloc_instruction(OP_PHISOURCE, size);
-	pseudo_t phi = __alloc_pseudo(0);
+	struct instruction *insn;
+	pseudo_t phi;
 	static int nr = 0;
 
+	if (!source)
+		return VOID;
+
+	insn = alloc_instruction(OP_PHISOURCE, size);
+	phi = __alloc_pseudo(0);
 	phi->type = PSEUDO_PHI;
 	phi->nr = ++nr;
 	phi->def = insn;
diff --git a/validation/crash-ep-active.c b/validation/crash-ep-active.c
new file mode 100644
index 000000000..6945f320b
--- /dev/null
+++ b/validation/crash-ep-active.c
@@ -0,0 +1,12 @@
+int a(int b)
+{
+        return 0( && b;
+}
+
+/*
+ * check-name: crash ep->active
+ * check-command: test-linearize $file
+ *
+ * check-error-ignore
+ * check-output-ignore
+ */
-- 
2.13.2

