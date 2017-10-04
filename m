From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 6/6] build: replace *_EXTRA_OBJS by local assignments to LDFLAGS and LOADLIBES
Date: Wed,  4 Oct 2017 15:26:05 +0200
Message-ID: <20171004132605.24734-7-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54542 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751997AbdJDN0R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:17 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This allows to drop the magic to handle *_EXTRA_OBJS.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f6c577c02143..50e7b99b6107 100644
--- a/Makefile
+++ b/Makefile
@@ -62,8 +62,8 @@ INST_MAN1=sparse.1 cgcc.1
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
-c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
-LIBXML_CFLAGS := $(shell $(PKG_CONFIG) --cflags libxml-2.0)
+c2xml: LOADLIBES += $(shell $(PKG_CONFIG) --libs libxml-2.0)
+c2xml: CFLAGS += $(shell $(PKG_CONFIG) --cflags libxml-2.0)
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
@@ -76,7 +76,7 @@ INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
 test-inspect_OBJS := test-inspect.o $(test-inspect_EXTRA_DEPS)
 $(test-inspect_OBJS) $(test-inspect_OBJS:.o=.sc): CFLAGS += $(GTK_CFLAGS)
-test-inspect_EXTRA_OBJS := $(GTK_LIBS)
+test-inspect: LOADLIBES += $(GTK_LIBS)
 else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
@@ -94,7 +94,8 @@ LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm: LDFLAGS += $(LLVM_LDFLAGS)
+sparse-llvm: LOADLIBES += $(LLVM_LIBS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
@@ -190,7 +191,7 @@ compile_EXTRA_DEPS = compile-i386.o
 
 $(foreach p,$(PROGRAMS),$(eval $(p): $($(p)_EXTRA_DEPS) $(LIBS)))
 $(PROGRAMS): % : %.o 
-	$(QUIET_LINK)$(LD) $(LDFLAGS) $(TARGET_ARCH) $^ $(LOADLIBES) $(LDLIBS) -o $@ $($@_EXTRA_OBJS)
+	$(QUIET_LINK)$(LD) $(LDFLAGS) $(TARGET_ARCH) $^ $(LOADLIBES) $(LDLIBS) -o $@
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
-- 
2.14.2

