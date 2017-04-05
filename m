From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: cleanup result files
Date: Wed,  5 Apr 2017 23:30:41 +0200
Message-ID: <20170405213041.46179-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34028 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755481AbdDEVcw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Apr 2017 17:32:52 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so6164785wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 05 Apr 2017 14:32:51 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When a test succeed, remove all temporary/result files
but leave them for failed tests.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 1 +
 1 file changed, 1 insertion(+)

diff --git a/validation/test-suite b/validation/test-suite
index a5f5e25e2..904a2dbbd 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -270,6 +270,7 @@ do_test()
 		ko_tests=`expr $ko_tests + 1`
 	else
 		ok_tests=`expr $ok_tests + 1`
+		rm -f $file.{error,output}.{expected,got,diff}
 	fi
 	return $test_failed
 }
-- 
2.12.0

