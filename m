From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 14/14] testsuite: quieter error reporting for 'known-to-fail'
Date: Mon, 13 Feb 2017 00:29:04 +0100
Message-ID: <20170212232904.49647-15-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdBLX3Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so16482540wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:23 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 47015c61f..a5f5e25e2 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -214,6 +214,8 @@ do_test()
 
 	get_tag "check-known-to-fail" $file
 	must_fail=`expr "$?" = 0`
+	quiet=0
+	[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
 	known_ko_tests=`expr $known_ko_tests + $must_fail`
 
 	for stream in output error; do
-- 
2.11.0

