From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 5/8] simplify ((A & M') | B ) & M when M' & M == 0
Date: Wed,  9 Aug 2017 01:06:31 +0200
Message-ID: <20170808230634.16227-6-luc.vanoostenryck@gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35567 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752495AbdHHXG7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:06:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id r77so4920375wmd.2
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:06:58 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is specially usefull when A is in fact undefined.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                             | 42 +++++++++++++++++++++-
 validation/optim/store-load-bitfield.c | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/store-load-bitfield.c

diff --git a/simplify.c b/simplify.c
index 8b63bcaff..9893613da 100644
--- a/simplify.c
+++ b/simplify.c
@@ -502,6 +502,46 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 	}
 }
 
+static int simplify_and_or_mask(struct instruction *insn, pseudo_t and, pseudo_t other, unsigned long long mask)
+{
+	struct instruction *def = and->def;
+	pseudo_t old;
+
+	if (!constant(def->src2))
+		return 0;
+	if (def->src2->value & mask)
+		return 0;
+	old = insn->src1;
+	use_pseudo(insn, other, &insn->src1);
+	remove_usage(old, &insn->src1);
+	return REPEAT_CSE;
+}
+
+static int simplify_constant_mask(struct instruction *insn, unsigned long long mask)
+{
+	struct instruction *left;
+	pseudo_t src1, src2;
+
+	switch (def_opcode(insn->src1)) {
+	case OP_OR:
+		// Let's handle ((A & M') | B ) & M
+		// or           (B | (A & M')) & M
+		// when M' & M == 0
+		left = insn->src1->def;
+		src1 = left->src1;
+		src2 = left->src2;
+		if (def_opcode(src1) == OP_AND)
+			return simplify_and_or_mask(insn, src1, src2, mask);
+		if (def_opcode(src2) == OP_AND)
+			return simplify_and_or_mask(insn, src2, src1, mask);
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value = insn->src2->value;
@@ -546,7 +586,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_AND:
 		if (!value)
 			return replace_with_pseudo(insn, insn->src2);
-		return 0;
+		return simplify_constant_mask(insn, value);
 
 	case OP_SET_NE:
 	case OP_SET_EQ:
diff --git a/validation/optim/store-load-bitfield.c b/validation/optim/store-load-bitfield.c
new file mode 100644
index 000000000..b74022602
--- /dev/null
+++ b/validation/optim/store-load-bitfield.c
@@ -0,0 +1,66 @@
+int ufoo(int a)
+{
+	struct u {
+		unsigned int :2;
+		unsigned int a:3;
+	} bf;
+
+	bf.a = a;
+	return bf.a;
+}
+
+int sfoo(int a)
+{
+	struct s {
+		signed int :2;
+		signed int a:3;
+	} bf;
+
+	bf.a = a;
+	return bf.a;
+}
+
+int xfoo(int a)
+{
+	struct x {
+		int :2;
+		int a:3;	// unsigned !
+	} bf;
+
+	bf.a = a;
+	return bf.a;
+}
+
+
+/*
+ * check-name: optim store/load bitfields
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+ufoo:
+.L0:
+	<entry-point>
+	scast.3     %r2 <- (32) %arg1
+	and.32      %r9 <- %r2, $7
+	ret.32      %r9
+
+
+sfoo:
+.L2:
+	<entry-point>
+	scast.3     %r13 <- (32) %arg1
+	and.32      %r20 <- %r13, $7
+	scast.32    %r21 <- (3) %r20
+	ret.32      %r21
+
+
+xfoo:
+.L4:
+	<entry-point>
+	scast.3     %r24 <- (32) %arg1
+	and.32      %r31 <- %r24, $7
+	ret.32      %r31
+
+
+ * check-output-end
+ */
-- 
2.13.2

