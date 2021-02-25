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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0D8C433E9
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB07A64F2B
	for <linux-sparse@archiver.kernel.org>; Thu, 25 Feb 2021 23:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBYXkA (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBYXj5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 25 Feb 2021 18:39:57 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F45C061788
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id lr13so11699114ejb.8
        for <linux-sparse@vger.kernel.org>; Thu, 25 Feb 2021 15:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dWIQX6FNkhoM9Ek8W8cd7BFifYtTDRXjX+tDcjnbAPk=;
        b=YakYo6QeUXUTKMiNpwupWMrODna/TCBtodmDg2HwCKoNlTn+fdCyIVAhZoPc3dKxvg
         XoT1BY/AmAaPNuvMT/HWTcFKGtkN23l9TKv7QVkszKCUQxMXkgMb6bqr55AFgJLrBte2
         2OdIS9hOpAJYBpLCsgSf0XsVuyBe8o2DnssJvynnyPnsZdU92RkCHSaMZ/yE5Iugy2pR
         NHjGPS3XsCoJVkQacPJCvkU50jLTVwuvoIGc4HhIRLaZGbcSA7TkAmqqPx4HDSih3Za1
         dKtTsPYyKptKffJa41tYGNPmhnS1oRw6B6TuDpBpxNdz7TWmldZ+Lo2CLY/150QvPPwH
         l+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWIQX6FNkhoM9Ek8W8cd7BFifYtTDRXjX+tDcjnbAPk=;
        b=kQGZEbYiMjd+hsMsmD98CGWie9ZaJyT9w1Z9AOdiXWJze5A+7EUddHXZYbdAVKE7Ny
         b81ybDY+tmpigx74hnZSPE0DR4E/1nO7DmklfCS8YKKOO4V1fsWQoormHzUyHd6f+BH5
         pPUpQ9Ou/KxgOp2/lyCvVtvIID58wJDGuWjsqD/Y+JYBKYdaeSCheIQ9kKhBD9TPD3yG
         WWgnkSbVYvb8xm7EVKLHwX7QipGClDfpEPEMP9RlYgSkkgBhdJB0KGiMGHRTdputUGc7
         Hx9wocvE5hrASOLNGNfAptofSjPQCy9XMNhSAjnN5xLVPz23psHw3XXgy+p+YmWVqUnR
         jnAw==
X-Gm-Message-State: AOAM531q6C0iqssHRtLT3F6ipfapZGKrpLR4J3el2uo7GEq4WecRqYsW
        NfRHXCSr9mKxUArUEhL7g/ZJq8yCSLc=
X-Google-Smtp-Source: ABdhPJzoKv1BStakCubliQttoyTE8q9wbBAuBvEju4XQWPerUVbi9FZ+3AO7NdzVei7T11HFzyIcoQ==
X-Received: by 2002:a17:906:e0cb:: with SMTP id gl11mr83521ejb.87.1614296355994;
        Thu, 25 Feb 2021 15:39:15 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:2cfa:d768:30f4:f221])
        by smtp.gmail.com with ESMTPSA id q27sm3906167ejc.74.2021.02.25.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 15:39:15 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/4] slice: display the source's size, like for unops
Date:   Fri, 26 Feb 2021 00:39:08 +0100
Message-Id: <20210225233908.97275-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When displaying an OP_SLICE, the width is shown but the size
of the source pseudo is useful to. So display the it, like
done for unops.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 7ab69d3ac968..b06c062599ee 100644
--- a/linearize.c
+++ b/linearize.c
@@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
 		break;
 
 	case OP_SLICE:
-		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->src), insn->from);
+		buf += sprintf(buf, "%s <- (%d) %s, %d", show_pseudo(insn->target), type_size(insn->orig_type), show_pseudo(insn->src), insn->from);
 		break;
 
 	case OP_NOT: case OP_NEG:
-- 
2.30.0

