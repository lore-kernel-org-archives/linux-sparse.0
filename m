From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 45/48] mem2reg: update copyright
Date: Wed, 23 Aug 2017 22:15:51 +0200
Message-ID: <20170823201554.90551-46-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35023 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id x79so650537wma.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:30 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mem2reg.c b/mem2reg.c
index 493274df5..d31cd4121 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -2,6 +2,7 @@
  * mem2reg - promote memory accesses to registers.
  *
  * Copyright (C) 2004 Linus Torvalds
+ * Copyright (C) 2017 Luc Van Oostenryck
  */
 
 #include "linearize.h"
-- 
2.14.0

