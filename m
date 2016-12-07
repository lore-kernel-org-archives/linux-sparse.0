From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/5] simplify '(x * -1)' to '-x'
Date: Wed,  7 Dec 2016 16:46:53 +0100
Message-ID: <20161207154655.98109-4-luc.vanoostenryck@gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36652 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLGPrI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so28578517wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:07 -0800 (PST)
In-Reply-To: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently we simplify multiplication by 1 but nothing is
done for multiplication by -1 which is equivalent to the
negation of its first operand.

This patch add this simplification.

Also add small test cases showing the simplification.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 12 ++++++++++++
 validation/optim/muldiv-minus-one.c | 13 +++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 validation/optim/muldiv-minus-one.c

diff --git a/simplify.c b/simplify.c
index 5541fc4c..6c7c79e9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -312,6 +312,9 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 
 static int simplify_mul_div(struct instruction *insn, long long value)
 {
+	unsigned long long sbit = 1ULL << (insn->size - 1);
+	unsigned long long bits = sbit | (sbit - 1);
+
 	if (value == 1)
 		return replace_with_pseudo(insn, insn->src1);
 
@@ -320,6 +323,15 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	case OP_MULU:
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
+
+		if (!(value & sbit))	// positive
+			break;
+
+		value |= ~bits;
+		if (value == -1) {
+			insn->opcode = OP_NEG;
+			return REPEAT_CSE;
+		}
 	/* Fall through */
 	case OP_DIVS:
 	case OP_DIVU:
diff --git a/validation/optim/muldiv-minus-one.c b/validation/optim/muldiv-minus-one.c
new file mode 100644
index 00000000..729b7344
--- /dev/null
+++ b/validation/optim/muldiv-minus-one.c
@@ -0,0 +1,13 @@
+typedef	unsigned int u32;
+
+int smulm1(int a) { return a * -1; }
+u32 umulm1(u32 a) { return a * (u32) -1; }
+
+/*
+ * check-name: muldiv-minus-one
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: mul[us]\\.
+ * check-output-contains: neg\\.
+ */
-- 
2.10.2

