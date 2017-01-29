From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/8] fix crash while testing between conditional & unconditional OP_BR
Date: Sun, 29 Jan 2017 11:48:01 +0100
Message-ID: <20170129104808.2500-2-luc.vanoostenryck@gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32829 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbdA2Kst (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 05:48:49 -0500
Received: by mail-wm0-f66.google.com with SMTP id v77so8887469wmv.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 02:48:49 -0800 (PST)
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It seems that testing for a NULL insn->cond is not the right test,
what must be done is to test if either of ->bb_{true,false} is NULL.

Fixes: 556dbc8d75 ("Update usage chain for dead instructions")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index b5cd0ea77..3dea03b5e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -221,7 +221,7 @@ void kill_instruction(struct instruction *insn)
 	case OP_BR:
 		insn->bb = NULL;
 		repeat_phase |= REPEAT_CSE;
-		if (insn->cond)
+		if (insn->bb_true && insn->bb_false)
 			kill_use(&insn->cond);
 		return;
 	}
-- 
2.11.0

