From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 11/14] testsuite: use 'error' instead of 'info' for successful tests known to fail
Date: Mon, 13 Feb 2017 00:29:01 +0100
Message-ID: <20170212232904.49647-12-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34524 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdBLX3V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:21 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so16482396wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:21 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index c14a4c5ab..852904a4d 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -259,7 +259,7 @@ do_test()
 		if [ "$test_failed" -eq "1" ]; then
 			echo "info: test '$file' is known to fail"
 		else
-			echo "info: test '$file' is known to fail but succeed!"
+			echo "error: test '$file' is known to fail but succeed!"
 			test_failed=1
 		fi
 	fi
-- 
2.11.0

