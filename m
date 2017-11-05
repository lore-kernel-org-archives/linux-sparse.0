From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 21/36] build: no need to clean *.so and SLIB_FILE
Date: Sun,  5 Nov 2017 17:25:29 +0100
Message-ID: <20171105162544.72960-21-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:48077 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQ0W (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:22 -0500
Received: by mail-wm0-f65.google.com with SMTP id r196so9512990wmf.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:22 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a8578c305..23c334132 100644
--- a/Makefile
+++ b/Makefile
@@ -207,7 +207,7 @@ version.h: FORCE
 
 
 clean: clean-check
-	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) version.h
+	rm -f *.[oa] .*.d $(PROGRAMS) $(SLIB_FILE) version.h
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
-- 
2.14.0

