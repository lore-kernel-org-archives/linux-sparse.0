Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48148C433E4
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D1720792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpTiv+lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgGWXqv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGWXqt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:49 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8BC0619D3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:48 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so5772345edz.0
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uKd43jKcj6y+qhr5DgTIhXyfVXs0sZVBdBWaslvamCc=;
        b=DpTiv+lWod05hzsvAhit3hwLWDLWDTFx69KVcntQvOYt8lSl1ZNKBicu5/X6umCyQ6
         +UTddesD26QjDw2B4iytwMSg5zR95+R/BRYYR5/u2wwfe4F/hNNeIOLhBi6wGuu5IMFW
         4wpjtLFGMbeLirF3iG+cw/yX9i7udOR1SLN0b16OUve0a5vsFSO8wK/EAAFId0xSipGV
         S3Yt+f+yzG4/kd1tdrXunmg1hB1FeNRSN/T4lE0W8FZtop1L9oi37SDbj32Z6UVwNoVV
         4bA9vHU87bYqa0w1c3mC4Jid28UiPZhA1o9+AQnZ8QUKXCKOa1QdOl59kmxdib+OFCHe
         bEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKd43jKcj6y+qhr5DgTIhXyfVXs0sZVBdBWaslvamCc=;
        b=ZzIhUYAgp21tdHkAGzxxD6i24t3F97d89XfxqhYZr+9ipHu6R+jDJWCwYPHjZcDOMm
         Le+ovjloQTmr2bHMBOkDPJnrdvfKJ0gE3b54jjhqfX4G8xN2aM2E+ACSGRYGnN+HSBVY
         Ip0Lzk1/OEJfldfacFst1YA7iovPHJQeWUpmyukHOWEUfm+RYq/g4ZN+Yc/eOKlr3k1p
         qCQX74P/NOVO3nhjNoYLhRwfQAP7TlnZAN2PgRUbfZ3v8rrYWAKcHK9ugixr3ea5laq7
         Owk7ST3QhDlZUYKuxv4fgXgh58es2oIpyf/IKJFavSpWTfm2O3V4plrFf38jwytgV1/l
         kDeg==
X-Gm-Message-State: AOAM532HtvTs5ZzkuzxqQ79yrQlgUZ1sSw+ga9gzjrhNTP9YAqcS/Ry4
        KSmlF8KDbUpjQkUury7jnygieNE4
X-Google-Smtp-Source: ABdhPJyqqthy36V1WPjupbGzVk0l3asufpRZMM14CLxk+0fzXEFU1T7EHdEbmLtLvS64LcTNFCkjow==
X-Received: by 2002:aa7:c407:: with SMTP id j7mr6412503edq.96.1595548007508;
        Thu, 23 Jul 2020 16:46:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:47 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] do not accept comma expressions in array declarator
Date:   Fri, 24 Jul 2020 01:46:37 +0200
Message-Id: <20200723234641.78462-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
References: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Comma expressions are not allowed for the size in an array
declarator.

So, change the parsing of these expressions to only accept
assignment-expressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                                | 2 +-
 validation/abstract-array-declarator.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/parse.c b/parse.c
index cc5dbd522b3e..182f4ad30b9c 100644
--- a/parse.c
+++ b/parse.c
@@ -1743,7 +1743,7 @@ static struct token *abstract_array_declarator(struct token *token, struct symbo
 
 	if (match_idents(token, &restrict_ident, &__restrict_ident, &__restrict___ident, NULL))
 		token = abstract_array_static_declarator(token->next, &has_static);
-	token = parse_expression(token, &expr);
+	token = assignment_expression(token, &expr);
 	sym->array_size = expr;
 	return token;
 }
diff --git a/validation/abstract-array-declarator.c b/validation/abstract-array-declarator.c
index f230e5862ae9..ca182373b866 100644
--- a/validation/abstract-array-declarator.c
+++ b/validation/abstract-array-declarator.c
@@ -3,7 +3,6 @@ void c99(int a[(1, 2)]);
 
 /*
  * check-name: abstract-array-declarator
- * check-known-to-fail
  *
  * check-error-start
 abstract-array-declarator.c:1:17: error: Expected ] in abstract_array_declarator
-- 
2.27.0

