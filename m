From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/28] testsuite: 'echo -n' may not be interpreted as '-n'
Date: Fri, 15 Sep 2017 09:13:31 +0200
Message-ID: <20170915071358.7312-2-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34713 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdIOHQI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:08 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so1974541wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:07 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

POSIX tell that the interpretation of the '-n' is implementation
independent. So avoid it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index cf151a361..53cd30190 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -303,8 +303,8 @@ do_test_suite()
 
 	# prints some numbers
 	tests_nr=$(($ok_tests + $ko_tests))
-	echo -n "Out of $tests_nr tests, $ok_tests passed, $ko_tests failed"
-	echo " ($known_ko_tests of them are known to fail)"
+	echo "Out of $tests_nr tests, $ok_tests passed, $ko_tests failed" \
+		" ($known_ko_tests of them are known to fail)"
 	if [ "$unhandled_tests" -ne "0" ]; then
 		echo "$unhandled_tests tests could not be handled by $prog_name"
 	fi
-- 
2.14.0

