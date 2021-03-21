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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE3C433E4
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3417361944
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCURJI (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhCURIa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20449C061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u5so17502699ejn.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v+voen80HxgUrnrUvPyBBSXSDXFTN7ud5BWjQyoJVio=;
        b=ncMhhhvgt/m7M6P4xg+pOR43yU6es5d7pt6zY53wG+7mtBdNLTdCEgnhSJNxicUizq
         vD8tblEVTc17fr/XhFdU/9AkZrhly86L4l1n7YGRU9Y0u/fOxz4NZamIFf557tLHv3FX
         HwWcjZLkPlBx/0m9/iVeWajS399g2ShiNXnG/6hByKwkuC8JBGcz8NottqS0LF9O/DgH
         WhvZjUzpxqnoBWVSl0WeQ+IvTTCs9E4PgEj6LcYjmZH/6HQRMVPIoN+m3RwSiup3rz4P
         9fg3VmaLA9Mq42rGniWrWnSLBCqRobwHcSaOUnVniT7fqgB5R4UoJ/Jsm4xPvG+ghyd8
         RAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v+voen80HxgUrnrUvPyBBSXSDXFTN7ud5BWjQyoJVio=;
        b=b1PYqh/8xJ2BdKDM5c/ijcxDD/GpeUCG3EBQqFPq0XVrokNnfNtWNwbAItykhLWl2X
         kXBlg5xjF9CXNRF9TNFXo+fw2iPnTKP2fiKnOVXVhb2/sqasvifMNxd6Q4NtwBiotNx0
         mnswjvxpaHDzyMAJg7oA2miI9mJte5fErVa6+ymOFHF1zue5C8jtuOcfbz00rlOCQj+f
         7umI7UACpY7FWwIi4TsaOiLlLGdY3gyOSHlMpp+0TCwLlvAVX1dI/sjNVX22QyOLWIzY
         sUu0qy1EFYbr4DmSbWhSaTwfvzTbGqEC7JC1AuZzi/8prtoyxzXV+IqdG101qOLrLad2
         oZUw==
X-Gm-Message-State: AOAM531Wh0ItKHIZK/iy2hu7LOW96bmn5pl47Vt+qOhU79/vYkLRe5C5
        g1aDK2RDcIYPtSMCjwMFlW9hCJc+XK8=
X-Google-Smtp-Source: ABdhPJxdYnm5YiB6qt9Th2k681oMhjAP2HW8ZH5a5CiedpBhnbxKfibYEG3/3oWXkxN3T2GsESQ3nA==
X-Received: by 2002:a17:906:948d:: with SMTP id t13mr14978340ejx.402.1616346508936;
        Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] memops: do not mess up with phisource's source ident
Date:   Sun, 21 Mar 2021 18:08:20 +0100
Message-Id: <20210321170822.46854-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In rewrite_load_instruction(), when testing if all phi-sources are
the same, the candidate is given an identifier if it hasn't one already.
But doing this inside this loop is strange:
* the pseudo may, at the end, not be selected but is changed anyway
* the identifier should be given either when the phi-source is created
  or at the end of the loop if selected.

So, do not change the identifier inside the selection loop.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/memops.c b/memops.c
index 5386c5a1f416..119a39a180d5 100644
--- a/memops.c
+++ b/memops.c
@@ -29,7 +29,6 @@ static void rewrite_load_instruction(struct instruction *insn, struct pseudo_lis
 	FOR_EACH_PTR(dominators, phi) {
 		if (new != phi->def->phi_src)
 			goto complex_phi;
-		new->ident = new->ident ? : phi->ident;
 	} END_FOR_EACH_PTR(phi);
 
 	/*
-- 
2.31.0

