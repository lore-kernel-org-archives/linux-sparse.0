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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113ADC433E5
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A4A6193A
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbhCUQS0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhCUQSS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC6C061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so17366086ejs.3
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WN5VWFGjCfI+jnZKuvmUolfrJcEpyaIRmr0S+DqXjlk=;
        b=vMKiIR9i6nKGRIWjw2Iu7uPr70LX++2m4ETEjRaXQv7u8HPLNL4/9jWY8t9e63VPP8
         uydBzLSIKv7Rie6pK8AgtyQkUboE9puwySTGolXjbfqpMraul5dIwV8WJtoVbio8uBkB
         Tgf8TpsqlBCtXfk/7iAZ8CUwrAEoB7YjJocMtdRLfdurxmBpnS9Smx9mGZZ0QtQuD2jq
         QRG3QNdoMGQDrLAYCWYgyMeSVrQfELOpHk3xFsudZ4H+Tvsw5udknBwii2AyaADSklwC
         0kAYDkpT8iOPIHYhZ26FJMDV2MLwgJII2aWKbDsyIRmS+NNUmE5OUxTstVKmYocd/b2k
         kzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WN5VWFGjCfI+jnZKuvmUolfrJcEpyaIRmr0S+DqXjlk=;
        b=RlhOSjC32R4uIrnO2OvFvJYHujkf/dIoNUujQjxt1G5i4Kd8a7KQGX7seXNoIU7gMG
         sQ/uhD3ors4XGnTQ/b064P1efEtuOHhGkCA+Wgfe91wGy3rpE0MVTBYjNl1T4ZEY1/0L
         JQU2EQGW5jsQRayevqqnOKXL5HrIFoJLHaeCM7JBgUPazAxxC5zVLVTupoHvN61JfvJa
         BsS2dbfQEtyHcfjNz9JWbVn0C/QwgVSjJd79p/GvK6m3GGN6a3g9XcM3gRuvrj9nQ3G9
         GmYpgHNEo8snEnvEEm7+TFMTjfupZVNPsdGPDQJPiEVI/HXVSrUqIL6/6K6Pv8WDVKas
         PrXg==
X-Gm-Message-State: AOAM533UXRZfTyURYuR7I937joJZIY3kiT8SnCZXjiz+BUFTiJouB/ZY
        fOWVlTVKeXY19jLdxWEueBFCiIaL8No=
X-Google-Smtp-Source: ABdhPJwLOnt7iPgkVPFgfXFcWTpeKnNrDWR0UkiuB27Ov9ieAZJhOhN51lIESYyopboJKh5Lpm5JnQ==
X-Received: by 2002:a17:906:4015:: with SMTP id v21mr15619769ejj.433.1616343496704;
        Sun, 21 Mar 2021 09:18:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:16 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] let ssa_rename_phi() use insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:09 +0100
Message-Id: <20210321161609.45905-7-luc.vanoostenryck@gmail.com>
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
 ssa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ssa.c b/ssa.c
index b9044207db16..5f1a52b8fe94 100644
--- a/ssa.c
+++ b/ssa.c
@@ -345,11 +345,11 @@ static void ssa_rename_phi(struct instruction *insn)
 	if (!var->torename)
 		return;
 	FOR_EACH_PTR(insn->bb->parents, par) {
-		struct instruction *term = delete_last_instruction(&par->insns);
 		pseudo_t val = lookup_var(par, var);
-		pseudo_t phi = alloc_phi(par, val, var);
+		struct instruction *phisrc = alloc_phisrc(val, var);
+		pseudo_t phi = phisrc->target;
 		phi->ident = var->ident;
-		add_instruction(&par->insns, term);
+		insert_last_instruction(par, phisrc);
 		link_phi(insn, phi);
 		mark_phi_used(val);
 	} END_FOR_EACH_PTR(par);
-- 
2.31.0

