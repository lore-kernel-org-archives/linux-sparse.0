From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] CSE: extend canonical_order()
Date: Wed, 12 Apr 2017 14:59:12 +0200
Message-ID: <20170412125912.46641-3-luc.vanoostenryck@gmail.com>
References: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33251 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753708AbdDLNBb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 12 Apr 2017 09:01:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so6281265wmb.0
        for <linux-sparse@vger.kernel.org>; Wed, 12 Apr 2017 06:01:31 -0700 (PDT)
In-Reply-To: <20170412125912.46641-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Impose an almost-total order between pseudos.
This creates more oppportunities for CSE and
make simplification slightly easier too.

Now the canonical order is:
	REG > PHI > ARG > SYM > VAL > VOID
and REGS, PHIs and ARGs are ordered following their
'->nr' field.
This order continues to put values at RHS and previous
results at LHS while still being quite cheap to check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h                       |  4 ++--
 simplify.c                        | 29 +++++++++++++++++++++--------
 validation/call-inlined.c         |  2 +-
 validation/optim/cse-dual-cmpeq.c |  1 -
 4 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/linearize.h b/linearize.h
index 6f4298f33..24cbcf94d 100644
--- a/linearize.h
+++ b/linearize.h
@@ -22,11 +22,11 @@ DECLARE_PTR_LIST(pseudo_user_list, struct pseudo_user);
 
 enum pseudo_type {
 	PSEUDO_VOID,
-	PSEUDO_REG,
-	PSEUDO_SYM,
 	PSEUDO_VAL,
+	PSEUDO_SYM,
 	PSEUDO_ARG,
 	PSEUDO_PHI,
+	PSEUDO_REG,
 };
 
 struct pseudo {
diff --git a/simplify.c b/simplify.c
index 5e3d57470..6d4ba4d69 100644
--- a/simplify.c
+++ b/simplify.c
@@ -709,16 +709,29 @@ static void switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instr
 	remove_usage(p2, pp2);
 }
 
+/*
+ * Test if the operands are in canonical order:
+ *	REG > PHI > ARG > SYM > VAL > VOID
+ *	%arg2 > %arg1, %r2 > %r1, %phi2 > %phi1
+ */
 static int canonical_order(pseudo_t p1, pseudo_t p2)
 {
-	/* symbol/constants on the right */
-	if (p1->type == PSEUDO_VAL)
-		return p2->type == PSEUDO_VAL;
-
-	if (p1->type == PSEUDO_SYM)
-		return p2->type == PSEUDO_SYM || p2->type == PSEUDO_VAL;
-
-	return 1;
+	int t1 = p1->type;
+	int t2 = p2->type;
+
+	switch (t1) {
+	case PSEUDO_REG:
+	case PSEUDO_PHI:
+	case PSEUDO_ARG:
+		if (t1 == t2)
+			return p1->nr >= p2->nr;
+		/* fall-through */
+	case PSEUDO_SYM:
+	case PSEUDO_VAL:
+	case PSEUDO_VOID:
+	default:
+		return t1 >= t2;
+	}
 }
 
 static int canonicalize_commutative(struct instruction *insn)
diff --git a/validation/call-inlined.c b/validation/call-inlined.c
index b907ded60..80059f489 100644
--- a/validation/call-inlined.c
+++ b/validation/call-inlined.c
@@ -25,7 +25,7 @@ const char *qus(void) { return lstrip(messg); }
 foo:
 .L0:
 	<entry-point>
-	add.32      %r3 <- %arg1, %arg2
+	add.32      %r3 <- %arg2, %arg1
 	add.32      %r5 <- %r3, $1
 	ret.32      %r5
 
diff --git a/validation/optim/cse-dual-cmpeq.c b/validation/optim/cse-dual-cmpeq.c
index 45ceee12d..aade6e989 100644
--- a/validation/optim/cse-dual-cmpeq.c
+++ b/validation/optim/cse-dual-cmpeq.c
@@ -18,7 +18,6 @@ static int engtge(int a, int b) { return (a >  b) == !(b >= a); }
  * check-name: cse-dual-cmpeq
  * check-command: test-linearize $file
  * check-output-ignore
- * check-known-to-fail
  *
  * check-output-excludes: set[gl][et]\\.
  * check-output-excludes: seteq\\.
-- 
2.12.0

