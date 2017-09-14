From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] build: only generate version.h when needed and remove it in clean target
Date: Thu, 14 Sep 2017 20:45:40 +0200
Message-ID: <20170914184540.26650-1-uwe@kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:48609 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751652AbdINSpq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 Sep 2017 14:45:46 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This way version.h isn't generated when running $(make clean) but only
when lib.c is about to be compiled.

This simplifies packaging for Debian because the package building programs
abort when there are additional files after $(make clean).
---
 Makefile | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index a4653aa1b747..13b0f97f146e 100644
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
 
@@ -215,6 +209,18 @@ pre-process.sc: CHECKER_FLAGS += -Wno-vla
 %.o: %.c $(LIB_H)
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
+version.h: FORCE
+	$(QUIET_GEN)echo '#define SPARSE_VERSION "$(SPARSE_VERSION)"' > version.h.tmp; \
+	if cmp -s version.h version.h.tmp; then \
+		rm version.h.tmp; \
+	else \
+		mv version.h.tmp version.h; \
+	fi
+
+.PHONY: FORCE
+
+lib.o: version.h
+
 %.sc: %.c sparse
 	$(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<
 
@@ -223,7 +229,7 @@ selfcheck: $(ALL_OBJS:.o=.sc)
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc version.h
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-- 
2.14.1

