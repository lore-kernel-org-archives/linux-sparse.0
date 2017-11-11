From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 15/38] build: reuse rule for ALL_OBJS
Date: Sat, 11 Nov 2017 15:24:14 +0100
Message-ID: <20171111142437.67359-16-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34347 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdKKOZR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id n74so8859026wmi.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:16 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 1a71ef01b..2df5aa2c9 100644
--- a/Makefile
+++ b/Makefile
@@ -180,7 +180,7 @@ $(LIB_FILE): $(LIB_OBJS)
 $(SLIB_FILE): $(LIB_OBJS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
 
-OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)_OBJS))
+OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)-objs))
 DEPS := $(OBJS:%.o=.%.o.d)
 
 -include $(DEPS)
@@ -195,8 +195,7 @@ cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
 %.sc: %.c sparse
 	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
-ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)-objs))
-selfcheck: $(ALL_OBJS:.o=.sc)
+selfcheck: $(OBJS:.o=.sc)
 
 
 clean: clean-check
-- 
2.14.0

