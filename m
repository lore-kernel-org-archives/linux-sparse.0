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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C10CC4332D
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6819C65111
	for <linux-sparse@archiver.kernel.org>; Tue,  9 Mar 2021 23:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhCIXmr (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 9 Mar 2021 18:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhCIXml (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 9 Mar 2021 18:42:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0BC06174A
        for <linux-sparse@vger.kernel.org>; Tue,  9 Mar 2021 15:42:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m9so24052786edd.5
        for <linux-sparse@vger.kernel.org>; Tue, 09 Mar 2021 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reRUHmuQaArHa3HhSjsmi+MCjA7ucxAIN8NpZBPutWo=;
        b=Xgc4BIweitELayiPx00eMdN0WVL1n/BV9yB5RQcOWX27NQbrN16zBRe+A+EQ1WI0bJ
         WTXiwalYHV5zehNzwbx1jSU01VZrcYnqtyu02Qef8osWmcCGyWHgktAigkdu3f6him11
         pgz5MwQkIeU0a0gexlqvs9vrAKVns0pUnilbaa9WqATMx6YI6CXsdCWh5dOjhSdd+0bc
         p6Qg3eI58BYUyUEdDC80VCiCDRRuWnyBIlO4+Gp04nhJ7nBICM5BC9wmJHIgpw1cXwxW
         b6u19xtmqGsNNAjgK4/sm25oe+1n5fqYII2Rri5oY+Z2fvPlhKG550M7VhcaSMxp5q0V
         gHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reRUHmuQaArHa3HhSjsmi+MCjA7ucxAIN8NpZBPutWo=;
        b=sOFSXQ9KjtpOFInZ4XOjDfjk9tq0tO1xPOeNdbCmU+fBF/G9VLmhblVFvfnRTWDVz+
         JynbOFYMnb0Jp9DqouGMOA8BnL4lALPZu4E8xz6ZtS5fYwM7cy0R+iFpbhvFh1t1NyS/
         e3cZekySNU5W0V3MUzXOeLLcZJsNPWMhQZ3nOkwmg1pYxQ/xOagMqox44AMDKRwOfP2T
         +vAbS+a4uYwIKM9L0WXHUmhAiqbUlPrKBJBPy8R4Y5SyOKLMK2LRujF2iMx8+8LHkSEN
         boVQmWnWf22X0PucC//sjm0ZmK5tQOB+7ZlR5e8bxZncd2tvnjFzRAfQoXxwTeGX2Z7e
         Pcow==
X-Gm-Message-State: AOAM532PLjm7lw/Fr+1ZvwB2FJkdnXmcg9gQ/8wPcaGVI32mpTaqYoY3
        6zeUdnkcq1Dm/kwmqR+scxIPy5BuYzo=
X-Google-Smtp-Source: ABdhPJz9QVKRek6p0yxZ/mH+q1q/4jlABvcRtTtBDSdPNjqAOGXV8RO27ad0MZaIsr0bG8ZmFFLg3g==
X-Received: by 2002:a50:e14d:: with SMTP id i13mr173487edl.106.1615333359864;
        Tue, 09 Mar 2021 15:42:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:1dad:50b9:7959:c788])
        by smtp.gmail.com with ESMTPSA id cw14sm10147984edb.8.2021.03.09.15.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 15:42:39 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] ssa: avoid SSA conversion of packed bitfields
Date:   Wed, 10 Mar 2021 00:42:31 +0100
Message-Id: <20210309234232.50889-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
References: <20210309234232.50889-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Packed bitfields are incompatible with the SSA conversion
which works on the assumption that memory operations are done
on the whole symbol.

So, directly exclude packed bitfields from the SSA conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ssa.c                                | 3 +++
 validation/mem2reg/packed-bitfield.c | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/ssa.c b/ssa.c
index 3f4fa1a831df..26d46baaa16c 100644
--- a/ssa.c
+++ b/ssa.c
@@ -32,6 +32,9 @@ static inline bool is_promotable(struct symbol *type)
 	case SYM_STRUCT:
 		// we allow a single scalar field
 		// but a run of bitfields count for 1
+		// (and packed bifields are excluded).
+		if (type->packed)
+			return 0;
 		nbr = 0;
 		bf_seen = 0;
 		FOR_EACH_PTR(type->symbol_list, member) {
diff --git a/validation/mem2reg/packed-bitfield.c b/validation/mem2reg/packed-bitfield.c
index 4eaf0befeaf5..f3ee259a62b8 100644
--- a/validation/mem2reg/packed-bitfield.c
+++ b/validation/mem2reg/packed-bitfield.c
@@ -12,7 +12,6 @@ static void foo(struct s s)
 /*
  * check-name: packed-bitfield
  * check-command: test-linearize -fmem2reg $file
- * check-known-to-fail
  *
  * check-output-contains: store.32
  * check-output-contains: load.16
-- 
2.30.0

