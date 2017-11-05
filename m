From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 26/36] build: remove the dist rule since unused
Date: Sun,  5 Nov 2017 17:25:34 +0100
Message-ID: <20171105162544.72960-26-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54123 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdKEQ0a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:30 -0500
Received: by mail-wm0-f66.google.com with SMTP id r196so9830219wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:30 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The last .tar.gz was for v0.5.0 in 2014.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index b2638ae41..0aaad52b3 100644
--- a/Makefile
+++ b/Makefile
@@ -194,13 +194,6 @@ version.h: FORCE
 	fi
 
 
-dist:
-	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-		echo 'Update VERSION in the Makefile before running "make dist".' ; \
-		exit 1 ; \
-	fi
-	git archive --format=tar --prefix=sparse-$(VERSION)/ HEAD^{tree} | gzip -9 > sparse-$(VERSION).tar.gz
