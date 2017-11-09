From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 06/37] build: fix effectiveness of generated dependencies
Date: Thu,  9 Nov 2017 07:46:17 +0100
Message-ID: <20171109064648.15379-7-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32779 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752537AbdKIGrG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so982572wmr.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:06 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

