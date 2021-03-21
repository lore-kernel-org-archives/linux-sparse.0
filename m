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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965AC433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317E26194A
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCUMf2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCUMfT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F544C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z1so16088558edb.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ncp3Ty72khzW9ORl77uMF4OR2IBlzkrexTvb+n75fEw=;
        b=XmfILwb9oGNSE8jlsSIRjjWUVppOJYMlQIWAzdEJIA/lPpShv+rr/U/NtzqQH5aMph
         nUbcmRgMkb3epaOpUvbNwKQ5BbShoeZcNjT6UWXOed1UIYwIUhxx9bGvfT15gKop9cCh
         CJgZsnfwmX8hCnsaqa/JZGwojbqms6u3dE65h0tyPO/osfk0CUfhql0BU/5UutvhrwU8
         M0LHndIpZGyQYV12lsHrZZn4pXIXO6De8AlAnLH/HGt+oG7wFbdbjoLmfp7tWq8ACV3s
         tQjj9syYJM5w30Kn32XqBHyVSWoGiU/jjs8KwwurDhQaV0f4rcIsqIGH05TZwEADsQDV
         Zxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ncp3Ty72khzW9ORl77uMF4OR2IBlzkrexTvb+n75fEw=;
        b=uCLMBYTBn+HNwBKZMjwIqKFTnQHOqE6es3wppiUWudWPuZnLnnE5hx1agWBy3bTysD
         sps55zFkPxU+9sLUTCjpp9Vh4b+CK89GL5x3M4GucDesrRDwqwbk35QJh8WDDwUHpsMo
         W5CyG6u51EOzQMEFayMxiz6nbcFxUwbxX1fGeblc6vDFObDhQqHr8TZSRFlwAfDbD+XC
         bqH8903TIvaar7NQqgrtjRxK3fU/naY1uLQoCKz2FKpyHxsykp2G1A4wv1/uvmttDQh6
         77q9Zuo2UPT1zs8d0djExne6u+ZRIx+xhYkojMo5yfUPz52V7K0oI+4bK1Cc6ebzV2+D
         /tNw==
X-Gm-Message-State: AOAM530388JO44AyGTA2qh8VjP4WT+c+IYnuZ5ExPCn4wQ2NBhJsEzow
        gFrHXHBVlTxpBPLQYPnv0YD/SgnX3E8=
X-Google-Smtp-Source: ABdhPJzYHFNBJ/dLPkzSgfpPEFHVugy3qiUdv4iunLQl6TSjwesdL8unMDUDqJjRfxPHnv44jbNs/Q==
X-Received: by 2002:aa7:c0c7:: with SMTP id j7mr20350705edp.298.1616330117845;
        Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/13] rename insert_branch() to convert_to_jump()
Date:   Sun, 21 Mar 2021 13:35:01 +0100
Message-Id: <20210321123505.27993-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Since the existing branch is now reused, nothing is inserted anymore.

So, rename this function to the more explanatory: convert_to_jump().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c     | 4 ++--
 flow.h     | 2 +-
 simplify.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/flow.c b/flow.c
index 38e0ccade722..8106cfc0d10b 100644
--- a/flow.c
+++ b/flow.c
@@ -268,7 +268,7 @@ try_to_rewrite_target:
 	 */
 	if (bb_list_size(target->parents) != 1)
 		return retval;
-	insert_branch(insn, final);
+	convert_to_jump(insn, final);
 	return 1;
 }
 
@@ -711,7 +711,7 @@ void vrfy_flow(struct entrypoint *ep)
 
 ///
 // change a switch or a conditional branch into a branch
-int insert_branch(struct instruction *insn, struct basic_block *target)
+int convert_to_jump(struct instruction *insn, struct basic_block *target)
 {
 	struct basic_block *bb = insn->bb;
 	struct basic_block *child;
diff --git a/flow.h b/flow.h
index cad1de7723d5..2103a10fe428 100644
--- a/flow.h
+++ b/flow.h
@@ -18,7 +18,7 @@ extern void simplify_symbol_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
 extern int simplify_cfg_early(struct entrypoint *ep);
-extern int insert_branch(struct instruction *insn, struct basic_block *target);
+extern int convert_to_jump(struct instruction *insn, struct basic_block *target);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
diff --git a/simplify.c b/simplify.c
index 0bc201e84313..7171bd564e63 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2441,7 +2441,7 @@ static int simplify_branch(struct instruction *insn)
 
 	/* Constant conditional */
 	if (constant(cond))
-		return insert_branch(insn, cond->value ? insn->bb_true : insn->bb_false);
+		return convert_to_jump(insn, cond->value ? insn->bb_true : insn->bb_false);
 
 	/* Same target? */
 	if (insn->bb_true == insn->bb_false) {
@@ -2471,9 +2471,9 @@ static int simplify_branch(struct instruction *insn)
 				long long val1 = def->src2->value;
 				long long val2 = def->src3->value;
 				if (!val1 && !val2)
-					return insert_branch(insn, insn->bb_false);
+					return convert_to_jump(insn, insn->bb_false);
 				if (val1 && val2)
-					return insert_branch(insn, insn->bb_true);
+					return convert_to_jump(insn, insn->bb_true);
 				if (val2) {
 					struct basic_block *tmp = insn->bb_true;
 					insn->bb_true = insn->bb_false;
@@ -2509,7 +2509,7 @@ static int simplify_switch(struct instruction *insn)
 	return 0;
 
 found:
-	return insert_branch(insn, jmp->target);
+	return convert_to_jump(insn, jmp->target);
 }
 
 static struct basic_block *is_label(pseudo_t pseudo)
-- 
2.31.0

