From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] fix test validation/div.c
Date: Mon, 27 Mar 2017 16:19:17 +0200
Message-ID: <20170327141918.61151-5-luc.vanoostenryck@gmail.com>
References: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33600 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbdC0OWB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 10:22:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id 20so13746955wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 07:21:54 -0700 (PDT)
In-Reply-To: <20170327141918.61151-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This test, which test the diagnostics given at the boundary
conditions of division, depends on the header <limits.h> which
itself depends on some macros being defined by the compiler.

Now these macros are predefined (at least the obvious ones)
but it's annoying for the tests to depends on external things
like this header.

Remove this dependence by rewriting the test to use the predefined
macros directly.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/div.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/validation/div.c b/validation/div.c
index 3dcbfd57c..3e6fb6988 100644
--- a/validation/div.c
+++ b/validation/div.c
@@ -1,4 +1,6 @@
-#include <limits.h>
+#define	INT_MIN		(-__INT_MAX__ - 1)
+#define	LONG_MIN	(-__LONG_MAX__ - 1)
+#define	LLONG_MIN	(-__LONG_LONG_MAX__ - 1)
 
 static int xd = 1 / 0;
 static int xl = 1L / 0;
@@ -16,14 +18,14 @@ static long long zll = LLONG_MIN % -1;
  * check-name: division constants
  *
  * check-error-start
-div.c:3:19: warning: division by zero
-div.c:4:20: warning: division by zero
-div.c:5:22: warning: division by zero
-div.c:7:25: warning: constant integer operation overflow
-div.c:8:27: warning: constant integer operation overflow
-div.c:9:34: warning: constant integer operation overflow
-div.c:11:25: warning: constant integer operation overflow
-div.c:12:27: warning: constant integer operation overflow
-div.c:13:34: warning: constant integer operation overflow
+div.c:5:19: warning: division by zero
+div.c:6:20: warning: division by zero
+div.c:7:22: warning: division by zero
+div.c:9:25: warning: constant integer operation overflow
+div.c:10:27: warning: constant integer operation overflow
+div.c:11:34: warning: constant integer operation overflow
+div.c:13:25: warning: constant integer operation overflow
+div.c:14:27: warning: constant integer operation overflow
+div.c:15:34: warning: constant integer operation overflow
  * check-error-end
  */
-- 
2.12.0

