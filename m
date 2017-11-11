From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 08/38] build: use '-objs' instead of '_EXTRA_DEPS'
Date: Sat, 11 Nov 2017 15:24:07 +0100
Message-ID: <20171111142437.67359-9-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33688 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdKKOZF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:05 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so8899243wmr.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:05 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Some programs are composed of several source files other than the
main one. These files need then to be added at linking time.
These extra file are currently specified using variables named
"<program-name>_EXTRA_DEPS" but the way these variables are used
make that they can only hold .o files (or .a ones) and are not
some kind of generic dependencie.

Make this explicit by using the suffix '-objs' instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index bd8a08f13..fa86c09a1 100644
--- a/Makefile
+++ b/Makefile
@@ -70,9 +70,9 @@ GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
 GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
-test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
-test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
-$(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
+test-inspect-objs := test-inspect.o
+test-inspect-objs += ast-model.o ast-view.o ast-inspect.o
+$(test-inspect-objs) $(test-inspect-objs:.o=.sc): CFLAGS += $(GTK_CFLAGS)
 test-inspect_EXTRA_OBJS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
@@ -165,9 +165,9 @@ install: all-installable
 	$(foreach f,$(INST_MAN1),$(call INSTALL_FILE,$f,$(MAN1DIR)))
 
 
-compile_EXTRA_DEPS = compile-i386.o
+compile-objs:= compile-i386.o
 
-$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
+$(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs) $(LIBS)))
 $(PROGRAMS): % : %.o 
 	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
 
@@ -193,7 +193,7 @@ pre-process.sc: CHECKER_FLAGS += -Wno-vla
 %.sc: %.c sparse
 	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
 
-ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
+ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)-objs))
 selfcheck: $(ALL_OBJS:.o=.sc)
 
 
-- 
2.14.0

