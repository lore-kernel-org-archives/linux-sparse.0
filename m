From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2] remove validation/tmp.o in clean target
Date: Sun, 19 Jul 2015 12:03:14 +0200
Message-ID: <1437300194-14573-1-git-send-email-uwe@kleine-koenig.org>
References: <1437299869-3669-1-git-send-email-uwe@kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:47420 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbbGSKDT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Jul 2015 06:03:19 -0400
In-Reply-To: <1437299869-3669-1-git-send-email-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

To prevent validation/tmp.o being still around after

	make check && make clean

remove it as part of the latter command.
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c7031afda00b..69e758da2fbf 100644
--- a/Makefile
+++ b/Makefile
@@ -218,4 +218,5 @@ clean-check:
 	                 -o -name "*.c.error.expected" \
 	                 -o -name "*.c.error.got" \
 	                 -o -name "*.c.error.diff" \
+			 -o -name "*.o" \
 	                 \) -exec rm {} \;
-- 
2.1.4

