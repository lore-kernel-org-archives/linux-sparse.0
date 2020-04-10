From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE PATCH 5/5] perform early CFG cleanup
Date: Fri, 10 Apr 2020 20:49:18 +0200
Message-ID: <20200410184918.64692-6-luc.vanoostenryck@gmail.com>
References: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51012 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgDJStg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Apr 2020 14:49:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so3377401wmc.0
        for <linux-sparse@vger.kernel.org>; Fri, 10 Apr 2020 11:49:34 -0700 (PDT)
In-Reply-To: <20200410184918.64692-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

add insert_self_branch()

A goto done into an piece of code discarded at expand or
linearize time will produce an invalid IR. More precisely,
the BB containing this goto will have as children a BB which:
1) has no instructions at all, so no terminator
2) has a null ->ep (normaly interpreted as unreachable)
3) is not added to the list of BBs.

What's really annoying is that such gotos are not detected at
earlier stages, so such invalid IR can be created completly
silently.

Fix this by adding, before any optimizations, a cleanup phase
which will detect such BBs and:
1) add a warning for the corresponding gotos
1) add branch to themselves as a way to properly terminate
   (any terminator would do the job).
2) add them to the list of BBs and make them reachable.

Note: the downside of a cleanup like this is that it could
      hide other problems with invalid CFG and assumptions
      are made (in the warning) about the origin of the
      problem.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                                  | 27 +++++++++++++++++++++++++
 flow.h                                  |  1 +
 linearize.c                             |  5 +++++
 linearize.h                             |  1 +
 optimize.c                              |  3 +++
 validation/linear/goto-and-expr-stmt0.c |  1 -
 6 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index ef8d04e5827f..976d476cdacd 100644
--- a/flow.c
+++ b/flow.c
@@ -814,4 +814,31 @@ out:
 	} END_FOR_EACH_PTR(bb);
 }
 
+void cleanup_cfg(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct basic_block *tgt;
+		struct instruction *br;
+
+		if (!bb->insns)
+			continue;
+		if (!bb->ep)
+			continue;
+
+		br = last_instruction(bb->insns);
+		if (!br)
+			continue;
 
+		FOR_EACH_PTR(bb->children, tgt) {
+			if (!tgt->insns) {
+				sparse_error(br->pos, "branch to unexisting label");
+				insert_self_branch(tgt);
+				tgt->ep = ep;
+				if (!lookup_bb(ep->bbs, tgt))
+					add_bb(&ep->bbs, tgt);
+			}
+		} END_FOR_EACH_PTR(tgt);
+	} END_FOR_EACH_PTR(bb);
+}
diff --git a/flow.h b/flow.h
index 099767d408f5..13eca195bab4 100644
--- a/flow.h
+++ b/flow.h
@@ -18,6 +18,7 @@ extern void kill_dead_stores(struct entrypoint *ep, pseudo_t addr, int local);
 extern void simplify_symbol_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
+extern void cleanup_cfg(struct entrypoint *ep);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
diff --git a/linearize.c b/linearize.c
index a2cde941ce18..7b685016ea3e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -740,6 +740,11 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	add_instruction(&bb->insns, br);
 }
 
+void insert_self_branch(struct basic_block *bb)
+{
+	add_jump(bb, bb);
+}
+
 static inline int bb_empty(struct basic_block *bb)
 {
 	return !bb->insns;
diff --git a/linearize.h b/linearize.h
index 76efd0b47ffa..7eca88016e26 100644
--- a/linearize.h
+++ b/linearize.h
@@ -308,6 +308,7 @@ struct entrypoint {
 
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
 extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
+extern void insert_self_branch(struct basic_block *bb);
 
 struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type);
 struct instruction *alloc_phi_node(struct basic_block *bb, struct symbol *type, struct ident *ident);
diff --git a/optimize.c b/optimize.c
index e8cb7fc31e4b..515d6d8d81e5 100644
--- a/optimize.c
+++ b/optimize.c
@@ -48,6 +48,9 @@ void optimize(struct entrypoint *ep)
 	if (fdump_ir & PASS_LINEARIZE)
 		show_entry(ep);
 
+	// Detect invalid gotos and band-aid them
+	cleanup_cfg(ep);
+
 	/*
 	 * Do trivial flow simplification - branches to
 	 * branches, kill dead basicblocks etc
diff --git a/validation/linear/goto-and-expr-stmt0.c b/validation/linear/goto-and-expr-stmt0.c
index 548813531779..a68aa59bcbcf 100644
--- a/validation/linear/goto-and-expr-stmt0.c
+++ b/validation/linear/goto-and-expr-stmt0.c
@@ -20,7 +20,6 @@ a:
 /*
  * check-name: goto-and-expr-stmt0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: END
-- 
2.26.0
