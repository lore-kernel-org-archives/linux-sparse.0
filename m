From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 14/16] Test conditional result locking
Date: Fri, 19 Dec 2008 01:35:05 +0300
Message-ID: <20081218223455.23692.82825.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:7286 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbYLRWZu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:25:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so511441ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:25:50 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

To test a function that can return a locked struct or NULL,
a macro has to be invented. Add a test case for that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 validation/context-vars.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/validation/context-vars.c b/validation/context-vars.c
index a44bfd8..a0c966f 100644
--- a/validation/context-vars.c
+++ b/validation/context-vars.c
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

