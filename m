From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] testsuite: grep the output patterns only when needed
Date: Sun, 28 May 2017 21:29:03 +0200
Message-ID: <20170528192906.1023-4-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34511 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE1T3P (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so12947138wmf.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:15 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For some testcase, it is checked if the output contains or not
some given pattern, or we're checking the number of time a
pattern is present in the output.
This is done with grep and some glue.

But for most testcases there is nothing to check and this
grepping is just wasted CPU cycles.

Fix this by using the already known tags to see if we need to
do this grepping or not.

This speedup the testsuite by another 15%.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index ce2ca454c..e33d97804 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -244,22 +244,27 @@ do_test()
 	fi
 
 	# verify the 'check-output-contains/excludes' tags
-	has_each_patterns "$file" 'check-output-contains' $file.output.got
-	if [ "$?" -ne "0" ]; then
-		error "Actual output doesn't contain some of the expected patterns."
-		test_failed=1
+	if [ $check_output_contains -eq 1 ]; then
+		has_each_patterns "$file" 'check-output-contains' $file.output.got
+		if [ "$?" -ne "0" ]; then
+			error "Actual output doesn't contain some of the expected patterns."
+			test_failed=1
+		fi
 	fi
-	has_none_patterns "$file" 'check-output-excludes' $file.output.got
-	if [ "$?" -ne "0" ]; then
-		error "Actual output contains some patterns which are not expected."
-		test_failed=1
+	if [ $check_output_excludes -eq 1 ]; then
+		has_none_patterns "$file" 'check-output-excludes' $file.output.got
+		if [ "$?" -ne "0" ]; then
+			error "Actual output contains some patterns which are not expected."
+			test_failed=1
+		fi
 	fi
