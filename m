From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 3/5] simplify '(x * -1)' to '-x'
Date: Tue,  7 Feb 2017 21:50:26 +0100
Message-ID: <20170207205028.35869-4-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
 <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33153 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755096AbdBGUxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:53:18 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so30450239wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:52:37 -0800 (PST)
In-Reply-To: <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently we simplify multiplication by 1 but nothing is
done for multiplication by -1 which is equivalent to the
negation of its first operand.

This patch add this simplification.

Also add small test cases showing the simplification.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 11 +++++++++++
 validation/optim/muldiv-minus-one.c | 13 +++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 validation/optim/muldiv-minus-one.c

diff --git a/simplify.c b/simplify.c
index 91021dbb1..363cc5ad7 100644
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
 
@@ -320,6 +323,14 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	case OP_MULU:
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
+		if (!(value & sbit))	// positive
+			break;
+
+		value |= ~bits;
+		if (value == -1) {
+			insn->opcode = OP_NEG;
+			return REPEAT_CSE;
+		}
 	}
 
 	return 0;
diff --git a/validation/optim/muldiv-minus-one.c b/validation/optim/muldiv-minus-one.c
new file mode 100644
index 000000000..729b73443
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
2.11.0

