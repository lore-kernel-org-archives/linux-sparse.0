From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/16] add killing of stores
Date: Thu, 16 Feb 2017 05:57:04 +0100
Message-ID: <20170216045708.50661-13-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36204 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbdBPE51 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1284869wmd.3
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:26 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

OP_STOREs were ignored by kill_instruction() but if it is force-killed
because the basic block it belong became unreachable then we need to
adjust the usage of its operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c              |  7 +++++++
 validation/kill-store.c | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/kill-store.c

diff --git a/simplify.c b/simplify.c
index a27f6a33a..804467f0d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -255,6 +255,13 @@ void kill_insn(struct instruction *insn, int force)
 		kill_use(&insn->src);
 		break;
 
+	case OP_STORE:
+		if (!force)
+			return;
+		kill_use(&insn->src);
+		kill_use(&insn->target);
+		break;
+
 	case OP_ENTRY:
 		/* ignore */
 		return;
diff --git a/validation/kill-store.c b/validation/kill-store.c
new file mode 100644
index 000000000..8f7253226
--- /dev/null
+++ b/validation/kill-store.c
@@ -0,0 +1,16 @@
+void keep(int *p)	 { *p = 0; }
+void kill(int *p, int i) { if (i && 0) *p = 0; }
+void dead(int *p, int i) { int v = i++; if (i && 0) p[v] = 0; }
+
+
+/*
+ * check-name: kill-store
+ * check-command: test-linearize -Wno-decl $file
+ * check-description:
+ *	Check that stores are optimized away but only
+ *	when needed:
+ *	- bb unreachable.
+ *
+ * check-output-ignore
+ * check-output-pattern-1-times: store\\.
+ */
-- 
2.11.0

