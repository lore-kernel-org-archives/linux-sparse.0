From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] kill dead loads
Date: Thu,  8 Jun 2017 09:39:27 +0200
Message-ID: <20170608073927.55218-4-luc.vanoostenryck@gmail.com>
References: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35252 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbdFHHjn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Jun 2017 03:39:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id g15so5868678wmc.2
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jun 2017 00:39:43 -0700 (PDT)
In-Reply-To: <20170608073927.55218-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Like others instructions producing a value, OP_LOADs can be dead.

But currently, dead OP_LOAD are not removed, as dead_insn() do for
others instructions.

Fix this by checking at simplification time if OP_LOADs are dead
and call kill_instruction() if it is the case.

NOTE: the fix is the exact same logic than dead_insn() but dead_insn()
      kill without discrimination. In our case we want to keep volatiles
      OP_LOADs which kill_instruction() does and dead_insn() does not.
      Ideally, dead_insn() should use kill_instruction() but this is
      a bigger change which will part of another series.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                   |  6 +++++-
 validation/optim/load-dead.c | 11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/load-dead.c

diff --git a/simplify.c b/simplify.c
index d5e219200..2c95d8b86 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1189,7 +1189,11 @@ int simplify_instruction(struct instruction *insn)
 
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
2.13.0

