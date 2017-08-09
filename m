From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 6/9] simplify ((A & M') | B ) & M when M' & M == 0
Date: Wed,  9 Aug 2017 21:38:03 +0200
Message-ID: <20170809193806.30975-7-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33837 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHITjG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:39:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id x64so618341wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:39:05 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is specially usefull when A is in fact undefined.

Reported-by: Dibyendu Majumdar <mobile@majumdar.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                             | 42 +++++++++++++++++++++-
 validation/optim/store-load-bitfield.c | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 validation/optim/store-load-bitfield.c

diff --git a/simplify.c b/simplify.c
index 30961cf39..40d4f0068 100644
--- a/simplify.c
+++ b/simplify.c
@@ -501,6 +501,46 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
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
@@ -545,7 +585,7 @@ static int simplify_constant_rightside(struct instruction *insn)
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
2.14.0

