Return-Path: <SRS0=ez6N=CO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EEAC433E2
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB9920757
	for <linux-sparse@archiver.kernel.org>; Sat,  5 Sep 2020 12:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNZ1Opfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgIEMOH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 5 Sep 2020 08:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgIEMOG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Sep 2020 08:14:06 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF0C061244
        for <linux-sparse@vger.kernel.org>; Sat,  5 Sep 2020 05:14:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so12003227eja.3
        for <linux-sparse@vger.kernel.org>; Sat, 05 Sep 2020 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufM7TOvsBmOIJKVEbKKr+BAcE1XH3xTVq/JYds7a6ek=;
        b=FNZ1Opfm8Kv4KnRq6p+ioAwDZ4nwTOejp0tBrOScx+/z/yDIEp/Bms1UrIkJwCebo9
         fIUIWViUE8WDEc4hEOuCK3k3GHWakFqJfs3xZ2te7UY4eXDjbojLSx2J9ugYXtjAyZo6
         Ji/nO89L5xpQaYQQ15Pi+cCM5YhKWe9KB/1qsxfXJtBijNitdbH7uOHAFWdndUGv3zYz
         24nh8w8ao+ypaGFc5cTWxK+49eC3WS0uOyZu9ALERFzsKWMIEsvzVFktt7VWSSJuxNfb
         pdzosusGoIx/nM5NaSSvPyfdBJyPRKZAlQCVWRdTXs6vGm8APj93BHmKQ1AY8k/2Ho93
         I5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufM7TOvsBmOIJKVEbKKr+BAcE1XH3xTVq/JYds7a6ek=;
        b=mJn6F3X0awwMzYkzJsa6sVEI/RNaghzuRoRspxZONiVFLulve3ph/Z7dHgXxY9RUjf
         +nljy0CB4eelw4MSrTLVLre15iBmwUujRivE9Zn3dJnJsy4Dp3kLNj1WHNM6za4gPxPo
         RM5CKhMPja8y/N3sitmowc2w+OYDXp49vw8f6IlbS0aXrxiRdrgoLcnFGPxtqLOw/OV1
         F3rzokriTtl6bMai1x+jLt0BxxP+abkkt5+exb2EW9u7Fh/++ppe+AzzJ0XT0/Yz8USr
         d/B7MRLMXyavL95E1+lmQj89vTRx+Emz2AoaCBklK3LXofLtdsa0WtYUsOZO6I3rSKfJ
         PEbA==
X-Gm-Message-State: AOAM533D7dwdCfgHyAvUujOD+pBS7mM6SBEwj4mgtTIYIWyQnk6YrvX8
        duynQpdy9hfM2yjq3ZyTR5CXnIa5JZg=
X-Google-Smtp-Source: ABdhPJz1IzsDBDwQwhtHHVszDCK3pmMgxIMN5vPOUaQdAfequXX+xu6jBp+KftKx/vhs3y9ODDqCbg==
X-Received: by 2002:a17:906:ecf1:: with SMTP id qt17mr9293274ejb.158.1599308043383;
        Sat, 05 Sep 2020 05:14:03 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:e1b1:2430:dffc:e425])
        by smtp.gmail.com with ESMTPSA id k14sm8577412edo.89.2020.09.05.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 05:14:02 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] add helper replace_with_value()
Date:   Sat,  5 Sep 2020 14:13:56 +0200
Message-Id: <20200905121358.83080-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
References: <20200905121358.83080-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

During simplification, it's relatively common to have to replace
an instruction with pseudo corresponding to a known value.
The pseudo can be created with value_pseudo() and the replacement
can be made via replace_with_pseudo() but the combination
of the two is a bit long.

So, create an helper doing both sat once: replace_with_value().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/simplify.c b/simplify.c
index f6b79685f439..0c75b3fadcab 100644
--- a/simplify.c
+++ b/simplify.c
@@ -465,6 +465,11 @@ static int replace_with_pseudo(struct instruction *insn, pseudo_t pseudo)
 	return REPEAT_CSE;
 }
 
+static inline int replace_with_value(struct instruction *insn, long long val)
+{
+	return replace_with_pseudo(insn, value_pseudo(val));
+}
+
 static inline int def_opcode(pseudo_t p)
 {
 	if (p->type != PSEUDO_REG)
-- 
2.28.0

