From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] avoid phisrc orphaned by simplify_loads()
Date: Thu, 13 Apr 2017 18:55:47 +0200
Message-ID: <20170413165551.2785-5-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33407 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754032AbdDMQ4D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id l28so9400371wre.0
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:02 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

simplify_loads() calls find_dominating_parents() which can
add an OP_PHISRC in each BB it visits and the corresponding
%phi are collected in a list.
Then, depending on find_dominating_parents()'s returned
value, either an OP_PHI is created with this list as phi_list,
or no such OP_PHI is created and the phi_list is discarded.
In the later case, the added OP_PHISRCs are of no use but are
left there nevertheless.

These orphaned OP_PHISRCs can only bring confusion later.
It seems also (but I can't strictly confirm this) that this can
sometimes happen at each CSE-simplification cycle, creating one
more such OP_PHISRC at each cycle, into each concerned BB.
Not good.

Change this by not creating these OP_PHISRC but instead just
collecting their source pseudo. And then only created them
together with the corresponding OP_PHI, or simply discarding
the list, depending on the returned value.

The situation can clearly be seen with the following code:
	struct s { void *x, *z; };
	extern void use(struct s *);
	void *foo(struct s *s)
	{
		if (s->x == s->z)
			use(s);
		return s->x;
	}
which was linearized as:
	foo:
		load.64     %r2 <- 0[%arg1]
		load.64     %r4 <- 8[%arg1]
		seteq.32    %r5 <- %r4, %r2
->		phisrc.64   %phi2 <- %r2
->		phisrc.64   %phi3 <- %r2
		cbr         %r5, .L1, .L2
	.L1:
		push.64     %arg1
		call        use
		br          .L2
	.L2:
		load.64     %r8 <- 0[%arg1]
		ret.64      %r8

and is now simply linearized as:
	foo:
		load.64     %r2 <- 0[%arg1]
		load.64     %r4 <- 8[%arg1]
		seteq.32    %r5 <- %r4, %r2
		cbr         %r5, .L1, .L2
	.L1:
		push.64     %arg1
		call        use
		br          .L2
	.L2:
		load.64     %r8 <- 0[%arg1]
		ret.64      %r8

Note: this situation seems to have existed since a long time
      but have been made worse by the patch:
      (5636cd5cb "missing load simplification")

Fixes: 5636cd5cbf816f30ee57d580ec4debd8e0bd7581
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                             | 10 ++++++----
 validation/linear/phisrc-orphan-ld.c | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 validation/linear/phisrc-orphan-ld.c

diff --git a/memops.c b/memops.c
index ac43b6a0a..39469e260 100644
--- a/memops.c
+++ b/memops.c
@@ -17,7 +17,7 @@
 #include "flow.h"
 
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
-	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
+	struct basic_block *bb, unsigned long generation, struct instruction_list **dominators,
 	int local)
 {
 	struct basic_block *parent;
@@ -49,7 +49,7 @@ no_dominance:
 		continue;
 
 found_dominator:
-		add_dominator(dominators, insn, one, NULL);
+		add_instruction(dominators, one);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
@@ -83,7 +83,7 @@ static void simplify_loads(struct basic_block *bb)
 			struct instruction *dom;
 			pseudo_t pseudo = insn->src;
 			int local = local_pseudo(pseudo);
-			struct pseudo_list *dominators;
+			struct instruction_list *dominators;
 			unsigned long generation;
 
 			/* Check for illegal offsets.. */
@@ -115,6 +115,7 @@ static void simplify_loads(struct basic_block *bb)
 			bb->generation = generation;
 			dominators = NULL;
 			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local)) {
+				struct pseudo_list *phi_list;
 				/* This happens with initial assignments to structures etc.. */
 				if (!dominators) {
 					if (local) {
@@ -123,7 +124,8 @@ static void simplify_loads(struct basic_block *bb)
 					}
 					goto next_load;
 				}
-				rewrite_load_instruction(insn, dominators);
+				phi_list = add_load_dominators(insn, dominators, NULL);
+				rewrite_load_instruction(insn, phi_list);
 			}
 		}
 next_load:
diff --git a/validation/linear/phisrc-orphan-ld.c b/validation/linear/phisrc-orphan-ld.c
new file mode 100644
index 000000000..a10aedba6
--- /dev/null
+++ b/validation/linear/phisrc-orphan-ld.c
@@ -0,0 +1,22 @@
+struct s {
+	void *x;
+	void *z;
+};
+
+extern void use(struct s *);
+
+void *foo(struct s *s)
+{
+	if (s->x == s->z)
+		use(s);
+
+	return s->x;
+}
+
+/*
+ * check-name: phisrc orphaned (loads)
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc
+ */
-- 
2.12.0

