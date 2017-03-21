From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 10/63] give a type to OP_SWITCH
Date: Tue, 21 Mar 2017 01:15:14 +0100
Message-ID: <20170321001607.75169-11-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35733 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755772AbdCUAQc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so257547wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:30 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 5a4ba82ef..4eb788915 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1906,16 +1906,17 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 	struct instruction *switch_ins;
 	struct basic_block *switch_end = alloc_basic_block(ep, stmt->pos);
 	struct basic_block *active, *default_case;
+	struct expression *expr = stmt->switch_expression;
 	struct multijmp *jmp;
 	pseudo_t pseudo;
 
-	pseudo = linearize_expression(ep, stmt->switch_expression);
+	pseudo = linearize_expression(ep, expr);
 
 	active = ep->active;
 	if (!bb_reachable(active))
 		return VOID;
 
-	switch_ins = alloc_instruction(OP_SWITCH, 0);
+	switch_ins = alloc_typed_instruction(OP_SWITCH, expr->ctype);
 	use_pseudo(switch_ins, pseudo, &switch_ins->cond);
 	add_one_insn(ep, switch_ins);
 	finish_block(ep);
-- 
2.12.0

