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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E29C43457
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F295E20878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufzHLB2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439826AbgJQW4u (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439827AbgJQW4t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:49 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5046C061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so6444571edj.8
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Ca3I1k5F9zXMoAQp+4bX8vRlxSxtpvWqBBlIPnk/7M=;
        b=ufzHLB2EyaVYJEfnQjQ5JcQr5CeHM4uvyJda6hsVXdWBZiEIPJuxrsmjCGxgWQTU86
         uU9s0htV4YJvOAF4LRA+5vUqbMdIUYrVNq6nYTTNA/PxXWpPuvsT95qjfCyj1sDfWb8X
         Nha5T26K1X2NRdoKWvf14JRBSrWbL0HGWkRnhOHXosoLXZ86T9WGibvGvVOCiiabvh3i
         SdDuA20wbRXDViZXSm+3fhGjPoXIV/oA4WgO+DiGFvl5zGbXYstXWc9NXVR52Ch/8BgQ
         xmCeE8KUi4L4KvhdGf54Ek7kOX8wApfcj78XfA119qkthvarOnO1o0uejaaeDlQbtn+C
         HGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Ca3I1k5F9zXMoAQp+4bX8vRlxSxtpvWqBBlIPnk/7M=;
        b=dYWkQUZJTIYbb7aPoEBwqvA7HyL9u4gK+wkZVl2dP8mVhvzz5B/YKObW9yZdQEvJrO
         asZ+H5ixadpEb7dUd4alWMdw05pnDArdBoz8kQr4E0ae+JNE3K7jZuNwtIPm74fctRLb
         oSFJgnGuefor900slUl4wsqtjPYxJ/BbB1W7+aakuu00ISiUURHX55w0oYpfXYED7IlI
         xQf1An/xiWxELkwPaN4YMeIBSJvX8B5P2AxyRB6LqB0pTSgouN/t3//roAdx/BPDiZRC
         1uObVMoQCPfC14d6TUjsj9iXd4XbkHYCqGhYAcS4qIEOgShwrDYBQme/IkP3x2VcVOid
         t7DQ==
X-Gm-Message-State: AOAM53296c48kcsBLy2T9cKCCzs9yY8nWOCnI2JSeLXnMHpljXoX3Z6t
        NpcnYUbsIlryQs3mhuzgWzP+tKnW6ts=
X-Google-Smtp-Source: ABdhPJwNKC1M+vsaqkSpKM2DZsR/Bo9ZoCMM/jHi1CPF9JH+h4wJbr3btmzoq9ILqRZGboKJtaszCA==
X-Received: by 2002:a05:6402:21c5:: with SMTP id bi5mr11265804edb.380.1602975403615;
        Sat, 17 Oct 2020 15:56:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:43 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/12] builtin: __sync_synchronize() too is variadic
Date:   Sun, 18 Oct 2020 00:56:27 +0200
Message-Id: <20201017225633.53274-7-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This builtin was marked as taking no argument but is in fact
variadic (like all the __sync_* builtins).

Fix this by marking it as being variadic.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index cb900599f112..4921a2429f55 100644
--- a/builtin.c
+++ b/builtin.c
@@ -641,7 +641,7 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_nand_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_or_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 	{ "__sync_sub_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
-	{ "__sync_synchronize", &void_ctype, 0 },
+	{ "__sync_synchronize", &void_ctype, 1 },
 	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
 	{ "__sync_xor_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
 
-- 
2.28.0

