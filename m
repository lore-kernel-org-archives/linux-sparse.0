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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B872C433EB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D316194C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCUMf2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCUMfS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7385CC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r12so16831851ejr.5
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdCvsHh96rDSYiMxCeNGHa83d2TUkZ2fHdWdWFmKug0=;
        b=g/RbVzwBKzAATT/imme5OnK9/76UFiDzgDikA6e0u5IUoTM+ckD6c5OtGMh1yvnJVI
         1kBnBS2SRypsHVl2DiPpvVpCzwsZRvfGRy2jei++T7dIIPu4hV1nKIEmjXxsUjfdgpN+
         BP5AmROVDrXZtNDWiLjEIPJR1ci1mOHD+0OON/k+NL2JuIQ6FIQFBiEuAAFnwedBc9oC
         VPn+b1EzWxFutlmfhRUeTcSPDcK9hCnCm6x1URgLXnVkuzbk9mJ5MHnOOtYy7NX6bjMP
         0rVBDrbw1Ta9jInpam9g8tTTaHgwyK4qyoCuvUJshLBPeVjtfmCyhC9Oim06UZd+683+
         AkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qdCvsHh96rDSYiMxCeNGHa83d2TUkZ2fHdWdWFmKug0=;
        b=RntVzn4ttrIBttwYz4jyH6FHCjBGfUVCh7JC3+xWK0uDvB7JU+k3v2HmQcKk/jLYu7
         FNLLhc9GPkTLpTp+8CqI3kfC54O6asMf/Cp6K47Pb4Ts5ad4GPAmH5im8AaPegMLOpfe
         8aGg8cqaMa6aToBJ4CEoaZvaRWO0oBVhrpiqzEjtaJj1CRH0lfQlK4IxQyXU1mjsK2Ve
         YdiMMyXGzte/qXmNE3IcsK/vF0pFnqTccNKxLrKugTVvDnTWiD6ZyK6V1DPsJHpZ1qs+
         jMD7NbGdrQmqIu/LcHhw8az6lrhBvJmZURNJMkkE/QyhSLlJobPf4uEEA9whP19lvlAB
         kkNA==
X-Gm-Message-State: AOAM533fk0GoXUXkD5AcoojHyO0AZKpspCkPFLbK7ZXfJ74rwjRogaIx
        FDG0kFvxBDDXV4NDkdv8GSTPsg08grA=
X-Google-Smtp-Source: ABdhPJwOGgN6JdLA+0bBF1g6GYdIJOjlmHyOrr6gMm9LNJBatgiyBR0PXSxEEZE+iBYRKz7Jw1038Q==
X-Received: by 2002:a17:907:20e4:: with SMTP id rh4mr14399630ejb.369.1616330117291;
        Sun, 21 Mar 2021 05:35:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/13] let insert_branch() return a status
Date:   Sun, 21 Mar 2021 13:35:00 +0100
Message-Id: <20210321123505.27993-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

insert_branch() modifies the CFG and the usage of pseudos so these
changes must be, in a way or another, notify to the upper layers.
Currently this is done by setting 'repeat_phase' in the function
itself.

Let this function to also report the changes via its return value
since this is usually useful for the caller to know and tend to
leaner code too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c     |  7 +++++--
 flow.h     |  2 +-
 simplify.c | 21 +++++++--------------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/flow.c b/flow.c
index 1f4b4ff08151..38e0ccade722 100644
--- a/flow.c
+++ b/flow.c
@@ -711,10 +711,11 @@ void vrfy_flow(struct entrypoint *ep)
 
 ///
 // change a switch or a conditional branch into a branch
-void insert_branch(struct instruction *insn, struct basic_block *target)
+int insert_branch(struct instruction *insn, struct basic_block *target)
 {
 	struct basic_block *bb = insn->bb;
 	struct basic_block *child;
+	int changed = REPEAT_CSE;
 
 	kill_use(&insn->cond);
 	insn->bb_true = target;
@@ -730,9 +731,11 @@ void insert_branch(struct instruction *insn, struct basic_block *target)
 		}
 		DELETE_CURRENT_PTR(child);
 		remove_bb_from_list(&child->parents, bb, 1);
+		changed |= REPEAT_CFG_CLEANUP;
 	} END_FOR_EACH_PTR(child);
 	PACK_PTR_LIST(&bb->children);
-	repeat_phase |= REPEAT_CFG_CLEANUP;
+	repeat_phase |= changed;
+	return changed;
 }
 
 static int retarget_parents(struct basic_block *bb, struct basic_block *target)
diff --git a/flow.h b/flow.h
index f9213306dfd6..cad1de7723d5 100644
--- a/flow.h
+++ b/flow.h
@@ -18,7 +18,7 @@ extern void simplify_symbol_usage(struct entrypoint *ep);
 extern void simplify_memops(struct entrypoint *ep);
 extern void pack_basic_blocks(struct entrypoint *ep);
 extern int simplify_cfg_early(struct entrypoint *ep);
-extern void insert_branch(struct instruction *insn, struct basic_block *target);
+extern int insert_branch(struct instruction *insn, struct basic_block *target);
 
 extern void convert_instruction_target(struct instruction *insn, pseudo_t src);
 extern void remove_dead_insns(struct entrypoint *);
diff --git a/simplify.c b/simplify.c
index 930c0fa7e83f..0bc201e84313 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2440,10 +2440,8 @@ static int simplify_branch(struct instruction *insn)
 	pseudo_t cond = insn->cond;
 
 	/* Constant conditional */
-	if (constant(cond)) {
-		insert_branch(insn, cond->value ? insn->bb_true : insn->bb_false);
-		return REPEAT_CSE;
-	}
+	if (constant(cond))
+		return insert_branch(insn, cond->value ? insn->bb_true : insn->bb_false);
 
 	/* Same target? */
 	if (insn->bb_true == insn->bb_false) {
@@ -2472,14 +2470,10 @@ static int simplify_branch(struct instruction *insn)
 			if (constant(def->src2) && constant(def->src3)) {
 				long long val1 = def->src2->value;
 				long long val2 = def->src3->value;
-				if (!val1 && !val2) {
-					insert_branch(insn, insn->bb_false);
-					return REPEAT_CSE;
-				}
-				if (val1 && val2) {
-					insert_branch(insn, insn->bb_true);
-					return REPEAT_CSE;
-				}
+				if (!val1 && !val2)
+					return insert_branch(insn, insn->bb_false);
+				if (val1 && val2)
+					return insert_branch(insn, insn->bb_true);
 				if (val2) {
 					struct basic_block *tmp = insn->bb_true;
 					insn->bb_true = insn->bb_false;
@@ -2515,8 +2509,7 @@ static int simplify_switch(struct instruction *insn)
 	return 0;
 
 found:
-	insert_branch(insn, jmp->target);
-	return REPEAT_CSE;
+	return insert_branch(insn, jmp->target);
 }
 
 static struct basic_block *is_label(pseudo_t pseudo)
-- 
2.31.0

