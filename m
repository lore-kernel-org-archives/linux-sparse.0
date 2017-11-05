From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/36] build: use '_LDLIBS' instead of '_EXTRA_OBJS'
Date: Sun,  5 Nov 2017 17:25:17 +0100
Message-ID: <20171105162544.72960-9-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55134 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKEQ0C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so9818572wmr.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:01 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some of the programs need to link with some external libraries.
For some reasons, these libraries are specified via variables named:
"<target>_EXTRA_OBJS".

Use the '_LDLIBS' prefix instead to better reflect the real use.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index eb7154992..c9cd15aba 100644
--- a/Makefile
+++ b/Makefile
@@ -59,7 +59,7 @@ INST_MAN1=sparse.1 cgcc.1
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
-c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
+c2xml_LDLIBS = `$(PKG_CONFIG) --libs libxml-2.0`
 LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
@@ -73,7 +73,7 @@ INST_PROGRAMS += test-inspect
 test-inspect_OBJS := test-inspect.o
 test-inspect_OBJS += ast-model.o ast-view.o ast-inspect.o
 $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
-test-inspect_EXTRA_OBJS := $(GTK_LIBS)
+test-inspect_LDLIBS := $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
@@ -91,7 +91,7 @@ LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm_LDLIBS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
@@ -169,7 +169,7 @@ compile_OBJS := compile-i386.o
 
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_OBJS) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_EXTRA_OBJS)
+	$(QUIET_LINK)$(LD) $(LDFLAGS) -o $@ $^ $($@_LDLIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
-- 
2.14.0

