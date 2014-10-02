From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] Link binaries with system libraries needed by LLVM
Date: Thu,  2 Oct 2014 13:09:43 -0700
Message-ID: <1412280583-9257-1-git-send-email-anatol.pomozov@gmail.com>
References: <20141002195322.GB3528@jtriplet-mobl1>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ig0-f202.google.com ([209.85.213.202]:43356 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbaJBUJw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Oct 2014 16:09:52 -0400
Received: by mail-ig0-f202.google.com with SMTP id r10so22584igi.5
        for <linux-sparse@vger.kernel.org>; Thu, 02 Oct 2014 13:09:52 -0700 (PDT)
In-Reply-To: <20141002195322.GB3528@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@joshtriplett.org, linux-sparse@vger.kernel.org, dan.carpenter@oracle.com, sparse@chrisli.org
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>

It is needed on Linux Arch with latest LLVM installed

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 28c4df6..c0ffd04 100644
--- a/Makefile
+++ b/Makefile
@@ -112,7 +112,7 @@ LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell llvm-config --ldflags)
 LLVM_CFLAGS := $(shell llvm-config --cflags | sed -e "s/-DNDEBUG//g")
-LLVM_LIBS := $(shell llvm-config --libs)
+LLVM_LIBS := $(shell llvm-config --libs --system-libs)
 PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
-- 
2.1.0.rc2.206.gedb03e5

