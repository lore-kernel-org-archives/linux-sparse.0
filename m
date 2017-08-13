From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 3/4] Makefile: rename debug/sparse as sparse-dbg during
Date: Sun, 13 Aug 2017 15:10:39 -0400
Message-ID: <CANeU7Q=cmugEO696EKuK72Fpdmr4Lt3M0EKRAhNR=qHYzf_tPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33503 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdHMTKk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:10:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id u207so5090266ywc.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:10:40 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

debug/sparse have conflict with release version of sparse
on install target.

Rename debug/sparse as sparse-dbg during install.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4c89e4c..9db6b15 100644
--- a/Makefile
+++ b/Makefile
@@ -155,10 +155,16 @@ QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)

 define INSTALL_EXEC
- $(QUIET_INST)install -v $1 $(DESTDIR)$2/$1 || exit 1;
+ $(QUIET_INST)install -v $1 $(DESTDIR)$2/$(notdir $1) || exit 1;

 endef

+define INSTALL_DBG
+ $(QUIET_INST)install -v debug/$1 $(DESTDIR)$2/$(notdir $1)-dbg || exit 1;
+
+endef
+
+
 define INSTALL_FILE
  $(QUIET_INST)install -v -m 644 $1 $(DESTDIR)$2/$1 || exit 1;

@@ -180,10 +186,12 @@ DBG_LIBS := $(DBG_LIB_FILE)
 REL_OBJS :=  $(LIB_OBJS) $(foreach @F,$(PROGRAMS),$(@F).o $(EXTRA_OBJS))
 DBG_OBJS :=  $(DBG_LIB_OBJS) $(foreach @F,$(PROGRAMS),debug/$(@F).o
$(EXTRA_OBJS))
 ALL_OBJS := $(REL_OBJS) $(DBG_OBJS)
-INST_PROGRAMS += $(PROGRAMS) $(DBG_PROGRAMS)
+ALL_PROGRAMS := $(REL_PROGRAMS) $(DBG_PROGRAMS)

+INST_PROGRAMS += $(REL_PROGRAMS) \
+ $(filter-out $(addprefix debug/,$(REL_PROGRAMS)),$(DBG_PROGRAMS))

-all: $(REL_PROGRAMS) $(DBG_PROGRAMS) sparse.pc
+all: $(ALL_PROGRAMS) sparse.pc

 all-installable: $(INST_PROGRAMS) $(LIBS) $(LIB_H) sparse.pc

@@ -194,6 +202,7 @@ install: all-installable
  $(Q)install -d $(DESTDIR)$(INCLUDEDIR)/sparse
  $(Q)install -d $(DESTDIR)$(PKGCONFIGDIR)
  $(foreach f,$(INST_PROGRAMS),$(call INSTALL_EXEC,$f,$(BINDIR)))
+ $(foreach f,$(REL_PROGRAMS),$(call INSTALL_DBG,$f,$(BINDIR)))
  $(foreach f,$(INST_MAN1),$(call INSTALL_FILE,$f,$(MAN1DIR)))
  $(foreach f,$(LIBS),$(call INSTALL_FILE,$f,$(LIBDIR)))
  $(foreach f,$(LIB_H),$(call INSTALL_FILE,$f,$(INCLUDEDIR)/sparse))
-- 
2.13.4
