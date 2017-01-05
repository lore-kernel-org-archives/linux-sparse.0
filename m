From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] testsuite: quieter error reporting for 'known-to-fail'
Date: Thu,  5 Jan 2017 06:16:32 +0100
Message-ID: <20170105051632.8392-6-luc.vanoostenryck@gmail.com>
References: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:32788 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759872AbdAEFT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 00:19:27 -0500
Received: by mail-wj0-f196.google.com with SMTP id kp2so77819823wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 21:18:43 -0800 (PST)
In-Reply-To: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 47015c61..a5f5e25e 100755
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

