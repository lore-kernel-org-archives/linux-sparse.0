From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/16] testsuite: add & use warning()
Date: Fri,  8 Dec 2017 14:14:45 +0100
Message-ID: <20171208131455.7786-7-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37644 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:16 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so3153518wmd.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:16 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Allow this new helper to indicate wich file trigger the
warning and replace the existing call to 'echo "warning: ...'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index f04d81779..420214c65 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -51,6 +51,14 @@ verbose()
 	return 0
 }
 
+##
+# warning(string) - prints a warning
+warning()
+{
+	[ "$quiet" -ne 1 ] && echo "warning: $1"
+	return 0
+}
+
 ##
 # error(string[, die]) - prints an error and exits with value die if given
 error()
@@ -253,7 +261,7 @@ do_test()
 	# can this test be handled by test-suite ?
 	# (it has to have a check-name key in it)
 	if [ "$check_name" = "" ]; then
-		echo "warning: test '$file' unhandled"
+		warning "$file: test unhandled"
 		unhandled_tests=$(($unhandled_tests + 1))
 		return 2
 	fi
-- 
2.15.0

