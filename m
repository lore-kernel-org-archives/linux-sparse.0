From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] avoid some crashes in add_dominators()
Date: Thu,  6 Jul 2017 21:19:49 +0200
Message-ID: <20170706191950.81268-5-luc.vanoostenryck@gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34021 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdGFTUC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Jul 2017 15:20:02 -0400
Received: by mail-wr0-f193.google.com with SMTP id k67so2596126wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 12:20:02 -0700 (PDT)
In-Reply-To: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 memops.c                    |  2 ++
 validation/crash-add-doms.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/crash-add-doms.c

diff --git a/memops.c b/memops.c
index 5efdd6f2d..aeacdf566 100644
--- a/memops.c
+++ b/memops.c
@@ -29,6 +29,8 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
 			int dominance;
+			if (!one->bb)
+				continue;
 			if (one == insn)
 				goto no_dominance;
 			dominance = dominates(pseudo, insn, one, local);
diff --git a/validation/crash-add-doms.c b/validation/crash-add-doms.c
new file mode 100644
index 000000000..54ad93e84
--- /dev/null
+++ b/validation/crash-add-doms.c
@@ -0,0 +1,22 @@
+char a;
+int b;
+void c(void)
+{
+	if (0) {
+		char *d;
+		for (;;)
+			for (;;)
+e:
+				*d *= (a && 0) ^ b && *d;
+	}
+	goto e;
+}
+
+
+/*
+ * check-name: crash add-doms
+ * check-command: test-linearize $file
+ *
+ * check-error-ignore
+ * check-output-ignore
+ */
-- 
2.13.0

