From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/28] testsuite: move verbose() & error()
Date: Fri, 15 Sep 2017 09:13:33 +0200
Message-ID: <20170915071358.7312-4-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33062 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:09 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so1975300wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:09 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 9e30ed937..5f63a23bb 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -71,6 +71,23 @@ get_tag_value()
 EOT
 }
 
+##
+# verbose(string) - prints string if we are in verbose mode
+verbose()
+{
+	[ "$V" -eq "1" ] && echo "        $1"
+	return 0
+}
+
+##
+# error(string[, die]) - prints an error and exits with value die if given
+error()
+{
+	[ "$quiet" -ne 1 ] && echo "error: $1"
+	[ -n "$2" ] && exit $2
+	return 0
+}
+
 ##
 # helper for has_(each|none)_patterns()
 has_patterns()
@@ -132,23 +149,6 @@ nbr_patterns()
 	return $?
 }
 
-##
-# verbose(string) - prints string if we are in verbose mode
-verbose()
-{
-	[ "$V" -eq "1" ] && echo "        $1"
-	return 0
-}
-
-##
-# error(string[, die]) - prints an error and exits with value die if given
-error()
-{
-	[ "$quiet" -ne 1 ] && echo "error: $1"
-	[ -n "$2" ] && exit $2
-	return 0
-}
