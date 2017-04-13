From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] check duplicated phi-nodes directly on dominators
Date: Thu, 13 Apr 2017 18:55:50 +0200
Message-ID: <20170413165551.2785-8-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34490 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754121AbdDMQ4F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so9431649wrc.1
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:04 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that add_load_dominators() is integrated into
rewrite_load_instruction() we can check for duplicated
phi sources directly in the dominators list instead
to have to check the corresponding phi sources.

This is a preparatory step for the next patch where
unneeded phi sources are not created anymore.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/flow.c b/flow.c
index b64a3f74a..d705abe2e 100644
--- a/flow.c
+++ b/flow.c
@@ -439,6 +439,7 @@ void rewrite_load_instruction(struct instruction *insn, struct instruction_list
 	struct ident *ident)
 {
 	struct pseudo_list *dominators;
+	struct instruction *dom;
 	pseudo_t new, phi;
 
 	dominators = add_load_dominators(insn, doms, ident);
@@ -447,12 +448,12 @@ void rewrite_load_instruction(struct instruction *insn, struct instruction_list
 	 * Check for somewhat common case of duplicate
 	 * phi nodes.
 	 */
-	new = first_pseudo(dominators)->def->src1;
-	FOR_EACH_PTR(dominators, phi) {
-		if (new != phi->def->src1)
+	new = first_instruction(doms)->target;
+	FOR_EACH_PTR(doms, dom) {
+		if (new != dom->target)
 			goto complex_phi;
-		new->ident = new->ident ? : phi->ident;
-	} END_FOR_EACH_PTR(phi);
+		new->ident = new->ident ? : ident ? : dom->target->ident;
+	} END_FOR_EACH_PTR(dom);
 
 	/*
 	 * All the same pseudo - mark the phi-nodes unused
-- 
2.12.0

