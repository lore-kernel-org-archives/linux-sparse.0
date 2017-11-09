From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 17/37] build: move tests near their use
Date: Thu,  9 Nov 2017 07:46:28 +0100
Message-ID: <20171109064648.15379-18-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49572 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdKIGrZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so14659125wmd.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:25 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes here, just moving things around.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 79 +++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/Makefile b/Makefile
index c77a166f8..460a261f1 100644
--- a/Makefile
+++ b/Makefile
@@ -20,20 +20,33 @@ PKG_CONFIG = pkg-config
 CHECKER = ./cgcc -no-compile
 CHECKER_FLAGS = -Wno-vla
 
-HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
-HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
-		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
-		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
+DESTDIR=
+PREFIX ?= $(HOME)
+BINDIR=$(PREFIX)/bin
+MANDIR=$(PREFIX)/share/man
+MAN1DIR=$(MANDIR)/man1
 
-GTK_VERSION:=3.0
-HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo 'yes')
-ifneq ($(HAVE_GTK),yes)
-	GTK_VERSION:=2.0
-	HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo 'yes')
-endif
+# Allow users to override build settings without dirtying their trees
+# For debugging, put this in local.mk:
+#
+#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
+#
+-include local.mk
 
-LLVM_CONFIG:=llvm-config
-HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
+
+PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
+	 test-linearize example test-unssa test-dissect ctags
+INST_PROGRAMS=sparse cgcc
+INST_MAN1=sparse.1 cgcc.1
+
+LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
+	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
+	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
+	  builtin.o \
+	  stats.o \
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+
+all:
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
 cflags += -DGCC_BASE=\"$(GCC_BASE)\"
@@ -41,21 +54,16 @@ cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
 cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
+# Can we use GCC's generated dependencies?
+HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
+		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
+		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
 ifeq ($(HAVE_GCC_DEP),yes)
 cflags += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
-DESTDIR=
-PREFIX ?= $(HOME)
-BINDIR=$(PREFIX)/bin
-MANDIR=$(PREFIX)/share/man
-MAN1DIR=$(MANDIR)/man1
-
-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
-	 test-linearize example test-unssa test-dissect ctags
-INST_PROGRAMS=sparse cgcc
-INST_MAN1=sparse.1 cgcc.1
-
+# Can we use libxml (needed for c2xml)?
+HAVE_LIBXML:=$(shell $(PKG_CONFIG) --exists libxml-2.0 2>/dev/null && echo 'yes')
 ifeq ($(HAVE_LIBXML),yes)
 PROGRAMS+=c2xml
 INST_PROGRAMS+=c2xml
@@ -65,6 +73,13 @@ else
 $(warning Your system does not have libxml, disabling c2xml)
 endif
 
+# Can we use gtk (needed for test-inspect)
+GTK_VERSION:=3.0
+HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo 'yes')
+ifneq ($(HAVE_GTK),yes)
+GTK_VERSION:=2.0
+HAVE_GTK:=$(shell $(PKG_CONFIG) --exists gtk+-$(GTK_VERSION) 2>/dev/null && echo 'yes')
+endif
 ifeq ($(HAVE_GTK),yes)
 GTK_CFLAGS := $(shell $(PKG_CONFIG) --cflags gtk+-$(GTK_VERSION))
 GTK_LIBS := $(shell $(PKG_CONFIG) --libs gtk+-$(GTK_VERSION))
@@ -78,6 +93,9 @@ else
 $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
 
+# Can we use LLVM (needed for ... sparse-llvm)?
+LLVM_CONFIG:=llvm-config
+HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 ifeq ($(HAVE_LLVM),yes)
 ifeq ($(shell uname -m | grep -q '\(i386\|x86\)' && echo ok),ok)
 LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
@@ -103,14 +121,6 @@ else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
-
-LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
-	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
-	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  builtin.o \
-	  stats.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
-
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
 
@@ -147,13 +157,6 @@ define INSTALL_FILE
 endef
 
 
-# Allow users to override build settings without dirtying their trees
-# For debugging, put this in local.mk:
-#
-#     CFLAGS += -O0 -DDEBUG -g3 -gdwarf-2
-#
--include local.mk
