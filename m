From: Dan McGee <dan@archlinux.org>
Subject: [PATCH] Makefile: fix permissions mixup on install
Date: Tue, 27 Oct 2009 19:46:08 -0500
Message-ID: <1256690768-2577-1-git-send-email-dan@archlinux.org>
References: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:39835 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756995AbZJ1AqJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Oct 2009 20:46:09 -0400
Received: by gxk4 with SMTP id 4so334606gxk.8
        for <linux-sparse@vger.kernel.org>; Tue, 27 Oct 2009 17:46:13 -0700 (PDT)
In-Reply-To: <449c10960910271737s4acf67dfsf29daf25fed9b53b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dan McGee <dan@archlinux.org>

`install` by default uses 755 permissions; for everything but executables we
want to use 644 permissions.

Signed-off-by: Dan McGee <dan@archlinux.org>
---
 Makefile |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 571673e..f6b0d2c 100644
--- a/Makefile
+++ b/Makefile
@@ -79,9 +79,12 @@ QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
 QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
 
-define INSTALL_CMD
+define INSTALL_PROG
 	$(Q)$(QUIET_INST_SH)install -v $1 $(DESTDIR)$2/$1 || exit 1;
+endef
 
+define INSTALL_OTHER
+	$(Q)$(QUIET_INST_SH)install -v -m 644 $1 $(DESTDIR)$2/$1 || exit 1;
 endef
 
 SED_PC_CMD = 's|@version@|$(VERSION)|g;		\
@@ -103,11 +106,11 @@ install: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc
 	$(Q)install -d $(DESTDIR)$(MAN1DIR)
 	$(Q)install -d $(DESTDIR)$(INCLUDEDIR)/sparse
 	$(Q)install -d $(DESTDIR)$(PKGCONFIGDIR)
-	$(foreach f,$(INST_PROGRAMS),$(call INSTALL_CMD,$f,$(BINDIR)))
-	$(foreach f,$(INST_MAN1),$(call INSTALL_CMD,$f,$(MAN1DIR)))
-	$(foreach f,$(LIBS),$(call INSTALL_CMD,$f,$(LIBDIR)))
-	$(foreach f,$(LIB_H),$(call INSTALL_CMD,$f,$(INCLUDEDIR)/sparse))
-	$(call INSTALL_CMD,sparse.pc,$(PKGCONFIGDIR))
+	$(foreach f,$(INST_PROGRAMS),$(call INSTALL_PROG,$f,$(BINDIR)))
+	$(foreach f,$(INST_MAN1),$(call INSTALL_OTHER,$f,$(MAN1DIR)))
+	$(foreach f,$(LIBS),$(call INSTALL_OTHER,$f,$(LIBDIR)))
+	$(foreach f,$(LIB_H),$(call INSTALL_OTHER,$f,$(INCLUDEDIR)/sparse))
+	$(call INSTALL_OTHER,sparse.pc,$(PKGCONFIGDIR))
 
 sparse.pc: sparse.pc.in
 	$(QUIET_GEN)sed $(SED_PC_CMD) sparse.pc.in > sparse.pc
-- 
1.6.5.1

