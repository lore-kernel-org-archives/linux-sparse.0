From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] sparse-llvm: Fix LLVM 3.5 linker errors
Date: Wed, 24 Sep 2014 14:01:01 -0700
Message-ID: <1411592461-22810-1-git-send-email-osandov@osandov.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64852 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbaIXVAL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 17:00:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id fb1so9481870pad.13
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 14:00:11 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
Cc: Alain Kalker <a.c.kalker@gmail.com>

llvm-config 3.5 no longer lists the non-LLVM libraries needed for linkage when
passed --libs. The --system-libs flag was added for this purpose. This adds
these libraries while silently doing nothing for older versions of LLVM.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index c3f3104..17bce6f 100644
--- a/Makefile
+++ b/Makefile
@@ -87,6 +87,7 @@ $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell llvm-config --ldflags)
 LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
 LLVM_LIBS := $(shell llvm-config --libs)
+LLVM_LIBS += $(shell llvm-config --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
-- 
2.1.0

