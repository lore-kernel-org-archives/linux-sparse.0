From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 12/15] give a type to OP_SELs, always
Date: Mon, 27 Mar 2017 19:34:02 +0200
Message-ID: <20170327173405.11405-13-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36498 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id u1so15369861wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:25 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, when a phi-node is converted into a OP_SEL
this instruction is given a size but not a type but when
created directly it is given a type.

For consistency and for sparse-LLVM which needs it,
give them always a type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 4b6483efa..755852454 100644
--- a/linearize.c
+++ b/linearize.c
@@ -688,7 +688,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	/* Remove the 'br' */
 	delete_last_instruction(&bb->insns);
 
-	select = alloc_instruction(OP_SEL, phi_node->size);
+	select = alloc_typed_instruction(OP_SEL, phi_node->type);
 	select->bb = bb;
 
 	assert(br->cond);
-- 
2.12.0

