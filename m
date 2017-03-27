From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 04/15] canonicalize binops before simplification
Date: Mon, 27 Mar 2017 19:33:54 +0200
Message-ID: <20170327173405.11405-5-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35485 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so12376186wrc.2
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:17 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, canonicalization of binops (more specifically
insuring that the operands of binops are in canonical order)
is only done after simplify_binop(). But the goal of
canonicalization is to limit the number of cases/patterns
we need to check/handle during ... simplification.
So canonicalization need to be done before simplification.

Fix this by moving (this part of) canonicalization before
doing simplification.

Note 1: the motivation of this patch is to prepare code for
        the canonicalization of compare instructions

Note 2: this patch allow now some simplification of ...
        the simplification code (simplify_binop()), this
	will be done in a later serie.

Note 3: this patch changes slightly the cost of the CSE/
	simplification, positively or negatively, depending
	on the ration of simplification/canonicalization
	that can be done.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/simplify.c b/simplify.c
index c18a2268e..90f51e2a9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -711,13 +711,13 @@ static int canonical_order(pseudo_t p1, pseudo_t p2)
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
@@ -1105,17 +1105,15 @@ int simplify_instruction(struct instruction *insn)
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

