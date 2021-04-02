Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA1C433B4
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020EA6113E
	for <linux-sparse@archiver.kernel.org>; Fri,  2 Apr 2021 20:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhDBU0M (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 2 Apr 2021 16:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBU0M (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Apr 2021 16:26:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8ABC0613E6
        for <linux-sparse@vger.kernel.org>; Fri,  2 Apr 2021 13:26:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id bx7so6459651edb.12
        for <linux-sparse@vger.kernel.org>; Fri, 02 Apr 2021 13:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zMArcpK8fFpQxYXd8UpEaQh2pRufQVTZa79MgkLdmY=;
        b=NHrtxmG+4JqZmna+nsOkjTI5o0QYR3vFzBkzB0DHJ6JZIS2JGrxByfvOMVkx1acZxs
         MgVWgArO4JyG7c8L142wYSwXaJBrqxQIKwrGDViLUzD9A83o3kFu2D7KNb17ibPM2+b2
         aEV0ZDHkLkIYJYdHDGpoEjBlfAfdnMTQdFtID7e99B/mapK/cCLDg+VzB1E7tizNdlsg
         bBC7Vzdm6/HItbttc7ARsuNwCIGu6gwBx1RK9bOyWS+tLjS87BOPuSZRU74gNHsOZjpl
         smffvnHQIgLui64sIEK3E49J6Sl5UIyOuU1opE2PVUHJF+Jfy7eL6s44b4+5gOKZtFSt
         /HDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zMArcpK8fFpQxYXd8UpEaQh2pRufQVTZa79MgkLdmY=;
        b=BFL6ve096LiEKZp5K4CdpCHFI1N0l9Mj8kyhvMdvCF3B4fBg0GOFBY6ApikVYSHVJY
         iBE4sTpKLQvlHa8r5bMVYtOJWNlzcnpOii8eOYs95LIJphDRI7s3WjIFd2zUwCFYAaXd
         i/+1kqyoqSFTOI/40DQFq8YRqAT9y8/BnzpXp5DGUJemwbrUADpQYYS0uLTI/JRMyurZ
         0Eb9zVGvFyAa+peAOlA088nxL5TS2yNDln1AT2sg2drdUW93NMPzra7XTVXxBtVTRPmk
         VajF34FqCJpX4HvLqzptb3nig7Ogmc0+HlFRwArXCPN2xtgcgsXyOfplDHom1PKf6dmB
         PPoA==
X-Gm-Message-State: AOAM530S2THlTKhgbhK/kZRaBhfcZRCCjF4gL4Qh8vHSxds0qctoKoKj
        +QzwUdk6tHeXQ5qLvPumekSlGgzS3MY=
X-Google-Smtp-Source: ABdhPJzpYlye2Kmi6ZCmWHMTSfm7C73+TZ1WeUAsGW5+1CSOH9eEDgXtTubrROBKwDcaXQm1dEP3EQ==
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr17487461edr.387.1617395167673;
        Fri, 02 Apr 2021 13:26:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e8a3:6a32:4891:b7b])
        by smtp.gmail.com with ESMTPSA id p24sm6011890edt.5.2021.04.02.13.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 13:26:06 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] fix remove_merging_phisrc()
Date:   Fri,  2 Apr 2021 22:25:58 +0200
Message-Id: <20210402202558.54504-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
References: <20210402202558.54504-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current implementation of remove_merging_phisrc() can't work correctly
when these phi-sources belong to a basic block with several children
to the same target basic block (this happens commonly with OP_SWITCH).

Fix this by directly scanning the source basic block for the presence
of any phi-source. Once identified, the processing is kept unchanged:
remove these phi-sources if a sibling phi-source will 'overwrite' them
in the target block.

Fixes: 2fdaca9e7175e62f08d259f5cb3ec7c9725bba68
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                          | 30 ++++++++++++++++++++----------
 validation/optim/multi-phisrc.c |  1 -
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/flow.c b/flow.c
index c866dec80480..d46d0ee1bb7e 100644
--- a/flow.c
+++ b/flow.c
@@ -843,21 +843,26 @@ static int retarget_parents(struct basic_block *bb, struct basic_block *target)
 	return REPEAT_CFG_CLEANUP;
 }
 
-static void remove_merging_phisrc(struct basic_block *top, struct instruction *insn)
+static void remove_merging_phisrc(struct instruction *insn, struct basic_block *bot)
 {
-	struct instruction *user = insn->phi_node;
+	struct instruction *node = insn->phi_node;
 	pseudo_t phi;
 
-	FOR_EACH_PTR(user->phi_list, phi) {
+	if (!node) {
+		kill_instruction(insn);
+		return;
+	}
+
+	FOR_EACH_PTR(node->phi_list, phi) {
 		struct instruction *phisrc;
 
 		if (phi == VOID)
 			continue;
 		phisrc = phi->def;
-		if (phisrc->bb != top)
-			continue;
-		REPLACE_CURRENT_PTR(phi, VOID);
-		kill_instruction(phisrc);
+		if (phisrc->bb == bot) {
+			kill_instruction(insn);
+			return;
+		}
 	} END_FOR_EACH_PTR(phi);
 }
 
@@ -901,6 +906,14 @@ static int merge_bb(struct basic_block *top, struct basic_block *bot)
 		replace_bb_in_list(&bb->parents, bot, top, 1);
 	} END_FOR_EACH_PTR(bb);
 
+	FOR_EACH_PTR(top->insns, insn) {
+		if (!insn->bb)
+			continue;
+		if (insn->opcode != OP_PHISOURCE)
+			continue;
+		remove_merging_phisrc(insn, bot);
+	} END_FOR_EACH_PTR(insn);
+
 	kill_instruction(delete_last_instruction(&top->insns));
 	FOR_EACH_PTR(bot->insns, insn) {
 		if (!insn->bb)
@@ -910,9 +923,6 @@ static int merge_bb(struct basic_block *top, struct basic_block *bot)
 		case OP_PHI:
 			remove_merging_phi(top, insn);
 			continue;
-		case OP_PHISOURCE:
-			remove_merging_phisrc(top, insn);
-			break;
 		}
 		insn->bb = top;
 		add_instruction(&top->insns, insn);
diff --git a/validation/optim/multi-phisrc.c b/validation/optim/multi-phisrc.c
index c6f21f2db15a..ff31c0834e58 100644
--- a/validation/optim/multi-phisrc.c
+++ b/validation/optim/multi-phisrc.c
@@ -17,7 +17,6 @@ void foo(int p, int a)
 /*
  * check-name: multi-phisrc
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: phi
-- 
2.31.1

