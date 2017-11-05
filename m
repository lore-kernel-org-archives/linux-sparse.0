From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 22/36] build: move clean & clean-check together
Date: Sun,  5 Nov 2017 17:25:30 +0100
Message-ID: <20171105162544.72960-22-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:48329 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdKEQ0X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id p75so9516895wmg.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:23 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 23c334132..bc161fd7f 100644
--- a/Makefile
+++ b/Makefile
@@ -206,9 +206,6 @@ version.h: FORCE
 	fi
 
 
-clean: clean-check
-	rm -f *.[oa] .*.d $(PROGRAMS) $(SLIB_FILE) version.h
