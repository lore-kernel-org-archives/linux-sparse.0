From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] build: remove version.h in clean target
Date: Wed, 20 Sep 2017 17:08:14 +0200
Message-ID: <20170920150814.19794-1-uwe@kleine-koenig.org>
References: <20170914184540.26650-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:51667 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751711AbdITPIU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Sep 2017 11:08:20 -0400
In-Reply-To: <20170914184540.26650-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

I think this is the inarguable part and that alone is still a
considerable improvement for me.

Best regards
Uwe

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a4653aa1b747..d0341764158e 100644
--- a/Makefile
+++ b/Makefile
@@ -223,7 +223,7 @@ selfcheck: $(ALL_OBJS:.o=.sc)
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc version.h
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-- 
2.14.1

