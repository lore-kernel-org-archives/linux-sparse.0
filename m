From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 22/37] build: make clean targets quieter
Date: Thu,  9 Nov 2017 07:46:33 +0100
Message-ID: <20171109064648.15379-23-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32818 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGre (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:34 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so983518wmr.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:34 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index cd48a2a3b..af03d5dd5 100644
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

