From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: try_to_simplify_bb eargerness
Date: Fri, 16 Jun 2017 21:18:44 +0200
Message-ID: <20170616191844.86256-3-luc.vanoostenryck@gmail.com>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34438 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbdFPTS7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:18:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id 70so6632123wme.1
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:18:59 -0700 (PDT)
In-Reply-To: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The simplification done by try_to_simplify_bb() (essentially
trying to bypass a basic block containing a conditional branch
if the branch is controlled by an OP_PHI when the corresponding
OP_PHISRC is a constant) can only be done if some conditions
are met:
1) The basic block doesn't have some side effects (in which case
   it must not be bypassed). Checked by bb_has_side_effects().
2) There may be some pseudos defined in the basic block but no
   basic blocks may depend on them. Checked by bb_depends_on().

The second condition is efficiently checked using liveness
information. However, there is no liveness information done
for OP_PHI/OP_PHISRC. So if the basic block contains some
other OP_PHI than the controlling one, there will surely be
some other BB depending on it but this will not be reflected
in the liveness info and bb_depends_on() can then wrongly
report that no dependencies exist.

Fix this by adding an extra check, verifiying that no other
OP_PHI are defined in the BB and avoiding the simplification
otherwise.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c               | 25 +++++++++++++++++++++++++
 validation/crazy03.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 validation/crazy03.c

diff --git a/flow.c b/flow.c
index 8a9005aa6..23145d6e7 100644
--- a/flow.c
+++ b/flow.c
@@ -79,6 +79,29 @@ static int bb_depends_on(struct basic_block *target, struct basic_block *src)
 	return 0;
 }
 
+/*
+ * This is only to be used by try_to_simplify_bb().
+ * It really should be handled by bb_depends_on(), only
+ * that there is no liveness done on OP_PHI/OP_PHISRC.
+ * So we consider for now that if there is an OP_PHI
+ * then some block in fact depends on this one.
+ * The OP_PHI controling the conditional branch of this bb
+ * is excluded since the branch will be removed.
+ */
+static int bb_defines_phi(struct basic_block *bb, struct instruction *def)
+{
+	struct instruction *insn;
+	FOR_EACH_PTR(bb->insns, insn) {
+		switch (insn->opcode) {
+		case OP_PHI:
+			if (def && insn != def)
+				return 1;
+			continue;
+		}
+	} END_FOR_EACH_PTR(insn);
+	return 0;
+}
+
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -127,6 +150,8 @@ static int try_to_simplify_bb(struct basic_block *bb, struct instruction *first,
 		target = true ? second->bb_true : second->bb_false;
 		if (bb_depends_on(target, bb))
 			continue;
+		if (bb_defines_phi(bb, first))
+			continue;
 		changed |= rewrite_branch(source, &br->bb_true, bb, target);
 		changed |= rewrite_branch(source, &br->bb_false, bb, target);
 		if (changed && !bogus)
diff --git a/validation/crazy03.c b/validation/crazy03.c
new file mode 100644
index 000000000..042033790
--- /dev/null
+++ b/validation/crazy03.c
@@ -0,0 +1,33 @@
+extern char a;
+extern int b;
+extern char *c, *d;
+extern void e(void);
+extern void f(char *);
+
+int g(int h);
+int g(int h)
+{
+	if (h > 1)
+		e();
+	if (h > 1)
+		return 0;
+	for (;;) {
+		if (a) {
+			while (c) ;
+			b = 0;
+		} else {
+			c = (void*)0;
+			b = 1;
+		}
+		if (b) {
+			f(c);
+			continue;
+		}
+		d = c;
+		while (*c++) ;
+	}
+}
+
+/*
+ * check-name: crazy03.c
+ */
-- 
2.13.0

