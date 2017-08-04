From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] mark pseudo users as deleted instead of removing them
Date: Fri,  4 Aug 2017 22:09:15 +0200
Message-ID: <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37229 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdHDUJ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:09:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so6802863wmt.4
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:09:28 -0700 (PDT)
In-Reply-To: <20170804200915.56738-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This will fix the (rare) problems with deletion while doing
nested ptrlist walking that occurs when doing recursive
kill_instruction() - remove_usage() - kill_instruction()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      | 28 ++++++++++++++++++++++------
 linearize.c |  2 ++
 memops.c    |  5 ++++-
 simplify.c  | 10 ++++++++--
 unssa.c     |  2 ++
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/flow.c b/flow.c
index 6cac21b24..1dbfd431e 100644
--- a/flow.c
+++ b/flow.c
@@ -283,6 +283,8 @@ void convert_instruction_target(struct instruction *insn, pseudo_t src)
 	if (target == src)
 		return;
 	FOR_EACH_PTR(target->users, pu) {
+		if (!pu)
+			continue;
 		if (*pu->userp != VOID) {
 			assert(*pu->userp == target);
 			*pu->userp = src;
@@ -675,8 +677,10 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 	complex = 0;
 	FOR_EACH_PTR(pseudo->users, pu) {
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
-		struct instruction *insn = pu->insn;
-
+		struct instruction *insn;
+		if (!pu)
+			continue;
+		insn = pu->insn;
 		switch (insn->opcode) {
 		case OP_STORE:
 			stores++;
@@ -715,7 +719,10 @@ static void simplify_one_symbol(struct entrypoint *ep, struct symbol *sym)
 		src = def->target;
 
 	FOR_EACH_PTR(pseudo->users, pu) {
-		struct instruction *insn = pu->insn;
+		struct instruction *insn;
+		if (!pu)
+			continue;
+		insn = pu->insn;
 		if (insn->opcode == OP_LOAD) {
 			check_access(insn);
 			convert_load_instruction(insn, src);
@@ -731,7 +738,10 @@ complex_def:
 external_visibility:
 	all = 1;
 	FOR_EACH_PTR_REVERSE(pseudo->users, pu) {
-		struct instruction *insn = pu->insn;
+		struct instruction *insn;
+		if (!pu)
+			continue;
+		insn = pu->insn;
 		if (insn->opcode == OP_LOAD)
 			all &= find_dominating_stores(pseudo, insn, ++bb_generation, !mod);
 	} END_FOR_EACH_PTR_REVERSE(pu);
@@ -739,7 +749,10 @@ external_visibility:
 	/* If we converted all the loads, remove the stores. They are dead */
 	if (all && !mod) {
 		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
+			struct instruction *insn;
+			if (!pu)
+				continue;
+			insn = pu->insn;
 			if (insn->opcode == OP_STORE)
 				kill_store(insn);
 		} END_FOR_EACH_PTR(pu);
@@ -749,7 +762,10 @@ external_visibility:
 		 * of them..
 		 */
 		FOR_EACH_PTR(pseudo->users, pu) {
-			struct instruction *insn = pu->insn;
+			struct instruction *insn;
+			if (!pu)
+				continue;
+			insn = pu->insn;
 			if (insn->opcode == OP_STORE)
 				kill_dominated_stores(pseudo, insn, ++bb_generation, insn->bb, !mod, 0);
 		} END_FOR_EACH_PTR(pu);
diff --git a/linearize.c b/linearize.c
index ba76397ea..0933e935f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -542,6 +542,8 @@ static void show_symbol_usage(pseudo_t pseudo)
 
 	if (pseudo) {
 		FOR_EACH_PTR(pseudo->users, pu) {
+			if (!pu)
+				continue;
 			printf("\t%s\n", show_instruction(pu->insn));
 		} END_FOR_EACH_PTR(pu);
 	}
diff --git a/memops.c b/memops.c
index aeacdf566..ce5aecbe8 100644
--- a/memops.c
+++ b/memops.c
@@ -66,7 +66,10 @@ static int address_taken(pseudo_t pseudo)
 {
 	struct pseudo_user *pu;
 	FOR_EACH_PTR(pseudo->users, pu) {
-		struct instruction *insn = pu->insn;
+		struct instruction *insn;
+		if (!pu)
+			continue;
+		insn = pu->insn;
 		if (insn->bb && (insn->opcode != OP_LOAD && insn->opcode != OP_STORE))
 			return 1;
 	} END_FOR_EACH_PTR(pu);
diff --git a/simplify.c b/simplify.c
index 03ff9c942..0569007a1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -166,20 +166,24 @@ static int clean_up_phi(struct instruction *insn)
 	return if_convert_phi(insn);
 }
 
+
 static int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_t *entry, int count)
 {
 	struct pseudo_user *pu;
 
 	FOR_EACH_PTR(*list, pu) {
+		if (!pu)
+			continue;
 		if (pu->userp == entry) {
-			DELETE_CURRENT_PTR(pu);
+			MARK_CURRENT_DELETED(pu);
 			if (!--count)
 				goto out;
 		}
 	} END_FOR_EACH_PTR(pu);
 	assert(count <= 0);
 out:
-	pack_ptr_list((struct ptr_list **)list);
+	if (ptr_list_size((struct ptr_list *) *list) == 0)
+		*list = NULL;
 	return count;
 }
 
@@ -308,6 +312,8 @@ static int dead_insn(struct instruction *insn, pseudo_t *src1, pseudo_t *src2, p
 {
 	struct pseudo_user *pu;
 	FOR_EACH_PTR(insn->target->users, pu) {
+		if (!pu)
+			continue;
 		if (*pu->userp != VOID)
 			return 0;
 	} END_FOR_EACH_PTR(pu);
diff --git a/unssa.c b/unssa.c
index e7c9154d5..87d0c2c7f 100644
--- a/unssa.c
+++ b/unssa.c
@@ -58,6 +58,8 @@ static int simplify_phi_node(struct instruction *phi, pseudo_t tmp)
 	// no need to make a copy of this one
 	// -> replace the target pseudo by the tmp
 	FOR_EACH_PTR(target->users, pu) {
+		if (!pu)
+			continue;
 		use_pseudo(pu->insn, tmp, pu->userp);
 	} END_FOR_EACH_PTR(pu);
 
-- 
2.13.2

