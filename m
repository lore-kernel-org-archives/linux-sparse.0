From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] unssa: do not try to update liveness
Date: Thu,  1 Dec 2016 16:07:01 +0100
Message-ID: <20161201150705.31590-2-luc.vanoostenryck@gmail.com>
References: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33928 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932322AbcLAPHV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Dec 2016 10:07:21 -0500
Received: by mail-wj0-f195.google.com with SMTP id xy5so26733111wjc.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Dec 2016 07:07:20 -0800 (PST)
In-Reply-To: <20161201150705.31590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The unSSA step used to try to maintain the liveness info
while creating the copies but this can't be done so simply
(what is updated is only the liveness for the current bb
while it needs to be done for all concerned bbs).

If/when liveness is needed after this step, it need to be
redone by calling track_pseudo_liveness().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 unssa.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/unssa.c b/unssa.c
index 382095d7..85b1388d 100644
--- a/unssa.c
+++ b/unssa.c
@@ -49,9 +49,6 @@ static void replace_phi_node(struct instruction *phi)
 	tmp->ident = phi->target->ident;
 	tmp->def = NULL;		// defined by all the phisrc
 	
-	// update the current liveness
-	remove_pseudo(&phi->bb->needs, phi->target);
-	add_pseudo(&phi->bb->needs, tmp);
 	track_phi_uses(phi);
 
 	phi->opcode = OP_COPY;
-- 
2.10.2

