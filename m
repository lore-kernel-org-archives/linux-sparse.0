From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 04/14] rewrite compare_opcode() like swap_compare_opcode()
Date: Sat, 25 Mar 2017 00:14:11 +0100
Message-ID: <20170324231421.14869-5-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34163 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755326AbdCXXOd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id u132so786524wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:32 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

More precisely, use a table to get the opcdoe corresponding
to the negated compare and use a more explicit name for the
function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/simplify.c b/simplify.c
index e3296a830..deacf97b4 100644
--- a/simplify.c
+++ b/simplify.c
@@ -403,28 +403,27 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	return 0;
 }
 
-static int compare_opcode(int opcode, int inverse)
+static int negate_compare_opcode(int opcode, int inverse)
 {
-	if (!inverse)
-		return opcode;
-
-	switch (opcode) {
-	case OP_SET_EQ:	return OP_SET_NE;
-	case OP_SET_NE:	return OP_SET_EQ;
-
-	case OP_SET_LT:	return OP_SET_GE;
-	case OP_SET_LE:	return OP_SET_GT;
-	case OP_SET_GT:	return OP_SET_LE;
-	case OP_SET_GE:	return OP_SET_LT;
+	static const unsigned char opcode_tbl[] = {
+		[OP_SET_EQ - OP_BINCMP] = OP_SET_NE,
+		[OP_SET_NE - OP_BINCMP] = OP_SET_EQ,
+		[OP_SET_GT - OP_BINCMP] = OP_SET_LE,
+		[OP_SET_GE - OP_BINCMP] = OP_SET_LT,
+		[OP_SET_LE - OP_BINCMP] = OP_SET_GT,
+		[OP_SET_LT - OP_BINCMP] = OP_SET_GE,
+		[OP_SET_A  - OP_BINCMP] = OP_SET_BE,
+		[OP_SET_AE - OP_BINCMP] = OP_SET_B ,
+		[OP_SET_BE - OP_BINCMP] = OP_SET_A ,
+		[OP_SET_B  - OP_BINCMP] = OP_SET_AE,
+	};
 
-	case OP_SET_A:	return OP_SET_BE;
-	case OP_SET_AE:	return OP_SET_B;
-	case OP_SET_B:	return OP_SET_AE;
-	case OP_SET_BE:	return OP_SET_A;
+	assert(opcode >= OP_BINCMP && opcode <= OP_BINCMP_END);
 
-	default:
+	if (!inverse)
 		return opcode;
-	}
+
+	return opcode_tbl[opcode - OP_BINCMP];
 }
 
 static int swap_compare_opcode(int opcode)
@@ -474,7 +473,7 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		// and similar for setne/eq ... 0/1
 		src1 = def->src1;
 		src2 = def->src2;
-		insn->opcode = compare_opcode(opcode, inverse);
+		insn->opcode = negate_compare_opcode(opcode, inverse);
 		use_pseudo(insn, src1, &insn->src1);
 		use_pseudo(insn, src2, &insn->src2);
 		remove_usage(old, &insn->src1);
-- 
2.12.0

