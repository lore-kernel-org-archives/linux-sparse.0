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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDFC433E3
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B934C61934
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCUQS0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCUQSQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634AC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id kt15so7893562ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcxS5hCDG0lEfkrheNDZDSCZbWYpv20H6bBFF7zpaT8=;
        b=mwhAF4/FCs/W+ME0S1AjKIsCu+1qH/fC3IBOQsXPM33AuTWSA2E1gXtiVEOGhXHezm
         iSUduvZ+TyU3Ecx1AFgAo6sqC2a6ZXBhG59+fiQn105iB/PrPurh7Y0o9qiVYvQG6QhA
         TKhXamINWnvfL0Q2MeCcVvaA/WLUv5vu0TpSN3HsKXc7M+2U4S77cE1rz+54wVHpt3hs
         f9CUgdJDqSG0sQulGZD80XTC0ddPiPqL2nXh25lyyirjcHD6HXeKmbTCw+H7w8kNJ4+A
         PgesampwNybjtBaAD24Z12g+KAL5uRKAAbDj21F8erriyzUP2cF2CVgqxEIro5EthAWZ
         8oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcxS5hCDG0lEfkrheNDZDSCZbWYpv20H6bBFF7zpaT8=;
        b=naUa8Ax9pKZoGrIsSxAGzp5L23ttj+9SVhyJW5T5MgVK6BftygeZdvQoNWqDko96M5
         ibKVKRNAVx3mJ+cD9ZnGCY/RVeFpJzEIwKWIbnA9TwrQ+S3OGsmB4/uMDPZY/iCqNkL2
         O4o9iH6x5o27YnVWGPQJ490X545DTgKWdotj8DCZ3NZss/myBxPVh+PTFxh6adwwNHsa
         th2cTKYlQItqmEp61A60JIuJMWTxkVdiQnBibfXQOhBezBgHwyda+3ZG9ehjd3fMp+hc
         TkGxcWdcqROuUSGo4xiFhsERwfwagRw19DO7VRgrhqh835IFbKM/TmuzPPYhhme8KW7F
         H1eg==
X-Gm-Message-State: AOAM53347ahpEF50m7K40vkEyx8ixp91+AVpvjC39BFQau+55gCDsS32
        ElsXj/v3LCmdw8iLrQujeudg8MldInE=
X-Google-Smtp-Source: ABdhPJwTqIz0mc2RKy57mI8uNj7sS4W5O1P3pDJJJGakwSErzbNVDrl3wxcayaU/1/YxlH0lpcp4hw==
X-Received: by 2002:a17:906:3395:: with SMTP id v21mr15202169eja.322.1616343495253;
        Sun, 21 Mar 2021 09:18:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:14 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] let insert_phis() use insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:07 +0100
Message-Id: <20210321161609.45905-5-luc.vanoostenryck@gmail.com>
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
 linearize.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linearize.c b/linearize.c
index 4787689b37b8..95fb3b59b90b 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1708,10 +1708,9 @@ static void insert_phis(struct basic_block *bb, pseudo_t src, struct symbol *cty
 	struct basic_block *parent;
 
 	FOR_EACH_PTR(bb->parents, parent) {
-		struct instruction *br = delete_last_instruction(&parent->insns);
-		pseudo_t phi = alloc_phi(parent, src, ctype);
-		add_instruction(&parent->insns, br);
-		link_phi(node, phi);
+		struct instruction *phisrc = alloc_phisrc(src, ctype);
+		insert_last_instruction(parent, phisrc);
+		link_phi(node, phisrc->target);
 	} END_FOR_EACH_PTR(parent);
 }
 
-- 
2.31.0

