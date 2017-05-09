From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] ignore VOID when trying to if-convert phi-nodes
Date: Wed, 10 May 2017 00:06:19 +0200
Message-ID: <20170509220619.72375-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33699 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdEIWIq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 May 2017 18:08:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so3621014wrc.0
        for <linux-sparse@vger.kernel.org>; Tue, 09 May 2017 15:08:46 -0700 (PDT)
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
make miss some optimizatin opportunities.
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

Fix this by filtering out these VOIDs before checking the
conditions of the if-conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                         | 25 +++++++++++++++++++++++--
 validation/optim/void-if-convert.c | 19 +++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 validation/optim/void-if-convert.c

diff --git a/simplify.c b/simplify.c
index 5d00937f1..cf9ca15f2 100644
--- a/simplify.c
+++ b/simplify.c
@@ -26,16 +26,37 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
 	return first_basic_block(source->parents);
 }
 
+/*
+ * Essentially the same as linearize_ptr_list()
+ * but ignoring VOID.
+ * Returns 0 if the the list contained the expected
+ * number of element, 1 or -1 if there was more or less.
+ */
+static int get_phi_list(pseudo_t array[], int n, struct pseudo_list *list)
+{
+	pseudo_t phi;
+	int i = 0;
+
+	FOR_EACH_PTR(list, phi) {
+		if (phi == VOID)
+			continue;
+		if (i >= n)
+			return 1;
+		array[i++] = phi;
+	} END_FOR_EACH_PTR(phi);
+	return (i == n) ? 0 : -1;
+}
+
 static int if_convert_phi(struct instruction *insn)
 {
-	pseudo_t array[3];
+	pseudo_t array[2];
 	struct basic_block *parents[3];
 	struct basic_block *bb, *bb1, *bb2, *source;
 	struct instruction *br;
 	pseudo_t p1, p2;
 
 	bb = insn->bb;
-	if (linearize_ptr_list((struct ptr_list *)insn->phi_list, (void **)array, 3) != 2)
+	if (get_phi_list(array, 2, insn->phi_list) != 0)
 		return 0;
 	if (linearize_ptr_list((struct ptr_list *)bb->parents, (void **)parents, 3) != 2)
 		return 0;
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
2.12.0

