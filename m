From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 31/36] build: remove unused QUIET_INST_SH
Date: Sun,  5 Nov 2017 17:25:39 +0100
Message-ID: <20171105162544.72960-31-luc.vanoostenryck@gmail.com>
References: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51408 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbdKEQ0j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Nov 2017 11:26:39 -0500
Received: by mail-wm0-f67.google.com with SMTP id b9so9859801wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Nov 2017 08:26:39 -0800 (PST)
In-Reply-To: <20171105162448.72907-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index a418bf897..1e3612210 100644
--- a/Makefile
+++ b/Makefile
@@ -164,7 +164,6 @@ QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
 QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
 QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
 # We rely on the -v switch of install to print 'file -> $install_dir/file'
-QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
 
 
-- 
2.14.0

