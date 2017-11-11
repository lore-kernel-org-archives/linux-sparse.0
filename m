From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 13/38] build: use $LIBS directly in the dependency list
Date: Sat, 11 Nov 2017 15:24:12 +0100
Message-ID: <20171111142437.67359-14-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51881 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKKOZO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:14 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so766966wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:14 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index c66f730af..61271e19f 100644
--- a/Makefile
+++ b/Makefile
@@ -170,8 +170,8 @@ compile-objs:= compile-i386.o
 
 ldflags += $($(@)-ldflags) $(LDFLAGS)
 ldlibs  += $($(@)-ldlibs)  $(LDLIBS)
-$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs) $(LIBS)))
-$(PROGRAMS): % : %.o 
+$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs)))
+$(PROGRAMS): % : %.o $(LIBS)
 	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
 
 $(LIB_FILE): $(LIB_OBJS)
-- 
2.14.0

