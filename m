From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] fix superfluous phisrc
Date: Wed,  4 Jan 2017 04:03:19 +0100
Message-ID: <20170104030321.28019-3-luc.vanoostenryck@gmail.com>
References: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34335 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753455AbdADDEM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 22:04:12 -0500
Received: by mail-wj0-f196.google.com with SMTP id qs7so36298918wjc.1
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 19:03:36 -0800 (PST)
In-Reply-To: <20170104030321.28019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In some case more phisrc are created than expected.
For example, on the following code:
	static int foo(int a, int b)
	{
		int i, x = 0;
		switch (a) {
		case  0: i = 0; break;
		case  1: i = 1; break;
		default: i = -1; break;
		}
		if (b)
			x = i;
		return x;
	}

test-linearize returns something like:
	foo:
	.L0:
		<entry-point>
		phisrc.32   %phi2(x) <- $0
		phisrc.32   %phi3(x) <- $0
		phisrc.32   %phi4(x) <- $0
		switch      %arg1, 0 -> .L2, 1 -> .L3, default -> .L4
	.L2:
		phisrc.32   %phi6(i) <- $0
		br          .L1
	.L3:
		phisrc.32   %phi7(i) <- $1
		br          .L1
	.L4:
		phisrc.32   %phi8(i) <- $0xffffffff
		br          .L1
	.L1:
		br          %arg2, .L5, .L6
	.L5:
		phi.32      %r3 <- %phi6(i), %phi7(i), %phi8(i)
		phisrc.32   %phi5(x) <- %r3
		br          .L6
	.L6:
		phi.32      %r4 <- %phi2(x), %phi3(x), %phi4(x), %phi5(x)
		ret.32      %r4

where we can notice that %phi2, %phi3 and %phi4 in .L0 and .L6
are completly redundant, only one of them is needed. This also
violates the usual semantic of phi-nodes: one phi for each parent bb.

There is as much %phi such created as there is cases in the switch
statement and the same problem also occurs with an if-else and 2 %phis.

Whats' happening is the following:
- find_dominating_parents() search dominators for .L6
- try first parent: .L1, find nothing, thus recurses
- .L1 has 3 parents (the three cases): .L2, .L3, .L4
- each of them has .L0 as dominator, it's recorded as such but three times

The problem is fixed by checking the dominators list and refusing to create
more than one phisrc in the same basic block.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/flow.c b/flow.c
index 7db9548f..d8e253b1 100644
--- a/flow.c
+++ b/flow.c
@@ -316,6 +316,17 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 	return 1;
 }
 
+static int phisrc_in_bb(struct pseudo_list *list, struct basic_block *bb)
+{
+	pseudo_t p;
+	FOR_EACH_PTR(list, p) {
+		if (p->def->bb == bb)
+			return 1;
+	} END_FOR_EACH_PTR(p);
+
+	return 0;
+}
+
 static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
 	int local, int loads)
@@ -358,6 +369,8 @@ no_dominance:
 		continue;
 
 found_dominator:
+		if (dominators && phisrc_in_bb(*dominators, parent))
+			continue;
 		br = delete_last_instruction(&parent->insns);
 		phi = alloc_phi(parent, one->target, one->size);
 		phi->ident = phi->ident ? : pseudo->ident;
-- 
2.11.0

