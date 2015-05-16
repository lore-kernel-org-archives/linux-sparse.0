From: Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH] build: drop -ON (optimization level) from llvm flags
Date: Sun, 17 May 2015 01:34:27 +0300
Message-ID: <1431815667-22623-1-git-send-email-a3at.mail@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:33602 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbbEPWee (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 May 2015 18:34:34 -0400
Received: by lagr1 with SMTP id r1so88924573lag.0
        for <linux-sparse@vger.kernel.org>; Sat, 16 May 2015 15:34:32 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse ML <linux-sparse@vger.kernel.org>
Cc: Azat Khuzhin <a3at.mail@gmail.com>

This will make debugging easier (via overriding flags in local.mk)
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c7031af..269b1eb 100644
--- a/Makefile
+++ b/Makefile
@@ -84,7 +84,7 @@ ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
-LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags | sed -e "s/-DNDEBUG//g")
+LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cflags | sed -e "s/-DNDEBUG//g" -e 's/-O[0-9]//g')
 LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
 LLVM_LIBS += $(shell $(LLVM_CONFIG) --system-libs 2>/dev/null)
 PROGRAMS += $(LLVM_PROGS)
-- 
2.1.4

