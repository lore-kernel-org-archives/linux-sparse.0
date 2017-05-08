From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix: kill unreachable BBs after killing a child
Date: Mon,  8 May 2017 20:57:10 +0200
Message-ID: <20170508185710.22021-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36579 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753948AbdEHS5f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 8 May 2017 14:57:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so17413383wmu.3
        for <linux-sparse@vger.kernel.org>; Mon, 08 May 2017 11:57:34 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When simplifying a switch into a simple branch all the now
unused children of the current BB must be removed.
If one of these children become now orphaned, it is directly
killed (it will need to be killed soon or later since it is
unreachable).

However, if one of the killed children is the header of a loop
where some variables are updated this may cause problems.
Indeed, by killing the header (which contains the phisrc of
the entry value of the variable) the whole loop may become
unreachable but is not killed yet, OTOH simplification of
the associated OP_PHI may create a cycle which may then be
detected later by simplify_one_memop() which will issue a
"crazy programmer" warning while the programmer was innocent.

This situation can be seen in code like:
	int *p;
	switch (i - i) {	// will be optimized to 0
	case 0:			// will be the simple branch
		return 0;
	case 1:			// will be optimized away
		p = ptr;
		do {		// will be an unreachable loop
			*p++ = 123;
		} while (--i);
	}

Fix this by calling kill_unreachable_bbs() after having
simplified the switch into a branch. This will avoid to
create a cycle with because of the removed phisrc in the
header and as an added benefit will avoid to waste time
trying to simplify BBs that are unreachable.

In addition, it's now useless to call kill_bb() for each
removed switch's children as kill_unreachable_bbs() will
do that too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                 |  3 +--
 validation/crazy02-not-so.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 validation/crazy02-not-so.c

diff --git a/linearize.c b/linearize.c
index a9f36b823..ee9591897 100644
--- a/linearize.c
+++ b/linearize.c
@@ -642,8 +642,6 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 static void remove_parent(struct basic_block *child, struct basic_block *parent)
 {
 	remove_bb_from_list(&child->parents, parent, 1);
-	if (!child->parents)
-		kill_bb(child);
 }
 
 /* Change a "switch" into a branch */
@@ -670,6 +668,7 @@ void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic
 		remove_parent(child, bb);
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
+	kill_unreachable_bbs(bb->ep);
 }
 	
 
diff --git a/validation/crazy02-not-so.c b/validation/crazy02-not-so.c
new file mode 100644
index 000000000..fe7133587
--- /dev/null
+++ b/validation/crazy02-not-so.c
@@ -0,0 +1,22 @@
+int foo(int *ptr, int i)
+{
+	int *p;
+
+	switch (i - i) {		// will be optimized to 0
+	case 0:
+		return 0;
+	case 1:				// will be optimized away
+		p = ptr;
+		do {			// will be an unreachable loop
+			*p++ = 123;
+		} while (--i);
+		break;
+	}
+
+	return 1;
+}
+
+/*
+ * check-name: crazy02-not-so.c
+ * check-command: sparse -Wno-decl $file
+ */
-- 
2.12.0

