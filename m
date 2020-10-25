Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B4C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 12:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76F20756
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 12:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQUtYfLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416043AbgJYMwl (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732350AbgJYMwl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 08:52:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59AC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 05:52:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k3so9520336ejj.10
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjT7//HL/w+UOBaWM3pSsJsC8+UiyXa0APCfmW47WT0=;
        b=eQUtYfLq3jYLtPXFqI/hTZScyl2YJpbYdKGctRhVoJapxTPn9NwfywGlc2CrevTe1U
         143+ix3dF6pV+uoevPbNrY34WaWAewbCiHglZ1lBOIhTklcZZ+XooWfrwSCSS5fZqUuT
         Gs+euck562KOElVLT5v65Vqb+hGcA7ol9JwdBhr82Be8ESKZzJp123Egzr6MHaMUq4Io
         B4862pxBtliVuxqMHQcau0jdGYldEunCgVkV9zDBtUudoJfYbdnM86KpheEbPHM7pSrp
         XsTYl5yX4vbEGWliDFOi5QjeDyc9kCSuUzrD0jsZafgqHzx7PIJzq4iFx5UzOqIal+ip
         2Ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hjT7//HL/w+UOBaWM3pSsJsC8+UiyXa0APCfmW47WT0=;
        b=tLSYhcwRiIINiowx30SVnUzBOf2Ij/3nb6en2kYh4mXp3yJR66xfBUVlGBsHTv2EHX
         D+nsaxbo7S4GAIUo4XLoJlltlznVRd6LJ3xDf91sp0P4XcI7QpvuAPjIinSE21kRQlOo
         3VIkajaQzkptwbdtESwAFukCBJTk0hswUrQnnIC+Btdk3nZPxsh0Vvf1DD16q7uYIABd
         JuUaRyrzDVviA7EY5/0BMqaPcsoeQ8vqTZK2lf16GD5YDqhsYNDZ7mZ9XKFitbblN26V
         GABQVpmcVBws14FwO5AcFl2alX2R645gby9CPSV9h906RNrbtl9cu3otYMuc/wf0t5bp
         ih+w==
X-Gm-Message-State: AOAM532a6hLW4QCIiABap0AvqnDXheRh8N3x3lEqk5sLNLTi7JqAfzNq
        NA5AFYZg19qLXOZ1CaCC1arXsj7dXi0=
X-Google-Smtp-Source: ABdhPJyBB0wwcC9c6LirZ76VMWaN0/Qb0o02ZFz3SaxV3t1v8fmfFb6mjdYPtlbt3ntRdb6rdAPCPg==
X-Received: by 2002:a17:906:fa84:: with SMTP id lt4mr11081845ejb.61.1603630359041;
        Sun, 25 Oct 2020 05:52:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id y3sm3937732ejk.92.2020.10.25.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 05:52:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] kill dead instructions before any other simplifications
Date:   Sun, 25 Oct 2020 13:52:29 +0100
Message-Id: <20201025125229.20350-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Dead instructions are removed when simplify_instruction() is
called but this is done in various places, depending on the kind
of instructions, sometimes after other simplifications.

Change this by using the instruction's flag OPF_TARGET at the very
beginning of simplify_instruction() to test which instructions are
dead and thus can be removed.

Note: OP_CALLs are special here as they're considered as always
      returning a value but only calls to pure functions are
      removed. This is OK since pure functions should always
      return a value.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 51 +++++----------------------------------------------
 1 file changed, 5 insertions(+), 46 deletions(-)

diff --git a/simplify.c b/simplify.c
index 6caf6cbcf918..f91aaa69dd81 100644
--- a/simplify.c
+++ b/simplify.c
@@ -388,20 +388,6 @@ int kill_insn(struct instruction *insn, int force)
 	return repeat_phase |= REPEAT_CSE;
 }
 
-///
-// kill trivially dead instructions
-static int dead_insn(struct instruction *insn, pseudo_t *src1, pseudo_t *src2, pseudo_t *src3)
-{
-	if (has_users(insn->target))
-		return 0;
-
-	insn->bb = NULL;
-	kill_use(src1);
-	kill_use(src2);
-	kill_use(src3);
-	return REPEAT_CSE;
-}
-
 static inline bool has_target(struct instruction *insn)
 {
 	return opcode_table[insn->opcode].flags & OPF_TARGET;
@@ -1270,8 +1256,6 @@ static int simplify_binop_same_args(struct instruction *insn, pseudo_t arg)
 
 static int simplify_binop(struct instruction *insn)
 {
-	if (dead_insn(insn, &insn->src1, &insn->src2, NULL))
-		return REPEAT_CSE;
 	if (constant(insn->src1)) {
 		if (constant(insn->src2))
 			return simplify_constant_binop(insn);
@@ -1451,8 +1435,6 @@ static int simplify_constant_unop(struct instruction *insn)
 
 static int simplify_unop(struct instruction *insn)
 {
-	if (dead_insn(insn, &insn->src1, NULL, NULL))
-		return REPEAT_CSE;
 	if (constant(insn->src1))
 		return simplify_constant_unop(insn);
 
@@ -1543,16 +1525,11 @@ static int simplify_cast(struct instruction *insn)
 {
 	unsigned long long mask;
 	struct instruction *def;
-	pseudo_t src;
+	pseudo_t src = insn->src;
 	pseudo_t val;
 	int osize;
 	int size;
 
-	if (dead_insn(insn, &insn->src, NULL, NULL))
-		return REPEAT_CSE;
-
-	src = insn->src;
-
 	/* A cast of a constant? */
 	if (constant(src))
 		return simplify_constant_unop(insn);
@@ -1687,9 +1664,6 @@ static int simplify_select(struct instruction *insn)
 {
 	pseudo_t cond, src1, src2;
 
-	if (dead_insn(insn, &insn->src1, &insn->src2, &insn->src3))
-		return REPEAT_CSE;
-
 	cond = insn->src1;
 	src1 = insn->src2;
 	src2 = insn->src3;
@@ -1861,6 +1835,10 @@ int simplify_instruction(struct instruction *insn)
 		return 0;
 
 	flags = opcode_table[insn->opcode].flags;
+	if (flags & OPF_TARGET) {
+		if (!has_users(insn->target))
+			return kill_instruction(insn);
+	}
 	if (flags & OPF_COMMU)
 		canonicalize_commutative(insn) ;
 	if (flags & OPF_COMPARE)
@@ -1906,14 +1884,9 @@ int simplify_instruction(struct instruction *insn)
 	case OP_SET_AE:
 		break;
 	case OP_LOAD:
-		if (!has_users(insn->target))
-			return kill_instruction(insn);
-		/* fall-through */
 	case OP_STORE:
 		return simplify_memop(insn);
 	case OP_SYMADDR:
-		if (dead_insn(insn, &insn->src, NULL, NULL))
-			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
 		return replace_with_pseudo(insn, insn->src);
 	case OP_SEXT: case OP_ZEXT:
 	case OP_TRUNC:
@@ -1923,30 +1896,18 @@ int simplify_instruction(struct instruction *insn)
 	case OP_UCVTF: case OP_SCVTF:
 	case OP_FCVTF:
 	case OP_PTRCAST:
-		if (dead_insn(insn, &insn->src, NULL, NULL))
-			return REPEAT_CSE;
 		break;
 	case OP_UTPTR:
 	case OP_PTRTU:
 		return replace_with_pseudo(insn, insn->src);
 	case OP_SLICE:
-		if (dead_insn(insn, &insn->src, NULL, NULL))
-			return REPEAT_CSE;
 		break;
 	case OP_SETVAL:
 	case OP_SETFVAL:
-		if (dead_insn(insn, NULL, NULL, NULL))
-			return REPEAT_CSE;
 		break;
 	case OP_PHI:
-		if (dead_insn(insn, NULL, NULL, NULL)) {
-			kill_use_list(insn->phi_list);
-			return REPEAT_CSE;
-		}
 		return clean_up_phi(insn);
 	case OP_PHISOURCE:
-		if (dead_insn(insn, &insn->phi_src, NULL, NULL))
-			return REPEAT_CSE;
 		break;
 	case OP_SEL:
 		return simplify_select(insn);
@@ -1960,8 +1921,6 @@ int simplify_instruction(struct instruction *insn)
 	case OP_FSUB:
 	case OP_FMUL:
 	case OP_FDIV:
-		if (dead_insn(insn, &insn->src1, &insn->src2, NULL))
-			return REPEAT_CSE;
 		break;
 	}
 	return 0;

base-commit: cfca7b4c6cb48283cb554fc91dc859ff669f2547
-- 
2.29.0

