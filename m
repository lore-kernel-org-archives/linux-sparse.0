From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 20/28] testsuite: save screen real estate
Date: Fri, 15 Sep 2017 09:13:50 +0200
Message-ID: <20170915071358.7312-21-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33828 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQ1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id i131so1975045wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:26 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 746c0fb3a..f2e1c3242 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -233,7 +233,7 @@ disable()
 {
 	disabled_tests=$(($disabled_tests + 1))
 	if [ -z "$vquiet" ]; then
-		echo "     DISABLE $1 ($2)"
+		echo "  SKIP	$1 ($2)"
 	fi
 }
 
@@ -293,7 +293,7 @@ do_test()
 	cmd=`eval echo $default_path/$check_command`
 
 	if [ -z "$vquiet" ]; then
-		echo "     TEST    $test_name ($file)"
+		echo "  TEST	$test_name ($file)"
 	fi
 
 	verbose "Using command       : $cmd"
-- 
2.14.0

