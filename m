From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 15/37] build: reuse rule for ALL_OBJS
Date: Thu,  9 Nov 2017 07:46:26 +0100
Message-ID: <20171109064648.15379-16-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50496 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGrV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:21 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14660472wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:21 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

