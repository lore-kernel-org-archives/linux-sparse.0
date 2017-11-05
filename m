From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/36] build: fix effectiveness of generated dependencies
Date: Sun,  5 Nov 2017 17:25:14 +0100
Message-ID: <20171105162544.72960-6-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51322 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdKEQZ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:25:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id b9so9857983wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:25:58 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Commit fb8734e3f "Makefile: clean up and simplify" added blindly
$(LIB_H) as dependency to all .o targets.
This completely defeat the purpose of generated dependencies.

Fix this by removing this unneeded dependency.

Fixes: fb8734e3fa18619277f54f131a9b898ce7171645
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f1af83e32..bc4469410 100644
--- a/Makefile
+++ b/Makefile
@@ -208,7 +208,7 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
-%.o: %.c $(LIB_H)
+%.o: %.c
 	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
 
 %.sc: %.c sparse
-- 
2.14.0

