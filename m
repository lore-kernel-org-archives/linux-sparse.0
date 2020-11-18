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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27FC64E75
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D95246B2
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u79TZIQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKRVL5 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKRVL5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 16:11:57 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6645C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:56 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y4so3545637edy.5
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3IZ+i/95LaVNeXZRa1HYtgvIV93YcdAD2zl2Q6dAA4=;
        b=u79TZIQKdUo3Efn30JM2c3HmhvEzeQjNs/fzoVdbO7DKTqOJLhYaOM3+D1ky91/oR9
         hswhjmtnFNLwZT2pn0CpE5c7dI8K7dv8w54r2DKSjOXLGFVKz9LYLDCdoGsqyiQDroWk
         S9jAI5IeVGRXs4xzBDrhN3a35yy1RYSYfLv7bl29+QoudUuf4umdZzND9GH/osNXNYYD
         6+wNST/DX5Tnjesw2RFAomiaru6WKCmZsHQRMA/VL5wmJsBV3vgXLMjVrgfcuASZYIFQ
         /R70KQAOnu5OFdW6p2vBedfFrSdGu9ahBJdyPaO3nf/K23ogM99kItU2Kfdnr6TxeRch
         Jjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3IZ+i/95LaVNeXZRa1HYtgvIV93YcdAD2zl2Q6dAA4=;
        b=L76nuQjAPmMLRWOtSE6qP59MaoXxBNS9konXeRFigpcKwryitAeRCIAoHAffSBc/VW
         2dQWdUTkmnZZEQ75+mhDsyubAIVu2nuZxR8DPwnjGWfzCBuafnWKezfN/A6mGT20SBjK
         Fw98Y5DKrRZlZv23zDkSYxf6BjxXCk3h2QJJiILuTIfVGWNjna6tQyShn+um2IBJHftR
         fGUVeVjklUP7d7jJ4mJiugZiOyEWqhqM6Ywoo6YYI6n30+Rg46Dflf765lXDR31nKcy2
         u0WhB/oS6bjUn52MPVLHY/oh0e+aYKLIzOkUbDZeK7bhpUJ/0a89nC46wsWElu7u0Z9r
         OonQ==
X-Gm-Message-State: AOAM531kgcZsSLLZPH4WyUAcTjt3RRhS3HuoVfCmdD37YTj6AJetYkdX
        EoaZ57VjW7ESL945CVv5w45ZrqavM4w=
X-Google-Smtp-Source: ABdhPJxoBDs4gLjPst6mUSygFFAnB/YeYEXsPrh1QtZfLy4vKtZ96tXQ22/Af0TqFg30Xo84cC2aew==
X-Received: by 2002:aa7:d8c4:: with SMTP id k4mr27327864eds.248.1605733915364;
        Wed, 18 Nov 2020 13:11:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id rp13sm13510712ejb.79.2020.11.18.13.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:11:54 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] unqual: statement expressions should drop qualifiers
Date:   Wed, 18 Nov 2020 22:11:46 +0100
Message-Id: <20201118211147.10680-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
References: <20201118211147.10680-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Statement expressions should be subjected to lvalue-conversion
and thus should drop qualifiers.

Fix this by calling unqualify_type() after array-to-pointer
conversion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                         | 2 +-
 validation/eval/unqual-stmt-expr.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b6e8477185f4..48ce61f0302d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3950,7 +3950,7 @@ struct symbol *evaluate_statement(struct statement *stmt)
 			return NULL;
 		if (stmt->expression->ctype == &null_ctype)
 			stmt->expression = cast_to(stmt->expression, &ptr_ctype);
-		return degenerate(stmt->expression);
+		return unqualify_type(degenerate(stmt->expression));
 
 	case STMT_COMPOUND: {
 		struct statement *s;
diff --git a/validation/eval/unqual-stmt-expr.c b/validation/eval/unqual-stmt-expr.c
index bac6cb6b197f..280c2fe8e36e 100644
--- a/validation/eval/unqual-stmt-expr.c
+++ b/validation/eval/unqual-stmt-expr.c
@@ -9,5 +9,4 @@ int *foo(volatile int x)
 
 /*
  * check-name: unqual-stmt-expr
- * check-known-to-fail
  */
-- 
2.29.2

