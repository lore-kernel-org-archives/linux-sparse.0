From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/28] testsuite: check error messages first
Date: Fri, 15 Sep 2017 09:13:38 +0200
Message-ID: <20170915071358.7312-9-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33121 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdIOHQO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so1975438wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:14 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 3d2192178..256d31550 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -276,7 +276,7 @@ do_test()
 	[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
 	known_ko_tests=$(($known_ko_tests + $must_fail))
 
-	for stream in output error; do
+	for stream in error output; do
 		eval ignore=\$check_${stream}_ignore
 		[ $ignore -eq 1 ] && continue
 
-- 
2.14.0

