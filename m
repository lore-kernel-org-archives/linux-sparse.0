From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] avoid crash when ep->active is NULL
Date: Thu,  6 Jul 2017 21:19:47 +0200
Message-ID: <20170706191950.81268-3-luc.vanoostenryck@gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32971 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdGFTUF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:20:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id x23so2620534wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:20:05 -0700 (PDT)
In-Reply-To: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                  |  3 +++
 validation/crash-ep-active.c | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 validation/crash-ep-active.c

diff --git a/linearize.c b/linearize.c
index c1ad0c2a4..b76e980dc 100644
--- a/linearize.c
+++ b/linearize.c
@@ -827,6 +827,9 @@ pseudo_t alloc_phi(struct basic_block *source, pseudo_t pseudo, int size)
 	pseudo_t phi = __alloc_pseudo(0);
 	static int nr = 0;
 
+	if (!source)
+		return VOID;
+
 	phi->type = PSEUDO_PHI;
 	phi->nr = ++nr;
 	phi->def = insn;
diff --git a/validation/crash-ep-active.c b/validation/crash-ep-active.c
new file mode 100644
index 000000000..61e17a188
--- /dev/null
+++ b/validation/crash-ep-active.c
@@ -0,0 +1,17 @@
+void a(void)
+{
+	0 (0
+		&&
+			({
+				goto b;
+			});
+	);
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
2.13.0

