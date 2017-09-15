From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/28] testsuite: clearer result summary
Date: Fri, 15 Sep 2017 09:13:37 +0200
Message-ID: <20170915071358.7312-8-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36779 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:14 -0400
Received: by mail-wm0-f68.google.com with SMTP id r136so1958704wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:13 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 8b2e0c85a..3d2192178 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -353,15 +353,20 @@ do_test_suite()
 		do_test "$i"
 	done
 
+	OK=OK
+	[ $failed -eq 0 ] || OK=KO
+
 	# prints some numbers
 	tests_nr=$(($ok_tests + $ko_tests))
-	echo "Out of $tests_nr tests, $ok_tests passed, $ko_tests failed" \
-		" ($known_ko_tests of them are known to fail)"
+	echo "$OK: out of $tests_nr tests, $ok_tests passed, $ko_tests failed"
+	if [ "$known_ko_tests" -ne 0 ]; then
+		echo "	$known_ko_tests of them are known to fail"
+	fi
 	if [ "$unhandled_tests" -ne "0" ]; then
-		echo "$unhandled_tests tests could not be handled by $prog_name"
+		echo "	$unhandled_tests tests could not be handled by $prog_name"
 	fi
 	if [ "$disabled_tests" -ne "0" ]; then
-		echo "$disabled_tests tests were disabled"
+		echo "	$disabled_tests tests were disabled"
 	fi
 }
 
-- 
2.14.0

