From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 33/37] build: add *.o to clean-check pattern
Date: Thu,  9 Nov 2017 07:46:44 +0100
Message-ID: <20171109064648.15379-34-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50591 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752498AbdKIGry (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id s66so14662571wmf.5
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:53 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

.o files are also created in the validation directory
(currently only tmp.o, for sparse-llvm/sparsec testing).

Aso remove them during make clean-check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index bdb6c03af..4c2012977 100644
--- a/Makefile
+++ b/Makefile
@@ -215,6 +215,7 @@ clean-check:
 	@echo "  CLEAN"
 	@find validation/ \( -name "*.c.output.*" \
 			  -o -name "*.c.error.*" \
+			  -o -name "*.o" \
 	                  \) -exec rm {} \;
 
 
-- 
2.14.0

