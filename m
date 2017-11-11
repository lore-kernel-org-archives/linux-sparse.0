From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 11/38] build: allow CFLAGS & friends from command line
Date: Sat, 11 Nov 2017 15:24:10 +0100
Message-ID: <20171111142437.67359-12-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54545 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdKKOZL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id r68so7597870wmr.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:10 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

This allow distros or devs to override the default CFLAGS,
CPPFLAGS, LDFLAGS, ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 4da421de1..8a06b75a5 100644
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

