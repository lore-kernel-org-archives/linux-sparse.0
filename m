From: garritfra <garritfranke@gmail.com>
Subject: [PATCH] ir-validate: remove orphan comments
Date: Thu, 18 Jun 2020 16:09:14 +0200
Message-ID: <20200618140913.25321-1-garritfranke@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgFROJ6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 18 Jun 2020 10:09:58 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8810C0613ED
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 07:09:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so6585521ejb.4
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2020 07:09:55 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc: garritfra <garritfranke@gmail.com>

Please let me know if these comments have a right to be there, but I
think they are orphans and can be removed.

Signed-off-by: Garrit Franke <garritfranke@gmail.com>
---
 optimize.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/optimize.c b/optimize.c
index e8cb7fc3..31d94e61 100644
--- a/optimize.c
+++ b/optimize.c
@@ -75,7 +75,6 @@ repeat:
 	 */
 	do {
 		simplify_memops(ep);
-		//ir_validate(ep);
 		do {
 			repeat_phase = 0;
 			clean_up_insns(ep);
@@ -86,15 +85,11 @@ repeat:
 
 			if (repeat_phase & REPEAT_SYMBOL_CLEANUP)
 				simplify_memops(ep);
-			//ir_validate(ep);
 		} while (repeat_phase);
 		pack_basic_blocks(ep);
-		//ir_validate(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
 			kill_unreachable_bbs(ep);
-		//ir_validate(ep);
 	} while (repeat_phase);
-	//ir_validate(ep);
 
 	vrfy_flow(ep);
 
@@ -111,13 +106,11 @@ repeat:
 	 * again
 	 */
 	if (simplify_flow(ep)) {
-		//ir_validate(ep);
 		clear_liveness(ep);
 		if (repeat_phase & REPEAT_CFG_CLEANUP)
 			kill_unreachable_bbs(ep);
 		goto repeat;
 	}
-	//ir_validate(ep);
 
 	/* Finally, add deathnotes to pseudos now that we have them */
 	if (dbg_dead)
-- 
2.25.1
