From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add test case for bogus volatile simplification
Date: Sat, 11 Nov 2017 17:24:59 +0100
Message-ID: <20171111162500.69476-2-luc.vanoostenryck@gmail.com>
References: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34198 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdKKQ1L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 11:27:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id n74so9091491wmi.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 08:27:10 -0800 (PST)
In-Reply-To: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/memops-volatile.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/validation/memops-volatile.c b/validation/memops-volatile.c
index 0f3e12ad2..71299f49d 100644
--- a/validation/memops-volatile.c
+++ b/validation/memops-volatile.c
@@ -1,6 +1,7 @@
 static int foo(volatile int *a, int v)
 {
 	*a = v;
+	*a = 0;
 	return *a;
 }
 
@@ -8,14 +9,9 @@ static int foo(volatile int *a, int v)
  * check-name: memops-volatile
  * check-command: test-linearize $file
  *
- * check-output-start
-foo:
-.L0:
-	<entry-point>
-	store.32    %arg2 -> 0[%arg1]
-	load.32     %r5 <- 0[%arg1]
-	ret.32      %r5
-
