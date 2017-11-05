From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 33/36] build: simpler logic for quiet commands
Date: Sun,  5 Nov 2017 17:25:41 +0100
Message-ID: <20171105162544.72960-33-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44984 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdKEQ0n (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:43 -0500
Received: by mail-wm0-f65.google.com with SMTP id n74so8118480wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:43 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index bdef09f70..7f1b9508f 100644
--- a/Makefile
+++ b/Makefile
@@ -158,13 +158,6 @@ LIBS := libsparse.a
 #
 V	      = @
 Q	      = $(V:1=)
-QUIET_CC      = $(Q:@=@echo    "  CC      $@";)
-QUIET_CHECK   = $(Q:@=@echo    "  CHECK   $<";)
-QUIET_AR      = $(Q:@=@echo    "  AR      $@";)
-QUIET_GEN     = $(Q:@=@echo    "  GEN     $@";)
-QUIET_LINK    = $(Q:@=@echo    "  LINK    $@";)
-# We rely on the -v switch of install to print 'file -> $install_dir/file'
-QUIET_INST    = $(Q:@=@echo -n "  INSTALL ";)
 
 
 compile_OBJS := compile-i386.o
@@ -175,10 +168,12 @@ ldflags += $($(@)_LDFLAGS) $(LDFLAGS)
 ldlibs  += $($(@)_LDLIBS)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS)))
 $(PROGRAMS): % : %.o $(LIBS)
-	$(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
+	@echo "  LD      $@"
+	$(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@
 
 libsparse.a: $(LIB_OBJS)
-	$(QUIET_AR)$(AR) rcs $@ $^
+	@echo "  AR      $@"
+	$(Q)$(AR) rcs $@ $^
 
 OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)_OBJS))
 DEPS := $(OBJS:%.o=.%.o.d)
@@ -188,10 +183,12 @@ DEPS := $(OBJS:%.o=.%.o.d)
 
 cflags   += $($(*)_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 %.o: %.c
-	$(QUIET_CC)$(CC) $(cflags) -c -o $@ $<
+	@echo "  CC      $@"
+	$(Q)$(CC) $(cflags) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
+	@echo "  CHECK   $<"
+	$(Q) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
 selfcheck: $(OBJS:.o=.sc)
 
@@ -225,8 +222,10 @@ install-bin: $(INST_PROGRAMS:%=$(DESTDIR)$(BINDIR)/%)
 install-man: $(INST_MAN1:%=$(DESTDIR)$(MAN1DIR)/%)
 
 $(DESTDIR)$(BINDIR)/%: %
-	$(QUIET_INST)install -v        $< $@ || exit 1;
+	@echo "  INSTALL $@"
+	$(Q)install        $< $@ || exit 1;
 $(DESTDIR)$(MAN1DIR)/%: %
-	$(QUIET_INST)install -v -m 644 $< $@ || exit 1;
+	@echo "  INSTALL $@"
+	$(Q)install -m 644 $< $@ || exit 1;
 
 .PHONY: FORCE
-- 
2.14.0

