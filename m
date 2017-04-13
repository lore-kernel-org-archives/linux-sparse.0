From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] avoid creating unneeded phi-sources
Date: Thu, 13 Apr 2017 18:55:51 +0200
Message-ID: <20170413165551.2785-9-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34984 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754073AbdDMQ4H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:07 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so9375944wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:06 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In rewrite_load_instruction(), it's tested if the dominators
are in fact all the same and if they are, as there is then no
need for a phi-node, the newly created OP_PHISRCs are killed
and the unique dominator is used in place of the phi-node.

But in this case, it's a waste to have created the OP_PHISRCs
as they are destroyed just after being created.

Fix this by basically switching the order 'creating phi sources'
and 'checking for uniqueness'. If the dominators are found to be
all the same then use this unique dominator as the loaded value
and no OP_PHISRC need to be created.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          | 17 ++++++++---------
 validation/loop-linearization.c | 30 +++++++++++++++---------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/flow.c b/flow.c
index d705abe2e..317074545 100644
--- a/flow.c
+++ b/flow.c
@@ -440,9 +440,7 @@ void rewrite_load_instruction(struct instruction *insn, struct instruction_list
 {
 	struct pseudo_list *dominators;
 	struct instruction *dom;
-	pseudo_t new, phi;
-
-	dominators = add_load_dominators(insn, doms, ident);
+	pseudo_t new;
 
 	/*
 	 * Check for somewhat common case of duplicate
@@ -456,17 +454,18 @@ void rewrite_load_instruction(struct instruction *insn, struct instruction_list
 	} END_FOR_EACH_PTR(dom);
 
 	/*
-	 * All the same pseudo - mark the phi-nodes unused
-	 * and convert the load into a LNOP and replace the
-	 * pseudo.
+	 * All the same pseudo - convert the load into a pseudo.
 	 */
-	FOR_EACH_PTR(dominators, phi) {
-		kill_instruction(phi->def);
-	} END_FOR_EACH_PTR(phi);
 	convert_load_instruction(insn, new);
 	return;
 
 complex_phi:
+	/*
+	 * Not identical pseudos - create a phisrc for each
+	 * dominators and convert the load into a phi-node.
+	 */
+	dominators = add_load_dominators(insn, doms, ident);
+
 	/* We leave symbol pseudos with a bogus usage list here */
 	if (insn->src->type != PSEUDO_SYM)
 		kill_use(&insn->src);
diff --git a/validation/loop-linearization.c b/validation/loop-linearization.c
index d53366bde..ab731dc15 100644
--- a/validation/loop-linearization.c
+++ b/validation/loop-linearization.c
@@ -39,11 +39,11 @@ static int fdo(void)
 ffor:
 .L0:
 	<entry-point>
-	phisrc.32   %phi5(i) <- $0
+	phisrc.32   %phi3(i) <- $0
 	br          .L4
 
 .L4:
-	phi.32      %r1(i) <- %phi5(i), %phi6(i)
+	phi.32      %r1(i) <- %phi3(i), %phi4(i)
 	setlt.32    %r2 <- %r1(i), $10
 	cbr         %r2, .L1, .L3
 
@@ -58,7 +58,7 @@ ffor:
 
 .L2:
 	add.32      %r7 <- %r1(i), $1
-	phisrc.32   %phi6(i) <- %r7
+	phisrc.32   %phi4(i) <- %r7
 	br          .L4
 
 .L3:
@@ -73,11 +73,11 @@ ffor:
 fwhile:
 .L8:
 	<entry-point>
-	phisrc.32   %phi11(i) <- $0
+	phisrc.32   %phi7(i) <- $0
 	br          .L12
 
 .L12:
-	phi.32      %r8(i) <- %phi11(i), %phi12(i)
+	phi.32      %r8(i) <- %phi7(i), %phi8(i)
 	setlt.32    %r9 <- %r8(i), $10
 	cbr         %r9, .L9, .L11
 
@@ -87,51 +87,51 @@ fwhile:
 	cbr         %r11, .L14, .L13
 
 .L13:
-	phisrc.32   %phi7(return) <- $0
+	phisrc.32   %phi5(return) <- $0
 	br          .L15
 
 .L14:
 	add.32      %r14 <- %r8(i), $1
-	phisrc.32   %phi12(i) <- %r14
+	phisrc.32   %phi8(i) <- %r14
 	br          .L12
 
 .L11:
-	phisrc.32   %phi8(return) <- $1
+	phisrc.32   %phi6(return) <- $1
 	br          .L15
 
 .L15:
-	phi.32      %r12 <- %phi7(return), %phi8(return)
+	phi.32      %r12 <- %phi5(return), %phi6(return)
 	ret.32      %r12
 
 
 fdo:
 .L16:
 	<entry-point>
-	phisrc.32   %phi16(i) <- $0
+	phisrc.32   %phi11(i) <- $0
 	br          .L17
 
 .L17:
-	phi.32      %r15(i) <- %phi16(i), %phi17(i)
+	phi.32      %r15(i) <- %phi11(i), %phi12(i)
 	push.32     %r15(i)
 	call.32     %r16 <- p
 	cbr         %r16, .L18, .L20
 
 .L20:
-	phisrc.32   %phi13(return) <- $0
+	phisrc.32   %phi9(return) <- $0
 	br          .L22
 
 .L18:
 	add.32      %r19 <- %r15(i), $1
 	setlt.32    %r20 <- %r15(i), $10
-	phisrc.32   %phi17(i) <- %r19
+	phisrc.32   %phi12(i) <- %r19
 	cbr         %r20, .L17, .L19
 
 .L19:
-	phisrc.32   %phi14(return) <- $1
+	phisrc.32   %phi10(return) <- $1
 	br          .L22
 
 .L22:
-	phi.32      %r17 <- %phi13(return), %phi14(return)
+	phi.32      %r17 <- %phi9(return), %phi10(return)
 	ret.32      %r17
 
 
-- 
2.12.0

