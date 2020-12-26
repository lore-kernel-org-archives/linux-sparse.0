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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A0C4332E
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C710820809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgLZRxW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgLZRxW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB41C06179E
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a12so6660260wrv.8
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJXiqKN0FincI2RnZabMb03+M1rtkN2yeJaFy6afhDs=;
        b=A2o41Tsw4DS18nK3p1hMnauxQ2PamIKAKVXixBOEZ3qBYnPGFeaqd3ZgUR+xA/MSWw
         OzGUYqgTIGi9DrYHmMP3MxCmoUn5qDCeGmf/O6AwRzsAQomdn30xGk6xj37hEJpmdMJg
         vNCRqG5pFfSXTigs/0oHAX/bWZFQyG81L50FBxu34l3CyfDUAKqqAY0L79K34jNXcpPU
         XA0xBZQbcbovlMZff3ulOYRIzRw5Y4QLv4qik0eiwgA/n7N9dU0aiiRKqKDyzyFfhaTq
         Ari089WUz1fkUgofPNQxAastGHW7ZGILd0no7saDJ7bwwaEB474W8hOUC9PZjCVxdUyi
         rowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJXiqKN0FincI2RnZabMb03+M1rtkN2yeJaFy6afhDs=;
        b=aFO4G1qcUsaKbWS5GFu52V7ivha4HxWKUvhvLwbRfHnQGFerj5eFfQCwlNCfWVoC7F
         LaekC/aPC8jaijCyGCXmknlS77N5BXvPelBPg/wfsGOxfKWOxaDkQGXhHoHweJR/lfOm
         cA04aH0iksl6PXQkGeJnbRTk8mdL3OoBiIh48vBowq5XtU1L+xjJaafKyKFwABmcmHQV
         dQaDr6Vs/Mfq9FqXqGbg8vND+eRIXtjrhTQ1WYlz/LbT8Y1W+5aMA/ohggF0zMXVP8o0
         515uFo5gP5o6W4ayhw5SBYB3eLi1XS0/ivHOlokX2rRNrRFlOxMoXbTh3Am2hy10E8+M
         pnrg==
X-Gm-Message-State: AOAM533eW5sxOj+a95LjLomKKPtlLggveHZi0umkGobSGq/3OwGCY+45
        AkrHZvL+E/Cm/EMaMODo7xDbfkYE9Bw=
X-Google-Smtp-Source: ABdhPJwCT6edtl5vnKwPz5DbZJ2uPZg208/X1WzPMsriUIFeopNP8NxVR1L5ADgE+ZC4Xoo7tQSJ0Q==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr42065554wru.206.1609005128291;
        Sat, 26 Dec 2020 09:52:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:07 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 13/16] struct-attr: fix type attribute like 'struct __attr { ... }'
Date:   Sat, 26 Dec 2020 18:51:26 +0100
Message-Id: <20201226175129.9621-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In a declaration like:
	struct <some attribute> { ... }
the attribute belong to the type but is currently handled as belonging
to the whole declaration.

Fix this by handling such attributes in a local 'decl_state' and
applying them once the closing '}' is reached.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index a67d567145d0..5f33ac178a45 100644
--- a/parse.c
+++ b/parse.c
@@ -719,10 +719,11 @@ static struct token *struct_union_enum_specifier(enum type type,
 	struct token *token, struct decl_state *ctx,
 	struct token *(*parse)(struct token *, struct symbol *))
 {
+	struct decl_state attr = { };
 	struct symbol *sym;
 	struct position *repos;
 
-	token = handle_attributes(token, ctx);
+	token = handle_attributes(token, &attr);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
@@ -760,6 +761,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
+	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 
 	// Mark the structure as needing re-examination
 	sym->examined = 0;
-- 
2.29.2

