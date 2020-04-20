From: Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH] build: fix LLVM version detection
Date: Mon, 20 Apr 2020 16:53:52 +0100
Message-ID: <20200420155352.11364-1-quentin@isovalent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725875AbgDTPyU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Apr 2020 11:54:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74404C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 20 Apr 2020 08:54:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k13so11618614wrw.7
        for <linux-sparse@vger.kernel.org>; Mon, 20 Apr 2020 08:54:20 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Quentin Monnet <quentin@isovalent.com>

The regex match used for detecting the LLVM version works for versions
with a single-digit major number. Now that LLVM v10 is out, detection
can fail, resulting in sparse-llvm not being built.

Fix detection by extracting the major version number to compare with the
minimum supported.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 85d15edca948..e93cfd66d0c9 100644
--- a/Makefile
+++ b/Makefile
@@ -183,7 +183,8 @@ arch := x32
 endif
 ifneq ($(filter ${arch},i386 i486 i586 i686 x86_64 amd64),)
 LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
-ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
+LLVM_VERSION_MAJOR:=$(firstword $(subst ., ,$(LLVM_VERSION)))
+ifeq ($(shell expr "$(LLVM_VERSION_MAJOR)" '>=' 3),1)
 LLVM_PROGS := sparse-llvm
 $(LLVM_PROGS): LD := g++
 LLVM_LDFLAGS := $(shell $(LLVM_CONFIG) --ldflags)
-- 
2.20.1
