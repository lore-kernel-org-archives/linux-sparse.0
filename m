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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956E7C433E9
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6484B60241
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhBUW32 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhBUW3V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:29:21 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4235C06178B
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id lu16so26138118ejb.9
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PgdXL2BuAIuT83mrcNy/xHTa0ZWjZnwJHLlvtwZTWY=;
        b=XmNtqSIOk6pk23xd3h1/SVi6v2SYQF+Uvl/IiwHgbaze4yFS5KXxczrwnehrmYC3Dp
         byyLk/bjDYsgk1t0X7CdDnbLKT5R0nuxvrtRYmBKPLKYniN9FK8KsM3VKgi51cs30xGf
         1hY2RyrFHPIW509DwgVuvcz/L/7wgJbXYmIb2M8XmhbXMw15BVqd+xLzEdopY8FSpydG
         ji3USZymbhxbPS4ouszlr1n7KcmnTiFsljnAcI8StPwjSVzn2Z8oQ5Bz7ndEIoUX/867
         vyu1aP7ZkU7JfX+QfnW4pLEasgjlZNjSZx7BgeJLJ6XrAO50v+zn9YxXJ1cLEc0NABvH
         Oeng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PgdXL2BuAIuT83mrcNy/xHTa0ZWjZnwJHLlvtwZTWY=;
        b=PUIfLcEMXJlfGwV3MVY5S8Yhm2YLUfHOTtqctz/5e6SoF9NzE/KrD1N9U01wbjzRPm
         uo/L3v6g61DMFV/6Vb/qFCMa3ZKBHdtLSwfKwwjhWX3KbOi1umkcDPTTEps3OzDY5/Ug
         7yaVogUc1EOxF972Yi8IOQrJfsIE3zYCKy+i6MNFTv80hk1KuxBeAmlzgdp5i3KVIlmK
         K2SBeNh3rWVsIUGHE/u9w45wg5D6M01fMuOvprE6NESaWj+0r0ndf7D7uTJG872ThTL2
         rk44utubL6vKHbadLe+JsUSyA73Av5HQZ/XCbugtVV6wZ8hcxC+IC5Bp/GyPoPisHEs8
         p3PQ==
X-Gm-Message-State: AOAM532vsi9FrWZIEGDvc4EpZT9tJRnmpFpCzfbeXYPutKDbdN9hbEOE
        9N2rv0C6itmaz6vh4xR6L5zQtyXpEwI=
X-Google-Smtp-Source: ABdhPJy6dkFubWn4RFVEJtFb9EZytUdECrCDmYf6bHbto+dF2nck85mYGALQ41VlOU4+SzmUU2jE8Q==
X-Received: by 2002:a17:907:75e7:: with SMTP id jz7mr6867253ejc.158.1613946519811;
        Sun, 21 Feb 2021 14:28:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id d6sm297744ejr.59.2021.02.21.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:28:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] asm: output *memory* operands need their address as *input*
Date:   Sun, 21 Feb 2021 23:28:34 +0100
Message-Id: <20210221222834.7974-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
References: <20210221222834.7974-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The addresses needed by memory output operands are linearized
(and placed) after the ASM instruction needing them.

So, split add_asm_output() in 2 parts: one generating only the
addresses for memory operands and called before issuing the body,
and another one doing the usual copy of (non-memory) output operands
back into their corresponding variables.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c                  | 31 +++++++++++++++++++++++--------
 validation/linear/asm-out0.c |  1 -
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/linearize.c b/linearize.c
index 6efa47492869..33d641b40de6 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2144,19 +2144,29 @@ static void add_asm_input(struct entrypoint *ep, struct instruction *insn, struc
 	add_asm_rule(insn, &insn->asm_rules->inputs, op, pseudo);
 }
 
+static void add_asm_output_address(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
+{
+	pseudo_t pseudo;
+
+	if (!op->is_memory)
+		return;
+
+	pseudo = linearize_expression(ep, op->expr);
+	add_asm_rule(insn, &insn->asm_rules->outputs, op, pseudo);
+}
+
 static void add_asm_output(struct entrypoint *ep, struct instruction *insn, struct asm_operand *op)
 {
 	struct access_data ad = { NULL, };
 	pseudo_t pseudo;
 
-	if (op->is_memory) {
-		pseudo = linearize_expression(ep, op->expr);
-	} else {
-		if (!linearize_address_gen(ep, op->expr, &ad))
-			return;
-		pseudo = alloc_pseudo(insn);
-		linearize_store_gen(ep, pseudo, &ad);
-	}
+	if (op->is_memory)
+		return;
+
+	if (!linearize_address_gen(ep, op->expr, &ad))
+		return;
+	pseudo = alloc_pseudo(insn);
+	linearize_store_gen(ep, pseudo, &ad);
 
 	add_asm_rule(insn, &insn->asm_rules->outputs, op, pseudo);
 }
@@ -2184,6 +2194,11 @@ static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement
 		add_asm_input(ep, insn, op);
 	} END_FOR_EACH_PTR(op);
 
+	/* ... and the addresses for memory outputs */
+	FOR_EACH_PTR(stmt->asm_outputs, op) {
+		add_asm_output_address(ep, insn, op);
+	} END_FOR_EACH_PTR(op);
+
 	add_one_insn(ep, insn);
 
 	/* Assign the outputs */
diff --git a/validation/linear/asm-out0.c b/validation/linear/asm-out0.c
index 64d154ed5ad7..a8e0be693d87 100644
--- a/validation/linear/asm-out0.c
+++ b/validation/linear/asm-out0.c
@@ -7,7 +7,6 @@ static void asm_out0(void)
 /*
  * check-name: asm-out0
  * check-command: test-linearize -fdump-ir $file
- * check-known-to-fail
  *
  * check-output-start
 asm_out0:
-- 
2.30.0

