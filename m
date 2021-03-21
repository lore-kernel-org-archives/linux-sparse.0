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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D2C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C116192C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCURJG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbhCURI2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D8AC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so17492518ejc.9
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JF3q0Wp1aD+/Ry+ocJbhaHWsTsz6av/7CMpb4TrpYDU=;
        b=iMH6J6IfegfDOMspTsPCZ+XJZoZLrvjuJlFjObRBwos8uVx3/F93a7h7EwN0z4+m3+
         c/3vV+S6deXDyzrp8ZeECPHdEO0v2SlyYH9eq4sCQvV3DY35XG4+JUtY0vWWFran3FJs
         JLlb7APRdPkNCVUB+BHEp10YoDJe71dNiLV7rQ7oeghH82s4sX5dlok5XtEWgHj+6uau
         wEwXSshzOsYcaePQz0CaTVm6LSSRw/oiTpc87M5sCb26zjx/2PR71fTvdiwsfniaQClm
         QN5y1IbpJ5mN/rI9uElqawuKqxFTiKyLzlkzXtA6glvT79VxFAuAuowTZd8W46wq/7VO
         XAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JF3q0Wp1aD+/Ry+ocJbhaHWsTsz6av/7CMpb4TrpYDU=;
        b=mnNaeFYLoRLngV4cSPMT2dsE56XaGhpUn/X925HpZ6HjCUxEFcUD7fgq9qMmtA5oMv
         c+DOE+ESrKyLtAwUAHh7pUKLS/nPTUwDe6FAXY7685UGJ/HLxZz9xLOylRVCeXek6qYS
         Ywt1CGTnqSjSZZOU1TZ7JABCJ0olLClbxGXQ+v/OA+XqTpIWzBYqKjQeESb6JqzjSnDc
         g6pegbkiHXiGJGWGuzVid3U+CDLW3sdjWx18cFGbTKoMWFBaw8a1LkCmt0OlTd6UspW2
         MTnAlv8I923yawD5N53k87ye/xsTd3JjXPY519AQ387PL7Ox96iTYQ4BLwe0OU3XEPOG
         ShIQ==
X-Gm-Message-State: AOAM530G7MP6S4Xpcd06/YxQFQLYHew1pupFZgye6qU0tR1QGLq0qSBX
        FSt66LFeNbOgidaQngTJeP0YwNnuodU=
X-Google-Smtp-Source: ABdhPJx1A5Y+GZYv7vUc+n0pZA1V9n9Z1aYw5uhYDm59c3VHGCb4NkufqWUkxXM50wVsViNl5CUM8Q==
X-Received: by 2002:a17:906:78d:: with SMTP id l13mr15441296ejc.97.1616346507000;
        Sun, 21 Mar 2021 10:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:26 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] memops: dominates()s first arg is redundant
Date:   Sun, 21 Mar 2021 18:08:17 +0100
Message-Id: <20210321170822.46854-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The first argument of dominates(), 'pseudo', is simply the 'src'
pseudo of it's second argument, the load or store instruction.

It's thus not needed to give it in a separate argument.

So, remove this redundant argument, since it makes things
slightly clearer.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c   |  4 ++--
 flow.h   |  2 +-
 memops.c | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/flow.c b/flow.c
index cb94fcf20834..c235c5e92c8a 100644
--- a/flow.c
+++ b/flow.c
@@ -423,7 +423,7 @@ static inline int distinct_symbols(pseudo_t a, pseudo_t b)
  *
  * Return 0 if it doesn't, and -1 if you don't know.
  */
-int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local)
+int dominates(struct instruction *insn, struct instruction *dom, int local)
 {
 	switch (dom->opcode) {
 	case OP_CALL: case OP_ENTRY:
@@ -440,7 +440,7 @@ int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom
 		return 0;
 	}
 
-	if (dom->src != pseudo) {
+	if (dom->src != insn->src) {
 		if (local)
 			return 0;
 		/* We don't think two explicitly different symbols ever alias */
diff --git a/flow.h b/flow.h
index c489ebe03034..d578fa95061a 100644
--- a/flow.h
+++ b/flow.h
@@ -41,7 +41,7 @@ static inline int kill_instruction_force(struct instruction *insn)
 }
 
 void check_access(struct instruction *insn);
-int dominates(pseudo_t pseudo, struct instruction *insn, struct instruction *dom, int local);
+int dominates(struct instruction *insn, struct instruction *dom, int local);
 
 extern void vrfy_flow(struct entrypoint *ep);
 extern int pseudo_in_list(struct pseudo_list *list, pseudo_t pseudo);
diff --git a/memops.c b/memops.c
index ff54208e2d54..7d9e4d703ee3 100644
--- a/memops.c
+++ b/memops.c
@@ -58,7 +58,7 @@ end:
 	repeat_phase |= REPEAT_CSE;
 }
 
-static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
+static int find_dominating_parents(struct instruction *insn,
 	struct basic_block *bb, unsigned long generation, struct pseudo_list **dominators,
 	int local)
 {
@@ -75,7 +75,7 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 				continue;
 			if (one == insn)
 				goto no_dominance;
-			dominance = dominates(pseudo, insn, one, local);
+			dominance = dominates(insn, one, local);
 			if (dominance < 0) {
 				if (one->opcode == OP_LOAD)
 					continue;
@@ -90,7 +90,7 @@ no_dominance:
 			continue;
 		parent->generation = generation;
 
-		if (!find_dominating_parents(pseudo, insn, parent, generation, dominators, local))
+		if (!find_dominating_parents(insn, parent, generation, dominators, local))
 			return 0;
 		continue;
 
@@ -160,7 +160,7 @@ static void simplify_loads(struct basic_block *bb)
 				int dominance;
 				if (!dom->bb)
 					continue;
-				dominance = dominates(pseudo, insn, dom, local);
+				dominance = dominates(insn, dom, local);
 				if (dominance) {
 					/* possible partial dominance? */
 					if (dominance < 0)  {
@@ -180,7 +180,7 @@ static void simplify_loads(struct basic_block *bb)
 			generation = ++bb_generation;
 			bb->generation = generation;
 			dominators = NULL;
-			if (find_dominating_parents(pseudo, insn, bb, generation, &dominators, local)) {
+			if (find_dominating_parents(insn, bb, generation, &dominators, local)) {
 				/* This happens with initial assignments to structures etc.. */
 				if (!dominators) {
 					if (local) {
@@ -226,7 +226,7 @@ static void kill_dominated_stores(struct basic_block *bb)
 				int dominance;
 				if (!dom->bb)
 					continue;
-				dominance = dominates(pseudo, insn, dom, local);
+				dominance = dominates(insn, dom, local);
 				if (dominance) {
 					/* possible partial dominance? */
 					if (dominance < 0)
-- 
2.31.0

