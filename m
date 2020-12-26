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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD26C433E9
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D36020809
	for <linux-sparse@archiver.kernel.org>; Sat, 26 Dec 2020 17:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLZRxU (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 26 Dec 2020 12:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgLZRxT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 26 Dec 2020 12:53:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B17CC061798
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 190so5771064wmz.0
        for <linux-sparse@vger.kernel.org>; Sat, 26 Dec 2020 09:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lipu7i6g9gAO9jeyCdrMofgOVQbcXXikXSs19rjetAo=;
        b=nYuEO5fgnVqC3SH8l5inv3iZkUw+J4v6d16TdUGHsPz/z9BZwod+sM2HgqonIunr53
         5CDe4UjrBK/ZlfIQRcfhAjM+5w3hnah8/4G/RU7ES0eKh518Lnphv+RawcRoBIVAoyMI
         SVV8MueRg5mu0a7AcvOYaA4M+O96tJ0/qI29XgKJgRzvDflH1u5aOrWq5ozviktY3fM4
         ATn6fVcMYsrll2sNnC/979CECxmozljKzQqZ5LfYTmh5e9GIo9UgejP1Wh67QQOnAmlA
         7GCDxqmpB7G0o6DLy3Yuy7ImXKMQByVQ3CXPyA342UbPqAgv7dbRA39JY+2blGpXBtJs
         Axrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lipu7i6g9gAO9jeyCdrMofgOVQbcXXikXSs19rjetAo=;
        b=YnIvoJyo/JXglyvMCb2w/uDzbp6Ge3FE+T3fM1fW2ogP/3orD3DaOQVktlRdkE1zoM
         h5UgvR/ogxxvLxwigsk5CFd2qI3mu/ft+Y70tJLUqKtzQ8Hu7nqV81o3f6b9aubr+/bR
         bUjWeP++a4pWEZL+tqny3SyEA+u7i1duOjnWuG3tGteZh2uvIvPQz5+nnS66reMS24er
         FmijzB3YgbKNt3VqNZFVCHMHLsp85cBBsFD8dUEM+g3u65X4QvCeBaaQDoTK0wXYU57G
         9B1WEzbJRX0ijbuu+b+G7mLhI6S743BYE32XWeV+ctf3L2JuLVa2PCq82N3Zk+SIBEIq
         gdmg==
X-Gm-Message-State: AOAM533eflp8v+YrgNj93StRg0jv06iQyEYRWXULbFimNafEfQGv2YYj
        BVmjjvdTFWwIznIvPoIAOyTOkumf7rw=
X-Google-Smtp-Source: ABdhPJxreeau2Auu40DZV1/gXCr3yzVk9zWKAkH8hps1GEwMIcZXs0hVOABfr/hN+F5YzfJ/52au+w==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr12936160wmc.102.1609005123882;
        Sat, 26 Dec 2020 09:52:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:10a5:37c9:8c28:d3e9])
        by smtp.gmail.com with ESMTPSA id c4sm12780813wmf.19.2020.12.26.09.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 09:52:03 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 08/16] apply_ctype: reverse the order of arguments
Date:   Sat, 26 Dec 2020 18:51:21 +0100
Message-Id: <20201226175129.9621-9-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

apply_ctype()'s argument order is: src, dst (so the reading
direction) but the assignment/memcpy() order is much more used:
	dst = src;
	memcpy(dst, src, n);
than the order here is confusing.

So, change its argument order to comply with the memcpy()/
assignement order and stop the confusion.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 402214212d77..f106444f75d8 100644
--- a/parse.c
+++ b/parse.c
@@ -1043,7 +1043,7 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
 	return ret;
 }
 
-static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst);
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
 
 static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
@@ -1056,7 +1056,7 @@ static struct token *typeof_specifier(struct token *token, struct symbol *sym, s
 		struct symbol *sym;
 		token = typename(token->next, &sym, NULL);
 		ctx->ctype.base_type = sym->ctype.base_type;
-		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
+		apply_ctype(token->pos, &ctx->ctype, &sym->ctype);
 	} else {
 		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
 		token = parse_expression(token->next, &typeof_sym->initializer);
@@ -1427,7 +1427,7 @@ static struct token *generic_qualifier(struct token *next, struct symbol *sym, s
 	return next;
 }
 
-static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst)
+static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src)
 {
 	unsigned long mod = src->modifiers;
 
@@ -1529,7 +1529,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 				break;
 			seen |= Set_S | Set_T;
 			ctx->ctype.base_type = s->ctype.base_type;
-			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
+			apply_ctype(token->pos, &ctx->ctype, &s->ctype);
 			token = token->next;
 			continue;
 		}
-- 
2.29.2

