From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 30/37] build: let quiet commands use less indentation
Date: Thu,  9 Nov 2017 07:46:41 +0100
Message-ID: <20171109064648.15379-31-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53966 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdKIGrt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so15296668wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:48 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now it does the same as done in the kernel: 2 + 8.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 92b885d8a..dc9ba9cde 100644
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
 
@@ -215,7 +215,7 @@ check: all
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

