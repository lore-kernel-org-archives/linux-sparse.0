From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 12/14] testsuite: get 'check-known-to-fail' earlier
Date: Mon, 13 Feb 2017 00:29:02 +0100
Message-ID: <20170212232904.49647-13-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35699 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdBLX3W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so16480688wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:21 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 852904a4d..fdb7cbc26 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -212,6 +212,10 @@ do_test()
 	$cmd 1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
+	get_tag "check-known-to-fail" $file
+	must_fail=`expr "$?" = 0`
+	known_ko_tests=`expr $known_ko_tests + $must_fail`
+
 	for stream in output error; do
 		grep -s -q "check-$stream-ignore" $file && continue
 
@@ -249,10 +253,6 @@ do_test()
 		test_failed=1
 	fi
 
-	get_tag "check-known-to-fail" $file
-	must_fail=`expr "$?" = 0`
-	known_ko_tests=`expr $known_ko_tests + $must_fail`
