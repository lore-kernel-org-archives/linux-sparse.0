From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 05/37] build: pass CPPFLAGS to compiler
Date: Thu,  9 Nov 2017 07:46:16 +0100
Message-ID: <20171109064648.15379-6-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56065 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdKIGrF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so465606wmd.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:04 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

Debian packages use CPPFLAGS to pass -D_FORTIFY_SOURCE=2 for hardening.

Originally-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Reviewed-by: Josh Triplett <josh@joshtriplett.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 39b34f901..f1af83e32 100644
--- a/Makefile
+++ b/Makefile
@@ -209,10 +209,10 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
 %.o: %.c $(LIB_H)
-	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
+	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(CFLAGS) $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.14.0

