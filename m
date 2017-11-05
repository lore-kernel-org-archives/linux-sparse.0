From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 18/36] build: only generate version.h when needed
Date: Sun,  5 Nov 2017 17:25:26 +0100
Message-ID: <20171105162544.72960-18-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:49542 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdKEQ0P (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:15 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so9453259wmd.4
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:15 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Uwe Kleine-König <uwe@kleine-koenig.org>

This way version.h isn't generated when running $(make clean) but only
when lib.c is about to be compiled.

This simplifies packaging for Debian because the package building programs
abort when there are additional files after $(make clean).

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 460a261f1..ea3ce89a4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,13 +1,5 @@
 VERSION=0.5.1
 
-# Generating file version.h if current version has changed
-SPARSE_VERSION:=$(shell git describe 2>/dev/null || echo '$(VERSION)')
-VERSION_H := $(shell cat version.h 2>/dev/null)
-ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
-$(info $(shell echo '     GEN      'version.h))
-$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h)
-endif
-
 OS = linux
 
 
@@ -199,6 +191,18 @@ cflags   += $($(*)_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 selfcheck: $(OBJS:.o=.sc)
 
 
+SPARSE_VERSION:=$(shell git describe 2>/dev/null || echo '$(VERSION)')
+lib.o: version.h
+version.h: FORCE
+	@echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h.tmp
+	@if cmp -s version.h version.h.tmp; then \
+		rm version.h.tmp; \
+	else \
+		echo    '     GEN      '$@; \
+		mv version.h.tmp version.h; \
+	fi
+
+
 clean: clean-check
 	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h version.h
 
@@ -220,3 +224,5 @@ clean-check:
 	                 -o -name "*.c.error.got" \
 	                 -o -name "*.c.error.diff" \
 	                 \) -exec rm {} \;
+
+.PHONY: FORCE
-- 
2.14.0

