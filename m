From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] give comparable label's names to basic blocks
Date: Tue, 22 Nov 2016 16:42:23 +0100
Message-ID: <20161122154223.2630-1-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34098 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbcKVPng (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 10:43:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so4662148wme.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 07:42:49 -0800 (PST)
In-Reply-To: <CANeU7Q=uNLQh=ynnWPeO0+ahu7qhJ2nxqxOrxbDraR1jo6xEAQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

test-linearize displays basic block's labels by using
'.L0x' plus the address of the bb struct. This is certainly
convenient as an UID but it has the disadvantage that these
names change at each run and are thus not comparable.

This complicate testing quite a bit.

Let change this by giving a simple sequential number to each bb
and simply display them as: '.L1', '.L2', ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c  | 30 ++++++++++++++++--------------
 linearize.h  |  5 ++++-
 test-unssa.c |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/linearize.c b/linearize.c
index c6ada1e8..cb252282 100644
--- a/linearize.c
+++ b/linearize.c
@@ -67,10 +67,12 @@ static struct entrypoint *alloc_entrypoint(void)
 
 static struct basic_block *alloc_basic_block(struct entrypoint *ep, struct position pos)
 {
+	static int nr;
 	struct basic_block *bb = __alloc_basic_block(0);
 	bb->context = -1;
 	bb->pos = pos;
 	bb->ep = ep;
+	bb->nr = nr++;
 	return bb;
 }
 
@@ -109,7 +111,7 @@ const char *show_pseudo(pseudo_t pseudo)
 		struct expression *expr;
 
 		if (sym->bb_target) {
-			snprintf(buf, 64, ".L%p", sym->bb_target);
+			snprintf(buf, 64, ".L%u", sym->bb_target->nr);
 			break;
 		}
 		if (sym->ident) {
@@ -303,10 +305,10 @@ const char *show_instruction(struct instruction *insn)
 		break;
 	case OP_BR:
 		if (insn->bb_true && insn->bb_false) {
-			buf += sprintf(buf, "%s, .L%p, .L%p", show_pseudo(insn->cond), insn->bb_true, insn->bb_false);
+			buf += sprintf(buf, "%s, .L%u, .L%u", show_pseudo(insn->cond), insn->bb_true->nr, insn->bb_false->nr);
 			break;
 		}
-		buf += sprintf(buf, ".L%p", insn->bb_true ? insn->bb_true : insn->bb_false);
+		buf += sprintf(buf, ".L%u", insn->bb_true ? insn->bb_true->nr : insn->bb_false->nr);
 		break;
 
 	case OP_SYMADDR: {
@@ -314,7 +316,7 @@ const char *show_instruction(struct instruction *insn)
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 
 		if (sym->bb_target) {
-			buf += sprintf(buf, ".L%p", sym->bb_target);
+			buf += sprintf(buf, ".L%u", sym->bb_target->nr);
 			break;
 		}
 		if (sym->ident) {
@@ -348,7 +350,7 @@ const char *show_instruction(struct instruction *insn)
 			buf += sprintf(buf, "%s", show_ident(expr->symbol->ident));
 			break;
 		case EXPR_LABEL:
-			buf += sprintf(buf, ".L%p", expr->symbol->bb_target);
+			buf += sprintf(buf, ".L%u", expr->symbol->bb_target->nr);
 			break;
 		default:
 			buf += sprintf(buf, "SETVAL EXPR TYPE %d", expr->type);
@@ -360,11 +362,11 @@ const char *show_instruction(struct instruction *insn)
 		buf += sprintf(buf, "%s", show_pseudo(insn->target));
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
 			if (jmp->begin == jmp->end)
-				buf += sprintf(buf, ", %d -> .L%p", jmp->begin, jmp->target);
+				buf += sprintf(buf, ", %d -> .L%u", jmp->begin, jmp->target->nr);
 			else if (jmp->begin < jmp->end)
-				buf += sprintf(buf, ", %d ... %d -> .L%p", jmp->begin, jmp->end, jmp->target);
+				buf += sprintf(buf, ", %d ... %d -> .L%u", jmp->begin, jmp->end, jmp->target->nr);
 			else
-				buf += sprintf(buf, ", default -> .L%p", jmp->target);
+				buf += sprintf(buf, ", default -> .L%u", jmp->target->nr);
 		} END_FOR_EACH_PTR(jmp);
 		break;
 	}
@@ -372,7 +374,7 @@ const char *show_instruction(struct instruction *insn)
 		struct multijmp *jmp;
 		buf += sprintf(buf, "%s", show_pseudo(insn->target));
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
-			buf += sprintf(buf, ", .L%p", jmp->target);
+			buf += sprintf(buf, ", .L%u", jmp->target->nr);
 		} END_FOR_EACH_PTR(jmp);
 		break;
 	}
@@ -473,7 +475,7 @@ void show_bb(struct basic_block *bb)
 {
 	struct instruction *insn;
 
-	printf(".L%p:\n", bb);
+	printf(".L%u:\n", bb->nr);
 	if (verbose) {
 		pseudo_t needs, defines;
 		printf("%s:%d\n", stream_name(bb->pos.stream), bb->pos.line);
@@ -481,7 +483,7 @@ void show_bb(struct basic_block *bb)
 		FOR_EACH_PTR(bb->needs, needs) {
 			struct instruction *def = needs->def;
 			if (def->opcode != OP_PHI) {
-				printf("  **uses %s (from .L%p)**\n", show_pseudo(needs), def->bb);
+				printf("  **uses %s (from .L%u)**\n", show_pseudo(needs), def->bb->nr);
 			} else {
 				pseudo_t phi;
 				const char *sep = " ";
@@ -489,7 +491,7 @@ void show_bb(struct basic_block *bb)
 				FOR_EACH_PTR(def->phi_list, phi) {
 					if (phi == VOID)
 						continue;
-					printf("%s(%s:.L%p)", sep, show_pseudo(phi), phi->def->bb);
+					printf("%s(%s:.L%u)", sep, show_pseudo(phi), phi->def->bb->nr);
 					sep = ", ";
 				} END_FOR_EACH_PTR(phi);		
 				printf(")**\n");
@@ -503,7 +505,7 @@ void show_bb(struct basic_block *bb)
 		if (bb->parents) {
 			struct basic_block *from;
 			FOR_EACH_PTR(bb->parents, from) {
-				printf("  **from %p (%s:%d:%d)**\n", from,
+				printf("  **from .L%u (%s:%d:%d)**\n", from->nr,
 					stream_name(from->pos.stream), from->pos.line, from->pos.pos);
 			} END_FOR_EACH_PTR(from);
 		}
@@ -511,7 +513,7 @@ void show_bb(struct basic_block *bb)
 		if (bb->children) {
 			struct basic_block *to;
 			FOR_EACH_PTR(bb->children, to) {
-				printf("  **to %p (%s:%d:%d)**\n", to,
+				printf("  **to .L%u (%s:%d:%d)**\n", to->nr,
 					stream_name(to->pos.stream), to->pos.line, to->pos.pos);
 			} END_FOR_EACH_PTR(to);
 		}
diff --git a/linearize.h b/linearize.h
index 61fbd831..f2ae140d 100644
--- a/linearize.h
+++ b/linearize.h
@@ -233,7 +233,10 @@ struct basic_block {
 	struct basic_block_list *children; /* destinations */
 	struct instruction_list *insns;	/* Linear list of instructions */
 	struct pseudo_list *needs, *defines;
-	void *priv;
+	union {
+		unsigned int nr;	/* unique id for label's names */
+		void *priv;
+	};
 };
 
 static inline int is_branch_goto(struct instruction *br)
diff --git a/test-unssa.c b/test-unssa.c
index 88ce025f..f7a5c3a1 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -12,7 +12,7 @@ static void output_bb(struct basic_block *bb, unsigned long generation)
 	struct instruction *insn;
 
 	bb->generation = generation;
-	printf(".L%p\n", bb);
+	printf(".L%u\n", bb->nr);
 
 	FOR_EACH_PTR(bb->insns, insn) {
 		if (!insn->bb)
-- 
2.10.2

