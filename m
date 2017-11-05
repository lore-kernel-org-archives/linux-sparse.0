From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/36] build: allow target-specific CFLAGS, CPPFLAGS, LDFLAGS & LDLIBS
Date: Sun,  5 Nov 2017 17:25:18 +0100
Message-ID: <20171105162544.72960-10-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55650 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQ0D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:03 -0500
Received: by mail-wm0-f67.google.com with SMTP id y83so9767201wmc.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:02 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index c9cd15aba..70a4156ed 100644
--- a/Makefile
+++ b/Makefile
@@ -59,8 +59,8 @@ INST_MAN1=sparse.1 cgcc.1
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
-c2xml_LDLIBS = `$(PKG_CONFIG) --libs libxml-2.0`
-LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml_LDLIBS := $(shell $(PKG_CONFIG) --libs libxml-2.0)
+c2xml_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -90,8 +90,9 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
-sparse-llvm.o: CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_LDLIBS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm_CFLAGS := $(LLVM_CFLAGS)
+sparse-llvm_LDFLAGS := $(LLVM_LDFLAGS)
+sparse-llvm_LDLIBS := $(LLVM_LIBS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
@@ -167,9 +168,11 @@ install: all-installable
 
 compile_OBJS := compile-i386.o
 
+ldflags += $($(@)_LDFLAGS) $(LDFLAGS)
+ldlibs  += $($(@)_LDLIBS)  $(LDLIBS)
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_LDLIBS)
+	$(QUIET_LINK)$(LD) $(ldflags) -o $@ $^ $(ldlibs)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
@@ -183,15 +186,15 @@ ifneq ($(DEP_FILES),)
 include $(DEP_FILES)
 endif
 
-c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
+cflags   += $($(*)_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 %.o: %.c
-	$(QUIET_CC)$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
+	$(QUIET_CC)$(CC) $(cflags) -c -o $@ $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(CFLAGS) $(CPPFLAGS) -c $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) $(cflags) -c $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_OBJS))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.14.0

