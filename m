From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] show OP_PHI without VOID
Date: Wed, 22 Mar 2017 14:35:19 +0100
Message-ID: <20170322133519.94254-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33671 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdCVNms (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 09:42:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11so9807710wma.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 06:42:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

As the normal result of branch simplification OP_PHI
can have some VOID in their phi_list, sometimes lots of them.
These list can't be simplified, comacted or so because the
address of the pseudos is used for the pseudo tracking.
But it's annoying that these VOID are displayed by
show_instruction(), it make things sometimes hard to read.

Chnage this by ommiting to display them (when not verbose).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linearize.c b/linearize.c
index 5199b6b02..8d4305aea 100644
--- a/linearize.c
+++ b/linearize.c
@@ -396,6 +396,8 @@ const char *show_instruction(struct instruction *insn)
 		const char *s = " <-";
 		buf += sprintf(buf, "%s", show_pseudo(insn->target));
 		FOR_EACH_PTR(insn->phi_list, phi) {
+			if (phi == VOID && !verbose)
+				continue;
 			buf += sprintf(buf, "%s %s", s, show_pseudo(phi));
 			s = ",";
 		} END_FOR_EACH_PTR(phi);
-- 
2.12.0

