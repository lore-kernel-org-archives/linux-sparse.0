From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 02/63] allow binop simplification after canonicalization
Date: Tue, 21 Mar 2017 01:15:06 +0100
Message-ID: <20170321001607.75169-3-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35837 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdCUAQX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:23 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so20435059wrb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:22 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/simplify.c b/simplify.c
index 5d00937f1..66035bbce 100644
--- a/simplify.c
+++ b/simplify.c
@@ -735,13 +735,13 @@ static int canonical_order(pseudo_t p1, pseudo_t p2)
 	return 1;
 }
 
-static int simplify_commutative_binop(struct instruction *insn)
+static int canonicalize_commutative(struct instruction *insn)
 {
-	if (!canonical_order(insn->src1, insn->src2)) {
-		switch_pseudo(insn, &insn->src1, insn, &insn->src2);
-		return REPEAT_CSE;
-	}
-	return 0;
+	if (canonical_order(insn->src1, insn->src2))
+		return 0;
+
+	switch_pseudo(insn, &insn->src1, insn, &insn->src2);
+	return repeat_phase |= REPEAT_CSE;
 }
 
 static inline int simple_pseudo(pseudo_t pseudo)
@@ -1129,17 +1129,15 @@ int simplify_instruction(struct instruction *insn)
 	case OP_ADD: case OP_MULS:
 	case OP_AND: case OP_OR: case OP_XOR:
 	case OP_AND_BOOL: case OP_OR_BOOL:
+		canonicalize_commutative(insn);
 		if (simplify_binop(insn))
 			return REPEAT_CSE;
-		if (simplify_commutative_binop(insn))
-			return REPEAT_CSE;
 		return simplify_associative_binop(insn);
 
 	case OP_MULU:
 	case OP_SET_EQ: case OP_SET_NE:
-		if (simplify_binop(insn))
-			return REPEAT_CSE;
-		return simplify_commutative_binop(insn);
+		canonicalize_commutative(insn);
+		return simplify_binop(insn);
 
 	case OP_SUB:
 	case OP_DIVU: case OP_DIVS:
-- 
2.12.0

