From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 29/37] build: remove unused QUIET_INST_SH
Date: Thu,  9 Nov 2017 07:46:40 +0100
Message-ID: <20171109064648.15379-30-luc.vanoostenryck@gmail.com>
References: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32843 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdKIGrq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 01:47:46 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so983963wmr.0
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 22:47:46 -0800 (PST)
In-Reply-To: <20171109064648.15379-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Josh Triplett <josh@joshtriplett.org>, Jeff Layton <jlayton@redhat.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index d26b294d2..92b885d8a 100644
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

