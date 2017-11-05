From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/36] build: use '_OBJS' instead of '_EXTRA_DEPS'
Date: Sun,  5 Nov 2017 17:25:16 +0100
Message-ID: <20171105162544.72960-8-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55133 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQ0B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so9818523wmr.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:00 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some programs are composed of several source files other than the
main one. These files need then to be added at linking time.
These extra file are currently specified using variables named
"<program-name>_EXTRA_DEPS" but the way these variables are used
make that they can only hold .o files (or .a ones) and are not
some kind of generic dependencie.

Make this explicit by using the suffix '_OBJS' instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index bd8a08f13..eb7154992 100644
--- a/Makefile
+++ b/Makefile
@@ -70,8 +70,8 @@ GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
 GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
-test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
+test-inspect_OBJS := test-inspect.o
+test-inspect_OBJS += ast-model.o ast-view.o ast-inspect.o
 $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
@@ -165,9 +165,9 @@ install: all-installable
 	$(foreach f,$(INST_MAN1),$(call INSTALL_FILE,$f,$(MAN1DIR)))
 
 
-compile_EXTRA_DEPS = compile-i386.o
+compile_OBJS := compile-i386.o
 
-$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
+$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS) $(LIBS)))
 $(PROGRAMS): % : %.o 
 	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
 
@@ -193,7 +193,7 @@ pre-process.sc: CHECKER_FLAGS += -Wno-vla
 %.sc: %.c sparse
 	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
 
-ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
+ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_OBJS))
 selfcheck: $(ALL_OBJS:.o=.sc)
 
 
-- 
2.14.0

