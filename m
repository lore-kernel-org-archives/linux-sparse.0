Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA1C433E0
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C138F206D9
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 21:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzuODihg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGNVn5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGNVn5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Jul 2020 17:43:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07163C061755
        for <linux-sparse@vger.kernel.org>; Tue, 14 Jul 2020 14:43:57 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so39957ejj.10
        for <linux-sparse@vger.kernel.org>; Tue, 14 Jul 2020 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZzxIMt2wFWdx5137XHFTBBx9SYUQFYeG+atOeVOoB5Y=;
        b=EzuODihgg+S9lo5ynbumNjUcfY7ztXUcMVHcfErxXR3S49MfUvSyMCwHxPhaUowf4e
         nMFPEGQRV3cvffbw/Q1yo4HIUKcfrd/xj+AjcABo6ZhMtFUD66J79yzfe8wOXthTbrQO
         aqywWWVyqplrf8JvTdm+BBzeHn27b83Hl9CKY/yVUwFYw2niu7E6Phz7RvbTR7LTheL1
         jSJkmX4s2mZeVM2jgaR7THT1OA4Xe9iPXin3+v9CiKq5Z5wh1VIKNF70kNpVWZ4life5
         Mr8DjH8H3QYBs0vzoLr1PmZB8LLD2m7ieuLji+Py0e8zfJSRLDtoAW6XyEddgpvgfWEw
         bcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZzxIMt2wFWdx5137XHFTBBx9SYUQFYeG+atOeVOoB5Y=;
        b=cPTUJYYp6mg3lBXEgP1yxeSxGhBhBi2sP6PFwwap4uxtCIOXwHokVmSQDGFXJ1yIHL
         FRubVWAg1Le3cSkcdOyie8McoBpa9TpPnsIosi1hLrsWGLtapiYsA3m6zYsqF7T1A0v6
         JzPHyj4YL2ig+B01tesYDcgxELGtHvJUYJTifdtQyWlWp+Ziu4kYvnfY3HxYkb1w7+mc
         r+5f59PHdWOPihuOJVQwjvh1j+CVjfiblgiXd0RSIGdBouMwnnVrsbWwvDrblP+THeal
         bMQjkpcfrLTy2dlKCPPp9F80xTz9dN45P4VwUr2nZvVhb018g4DWplGO5KmgpY+RGqWB
         wiwA==
X-Gm-Message-State: AOAM5327EXQs3oew74ygqjoT2aA9KreGmc3qR0JvhaPjUWdcu7nXNt9P
        1nxUwI7QgU0Bh24rJUpLpUT+wXWB
X-Google-Smtp-Source: ABdhPJy24E6YJgt+xMF2TYdl+hMdAvOUA2iAXRZXSaE0VLl1rayWnqhKPMvVgpfI+1kuWmP+pdQkmQ==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr6745723ejc.67.1594763035535;
        Tue, 14 Jul 2020 14:43:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5cd9:fc:d7bc:c84f])
        by smtp.gmail.com with ESMTPSA id s13sm31921ejd.117.2020.07.14.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:43:54 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] syntax errors in numbers are not fatal
Date:   Tue, 14 Jul 2020 23:43:51 +0200
Message-Id: <20200714214351.14516-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When parsing expressions, if an invalid number is reached, a fatal
error is issued. But this is not the kind of error for which
continuing the processing doesn't make sense, since the token
was already categorized as a number during the tokenization.

So, change the fatal error into a normal one (and set the value to 0).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/expression.c b/expression.c
index 1160cd9cc593..02bb5b159d9f 100644
--- a/expression.c
+++ b/expression.c
@@ -379,7 +379,10 @@ Float:
 	return;
 
 Enoint:
-	error_die(expr->pos, "constant %s is not a valid number", show_token(token));
+	sparse_error(expr->pos, "constant %s is not a valid number", show_token(token));
+	expr->type = EXPR_VALUE;
+	expr->value = 0;
+	expr->ctype = &int_ctype;
 }
 
 static struct token *generic_selection(struct token *token, struct expression **tree)
-- 
2.27.0

