From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] unssa: update comment about the unneeded copies
Date: Thu,  1 Dec 2016 16:07:05 +0100
Message-ID: <20161201150705.31590-6-luc.vanoostenryck@gmail.com>
References: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33082 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcLAPHZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Dec 2016 10:07:25 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so26730017wjc.0
        for <linux-sparse@vger.kernel.org>; Thu, 01 Dec 2016 07:07:24 -0800 (PST)
In-Reply-To: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unssa.c b/unssa.c
index f0a1392f..4b52004c 100644
--- a/unssa.c
+++ b/unssa.c
@@ -15,10 +15,14 @@
  * as the corresponding OP_PHISOURCE.
  *
  * While very simple this method create a lot more copies that really necessary.
+ * We eliminate some of these copies but most probably most of them are still
+ * useless.
  * Ideally, "Sreedhar method III" should be used:
  * "Translating Out of Static Single Assignment Form", V. C. Sreedhar, R. D.-C. Ju,
  * D. M. Gillies and V. Santhanam.  SAS'99, Vol. 1694 of Lecture Notes in Computer
  * Science, Springer-Verlag, pp. 194-210, 1999.
+ * But for this we need precise liveness, on each %phi and not only on OP_PHI's
+ * target pseudos.
  *
  * Copyright (C) 2005 Luc Van Oostenryck
  */
-- 
2.10.2

