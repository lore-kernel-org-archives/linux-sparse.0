From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/36] build: use $LIBS directly in the dependency list
Date: Sun,  5 Nov 2017 17:25:21 +0100
Message-ID: <20171105162544.72960-13-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48293 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdKEQ0G (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id p75so9516157wmg.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:05 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 73fc6d554..da99a60ad 100644
--- a/Makefile
+++ b/Makefile
@@ -170,8 +170,8 @@ compile_OBJS := compile-i386.o
 
 ldflags += $($(@)_LDFLAGS) $(LDFLAGS)
 ldlibs  += $($(@)_LDLIBS)  $(LDLIBS)
-$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS) $(LIBS)))
-$(PROGRAMS): % : %.o 
+$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
+$(PROGRAMS): % : %.o $(LIBS)
 	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
 
 $(LIB_FILE): $(LIB_OBJS)
-- 
2.14.0

