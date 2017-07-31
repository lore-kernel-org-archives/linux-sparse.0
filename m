From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 2/7] fix infinite simplification loops
Date: Mon, 31 Jul 2017 22:36:19 +0200
Message-ID: <20170731203624.58971-3-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35245 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdGaUgf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so28955665wra.2
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:35 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Each time a parent is removed from a BB there is
the possibility that the BB become unreachable.
This in turn can create cycles of dead BBs which
can the create inifinite loops during the
simplification process.

Fix this by setting the flag REPEAT_CFG_CLEANUP when
a branch is rewritten, this will in turn trigger
a call to kill_unreachable_bbs() which will break
these loops.

Reported-by: Michael Stefaniuc <mstefani@mykolab.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                       |  3 ++-
 validation/infinite-loop02.c | 11 +++++++++++
 validation/infinite-loop03.c | 16 ++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/infinite-loop02.c
 create mode 100644 validation/infinite-loop03.c

diff --git a/flow.c b/flow.c
index fce8bde21..536bf257f 100644
--- a/flow.c
+++ b/flow.c
@@ -34,7 +34,8 @@ static int rewrite_branch(struct basic_block *bb,
 		return 0;
 
 	/* We might find new if-conversions or non-dominating CSEs */
-	repeat_phase |= REPEAT_CSE;
+	/* we may also create new dead cycles */
+	repeat_phase |= REPEAT_CSE | REPEAT_CFG_CLEANUP;
 	*ptr = new;
 	replace_bb_in_list(&bb->children, old, new, 1);
 	remove_bb_from_list(&old->parents, bb, 1);
diff --git a/validation/infinite-loop02.c b/validation/infinite-loop02.c
new file mode 100644
index 000000000..7d0761d87
--- /dev/null
+++ b/validation/infinite-loop02.c
@@ -0,0 +1,11 @@
+void foo(void)
+{
+	int a = 1;
+	while ((a = !a))
+		;
+}
+
+/*
+ * check-name: infinite loop 02
+ * check-command: sparse -Wno-decl $file
+ */
diff --git a/validation/infinite-loop03.c b/validation/infinite-loop03.c
new file mode 100644
index 000000000..ac8a9519d
--- /dev/null
+++ b/validation/infinite-loop03.c
@@ -0,0 +1,16 @@
+static void foo(int *buf)
+{
+	int a = 1;
+	int *b;
+	do {
+		if (a)
+			b = buf;
+		if (a)
+			*buf = 0;
+	} while (!(a = !a));
+}
+
+/*
+ * check-name: infinite loop 03
+ * check-command: sparse -Wno-decl $file
+ */
-- 
2.13.2

