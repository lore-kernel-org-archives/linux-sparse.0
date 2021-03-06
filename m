Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2CC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FCB96501B
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFOLq (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 09:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCFOLZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 09:11:25 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A3C06174A
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 06:11:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b7so7109744edz.8
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/sSnNH0NohhUA2J/HUAZwTuzH4k2s+o74NdK2SDXEU=;
        b=t8E8cpLvFmFLeE4WP7TyGhMRdpSatdmDVPrZTq+yRCiUJXAG7FLrb/lbMzCs5yTnI1
         tIDAVGp6C9sD7JHhF8TcVWUMNhNJiX+7OrDj0a3F7RvjZWVtmvWRD1G4jX3D/q3DS5nn
         R3zPdrGMNg2VFde6Fg/9T9uNBqvYbDiAPtQM4TYAziFF/1kE/B6cav5ktIUJvv8GlLTp
         GFJ+qsIa1D3DoTdx4dXSCf+PGqUQwZgsVdOGmlLpKhdn5Gzc7DHIkrILW2yaiwzas2fi
         EhqQ10QIulOnu6gAeITlbsMxI4EhS5Y32TOdMNI6jIUEKqF1Kv71Y3c3bnGh2OcqCk+d
         0ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/sSnNH0NohhUA2J/HUAZwTuzH4k2s+o74NdK2SDXEU=;
        b=dMnO0GeBYKRlKgpX66k9AT5li4Ssa/kmFBPDW0tM42/8YSvoPZAcw8QHRVxgr+gGHC
         0CJgNxavq177zB/pMyf/fUtyYW22xiLj8orMDVgxN7YNsyfwK/pJde6Q2/JlPae9JSUo
         nzpQHozQXNvEfuCQ2V91PNZCISSmyWDQqLTOVvzi51s7QWHDGVCqZPPpQfgaUGps543Y
         H0K9jg01pj4T+yZ7XafX+l4TG3UC5T7klmL1IWN663I8aR0dvolPfPYh53kv1hse6sNu
         BmVKf5LTPF8FLoutYU2JLBI6kZE5lyFW2qScGl/USEPZsnK7tAF7Ph9NtZIL341cA7u2
         Gf/g==
X-Gm-Message-State: AOAM532uPUeIq8ixCtmI7JGSdZheLOzAcDG/t1+xbFS/93v/o1tb0MXg
        dnfayd4mydahQIall43S2hsGs+BiYps=
X-Google-Smtp-Source: ABdhPJxUUKpQyvCNUFz6tzJmRCrnJaSsTiragjRgnJ5cFaF607gGYf7lUnzuSFcP9U2NzrgLknxpig==
X-Received: by 2002:a05:6402:22b5:: with SMTP id cx21mr14139869edb.27.1615039877503;
        Sat, 06 Mar 2021 06:11:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c537:1c5b:9ed2:3808])
        by smtp.gmail.com with ESMTPSA id l1sm3247733eje.12.2021.03.06.06.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 06:11:16 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] phi-sources can only have a single user (or none)
Date:   Sat,  6 Mar 2021 15:11:11 +0100
Message-Id: <20210306141111.38187-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, OP_PHISOURCES have a list as member, 'phi_users',
that should link to all phi-nodes using them but:
*) phi-sources are never shared between phi-nodes
*) this list is useless because it's only created during liveness
   and not used after.

So, replace the list by a simple pointer to hold the unique phi-node
using it and keep this link updated during all its lifetime.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.rst |  2 +-
 flow.c               | 21 +--------------------
 linearize.c          | 14 +++++---------
 linearize.h          |  8 +++++++-
 liveness.c           |  1 -
 memops.c             |  1 +
 sparse-llvm.c        |  2 --
 ssa.c                |  2 +-
 storage.c            | 30 ------------------------------
 9 files changed, 16 insertions(+), 65 deletions(-)

diff --git a/Documentation/IR.rst b/Documentation/IR.rst
index 38df84ff3954..0cc90ec01aea 100644
--- a/Documentation/IR.rst
+++ b/Documentation/IR.rst
@@ -381,7 +381,7 @@ Others
 	* .phi_src: operand (type must be compatible with .target, alias .src)
 	* .target: the "result" PSEUDO_PHI
 	* .type: type of .target
-	* .phi_users: list of phi instructions using the target pseudo
+	* .phi_node: the unique phi instruction using the target pseudo
 
 .. op:: OP_CALL
 	Function call.
diff --git a/flow.c b/flow.c
index bda277aa551b..b776375babdb 100644
--- a/flow.c
+++ b/flow.c
@@ -46,25 +46,6 @@ static int rewrite_branch(struct basic_block *bb,
 	return 1;
 }
 
-///
-// returns the phi-node corresponding to a phi-source
-static struct instruction *get_phinode(struct instruction *phisrc)
-{
-	struct pseudo_user *pu;
-
-	FOR_EACH_PTR(phisrc->target->users, pu) {
-		struct instruction *user;
-
-		if (!pu)
-			continue;
-		user = pu->insn;
-		assert(user->opcode == OP_PHI);
-		return user;
-	} END_FOR_EACH_PTR(pu);
-	assert(0);
-}
-
-
 /*
  * Return the known truth value of a pseudo, or -1 if
  * it's not known.
@@ -843,7 +824,7 @@ static int retarget_parents(struct basic_block *bb, struct basic_block *target)
 
 static void remove_merging_phisrc(struct basic_block *top, struct instruction *insn)
 {
-	struct instruction *user = get_phinode(insn);
+	struct instruction *user = insn->phi_node;
 	pseudo_t phi;
 
 	FOR_EACH_PTR(user->phi_list, phi) {
diff --git a/linearize.c b/linearize.c
index 7a6f745fd4fc..c1aeb1596d22 100644
--- a/linearize.c
+++ b/linearize.c
@@ -407,11 +407,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_PHISOURCE: {
-		struct instruction *phi;
 		buf += sprintf(buf, "%s <- %s    ", show_pseudo(insn->target), show_pseudo(insn->phi_src));
-		FOR_EACH_PTR(insn->phi_users, phi) {
-			buf += sprintf(buf, " (%s)", show_pseudo(phi->target));
-		} END_FOR_EACH_PTR(phi);
 		break;
 	}
 
@@ -1683,8 +1679,8 @@ static pseudo_t add_join_conditional(struct entrypoint *ep, struct expression *e
 		return (phi1 == VOID) ? phi1 : phi1->def->src;
 
 	phi_node = alloc_typed_instruction(OP_PHI, expr->ctype);
-	use_pseudo(phi_node, phi1, add_pseudo(&phi_node->phi_list, phi1));
-	use_pseudo(phi_node, phi2, add_pseudo(&phi_node->phi_list, phi2));
+	link_phi(phi_node, phi1);
+	link_phi(phi_node, phi2);
 	phi_node->target = target = alloc_pseudo(phi_node);
 	add_one_insn(ep, phi_node);
 	return target;
@@ -1756,7 +1752,7 @@ static void insert_phis(struct basic_block *bb, pseudo_t src, struct symbol *cty
 		struct instruction *br = delete_last_instruction(&parent->insns);
 		pseudo_t phi = alloc_phi(parent, src, ctype);
 		add_instruction(&parent->insns, br);
-		use_pseudo(node, phi, add_pseudo(&node->phi_list, phi));
+		link_phi(node, phi);
 	} END_FOR_EACH_PTR(parent);
 }
 
@@ -1789,7 +1785,7 @@ static pseudo_t linearize_logical(struct entrypoint *ep, struct expression *expr
 	src2 = linearize_expression_to_bool(ep, expr->right);
 	src2 = cast_pseudo(ep, src2, &bool_ctype, ctype);
 	phi2 = alloc_phi(ep->active, src2, ctype);
-	use_pseudo(node, phi2, add_pseudo(&node->phi_list, phi2));
+	link_phi(node, phi2);
 
 	// join
 	set_activeblock(ep, merge);
@@ -2049,7 +2045,7 @@ static void add_return(struct entrypoint *ep, struct basic_block *bb, struct sym
 	}
 	phi = alloc_phi(ep->active, src, ctype);
 	phi->ident = &return_ident;
-	use_pseudo(phi_node, phi, add_pseudo(&phi_node->phi_list, phi));
+	link_phi(phi_node, phi);
 }
 
 static pseudo_t linearize_fn_statement(struct entrypoint *ep, struct statement *stmt)
diff --git a/linearize.h b/linearize.h
index a77e4b3e5f6f..18f1d80f0ca4 100644
--- a/linearize.h
+++ b/linearize.h
@@ -109,7 +109,7 @@ struct instruction {
 		};
 		struct /* phi source */ {
 			pseudo_t phi_src;
-			struct instruction_list *phi_users;
+			struct instruction *phi_node;
 		};
 		struct /* unops */ {
 			pseudo_t src;
@@ -292,6 +292,12 @@ static inline void use_pseudo(struct instruction *insn, pseudo_t p, pseudo_t *pp
 		add_pseudo_user_ptr(alloc_pseudo_user(insn, pp), &p->users);
 }
 
+static inline void link_phi(struct instruction *node, pseudo_t phi)
+{
+	use_pseudo(node, phi, add_pseudo(&node->phi_list, phi));
+	phi->def->phi_node = node;
+}
+
 static inline void remove_bb_from_list(struct basic_block_list **list, struct basic_block *entry, int count)
 {
 	delete_ptr_list_entry((struct ptr_list **)list, entry, count);
diff --git a/liveness.c b/liveness.c
index 30a9a5b6b169..4fc16e3de37d 100644
--- a/liveness.c
+++ b/liveness.c
@@ -260,7 +260,6 @@ static void track_phi_uses(struct instruction *insn)
 			continue;
 		def = phi->def;
 		assert(def->opcode == OP_PHISOURCE);
-		add_ptr_list(&def->phi_users, insn);
 	} END_FOR_EACH_PTR(phi);
 }
 
diff --git a/memops.c b/memops.c
index 0a1106b0e464..ff54208e2d54 100644
--- a/memops.c
+++ b/memops.c
@@ -100,6 +100,7 @@ found_dominator:
 		phi->ident = phi->ident ? : one->target->ident;
 		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
+		phi->def->phi_node = insn;
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 658744eeeb38..9ceb19a97736 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1342,8 +1342,6 @@ int main(int argc, char **argv)
 
 	compile(module, symlist);
 
-	/* need ->phi_users */
-	dbg_dead = 1;
 	FOR_EACH_PTR(filelist, file) {
 		symlist = sparse(file);
 		if (die_if_error)
diff --git a/ssa.c b/ssa.c
index 4c86c55c2ec1..b9044207db16 100644
--- a/ssa.c
+++ b/ssa.c
@@ -350,7 +350,7 @@ static void ssa_rename_phi(struct instruction *insn)
 		pseudo_t phi = alloc_phi(par, val, var);
 		phi->ident = var->ident;
 		add_instruction(&par->insns, term);
-		use_pseudo(insn, phi, add_pseudo(&insn->phi_list, phi));
+		link_phi(insn, phi);
 		mark_phi_used(val);
 	} END_FOR_EACH_PTR(par);
 }
diff --git a/storage.c b/storage.c
index acbc477d5f70..6fc6e3d7085f 100644
--- a/storage.c
+++ b/storage.c
@@ -261,35 +261,6 @@ static void set_up_argument_storage(struct entrypoint *ep, struct basic_block *b
 	} END_FOR_EACH_PTR(arg);
 }
 
-/*
- * One phi-source may feed multiple phi nodes. If so, combine
- * the storage output for this bb into one entry to reduce
- * storage pressure.
- */
-static void combine_phi_storage(struct basic_block *bb)
-{
-	struct instruction *insn;
-	FOR_EACH_PTR(bb->insns, insn) {
-		struct instruction *phi;
-		struct storage *last;
-
-		if (!insn->bb || insn->opcode != OP_PHISOURCE)
-			continue;
-		last = NULL;
-		FOR_EACH_PTR(insn->phi_users, phi) {
-			struct storage *storage = lookup_storage(bb, phi->target, STOR_OUT);
-			if (!storage) {
-				DELETE_CURRENT_PTR(phi);
-				continue;
-			}
-			if (last && storage != last)
-				storage = combine_storage(storage, last);
-			last = storage;
-		} END_FOR_EACH_PTR(phi);
-		PACK_PTR_LIST(&insn->phi_users);
-	} END_FOR_EACH_PTR(insn);
-}
-
 void set_up_storage(struct entrypoint *ep)
 {
 	struct basic_block *bb;
@@ -300,7 +271,6 @@ void set_up_storage(struct entrypoint *ep)
 	/* Then do a list of all the inter-bb storage */
 	FOR_EACH_PTR(ep->bbs, bb) {
 		set_up_bb_storage(bb);
-		combine_phi_storage(bb);
 	} END_FOR_EACH_PTR(bb);
 
 	name_storage();
-- 
2.30.0

