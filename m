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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3F0C433E4
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15968206C3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agbOOuji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHIUxh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHIUxh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:37 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB27C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:37 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id df16so4958438edb.9
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c33lN/FCxCwBBDO3E/mppG85/K6GGeXSS8IZ1jmCNJU=;
        b=agbOOujieSwmP9D5Kjccl+HxhpsPlZyjAGHNI8RffBHvJ8UsXHow0x1D1G1cNfntNL
         VtX8fthC67W+cC/r82zoHaQzR9amyUkp5BEpjSlWaxVqeaRpq2z8jQNT74G7066pfs3w
         fUXhuTn+jADCIy9k2IJ0H0S9zTPrNFCJr7nERwEqJgCXTkgc172GNLXbNINvab/XsuQO
         hwz9XMZoO79J17FISHLRDMv/bPRiUjZSKRkz6Dq4cRHM4EGIFEjX7iF9qNr40D0Mcat0
         WHyD/6ZZJmaJ+CXLTxhOO1GK6psquGNsZv9zuPQPUNkQMea2e2uPtvE5X9t837ENqGXu
         sDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c33lN/FCxCwBBDO3E/mppG85/K6GGeXSS8IZ1jmCNJU=;
        b=bPo+uM/rQsEYV5Ge0FYKB2n1Kob6ysqM7Vie1881w1T/RnGjjIrOVnCaZ4ylW9iytG
         v0Ps4EZRydfHO+wGsWrNLWavqTZvAz8jf3nVFVLHQgX1FDQf3Y2fubNmm+98UKyRJ5o5
         SRifAQmOJP5WooXYMGJrCg5f3GFq5tOqnaHd4f3k7GkaKWxF4bZ2Mhv3iasBJmwQ/HI7
         qKWTEP60dP0AKewi2bFCTIc0SzsyBuTmlVVDO9ZilJysETafsP7bCdWXKqO4mXmPs3PB
         o0s6T9/G+45/FOflUikyvr0NOrchQbxiKokYeAn0vQUwoMmPMW3aw/YiArg5WomcmwLr
         D+Bw==
X-Gm-Message-State: AOAM532H6VqNj/oHHjElMlk2nqZuLmvxaPyhooDYr9Q0uB+4zIHnJmQm
        ng7G9/QTCA2c3lLpXhV+atBVc7hO
X-Google-Smtp-Source: ABdhPJxO6TSuyMOebRIK2ksIQEls2OXwCiGVNdWiNvn5+gVxFrra1IMwqRVW81zID7EXGEFGClSFDA==
X-Received: by 2002:a50:fa94:: with SMTP id w20mr18906461edr.82.1597006414990;
        Sun, 09 Aug 2020 13:53:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/10] attribute: split handle_asm_name() from handle_attributes()
Date:   Sun,  9 Aug 2020 22:53:21 +0200
Message-Id: <20200809205329.42811-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

handle_attributes() handles attributes but also the asm names.
These asm names must occur before the attributes and only once
while the attributes may occur multiple time. Also, these asm
names are not allowed everywhere attributes, only in declarations.

It's maybe handy to process both in the same function but it's
also slightly confusing. So, move the handling of the asm names
in a separate function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 19520eaebf38..cf897e5d2804 100644
--- a/parse.c
+++ b/parse.c
@@ -1742,6 +1742,20 @@ static struct token *parameter_type_list(struct token *, struct symbol *);
 static struct token *identifier_list(struct token *, struct symbol *);
 static struct token *declarator(struct token *token, struct decl_state *ctx);
 
+static struct token *handle_asm_name(struct token *token, struct decl_state *ctx)
+{
+	struct symbol *keyword;
+
+	if (token_type(token) != TOKEN_IDENT)
+		return token;
+	keyword = lookup_keyword(token->ident, NS_KEYWORD);
+	if (!keyword || keyword->type != SYM_KEYWORD)
+		return token;
+	if (!(keyword->op->type & KW_ASM))
+		return token;
+	return keyword->op->declarator(token->next, ctx);
+}
+
 static struct token *skip_attribute(struct token *token)
 {
 	token = token->next;
@@ -1798,7 +1812,6 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 		if (!(keyword->op->type & keywords))
 			break;
 		token = keyword->op->declarator(token->next, ctx);
-		keywords &= KW_ATTRIBUTE;
 	}
 	return token;
 }
@@ -3018,7 +3031,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	saved = ctx.ctype;
 	token = declarator(token, &ctx);
-	token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
+	token = handle_asm_name(token, &ctx);
+	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 	apply_modifiers(token->pos, &ctx);
 
 	decl->ctype = ctx.ctype;
@@ -3142,7 +3156,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		ctx.ctype = saved;
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		token = declarator(token, &ctx);
-		token = handle_attributes(token, &ctx, KW_ATTRIBUTE | KW_ASM);
+		token = handle_asm_name(token, &ctx);
+		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		apply_modifiers(token->pos, &ctx);
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
-- 
2.28.0

