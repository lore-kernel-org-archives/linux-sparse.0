From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] avoid crash in rewrite_branch()
Date: Thu,  6 Jul 2017 21:19:48 +0200
Message-ID: <20170706191950.81268-4-luc.vanoostenryck@gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32983 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbdGFTUB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:20:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id x23so2620638wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:20:01 -0700 (PDT)
In-Reply-To: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                            |  2 +-
 validation/crash-rewrite-branch.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 validation/crash-rewrite-branch.c

diff --git a/flow.c b/flow.c
index 3974984de..d8198ce8d 100644
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
2.13.0

