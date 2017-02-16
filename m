From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/16] add killing of non-volatile loads
Date: Thu, 16 Feb 2017 05:57:03 +0100
Message-ID: <20170216045708.50661-12-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36201 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbdBPE50 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id r18so1284837wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:25 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_LOADs were ignored by kill_instruction() but there are two cases
were something can or must be done:
1) if the is not a volatile one, it is free of side-effects and can thus
   be optimized away like others instructions.
2) if force-killed then we need to adjust the usage of its operand.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c             |  6 ++++++
 validation/kill-load.c | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/kill-load.c

diff --git a/simplify.c b/simplify.c
index b80d05b87..a27f6a33a 100644
--- a/simplify.c
+++ b/simplify.c
@@ -249,6 +249,12 @@ void kill_insn(struct instruction *insn, int force)
 			kill_use(&insn->func);
 		break;
 
+	case OP_LOAD:
+		if (!force && insn->type->ctype.modifiers & MOD_VOLATILE)
+			return;
+		kill_use(&insn->src);
+		break;
+
 	case OP_ENTRY:
 		/* ignore */
 		return;
diff --git a/validation/kill-load.c b/validation/kill-load.c
new file mode 100644
index 000000000..45fb83e4b
--- /dev/null
+++ b/validation/kill-load.c
@@ -0,0 +1,17 @@
+int keep(volatile int *p)	{ return *p && 0; }
+int kill(int *p, int i)		{ return *p && 0; }
+void ind(volatile int *p,int i)	{ int v = i++; if (i && 0) p[v]; }
+
+
+/*
+ * check-name: kill-load
+ * check-command: test-linearize -Wno-decl $file
+ * check-description:
+ *	Check that loads are optimized away but only
+ *	when needed:
+ *	- non-volatile
+ *	- bb unreachable.
+ *
+ * check-output-ignore
+ * check-output-pattern-1-times: load\\.
+ */
-- 
2.11.0

