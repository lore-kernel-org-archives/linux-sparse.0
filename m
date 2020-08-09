Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114DEC433E1
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E556D206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq1Lxo/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHIQw5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIQwx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97012C061351
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:44 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so7054901ejb.11
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v0yEyYaJiwM/8R0MJ0SDvJwBNEKNiIGLxNx+W5A9kuY=;
        b=oq1Lxo/boIUm6jSqL5rLY9URNGYAi4pL47CnBRlK0EvDdxZjUaS5XFVY2cv4MDesV9
         WnkLINSNxY1IKiRf5wp1sZRjSKJrsGLQT/+7kpEH0m7eW0rAYLjS6Piy4RFiu44I2dyA
         Z2Rzn85JsI5vkK/mLj9IYpC837T5UU6lj00XSW1dA+gQ3GeytrvZ8JAbJE3LhaTKE5VZ
         REZq9yeL2TtxwhlsYaiV2s/n7VnXBnJ4dWvj3FnZINRIHkSWPL+Eqk4AEeyve0pISoZR
         qLIjKhebskfnJ9G1jJO5F2pqcCGSZkOauk0uF6jPctxKX7/CihO6nt5eDvMochljEodg
         G8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v0yEyYaJiwM/8R0MJ0SDvJwBNEKNiIGLxNx+W5A9kuY=;
        b=tfLdLWdRT48d9X5pUHBRkGVd4Us24fulEx0PZs7EXgTc+sWdhDf6RP57POr4eq0y5o
         tZhp+fEf9jl+y3tUa5+7bz28al6ZL7I3EIVrVDnbIVKwXwv/iGsHXYyOE3XkMREEGD+s
         AoRlkPq8E6OjNM7vXoD5gNN+8IOzF4BexJ3STaNq+M2NIT0BUZlHYZ3YuG/50j43wYCm
         sEwT4z3hato651mh87Uo/4UIkQkU3z6UPtn52lB/V5KwsJZHMw/9dqU5FQiTpmNM6sJu
         a6xLVeBEWJKlUeVY31Q2t3FUKgrMKKHxpj859WZj0mkIAGjOaBsw5uENa7lDjQBtPnlH
         8/7g==
X-Gm-Message-State: AOAM532U2IF4yGVYNLZtXaRDkEigtuqQ6keFzNTvKZnLzsYbYFM2LGGF
        TkOu/bpXTejhYhz7OFc2CwoqgUPG
X-Google-Smtp-Source: ABdhPJzzPpLORdDXLLWel+1mMKRWxk9KgxVRlRoxANIMuNcySCtjv3AchJ3o7xI+zJSlR/JJc5Yi4g==
X-Received: by 2002:a17:906:7104:: with SMTP id x4mr19147183ejj.417.1596991963124;
        Sun, 09 Aug 2020 09:52:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:42 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] parse: simplify set_storage_class()
Date:   Sun,  9 Aug 2020 18:52:29 +0200
Message-Id: <20200809165229.36677-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The second test is now made as the else part of the first test,
saving a 'return' that is otherwise not needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index 92ca1b66e140..f3f33790eac0 100644
--- a/parse.c
+++ b/parse.c
@@ -1385,12 +1385,9 @@ static struct token *storage_specifier(struct token *next, struct symbol *sym, s
 	const char *storage = modifier_name(class);
 
 	/* __thread can be used alone, or with extern or static */
-	if (is_tls && (class & ~(MOD_STATIC|MOD_EXTERN))) {
+	if (is_tls && (class & ~(MOD_STATIC|MOD_EXTERN)))
 		sparse_error(next->pos, "__thread cannot be used with '%s'", storage);
-		return next;
-	}
-
-	if (!ctx->storage_class)
+	else if (!ctx->storage_class)
 		ctx->storage_class = class;
 	else if (ctx->storage_class == class)
 		sparse_error(next->pos, "duplicate %s", storage);
-- 
2.28.0

