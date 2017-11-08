From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/9] dump-ir: set the default optimization level to 2
Date: Wed,  8 Nov 2017 11:27:57 +0100
Message-ID: <20171108102802.43987-5-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:48075 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdKHK2Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id r196so9387019wmf.2
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:16 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

