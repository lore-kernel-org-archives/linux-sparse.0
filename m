From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] test-suite: be more verbose on 'unhandled' and 'known to
	fail' tests
Date: Thu, 16 Jul 2009 23:51:49 +0200
Message-ID: <20090716215134.7792.46659.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:45061 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932898AbZGPVxv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 16 Jul 2009 17:53:51 -0400
Received: by ewy26 with SMTP id 26so474826ewy.37
        for <linux-sparse@vger.kernel.org>; Thu, 16 Jul 2009 14:53:49 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Impact:
  - On an 'unhandled' test issue a warning, and
  - in case of a 'known to fail' test a info message.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

grep-ed out from 'make check' output:

warning: test 'badtype1.c' unhandled
warning: test 'badtype2.c' unhandled
warning: test 'badtype3.c' unhandled
warning: test 'bitfields.c' unhandled
warning: test 'builtin_safe1.c' unhandled
warning: test 'choose_expr.c' unhandled
warning: test 'field-overlap.c' unhandled
warning: test 'foul-bitwise.c' unhandled
warning: test 'inline_compound_literals.c' unhandled
warning: test 'preprocessor/preprocessor11.c' unhandled
warning: test 'preprocessor/preprocessor12.c' unhandled
warning: test 'preprocessor/preprocessor13.c' unhandled
warning: test 'preprocessor/preprocessor14.c' unhandled
warning: test 'preprocessor/preprocessor15.c' unhandled
warning: test 'preprocessor/preprocessor16.c' unhandled
warning: test 'preprocessor/preprocessor7.c' unhandled
warning: test 'preprocessor/preprocessor8.c' unhandled
warning: test 'struct-ns2.c' unhandled
warning: test 'struct-size1.c' unhandled
warning: test 'test-be.c' unhandled
warning: test 'type1.c' unhandled

Out of 72 tests, 70 passed, 2 failed (2 of them are known to fail)
21 tests could not be handled by test-suite

I'd say we should integrate these tests into the test-suite, no?

Cheers,
Hannes

 validation/test-suite |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 1a35703..42f7bd7 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -89,6 +89,7 @@ do_test()
 	# (it has to have a check-name key in it)
 	get_value "check-name" $file
 	if [ "$?" -eq 1 ]; then
+		echo "warning: test '$file' unhandled"
 		unhandled_tests=`expr $unhandled_tests + 1`
 		return 2
 	fi
@@ -142,7 +143,10 @@ do_test()
 	if [ "$test_failed" -eq "1" ]; then
 		ko_tests=`expr $ko_tests + 1`
 		get_tag "check-known-to-fail" $file
-		[ "$?" -eq "0" ] && known_ko_tests=`expr $known_ko_tests + 1`
+		if [ "$?" -eq "0" ]; then
+			echo "info: test '$file' is known to fail"
+			known_ko_tests=`expr $known_ko_tests + 1`
+		fi
 		return 1
 	else
 		ok_tests=`expr $ok_tests + 1`

