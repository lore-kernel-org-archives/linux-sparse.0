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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7829C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5F5207B2
	for <linux-sparse@archiver.kernel.org>; Sun, 27 Dec 2020 09:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgL0J2p (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 27 Dec 2020 04:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgL0J2p (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 27 Dec 2020 04:28:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E2C061795
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:04 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n16so5642809wmc.0
        for <linux-sparse@vger.kernel.org>; Sun, 27 Dec 2020 01:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tYiiSUsa92fCCZRs8VNLpkaZ9xFDp3m5JmvUmVDiZY=;
        b=ZEBWOAJXlsIBTYDqDnUVX9gX256lk4EyjE0aQ3DGO4N+dHdD6nuOstQKDezXqA7UYt
         K/QExcovssGP1eUKQVhfY9iD7GBAqvyxd/svsuai4gJQPx4x26HrQvZ0x/zR+qxQBgOa
         Ty9ex4rKHxw9cTX01/0Qi7945KHZ+5ePfgkIMsstVGNYRT5/uPz8oB3RutHnOAOzbSOT
         XhaJ61D/V2taiGrEt7Fc/SxPqhuJnjzIWY66P4sUCwNDigZI95avBmZ/lyEPcI2G7pgV
         GqWTqLjsLLhhdblgKFuvgEJVrTLJWbD+SvmyrWAplTod37lQnGmBTs+klRRNJVTZnxuO
         cdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tYiiSUsa92fCCZRs8VNLpkaZ9xFDp3m5JmvUmVDiZY=;
        b=eSUM4n4NwrASFfhkz/+dvI34l9cqewPo0qDkUb47hjudj9VuajKdsZGRbgTztnI1SI
         cwTH+H6Me0bGdeoTRK38QIqc1/YbVV/sfe3nByjvACDWcNwcN6U1qmIbMfM/7NUVWMdI
         USElJ/UvDIMVhMAm3Iw4QXY4ieUD0Urh9coGZ6D+5iAunA3zj0RKvmLX9KStDzFbn8cY
         2cJtirCFmQ8+frGWwlVkxZL9AXee9JMHlKuui76oOxwH9WPX2XHbTtfVaJFkSQM2bJcZ
         rYU7IdIPb+68NMi9/LcgcayVMcfBO21ebpIryLcjnSJFe3HoEX3CLRYejMIsqWNbq3xQ
         wHVA==
X-Gm-Message-State: AOAM531QZrVH4utIUETg01DL2c1wVQ3+bv3z8x31D2w9IWO2cNTAK7SQ
        O+3yjmA2XYCuyz6Xqsyp+x8pvXRrfik=
X-Google-Smtp-Source: ABdhPJyyQGiy86w4Ml7Jt7ldlpqUQxTZTO2MmUGgcHWoWKjA8xPiIy9pUCRbfc6wVWE/AyR+9nvnZQ==
X-Received: by 2002:a7b:c24d:: with SMTP id b13mr15667079wmj.151.1609061283356;
        Sun, 27 Dec 2020 01:28:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c99c:3949:2fe7:7420])
        by smtp.gmail.com with ESMTPSA id n8sm49904007wrs.34.2020.12.27.01.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 01:28:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add helper has_definition()
Date:   Sun, 27 Dec 2020 10:27:58 +0100
Message-Id: <20201227092759.30999-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Add he helper has_definition() to check if the pseudo belong to one
of the pseudo types having a definition: PSEUDO_REG & PSEUDO_PHI.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linearize.h b/linearize.h
index 2c548d43526f..c5bdd04257a1 100644
--- a/linearize.h
+++ b/linearize.h
@@ -249,6 +249,11 @@ static inline int has_use_list(pseudo_t p)
 	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_UNDEF && p->type != PSEUDO_VAL);
 }
 
+static inline bool has_definition(pseudo_t p)
+{
+	return p->type == PSEUDO_REG || p->type == PSEUDO_PHI;
+}
+
 static inline int pseudo_user_list_size(struct pseudo_user_list *list)
 {
 	return ptr_list_size((struct ptr_list *)list);
-- 
2.29.2

