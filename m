From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] CSE: support CSE of floating-point literal
Date: Wed, 12 Apr 2017 11:29:27 +0200
Message-ID: <20170412092927.23884-3-luc.vanoostenryck@gmail.com>
References: <20170412092927.23884-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33093 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdDLJbf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 05:31:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so5165196wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 02:31:34 -0700 (PDT)
In-Reply-To: <20170412092927.23884-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Before the introduction of OP_SETFVAL, floating-point were
created via OP_SETVAL whose CSE is done by comparing the
pointer of the corresponding expression without any
interpretation of this pointer.
As consequence, even if two OP_SETVAL have two identical
expressions (value), in most cases the corresponding pointers
are not identical, completly inhibiting the CSE of OP_SETVALs.

Fix the CSE of floating-point literals by directly using
the value given by the new OP_SETFVAL.

Note: to respect some of the subtilities of floating-point,
the equality comparison of two literals is not done on
the floating-point value itself but bit-by-bit on its
binary representation (as such we can continue to make the
distinction between +0.0 & -0.0, handle NaNs, ...).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                          | 11 +++++++++++
 validation/optim/cse-setfval.c | 12 ++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/optim/cse-setfval.c

diff --git a/cse.c b/cse.c
index f535636b4..cd1e8942c 100644
--- a/cse.c
+++ b/cse.c
@@ -89,6 +89,10 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 		hash += hashval(insn->val);
 		break;
 
+	case OP_SETFVAL:
+		hash += hashval(insn->fvalue);
+		break;
+
 	case OP_SYMADDR:
 		hash += hashval(insn->symbol);
 		break;
@@ -178,6 +182,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 {
 	const struct instruction *i1 = _i1;
 	const struct instruction *i2 = _i2;
+	int diff;
 
 	if (i1->opcode != i2->opcode)
 		return i1->opcode < i2->opcode ? -1 : 1;
@@ -240,6 +245,12 @@ static int insn_compare(const void *_i1, const void *_i2)
 			return i1->val < i2->val ? -1 : 1;
 		break;
 
+	case OP_SETFVAL:
+		diff = memcmp(&i1->fvalue, &i2->fvalue, sizeof(i1->fvalue));
+		if (diff)
+			return diff;
+		break;
+
 	/* Other */
 	case OP_PHI:
 		return phi_list_compare(i1->phi_list, i2->phi_list);
diff --git a/validation/optim/cse-setfval.c b/validation/optim/cse-setfval.c
new file mode 100644
index 000000000..59c00a407
--- /dev/null
+++ b/validation/optim/cse-setfval.c
@@ -0,0 +1,12 @@
+int ftest(double a, double b)
+{
+	return a == 0.125 || b == 0.125;
+}
+
+/*
+ * check-name: CSE OP_SETFVAL
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-pattern-1-times: setfval\\.
+ */
-- 
2.12.0

