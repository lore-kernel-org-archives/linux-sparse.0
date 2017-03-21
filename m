From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 03/63] canonicalize compare instructions
Date: Tue, 21 Mar 2017 01:15:07 +0100
Message-ID: <20170321001607.75169-4-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36427 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCUAQY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:24 -0400
Received: by mail-wr0-f195.google.com with SMTP id l37so20367106wrc.3
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:22 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/simplify.c b/simplify.c
index 66035bbce..da40caa65 100644
--- a/simplify.c
+++ b/simplify.c
@@ -427,6 +427,26 @@ static int compare_opcode(int opcode, int inverse)
 	}
 }
 
+static int compare_swap(int opcode)
+{
+	switch (opcode) {
+	case OP_SET_EQ:	return OP_SET_EQ;
+	case OP_SET_NE:	return OP_SET_NE;
+
+	case OP_SET_LT:	return OP_SET_GT;
+	case OP_SET_LE:	return OP_SET_GE;
+	case OP_SET_GT:	return OP_SET_LT;
+	case OP_SET_GE:	return OP_SET_LE;
+
+	case OP_SET_A:	return OP_SET_B;
+	case OP_SET_AE:	return OP_SET_BE;
+	case OP_SET_B:	return OP_SET_A;
+	case OP_SET_BE:	return OP_SET_AE;
+	default:
+		return opcode;
+	}
+}
+
 static int simplify_seteq_setne(struct instruction *insn, long long value)
 {
 	pseudo_t old = insn->src1;
@@ -744,6 +764,14 @@ static int canonicalize_commutative(struct instruction *insn)
 	return repeat_phase |= REPEAT_CSE;
 }
 
+static int canonicalize_compare(struct instruction *insn)
+{
+	int repeat = canonicalize_commutative(insn);
+	if (repeat)
+		insn->opcode = compare_swap(insn->opcode);
+	return repeat;
+}
+
 static inline int simple_pseudo(pseudo_t pseudo)
 {
 	return pseudo->type == PSEUDO_VAL || pseudo->type == PSEUDO_SYM;
@@ -1139,15 +1167,17 @@ int simplify_instruction(struct instruction *insn)
 		canonicalize_commutative(insn);
 		return simplify_binop(insn);
 
+	case OP_SET_LE: case OP_SET_GE:
+	case OP_SET_LT: case OP_SET_GT:
+	case OP_SET_B:  case OP_SET_A:
+	case OP_SET_BE: case OP_SET_AE:
+		canonicalize_compare(insn);
+		/* fall through */
 	case OP_SUB:
 	case OP_DIVU: case OP_DIVS:
 	case OP_MODU: case OP_MODS:
 	case OP_SHL:
 	case OP_LSR: case OP_ASR:
-	case OP_SET_LE: case OP_SET_GE:
-	case OP_SET_LT: case OP_SET_GT:
-	case OP_SET_B:  case OP_SET_A:
-	case OP_SET_BE: case OP_SET_AE:
 		return simplify_binop(insn);
 
 	case OP_NOT: case OP_NEG:
-- 
2.12.0

