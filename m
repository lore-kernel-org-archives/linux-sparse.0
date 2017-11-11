From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 37/38] build: add rule to run a single test
Date: Sat, 11 Nov 2017 15:24:36 +0100
Message-ID: <20171111142437.67359-38-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53695 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdKKOZ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id g141so7556459wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:59 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 2c70d904b..a2d3e8c89 100644
--- a/Makefile
+++ b/Makefile
@@ -208,6 +208,8 @@ version.h: FORCE
 
 check: all
 	$(Q)cd validation && ./test-suite
+validation/%.t: FORCE
+	@validation/test-suite single $*.c
 
 
 clean: clean-check
-- 
2.14.0

