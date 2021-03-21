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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCAC433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2D261864
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCUQS0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCUQSR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A222C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id b9so17383984ejc.11
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eo9svFSXNAbzExMJ8PSOaDkeNUCU7lNCsywyf5d6/FU=;
        b=j9pUDGOXKq8vC0xW5OhcZuwmapD5CL6M8eaKQztEkm86TRKMNOZvyKTmLdY8d71jPI
         ePM7TTsCE+f/kh6LJVJpu8irTXGpnrVNUIsCE+c7OLJzbzU38FTHVBwWAQUTpuCenDsz
         vbUF5n36GNlm1wyRWd6lb+cJthY9g4TAyqEGg+E+0F3+5n++qdBgUqlzWCUglJx/E4s7
         Y8Oxixf8yOSllMJjYaC7hC0mJ1Me42ESdFle4br407lsC3NHZam1D7WHAZd+/752NSvH
         Gh5TrHygKQT1I8KAF3Qw8xIGMLequLlZ7muy97glMSiTF5i1VECPGqSYrTO1ZRcqqT/8
         0oRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eo9svFSXNAbzExMJ8PSOaDkeNUCU7lNCsywyf5d6/FU=;
        b=bCDwwKdQD7M2c12JTmK6vPJslFu1ENzO127p0QRwDsjHQzisWiQxcnAEUTqMff5gSa
         LUY5vmtZRfBmsvaSZWtA8+7zz7+IXgngCeFrCIzclc2zXF44TJGh2/SsxyWZVrakGqNc
         xAYXY5QEF/LbO9htTb/8YVQ55ZrL/FtZvhc/9C22yPufp0slDPnZvmFGkxS1iWG+WmQr
         LbUle7wM3BajxFWJgTHRkgKjrkdxZV/q26GmNENyl6SA0BXi79fdoKeGSOHsPWvNJvWX
         X6pNZScpB3O+TvZ3s7i/ydwXHaJctjQj1gAPefqM45XRrdiLWndwcuz/alZ5r10XIANn
         Jqfw==
X-Gm-Message-State: AOAM532NRjYde2/xqnkDfwGkgf0PGLj2mtQWlwyZv26QI2Zbq7coxguS
        LypCHe4Roh5CbvUkdCXRcpVmHUaoRyY=
X-Google-Smtp-Source: ABdhPJwTAtDiFtkjYGpX6sEvyJdasnk9+OVZE+DJMImBPb8LrQ8db/qFmVvGiLAvQRc7YA1LyBe22A==
X-Received: by 2002:a17:906:e0d6:: with SMTP id gl22mr14918049ejb.444.1616343496112;
        Sun, 21 Mar 2021 09:18:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:15 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] let find_dominating_parents() use insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:08 +0100
Message-Id: <20210321161609.45905-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
References: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/memops.c b/memops.c
index ff54208e2d54..f74bff2abf88 100644
--- a/memops.c
+++ b/memops.c
@@ -65,8 +65,8 @@ static int find_dominating_parents(pseudo_t pseudo, struct instruction *insn,
 	struct basic_block *parent;
 
 	FOR_EACH_PTR(bb->parents, parent) {
+		struct instruction *phisrc;
 		struct instruction *one;
-		struct instruction *br;
 		pseudo_t phi;
 
 		FOR_EACH_PTR_REVERSE(parent->insns, one) {
@@ -95,12 +95,12 @@ no_dominance:
 		continue;
 
 found_dominator:
-		br = delete_last_instruction(&parent->insns);
-		phi = alloc_phi(parent, one->target, one->type);
+		phisrc = alloc_phisrc(one->target, one->type);
+		phisrc->phi_node = insn;
+		insert_last_instruction(parent, phisrc);
+		phi = phisrc->target;
 		phi->ident = phi->ident ? : one->target->ident;
-		add_instruction(&parent->insns, br);
 		use_pseudo(insn, phi, add_pseudo(dominators, phi));
-		phi->def->phi_node = insn;
 	} END_FOR_EACH_PTR(parent);
 	return 1;
 }		
-- 
2.31.0

