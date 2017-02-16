From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/16] add killing of pure calls
Date: Thu, 16 Feb 2017 05:57:01 +0100
Message-ID: <20170216045708.50661-10-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33252 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbdBPE5Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:24 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so1299456wmv.0
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:23 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_CALL were ignored by kill_instruction() but there are two cases
were something can or must be done:
1) if the function is pure, it is free of side-effects and can thus
   be optimized away like others instructions.
2) if force-killed then we need to adjust the usage of all the arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                  | 11 +++++++++++
 validation/kill-pure-call.c | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 validation/kill-pure-call.c

diff --git a/simplify.c b/simplify.c
index b8944f0f7..cacf81f9f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -236,6 +236,17 @@ void kill_insn(struct instruction *insn, int force)
 		kill_use(&insn->cond);
 		break;
 
+	case OP_CALL:
+		if (!force) {
+			/* a "pure" function can be killed too */
+			if (!(insn->func->type == PSEUDO_SYM))
+				return;
+			if (!(insn->func->sym->ctype.modifiers & MOD_PURE))
+				return;
+		}
+		kill_use_list(insn->arguments);
+		break;
+
 	case OP_ENTRY:
 		/* ignore */
 		return;
diff --git a/validation/kill-pure-call.c b/validation/kill-pure-call.c
new file mode 100644
index 000000000..d3f78c026
--- /dev/null
+++ b/validation/kill-pure-call.c
@@ -0,0 +1,17 @@
+int side(int a);
+int pure(int a) __attribute__((pure));
+
+int keep(int a) { return side(a) && 0; }
+int kill(int a) { return pure(a) && 0; }
+
+/*
+ * check-name: kill-pure-call
+ * check-command: test-linearize -Wno-decl $file
+ * check-description:
+ *	See that the call is optimized away but only
+ *	when the function is "pure".
+ *
+ * check-output-ignore
+ * check-output-contains: call\\..* side
+ * check-output-excludes: call\\..* pure
+ */
-- 
2.11.0

