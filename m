From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] Make 'linearize_return()' helper function
Date: Sat, 27 Aug 2011 14:28:51 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1108271427540.18733@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64681 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1H0V2y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 17:28:54 -0400
Received: by pzk37 with SMTP id 37so6220437pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 14:28:54 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Aug 2011 11:43:24 -0700
Subject: [PATCH 3/3] Make 'linearize_return()' helper function

Rather than do it in that huge 'linearize_statement()' function, split
out the return generation case.  Avoids one level of indentation, and
makes for simpler and more straightforward functions.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

You'd think "return" is easily linearized, but it's actually not at all 
trivial. Inline functions and all that..

 linearize.c |   48 ++++++++++++++++++++++++++----------------------
 1 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/linearize.c b/linearize.c
index e48854755b1e..320972745d6d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1843,6 +1843,30 @@ static pseudo_t linearize_declaration(struct entrypoint *ep, struct statement *s
 	return VOID;
 }
 
+static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
+{
+	struct expression *expr = stmt->expression;
+	struct basic_block *bb_return = get_bound_block(ep, stmt->ret_target);
+	struct basic_block *active;
+	pseudo_t src = linearize_expression(ep, expr);
+	active = ep->active;
+	if (active && src != &void_pseudo) {
+		struct instruction *phi_node = first_instruction(bb_return->insns);
+		pseudo_t phi;
+		if (!phi_node) {
+			phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
+			phi_node->target = alloc_pseudo(phi_node);
+			phi_node->bb = bb_return;
+			add_instruction(&bb_return->insns, phi_node);
+		}
+		phi = alloc_phi(active, src, type_size(expr->ctype));
+		phi->ident = &return_ident;
+		use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
+	}
+	add_goto(ep, bb_return);
+	return VOID;
+}
+
 static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 {
 	struct symbol *sym;
@@ -1980,28 +2004,8 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 	case STMT_ASM:
 		return linearize_asm_statement(ep, stmt);
 
-	case STMT_RETURN: {
-		struct expression *expr = stmt->expression;
-		struct basic_block *bb_return = get_bound_block(ep, stmt->ret_target);
-		struct basic_block *active;
-		pseudo_t src = linearize_expression(ep, expr);
-		active = ep->active;
-		if (active && src != &void_pseudo) {
-			struct instruction *phi_node = first_instruction(bb_return->insns);
-			pseudo_t phi;
-			if (!phi_node) {
-				phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-				phi_node->target = alloc_pseudo(phi_node);
-				phi_node->bb = bb_return;
-				add_instruction(&bb_return->insns, phi_node);
-			}
-			phi = alloc_phi(active, src, type_size(expr->ctype));
-			phi->ident = &return_ident;
-			use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
-		}
-		add_goto(ep, bb_return);
-		return VOID;
-	}
+	case STMT_RETURN:
+		return linearize_return(ep, stmt);
 
 	case STMT_CASE: {
 		add_label(ep, stmt->case_label);
-- 
1.7.6.409.ge7a85.dirty

