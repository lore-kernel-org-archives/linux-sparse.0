From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 28/38] build: use standard rules for install
Date: Sat, 11 Nov 2017 15:24:27 +0100
Message-ID: <20171111142437.67359-29-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39475 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdKKOZl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:41 -0500
Received: by mail-wm0-f67.google.com with SMTP id l8so2036287wmg.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:40 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index e4efefa1e..afb76a994 100644
--- a/Makefile
+++ b/Makefile
@@ -168,31 +168,11 @@ QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
 QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
 
-define INSTALL_EXEC
-	$(QUIET_INST)install -v $1 $(DESTDIR)$2/$1 || exit 1;
-
-endef
-
-define INSTALL_FILE
-	$(QUIET_INST)install -v -m 644 $1 $(DESTDIR)$2/$1 || exit 1;
-
-endef
-
 
+compile_OBJS := compile-i386.o
 
 all: $(PROGRAMS)
 
-all-installable: $(INST_PROGRAMS)
-
-install: all-installable
-	$(Q)install -d $(DESTDIR)$(BINDIR)
-	$(Q)install -d $(DESTDIR)$(MAN1DIR)
-	$(foreach f,$(INST_PROGRAMS),$(call INSTALL_EXEC,$f,$(BINDIR)))
-	$(foreach f,$(INST_MAN1),$(call INSTALL_FILE,$f,$(MAN1DIR)))
-
-
-compile-objs:= compile-i386.o
