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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683D6C433E5
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505C461946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCUMf3 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCUMfU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44AEC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so16848366ejv.1
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrT5JwJ4a/A3XHo1/pfX52BDzwc1WHWNFxARYbZ+WVE=;
        b=vRr04TiivGVHaxQJ4lWtB1icjCx7k79eQ7byY1i1zeYsKnVyrjhp1/ftdvFU2qL/Ke
         M8U8nscM56L0F/CgbBFdIHz274EYRYRIaVAter/yChv/iMHdrKAwUMNJHcs7TdjjRkW4
         jkjvaLC52S5afKivVylyinLMnAJHpIj2qxZVPCVZUCiVuNRUvqcZhqlrtczT7SrxnmRM
         bRiJ9XhkbklUUA6TYqZQOc8r84At5KyGHuWKLp14iLpMW/iTasVlMfZicbbBfjdcoOCD
         Tg/U+QaGUWqLg8Z5trhIZovNoE4qau38wmdkqMrwR2Hh5R8hjiGMv0Hbmg7cUBugJNlz
         duGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrT5JwJ4a/A3XHo1/pfX52BDzwc1WHWNFxARYbZ+WVE=;
        b=BdUIdR4BImTs8WieCFMtiWien4hmwvcBCR7RlPwnL6gyPCu0UyCzfp/2UoAcI9Hhv+
         21aBLig733gT/9h8iQSpiyIcgeNdE7jfP+uqmFOQwSPhbT0M4mCr5gqbRFwjzFSi9zoK
         tjb/wVSuE6j01j55yn/6kDlypS48rxNP0RFca2aeh0Dq2PuvdpAEdFbjmIvSVIGzIoZ2
         jrtvmd2hk6+Mr65Y7vMO1eH77t9iIx8S8M3uGma9VXz17hlXlT1ugKjtspTdYK1kRH59
         OYy9znItOzV+Ujzu6fUQondSnIXfWv0/qLl4Alae6d9rsWthNM5tOJ/Ta18tRcFUuIIq
         PRSA==
X-Gm-Message-State: AOAM532lawG9nKYLymyhGrqlsgglEV57myHHkTMZzodbYSKLPWPwIjKa
        0xPm47OXp0a1MEtzhKvWGPtqCmlDTMo=
X-Google-Smtp-Source: ABdhPJxguhR8z0P3nakWnbx8yGCXDT0lXQnkTTjFhoog8mTUNswPYIkNbV1aAOzNcvcaxtzPBO+ABg==
X-Received: by 2002:a17:906:9509:: with SMTP id u9mr14280172ejx.225.1616330118402;
        Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:18 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/13] add remove_phisources()
Date:   Sun, 21 Mar 2021 13:35:02 +0100
Message-Id: <20210321123505.27993-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When a parent is removed from a BB containing one or several phi-nodes,
the corresponding phi-sources become irrelevant and need to be removed
from the phi-nodes.

Add an helper for doing this: remove_phisources().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 flow.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/flow.c b/flow.c
index 8106cfc0d10b..4952562a373d 100644
--- a/flow.c
+++ b/flow.c
@@ -22,6 +22,49 @@
 
 unsigned long bb_generation;
 
+///
+// remove phi-sources from a removed edge
+//
+// :note: It's possible to have several edges between the same BBs.
+//	  It's common with switches but it's also possible with branches.
+//	  This function will only remove a single phi-source per edge.
+int remove_phisources(struct basic_block *par, struct basic_block *old)
+{
+	struct instruction *insn;
+	int changed = 0;
+
+	FOR_EACH_PTR(old->insns, insn) {
+		pseudo_t phi;
+
+		if (!insn->bb)
+			continue;
+		if (insn->opcode != OP_PHI)
+			return changed;
+
+		// found a phi-node in the target BB,
+		// now look after its phi-sources.
+		FOR_EACH_PTR(insn->phi_list, phi) {
+			struct instruction *phisrc = phi->def;
+
+			if (phi == VOID)
+				continue;
+			assert(phisrc->phi_node == insn);
+			if (phisrc->bb != par)
+				continue;
+			// found a phi-source corresponding to this edge:
+			// remove it but avoid the recursive killing.
+			REPLACE_CURRENT_PTR(phi, VOID);
+			remove_use(&phisrc->src);
+			phisrc->bb = NULL;
+			changed |= REPEAT_CSE;
+			// Only the first one must be removed.
+			goto next;
+		} END_FOR_EACH_PTR(phi);
+next: ;
+	} END_FOR_EACH_PTR(insn);
+	return changed;
+}
+
 /*
  * Dammit, if we have a phi-node followed by a conditional
  * branch on that phi-node, we should damn well be able to
diff --git a/flow.h b/flow.h
index 2103a10fe428..c489ebe03034 100644
--- a/flow.h
+++ b/flow.h
@@ -11,6 +11,8 @@ extern unsigned long bb_generation;
 struct entrypoint;
 struct instruction;
 
+extern int remove_phisources(struct basic_block *par, struct basic_block *old);
+
 extern int simplify_flow(struct entrypoint *ep);
 
 extern void kill_dead_stores(struct entrypoint *ep, pseudo_t addr, int local);
-- 
2.31.0

