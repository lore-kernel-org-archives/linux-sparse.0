From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 32/37] build: simplify clean pattern
Date: Thu,  9 Nov 2017 07:46:43 +0100
Message-ID: <20171109064648.15379-33-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50589 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdKIGrx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:53 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14662511wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:52 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index c861ca090..bdb6c03af 100644
--- a/Makefile
+++ b/Makefile
@@ -213,13 +213,9 @@ clean: clean-check
 	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
 clean-check:
 	@echo "  CLEAN"
-	@find validation/ \( -name "*.c.output.expected" \
-	                 -o -name "*.c.output.got" \
-	                 -o -name "*.c.output.diff" \
-	                 -o -name "*.c.error.expected" \
-	                 -o -name "*.c.error.got" \
-	                 -o -name "*.c.error.diff" \
-	                 \) -exec rm {} \;
+	@find validation/ \( -name "*.c.output.*" \
+			  -o -name "*.c.error.*" \
+	                  \) -exec rm {} \;
 
 
 install: $(INST_PROGRAMS) $(INST_MAN1) install-dirs install-bin install-man
-- 
2.14.0

