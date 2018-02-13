From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 09/10] let kill_instruction() report if changes were made
Date: Tue, 13 Feb 2018 22:58:11 +0100
Message-ID: <20180213215812.18735-10-luc.vanoostenryck@gmail.com>
References: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53641 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965865AbeBMWAa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 17:00:30 -0500
Received: by mail-wm0-f65.google.com with SMTP id t74so18809143wme.3
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 14:00:30 -0800 (PST)
In-Reply-To: <20180213215812.18735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This let us take others actions if no changes have been made
and allow simpler call to this function since its effect on
'repeat_phase' can be directly returned.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.h     | 10 +++++-----
 simplify.c | 17 ++++++++---------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/flow.h b/flow.h
index 6743db1ee..8e96f62fb 100644
--- a/flow.h
+++ b/flow.h
@@ -26,14 +26,14 @@ extern void kill_bb(struct basic_block *);
 extern void kill_use(pseudo_t *);
 extern void kill_unreachable_bbs(struct entrypoint *ep);
 
-extern void kill_insn(struct instruction *, int force);
-static inline void kill_instruction(struct instruction *insn)
+extern int kill_insn(struct instruction *, int force);
+static inline int kill_instruction(struct instruction *insn)
 {
-	kill_insn(insn, 0);
+	return kill_insn(insn, 0);
 }
-static inline void kill_instruction_force(struct instruction *insn)
+static inline int kill_instruction_force(struct instruction *insn)
 {
-	kill_insn(insn, 1);
+	return kill_insn(insn, 1);
 }
 
 void check_access(struct instruction *insn);
diff --git a/simplify.c b/simplify.c
index 5a90b9c6a..f0dc69ff9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -221,10 +221,10 @@ static void kill_use_list(struct pseudo_list *list)
  * the function does that unconditionally (must only be used
  * for unreachable instructions.
  */
-void kill_insn(struct instruction *insn, int force)
+int kill_insn(struct instruction *insn, int force)
 {
 	if (!insn || !insn->bb)
-		return;
+		return 0;
 
 	switch (insn->opcode) {
 	case OP_SEL:
@@ -266,9 +266,9 @@ void kill_insn(struct instruction *insn, int force)
 		if (!force) {
 			/* a "pure" function can be killed too */
 			if (!(insn->func->type == PSEUDO_SYM))
-				return;
+				return 0;
 			if (!(insn->func->sym->ctype.modifiers & MOD_PURE))
-				return;
+				return 0;
 		}
 		kill_use_list(insn->arguments);
 		if (insn->func->type == PSEUDO_REG)
@@ -277,20 +277,20 @@ void kill_insn(struct instruction *insn, int force)
 
 	case OP_LOAD:
 		if (!force && insn->type->ctype.modifiers & MOD_VOLATILE)
-			return;
+			return 0;
 		kill_use(&insn->src);
 		break;
 
 	case OP_STORE:
 		if (!force)
-			return;
+			return 0;
 		kill_use(&insn->src);
 		kill_use(&insn->target);
 		break;
 
 	case OP_ENTRY:
 		/* ignore */
-		return;
+		return 0;
 
 	case OP_BR:
 	case OP_SETFVAL:
@@ -299,8 +299,7 @@ void kill_insn(struct instruction *insn, int force)
 	}
 
 	insn->bb = NULL;
-	repeat_phase |= REPEAT_CSE;
-	return;
+	return repeat_phase |= REPEAT_CSE;
 }
 
 /*
-- 
2.16.0

