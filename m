Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D76C433ED
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B14610C7
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Apr 2021 15:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhDRPdO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Apr 2021 11:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhDRPdO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Apr 2021 11:33:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BDC061760
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so49152530ejc.4
        for <linux-sparse@vger.kernel.org>; Sun, 18 Apr 2021 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mTDPMx1aYnlOGqFSax2OjMQRk5DqmfeLh7StN5YDao=;
        b=AYyXUBCcAkNlhSYgaQQpX4jt4zH+4iPY23zkCGcYj5onmv7abAlfJ+Tu1ob2Lu/nb4
         QsDH0rs3Cm1DNlyRFGuQKG59A+RadmKJ43v7IiLcaiuVqt1m+q+tLQ1/hL5B1ywOkO4D
         g8sJkMevzUS5j3/s9NBzgxTL4dLyFF/K9AMtTq2NUho0oPgi3+3wDbwz5LEVGb1WVabK
         2scuJpLTnkmVW/GW04JD0RqLK0fjJEjhrAStOnS6y8R8L7dP5ut+B44oAyoAWI8emmg8
         ZskDRrJNJNhxUzmsBq+N8cnuIn28fUrwDsDlBTge9x63KDbnr2saHbb+8XU/WYyWoUl7
         CPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mTDPMx1aYnlOGqFSax2OjMQRk5DqmfeLh7StN5YDao=;
        b=qt1dCHgeMDu2bcyjewNpbptN+KveKjLUoguRbImaizZ5gC5gjvulzL3sndvOxbsm/1
         nmqk3d7dOYANPaOgSa+wE19UYL7Lat4h/8P1ZPZXIHnjNpvVKWQ4ZGOrFSSJSlx85PYG
         1pePMm0g6M3wH5E/PmdSECUbWSqZv/O0yTdEJtVsj9UEtoaXrpuppiz8hptxTI+nBvwN
         NmfR3jmezsPzUaSvo6aVSc02tdqBdObFvv5O2gw7YJpBNkvXBeNYSnusTn/g8c8lzujB
         0aAe2QS7FN7loK5ezYYjpSfYL9DE0BVx4Lft9ReME2XXokF4I9cesUhwvPmTh+6vRZhD
         pmiQ==
X-Gm-Message-State: AOAM530BOGL+9PJdgct3fJVkXfbQ6esAaub0YqlrYMD2IDGqWGS2YAmC
        +uSMxV3GdiYHpKzoVa4IcaUkuEoR14Q=
X-Google-Smtp-Source: ABdhPJwmW/etaUp8vOnoZZNXQ31OuEQ6Bq4V4FiecS+Z2zeIyIVDzGTyHSH8RU7SL+ZGX+7P/a64AA==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr18192508ejg.310.1618759964502;
        Sun, 18 Apr 2021 08:32:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:959c:c85:d486:38cf])
        by smtp.gmail.com with ESMTPSA id k9sm8632888eje.102.2021.04.18.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 08:32:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE 1/4] canonicalize constant signed compares toward zero
Date:   Sun, 18 Apr 2021 17:32:30 +0200
Message-Id: <20210418153233.45234-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
References: <20210418153233.45234-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Currently, signed compares against a constant are canonicalized
toward the smallest possible constant. So, the following
canonicalization are done:
	x < 256		--> x <= 255
	x < -2047	--> x <= -2048

This has two advantages:
1) it maximalizes the number of constants possible for a given bit size.
2) it allows to remove all < and all >=

But it has also a serious disadvantages: a simple comparison against
zero, like:
	x >= 0
is canonicalized into:
	x > -1

Which can be more costly for some architectures if translated as such ,
is also less readable than the version using 0 and is also sometimes
quite more complicated to match in some simplification patterns.

So, canonicalize it using 'towards 0' / using the smallest constant
in absolute value.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                            | 34 +++++++++---
 validation/optim/canonical-cmp-zero.c | 74 +++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 6 deletions(-)
 create mode 100644 validation/optim/canonical-cmp-zero.c

diff --git a/simplify.c b/simplify.c
index 9e3514d838a9..e0e4f9ebcba9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1178,38 +1178,52 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 
 	switch (insn->opcode) {
 	case OP_SET_LT:
+		if (!value)
+			break;
 		if (value == sign_bit(size))	// (x <  SMIN) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == sign_mask(size))	// (x <  SMAX) --> (x != SMAX)
 			return replace_opcode(insn, OP_SET_NE);
 		if (value == sign_bit(size) + 1)// (x < SMIN + 1) --> (x == SMIN)
 			return replace_binop_value(insn, OP_SET_EQ, sign_bit(size));
-		changed |= replace_binop_value(insn, OP_SET_LE, (value - 1) & bits);
+		if (!(value & sign_bit(size)))
+			changed |= replace_binop_value(insn, OP_SET_LE, (value - 1) & bits);
 		break;
 	case OP_SET_LE:
+		if (!value)
+			break;
 		if (value == sign_mask(size))	// (x <= SMAX) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == sign_bit(size))	// (x <= SMIN) --> (x == SMIN)
 			return replace_opcode(insn, OP_SET_EQ);
 		if (value == sign_mask(size) - 1) // (x <= SMAX - 1) --> (x != SMAX)
 			return replace_binop_value(insn, OP_SET_NE, sign_mask(size));
+		if (value & sign_bit(size))
+			changed |= replace_binop_value(insn, OP_SET_LT, (value + 1) & bits);
 		break;
 	case OP_SET_GE:
+		if (!value)
+			break;
 		if (value == sign_bit(size))	// (x >= SMIN) --> 1
 			return replace_with_pseudo(insn, value_pseudo(1));
 		if (value == sign_mask(size))	// (x >= SMAX) --> (x == SMAX)
 			return replace_opcode(insn, OP_SET_EQ);
 		if (value == sign_bit(size) + 1)// (x >= SMIN + 1) --> (x != SMIN)
 			return replace_binop_value(insn, OP_SET_NE, sign_bit(size));
-		changed |= replace_binop_value(insn, OP_SET_GT, (value - 1) & bits);
+		if (!(value & sign_bit(size)))
+			changed |= replace_binop_value(insn, OP_SET_GT, (value - 1) & bits);
 		break;
 	case OP_SET_GT:
+		if (!value)
+			break;
 		if (value == sign_mask(size))	// (x >  SMAX) --> 0
 			return replace_with_pseudo(insn, value_pseudo(0));
 		if (value == sign_bit(size))	// (x >  SMIN) --> (x != SMIN)
 			return replace_opcode(insn, OP_SET_NE);
 		if (value == sign_mask(size) - 1) // (x > SMAX - 1) --> (x == SMAX)
 			return replace_binop_value(insn, OP_SET_EQ, sign_mask(size));
+		if (value & sign_bit(size))
+			changed |= replace_binop_value(insn, OP_SET_GE, (value + 1) & bits);
 		break;
 
 	case OP_SET_B:
@@ -1271,8 +1285,10 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if ((value & bits) != value)
 				return replace_with_value(insn, 1);
 			break;
-		case OP_SET_LE:
+		case OP_SET_LE: case OP_SET_LT:
 			value = sign_extend(value, def->size);
+			if (insn->opcode == OP_SET_LT)
+				value -= 1;
 			if (bits & sign_bit(def->size))
 				break;
 			if (value < 0)
@@ -1282,8 +1298,10 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if (value == 0)
 				return replace_opcode(insn, OP_SET_EQ);
 			break;
-		case OP_SET_GT:
+		case OP_SET_GT: case OP_SET_GE:
 			value = sign_extend(value, def->size);
+			if (insn->opcode == OP_SET_GE)
+				value -= 1;
 			if (bits & sign_bit(def->size))
 				break;
 			if (value < 0)
@@ -1340,16 +1358,20 @@ static int simplify_compare_constant(struct instruction *insn, long long value)
 			if (bits >= value)
 				return replace_with_value(insn, 1);
 			break;
+		case OP_SET_LT:
+			value -= 1;
 		case OP_SET_LE:
-			value = sign_extend(value, def->size);
 			if (bits & sign_bit(def->size)) {
+				value = sign_extend(value, def->size);
 				if (value >= -1)
 					return replace_with_value(insn, 1);
 			}
 			break;
+		case OP_SET_GE:
+			value -= 1;
 		case OP_SET_GT:
-			value = sign_extend(value, def->size);
 			if (bits & sign_bit(def->size)) {
+				value = sign_extend(value, def->size);
 				if (value >= -1)
 					return replace_with_value(insn, 0);
 			}
diff --git a/validation/optim/canonical-cmp-zero.c b/validation/optim/canonical-cmp-zero.c
new file mode 100644
index 000000000000..e01a00e637b6
--- /dev/null
+++ b/validation/optim/canonical-cmp-zero.c
@@ -0,0 +1,74 @@
+int f00(int x) { return x >= 0; }
+int f01(int x) { return x > -1; }
+int f02(int x) { return x <  1; }
+int f03(int x) { return x <= 0; }
+
+int f10(int x) { return x <  16; }
+int f11(int x) { return x <= 15; }
+
+int f20(int x) { return x >  -9; }
+int f21(int x) { return x >= -8; }
+
+/*
+ * check-name: canonical-cmp-zero
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-start
+f00:
+.L0:
+	<entry-point>
+	setge.32    %r2 <- %arg1, $0
+	ret.32      %r2
+
+
+f01:
+.L2:
+	<entry-point>
+	setge.32    %r5 <- %arg1, $0
+	ret.32      %r5
+
+
+f02:
+.L4:
+	<entry-point>
+	setle.32    %r8 <- %arg1, $0
+	ret.32      %r8
+
+
+f03:
+.L6:
+	<entry-point>
+	setle.32    %r11 <- %arg1, $0
+	ret.32      %r11
+
+
+f10:
+.L8:
+	<entry-point>
+	setle.32    %r14 <- %arg1, $15
+	ret.32      %r14
+
+
+f11:
+.L10:
+	<entry-point>
+	setle.32    %r17 <- %arg1, $15
+	ret.32      %r17
+
+
+f20:
+.L12:
+	<entry-point>
+	setge.32    %r20 <- %arg1, $0xfffffff8
+	ret.32      %r20
+
+
+f21:
+.L14:
+	<entry-point>
+	setge.32    %r23 <- %arg1, $0xfffffff8
+	ret.32      %r23
+
+
+ * check-output-end
+ */
-- 
2.31.1

