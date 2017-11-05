From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 32/36] build: let quiet commands use less indentation
Date: Sun,  5 Nov 2017 17:25:40 +0100
Message-ID: <20171105162544.72960-32-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46316 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdKEQ0l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so9537822wmr.1
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:41 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now it does the same as done in the kernel: 2 + 8.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 1e3612210..bdef09f70 100644
--- a/Makefile
+++ b/Makefile
@@ -158,13 +158,13 @@ LIBS := libsparse.a
 #
 V	      = @
 Q	      = $(V:1=)
-QUIET_CC      = $(Q:@=@echo    '     CC       '$@;)
-QUIET_CHECK   = $(Q:@=@echo    '     CHECK    '$<;)
-QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
-QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
-QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
+QUIET_CC      = $(Q:@=@echo    "  CC      $@";)
+QUIET_CHECK   = $(Q:@=@echo    "  CHECK   $<";)
+QUIET_AR      = $(Q:@=@echo    "  AR      $@";)
+QUIET_GEN     = $(Q:@=@echo    "  GEN     $@";)
+QUIET_LINK    = $(Q:@=@echo    "  LINK    $@";)
 # We rely on the -v switch of install to print 'file -> $install_dir/file'
-QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
+QUIET_INST    = $(Q:@=@echo -n "  INSTALL ";)
 
 
 compile_OBJS := compile-i386.o
@@ -203,7 +203,7 @@ version.h: FORCE
 	@if cmp -s version.h version.h.tmp; then \
 		rm version.h.tmp; \
 	else \
-		echo    '     GEN      '$@; \
+		echo "  GEN     $@"; \
 		mv version.h.tmp version.h; \
 	fi
 
@@ -213,7 +213,7 @@ check: all
 
 
 clean: FORCE
-	@echo '     CLEAN'
+	@echo "  CLEAN"
 	@git clean -q -d -x -e .sparse.mk -e '*.[ch]'
 
 
-- 
2.14.0

