From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 6/5] test conditional result locking
Date: Sun, 27 Apr 2008 14:23:52 +0200
Message-ID: <1209299032.10943.71.camel@johannes.berg>
References: <20080427113128.237957000@sipsolutions.net>
	 <20080427113350.901380000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:38582 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754926AbYD0MYB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2008 08:24:01 -0400
In-Reply-To: <20080427113350.901380000@sipsolutions.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>

To test a function that can return a locked struct or NULL,
a macro has to be invented. Add a test case for that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
This is a bit awkward but I don't see any good way to do it differently
since otherwise we'd have to track the assignment.

 validation/context-vars.c |   28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

--- sparse.orig/validation/context-vars.c	2008-04-27 14:10:37.000000000 +0200
+++ sparse/validation/context-vars.c	2008-04-27 14:14:25.000000000 +0200
@@ -1,3 +1,5 @@
+#include <stddef.h>
+
 static void a(void *p) __attribute__((context(p,0,1)))
 {
     __context__(p,1);
@@ -159,13 +161,31 @@ static void good_locked_val(void)
     ;
 }
 
+
+extern struct test *_search(int key);
+
+#define search(res, key) do {\
+  res = _search((key)); \
+  (res ? ({ __context__(&res->lock,1); res; }) : NULL); \
+  } while (0)
+
+static void test(void)
+{
+    struct test *x;
+
+    search(x, 32);
+    if (x)
+      unlock(x);
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


