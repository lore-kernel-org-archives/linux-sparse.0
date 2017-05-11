From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] ignore VOID when trying to if-convert phi-nodes
Date: Thu, 11 May 2017 22:46:17 +0200
Message-ID: <20170511204617.58622-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34345 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752826AbdEKUqX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 May 2017 16:46:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so5161985wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 11 May 2017 13:46:23 -0700 (PDT)
In-Reply-To: <CANeU7QmM5Rd6o8keZMHL-N2=_dKZg4iPg=M-FAYjqRpEavrj3Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Simple if-then-else expressions can often be
replaced by an OP_SELECT. This is done in a very
generic way by looking not at the test/if part but
at OP_PHIs which contain exactly 2 values.

An implementation detail makes that the address
of valid OP_PHI's sources must not change, so the
list holding these values must not be repacked and such.
As consequence, when a value need to be removed from the
list this value is simply replaced in the list by a VOID.
These VOIDs must then be ignored when processing OP_PHI's
sources.
But for the if-conversion, these VOID are not ignored
and are thus considered like any other value which in turn
make miss some optimization opportunities.
For example code like:
	int foo(int a)
	{
		if (a)
			return 0;
		else
			return 1;
		return 2;
	}

will be linearized into something like:
	...
	phi.32      %r2 <- %phi1, %phi2, VOID
	ret.32      %r2
where %phi1 & %phi2 correspond to the 'return 0' & 'return 1'
and the VOID correspond to the dead 'return 2'.
This code should be trivially be converted to a select
but is not because the OP_PHI is considered as having 3
elements instead of 2.

Worse, if at some moment we would have a phi list with:
	phi.32      %r2 <- %phi1, VOID
then the optimization would trigger but the corresponding
code make the assumption that the pseudos are the target
of an OP_PHISOURCE instruction, which VOIDs, of course,
are not and a crash should ensue.

Fix this by filtering out these VOIDs before checking the
conditions of the if-conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Changes since v1:
- partially address Chris remarks:
  - change how the negative return value is calculated
  - change the unneeded compare against zero
- change the name, comment, prototype and meaning of the
  function to make clear that what we're interested in here
  is the OP_PHISOURCE, not the %phi pseudos.
- add check to insure that we're indeed dealing with OP_PHISOURCEs
- add a paragraph in the commit log about a potential crash

 simplify.c                         | 41 ++++++++++++++++++++++++++++++++------
 validation/optim/void-if-convert.c | 19 ++++++++++++++++++
 2 files changed, 54 insertions(+), 6 deletions(-)
 create mode 100644 validation/optim/void-if-convert.c

diff --git a/simplify.c b/simplify.c
index 5d00937f1..7ae34b58f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -26,23 +26,52 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 	return first_basic_block(source->parents);
 }
 
+/*
+ * Copy the phi-node's phisrcs into to given array.
+ * Returns 0 if the the list contained the expected
+ * number of element, a positive number if there was
+ * more than expected and a negative one if less.
+ *
+ * Note: we can't reuse a function like linearize_ptr_list()
+ * because any VOIDs in the phi-list must be ignored here
+ * as in this context they mean 'entry has been removed'.
+ */
+static int get_phisources(struct instruction *sources[], int nbr, struct instruction *insn)
+{
+	pseudo_t phi;
+	int i = 0;
+
+	assert(insn->opcode == OP_PHI);
+	FOR_EACH_PTR(insn->phi_list, phi) {
+		struct instruction *def;
+		if (phi == VOID)
+			continue;
+		if (i >= nbr)
+			return 1;
+		def = phi->def;
+		assert(def->opcode == OP_PHISOURCE);
+		sources[i++] = def;
+	} END_FOR_EACH_PTR(phi);
+	return nbr - i;
+}
+
 static int if_convert_phi(struct instruction *insn)
 {
-	pseudo_t array[3];
+	struct instruction *array[2];
 	struct basic_block *parents[3];
 	struct basic_block *bb, *bb1, *bb2, *source;
 	struct instruction *br;
 	pseudo_t p1, p2;
 
 	bb = insn->bb;
-	if (linearize_ptr_list((struct ptr_list *)insn->phi_list, (void **)array, 3) != 2)
+	if (get_phisources(array, 2, insn))
 		return 0;
 	if (linearize_ptr_list((struct ptr_list *)bb->parents, (void **)parents, 3) != 2)
 		return 0;
-	p1 = array[0]->def->src1;
-	bb1 = array[0]->def->bb;
-	p2 = array[1]->def->src1;
-	bb2 = array[1]->def->bb;
+	p1 = array[0]->src1;
+	bb1 = array[0]->bb;
+	p2 = array[1]->src1;
+	bb2 = array[1]->bb;
 
 	/* Only try the simple "direct parents" case */
 	if ((bb1 != parents[0] || bb2 != parents[1]) &&
diff --git a/validation/optim/void-if-convert.c b/validation/optim/void-if-convert.c
new file mode 100644
index 000000000..66513c4dc
--- /dev/null
+++ b/validation/optim/void-if-convert.c
@@ -0,0 +1,19 @@
+int foo(int a)
+{
+	if (a)
+		return 0;
+	else
+		return 1;
+	return 2;
+}
+
+/*
+ * check-name: Ignore VOID in if-convert
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: phisrc\\.
+ * check-output-excludes: phi\\.
+ * check-output-excludes: VOID
+ * check-output-contains: seteq\\.
+ */
-- 
2.12.2

