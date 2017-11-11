From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 29/38] build: remove unused QUIET_INST_SH
Date: Sat, 11 Nov 2017 15:24:28 +0100
Message-ID: <20171111142437.67359-30-luc.vanoostenryck@gmail.com>
References: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33727 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdKKOZn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 09:25:43 -0500
Received: by mail-wm0-f67.google.com with SMTP id r68so8900390wmr.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 06:25:42 -0800 (PST)
In-Reply-To: <20171111142437.67359-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Jeff Layton <jlayton@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index afb76a994..38ae80f8b 100644
--- a/Makefile
+++ b/Makefile
@@ -165,7 +165,6 @@ QUIET_AR      = $(Q:@=@echo    '     AR       '$@;)
 QUIET_GEN     = $(Q:@=@echo    '     GEN      '$@;)
 QUIET_LINK    = $(Q:@=@echo    '     LINK     '$@;)
 # We rely on the -v switch of install to print 'file -> $install_dir/file'
-QUIET_INST_SH = $(Q:@=echo -n  '     INSTALL  ';)
 QUIET_INST    = $(Q:@=@echo -n '     INSTALL  ';)
 
 
-- 
2.14.0

