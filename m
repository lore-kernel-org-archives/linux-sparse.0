From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 14/37] build: no need to use wildcards for generated dependencies
Date: Thu,  9 Nov 2017 07:46:25 +0100
Message-ID: <20171109064648.15379-15-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50494 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdKIGrU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:20 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14660408wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:20 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

