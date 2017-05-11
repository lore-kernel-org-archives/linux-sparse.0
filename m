From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/3] let kill_unreachable_bbs() clear REPEAT_CFG_CLEANUP
Date: Fri, 12 May 2017 00:26:20 +0200
Message-ID: <20170511222621.88420-3-luc.vanoostenryck@gmail.com>
References: <CANeU7QnpFci3ViG9dP1g5x1wPKnR=dAXCiLwnD4buD9t1NyaeA@mail.gmail.com>
 <20170511222621.88420-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34122 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756030AbdEKW0b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 18:26:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so5403315wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 15:26:30 -0700 (PDT)
In-Reply-To: <20170511222621.88420-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/flow.c b/flow.c
index 94a8ec746..09c9b8075 100644
--- a/flow.c
+++ b/flow.c
@@ -825,6 +825,8 @@ void kill_unreachable_bbs(struct entrypoint *ep)
 		DELETE_CURRENT_PTR(bb);
 	} END_FOR_EACH_PTR(bb);
 	PACK_PTR_LIST(&ep->bbs);
+
+	repeat_phase &= ~REPEAT_CFG_CLEANUP;
 }
 
 static int rewrite_parent_branch(struct basic_block *bb, struct basic_block *old, struct basic_block *new)
-- 
2.12.2

