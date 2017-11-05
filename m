From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/36] build: allow CFLAGS & friends from command line
Date: Sun,  5 Nov 2017 17:25:19 +0100
Message-ID: <20171105162544.72960-11-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53201 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdKEQ0E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id t139so9834127wmt.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:03 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This allow distros or devs to override the default CFLAGS,
CPPFLAGS, LDFLAGS, ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 70a4156ed..fed392c8a 100644
--- a/Makefile
+++ b/Makefile
@@ -36,13 +36,13 @@ LLVM_CONFIG:=llvm-config
 HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 
 GCC_BASE := $(shell $(CC) --print-file-name=)
-CFLAGS += -DGCC_BASE=\"$(GCC_BASE)\"
+cflags += -DGCC_BASE=\"$(GCC_BASE)\"
 
 MULTIARCH_TRIPLET := $(shell $(CC) -print-multiarch 2>/dev/null)
-CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+cflags += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
 
 ifeq ($(HAVE_GCC_DEP),yes)
-CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
+cflags += -Wp,-MD,$(@D)/.$(@F).d
 endif
 
 DESTDIR=
-- 
2.14.0

