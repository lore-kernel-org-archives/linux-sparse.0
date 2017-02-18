From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] replace test for c99 for-loop initializers
Date: Sat, 18 Feb 2017 21:30:44 +0100
Message-ID: <20170218203048.22276-2-luc.vanoostenryck@gmail.com>
References: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34423 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbdBRUa4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Feb 2017 15:30:56 -0500
Received: by mail-wr0-f194.google.com with SMTP id 89so1731421wrr.1
        for <linux-sparse@vger.kernel.org>; Sat, 18 Feb 2017 12:30:55 -0800 (PST)
In-Reply-To: <20170218203048.22276-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The existing test is an indirect test, using a warning
about context imbalance to show that some part of code
was discarded.

Now that we have the minimal tools to test the output of
test-linearize, use them to replace the test by a direct one.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/c99-for-loop.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/validation/c99-for-loop.c b/validation/c99-for-loop.c
index 42246c513..427fde268 100644
--- a/validation/c99-for-loop.c
+++ b/validation/c99-for-loop.c
@@ -1,33 +1,21 @@
-int op(int);
-
-static int good(void)
+int c99(void);
+int c99(void)
 {
-	__context__(1);
-	for (int i = 0; i < 10; i++) {
-		if (!op(i)) {
-			__context__(-1);
-			return 0;
-		}
-	}
-	__context__(-1);
-	return 1;
-}
+	int r = -1;
 
-static int bad(void)
-{
-	__context__(1);
 	for (int i = 0; i < 10; i++) {
-		if (!op(i)) {
-			__context__(-1);
-			return 0;
-		}
+		r = i;
 	}
-	return 1;
+
+	return r;
 }
+
 /*
  * check-name: C99 for loop variable declaration
+ * check-command: test-linearize $file
  *
- * check-error-start
-c99-for-loop.c:16:12: warning: context imbalance in 'bad' - different lock contexts for basic block
- * check-error-end
+ * check-output-ignore
+ * check-output-contains: phisrc\\.
+ * check-output-contains: phi\\.
+ * check-output-contains: add\\.
  */
-- 
2.11.0

