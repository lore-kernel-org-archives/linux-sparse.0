From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] build: disable sparse-llvm on non-x86
Date: Sun, 10 Sep 2017 03:56:22 +0200
Message-ID: <20170910015622.42436-1-luc.vanoostenryck@gmail.com>
References: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:44283 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750788AbdIJB4b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 9 Sep 2017 21:56:31 -0400
Received: by mail-wm0-f45.google.com with SMTP id 137so13894770wmj.1
        for <linux-sparse@vger.kernel.org>; Sat, 09 Sep 2017 18:56:30 -0700 (PDT)
In-Reply-To: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Antoine Beaupre <anarcat@debian.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse-llvm doesn't have support for targets other than
x86 or x86-64.

Disable sparse-llvm on other archs as it create problems during
build, selftest, ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 84bb133da..d51b60733 100644
--- a/Makefile
+++ b/Makefile
@@ -90,6 +90,7 @@ $(warning Your system does not have gtk3/gtk2, disabling test-inspect)
 endif
 
 ifeq ($(HAVE_LLVM),yes)
+ifeq ($(shell uname -m | grep -q '\(i386\|x86\)' && echo ok),ok)
 LLVM_VERSION:=$(shell $(LLVM_CONFIG) --version)
 ifeq ($(shell expr "$(LLVM_VERSION)" : '[3-9]\.'),2)
 LLVM_PROGS := sparse-llvm
@@ -106,6 +107,9 @@ else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
 else
+$(warning sparse-llvm disabled on $(shell uname -m))
+endif
+else
 $(warning Your system does not have llvm, disabling sparse-llvm)
 endif
 
-- 
2.14.0

