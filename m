From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 06/10] don't run sparse{c,i} tests when sparse-llvm is disabled
Date: Mon, 04 Aug 2014 19:38:24 +0100
Message-ID: <53DFD320.2050903@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:39340 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbaHDSi1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:38:27 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 validation/test-suite | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..0142701 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -7,12 +7,18 @@ default_cmd="sparse \$file"
 tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
 prog_name=`basename $0`
 
+if [ ! -x "$default_path/sparse-llvm" ]; then
+	disabled_cmds="sparsec sparsei sparse-llvm"
+fi
+
 # counts:
 #	- tests that have not been converted to test-suite format
+#	- tests that are disabled
 #	- tests that passed
 #	- tests that failed
 #	- tests that failed but are known to fail
 unhandled_tests=0
+disabled_tests=0
 ok_tests=0
 ko_tests=0
 known_ko_tests=0
@@ -80,6 +86,7 @@ echo "    help                       prints usage"
 #	- 0 if the test passed,
 #	- 1 if it failed,
 #	- 2 if it is not a "test-suite" test.
+#	- 3 if the test is disabled.
 do_test()
 {
 	test_failed=0
@@ -95,8 +102,6 @@ do_test()
 	fi
 	test_name=$last_result
 
-	echo "     TEST    $test_name ($file)"
-
 	# does the test provide a specific command ?
 	cmd=`eval echo $default_path/$default_cmd`
 	get_value "check-command" $file
@@ -104,6 +109,19 @@ do_test()
 		last_result=`echo $last_result | sed -e 's/^ *//'`
 		cmd=`eval echo $default_path/$last_result`
 	fi
+
+	# check for disabled commands
+	for i in $disabled_cmds; do
+		case "$cmd" in
+		*$i*)
+			disabled_tests=`expr $disabled_tests + 1`
+			return 3
+			;;
+		esac
+	done
+
+	echo "     TEST    $test_name ($file)"
+
 	verbose "Using command       : $cmd"
 
 	# grab the expected exit value
@@ -168,6 +186,9 @@ do_test_suite()
 	if [ "$unhandled_tests" -ne "0" ]; then
 		echo "$unhandled_tests tests could not be handled by $prog_name"
 	fi
+	if [ "$disabled_tests" -ne "0" ]; then
+		echo "$disabled_tests tests were disabled"
+	fi
 }
 
 ##
-- 
2.0.0
