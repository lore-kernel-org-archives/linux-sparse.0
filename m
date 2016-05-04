From: Emily Maier <emily@emilymaier.net>
Subject: [PATCH 2/2] validation: Check C99 for loop variables
Date: Wed,  4 May 2016 08:39:44 -0400
Message-ID: <1462365584-20536-2-git-send-email-emily@emilymaier.net>
References: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from emilymaier.net ([104.131.113.117]:54834 "EHLO
	mail.emilymaier.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbcEDMpv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 May 2016 08:45:51 -0400
In-Reply-To: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Emily Maier <emily@emilymaier.net>

Previously, sparse would generate incorrect code in the presence of a
C99 variable declaration inside the for statement, completely dropping
the code after the end of the for loop. Check that it's now behaving
correctly by entering a context and not leaving it at the end of the
loop.

Signed-off-by: Emily Maier <emily@emilymaier.net>
---
 validation/c99-for-loop.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 validation/c99-for-loop.c

diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
new file mode 100644
index 0000000..42246c5
--- /dev/null
+++ b/validation/c99-for-loop.c
@@ -0,0 +1,33 @@
+int op(int);
+
+static int good(void)
+{
+	__context__(1);
+	for (int i = 0; i < 10; i++) {
+		if (!op(i)) {
+			__context__(-1);
+			return 0;
+		}
+	}
+	__context__(-1);
+	return 1;
+}
+
+static int bad(void)
+{
+	__context__(1);
+	for (int i = 0; i < 10; i++) {
+		if (!op(i)) {
+			__context__(-1);
+			return 0;
+		}
+	}
+	return 1;
+}
+/*
+ * check-name: C99 for loop variable declaration
+ *
+ * check-error-start
+c99-for-loop.c:16:12: warning: context imbalance in 'bad' - different lock contexts for basic block
+ * check-error-end
+ */
-- 
2.5.5

