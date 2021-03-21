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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AD8C433E2
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22186194C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCUMf0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCUMfR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3815AC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u5so16831429ejn.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTWNAKWB/spf0KR3ml2vXOWrUdmG1XPa7riG/7CK5wY=;
        b=Fnd1XdAUvXANqSlg5A6iIqjKI/wjqHacInZKwafsQQX9XeJEx+OYYD9SHYs4Asz0fS
         zHmi1xON+ktmNOorLsVb3LXB0fvSrMyGZWpLjqU5YMBYMH1Cn4jFpcQaBRpK0C0xtOE2
         Uvq1Diy+ImxBAkH7w3wy2bpoIx/NVaYL690ugDkcrnBe01doXlf9SftOjaJPecw79V5u
         gQbTiXaoIwP3A078JLRliJIkvXPqMBPRNAXjUPluAO8b+TCsJhtSp/bZmNtRlSWIHJEt
         W2Mq7/jbbr4MjT78A51oW3QNFrS6ZIK4nmVOKlitk40iJfvKqexYP9hMXuX2FcZMeowy
         GFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTWNAKWB/spf0KR3ml2vXOWrUdmG1XPa7riG/7CK5wY=;
        b=l+PXBBcf1C2a2eUfuaVmk/O+wSZ+k++tp+iVJm9hURP5W4jYur7tyyVieUbofR9q1z
         qnA3wXu1jREA/b2bIigVgkzf2m7BkCDo+HtNnXX80NMBF1zTDMroSnaB/nH+tGp0h9Zm
         nuDx0ZVMjMzGyi9GkuHlWu5+Xh+oe2dGesPL3e7whaIs+zS39C0g41bAsd0Hq2Zv+XkO
         YlHbhqcLSkN7T27rQHSwgjJ2gRuIeJFK+bK4vjH3h54nhQ6wkUIOu4W6Bzo/DDUgME9i
         d8RQsHDLzlyInfXZKxX0Hgm1sPKKm5WdcW9o8LxT8ifDNS7Ib0LNTNVSKmfNk+fUOqjG
         X3nA==
X-Gm-Message-State: AOAM5328MZx1wLdeMx01k0HIpJ7MKHcdhBJAG+Ft3jr0gl3k8LGH0sUj
        QV7gBIZ2Szi3KNhF8Uy6PsfAIoEgnXI=
X-Google-Smtp-Source: ABdhPJyfElXcMKWmo7QZf7L2p0vtzgtRsnsHQW8aBe1B1u+XN+4WL0TEGi5BEvqperhm68B1bR4y7g==
X-Received: by 2002:a17:906:f9cc:: with SMTP id lj12mr13935725ejb.544.1616330116009;
        Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/13] let insert_branch() reuse the terminating instruction
Date:   Sun, 21 Mar 2021 13:34:58 +0100
Message-Id: <20210321123505.27993-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

insert_branch() changes a switch or a conditional branch into a jump.
This is implemented by deleting the old instruction and allocating
the new one. This is not needed here since no reference to the
old instruction is kept.

So, simply reuse the terminating instruction and change it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/linearize.c b/linearize.c
index 2268b0951376..1d85cf2ba208 100644
--- a/linearize.c
+++ b/linearize.c
@@ -696,18 +696,14 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 void insert_branch(struct instruction *jmp, struct basic_block *target)
 {
 	struct basic_block *bb = jmp->bb;
-	struct instruction *br, *old;
 	struct basic_block *child;
 
-	/* Remove the switch */
-	old = delete_last_instruction(&bb->insns);
-	assert(old == jmp);
-	kill_instruction(old);
-
-	br = alloc_instruction(OP_BR, 0);
-	br->bb = bb;
-	br->bb_true = target;
-	add_instruction(&bb->insns, br);
+	kill_use(&jmp->cond);
+	jmp->bb_true = target;
+	jmp->bb_false = NULL;
+	jmp->cond = NULL;
+	jmp->size = 0;
+	jmp->opcode = OP_BR;
 
 	FOR_EACH_PTR(bb->children, child) {
 		if (child == target) {
-- 
2.31.0

