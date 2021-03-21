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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99693C433EA
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C4361946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhCUMf3 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCUMfV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08045C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id bf3so16078985edb.6
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yogb3xLL1K4x00FKimazPH2zLp4VAS/QnZoB6MtsZTQ=;
        b=r78ZNuBcWzDoTc8fg1kcM63xJg9xVCK4/hOVei2VapP5yCCXFyXU8rcRaGD0SBqDbf
         JO942PEvTgpW10eKs/r9HRfwrBYSoiZKyxa1IijZEjgtenkm9XkgI/P8YgGe9EkZZJ/5
         OHiKRoOSM9m3Fabme+1+fRis63fGT78mB03FqETA+9Dc1ZlK0dYb4XmenpPRyiNHUMDI
         XYICVbyJe1uCmVzcRqD9XmTIBeB7VdnUQq4MDtmwVbbwPxrc+mHJuKDH++Ofsp7oZZqg
         iHwEzxUSx76Bczc9W5LS0xq4/I3CQ90hqP0CvFCIiFNbhQ1ghSpejWIh3G01Mr4zvqIE
         /gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yogb3xLL1K4x00FKimazPH2zLp4VAS/QnZoB6MtsZTQ=;
        b=rST888udS2/PdNH801SDGnN24o7mASLXFPWesNLiN9Hy2K5ILcHp/89uiCxORQSvLL
         H70g3AV1+EAzdwDP5vA/3xfeVaHOBNDYCX4fumxuT2NI7cuhWWNJSUylEICl2ZeOfZhg
         Xv8UeDt1i83fZE/mjmqnFomvsnCKf4xXSSVAqFWiwVkGan+b7/7W2Xn38ma51UIGPwvx
         hD5Q0bLtreGUXU1hEdP31UslpPt/RgQOLdL1VCqmLGm57IVK4jW5gUWOd/UejDjtLmvu
         sHRDq8KArm10kyiMT+YcYnN0/jGS1oOTzCjrdy1FHOIcJhXtiXtrZFoZQzbR4oLB5yDC
         2NbQ==
X-Gm-Message-State: AOAM533dHHd/1JP6A8bruH4YMcFt/26yLa0/6HDIG6rQ1pQ+V2kZEDtK
        x2Mhzfu73yc+KHbxgI7prq+sOugEQCc=
X-Google-Smtp-Source: ABdhPJzyoQJUU98QlqPlAz9Y3zkUqnb4V9rheeE8PcnxypgHHqrpMLCwRbAPaCSzj+QHLX1888H9NQ==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr20348799edx.273.1616330119837;
        Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/13] use convert_to_jump() when converting a CBR with same targets
Date:   Sun, 21 Mar 2021 13:35:04 +0100
Message-Id: <20210321123505.27993-13-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

If a conditional branch has identical targets, it should be
converted to a simple jump.

This is done but using its own code.
Change this by using the existing convert_to_jump() instead.
This also allows any redundant phi-sources to be removed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                     | 13 ++-----------
 validation/optim/bad-phisrc2.c |  1 -
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/simplify.c b/simplify.c
index 7171bd564e63..90db041af823 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2444,17 +2444,8 @@ static int simplify_branch(struct instruction *insn)
 		return convert_to_jump(insn, cond->value ? insn->bb_true : insn->bb_false);
 
 	/* Same target? */
-	if (insn->bb_true == insn->bb_false) {
-		struct basic_block *bb = insn->bb;
-		struct basic_block *target = insn->bb_false;
-		remove_bb_from_list(&target->parents, bb, 1);
-		remove_bb_from_list(&bb->children, target, 1);
-		insn->bb_false = NULL;
-		kill_use(&insn->cond);
-		insn->cond = NULL;
-		insn->opcode = OP_BR;
-		return REPEAT_CSE|REPEAT_CFG_CLEANUP;
-	}
+	if (insn->bb_true == insn->bb_false)
+		return convert_to_jump(insn, insn->bb_true);
 
 	/* Conditional on a SETNE $0 or SETEQ $0 */
 	if (cond->type == PSEUDO_REG) {
diff --git a/validation/optim/bad-phisrc2.c b/validation/optim/bad-phisrc2.c
index 3eade688f768..78eae28856fd 100644
--- a/validation/optim/bad-phisrc2.c
+++ b/validation/optim/bad-phisrc2.c
@@ -10,7 +10,6 @@ int bad_phisrc2(int p, int a, int r)
 /*
  * check-name: bad-phisrc2
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-contains: select\\.
-- 
2.31.0

