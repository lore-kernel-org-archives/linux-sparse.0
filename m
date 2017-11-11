From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 22/38] build: make clean targets quieter
Date: Sat, 11 Nov 2017 15:24:21 +0100
Message-ID: <20171111142437.67359-23-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36471 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdKKOZ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so7479455wmr.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:28 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 400187887..18b9c75dd 100644
--- a/Makefile
+++ b/Makefile
@@ -218,9 +218,10 @@ check: all
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
+	@rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
 clean-check:
-	find validation/ \( -name "*.c.output.expected" \
+	@echo '     CLEAN'
+	@find validation/ \( -name "*.c.output.expected" \
 	                 -o -name "*.c.output.got" \
 	                 -o -name "*.c.output.diff" \
 	                 -o -name "*.c.error.expected" \
-- 
2.14.0

