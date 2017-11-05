From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 29/36] build: use git-clean
Date: Sun,  5 Nov 2017 17:25:37 +0100
Message-ID: <20171105162544.72960-29-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45316 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdKEQ0e (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:34 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so9495552wmd.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:34 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index afc1efe98..f0f7a5b69 100644
--- a/Makefile
+++ b/Makefile
@@ -233,16 +233,8 @@ check: all
 	$(Q)cd validation && ./test-suite
 
 
-clean: clean-check
-	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
-clean-check:
+clean: FORCE
 	@echo '     CLEAN'
-	@find validation/ \( -name "*.c.output.expected" \
-	                 -o -name "*.c.output.got" \
-	                 -o -name "*.c.output.diff" \
-	                 -o -name "*.c.error.expected" \
-	                 -o -name "*.c.error.got" \
-	                 -o -name "*.c.error.diff" \
-	                 \) -exec rm {} \;
+	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
 
 .PHONY: FORCE
-- 
2.14.0

