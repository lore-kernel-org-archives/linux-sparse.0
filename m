From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 7/9] test conditional result locking
Date: Thu, 29 May 2008 10:54:09 +0200
Message-ID: <20080529085517.605471000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45710 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756299AbYE2I7R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 04:59:17 -0400
Content-Disposition: inline; filename=008-test-condititional-lock-result.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

To test a function that can return a locked struct or NULL,
a macro has to be invented. Add a test case for that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 validation/context-vars.c |   29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

--- sparse.orig/validation/context-vars.c	2008-04-27 14:10:37.000000000 +0200
+++ sparse/validation/context-vars.c	2008-04-27 14:41:41.000000000 +0200
@@ -1,3 +1,5 @@
+#include <stddef.h>
+
 static void a(void *p) __attribute__((context(p,0,1)))
 {
     __context__(p,1);
@@ -159,13 +161,32 @@ static void good_locked_val(void)
     ;
 }
 
+
+extern struct test *_search(int key);
+
+#define search(res, key) do {	\
+  (res) = _search((key));	\
+  if (res)			\
+      __context__(&(res)->lock,1);\
+  } while (0)
+
+static void test(void)
+{
+    struct test **x;
+
+    search(*x, 32);
+    if (*x)
+      unlock(*x);
+}
+
+
 /*
  * check-name: Check -Wcontext with lock variables
  *
  * check-error-start
-context-vars.c:53:7: warning: context imbalance in 'warn_lock1': wrong count at exit
-context-vars.c:53:7:    context '**v+4': wanted 0, got 1
-context-vars.c:137:11: warning: context problem in 'warn_unlock': 'unlock' expected different context
-context-vars.c:137:11:    context '*t+0': wanted >= 1, got 0
+context-vars.c:55:7: warning: context imbalance in 'warn_lock1': wrong count at exit
+context-vars.c:55:7:    context '**v+4': wanted 0, got 1
+context-vars.c:139:11: warning: context problem in 'warn_unlock': 'unlock' expected different context
+context-vars.c:139:11:    context '*t+0': wanted >= 1, got 0
  * check-error-end
  */

-- 

