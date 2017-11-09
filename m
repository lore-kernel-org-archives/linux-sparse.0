From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 24/37] build: normalize rules
Date: Thu,  9 Nov 2017 07:46:35 +0100
Message-ID: <20171109064648.15379-25-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:57041 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGri (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:38 -0500
Received: by mail-wm0-f67.google.com with SMTP id z3so15289571wme.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:38 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0f69b479f..b2638ae41 100644
--- a/Makefile
+++ b/Makefile
@@ -161,10 +161,10 @@ ldflags += $($(@)_LDFLAGS) $(LDFLAGS)
 ldlibs  += $($(@)_LDLIBS)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
 $(PROGRAMS): % : %.o $(LIBS)
-	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
+	$(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
 
 libsparse.a: $(LIB_OBJS)
-	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(AR) rcs $@ $^
 
 OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)_OBJS))
 DEPS := $(OBJS:%.o=.%.o.d)
-- 
2.14.0

