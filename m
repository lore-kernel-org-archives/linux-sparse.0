From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 32/38] build: simplify clean pattern
Date: Sat, 11 Nov 2017 15:24:31 +0100
Message-ID: <20171111142437.67359-33-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37274 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdKKOZs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:48 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so7477817wme.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:48 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index bf2f82042..d0e616ba5 100644
--- a/Makefile
+++ b/Makefile
@@ -214,13 +214,9 @@ clean: clean-check
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

