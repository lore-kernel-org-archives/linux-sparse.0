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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D7C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84E8206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynxh7tXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgHIUxo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgHIUxo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:44 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4DC061786
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id g19so7378708ejc.9
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mksNiVj061RJ0GABvVtDeUg0gGhklQ9Ty2JoxHFRysk=;
        b=Ynxh7tXr6E3Dw1ldo+BrV8unu/+G1g7Iz6NSMa3a5xnXHz71tsbcgexLMWdnvs+FrQ
         GkZIiyTRczDebJa+ZklJqSxnGyI7jOqqNzhQJq/glk860hAawhJN0+lq7a+ngjuKPPQw
         +jmgH7MP4mcBkGVv7l0l7MQ+rsGf7NvfXrH2xDWslrcKwJFwdRJa6NHU7vJWUVsbyBUE
         ZhmHwEQwzmtZqskz9zUUmh7ar4UyEaYifrfghBtlY2Bzd8FkOX6Fk4OaPK/htNuizMmm
         vhPLduMSz2lAr6svA8AWP4UUkolfLrj6e5DcOCiPScTrUV89zHfaUamNPnNPcQOA/xdA
         BKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mksNiVj061RJ0GABvVtDeUg0gGhklQ9Ty2JoxHFRysk=;
        b=JdqROueWNA5PwxSr7h/c60wd36ZSJ0EcAv4ZkZU5fn9SOI5l0GlCL3jqmHZO73Txfi
         iEOSBuSOlSLYBMtjYI7lmPoq/nA+gqhw8TatjNlCQRDBWNMQjMyk3uIrkjII+me2ql4V
         +6tpLFtf4G1RrZnhaQ8gZFC/Lb9Ba4r/ZyAXvodVRwQ7bF3Qg4MA7DOSwUTZKHnLiThj
         cnDiQbuclIfor5r8iEZoIw8IByhHt0Y8a26IWdKRXb5nhhsU25x5SGnSQVJabVKA46Si
         G1bBjacrIrxuLY7yiBZsCtzeuW1WAxQ1+WMueb+jwDCh29mMTXWaomAek1VdgVfc1M+w
         WmWw==
X-Gm-Message-State: AOAM530VhQdO8XZnt/vg9S7SzQfE1yjytfe7J92JWHj1bncVKRFuHxCk
        pbvc/YUVJzQ1SfmET/OxsCfkuWy+
X-Google-Smtp-Source: ABdhPJxfL3+pNeJWjVk0KDL0fSIMlCaiwKeXIwSQ3hE+rtdQTYdnG42VeEn2z96n2PRfKm3L/uLz2Q==
X-Received: by 2002:a17:906:d9db:: with SMTP id qk27mr18585868ejb.37.1597006422576;
        Sun, 09 Aug 2020 13:53:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/10] keyword type is a bitmask and must be tested so
Date:   Sun,  9 Aug 2020 22:53:29 +0200
Message-Id: <20200809205329.42811-11-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The keyword's type is a bitmask because depending on the context
the same keyword can be of different type (for example 'const'
as qualifier and the attribute 'const' , a variant of 'pure').

Thus, it's an error to test this type for equality, instead it's
a specific (set of) bit(s) that must be tested.

So, change a test ' x == KW_...' into 'x & KW_...'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index d378f1255fee..e1a5cce4e46b 100644
--- a/parse.c
+++ b/parse.c
@@ -1287,7 +1287,7 @@ static struct token *attribute_mode(struct token *token, struct symbol *attr, st
 	token = expect(token, '(', "after mode attribute");
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *mode = lookup_keyword(token->ident, NS_KEYWORD);
-		if (mode && mode->op->type == KW_MODE)
+		if (mode && mode->op->type & KW_MODE)
 			ctx->mode = mode->op;
 		else
 			sparse_error(token->pos, "unknown mode attribute %s", show_ident(token->ident));
-- 
2.28.0

