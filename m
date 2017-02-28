From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 1/7] replace test for c99 for-loop initializers
Date: Tue, 28 Feb 2017 11:03:57 +0100
Message-ID: <20170228100403.33184-2-luc.vanoostenryck@gmail.com>
References: <20170228094635.qbod5dwqwrw6etvt@macbook.local>
 <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33091 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751037AbdB1KGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 05:06:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so1504823wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 02:06:11 -0800 (PST)
In-Reply-To: <20170228100403.33184-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This test is to insure that a for-loop with C99-style initializer
linearize correctly: the same as a C89-style one (modulo any effect
on the scope of the variables). For example that code like:
	for (int = 0; i < 10; i++)
		do_stuff(i);
is linearized the same as  code like:
	int i;
	for (i = 0; i < 10; i++)
		do_stuff(i);

A test for this already exist in the testsuite:
	0e91f878 ("validation: Check C99 for loop variables")
which show the correctness of the fix::
	ed73fd32 ("linearize: Emit C99 declarations correctly")
But this test is an indirect one, using the presence or absence of
warning about context imbalance to show that some part of code is
present or not.

Now that we have the minimal tools to test the output of
test-linearize, use them to replace the test by a direct one.

Note: ideally we would like to show that the C89 & the C99 version
generate the same code but the testsuie deosn't allow this (yet).

Test-case-for: ed73fd32 ("linearize: Emit C99 declarations correctly")
Replaces:      0e91f878 ("validation: Check C99 for loop variables")
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
2.11.1

