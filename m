From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/36] build: reuse rule for ALL_OBJS
Date: Sun,  5 Nov 2017 17:25:23 +0100
Message-ID: <20171105162544.72960-15-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:48054 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdKEQ0J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id r196so9512419wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:09 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b694db61a..2d3deec3a 100644
--- a/Makefile
+++ b/Makefile
@@ -195,8 +195,7 @@ cflags   += $($(*)_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 %.sc: %.c sparse
 	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
-ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_OBJS))
-selfcheck: $(ALL_OBJS:.o=.sc)
+selfcheck: $(OBJS:.o=.sc)
 
 
 clean: clean-check
-- 
2.14.0

