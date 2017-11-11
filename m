From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 31/38] build: simplify quiet commands
Date: Sat, 11 Nov 2017 15:24:30 +0100
Message-ID: <20171111142437.67359-32-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38481 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdKKOZq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:46 -0500
Received: by mail-wm0-f66.google.com with SMTP id p75so7472799wmg.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:46 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

The current mechanism for the quiet commands, what's
hiding the true command and emitting instead things like:
	CC      target.o
is, IMO, somehow unneedlessly sophisticated and this doesn't help
to understand what's happening and to adapt things when needed.

Change this by using simple 'echo' commands and make's '@' to
display the short command and hiding the long one.

Warning: There is a small change in behaviour with this:
  previously, when displaying the non-quiet commands with
  'make V=1' the quiet ones were not emitted. Now, with this
  patch, the short/quiet command is emitted in both case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 5b3cd66f9..bf2f82042 100644
--- a/Makefile
+++ b/Makefile
@@ -159,13 +159,6 @@ LIBS := libsparse.a
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
@@ -176,10 +169,12 @@ ldflags += $($(@)-ldflags) $(LDFLAGS)
 ldlibs  += $($(@)-ldlibs)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs)))
 $(PROGRAMS): % : %.o $(LIBS)
-	$(QUIET_LINK)$(LD) $(ldflags) $^ $(ldlibs) -o $@
+	@echo "  LD      $@"
+	$(Q)$(LD) $(ldflags) $^ $(ldlibs) -o $@
 
 libsparse.a: $(LIB_OBJS)
-	$(QUIET_AR)$(AR) rcs $@ $^
+	@echo "  AR      $@"
+	$(Q)$(AR) rcs $@ $^
 
 OBJS := $(LIB_OBJS) $(PROGRAMS:%=%.o) $(foreach p,$(PROGRAMS),$($(p)-objs))
 DEPS := $(OBJS:%.o=.%.o.d)
@@ -189,10 +184,12 @@ DEPS := $(OBJS:%.o=.%.o.d)
 
 cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
 %.o: %.c
-	$(QUIET_CC)$(CC) $(cflags) -c -o $@ $<
+	@echo "  CC      $@"
+	$(Q)$(CC) $(cflags) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
+	@echo "  CHECK   $<"
+	$(Q) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
 selfcheck: $(OBJS:.o=.sc)
 
@@ -234,8 +231,10 @@ install-bin: $(INST_PROGRAMS:%=$(DESTDIR)$(BINDIR)/%)
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

