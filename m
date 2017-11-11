From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 14/38] build: no need to use wildcards for generated dependencies
Date: Sat, 11 Nov 2017 15:24:13 +0100
Message-ID: <20171111142437.67359-15-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56285 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdKKOZP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:15 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so2082791wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:15 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 61271e19f..1a71ef01b 100644
--- a/Makefile
+++ b/Makefile
@@ -180,11 +180,10 @@ $(LIB_FILE): $(LIB_OBJS)
 $(SLIB_FILE): $(LIB_OBJS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -Wl,-soname,$@ -shared -o $@ $(LIB_OBJS)
 
-DEP_FILES := $(wildcard .*.o.d)
+OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)_OBJS))
+DEPS := $(OBJS:%.o=.%.o.d)
 
-ifneq ($(DEP_FILES),)
-include $(DEP_FILES)
-endif
+-include $(DEPS)
 
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
-- 
2.14.0

