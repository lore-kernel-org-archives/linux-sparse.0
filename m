From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 02/27] give a type to OP_SEL, always
Date: Sat, 11 Mar 2017 10:06:41 +0100
Message-ID: <20170311090706.17171-3-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33045 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbdCKJHY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id n11so2314509wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:22 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, when a phi-node is converted into a OP_SEL
this instruction is given a size but not a type but when
created directly it is given a type.

There is no good reasons for that and it complicates
further correct processing or makes it impossible.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 3a9c8f2e2..9321cde21 100644
--- a/linearize.c
+++ b/linearize.c
@@ -679,7 +679,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	/* Remove the 'br' */
 	delete_last_instruction(&bb->insns);
 
-	select = alloc_instruction(OP_SEL, phi_node->size);
+	select = alloc_typed_instruction(OP_SEL, phi_node->type);
 	select->bb = bb;
 
 	assert(br->cond);
-- 
2.11.1

