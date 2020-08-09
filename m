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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7180C433E3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DA7206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6OSHHTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHIUxo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgHIUxn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75CC061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:43 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so7403957ejb.4
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uLSE3sMjtLd8YmuuFJpILZqhYeg0jd0r3m+B11eDVc=;
        b=m6OSHHTKFhegInjACLF5qmwaDfqyYeCKjW/D1WhT9+k23VBqrKPF+PNL+ACvRRhFY3
         HAseWyZrEOvAz2pX1qiYZkkMEdwQWJvgZ0LQj+M0Kmlc4jA59pw9hA5QLuEvngRrWe8t
         /XikSKdYltFwDINXoigQcOhQGCMjjaJBAo4OErHNDjvs0bf02XsXNFFZPcXfkZwiySct
         X32TQZlhauKjOptc7u55lQxrHaw5ZtYcPB6PS6Ip7LGWlzKIxcRumFKsOcBklrpEc/jH
         9f6rgS4uCv4Qiti2B0jjmLREUED+fvMbMT3av+7Q0C6D5vVgqDTU0/xznMvnIwEHl3Qw
         +Bhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uLSE3sMjtLd8YmuuFJpILZqhYeg0jd0r3m+B11eDVc=;
        b=ixnG7xVwbSsi1ydG0Tz4Jr1DYejsKB6X5VY9jMkusFwUjos5E9t4a/wRiUGydmw+DL
         04U0fJ2wNsa0tTHkQmPLQKj/f32JzrF1QwWkB4MlEl8LNqdC2RIa//hoTVGYeevC5iej
         HQHnxT3K82Na1wUeWj25E6xZfM3nQP3pqW39r/uYgH/hKno0mc1nOnrcoDd111EW956l
         jLkN7Q/FNIN8G4/nLoy8FQHPaKCAlwHedaKaGkv78LBA3uFQzOSLAmUSVvheaSGmECGU
         NviGcr4b+9bzKKe6J7F6d87Ks5p28elPzjXgV/n8qu8NLrS5OD2QEKSJL9oP7Ut45Kz4
         7SuA==
X-Gm-Message-State: AOAM533BxIF2N25RS/Ry4wD3u+Ok/qJFpppNya2+c9hZZGCupBwJAuIx
        CB/tUlrduysE3gjrx/0XdcaXDjKi
X-Google-Smtp-Source: ABdhPJxFbRCAE6UaZXK9C9vWe/ASXa7ht5gIdwec8gIEHgBi9QRZoNxgw0gj8Wu2230YMrLOREtcnA==
X-Received: by 2002:a17:906:2717:: with SMTP id z23mr583471ejc.19.1597006421548;
        Sun, 09 Aug 2020 13:53:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:41 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/10] testing for sym->op is unneeded for lookup_keyword()
Date:   Sun,  9 Aug 2020 22:53:28 +0200
Message-Id: <20200809205329.42811-10-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

All symbols returned by lookup_keyword() are of type SYM_KEYWORD,
because either:
   1) it's in NS_KEYWORD (and all symbol in NS_KEYWORD are SYM_KEYWORD)
   2) it's in NS_TYPEDEF and all *keywords* in NS_TYPEDEF are reserved
      and so can't be user defined and so must be SYM_KEYWORD.
Thus, they all have a symbol_op associated to them and it's
unneeded to test it.

So, remove the unneeded test.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 2b7ef2ae23c4..d378f1255fee 100644
--- a/parse.c
+++ b/parse.c
@@ -2160,7 +2160,7 @@ static struct token *parse_asm_statement(struct token *token, struct statement *
 	stmt->type = STMT_ASM;
 	while (token_type(token) == TOKEN_IDENT) {
 		struct symbol *s = lookup_keyword(token->ident, NS_TYPEDEF);
-		if (s && s->op  && s->op->asm_modifier)
+		if (s && s->op->asm_modifier)
 			s->op->asm_modifier(token, &mods);
 		else if (token->ident == &goto_ident)
 			asm_modifier(token, &mods, MOD_ASM_GOTO);
-- 
2.28.0

