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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2055CC433E1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BB061944
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCURJF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhCURI3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:29 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E486EC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id jy13so17482412ejc.2
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ayr6xXcgT8EK4oQFot03FfNuLz7CNdrWrUWlWcR5Fg=;
        b=E5hlHzMgL9tecGCV8RMoZAE9W1u4CmWBoZzz+8rPXkf2/0cfSxI2kt1+jq4EfiSNmY
         fkm/SKDvsgKzDPuY14/nMdkvu/Cvz3r7OquTpJS7Fjirns35PwaZpPvS5J1eDDTSzEeX
         CAwKApE0MTKDuK8pgcizVQA9hQxHfwOSrd9phjblaW8nc4stvup91/IYMKJtQLBTbr9n
         8C0thbhvL+TZZyPXB04h/EN2epooLOiUvhEXHLfEoFkm4UkSuTmVU7XoiA69ZK42JMh6
         s0heBFmxz2emsgAWPHHlyoGlUpAavUSMoJAIqu2AlBkV4rX8UM6CR4j/A/fQdECqFI/b
         EyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ayr6xXcgT8EK4oQFot03FfNuLz7CNdrWrUWlWcR5Fg=;
        b=mpK40HrC6B1GbjwiQ5pB2QKGB9iK0yrY2MfOrKlq5cIS/y9GlXK60bYHm0W+BGU4ad
         b9YqFsXJALdQ6L/hx9E7Ue+22UOkYtRoQ/y9mretCXrXuwQsAlRvvQpjx67Hs/9pJwyN
         P4S0tX9HDoMiI1RTeC2I6evyvGFGTKPBBZsN9Q6TyTWTFhj0jLctMJqMlF6cCkReGxJ5
         qZAyifIEFL4jdT5IUDsIj4oxBrLTJvFyvi6wUmcRrdyogejbnis+BS4FXcJZ3GXgp1Ei
         m0dLi7yHl7eAVentGEMsA7mmm2IUcXvGaJ39sU4p2kYbC4hSKcif5uQq24YRudLvvC9q
         +V4Q==
X-Gm-Message-State: AOAM530ldpaVbaxg4HSKsvabTZ14m7CdECtKZWydQk1WgggMijKlO/V1
        Q51jKzGL6FTxLMmmJPcln5lGnQvRRkE=
X-Google-Smtp-Source: ABdhPJxHmiz7ILDg/NI71/SOi//lsfDyPiFPaojKhX968Xd/R/HnTf6GPY+2ljvPoRsXiZ1p5knBGQ==
X-Received: by 2002:a17:906:1c98:: with SMTP id g24mr15386583ejh.51.1616346507709;
        Sun, 21 Mar 2021 10:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:27 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] memops: find_dominating_parents()s generation is redundant
Date:   Sun, 21 Mar 2021 18:08:18 +0100
Message-Id: <20210321170822.46854-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

find_dominating_parents() has an argument 'generation' used
to check if a BB has already been visited.
But this argument is not needed since this generation is also
stored in the field ::generation of the current BB.

So, remove this argument.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/memops.c b/memops.c
index 7d9e4d703ee3..753eb3a7a914 100644
--- a/memops.c
+++ b/memops.c
@@ -59,7 +59,7 @@ end:
 }
 
 static int find_dominating_parents(struct instruction *insn,
-	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
+	struct basic_block *bb, struct pseudo_list **dominators,
 	int local)
 {
 	struct basic_block *parent;
@@ -86,11 +86,11 @@ static int find_dominating_parents(struct instruction *insn,
 			goto found_dominator;
 		} END_FOR_EACH_PTR_REVERSE(one);
 no_dominance:
-		if (parent->generation == generation)
+		if (parent->generation == bb->generation)
 			continue;
-		parent->generation = generation;
+		parent->generation = bb->generation;
 
-		if (!find_dominating_parents(insn, parent, generation, dominators, local))
+		if (!find_dominating_parents(insn, parent, dominators, local))
 			return 0;
 		continue;
 
@@ -146,7 +146,6 @@ static void simplify_loads(struct basic_block *bb)
 			pseudo_t pseudo = insn->src;
 			int local = local_pseudo(pseudo);
 			struct pseudo_list *dominators;
-			unsigned long generation;
 
 			if (insn->is_volatile)
 				continue;
@@ -177,10 +176,9 @@ static void simplify_loads(struct basic_block *bb)
 			} END_FOR_EACH_PTR_REVERSE(dom);
 
 			/* OK, go find the parents */
-			generation = ++bb_generation;
-			bb->generation = generation;
+			bb->generation = ++bb_generation;
 			dominators = NULL;
-			if (find_dominating_parents(insn, bb, generation, &dominators, local)) {
+			if (find_dominating_parents(insn, bb, &dominators, local)) {
 				/* This happens with initial assignments to structures etc.. */
 				if (!dominators) {
 					if (local) {
-- 
2.31.0

