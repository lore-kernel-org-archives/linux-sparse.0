From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] build: let the C++ compiler be configurable
Date: Tue, 16 Jun 2020 23:10:58 +0200
Message-ID: <20200616211058.78202-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgFPVLD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 16 Jun 2020 17:11:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA83EC061573
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:11:03 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x93so260012ede.9
        for <linux-sparse@vger.kernel.org>; Tue, 16 Jun 2020 14:11:03 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

By default, the C compiler is 'gcc' but it can be overridden
on the command line via 'make CC=...'.

However, the C++ compiler (only needed for sparse-llvm) is
hardcoded to 'g++'.

Fix this by allowing to specify the C++ compiler via 'CXX=...'
but keeping 'g++' as the default.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f46654e79642..07de0bc3226e 100644
--- a/Makefile
+++ b/Makefile
@@ -6,6 +6,7 @@ OS = linux
 
 
 CC = gcc
+CXX = g++
 LD = $(CC)
 AR = ar
 
@@ -189,7 +190,7 @@ LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
 LLVM_VERSION_MAJOR:=$(firstword $(subst ., ,$(LLVM_VERSION)))
 ifeq ($(shell expr "$(LLVM_VERSION_MAJOR)" '>=' 3),1)
 LLVM_PROGS := sparse-llvm
-$(LLVM_PROGS): LD := g++
+$(LLVM_PROGS): LD := $(CXX)
 LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
 LLVM_CFLAGS := $(shell $(LLVM_CONFIG) --cppflags)
 LLVM_LIBS := $(shell $(LLVM_CONFIG) --libs)
-- 
2.27.0
