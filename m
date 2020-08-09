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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9FAC433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97182206D8
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv5Redwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHIUxk (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgHIUxj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 16:53:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC8C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 13:53:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs17so4989409edb.1
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8MVILbPVkAthU68h6numub/5je9Hm949nrIiW7mSmI=;
        b=iv5RedwubF4WLtC7c6YfTMrEIerFKyH+Fi2fPpBxXh9t/0ojjgrB6m87aBjNjzqOMe
         yxV82gCTBGirSj9yaMARyjifXc21+H/RQwBr5il+t1JEgK2HjgD6kJ7pGZJ7mBzibMnM
         cMsi1ncwUhZHOCrh9oGZ2i/bxBHbTRiqLTXYg17i5mH8zdEiFPYF8OQSRpQxDwyVCVgC
         jOMSUcdNF0i87L7quuzUCqisBXqAgTAECN0NJR37wkkzXY2rjoCPHCodn2lolyf9rjbj
         xSph4PXuZS3BlfUs7Nu1EcvaTYRBvpzI2kAqBrB7SmEDsWXO9EbUlSTni8snzaxpeeh3
         YwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8MVILbPVkAthU68h6numub/5je9Hm949nrIiW7mSmI=;
        b=eDdKNyynC3IN5jjhBg7S+t7UzcR3Jg9KYrv9n4D7ptTe1rA92Vj/h5XbmD5cEO1iPu
         mQwgwhLQZuQ23BJGrIzfPyZ1TzNWVK1I0ObF9KWU+g218isUukRx+GmNRQ+koRJ/35jk
         rLdnJd8d/iOLO4x8h4O8mCKMX7Son4SVzeF+BLUY8s+uIouhfCAN7UEiUzZ1OQz9Kywo
         K4L1Skb+U6qur79MbhDvct1eBLug6pZZTCvf/IFIEiODAq/FHk7u+Fm/xAfy8F8l53hh
         H8BQik+X51gfinZccfcprdv2YHHQTFSY4yrshZgAB/SkazsUliswwNMYGosUOgDhvDJy
         I+kQ==
X-Gm-Message-State: AOAM533S9bQ9RzccjkTL506RxXHxn891XcYQ7ijTNHDnz3iWL/0wKVBE
        TpqqZT2gIEsIgk1yMKQ1PpB5g6z2
X-Google-Smtp-Source: ABdhPJxQl1U7Ze1K3SWr/Cim9UtEGaLZ67w8yauR72JBvu+I6ooPH96ZC43MYAUEeDShEtUVdvuIkA==
X-Received: by 2002:a05:6402:b45:: with SMTP id bx5mr18646844edb.22.1597006417144;
        Sun, 09 Aug 2020 13:53:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id m20sm11258203ejk.90.2020.08.09.13.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 13:53:36 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/10] attribute: remove argument 'keywords' from handle_attributes()
Date:   Sun,  9 Aug 2020 22:53:23 +0200
Message-Id: <20200809205329.42811-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
References: <20200809205329.42811-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Now that the asm names are handled in handle_asm(), the 'keywords'
argument of handle_attributes() is no more needed since it always
must be 'KW_ATTRIBUTE'.

So, remove this argument.

Note: this is preparation work to later make the distinction between
      function/variable/type/label/... attributes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/parse.c b/parse.c
index 73ec579cfa7f..ec675f20ef01 100644
--- a/parse.c
+++ b/parse.c
@@ -49,7 +49,7 @@ struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
 static struct token *statement(struct token *token, struct statement **tree);
-static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords);
+static struct token *handle_attributes(struct token *token, struct decl_state *ctx);
 
 typedef struct token *declarator_t(struct token *, struct decl_state *);
 static declarator_t
@@ -756,7 +756,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 	struct symbol *sym;
 	struct position *repos;
 
-	token = handle_attributes(token, ctx, KW_ATTRIBUTE);
+	token = handle_attributes(token, ctx);
 	if (token_type(token) == TOKEN_IDENT) {
 		sym = lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
@@ -956,7 +956,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 		struct symbol *sym;
 
 		// FIXME: only 'deprecated' should be accepted
-		next = handle_attributes(next, &ctx, KW_ATTRIBUTE);
+		next = handle_attributes(next, &ctx);
 
 		if (match_op(next, '=')) {
 			next = constant_expression(next->next, &expr);
@@ -1805,7 +1805,7 @@ static struct token *skip_attributes(struct token *token)
 	return token;
 }
 
-static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords)
+static struct token *handle_attributes(struct token *token, struct decl_state *ctx)
 {
 	struct symbol *keyword;
 	for (;;) {
@@ -1814,7 +1814,7 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 		keyword = lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
 		if (!keyword || keyword->type != SYM_KEYWORD)
 			break;
-		if (!(keyword->op->type & keywords))
+		if (!(keyword->op->type & KW_ATTRIBUTE))
 			break;
 		token = keyword->op->declarator(token->next, ctx);
 	}
@@ -1903,8 +1903,7 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	    is_nested(token, &next, ctx->prefer_abstract)) {
 		struct symbol *base_type = ctype->base_type;
 		if (token->next != next)
-			next = handle_attributes(token->next, ctx,
-						  KW_ATTRIBUTE);
+			next = handle_attributes(token->next, ctx);
 		token = declarator(next, ctx);
 		token = expect(token, ')', "in nested declarator");
 		while (ctype->base_type != base_type)
@@ -2027,7 +2026,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		if (match_op(token, ':'))
 			token = handle_bitfield(token, &ctx);
 
-		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+		token = handle_attributes(token, &ctx);
 		apply_modifiers(token->pos, &ctx);
 
 		decl->ctype = ctx.ctype;
@@ -2067,7 +2066,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	token = declaration_specifiers(token, &ctx);
 	ctx.ident = &sym->ident;
 	token = declarator(token, &ctx);
-	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+	token = handle_attributes(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
 	sym->ctype.modifiers |= decl_modifiers(&ctx);
@@ -2567,7 +2566,7 @@ static struct token *handle_label_attributes(struct token *token, struct symbol
 {
 	struct decl_state ctx = { };
 
-	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+	token = handle_attributes(token, &ctx);
 	label->label_modifiers = ctx.ctype.modifiers;
 	return token;
 }
@@ -3028,7 +3027,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	saved = ctx.ctype;
 	token = declarator(token, &ctx);
 	token = handle_asm_name(token, &ctx);
-	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+	token = handle_attributes(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 
 	decl->ctype = ctx.ctype;
@@ -3150,10 +3149,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		ctx.ctype = saved;
-		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+		token = handle_attributes(token, &ctx);
 		token = declarator(token, &ctx);
 		token = handle_asm_name(token, &ctx);
-		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
+		token = handle_attributes(token, &ctx);
 		apply_modifiers(token->pos, &ctx);
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
-- 
2.28.0

