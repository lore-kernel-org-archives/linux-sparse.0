From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 06/14] testsuite: report as error tests known to fail but which succeed
Date: Mon, 13 Feb 2017 00:28:56 +0100
Message-ID: <20170212232904.49647-7-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33135 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdBLX3Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:16 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so21879553wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:16 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Such situation may simply show that what was tested is now fixed
and that it's juste the test annotation which need to be adapted,
but can be a sign that something else is broken.

Reporting the exact result (failure/success, known-to-fail/expect-to-succeed)
make the testsuite more useful and allow to use more efficiently
git-bisect or other automated testing tools.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 0d874e075..8692bfe98 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -11,6 +11,10 @@ if [ ! -x "$default_path/sparse-llvm" ]; then
 	disabled_cmds="sparsec sparsei sparse-llvm"
 fi
 
+# flags:
+#	- some tests gave an unexpected result
+failed=0
+
 # counts:
 #	- tests that have not been converted to test-suite format
 #	- tests that are disabled
@@ -163,18 +167,27 @@ do_test()
 		test_failed=1
 	fi
 
-	if [ "$test_failed" -eq "1" ]; then
-		ko_tests=`expr $ko_tests + 1`
-		get_tag "check-known-to-fail" $file
-		if [ "$?" -eq "0" ]; then
+	get_tag "check-known-to-fail" $file
+	must_fail=`expr "$?" = 0`
+	known_ko_tests=`expr $known_ko_tests + $must_fail`
+
+	[ "$test_failed" -eq "$must_fail" ] || failed=1
+
+	if [ "$must_fail" -eq "1" ]; then
+		if [ "$test_failed" -eq "1" ]; then
 			echo "info: test '$file' is known to fail"
-			known_ko_tests=`expr $known_ko_tests + 1`
+		else
+			echo "info: test '$file' is known to fail but succeed!"
+			test_failed=1
 		fi
-		return 1
+	fi
+
+	if [ "$test_failed" -eq "1" ]; then
+		ko_tests=`expr $ko_tests + 1`
 	else
 		ok_tests=`expr $ok_tests + 1`
-		return 0
 	fi
+	return $test_failed
 }
 
 do_test_suite()
@@ -273,5 +286,5 @@ case "$1" in
 		;;
 esac
 
-exit 0
+exit $failed
 
-- 
2.11.0

