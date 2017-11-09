From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 37/37] build: add rule to run a single test
Date: Thu,  9 Nov 2017 07:46:48 +0100
Message-ID: <20171109064648.15379-38-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45425 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdKIGsB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:48:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so14733484wmd.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:48:01 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index d7bcbf465..cf04ec61d 100644
--- a/Makefile
+++ b/Makefile
@@ -207,6 +207,8 @@ version.h: FORCE
 
 check: all
 	$(Q)cd validation && ./test-suite
+validation/%.t: FORCE
+	@validation/test-suite single $*.c
 
 
 clean: clean-check
-- 
2.14.0

