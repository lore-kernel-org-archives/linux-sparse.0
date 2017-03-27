From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 13/15] give a type to OP_SWITCHs
Date: Mon, 27 Mar 2017 19:34:03 +0200
Message-ID: <20170327173405.11405-14-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33240 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751430AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so15306102wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:26 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For consistency and for sparse-LLVM which needs it,
give them a type too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 755852454..574ccea94 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1917,16 +1917,17 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
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

