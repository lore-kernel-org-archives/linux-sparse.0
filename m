From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: build sparse-llvm on i686s too.
Date: Wed,  6 Dec 2017 11:25:54 +0100
Message-ID: <20171206102554.12887-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38093 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755028AbdLFK0M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Dec 2017 05:26:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id 64so6151025wme.3
        for <linux-sparse@vger.kernel.org>; Wed, 06 Dec 2017 02:26:12 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In commit "f1e4ba13d (build: disable sparse-llvm on non-x86)",
we wanted to disable the build of sparse-llvm on non-x86 archs
but the pattern used also excluded machines like 'i686'.

Fix this by using the pattern 'i[3456]86' instead.

Fixes: f1e4ba13d1499407a72349b50052ae818c8d8553
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index eac6df7ed..1ae0a33f0 100644
--- a/Makefile
+++ b/Makefile
@@ -142,7 +142,7 @@ endif
 LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 ifeq ($(HAVE_LLVM),yes)
-ifeq ($(shell uname -m | grep -q '\(i386\|x86\)' && echo ok),ok)
+ifeq ($(shell uname -m | grep -q '\(i[3456]86\|x86\)' && echo ok),ok)
 LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
 ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
 LLVM_PROGS := sparse-llvm
-- 
2.15.0

