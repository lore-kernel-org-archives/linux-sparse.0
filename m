From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 05/10] Makefile: suppress error message from shell
Date: Mon, 04 Aug 2014 19:37:31 +0100
Message-ID: <53DFD2EB.3090204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:39253 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752156AbaHDShe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:37:34 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


In particular, on systems which do not have 'llvm-config' installed,
every invocation of make issues the following messages:

    /bin/sh: llvm-config: command not found
    make: llvm-config: Command not found

A simple solution would be to suppress these messages by redirecting
stderr to the bit-bucket within the definitions of HAVE_LLVM_VERSION
and LLVM_VERSION.

As an alternative, however, we move the definition of LLVM_VERSION
down the file within the HAVE_LLVM conditional, which ensures that
the 'llvm-config' command exists. In addition, the HAVE_LLVM_VERSION
variable is replaced with an equivalent conditional expression.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index f453ded..1795905 100644
--- a/Makefile
+++ b/Makefile
@@ -32,8 +32,6 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
 LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
-HAVE_LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
-LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
 
 GCC_BASE = $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
@@ -76,13 +74,9 @@ else
 $(warning Your system does not have libgtk2, disabling test-inspect)
 endif
 
-ifneq ($(HAVE_LLVM),yes)
-$(warning Your system does not have llvm, disabling sparse-llvm)
-else
-ifneq ($(HAVE_LLVM_VERSION),yes)
-$(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
-HAVE_LLVM=no
-else
+ifeq ($(HAVE_LLVM),yes)
+LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
+ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
@@ -92,7 +86,11 @@ PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+else
+$(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
+else
+$(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
-- 
2.0.0
