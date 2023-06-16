Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A06FEB64D7
	for <linux-sparse@archiver.kernel.org>; Fri, 16 Jun 2023 18:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjFPSp6 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 16 Jun 2023 14:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFPSp6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2023 14:45:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650435AD
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2023 11:45:56 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8d0d68530so9650855e9.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2023 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686941154; x=1689533154;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sxu2k8WVGEvm9vtT7HHKa/tRoMu/61Yzm9RfmzLYoAY=;
        b=J5YFPt/ItgLmRb9pTwMiA6FgEtSnJ4ZUUSu5/bd7QuoOwpPYdbFBjLYPe0w+iYHY6E
         TteIVDj01BFf1jvJcdbJakXA0qzQnJUvnlOjSZt6FJ4twj75/hEQsnz/ehEi9TKWjZW8
         xZShsY6P+Owg2FV8zfrMDu+Z9azS26xkK8tPNKeRcZB/tYKRbQsIFqF6bEWL0YaFrGy6
         uGut/nLL5e93VLXVpUHWq8Y9FQ51dmXlNOncRGGn/DurVKarhvHFQjsFx+zDrnzT9tyl
         3TEcyBIPFsrwK81lzTTugKUG3FKHatq/gNh/2a2qBwFMd/a5Fv9RpKD2MXv9rOx5GmoH
         775A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941154; x=1689533154;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxu2k8WVGEvm9vtT7HHKa/tRoMu/61Yzm9RfmzLYoAY=;
        b=OcAgs/anS5BXqopF9nXvQUet6xUDLdTtuFkDlveIN14NPe3EzzdxJhqwP8iQunWYTM
         YG8MOC0CCYS7HG7EOD/7jlfOrfboZd9rMquW6uyZaZ8rU/KgZJ6JudJo0eLDVZAo8kBt
         OoXNdvG5zHYjLTRE0UE4pzA7bQ217Fz4rgjAktSuELrGbKHvPCxfguK5ROIC978T/U2R
         F09mn4AdukSR+xZEt2Hp7WpLZRWdnK8Bxwj0IMu4yHAe0les3ZLI02gGC4DYx1fozMAP
         WSR4mAddnQHySStb/qQa9CQwvhEHmLJN/PM14SdX77mnwqXOAH4VX45tgd95kTYdtS4T
         cVAQ==
X-Gm-Message-State: AC+VfDyINpYPZ3rTSHGABuaLt3THrffdeS7uX/PmMMkcPRzesq3HnAQ0
        CLQRsCcMiLbs5navJuHhhxuPC81LSj2FG6Fy9uE=
X-Google-Smtp-Source: ACHHUZ4XQ/CQgB3CCDXbu18qikjjI8xTBzhMuNvt44SlqYWQBw0hTM2hWsPFwimt7R93KF5AYG28Nw==
X-Received: by 2002:a1c:f603:0:b0:3f8:f80e:7b48 with SMTP id w3-20020a1cf603000000b003f8f80e7b48mr1942895wmc.32.1686941154194;
        Fri, 16 Jun 2023 11:45:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d6-20020adffd86000000b0030ae87bd3e3sm24296403wrr.18.2023.06.16.11.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 11:45:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 21:45:42 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     linux-sparse@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] parse: add support for the __cleanup__ attribute
Message-ID: <ZIyt1uUYW/YXEluw@moroto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The kernel is soon going to start using the __cleanup__ attribute so we
need to add support for it in Sparse.  This patch is a bit ugly, but it
gives me the minimum that I need to make Smatch work and hopefully it's
the starts the conversation about how to do this correctly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 parse.c  | 24 +++++++++++++++++++++++-
 symbol.h |  2 ++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 3d6fef7cb011..185a4c7f7cfb 100644
--- a/parse.c
+++ b/parse.c
@@ -79,7 +79,8 @@ typedef struct token *attr_t(struct token *, struct symbol *,
 			     struct decl_state *);
 
 static attr_t
-	attribute_packed, attribute_aligned, attribute_modifier,
+	attribute_packed, attribute_aligned, attribute_cleanup,
+	attribute_modifier,
 	attribute_function,
 	attribute_bitwise,
 	attribute_address_space, attribute_context,
@@ -361,6 +362,10 @@ static struct symbol_op aligned_op = {
 	.attribute = attribute_aligned,
 };
 
+static struct symbol_op cleanup_op = {
+	.attribute = attribute_cleanup,
+};
+
 static struct symbol_op attr_mod_op = {
 	.attribute = attribute_modifier,
 };
@@ -537,6 +542,7 @@ static struct init_keyword {
 	/* Attributes */
 	D("packed",		&packed_op),
 	D("aligned",		&aligned_op),
+	D("__cleanup__",	&cleanup_op),
 	D("nocast",		&attr_mod_op,		.mods = MOD_NOCAST),
 	D("noderef",		&attr_mod_op,		.mods = MOD_NODEREF),
 	D("safe",		&attr_mod_op,		.mods = MOD_SAFE),
@@ -1114,6 +1120,18 @@ static struct token *attribute_aligned(struct token *token, struct symbol *attr,
 	return token;
 }
 
+static struct token *attribute_cleanup(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	struct expression *expr = NULL;
+
+	if (match_op(token, '(')) {
+		token = parens_expression(token, &expr, "in attribute");
+		if (expr && expr->type == EXPR_SYMBOL)
+			ctx->cleanup = expr;
+	}
+	return token;
+}
+
 static void apply_mod(struct position *pos, unsigned long *mods, unsigned long mod)
 {
 	if (*mods & mod & ~MOD_DUP_OK)
@@ -1910,6 +1928,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
+		decl->cleanup = ctx.cleanup;
 		decl->endpos = token->pos;
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
@@ -1964,6 +1983,7 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
+	sym->cleanup = ctx.cleanup;
 	sym->endpos = token->pos;
 	class = ctx.storage_class;
 	if (forced)
@@ -2924,6 +2944,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	decl->ctype = ctx.ctype;
 	decl->ctype.modifiers |= mod;
+	decl->cleanup = ctx.cleanup;
 	decl->endpos = token->pos;
 
 	/* Just a type declaration? */
@@ -3048,6 +3069,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		apply_modifiers(token->pos, &ctx);
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
+		decl->cleanup = ctx.cleanup;
 		decl->endpos = token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
diff --git a/symbol.h b/symbol.h
index 5270fcd73a10..88130c15d4bd 100644
--- a/symbol.h
+++ b/symbol.h
@@ -107,6 +107,7 @@ struct decl_state {
 	struct ctype ctype;
 	struct ident **ident;
 	struct symbol_op *mode;
+	struct expression *cleanup;
 	unsigned long f_modifiers;		// function attributes
 	unsigned long storage_class;
 	unsigned char prefer_abstract;
@@ -204,6 +205,7 @@ struct symbol {
 			struct statement *inline_stmt;
 			struct symbol_list *inline_symbol_list;
 			struct expression *initializer;
+			struct expression *cleanup;
 			struct entrypoint *ep;
 			struct symbol *definition;
 		};
-- 
2.39.2
