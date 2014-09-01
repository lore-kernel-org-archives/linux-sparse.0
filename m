From: Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH] build: allow use of PKG_CONFIG to override pkg-config
Date: Mon,  1 Sep 2014 16:19:18 +0300
Message-ID: <1409577558-27828-1-git-send-email-aaro.koskinen@nsn.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:34714 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbaIANn2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 1 Sep 2014 09:43:28 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nsn.com>

Allow overriding pkg-config e.g. when cross-compiling.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index f453ded..f61aa87 100644
--- a/Makefile
+++ b/Makefile
@@ -17,6 +17,7 @@ CFLAGS += -Wall -Wwrite-strings
 LDFLAGS += -g
 LD = gcc
 AR = ar
+PKG_CONFIG = pkg-config
 
 ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #
@@ -25,11 +26,11 @@ ALL_CFLAGS = $(CFLAGS) $(BASIC_CFLAGS)
 #     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
 #
 
-HAVE_LIBXML:=$(shell pkg-config --exists libxml-2.0 2>/dev/null && echo 'yes')
+HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
 HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
-HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
+HAVE_GTK2:=$(shell $(PKG_CONFIG) --exists gtk+-2.0 2>/dev/null && echo 'yes')
 LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 HAVE_LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
@@ -59,14 +60,14 @@ INST_MAN1=sparse.1 cgcc.1
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
-c2xml_EXTRA_OBJS = `pkg-config --libs libxml-2.0`
+c2xml_EXTRA_OBJS = `$(PKG_CONFIG) --libs libxml-2.0`
 else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
 
 ifeq ($(HAVE_GTK2),yes)
-GTK2_CFLAGS := $(shell pkg-config --cflags gtk+-2.0)
-GTK2_LIBS := $(shell pkg-config --libs gtk+-2.0)
+GTK2_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-2.0)
+GTK2_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-2.0)
 PROGRAMS += test-inspect
 INST_PROGRAMS += test-inspect
 test-inspect_EXTRA_DEPS := ast-model.o ast-view.o ast-inspect.o
@@ -185,7 +186,7 @@ DEP_FILES := $(wildcard .*.o.d)
 $(if $(DEP_FILES),$(eval include $(DEP_FILES)))
 
 c2xml.o: c2xml.c $(LIB_H)
-	$(QUIET_CC)$(CC) `pkg-config --cflags libxml-2.0` -o $@ -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) `$(PKG_CONFIG) --cflags libxml-2.0` -o $@ -c $(ALL_CFLAGS) $<
 
 compat-linux.o: compat/strtold.c compat/mmap-blob.c $(LIB_H)
 compat-solaris.o: compat/mmap-blob.c $(LIB_H)
-- 
2.1.0

