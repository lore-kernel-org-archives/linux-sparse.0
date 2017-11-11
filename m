From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 25/38] build: remove the dist rule since unused
Date: Sat, 11 Nov 2017 15:24:24 +0100
Message-ID: <20171111142437.67359-26-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33718 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdKKOZe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id r68so8900104wmr.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:34 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

The last .tar.gz was for v0.5.0 in 2014.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Makefile b/Makefile
index cc8044915..6d90bfbef 100644
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
