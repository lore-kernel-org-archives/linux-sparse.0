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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C375C43381
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B6D207A3
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Dec 2020 10:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLaKMG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Dec 2020 05:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLaKMF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Dec 2020 05:12:05 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E3C0617A6
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v14so6990494wml.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Dec 2020 02:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sS3CtCv1mfx7U74EhcAnKmNrWaxczz5yzmoqqiME4XA=;
        b=El1VW+25rRRRbBM/OIDWtRXtLzXGnDpniWGXyDTu8HdgfJ2pD+dWb1uOp2DgxALT2W
         3gZqyZlxWaC+NYcE6Td/QRKlVRRPun9u1NYKBZ1GfDUAGe1Bq9UtfrODT61kYfFqzsrc
         vEHEEc661zFsS9OAPfntYfJmVDvWzzweUrbB0+DOFbfTQT/2bjKjcu9caVo2DxSZpqc5
         MqUDpBifYs5lbMFbLuAyaPYTdqQQdXtDucJjB3OLx8hFAVVBdy5YBrveg01/YpLux+XN
         fonYFXI1K0QWIjXMbS0sANsl62g5yDdrb4CNQX+RiBzHmxD8KriX9I/nzWNK4N3SIk9J
         K14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sS3CtCv1mfx7U74EhcAnKmNrWaxczz5yzmoqqiME4XA=;
        b=KqHC3wuP0tv1NbRAWQCjaTdS40YiFbbnpVgbUEWpbj1Ffhn/8j8cUlqhm/tzMhF3el
         1ZTWGnLnvIDIJjEDO/hM3+cmvuKHJf8ZPuMJb4be9ugAV2eWGrMwm3MTzuwRoK0lLlHm
         0jkUoL7bUwhI4g2Syb3kmuEzR/8KWcA3ssQNyt6QrMSGeerxbXXIk/TpJAURWpnU56Xt
         x40Bz3vBBQcp5KXx1bmw9Zn8oXhyjoxnDbiXX6QypxQXrKKgOxFr+Pz7WKp/5255Gohn
         q4BRqTmgMyjaE0/Kkl+Q9mGRNuT6GRKvX4MlsUxJgZKiEbrD4KQYRmh7e9QvUuYDjakt
         bQLQ==
X-Gm-Message-State: AOAM530+hrta9gBlWnHBzaWnf1frA6v3Cklier0mScUKBTNX8rh1vz38
        MlLN/kqkg9mmpKERAIr3xLdXC04BSUA=
X-Google-Smtp-Source: ABdhPJyT9ZBuJQCcvvswcd5yozHdXq5Z8whL31JhidTfr02NtiuoHEcK79op7nfduRppTlnEvzGzqQ==
X-Received: by 2002:a7b:c091:: with SMTP id r17mr11492471wmh.129.1609409451892;
        Thu, 31 Dec 2020 02:10:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:7c8c:1eb2:47fd:b5e7])
        by smtp.gmail.com with ESMTPSA id n3sm66161019wrw.61.2020.12.31.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:10:51 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 13/16] struct-attr: fix type attribute like 'struct __attr { ... }'
Date:   Thu, 31 Dec 2020 11:10:31 +0100
Message-Id: <20201231101034.59978-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
References: <20201231101034.59978-1-luc.vanoostenryck@gmail.com>
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
index 69bfc2e0fe57..b38615b8d61d 100644
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
@@ -763,6 +764,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 
 	token = parse(token->next, sym);
 	token = expect(token, '}', "at end of specifier");
+	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 
 	sym->endpos = token->pos;
 
-- 
2.29.2

