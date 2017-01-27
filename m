From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix crash while testing between conditional & unconditional
 OP_BR
Date: Fri, 27 Jan 2017 12:38:18 +0100
Message-ID: <20170127113817.6p2274s44jis66og@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35793 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934345AbdA0Li5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Jan 2017 06:38:57 -0500
Received: by mail-wm0-f46.google.com with SMTP id r126so113082681wmr.0
        for <linux-sparse@vger.kernel.org>; Fri, 27 Jan 2017 03:38:56 -0800 (PST)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: sparse@chrisli.org

While testing the newly updated sparse-next I saw that a patch of mine
(3eadf3e6a "kill uses of replaced instructions") triggered an old
hidden bug.

To preserve bissectability the following patch should be applied
somewhere before the triggering one (but it will produce a small
conflict later with (dae3a1022 "cleanup kill_instruction()")
where the offending if-statement will need to be inversed.


From 8d8416cf4057627fea13ca74b2c8c7a3e3448e0e Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Fri, 27 Jan 2017 11:03:32 +0100
Subject: [PATCH] fix crash while testing between conditional & unconditional OP_BR

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
