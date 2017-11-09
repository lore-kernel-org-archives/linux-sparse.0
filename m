From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 28/37] build: use standard rules for install
Date: Thu,  9 Nov 2017 07:46:39 +0100
Message-ID: <20171109064648.15379-29-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGrp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:45 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so15314846wmt.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:45 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index afc1efe98..d26b294d2 100644
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
