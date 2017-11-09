From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 13/37] build: use $LIBS directly in the dependency list
Date: Thu,  9 Nov 2017 07:46:24 +0100
Message-ID: <20171109064648.15379-14-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50488 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbdKIGrS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14660282wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:18 -0800 (PST)
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

