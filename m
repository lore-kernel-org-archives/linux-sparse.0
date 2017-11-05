From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 30/36] build: use standard rules for install
Date: Sun,  5 Nov 2017 17:25:38 +0100
Message-ID: <20171105162544.72960-30-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55720 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdKEQ0g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id y83so9768737wmc.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:36 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index f0f7a5b69..a418bf897 100644
--- a/Makefile
+++ b/Makefile
@@ -167,31 +167,11 @@ QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
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
-compile_OBJS := compile-i386.o
