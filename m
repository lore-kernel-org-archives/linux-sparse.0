From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 33/38] build: add *.o to clean-check pattern
Date: Sat, 11 Nov 2017 15:24:32 +0100
Message-ID: <20171111142437.67359-34-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35622 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdKKOZu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:50 -0500
Received: by mail-wm0-f49.google.com with SMTP id y80so7435300wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:50 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

.o files are also created in the validation directory
(currently only tmp.o, for sparse-llvm/sparsec testing).

Aso remove them during make clean-check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index d0e616ba5..e57934c92 100644
--- a/Makefile
+++ b/Makefile
@@ -216,6 +216,7 @@ clean-check:
 	@echo "  CLEAN"
 	@find validation/ \( -name "*.c.output.*" \
 			  -o -name "*.c.error.*" \
+			  -o -name "*.o" \
 	                  \) -exec rm {} \;
 
 
-- 
2.14.0

