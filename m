From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 01/28] misc: fix testcase typeof-safe
Date: Tue, 19 May 2020 02:57:01 +0200
Message-ID: <20200519005728.84594-2-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgESA5e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:34 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D32FC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:34 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k19so10173590edv.9
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:34 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This testcase was marked as known-to-fail but it was
simply the expected error messages that were missing.

So, slightly reorganize the test a little bit, add the
expected messages and remove the 'known-to-fail' tag.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/typeof-safe.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/validation/typeof-safe.c b/validation/typeof-safe.c
index 614863fba381..508bd39204c5 100644
--- a/validation/typeof-safe.c
+++ b/validation/typeof-safe.c
@@ -2,16 +2,24 @@
 
 static void test_safe(void)
 {
-	int __safe obj, *ptr;
-	typeof(obj) var = obj;
-	typeof(ptr) ptr2 = ptr;
+	int obj;
+	int __safe *ptr;
+
+	int __safe *ptr2 = ptr;
+	typeof(ptr) ptr3 = ptr;
 	typeof(*ptr) var2 = obj;
-	typeof(*ptr) *ptr3 = ptr;
-	typeof(obj) *ptr4 = ptr;
+	int __safe  var3 = obj;
+	int *ptr4 = &obj;
+	int *ptr4 = ptr;		// KO
+
+	typeof(*ptr) sobj;
+	typeof(&sobj) ptr5 = &obj;
+	typeof(&sobj) ptr6 = ptr;	// KO
+
 	obj = obj;
 	ptr = ptr;
-	ptr = &obj;
 	obj = *ptr;
+	ptr = (int __safe *) &obj;
 }
 
 /*
@@ -19,5 +27,11 @@ static void test_safe(void)
  * check-known-to-fail
  *
  * check-error-start
+typeof-safe.c:13:21: warning: incorrect type in initializer (different modifiers)
+typeof-safe.c:13:21:    expected int *ptr4
+typeof-safe.c:13:21:    got int [safe] *ptr
+typeof-safe.c:17:30: warning: incorrect type in initializer (different modifiers)
+typeof-safe.c:17:30:    expected int *ptr6
+typeof-safe.c:17:30:    got int [safe] *ptr
  * check-error-end
  */
-- 
2.26.2
