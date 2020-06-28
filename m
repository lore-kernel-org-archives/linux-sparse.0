From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] remove unneeded BSD & Solaris compatibility layer
Date: Sun, 28 Jun 2020 11:09:04 +0200
Message-ID: <20200628090904.69011-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgF1JJK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Jun 2020 05:09:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F086C061794
        for <linux-sparse@vger.kernel.org>; Sun, 28 Jun 2020 02:09:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so13339533ejd.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 Jun 2020 02:09:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

None of the BSDs need "compat-bsd.c" anymore. Same for
Solaris and "compat-solaris.c", even for Solaris 10.

The only problem was lacking C99's strtold() but it seems
that this was solved many years ago and they're all doing
quite fine with "compat-linux.c".

So, simply replace the content of these file by an include of
"compat-linux.c".

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compat-bsd.c     | 14 +-------------
 compat-solaris.c | 34 +---------------------------------
 2 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/compat-bsd.c b/compat-bsd.c
index d8acf40b1dcb..43c716ca2f87 100644
--- a/compat-bsd.c
+++ b/compat-bsd.c
@@ -21,16 +21,4 @@
  * THE SOFTWARE.
  */
 
-#include <sys/types.h>
-#include <string.h>
-
-#include "lib.h"
-#include "allocate.h"
-#include "token.h"
-
-#include "compat/mmap-blob.c"
-
-long double string_to_ld(const char *nptr, char **endptr)
-{
-	return strtod(nptr, endptr);
-}
+#include "compat-linux.c"
diff --git a/compat-solaris.c b/compat-solaris.c
index 7253a892d50d..58bc43387c60 100644
--- a/compat-solaris.c
+++ b/compat-solaris.c
@@ -1,33 +1 @@
-#include "lib.h"
-#include "allocate.h"
-
-#include "compat/mmap-blob.c"
-
-#include <floatingpoint.h>
-#include <limits.h>
-#include <errno.h>
-
-long double string_to_ld(const char *str, char **endptr)
-{
-	long double res;
-	decimal_record dr;
-	enum decimal_string_form form;
-	decimal_mode dm;
-	fp_exception_field_type excp;
-	char *echar;
-
-	string_to_decimal ((char **)&str, INT_MAX, 0,
-			   &dr, &form, &echar);
-	if (endptr) *endptr = (char *)str;
-
-	if (form == invalid_form) {
-		errno = EINVAL;
-		return 0.0;
-	}
