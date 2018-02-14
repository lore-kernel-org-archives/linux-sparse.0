From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] IR: let OP_COMPUTEGOTO use .src instead of .target
Date: Wed, 14 Feb 2018 02:08:43 +0100
Message-ID: <20180214010843.23651-6-luc.vanoostenryck@gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45790 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBLA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:11:00 -0500
Received: by mail-wr0-f194.google.com with SMTP id h9so20408169wre.12
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:11:00 -0800 (PST)
In-Reply-To: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct instruction, .target is normally used to hold
the result. Its value is thus produced/defined by instructions.

However, OP_COMPUTEDGOTO use .target as an input. This
creates slight complications for code, like liveness analysis,
which care about which fields are used and which are defined
by the instructions.

Change this by letting OP_COMPUTEDGOTO use .src for its
operand instead of .target.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md | 2 +-
 linearize.c         | 4 ++--
 liveness.c          | 5 +----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 8f5827dfc..ef486ed5a 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -39,7 +39,7 @@ Switch / multi-branch
 
 #### OP_COMPUTEDGOTO
 Computed goto / branch to register
-- .target: target address (type is irrelevant, void*)
+- .src: address to branch to (void*)
 - .multijmp_list: list of possible destination basic blocks
 
 ### Arithmetic binops
diff --git a/linearize.c b/linearize.c
index 0fa12c36f..370c6c7d7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -399,7 +399,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 	case OP_COMPUTEDGOTO: {
 		struct multijmp *jmp;
-		buf += sprintf(buf, "%s", show_pseudo(insn->target));
+		buf += sprintf(buf, "%s", show_pseudo(insn->src));
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
 			buf += sprintf(buf, ", .L%u", jmp->target->nr);
 		} END_FOR_EACH_PTR(jmp);
@@ -2120,7 +2120,7 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
 
 		pseudo = linearize_expression(ep, expr);
 		goto_ins = alloc_instruction(OP_COMPUTEDGOTO, 0);
-		use_pseudo(goto_ins, pseudo, &goto_ins->target);
+		use_pseudo(goto_ins, pseudo, &goto_ins->src);
 		add_one_insn(ep, goto_ins);
 
 		FOR_EACH_PTR(stmt->target_list, sym) {
diff --git a/liveness.c b/liveness.c
index 0c525112b..568e2d5f2 100644
--- a/liveness.c
+++ b/liveness.c
@@ -53,6 +53,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 
 	switch (insn->opcode) {
 	case OP_RET:
+	case OP_COMPUTEDGOTO:
 		USES(src);
 		break;
 
@@ -61,10 +62,6 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
 		USES(cond);
 		break;
 
-	case OP_COMPUTEDGOTO:
-		USES(target);
-		break;
-	
 	/* Binary */
 	case OP_BINARY ... OP_BINARY_END:
 	case OP_FPCMP ... OP_FPCMP_END:
-- 
2.16.0

