From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 09/63] give a type to OP_SEL, always
Date: Tue, 21 Mar 2017 01:15:13 +0100
Message-ID: <20170321001607.75169-10-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34849 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755818AbdCUAQa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so20435344wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:29 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, when a phi-node is converted into a OP_SEL
this instruction is given a size but not a type but when
created directly it is given a type.

For consistency, give it a type too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index bc2489067..5a4ba82ef 100644
--- a/linearize.c
+++ b/linearize.c
@@ -684,7 +684,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	/* Remove the 'br' */
 	delete_last_instruction(&bb->insns);
 
-	select = alloc_instruction(OP_SEL, phi_node->size);
+	select = alloc_typed_instruction(OP_SEL, phi_node->type);
 	select->bb = bb;
 
 	assert(br->cond);
-- 
2.12.0

