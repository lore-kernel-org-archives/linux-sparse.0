From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 12/14] give a type to OP_SWITCHs
Date: Sat, 25 Mar 2017 00:14:19 +0100
Message-ID: <20170324231421.14869-13-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33079 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934140AbdCXXOl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so798124wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:40 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
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
index 3f1de1288..73599798f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1914,16 +1914,17 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
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

