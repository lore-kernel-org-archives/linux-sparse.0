From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 5/5] unssa: update comment about the unneeded copies
Date: Mon, 12 Dec 2016 16:29:01 +0100
Message-ID: <20161212152901.24948-6-luc.vanoostenryck@gmail.com>
References: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35930 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932244AbcLLP3N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Dec 2016 10:29:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so11935366wma.3
        for <linux-sparse@vger.kernel.org>; Mon, 12 Dec 2016 07:29:12 -0800 (PST)
In-Reply-To: <20161212152901.24948-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/unssa.c b/unssa.c
index a7085ca0..e7c9154d 100644
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

