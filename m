From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] remove validation/tmp.o in clean target
Date: Sun, 19 Jul 2015 11:57:49 +0200
Message-ID: <1437299869-3669-1-git-send-email-uwe@kleine-koenig.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:47421 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751496AbbGSKDU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Jul 2015 06:03:20 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

To prevent validation/tmp.o being still around after

	make check && make clean

remove it as part of the latter command.
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c7031afda00b..bc837db7c3f6 100644
--- a/Makefile
+++ b/Makefile
@@ -199,7 +199,7 @@ compat-cygwin.o: $(LIB_H)
 	$(QUIET_CC)$(CC) -o $@ -c $(ALL_CFLAGS) $<
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc validation/*.[oa]
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-- 
2.1.4

