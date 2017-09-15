From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] dump-ir: set the default optimization level to 2
Date: Fri, 15 Sep 2017 09:40:30 +0200
Message-ID: <20170915074034.7785-5-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34249 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbdIOHko (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so2023263wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:43 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib.c b/lib.c
index a78926dfd..6f8ee1e59 100644
--- a/lib.c
+++ b/lib.c
@@ -45,7 +45,9 @@
 #include "target.h"
 #include "version.h"
 
-int verbose, optimize, optimize_size, preprocessing;
+int verbose, preprocessing;
+int optimize = 2;
+int optimize_size = 0;
 int die_if_error = 0;
 int has_error = 0;
 
-- 
2.14.0

