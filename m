From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] testsuite: use 'error' instead of 'info' for successful tests known to fail
Date: Thu,  5 Jan 2017 06:16:29 +0100
Message-ID: <20170105051632.8392-3-luc.vanoostenryck@gmail.com>
References: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:34866 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759817AbdAEFT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 00:19:27 -0500
Received: by mail-wj0-f194.google.com with SMTP id hb5so44667763wjc.2
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 21:18:40 -0800 (PST)
In-Reply-To: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index c14a4c5a..852904a4 100755
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

