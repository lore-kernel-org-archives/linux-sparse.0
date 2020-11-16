Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5EAC63777
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBD92244C
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImguAacp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgKPW3j (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgKPW3i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:38 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3CBC0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:38 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so26738488ejk.2
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y20OTX9TInFXtpPpAYcH9brk/dtoPFRCRKNZm0BdChE=;
        b=ImguAacp2RUO8Fxu3yW81XWcsTxbZy0L+FSIn20DARswIJ5DWa3TlxSgBziPdo6eve
         WJ2JMarY0/eTPzwK68diKGQ1UMoc43f8xjOlaHVMcWsGt1c2SannfSsYzHVSq8/shBks
         4dBnKEGU8rUpAobe4503YEvSVln1q75y17RFk2bKsUtea/QoXr+NxQN6Qtsw8MlhUE9h
         UboE76JoGzNX0hAoWrJCOfZLsqZDE9zR+3eL9dEbrXrW69hsOstweAE0f+bJmunQ+xTb
         CvJT9JYNAscr8tz3FAGDCYTwYs88Qq3uGb0xTVprXhJVWlhCdPKenaqIFCaSyy4vVb+m
         GTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y20OTX9TInFXtpPpAYcH9brk/dtoPFRCRKNZm0BdChE=;
        b=EhtopznbEPDblNE+ORMkH8Rw94yGm3dtY0QlXNzEa4RiCw5vp1qTNtsNe5CD5ez6dc
         TjPReOdNj/kCWxFmXVFBVzGs7EkDbYHyxAe+aDLHb+oOJoyTGQMPBYIw+T9pg4VD82Tq
         A5KeO7tVArnr06b4sm6TeBEKDinR1nSKRo+EL7B3pGH96UhpEt7FL9iC0DpV+Mj39yjG
         i4L1TGKoayOd4UdV487RK8J2CmmJT+RIi4dGMTqje/ebD+dFHHzpjrPKOyqNr4BNe8xB
         kCm++UWnoYGfVteM9OOwEKFopx1uOss5n86NYFJzJHMFR8m5N9NUzWcpTjbXJnuKVx4F
         tcKg==
X-Gm-Message-State: AOAM533xcNc34Tw6wo+qMnERaL9KDgsospT5t4iucVRXvultHfSc63Mq
        zRbOXrVZBv7E2+0b021S84NrGcryB0o=
X-Google-Smtp-Source: ABdhPJw3mL8Ybv2NN8gLjFjKjVD99ucwBafKyd/l6DTRoDmdSu7SQHlMDtY8nZyCtv1TD8J4GGZH+A==
X-Received: by 2002:a17:907:b01:: with SMTP id h1mr16019645ejl.10.1605565777161;
        Mon, 16 Nov 2020 14:29:37 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:36 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] cfg: adjust phi-nodes when merging BBs
Date:   Mon, 16 Nov 2020 23:29:24 +0100
Message-Id: <20201116222927.51939-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When merging BBs, it's possible that the top BB feeds one or
several phi-nodes in the bottom BB. Since phi-nodes only make
sense for values incoming from the parent BBs, these phi-nodes
can and should be removed when merging the BBs.

So, when merging BBs, remove these related phi-nodes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/flow.c b/flow.c
index e9c8f6b7355e..23886f9d84fa 100644
--- a/flow.c
+++ b/flow.c
@@ -760,6 +760,26 @@ static void adjust_phisrc(struct basic_block *top, struct instruction *insn)
 	} END_FOR_EACH_PTR(phi);
 }
 
+static void adjust_phi(struct basic_block *top, struct instruction *insn)
+{
+	pseudo_t phi;
+
+	FOR_EACH_PTR(insn->phi_list, phi) {
+		struct instruction *def;
+
+		if (phi == VOID)
+			continue;
+
+		def = phi->def;
+		if (def->bb != top)
+			continue;
+
+		convert_instruction_target(insn, def->src);
+		kill_instruction(def);
+		kill_instruction(insn);
+	} END_FOR_EACH_PTR(phi);
+}
+
 ///
 // merge two BBs
 // @top: the first BB to be merged
@@ -786,6 +806,9 @@ static int merge_bb(struct basic_block *top, struct basic_block *bot)
 			continue;
 		assert(insn->bb == bot);
 		switch (insn->opcode) {
+		case OP_PHI:
+			adjust_phi(top, insn);
+			continue;
 		case OP_PHISOURCE:
 			adjust_phisrc(top, insn);
 			break;
-- 
2.29.2

