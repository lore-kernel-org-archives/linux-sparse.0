From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/16] testsuite: reset 'quiet' at the start of each testcase
Date: Fri,  8 Dec 2017 14:14:46 +0100
Message-ID: <20171208131455.7786-8-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43499 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdLHNPR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id n138so3249957wmg.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:16 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The flag 'quiet' is used to quiets unwanted error messages,
for example for testcases known to fail, but this flag is reset
too late so that the beginning of the next testcases will run
with the value for the previous case.

Fix this by reseting the flag at the begining of each testcase.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 420214c65..6a939846f 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -255,6 +255,7 @@ do_test()
 {
 	test_failed=0
 	file="$1"
+	quiet=0
 
 	get_tag_value $file
 
@@ -316,7 +317,6 @@ do_test()
 	actual_exit_value=$?
 
 	must_fail=$check_known_to_fail
-	quiet=0
 	[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
 	known_ko_tests=$(($known_ko_tests + $must_fail))
 
-- 
2.15.0

