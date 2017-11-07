From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] volatile loads are side-effects too
Date: Tue,  7 Nov 2017 16:59:44 +0100
Message-ID: <20171107155944.68463-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53075 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752695AbdKGP7x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Nov 2017 10:59:53 -0500
Received: by mail-wm0-f68.google.com with SMTP id t139so4963957wmt.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Nov 2017 07:59:52 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some branch simplifications are only valid if the branch is free
of side-effects. The check is done in flow.c:bb_has_side_effects()
but currently deosn't take in account the fact that a volatile load
is also a side-effect.

Fix this by adding the appropriate check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                                  |  7 +++++++
 validation/optim/volatile-side-effect.c | 13 +++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 validation/optim/volatile-side-effect.c

diff --git a/flow.c b/flow.c
index 6b2c879a8..1144bff4e 100644
--- a/flow.c
+++ b/flow.c
@@ -169,6 +169,13 @@ static int bb_has_side_effects(struct basic_block *bb)
 			/* FIXME! This should take "const" etc into account */
 			return 1;
 
+		case OP_LOAD:
+			if (!insn->type)
+				return 1;
+			if (insn->type->ctype.modifiers & MOD_VOLATILE)
+				return 1;
+			continue;
+
 		case OP_STORE:
 		case OP_CONTEXT:
 			return 1;
diff --git a/validation/optim/volatile-side-effect.c b/validation/optim/volatile-side-effect.c
new file mode 100644
index 000000000..842b72282
--- /dev/null
+++ b/validation/optim/volatile-side-effect.c
@@ -0,0 +1,13 @@
+void foo(int p, volatile int *ptr)
+{
+	p ? : *ptr;
+	p ? : *ptr;
+}
+
+/*
+ * check-name: volatile-side-effect
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-pattern(2): load
+ */
-- 
2.14.0

