From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify '~(~x)' and '-(-x)' to 'x'
Date: Wed,  7 Dec 2016 17:05:47 +0100
Message-ID: <20161207160547.9821-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35681 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbcLGQGk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 11:06:40 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so28829422wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 08:05:52 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently those double operations are not simplified.

This patch add those simplifications and some small test cases.

Note: the 'boolean not': '!(!x)' is not handled by this patch
because this operator is processed differently (it doesn't generate
an unop instruction but directly generates 'seteq' operations).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

WARNING: the test cases, to give the correct results, need the patches
from the serie "fix uses of killed instructions" sent previously.


 simplify.c                     | 17 +++++++++++++++++
 validation/optim/double-unop.c | 15 +++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 validation/optim/double-unop.c

diff --git a/simplify.c b/simplify.c
index b5cd0ea7..7e4bce5b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -588,6 +588,23 @@ static int simplify_unop(struct instruction *insn)
 		return REPEAT_CSE;
 	if (constant(insn->src1))
 		return simplify_constant_unop(insn);
+
+	switch (insn->opcode) {
+		struct instruction *def;
+
+	case OP_NOT:
+		def = insn->src->def;
+		if (def && def->opcode == OP_NOT)
+			return replace_with_pseudo(insn, def->src);
+		break;
+	case OP_NEG:
+		def = insn->src->def;
+		if (def && def->opcode == OP_NEG)
+			return replace_with_pseudo(insn, def->src);
+		break;
+	default:
+		return 0;
+	}
 	return 0;
 }
 
diff --git a/validation/optim/double-unop.c b/validation/optim/double-unop.c
new file mode 100644
index 00000000..f0e6d94f
--- /dev/null
+++ b/validation/optim/double-unop.c
@@ -0,0 +1,15 @@
+typedef unsigned int u32;
+
+u32 unotnot(u32 a) { return ~(~a); }
+int snotnot(int a) { return ~(~a); }
+u32 unegneg(int a) { return -(-a); }
+int snegneg(int a) { return -(-a); }
+
+/*
+ * check-name: double-unop
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: not\\.
+ * check-output-excludes: neg\\.
+ */
-- 
2.10.2

