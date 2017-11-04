From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] build: only generate version.h when needed and remove it
 in clean target
Date: Sat, 4 Nov 2017 17:54:36 +0100
Message-ID: <20171104165434.gg4e7fhu6rjfqe5s@ltop.local>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:46300 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbdKDQym (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Nov 2017 12:54:42 -0400
Received: by mail-wm0-f45.google.com with SMTP id r68so6696187wmr.1
        for <linux-sparse@vger.kernel.org>; Sat, 04 Nov 2017 09:54:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170914184540.26650-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Sep 14, 2017 at 08:45:40PM +0200, Uwe Kleine-König wrote:
> This way version.h isn't generated when running $(make clean) but only
> when lib.c is about to be compiled.

Hi,

I would like to use in my development tree the following slightly updated version.
Would you mind to give your SoB?

Regards,
-- Luc Van Oostenryck

From bebb8ee6d8a793b50d77600ddcabec5f78cc9819 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Thu, 14 Sep 2017 20:45:40 +0200
Subject: [PATCH] build: only generate version.h when needed and remove it in
 clean target

This way version.h isn't generated when running $(make clean) but only
when lib.c is about to be compiled.

This simplifies packaging for Debian because the package building programs
abort when there are additional files after $(make clean).

---
 Makefile | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index ee1334c42..1491accb0 100644
--- a/Makefile
+++ b/Makefile
@@ -1,12 +1,6 @@
 VERSION=0.5.1
 
-# Generating file version.h if current version has changed
 SPARSE_VERSION:=$(shell git describe 2>/dev/null || echo '$(VERSION)')
-VERSION_H := $(shell cat version.h 2>/dev/null)
-ifneq ($(lastword $(VERSION_H)),"$(SPARSE_VERSION)")
-$(info $(shell echo '     GEN      'version.h))
-$(shell echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h)
-endif
 
 OS = linux
 
@@ -204,6 +198,17 @@ CFLAGS += ${${*}_CFLAGS}
 selfcheck: $(OBJS:.o=.sc)
 
 
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
 	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc version.h
 
@@ -225,3 +230,5 @@ clean-check:
 	                 -o -name "*.c.error.got" \
 	                 -o -name "*.c.error.diff" \
 	                 \) -exec rm {} \;
+
+.PHONY: FORCE
-- 
2.14.0

