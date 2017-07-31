From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 6/7] fix some crashes in add_dominators()
Date: Mon, 31 Jul 2017 22:36:23 +0200
Message-ID: <20170731203624.58971-7-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38577 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbdGaUgk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so15233219wrd.5
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:40 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
2.13.2

