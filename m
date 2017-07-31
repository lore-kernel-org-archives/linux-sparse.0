From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 7/7] fix crash with sym->bb_target == NULL
Date: Mon, 31 Jul 2017 22:36:24 +0200
Message-ID: <20170731203624.58971-8-luc.vanoostenryck@gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37825 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdGaUgm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 31 Jul 2017 16:36:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so212466wmt.4
        for <linux-sparse@vger.kernel.org>; Mon, 31 Jul 2017 13:36:41 -0700 (PDT)
In-Reply-To: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Michael Stefaniuc <mstefani@mykolab.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                  |  5 ++++-
 validation/crash-bb_target.c | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 validation/crash-bb_target.c

diff --git a/linearize.c b/linearize.c
index 12209492b..ba76397ea 100644
--- a/linearize.c
+++ b/linearize.c
@@ -334,6 +334,7 @@ const char *show_instruction(struct instruction *insn)
 		
 	case OP_SETVAL: {
 		struct expression *expr = insn->val;
+		struct symbol *sym;
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 
 		if (!expr) {
@@ -355,7 +356,9 @@ const char *show_instruction(struct instruction *insn)
 			buf += sprintf(buf, "%s", show_ident(expr->symbol->ident));
 			break;
 		case EXPR_LABEL:
-			buf += sprintf(buf, ".L%u", expr->symbol->bb_target->nr);
+			sym = expr->symbol;
+			if (sym->bb_target)
+				buf += sprintf(buf, ".L%u", sym->bb_target->nr);
 			break;
 		default:
 			buf += sprintf(buf, "SETVAL EXPR TYPE %d", expr->type);
diff --git a/validation/crash-bb_target.c b/validation/crash-bb_target.c
new file mode 100644
index 000000000..bc5a3d354
--- /dev/null
+++ b/validation/crash-bb_target.c
@@ -0,0 +1,10 @@
+a() {
+  &&b
+
+/*
+ * check-name: crash bb_target
+ * check-command: test-linearize $file
+ *
+ * check-error-ignore
+ * check-output-ignore
+ */
-- 
2.13.2

