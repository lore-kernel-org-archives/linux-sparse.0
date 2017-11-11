From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 24/38] build: normalize rules
Date: Sat, 11 Nov 2017 15:24:23 +0100
Message-ID: <20171111142437.67359-25-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35505 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdKKOZc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:32 -0500
Received: by mail-wm0-f68.google.com with SMTP id y80so7434637wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:32 -0800 (PST)
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
index 70220e841..cc8044915 100644
--- a/Makefile
+++ b/Makefile
@@ -161,10 +161,10 @@ ldflags += $($(@)-ldflags) $(LDFLAGS)
 ldlibs  += $($(@)-ldlibs)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs)))
 $(PROGRAMS): % : %.o $(LIBS)
-	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
+	$(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
 
 libsparse.a: $(LIB_OBJS)
-	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(AR) rcs $@ $^
 
 OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)-objs))
 DEPS := $(OBJS:%.o=.%.o.d)
-- 
2.14.0

