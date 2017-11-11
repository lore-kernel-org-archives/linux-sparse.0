From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 30/38] build: let quiet commands use less indentation
Date: Sat, 11 Nov 2017 15:24:29 +0100
Message-ID: <20171111142437.67359-31-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdKKOZo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id y80so7435103wmd.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:44 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Now it does the same as done in the kernel: 2 + 8.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 38ae80f8b..5b3cd66f9 100644
--- a/Makefile
+++ b/Makefile
@@ -159,13 +159,13 @@ LIBS := libsparse.a
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
@@ -204,7 +204,7 @@ version.h: FORCE
 	@if cmp -s version.h version.h.tmp; then \
 		rm version.h.tmp; \
 	else \
-		echo    '     GEN      '$@; \
+		echo "  GEN     $@"; \
 		mv version.h.tmp version.h; \
 	fi
 
@@ -216,7 +216,7 @@ check: all
 clean: clean-check
 	@rm -f *.[oa] .*.d $(PROGRAMS) version.h
 clean-check:
-	@echo '     CLEAN'
+	@echo "  CLEAN"
 	@find validation/ \( -name "*.c.output.expected" \
 	                 -o -name "*.c.output.got" \
 	                 -o -name "*.c.output.diff" \
-- 
2.14.0

