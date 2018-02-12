From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] kill dead loads
Date: Mon, 12 Feb 2018 23:02:44 +0100
Message-ID: <20180212220246.17750-8-luc.vanoostenryck@gmail.com>
References: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34200 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeBLWDC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Feb 2018 17:03:02 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21so10667658wmh.1
        for <linux-sparse@vger.kernel.org>; Mon, 12 Feb 2018 14:03:01 -0800 (PST)
In-Reply-To: <20180212220246.17750-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Like others instructions producing a value, OP_LOADs can be dead.

But currently, dead OP_LOAD are not removed as dead_insn() do
for others instructions.

Fix this by checking at simplification time if OP_LOADs are
dead and call kill_instruction() if it is the case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   |  6 +++++-
 validation/optim/load-dead.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/load-dead.c

diff --git a/simplify.c b/simplify.c
index f0dc69ff9..dbea438e7 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1195,7 +1195,11 @@ int simplify_instruction(struct instruction *insn)
 
 	case OP_NOT: case OP_NEG:
 		return simplify_unop(insn);
-	case OP_LOAD: case OP_STORE:
+	case OP_LOAD:
+		if (!has_users(insn->target))
+			return kill_instruction(insn);
+		/* fall-through */
+	case OP_STORE:
 		return simplify_memop(insn);
 	case OP_SYMADDR:
 		if (dead_insn(insn, NULL, NULL, NULL))
diff --git a/validation/optim/load-dead.c b/validation/optim/load-dead.c
new file mode 100644
index 000000000..52538cc2d
--- /dev/null
+++ b/validation/optim/load-dead.c
@@ -0,0 +1,11 @@
+void foo(int *p) { *p; }
+
+int *p;
+void bar(void) { *p; }
+
+/*
+ * check-name: load-dead
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ * check-output-excludes: load\\.
+ */
-- 
2.16.0

