From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/3] sparse test suite: add test mixing __context__ and
	__attribute__((context(...)))
Date: Thu, 10 Apr 2008 15:25:21 +0200
Message-ID: <20080410132618.299342000@sipsolutions.net>
References: <20080410132519.049821000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from crystal.sipsolutions.net ([195.210.38.204]:56456 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbYDJOl0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 10 Apr 2008 10:41:26 -0400
Content-Disposition: inline; filename=context-named-mixed-goto.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

An earlier version of the next patch had a bug that this test catches.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 validation/context-named.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- sparse.orig/validation/context-named.c	2008-04-10 14:57:26.000000000 +0200
+++ sparse/validation/context-named.c	2008-04-10 15:23:16.000000000 +0200
@@ -465,6 +465,27 @@ static void warn_exact_fn2(void)
     r2();
 }
 
+#define __acquire(x)	__context__(x,1)
+#define __release(x)	__context__(x,-1)
+
+#define rl() \
+  do { __acquire(RCU); } while (0)
+
+#define ru() \
+  do { __release(RCU); } while (0)
+
+static void good_mixed_with_if(void)
+{
+    rl();
+
+    if (condition) {
+        a();
+        r();
+    }
+
+    ru();
+}
+
 /*
  * check-name: Check -Wcontext with lock names
  *

-- 

