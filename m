From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] avoid phisrc orphaned by find_dominating_stores()
Date: Thu, 13 Apr 2017 18:55:48 +0200
Message-ID: <20170413165551.2785-6-luc.vanoostenryck@gmail.com>
References: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35601 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754073AbdDMQ4E (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Apr 2017 12:56:04 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so13692668wmi.2
        for <linux-sparse@vger.kernel.org>; Thu, 13 Apr 2017 09:56:03 -0700 (PDT)
In-Reply-To: <20170413165551.2785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Note: this is the dual of the preceding patch, only for stores
instead of loads.

find_dominating_stores() call find_dominating_parents() which can
add an OP_PHISRC in each BB it visits and the corresponding
%phi are collected in a list. Then, depending on the returned
value, an OP_PHI is created with this list as phi_list.

However, it could that because of the returned value, no such
OP_PHI is created and thus the newly created OP_PHISRC stay
there but are of no use.

It seems also (but I can't strictly confirm this) that this can
sometimes happen at each CSE-simplification cycle, creating one
more such OP_PHISRC at each cycle, into each concerned BB.
Not good.

Change this by not creating these OP_PHISRC but instead just
collecting their source pseudo. And then only created them
together with the corresponding OP_PHI, or simply discarding
the list, depending on the returned value.

The situation can clearly be seen with the following code:
	extern void abort(void);
	extern int bar;
	int foo(void)
	{
		if (bar)
			abort();
		return bar;
	}
which was linearized as:
	foo:
		load.32     %r1 <- 0[bar]
>		phisrc.32   %phi2(bar) <- %r1
		cbr         %r1, .L1, .L2
	.L1:
		call        abort
		br          .L2
	.L2:
		load.32     %r2 <- 0[bar]
		ret.32      %r2

and is now linearized as:
	foo:
		load.32     %r1 <- 0[bar]
		cbr         %r1, .L1, .L2
	.L1:
		call        abort
		br          .L2
	.L2:
		load.32     %r2 <- 0[bar]
		ret.32      %r2

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                               | 20 +++++++++++---------
 validation/linear/phisrc-orphan-st.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+), 9 deletions(-)
 create mode 100644 validation/linear/phisrc-orphan-st.c

diff --git a/flow.c b/flow.c
index aa7a6586f..678f9ba86 100644
--- a/flow.c
+++ b/flow.c
@@ -352,19 +352,19 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 	return 1;
 }
 
-static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
+static int phisrc_in_bb(struct instruction_list *list, struct basic_block *bb)
 {
-	pseudo_t p;
-	FOR_EACH_PTR(list, p) {
-		if (p->def->bb == bb)
+	struct instruction *def;
+	FOR_EACH_PTR(list, def) {
+		if (def->bb == bb)
 			return 1;
-	} END_FOR_EACH_PTR(p);
+	} END_FOR_EACH_PTR(def);
 
 	return 0;
 }
 
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
-	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
+	struct basic_block *bb, unsigned long generation, struct instruction_list **dominators,
 	int local)
 {
 	struct basic_block *parent;
@@ -401,7 +401,7 @@ no_dominance:
 found_dominator:
 		if (dominators && phisrc_in_bb(*dominators, parent))
 			continue;
-		add_dominator(dominators, insn, one, pseudo->ident);
+		add_instruction(dominators, one);
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
@@ -472,7 +472,8 @@ static int find_dominating_stores(pseudo_t pseudo, struct instruction *insn,
 {
 	struct basic_block *bb = insn->bb;
 	struct instruction *one, *dom = NULL;
-	struct pseudo_list *dominators;
+	struct instruction_list *dominators;
+	struct pseudo_list *phi_list;
 	int partial;
 
 	/* Unreachable load? Undo it */
@@ -534,7 +535,8 @@ found:
 	 * have to turn the load into a phi-node of the
 	 * dominators.
 	 */
-	rewrite_load_instruction(insn, dominators);
+	phi_list = add_load_dominators(insn, dominators, pseudo->ident);
+	rewrite_load_instruction(insn, phi_list);
 	return 1;
 }
 
diff --git a/validation/linear/phisrc-orphan-st.c b/validation/linear/phisrc-orphan-st.c
new file mode 100644
index 000000000..e5b3a3a46
--- /dev/null
+++ b/validation/linear/phisrc-orphan-st.c
@@ -0,0 +1,17 @@
+extern void abort(void);
+extern int bar;
+
+int foo(void)
+{
+	if (bar)
+		abort();
+	return bar;
+}
+
+/*
+ * check-name: phisrc orphaned (stores)
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: phisrc
+ */
-- 
2.12.0

