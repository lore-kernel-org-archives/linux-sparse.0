From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] sparse, llvm: fix link errors
Date: Fri, 10 May 2013 17:01:24 -0400
Message-ID: <1368219684-4567-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:55595 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab3EJVCn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 May 2013 17:02:43 -0400
Received: by mail-vc0-f180.google.com with SMTP id hv10so4006761vcb.39
        for <linux-sparse@vger.kernel.org>; Fri, 10 May 2013 14:02:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>

This patch fixes the following link errors.

    libLLVMSupport.a(Signals.o): In function `llvm::sys::PrintStackTrace(_IO_FILE*)':
    Signals.inc:269: undefined reference to `dladdr'
    Signals.inc:281: undefined reference to `dladdr'

Cc: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 35e3801..4f53903 100644
--- a/Makefile
+++ b/Makefile
@@ -84,14 +84,14 @@ HAVE_LLVM=no
 else
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
-LDFLAGS += $(shell llvm-config --ldflags)
+LLVM_LDFLAGS := $(shell llvm-config --ldflags)
 LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
 LLVM_LIBS := $(shell llvm-config --libs)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm_EXTRA_DEPS := sparse-llvm.o
 sparse-llvm.o $(sparse-llvm_EXTRA_DEPS): BASIC_CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS)
+sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
 endif
 endif
 
-- 
1.8.1.2

