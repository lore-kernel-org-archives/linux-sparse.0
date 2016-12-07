From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] simplify '(x || 1)' to '1'
Date: Wed,  7 Dec 2016 17:13:24 +0100
Message-ID: <20161207161324.15619-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33790 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753226AbcLGQNb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 11:13:31 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so50667775wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 08:13:30 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is simplifications for:
	(x && 0) => 0
	(x && 1) => x
	(x || 0) => x
but the fourth case '(x || 1)' is missing.

This patch add the missing simplification and a small test case.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       |  7 +++++-
 validation/optim/bool-simplify.c | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/bool-simplify.c

diff --git a/simplify.c b/simplify.c
index b5cd0ea7..da12ebe8 100644
--- a/simplify.c
+++ b/simplify.c
@@ -315,6 +315,11 @@ static int simplify_constant_rightside(struct instruction *insn)
 	long long value = insn->src2->value;
 
 	switch (insn->opcode) {
+	case OP_OR_BOOL:
+		if (value == 1)
+			return replace_with_pseudo(insn, insn->src2);
+		goto case_neutral_zero;
+
 	case OP_SUB:
 		if (value) {
 			insn->opcode = OP_ADD;
@@ -324,9 +329,9 @@ static int simplify_constant_rightside(struct instruction *insn)
 	/* Fall through */
 	case OP_ADD:
 	case OP_OR: case OP_XOR:
-	case OP_OR_BOOL:
 	case OP_SHL:
 	case OP_LSR:
+	case_neutral_zero:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src1);
 		return 0;
diff --git a/validation/optim/bool-simplify.c b/validation/optim/bool-simplify.c
new file mode 100644
index 00000000..e0ff1c2d
--- /dev/null
+++ b/validation/optim/bool-simplify.c
@@ -0,0 +1,51 @@
+int and_0(int a)
+{
+	return a && 0;
+}
+
+int and_1(int a)
+{
+	return a && 1;
+}
+
+int or_0(int a)
+{
+	return a || 0;
+}
+
+int or_1(int a)
+{
+	return a || 1;
+}
+
+/*
+ * check-name: bool-simplify
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+and_0:
+.L0:
+	<entry-point>
+	ret.32      $0
+
+
+and_1:
+.L2:
+	<entry-point>
+	ret.32      %arg1
+
+
+or_0:
+.L4:
+	<entry-point>
+	ret.32      %arg1
+
+
+or_1:
+.L6:
+	<entry-point>
+	ret.32      $1
+
+
+ * check-output-end
+ */
-- 
2.10.2

