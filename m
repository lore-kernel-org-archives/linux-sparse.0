Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9973C64E8A
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9372720795
	for <linux-sparse@archiver.kernel.org>; Fri, 27 Nov 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UARenfpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgK0QwH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 27 Nov 2020 11:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbgK0QwG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610B2C0613D1
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:06 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d3so2562988wmb.4
        for <linux-sparse@vger.kernel.org>; Fri, 27 Nov 2020 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qY3zM7AEcXD4DaouYS0uVroIotDp/b3XoVejh7F4UeI=;
        b=UARenfpJiZ7T3se/AgX6Vvrx7XpC/Ti3kyzfgKtGh4L++qNWAeSiEFWsizQsjcz8fu
         XaHZA2vuEMswy6gEUxuimsTRtmXxcg1OfYtnWUbwWCQhgQTIHWY5nP4lx/yVlSllKPly
         pNsc+W21Jwcv5EFYRAuQjXtAuN4fBYTLv0uv4ulgSRQkhl4uZjAAAWxMBwfx4fwJIwIn
         TEDcvSVsR5/iqHbFaLZQl5MRmgSzMB4ppzkEPeNBEuNiu/dTf+efoVy06fvYtKF1/8je
         p95AhS5BhhTC02uyf6K7qXJBgPuSdZtJzJ6jCZxMb19MPUVtpiknBfwAEOFSjNswCRT6
         Jriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qY3zM7AEcXD4DaouYS0uVroIotDp/b3XoVejh7F4UeI=;
        b=aQzPWP0w9UEdejNMAzuFGLALFoubnHlBjr+LRuQLCLo/xgbmEAaOBlJfAUwCY07ysB
         ajIpBZmB16q5zDj10Vq2W7coUJOjvqLl2IXXyR18uOXMgRnf0A1O614DfodAXPg9Gcuk
         +WuA/pwL3uTYnn9NjqNSf8p/3kZu/fiZCIZ3dL3m2xoxqXOBOPn2eNAgOG4YzeYvi8TU
         RvbXz2/8rWKWirRvmuf8NlRUhE16FTBxvy0TkHbnLcwUiJeWRiH/6MLcs0E9tBi77ZdW
         lVT+JMDzkc1L4pcWIqRwdpIQ4LBX9O+/xThEVPMv5jbpQGilHdPDcjmLnH/+UVHsNwdg
         posQ==
X-Gm-Message-State: AOAM532PQegg1K7FrrUCRlWIDplWIoGJoe7hAGKOP2i3jlhKVuxTmCJW
        jqgao0o2MJkQBO5b36cexLZvPgldd50=
X-Google-Smtp-Source: ABdhPJzhEDeMOfU3vmdk8xuaXZwU3XJCytOh4Mh5/XiDKYd2szO58OmQyIrjvMOACSOc+Yrt+LryEw==
X-Received: by 2002:a1c:e042:: with SMTP id x63mr10278117wmg.68.1606495924794;
        Fri, 27 Nov 2020 08:52:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:e9bd:38ae:745f:40ea])
        by smtp.gmail.com with ESMTPSA id y2sm15895539wrn.31.2020.11.27.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:52:04 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] refactor simplify_add() to avoid code duplication (preparation)
Date:   Fri, 27 Nov 2020 17:49:47 +0100
Message-Id: <20201127164950.41517-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
References: <20201127164950.41517-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Do some refactoring in simplify_add() to prepare the next patch
which will avoid some code duplication there.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/simplify.c b/simplify.c
index 046bf02c6d36..82ff1242bb0e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1628,9 +1628,7 @@ static int simplify_add(struct instruction *insn)
 
 	switch (DEF_OPCODE(def, src1)) {
 	case OP_NEG:				// (-x + y) --> (y - x)
-		switch_pseudo(insn, &insn->src1, insn, &insn->src2);
-		insn->opcode = OP_SUB;
-		return replace_pseudo(insn, &insn->src2, def->src);
+		return replace_binop(insn, OP_SUB, &insn->src1, src2, &insn->src2, def->src);
 
 	case OP_SUB:
 		if (def->src2 == src2)		// (x - y) + y --> x
@@ -1640,8 +1638,7 @@ static int simplify_add(struct instruction *insn)
 
 	switch (DEF_OPCODE(def, src2)) {
 	case OP_NEG:				// (x + -y) --> (x - y)
-		insn->opcode = OP_SUB;
-		return replace_pseudo(insn, &insn->src2, def->src);
+		return replace_binop(insn, OP_SUB, &insn->src1, src1, &insn->src2, def->src);
 	case OP_SUB:
 		if (src1 == def->src2)		// x + (y - x) --> y
 			return replace_with_pseudo(insn, def->src1);
-- 
2.29.2

