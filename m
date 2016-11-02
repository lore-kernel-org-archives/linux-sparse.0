From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] testsuite: report as error tests known to fail but which succeed
Date: Wed,  2 Nov 2016 22:45:07 +0100
Message-ID: <20161102214509.36571-4-luc.vanoostenryck@gmail.com>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33275 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755744AbcKBVsX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 17:48:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id u144so5032594wmu.0
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 14:48:23 -0700 (PDT)
In-Reply-To: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
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
 validation/test-suite | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index df5a7c60..03421a24 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -161,15 +161,26 @@ do_test()
 		test_failed=1
 	fi
 
+	get_tag "check-known-to-fail" $file
+	if [ "$?" -eq "0" ]; then
+		must_fail=1
+		known_ko_tests=`expr $known_ko_tests + 1`
+	else
+		must_fail=0
+	fi
+
 	if [ "$test_failed" -eq "1" ]; then
 		ko_tests=`expr $ko_tests + 1`
-		get_tag "check-known-to-fail" $file
-		if [ "$?" -eq "0" ]; then
+		if [ "$must_fail" -eq "1" ]; then
 			echo "info: test '$file' is known to fail"
-			known_ko_tests=`expr $known_ko_tests + 1`
 		fi
 		return 1
 	else
+		if [ "$must_fail" -eq "1" ]; then
+			echo "info: test '$file' is known to fail but succeed!"
+			ko_tests=`expr $ko_tests + 1`
+			return 1
+		fi
 		ok_tests=`expr $ok_tests + 1`
 		return 0
 	fi
-- 
2.10.1

