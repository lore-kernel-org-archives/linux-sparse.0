From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] fix discarded label statement
Date: Thu, 10 Nov 2016 15:45:20 +0100
Message-ID: <20161110144520.24965-4-luc.vanoostenryck@gmail.com>
References: <20161110144520.24965-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36578 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933845AbcKJOpi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Nov 2016 09:45:38 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so1952217wma.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Nov 2016 06:45:38 -0800 (PST)
In-Reply-To: <20161110144520.24965-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

When code contains an unused label, it's not needed to create a new
basic block for the code that follow it but that doesn't mean that
the following code is unreachable.

There is currently a bug related to this when processing a label statement
for a label that is never used: not only the label is ignored (and this
no new basic block is created) but the whol statement is ignored.
In other words the statement directly following an unused label is
simply ignored.

The patch fix this by simply moving the code handling the statement out
of the conditional part processing used labels.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                            |  2 +-
 validation/discarded-label-statement.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 validation/discarded-label-statement.c

diff --git a/linearize.c b/linearize.c
index c6ada1e8..4dc3d04d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2026,8 +2026,8 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 
 		if (label->used) {
 			add_label(ep, label);
-			linearize_statement(ep, stmt->label_statement);
 		}
+		linearize_statement(ep, stmt->label_statement);
 		break;
 	}
 
diff --git a/validation/discarded-label-statement.c b/validation/discarded-label-statement.c
new file mode 100644
index 00000000..b4e58ac6
--- /dev/null
+++ b/validation/discarded-label-statement.c
@@ -0,0 +1,24 @@
+/*
+ * Verify that the statement following an unused label
+ * is not discarded with the label.
+ */
+
+static int bad(int a, int b)
+{
+	int r = 0;
+
+start:
+	r += a;
+	r += b;
+
+	return r;
+}
+
+/*
+ * check-name: discarded-label-statement
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-contains: add
+ * check-output-contains: %arg1
+ */
-- 
2.10.1

