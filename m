From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/28] testsuite: remove useless test-be.c
Date: Fri, 15 Sep 2017 09:13:46 +0200
Message-ID: <20170915071358.7312-17-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33808 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdIOHQX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so1974948wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:22 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-be.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)
 delete mode 100644 validation/test-be.c

diff --git a/validation/test-be.c b/validation/test-be.c
deleted file mode 100644
index deda3cc14..000000000
--- a/validation/test-be.c
+++ /dev/null
@@ -1,46 +0,0 @@
-int printf(char *c, ...);
-void exit(int c);
-
-#undef PRINT_OUTPUTS
-
-static void test_func_args(int x, int y)
-{
-	if (x == y)
-		exit(1);
-}
-
-static int binop_s32(int x, int y)
-{
-	int a;
-
-	a = a + x;
-	a = a / y;
-	a = a * x;
-	a = a - y;
-
-	return a;
-}
-
-static void test_binops(void)
-{
-	int tmp_s32 = binop_s32(987123, 234);
-
-#ifdef PRINT_OUTPUTS
-	printf("binop_s32(987123, 234) == %d\n", tmp_s32);
-#else
-	if (tmp_s32 != -1470599007)
-		exit(2);
-#endif
-}
-
-int main (int argc, char *argv[])
-{
-	test_func_args(1, 2);
-	test_binops();
-
-	return 0;
-}
