From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] testsuite: use shell arithmetic instead of fork-execing expr
Date: Sun, 28 May 2017 21:29:04 +0200
Message-ID: <20170528192906.1023-5-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34831 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE1T3Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so12960481wmc.2
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:15 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The tessuite use a few counters to keep track of things.
These counters are incremented via the 'expr' command.

But this command is not a shell builtin and need thus
to be fork+execed which need more CPU ressources than
using some builtin operation.

Change this by doing all the arithmetic via the portable
'$(( ... ))' shell builtin.

This speedup the testsuite by another 10%.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index e33d97804..da9d88159 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -180,7 +180,7 @@ do_test()
 	# (it has to have a check-name key in it)
 	if [ "$check_name" = "" ]; then
 		echo "warning: test '$file' unhandled"
-		unhandled_tests=`expr $unhandled_tests + 1`
+		unhandled_tests=$(($unhandled_tests + 1))
 		return 2
 	fi
 	test_name="$check_name"
@@ -196,7 +196,7 @@ do_test()
 	base_cmd=`basename $1`
 	for i in $disabled_cmds; do
 		if [ "$i" = "$base_cmd" ] ; then
-			disabled_tests=`expr $disabled_tests + 1`
+			disabled_tests=$(($disabled_tests + 1))
 			echo "     DISABLE $test_name ($file)"
 			return 3
 		fi
@@ -218,7 +218,7 @@ do_test()
 	must_fail=$check_known_to_fail
 	quiet=0
 	[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
-	known_ko_tests=`expr $known_ko_tests + $must_fail`
+	known_ko_tests=$(($known_ko_tests + $must_fail))
 
 	for stream in output error; do
 		eval ignore=\$check_${stream}_ignore
@@ -279,9 +279,9 @@ do_test()
 	fi
 
 	if [ "$test_failed" -eq "1" ]; then
-		ko_tests=`expr $ko_tests + 1`
+		ko_tests=$(($ko_tests + 1))
 	else
-		ok_tests=`expr $ok_tests + 1`
+		ok_tests=$(($ok_tests + 1))
 		rm -f $file.{error,output}.{expected,got,diff}
 	fi
 	return $test_failed
@@ -294,7 +294,7 @@ do_test_suite()
 	done
 
 	# prints some numbers
-	tests_nr=`expr $ok_tests + $ko_tests`
+	tests_nr=$(($ok_tests + $ko_tests))
 	echo -n "Out of $tests_nr tests, $ok_tests passed, $ko_tests failed"
 	echo " ($known_ko_tests of them are known to fail)"
 	if [ "$unhandled_tests" -ne "0" ]; then
-- 
2.13.0

