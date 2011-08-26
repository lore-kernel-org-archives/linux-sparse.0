From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse: Reduce 'test-suite' run output
Date: Fri, 26 Aug 2011 16:50:21 +0300
Message-ID: <1314366621-29361-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47337 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab1HZNuZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Aug 2011 09:50:25 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

There's more than 100 tests in the validation test suite. That makes it
cumbersome to notice test breakage in because the results don't fit on single
page.

We don't expect to see most tests to pass so it's much more convenient to
only be verbose for failing test cases. This patch changes the
'test-suite' output to report progress on a single line unless a test case
fails.

Current master 'make check' output looks as follows:

  Makefile:53: Your system does not have libxml, disabling c2xml
       TEST    preprocessor/preprocessor14.c ( Preprocessor #14)
  error: actual output text does not match expected output text.
  error: see preprocessor/preprocessor14.c.output.* for further investigation.
  --- preprocessor/preprocessor14.c.output.expected	2011-08-26 05:47:22.000000000 +0000
  +++ preprocessor/preprocessor14.c.output.got	2011-08-26 05:47:22.000000000 +0000
  @@ -1,2 +1,2 @@

  -
  +,
  info: test 'preprocessor/preprocessor14.c' is known to fail
       TEST    static-forward-decl.c ( static forward declaration)
  error: actual error text does not match expected error text.
  error: see static-forward-decl.c.error.* for further investigation.
  --- static-forward-decl.c.error.expected	2011-08-26 05:47:22.000000000 +0000
  +++ static-forward-decl.c.error.got	2011-08-26 05:47:22.000000000 +0000
  @@ -0,0 +1 @@
  +static-forward-decl.c:3:5: warning: symbol 'f' was not declared. Should it be static?
  info: test 'static-forward-decl.c' is known to fail
       TEST    varargs1.c ( Varargs bogus warning regression test #1)
  Out of 102 tests, 100 passed, 2 failed (2 of them are known to fail)

Cc: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 validation/test-suite |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..513d785 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -95,7 +95,7 @@ do_test()
 	fi
 	test_name=$last_result
 
-	echo "     TEST    $test_name ($file)"
+	printf "\r     TEST    %-80s" "$file ($test_name)"
 
 	# does the test provide a specific command ?
 	cmd=`eval echo $default_path/$default_cmd`
@@ -128,6 +128,7 @@ do_test()
 	for stream in output error; do
 		diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
 		if [ "$?" -ne "0" ]; then
+			echo ""
 			error "actual $stream text does not match expected $stream text."
 			error  "see $file.$stream.* for further investigation."
 			cat "$file".$stream.diff
@@ -163,6 +164,7 @@ do_test_suite()
 
 	# prints some numbers
 	tests_nr=`expr $ok_tests + $ko_tests`
+	echo ""
 	echo -n "Out of $tests_nr tests, $ok_tests passed, $ko_tests failed"
 	echo " ($known_ko_tests of them are known to fail)"
 	if [ "$unhandled_tests" -ne "0" ]; then
-- 
1.7.4.1

