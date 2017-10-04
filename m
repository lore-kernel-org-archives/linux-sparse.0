From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 3/6] build: drop BASIC_CFLAGS and ALL_CFLAGS
Date: Wed,  4 Oct 2017 15:26:02 +0200
Message-ID: <20171004132605.24734-4-uwe@kleine-koenig.org>
References: <20171004132605.24734-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:54539 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752619AbdJDN0O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Oct 2017 09:26:14 -0400
In-Reply-To: <20171004132605.24734-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

There is no good reason to not use plain CFLAGS for all usages.
This simplifies understanding the Makefile for the casual reader.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 Makefile | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index ddb4c5e3de02..069dae6c8fdb 100644
--- a/Makefile
+++ b/Makefile
@@ -21,8 +21,6 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS =
 
-ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
-
 HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
@@ -39,13 +37,13 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
+CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
-BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
 ifeq ($(HAVE_GCC_DEP),yes)
-BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
+CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
 DESTDIR=
@@ -96,7 +94,7 @@ LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
-sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
+sparse-llvm.o: CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
@@ -122,7 +120,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
 
-# If you add $(SLIB_FILE) to this, you also need to add -fpic to BASIC_CFLAGS above.
+# If you add $(SLIB_FILE) to this, you also need to add -fpic to CFLAGS above.
 # Doing so incurs a noticeable performance hit, and Sparse does not have a
 # stable shared library interface, so this does not occur by default.  If you
 # really want a shared library, you may want to build Sparse twice: once
@@ -212,10 +210,10 @@ c2xml.o c2xml.sc: CFLAGS += $(LIBXML_CFLAGS)
 pre-process.sc: CHECKER_FLAGS += -Wno-vla
 
 %.o: %.c $(LIB_H)
-	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $@ -c $(CFLAGS) $<
 
 %.sc: %.c sparse
-	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<
+	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(CFLAGS) $<
 
 ALL_OBJS :=  $(LIB_OBJS) $(foreach p,$(PROGRAMS),$(p).o $($(p)_EXTRA_DEPS))
 selfcheck: $(ALL_OBJS:.o=.sc)
-- 
2.14.2

