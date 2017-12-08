From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/16] testsuite: move verbose/error() before get_tag_value()
Date: Fri,  8 Dec 2017 14:14:44 +0100
Message-ID: <20171208131455.7786-6-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:41857 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753303AbdLHNPP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:15 -0500
Received: by mail-wm0-f68.google.com with SMTP id g75so3288655wme.0
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:15 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

So, we can use them inside get_tag_value().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 07d9e7fc9..f04d81779 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -42,6 +42,25 @@ vquiet=""
 quiet=0
 abort=0
 
+
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
+
 ##
 # get_tag_value(file) - get the 'check-<...>' tags & values
 get_tag_value()
@@ -87,23 +106,6 @@ get_tag_value()
 EOT
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
