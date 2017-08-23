From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 41/48] mem2reg: make rewrite_load_instruction() functional
Date: Wed, 23 Aug 2017 22:15:47 +0200
Message-ID: <20170823201554.90551-42-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38012 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbdHWURY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:17:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id a70so625739wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:17:23 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c                       | 25 ++++++++++-------
 validation/loop-linearization.c | 60 ++++++++++++++++++++---------------------
 2 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index d0873b051..bb5fadbf2 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -12,7 +12,7 @@
  * We should probably sort the phi list just to make it easier to compare
  * later for equality.
  */
-static void rewrite_load_instruction(struct symbol *sym, struct instruction *insn,
+static pseudo_t dominating_value(struct symbol *sym,
 	struct basic_block *bb, struct pseudo_list *dominators)
 {
 	struct basic_block *parent;
@@ -31,9 +31,9 @@ static void rewrite_load_instruction(struct symbol *sym, struct instruction *ins
 	} END_FOR_EACH_PTR(val);
 
 	/*
-	 * All the same pseudo - replace the load by the unique val
+	 * All the same pseudo - use it!
 	 */
-	goto convert;
+	return new;
 
 complex_phi:
 	/*
@@ -67,8 +67,7 @@ complex_phi:
 		kill_use(&insn->src);
 #endif
 
-convert:
-	convert_load_instruction(insn, new);
+	return new;
 }
 
 /*
@@ -135,6 +134,7 @@ static int find_dominating_stores(struct symbol *sym, struct instruction *insn,
 	struct instruction *one, *dom = NULL;
 	struct pseudo_list *dominators;
 	pseudo_t pseudo = sym->pseudo;
+	pseudo_t val;
 	int partial;
 
 	/* Unreachable load? Undo it */
@@ -170,8 +170,8 @@ found:
 		return 0;
 
 	if (dom) {
-		convert_load_instruction(insn, dom->target);
-		return 1;
+		val = dom->target;
+		goto convert;
 	}
 
 	/* OK, go find the parents */
@@ -186,8 +186,10 @@ found:
 		if (!local)
 			return 0;
 		check_access(insn);
-		convert_load_instruction(insn, value_pseudo(0));
-		return 1;
+
+		// FIXME: should be UNDEF
+		val = value_pseudo(0);
+		goto convert;
 	}
 
 	/*
@@ -196,7 +198,10 @@ found:
 	 * have to turn the load into a phi-node of the
 	 * dominators.
 	 */
-	rewrite_load_instruction(sym, insn, bb, dominators);
+	val = dominating_value(sym, bb, dominators);
+
+convert:
+	convert_load_instruction(insn, val);
 	return 1;
 }
 
diff --git a/validation/loop-linearization.c b/validation/loop-linearization.c
index 25c6dfb87..6c531d056 100644
--- a/validation/loop-linearization.c
+++ b/validation/loop-linearization.c
@@ -39,16 +39,16 @@ static int fdo(void)
 ffor:
 .L0:
 	<entry-point>
-	phisrc.32   %phi5(i) <- $0
+	phisrc.32   %phi3 <- $0
 	br          .L4
 
 .L4:
-	phi.32      %r1(i) <- %phi5(i), %phi6(i)
-	setlt.32    %r2 <- %r1(i), $10
+	phi.32      %r8 <- %phi3, %phi4
+	setlt.32    %r2 <- %r8, $10
 	cbr         %r2, .L1, .L3
 
 .L1:
-	call.32     %r4 <- p, %r1(i)
+	call.32     %r4 <- p, %r8
 	cbr         %r4, .L2, .L5
 
 .L5:
@@ -56,8 +56,8 @@ ffor:
 	br          .L7
 
 .L2:
-	add.32      %r7 <- %r1(i), $1
-	phisrc.32   %phi6(i) <- %r7
+	add.32      %r7 <- %r8, $1
+	phisrc.32   %phi4 <- %r7
 	br          .L4
 
 .L3:
@@ -72,64 +72,64 @@ ffor:
 fwhile:
 .L8:
 	<entry-point>
-	phisrc.32   %phi11(i) <- $0
+	phisrc.32   %phi7 <- $0
 	br          .L12
 
 .L12:
-	phi.32      %r8(i) <- %phi11(i), %phi12(i)
-	setlt.32    %r9 <- %r8(i), $10
-	cbr         %r9, .L9, .L11
+	phi.32      %r16 <- %phi7, %phi8
+	setlt.32    %r10 <- %r16, $10
+	cbr         %r10, .L9, .L11
 
 .L9:
-	call.32     %r11 <- p, %r8(i)
-	cbr         %r11, .L14, .L13
+	call.32     %r12 <- p, %r16
+	cbr         %r12, .L14, .L13
 
 .L13:
-	phisrc.32   %phi7(return) <- $0
+	phisrc.32   %phi5(return) <- $0
 	br          .L15
 
 .L14:
-	add.32      %r14 <- %r8(i), $1
-	phisrc.32   %phi12(i) <- %r14
+	add.32      %r15 <- %r16, $1
+	phisrc.32   %phi8 <- %r15
 	br          .L12
 
 .L11:
-	phisrc.32   %phi8(return) <- $1
+	phisrc.32   %phi6(return) <- $1
 	br          .L15
 
 .L15:
-	phi.32      %r12 <- %phi7(return), %phi8(return)
-	ret.32      %r12
+	phi.32      %r13 <- %phi5(return), %phi6(return)
+	ret.32      %r13
 
 
 fdo:
 .L16:
 	<entry-point>
-	phisrc.32   %phi16(i) <- $0
+	phisrc.32   %phi11 <- $0
 	br          .L17
 
 .L17:
-	phi.32      %r15(i) <- %phi16(i), %phi17(i)
-	call.32     %r16 <- p, %r15(i)
-	cbr         %r16, .L18, .L20
+	phi.32      %r23 <- %phi11, %phi12
+	call.32     %r18 <- p, %r23
+	cbr         %r18, .L18, .L20
 
 .L20:
-	phisrc.32   %phi13(return) <- $0
+	phisrc.32   %phi9(return) <- $0
 	br          .L22
 
 .L18:
-	add.32      %r19 <- %r15(i), $1
-	setlt.32    %r20 <- %r15(i), $10
-	phisrc.32   %phi17(i) <- %r19
-	cbr         %r20, .L17, .L19
+	add.32      %r21 <- %r23, $1
+	setlt.32    %r22 <- %r23, $10
+	phisrc.32   %phi12 <- %r21
+	cbr         %r22, .L17, .L19
 
 .L19:
-	phisrc.32   %phi14(return) <- $1
+	phisrc.32   %phi10(return) <- $1
 	br          .L22
 
 .L22:
-	phi.32      %r17 <- %phi13(return), %phi14(return)
-	ret.32      %r17
+	phi.32      %r19 <- %phi9(return), %phi10(return)
+	ret.32      %r19
 
 
  * check-output-end
-- 
2.14.0

