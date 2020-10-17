Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7E0C43457
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9997520878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGX+X4rG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439824AbgJQW4r (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439822AbgJQW4r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:47 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A5C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:46 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so8703934ejb.6
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yzbwhgM1b2KZznlK+JCIHyQBOKMQ8o5rvF04A7Pc4Js=;
        b=sGX+X4rGY6Q3QJAVKNZoOI+L3vRAuwFprti8qJpAar1guA9fnkPmy3HSrCLCaagmmi
         5jx7BNv+RRqWCwqiP7nCBfO6aHQ9CfnyD2jMY4xH7Orw/Awua1IcGaSbbXLpcyfDp4d7
         405oFhodJOLBC2t4JlSaPoZ7nrC9dE6hmteIYWP7i1O83+dFSeMIAJjp5uTkEEsGqgn6
         /JlHbDGcplyyEqlh2FzWMsD+fCDoBtAoBvoqKCynC3Mw/Ol4+S9gnTD6YgrmPpZx+5vK
         hQtcZLP4BAHkyTUxqycRUQWtV49upQEcRfpp7RPIM3u4oOd0EcveBAmfLyYaTR76Ow92
         LZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yzbwhgM1b2KZznlK+JCIHyQBOKMQ8o5rvF04A7Pc4Js=;
        b=CMBy16r1Ml4b0mKE8NsxFHt9rmvugPhEqKZSAGRMkpsyMvO6nNpTQ9cl8aQSSR5S86
         oHJJ4p7w/Br4n7Cru1ShvoR2bVCww7blVkz1RH9di4iN7x3pz/djM3dWpXCasqSA3DZg
         P4Lwt/NCrVPWMUm/wTdTJDnc4aEn3B7aJdjuxnOPLgFQmQecQtb4GV9UndvZcRPR0jOW
         yLQ55/f8dmPBspzXaZBuiP2A5y5FRdLYDELgWIlznhVGbCe5De4hKbjGB+ABn0s6dS6t
         KyC/IcV2CET8ZPsXc5Cm+/Yi5qILcSjD5aO/KlzHJQ1GCYs11yxUw6BVEL2EbDjh97vs
         2MYA==
X-Gm-Message-State: AOAM532Tpt8HsxT+WLMXRWh2ykBqHPFl16pynSOxaLETKj9a6KKMenZf
        v9sON3HMwMZ6R2pyplU3x4G56ZtA0Og=
X-Google-Smtp-Source: ABdhPJwojYyBYRTmwXrfD+OExshLsKvunyIIzsCYwZA+Fm2sjmeABmsSKx3kucKqrZrMnpfjxa+lXg==
X-Received: by 2002:a17:906:9702:: with SMTP id k2mr10413779ejx.494.1602975404547;
        Sat, 17 Oct 2020 15:56:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/12] builtin: add predefines for __ATOMIC_RELAXED & friends
Date:   Sun, 18 Oct 2020 00:56:28 +0200
Message-Id: <20201017225633.53274-8-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The __atomic_*() builtins take an int argument to specify the
desired memory ordering. The different admissible values are
predefined by the compiler, so do that too for Sparse.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 predefine.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/predefine.c b/predefine.c
index f898cdfa39b8..98e38a04579d 100644
--- a/predefine.c
+++ b/predefine.c
@@ -179,6 +179,13 @@ void predefined_macros(void)
 	if (arch_target->has_int128)
 		predefined_sizeof("INT128", "", 128);
 
+	predefine("__ATOMIC_RELAXED", 0, "0");
+	predefine("__ATOMIC_CONSUME", 0, "1");
+	predefine("__ATOMIC_ACQUIRE", 0, "3");
+	predefine("__ATOMIC_RELEASE", 0, "4");
+	predefine("__ATOMIC_ACQ_REL", 0, "7");
+	predefine("__ATOMIC_SEQ_CST", 0, "8");
+
 	predefine("__ORDER_LITTLE_ENDIAN__", 1, "1234");
 	predefine("__ORDER_BIG_ENDIAN__", 1, "4321");
 	predefine("__ORDER_PDP_ENDIAN__", 1, "3412");
-- 
2.28.0

