From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 10/38] build: allow target-specific CFLAGS, CPPFLAGS, LDFLAGS & LDLIBS
Date: Sat, 11 Nov 2017 15:24:09 +0100
Message-ID: <20171111142437.67359-11-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39433 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdKKOZJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id l8so2035044wmg.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:09 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

This a preparatory step to allow these flags to be overriden
from the command line.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index ba0cb2093..4da421de1 100644
--- a/Makefile
+++ b/Makefile
@@ -59,8 +59,8 @@ INST_MAN1=sparse.1 cgcc.1
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
-c2xml-ldlibs = `$(PKG_CONFIG) --libs libxml-2.0`
-LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml-ldlibs := $(shell $(PKG_CONFIG) --libs libxml-2.0)
+c2xml-cflags := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -90,8 +90,9 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
-sparse-llvm.o: CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm-ldlibs := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm-cflags := $(LLVM_CFLAGS)
+sparse-llvm-ldflags := $(LLVM_LDFLAGS)
+sparse-llvm-ldlibs := $(LLVM_LIBS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
@@ -167,9 +168,11 @@ install: all-installable
 
 compile-objs:= compile-i386.o
 
+ldflags += $($(@)-ldflags) $(LDFLAGS)
+ldlibs  += $($(@)-ldlibs)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)-objs) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@-ldlibs)
+	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
@@ -183,15 +186,15 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
+cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
 %.o: %.c
-	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
+	$(QUIET_CC)$(CC) $(cflags) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)-objs))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.14.0

