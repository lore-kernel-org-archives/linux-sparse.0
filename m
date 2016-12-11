From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] simplify '(x || x)' and '(x && x)'
Date: Sun, 11 Dec 2016 22:13:28 +0100
Message-ID: <20161211211328.26735-4-luc.vanoostenryck@gmail.com>
References: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34935 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbcLKVQE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 16:16:04 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so7108372wme.2
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 13:16:03 -0800 (PST)
In-Reply-To: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The operators '||' and '&&' being idempotent, the expressions
'(x || x)' and '(x && x)' can be simplified to a test against zero.

Note: they could even be replaced by 'x' itself but only if 'x' is
already a boolean expression/has already been tested against zero.
If it is the case, the redundant test this will be optimized away
in further steps.

For example, test-linearize on the following code:
	int ior(int a) { return a || a; }
emitted the following instructions:
	or-bool.32  %r3 <- %arg1, %arg1
after the patch, it now emits:
	setne.32    %r3 <- %arg1, $0
which is easier to combine with others simplifications.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                        |  8 ++++----
 validation/optim/bool-same-args.c | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)
 create mode 100644 validation/optim/bool-same-args.c

diff --git a/simplify.c b/simplify.c
index d076ebb5..169561fd 100644
--- a/simplify.c
+++ b/simplify.c
@@ -578,10 +578,10 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 
 	case OP_AND_BOOL:
 	case OP_OR_BOOL:
-		// simplification is correct only if the operands
-		// have already been compared against zero which
-		// is not enforced.
-		break;
+		remove_usage(arg, &insn->src2);
+		insn->src2 = value_pseudo(0);
+		insn->opcode = OP_SET_NE;
+		return REPEAT_CSE;
 
 	default:
 		break;
diff --git a/validation/optim/bool-same-args.c b/validation/optim/bool-same-args.c
new file mode 100644
index 00000000..0ae4684e
--- /dev/null
+++ b/validation/optim/bool-same-args.c
@@ -0,0 +1,12 @@
+static int ior(int a) { return a || a; }
+static int and(int a) { return a && a; }
+
+/*
+ * check-name: bool-same-args
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: or-bool\\.
+ * check-output-excludes: and-bool\\.
+ * check-output-contains: setne\\.
+ */
-- 
2.10.2

