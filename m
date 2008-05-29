From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/9] add test for acquire/release
Date: Thu, 29 May 2008 10:54:03 +0200
Message-ID: <20080529085512.974905000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45736 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbYE2JAA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 05:00:00 -0400
Content-Disposition: inline; filename=002-acq-rel-test.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

Test that giving
	__attribute__((context(TEST,1,0)))
	__attribute__((context(TEST,0,1)))
instead of
	__attribute__((context(TEST,1,1)))
works.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 validation/context.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- sparse.orig/validation/context.c	2008-05-13 23:40:36.000000000 +0200
+++ sparse/validation/context.c	2008-05-14 00:58:33.000000000 +0200
@@ -380,6 +380,21 @@ static int warn_conditional(void)
     return 0;
 }
 
+static void good_require(void)
+__attribute__((context(TEST,1,0)))
+__attribute__((context(TEST,0,1)))
+{
+    __context__(TEST,-1);
+    __context__(TEST,1);
+}
+
+static void good_require_caller(void)
+{
+    __context__(TEST,1,0);
+    good_require();
+    __context__(TEST,-1,1);
+}
+
 /*
  * check-name: Check -Wcontext
  *

-- 

