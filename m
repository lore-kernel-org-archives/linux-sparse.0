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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD78C433E5
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1259B61946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhCURJH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCURIb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28C6C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u9so17489822ejj.7
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o9O/t7DIwQXjQjmlQ8dOVimiEpImz/xtfBcJterv9Ss=;
        b=A07jUq6b/8OnJ0alfY1ZqqtDdg3XhKF4Pr8bw71y310NvbajpxxlxgLVeE1TA6bL6y
         IsbXhKQ22sizG7WVh93SggeibD/kykbtMchbBfANqR4vsnEVnayXvV96u+1V3uFFqwkQ
         gh/YeEcm1DhlebmtHnqrGfAxE5IjCcY1H1nGnOFmq17Oq2/FAfdRP6Qwkdi8ivn8snVG
         G3wU+VQpQIUoxynTbQBVvAEZJErxYcghaAKQlhd03QXwX5i95m5Z8NQUZkStBBm6mYVW
         Iweod+LUV4Ui3Qpaa9im4wIx/OU93jrqevJsw/Q91SsJ6SinEbHrLlgvyuW1oenDDP/x
         w7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o9O/t7DIwQXjQjmlQ8dOVimiEpImz/xtfBcJterv9Ss=;
        b=Cn7PJra8t3OfXoMN2z8Rbynl0apRauV6V5A97h4ubUzk/7HFnN7E1vfQ6+GjQ28ddD
         4/wauhxLiRmfNM+llUXrHSpnTR22RbMNhE4mskbWMRSced3+68IWgs5DOjLHm5omvIvK
         j2t7RA4ep+8B2PoGfNv/aIuI7MRBbNrgYJlLcCNjAPaP5T2z0mrUqNpvHzYAwii/0SWm
         tzsBd4l0VTdkMoFtchSz9i98OYdtA2pr+KUws9thcBb370AuHeuRJ/rPDRr2UAj266NR
         3MR4/qeSjWUzTx76Zm5k1XzSDOQzYudYD5NfUyuUgyZ2OX0Mb2NHAJTNrFNVRlciIrBE
         L3Jg==
X-Gm-Message-State: AOAM530VnF7hTSvzL0S4/fe7DHKdz2vLRwkAydhc6Adx1lNPtJc6gL8N
        X9+AgGm3abo4YZ/neT/2kONlN6Ka4QE=
X-Google-Smtp-Source: ABdhPJySC82nmu3LmURTJ3K+nd5B0mSaU87RgivX0zCooxkTb2bXLWDf+f5ex34cKU4gh1UJg8fC1g==
X-Received: by 2002:a17:906:f6ce:: with SMTP id jo14mr15637580ejb.476.1616346509603;
        Sun, 21 Mar 2021 10:08:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:29 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] memops: avoid using first_pseudo()
Date:   Sun, 21 Mar 2021 18:08:21 +0100
Message-Id: <20210321170822.46854-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The loop in rewrite_load_instruction() uses first_pseudo() to not have
to special case the first element.

But this slightly complicates further changes.

So, simply use a null-or-no-null test inside the loop to identify
this first element.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/memops.c b/memops.c
index 119a39a180d5..897fb6bf57fe 100644
--- a/memops.c
+++ b/memops.c
@@ -19,15 +19,17 @@
 
 static void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
 {
-	pseudo_t new, phi;
+	pseudo_t new = NULL;
+	pseudo_t phi;
 
 	/*
 	 * Check for somewhat common case of duplicate
 	 * phi nodes.
 	 */
-	new = first_pseudo(dominators)->def->phi_src;
 	FOR_EACH_PTR(dominators, phi) {
-		if (new != phi->def->phi_src)
+		if (!new)
+			new = phi->def->phi_src;
+		else if (new != phi->def->phi_src)
 			goto complex_phi;
 	} END_FOR_EACH_PTR(phi);
 
-- 
2.31.0

