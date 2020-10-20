Return-Path: <SRS0=cyFV=D3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AB9C41604
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6CA222C8
	for <linux-sparse@archiver.kernel.org>; Tue, 20 Oct 2020 21:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1JFuP+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438659AbgJTVK2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438655AbgJTVK2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 20 Oct 2020 17:10:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3046C0613CE
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so4862307ejb.6
        for <linux-sparse@vger.kernel.org>; Tue, 20 Oct 2020 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCvya167EhdKOgB5tHySOUm4n1lPWmrVXQ8t80GBlLA=;
        b=e1JFuP+4cMPxiDvftfjcuNDIInqjUfbECJE1OvMFh6LJSRYwVWq54cbtGtwrWFZJLG
         aTdMUUrJ0iklL95R64UwRLNSFjSsyYTTCcrMFzaC5X/kQg5hUWCn4gLuq1IsCNXd4j83
         wEvx6IuoqqrVaY0ZgS6KSmZBU1koGFGV3VstCn5bsFE2SvEkkFygfdmBwxu1VtL6TAKD
         anJh7OtmNZvPAOGmfGiQxuByJw6yr49qohJhXZ+6jvKjgjUCSdcRFDiYqPLF4UrSUCFN
         P53FxfLwybO0nMc3yHhZYzAHGPYJRWS3L31TLSXvPrswNLHF9MWMlK36dNdVt/tqsiOq
         YaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCvya167EhdKOgB5tHySOUm4n1lPWmrVXQ8t80GBlLA=;
        b=MdahetS7SWIp10Pk/lkcTyCKgRAijhq/+qLOazbPkr/0h+uAe9JRT17Z2S0PUIXDNf
         sVnBfKrD4RA74dfAMDp+dGzvGYbGXld5/BT6/fg5R5sp9GcYcKRH5MewOjKRdbSp+CFE
         tjerdE6apEE77Y2TcUWNA+RIFkt7ogX7l4LYIpN36HjUbapKqDm5iWEdK64iNFh26nRQ
         2axOfW/naN9d25Btwz7wdrbH8osJiPUf7YM5o/WHaQQkqw9FNwOtQOJsjXUDGs032tIr
         9ZQ6J3aU8Npa+T5y4IwW6i+BpCrU/Lpm5sxoGxULjoPMnO0dGt7zzfHGDjLtrTMlWXkP
         WYSw==
X-Gm-Message-State: AOAM533xYqGznqzfVAFSxj+LbMD5Wzk/yQTdlvJxm9ILsnCOfXYR89IN
        BjaFEuS1U1V7EZt4RV8DHvruwnZioBA=
X-Google-Smtp-Source: ABdhPJyxtLxPJwaDIJdYf1dXdfMD3Ave7Jh301/ywgWI05rs08s2y/w1eYB7NAj/LLeFMSuHN4zd9Q==
X-Received: by 2002:a17:906:c293:: with SMTP id r19mr89660ejz.63.1603228226212;
        Tue, 20 Oct 2020 14:10:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:85fe:66cb:a92b:c664])
        by smtp.gmail.com with ESMTPSA id d12sm4012848ejt.105.2020.10.20.14.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:10:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/22] let switch_pseudo() return REPEAT_CSE
Date:   Tue, 20 Oct 2020 23:10:01 +0200
Message-Id: <20201020211021.82394-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
References: <20201020211021.82394-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

It make some uses easier and more compact.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 15452a585598..edef3a7e5c1e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1202,7 +1202,7 @@ static int simplify_binop(struct instruction *insn)
 	return 0;
 }
 
-static void switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instruction *insn2, pseudo_t *pp2)
+static int switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instruction *insn2, pseudo_t *pp2)
 {
 	pseudo_t p1 = *pp1, p2 = *pp2;
 
@@ -1210,6 +1210,7 @@ static void switch_pseudo(struct instruction *insn1, pseudo_t *pp1, struct instr
 	use_pseudo(insn2, p1, pp2);
 	remove_usage(p1, pp1);
 	remove_usage(p2, pp2);
+	return REPEAT_CSE;
 }
 
 static int canonical_order(pseudo_t p1, pseudo_t p2)
-- 
2.28.0

