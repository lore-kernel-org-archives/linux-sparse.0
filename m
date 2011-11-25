From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH] sparse, llvm: Don't fail the build if LLVM is too old
Date: Fri, 25 Nov 2011 09:06:44 +0200
Message-ID: <1322204804-6627-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45658 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1KYHHI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 02:07:08 -0500
Received: by faas1 with SMTP id s1so1937379faa.19
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2011 23:07:07 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>

Disable sparse-llvm compilation if LLVM version is too old.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 Makefile |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index e508cae..2b5976d 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,8 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
 HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
 HAVE_LLVM:=$(shell llvm-config --version >/dev/null 2>&1 && echo 'yes')
+HAVE_LLVM_VERSION:=$(shell llvm-config --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
+LLVM_VERSION=$(shell llvm-config --version)
 
 GCC_BASE = $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
@@ -65,7 +67,13 @@ else
 $(warning Your system does not have libgtk2, disabling test-inspect)
 endif
 
-ifeq ($(HAVE_LLVM),yes)
+ifneq ($(HAVE_LLVM),yes)
+$(warning Your system does not have llvm, disabling sparse-llvm)
+else
+ifneq ($(HAVE_LLVM_VERSION),yes)
+$(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
+HAVE_LLVM=no
+else
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LDFLAGS += $(shell llvm-config --ldflags)
@@ -76,8 +84,7 @@ INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm_EXTRA_DEPS := sparse-llvm.o
 sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS)
-else
-$(warning Your system does not have llvm, disabling sparse-llvm)
+endif
 endif
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
-- 
1.7.6.4

