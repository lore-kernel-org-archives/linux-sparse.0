From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 05/30] give a type to OP_SEL, always
Date: Sun, 19 Mar 2017 02:42:02 +0100
Message-ID: <20170319014227.8833-6-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so8916324wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:43 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, when a phi-node is converted into a OP_SEL
this instruction is given a size but not a type but when
created directly it is given a type.

For consistency, give it a type too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 6eacb2e36..4ebd6d6d8 100644
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

