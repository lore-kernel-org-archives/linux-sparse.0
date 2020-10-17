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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6417C433E7
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A1F20878
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy+c2Rwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439818AbgJQW4l (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439817AbgJQW4l (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:41 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0237CC061755
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id v19so6445005edx.9
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bme2c4zWU+1p4vw3BAkOHr93X6SQcXKxu5llH7gC5Yg=;
        b=jy+c2RwcANH7OmDSwtKzwDZmnpauzbQm0HvBhO2XWYjR5x2TOEd8QLru4jK7m04CQz
         L2iNLD9wpCaX76rddnhHtQKRfD16e5JhMeZJO+N4n50CQc2gHf7eUii83YHlWjeiBmXH
         aDIJDn/SuPDKO4qlw1s3f27q0yu8iO9x1ivL028/Yee6ac2fEe/hiTuk9OXiJviBKdvu
         yTClZfytVlYVCeXizs+qVSgRraalClw2gcbVWJtgu0VrLu8+ymHbLAMej8xUFtwI+5bU
         8/QxZyETn5+0oic4DGos5WiLGNt5kpjWSOsJUO4qqwDIs7y6OAr0MU7RFrXnDZwdNtQJ
         kjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bme2c4zWU+1p4vw3BAkOHr93X6SQcXKxu5llH7gC5Yg=;
        b=fSIASpciVuyG1r2RYTZ5VEXpPcjyUQz4128ZH9nO36vm8/1lauCmR9URj9ErS5zud4
         4pgmrBqmJxIzkrStaH0j8cJgI5TZYrxw20mxT61LaZec4+Zo/TJVabxQisS4ygp7B4h7
         c+uejfrRV8Sr8f040WzPvpsv8y9ZbWttx3p+gohDaKzZ9vh0pyZlavA4ETby68hPt+y0
         imVTpaQN6PK+u8OXV4ZUXHTCzlL0jfC1qHAwjwwgdB+GJ8JObnjYTmLEel3/zHCZVqN0
         Z0HYaf+h0eP58IlnZIWKHb5GpxeTLs1F3Pdk33R5DV0hN7PbEMW7jC4Ca8k/fVtgYNoJ
         tDHw==
X-Gm-Message-State: AOAM532dlZqYyFR77hCh8k8zSm9zqO/hULMVWQkopthJV27+m+NFnQMP
        g9yhXXUmGhjKaKy7WbfCybEqHrZ2r4Q=
X-Google-Smtp-Source: ABdhPJx+xUp8MHVeOcsEItlgTRXwsQQLc3yuZAEQ+/A5WGfD8PYhNpBb1dgyMrXOireGPEcbOxpLkQ==
X-Received: by 2002:aa7:c451:: with SMTP id n17mr10731883edr.266.1602975399177;
        Sat, 17 Oct 2020 15:56:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/12] builtin: add generic .args method
Date:   Sun, 18 Oct 2020 00:56:22 +0200
Message-Id: <20201017225633.53274-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The arity of builtin functions can be retrieved from their prototype.
So, create a generic .args method, doing the evaluation of all
arguments present in the prototype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin.c b/builtin.c
index 26b612dc401b..0d4cb12cca22 100644
--- a/builtin.c
+++ b/builtin.c
@@ -83,6 +83,13 @@ error:
 	return 0;
 }
 
+static int args_prototype(struct expression *expr)
+{
+	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
+	int n = symbol_list_size(fntype->arguments);
+	return eval_args(expr, n);
+}
+
 static int args_triadic(struct expression *expr)
 {
 	return eval_args(expr, 3);
-- 
2.28.0

