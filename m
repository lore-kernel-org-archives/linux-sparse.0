From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/36] build: no need to use wildcards for generated dependencies
Date: Sun,  5 Nov 2017 17:25:22 +0100
Message-ID: <20171105162544.72960-14-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:49527 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdKEQ0H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id b189so9452961wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:06 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index da99a60ad..b694db61a 100644
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

