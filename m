From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/8] remove test on initial phi->ident
Date: Thu, 13 Apr 2017 18:55:46 +0200
Message-ID: <20170413165551.2785-4-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36731 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753970AbdDMQ4C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id q125so13647842wmd.3
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:02 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The code used to be like:
 	pseudo_t phi = alloc_phi(...);
	phi->ident = phi->ident ? : ...
but this new allocated phi can never have an identifier.

Change this by removing the test and directly assigning the
other part of the conditional.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index 25a5bffbe..aa7a6586f 100644
--- a/flow.c
+++ b/flow.c
@@ -412,7 +412,7 @@ void add_dominator(struct pseudo_list **phi_list, struct instruction *insn,
 	struct basic_block *bb = dom->bb;
 	struct instruction *br = delete_last_instruction(&bb->insns);
 	pseudo_t phi = alloc_phi(bb, dom->target, dom->type);
-	phi->ident = phi->ident ? : ident ? : dom->target->ident;
+	phi->ident = ident ? : dom->target->ident;
 	add_instruction(&bb->insns, br);
 	use_pseudo(insn, phi, add_pseudo(phi_list, phi));
 }
-- 
2.12.0

