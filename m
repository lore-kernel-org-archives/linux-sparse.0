From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] Link binaries with system libraries needed by LLVM
Date: Thu,  2 Oct 2014 07:19:48 -0700
Message-ID: <1412259588-8542-1-git-send-email-anatol.pomozov@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f73.google.com ([209.85.218.73]:36450 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaJBOTv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 10:19:51 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so412270oif.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Oct 2014 07:19:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: dan.carpenter@oracle.com, sparse@chrisli.org, Anatol Pomozov <anatol.pomozov@gmail.com>

It is needed on Linux Arch with latest LLVM installed

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 28c4df6..25087d7 100644
--- a/Makefile
+++ b/Makefile
@@ -112,11 +112,12 @@ LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell llvm-config --ldflags)
 LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
+LLVM_SYSTEM_LIBS := $(shell llvm-config --system-libs)
 LLVM_LIBS := $(shell llvm-config --libs)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
-sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+sparse-llvm_EXTRA_OBJS := $(LLVM_SYSTEM_LIBS) $(LLVM_LIBS) $(LLVM_LDFLAGS)
 endif
 endif
 
-- 
2.1.0.rc2.206.gedb03e5

