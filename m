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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA0C433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CE3206B5
	for <linux-sparse@archiver.kernel.org>; Wed, 27 Jan 2021 03:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbhA0DqO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 26 Jan 2021 22:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbhAZWF6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 26 Jan 2021 17:05:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9A5C061797
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so18101935wrt.5
        for <linux-sparse@vger.kernel.org>; Tue, 26 Jan 2021 14:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fw5+CX6TI2CvHGEEzxLcRpfZw/VeG8LzYlccTQEiPYU=;
        b=HOjbI3R6ekHNj3A6RnYGb5x8uOUjxCUVr19043jYOCSny4M1CIcrfJ/YigqELw7rR5
         URSem1gPVnD6DK5H+FT5jqsJ6eTbgUFxedzBNulLWnuqd2k0AdYmhktQzxiI1Wui/GhR
         nuqhxw75X0hxZJFhL7jHHrTvMfxp1VMgr3T0XW/9erjgPDkcEHRlX9c73dETzNTePr1v
         BQg+sf8jwHRGX4wtJ87p5KJn3W8eM6RjnlWyML8sP06DtqPQd7LbuOOVrYGkE4gMVrWs
         wPuZXVNBx1CeZPddmZ0PwflwirRHM8zDl0sgvnKlShSqeqxgjTZ3dYJOvgKdKfbCvNyx
         pZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fw5+CX6TI2CvHGEEzxLcRpfZw/VeG8LzYlccTQEiPYU=;
        b=eUjuljjqEh12NEf0zJ16e5ulBZIBXQ/ufC8tAtRon7zafpBCA750DgxwF7GOkTzfej
         kYeW3RMEwHHgoY2G4IV55mEEbB6QwJlkomodHbwGDxk+PUob59sLJR0ScgPwoVQgLatV
         b8q9qOwytaK/ZXpzahU32lfR1vT7n1k7n7FxW737opPmCYx0zJSQajNFnNBKBPLfRgjV
         eh36wt5D9lPQQslxM4skfV46EtvykiDL1/93ae8tY0R4pMz536LfBlQDdCuWiNYoacmw
         bywZRs9TWC6cJRrej12/5WR1n20xwhwvPSQrkt3kBNaFl308N6krrOEu4WMuBmct9d1S
         i8KQ==
X-Gm-Message-State: AOAM530r/wWceuqf4Cs6PxtsQBG8+7F+/1ZBxj5isgqgv2cPPDub4Kkk
        IIpAh6xtG+r9kdUdIuzjlMbsREv7dYU=
X-Google-Smtp-Source: ABdhPJz+FmKkXO0q3MfxDIhrsnHzz3kLbmvcsazHcpWLX/aFBgvbExCZVEAQnVf0X3IfSgSxdot1TA==
X-Received: by 2002:a5d:58ec:: with SMTP id f12mr8050266wrd.134.1611698686350;
        Tue, 26 Jan 2021 14:04:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:285a:40db:3257:f0fd])
        by smtp.gmail.com with ESMTPSA id b132sm5268447wmh.21.2021.01.26.14.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:04:45 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/10] cmps: canonicalize SEL(x {<,<=} y, a, b) --> SEL(x {>=,>} y, b, a)
Date:   Tue, 26 Jan 2021 23:04:31 +0100
Message-Id: <20210126220432.58265-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Both compares and OP_SELECT are anti-symmetrical: swapping
the arguments is equivalent to inversing the condition.
As consequence, when combined, they're symmetrical:
swapping the arguments of the compare (or equivalently reversing
the direction of the compare) and swapping the operand of the
OP_SELECT is a no-op, both forms are equivalent.

So, canonicalize these to always use OP_GT or OP_GE.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                            | 7 +++++++
 validation/optim/canonical-cmps-sel.c | 1 -
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index b29f5d5b2444..10cdf50dcbf1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2301,6 +2301,13 @@ static int simplify_select(struct instruction *insn)
 		if (src2 == def->src1 && src1 == def->src2)
 			return replace_with_pseudo(insn, src1); // SEL(y!=x,x,y) --> x
 		break;
+	case OP_SET_LE: case OP_SET_LT:
+	case OP_SET_BE: case OP_SET_B:
+		if (!one_use(cond))
+			break;
+		// SEL(x {<,<=} y, a, b) --> SEL(x {>=,>} y, b, a)
+		def->opcode = opcode_negate(def->opcode);
+		return switch_pseudo(insn, &insn->src2, insn, &insn->src3);
 	case OP_SEL:
 		if (constant(def->src2) && constant(def->src3)) {
 			// Is the def of the conditional another select?
diff --git a/validation/optim/canonical-cmps-sel.c b/validation/optim/canonical-cmps-sel.c
index f0a0effc7954..bba5e5c894f8 100644
--- a/validation/optim/canonical-cmps-sel.c
+++ b/validation/optim/canonical-cmps-sel.c
@@ -19,7 +19,6 @@ _Bool sel_leu(unsigned int a, unsigned int b, int x, int y)
 /*
  * check-name: canonical-cmps-sel
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-returns: 1
-- 
2.30.0

