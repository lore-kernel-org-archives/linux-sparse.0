From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] give a type to OP_SEL, always
Date: Fri,  3 Mar 2017 11:18:29 +0100
Message-ID: <20170303101829.42546-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdCCK1K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 05:27:10 -0500
Received: by mail-wm0-f66.google.com with SMTP id n11so2416824wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 03 Mar 2017 02:27:06 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

Currently, when a phi-node is converted into a OP_SEL
this instruction is given a size but not a type.

There is no good reasons for that and it complicate the
further correct processing or make it impossible.

CC: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index fb4c7bd10..03248dd39 100644
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

