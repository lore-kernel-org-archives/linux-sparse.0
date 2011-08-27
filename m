From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 2/3] Make 'linearize_switch()' helper function
Date: Sat, 27 Aug 2011 14:27:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.02.1108271427260.18733@i5.linux-foundation.org>
References: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:60269 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1H0V1t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 17:27:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6219152pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 14:27:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.02.1108271424400.18733@i5.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>
Cc: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 27 Aug 2011 11:41:35 -0700
Subject: [PATCH 2/3] Make 'linearize_switch()' helper function

Rather than do it in that huge 'linearize_statement()' function, split
out the switch generation case.  Avoids one level of indentation, and
makes for simpler and more straightforward functions.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 linearize.c |  126 ++++++++++++++++++++++++++++++----------------------------
 1 files changed, 65 insertions(+), 61 deletions(-)

diff --git a/linearize.c b/linearize.c
index 2decd5300859..e48854755b1e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1843,6 +1843,69 @@ static pseudo_t linearize_declaration(struct entrypoint *ep, struct statement *s
 	return VOID;
 }
 
+static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
+{
+	struct symbol *sym;
+	struct instruction *switch_ins;
+	struct basic_block *switch_end = alloc_basic_block(ep, stmt->pos);
+	struct basic_block *active, *default_case;
+	struct multijmp *jmp;
+	pseudo_t pseudo;
+
+	pseudo = linearize_expression(ep, stmt->switch_expression);
+
+	active = ep->active;
+	if (!bb_reachable(active))
+		return VOID;
+
+	switch_ins = alloc_instruction(OP_SWITCH, 0);
+	use_pseudo(switch_ins, pseudo, &switch_ins->cond);
+	add_one_insn(ep, switch_ins);
+	finish_block(ep);
+
+	default_case = NULL;
+	FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
+		struct statement *case_stmt = sym->stmt;
+		struct basic_block *bb_case = get_bound_block(ep, sym);
+
+		if (!case_stmt->case_expression) {
+			default_case = bb_case;
+			continue;
+		} else {
+			int begin, end;
+
+			begin = end = case_stmt->case_expression->value;
+			if (case_stmt->case_to)
+				end = case_stmt->case_to->value;
+			if (begin > end)
+				jmp = alloc_multijmp(bb_case, end, begin);
+			else
+				jmp = alloc_multijmp(bb_case, begin, end);
+
+		}
+		add_multijmp(&switch_ins->multijmp_list, jmp);
+		add_bb(&bb_case->parents, active);
+		add_bb(&active->children, bb_case);
+	} END_FOR_EACH_PTR(sym);
+
+	bind_label(stmt->switch_break, switch_end, stmt->pos);
+
+	/* And linearize the actual statement */
+	linearize_statement(ep, stmt->switch_statement);
+	set_activeblock(ep, switch_end);
+
+	if (!default_case)
+		default_case = switch_end;
+
+	jmp = alloc_multijmp(default_case, 1, 0);
+	add_multijmp(&switch_ins->multijmp_list, jmp);
+	add_bb(&default_case->parents, active);
+	add_bb(&active->children, default_case);
+	sort_switch_cases(switch_ins);
+
+	return VOID;
+}
+
 static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt)
 {
 	struct statement  *pre_statement = stmt->iterator_pre_statement;
@@ -2030,67 +2093,8 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		break;
 	}
 
-	case STMT_SWITCH: {
-		struct symbol *sym;
-		struct instruction *switch_ins;
-		struct basic_block *switch_end = alloc_basic_block(ep, stmt->pos);
-		struct basic_block *active, *default_case;
-		struct multijmp *jmp;
-		pseudo_t pseudo;
-
-		pseudo = linearize_expression(ep, stmt->switch_expression);
-
-		active = ep->active;
-		if (!bb_reachable(active))
-			break;
-
-		switch_ins = alloc_instruction(OP_SWITCH, 0);
-		use_pseudo(switch_ins, pseudo, &switch_ins->cond);
-		add_one_insn(ep, switch_ins);
-		finish_block(ep);
-
-		default_case = NULL;
-		FOR_EACH_PTR(stmt->switch_case->symbol_list, sym) {
-			struct statement *case_stmt = sym->stmt;
-			struct basic_block *bb_case = get_bound_block(ep, sym);
-
-			if (!case_stmt->case_expression) {
-				default_case = bb_case;
-				continue;
-			} else {
-				int begin, end;
-
-				begin = end = case_stmt->case_expression->value;
-				if (case_stmt->case_to)
-					end = case_stmt->case_to->value;
-				if (begin > end)
-					jmp = alloc_multijmp(bb_case, end, begin);
-				else
-					jmp = alloc_multijmp(bb_case, begin, end);
-
-			}
-			add_multijmp(&switch_ins->multijmp_list, jmp);
-			add_bb(&bb_case->parents, active);
-			add_bb(&active->children, bb_case);
-		} END_FOR_EACH_PTR(sym);
-
-		bind_label(stmt->switch_break, switch_end, stmt->pos);
-
-		/* And linearize the actual statement */
-		linearize_statement(ep, stmt->switch_statement);
-		set_activeblock(ep, switch_end);
-
-		if (!default_case)
-			default_case = switch_end;
-
-		jmp = alloc_multijmp(default_case, 1, 0);
-		add_multijmp(&switch_ins->multijmp_list, jmp);
-		add_bb(&default_case->parents, active);
-		add_bb(&active->children, default_case);
-		sort_switch_cases(switch_ins);
