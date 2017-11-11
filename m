From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 18/38] build: only generate version.h when needed
Date: Sat, 11 Nov 2017 15:24:17 +0100
Message-ID: <20171111142437.67359-19-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40201 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdKKOZV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id b189so742411wmd.5
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:20 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

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
index 975b5e72d..ce57ed3cb 100644
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
 
 
@@ -199,6 +191,18 @@ cflags   += $($(*)-cflags) $(CPPFLAGS) $(CFLAGS)
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

