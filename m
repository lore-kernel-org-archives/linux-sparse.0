From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 25/37] build: remove the dist rule since unused
Date: Thu,  9 Nov 2017 07:46:36 +0100
Message-ID: <20171109064648.15379-26-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56186 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdKIGrk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id b189so467783wmd.4
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:40 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
