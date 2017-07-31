From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 5/7] fix crash in rewrite_branch()
Date: Mon, 31 Jul 2017 22:36:22 +0200
Message-ID: <20170731203624.58971-6-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33344 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaUgj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id q189so234881wmd.0
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:39 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                            |  2 +-
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 validation/crash-rewrite-branch.c

diff --git a/flow.c b/flow.c
index 23fa7c21b..6cac21b24 100644
--- a/flow.c
+++ b/flow.c
@@ -30,7 +30,7 @@ static int rewrite_branch(struct basic_block *bb,
 	struct basic_block *old,
 	struct basic_block *new)
 {
-	if (*ptr != old || new == old)
+	if (*ptr != old || new == old || !bb->ep)
 		return 0;
 
 	/* We might find new if-conversions or non-dominating CSEs */
diff --git a/validation/crash-rewrite-branch.c b/validation/crash-rewrite-branch.c
new file mode 100644
index 000000000..eb310df1c
--- /dev/null
+++ b/validation/crash-rewrite-branch.c
@@ -0,0 +1,24 @@
+void a(int c, int e)
+{
+	for(;                   b; c ;
+
+	if (()) {
+		unsigned short d = e;
+		if (())
+			while ()
+				;
+		&d;
+	}
+
+	if (()) {
+		int f = &f;
+	}
+}
+
+/*
+ * check-name: crash rewrite_branch
+ * check-command: test-linearize $file
+ *
+ * check-error-ignore
+ * check-output-ignore
+ */
-- 
2.13.2

