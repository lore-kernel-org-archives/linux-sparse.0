From: Cody P Schafer <cody@linux.vnet.ibm.com>
Subject: [PATCH] build: allow use of LLVM_CONFIG to override llvm-config config script
Date: Tue, 15 Apr 2014 10:22:49 -0700
Message-ID: <1397582569-7043-1-git-send-email-cody@linux.vnet.ibm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:38985 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbaDORXF (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Apr 2014 13:23:05 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <cody@linux.vnet.ibm.com>;
	Tue, 15 Apr 2014 13:23:04 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A3F4238C801C
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 13:23:01 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3FHN1Sw9896254
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 17:23:01 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3FHN1o3027421
	for <linux-sparse@vger.kernel.org>; Tue, 15 Apr 2014 13:23:01 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>

On systems like ubuntu 12.04, llvm-config is llvm 2.9, but
llvm-config-3.0 and llvm-config-3.3 (for example) are versions 3.0 and
3.3 respectively. Allow overriding the name/path of the llvm-config
script so people can use these versioned config scripts

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index c3f3104..bbdc088 100644
--- a/Makefile
+++ b/Makefile
@@ -30,9 +30,10 @@ HAVE_GCC_DEP:=$(shell touch .gcc-test.c && 				\
 		$(CC) -c -Wp,-MD,.gcc-test.d .gcc-test.c 2>/dev/null && \
 		echo 'yes'; rm -f .gcc-test.d .gcc-test.o .gcc-test.c)
 HAVE_GTK2:=$(shell pkg-config --exists gtk+-2.0 2>/dev/null && echo 'yes')
-HAVE_LLVM:=$(shell llvm-config --version >/dev/null 2>&1 && echo 'yes')
-HAVE_LLVM_VERSION:=$(shell llvm-config --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
-LLVM_VERSION=$(shell llvm-config --version)
+LLVM_CONFIG=llvm-config
+HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
+HAVE_LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version | grep "^[3-9].*" >/dev/null 2>&1 && echo yes)
+LLVM_VERSION=$(shell $(LLVM_CONFIG) --version)
 
 GCC_BASE = $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
@@ -84,9 +85,9 @@ HAVE_LLVM=no
 else
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
-LLVM_LDFLAGS := $(shell llvm-config --ldflags)
-LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
-LLVM_LIBS := $(shell llvm-config --libs)
+LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
+LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags | sed -e "s/-DNDEBUG//g")
+LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
-- 
1.9.2

