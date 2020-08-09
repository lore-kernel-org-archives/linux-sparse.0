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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E02BC433E3
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7927C206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYYBBByb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHIQw6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQwx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B905C06178A
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so4740475edx.7
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQykV82bpnNc28LwFYpkbponpDzXBOc4RfJfkOMMf68=;
        b=YYYBBBybvoFsMJ5n07SDO9LkZFnfbng/4zHacsMz9yjzqw8z02ndnnCo1j/68cXMdu
         K77PyFcAXeD8ws+SPsHB+NHIZAObV7JEuRT+YjCQKiWCVyEi2qDb/02OPD7SPNLGImPA
         fNNDx2utDEU1mfwA7qLechvAoZDYCLiL+IUoSP6qJtwp/6/NZCl01zi13LF8CuWEWsSP
         CuU5GGhdyoHK/oucT5kCdwIx56fkNpFIF9Kc4kLL8NRy1aPFXEysYyPMN5Ien0gb0pzK
         LKA5MuO2A0GBPDHtwFhADhD7YTKbseZMOBxLmkWI8VuKnqZkCoHhlq2IWAaFaFJm+Dmd
         0rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQykV82bpnNc28LwFYpkbponpDzXBOc4RfJfkOMMf68=;
        b=dkWFb+nxLONMW+vkCGxdg+pgV3o4ul0qMzgtO9luw4J7ZKVqdY+ozJ29XRCjSlcJdB
         TKU95OQFPyKCaDbLRAUoVYa6UMiEK2rehrF/o2ZrVafXJKtj73FbZk4w60f7Y9E3GW3J
         aql2ka8BRV+FVpxBRSXaQ0pgb8OLBe0kdvbq350FWNCdEy4NOmHK8mXlhb/weJ+Je7Og
         8vWY1J9lkp7IRNhERrZgHKlA7Xl99eQaqI+KrZEAE9XVNthO74KO4htzeHbbi2ijEnGl
         el/SETzDNApoj/Xj2r1Ky7MJ0ByZhQbGQ12FwJuMkDVlzVokJCkoum+X/l5UL5jVXgze
         FcPg==
X-Gm-Message-State: AOAM533dzzrbdwadZI66Goq3PoIvmGIjeWrhyJHK2rbwypdm1kUxGb2N
        qwM6zuZ7nGGmiTxU9yIuK55TPLvJ
X-Google-Smtp-Source: ABdhPJykjT5A/L1vQ5QRROvTHM/KtdaKhoBgu3jgxnZ9Co7FEXqpEWb69UXo8knm9AEsTnCIv9o+ZA==
X-Received: by 2002:a05:6402:1c88:: with SMTP id cy8mr18190788edb.24.1596991960516;
        Sun, 09 Aug 2020 09:52:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:40 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] parse: associate modifiers with their keyword
Date:   Sun,  9 Aug 2020 18:52:26 +0200
Message-Id: <20200809165229.36677-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A significant number of declarators need to set or simply use
the modifier associated with the corresponding keyword but this
is open-coded for each of them. As result, almost all keywords
corresponding to a declaration need their own specific method.

Make this more generic by adding the associated modifier to the
ctype associated to keywords and passing the result of the keyword
lookup to the declarator methods. This way, these methods can be
made generic by getting the modifier from the ctype, like it was
already done for attributes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 156 +++++++++++++++++--------------------------------------
 symbol.h |   2 +-
 2 files changed, 48 insertions(+), 110 deletions(-)

diff --git a/parse.c b/parse.c
index 2711022aba69..37fe90c016fe 100644
--- a/parse.c
+++ b/parse.c
@@ -51,15 +51,12 @@ struct statement_list *function_computed_goto_list;
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct decl_state *ctx, unsigned int keywords);
 
-typedef struct token *declarator_t(struct token *, struct decl_state *);
+typedef struct token *declarator_t(struct token *, struct symbol *, struct decl_state *);
 static declarator_t
 	struct_specifier, union_specifier, enum_specifier,
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
-	typedef_specifier, inline_specifier, auto_specifier,
-	register_specifier, static_specifier, extern_specifier,
-	thread_specifier, const_qualifier, volatile_qualifier;
-static declarator_t restrict_qualifier;
-static declarator_t atomic_qualifier;
+	storage_specifier, thread_specifier;
+static declarator_t generic_qualifier;
 static declarator_t autotype_specifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
@@ -135,19 +132,18 @@ static void asm_modifier_inline(struct token *token, unsigned long *mods)
 
 static struct symbol_op typedef_op = {
 	.type = KW_MODIFIER,
-	.declarator = typedef_specifier,
+	.declarator = storage_specifier,
 };
 
 static struct symbol_op inline_op = {
 	.type = KW_MODIFIER,
-	.declarator = inline_specifier,
+	.declarator = generic_qualifier,
 	.asm_modifier = asm_modifier_inline,
 };
 
-static declarator_t noreturn_specifier;
 static struct symbol_op noreturn_op = {
 	.type = KW_MODIFIER,
-	.declarator = noreturn_specifier,
+	.declarator = generic_qualifier,
 };
 
 static declarator_t alignas_specifier;
@@ -158,22 +154,22 @@ static struct symbol_op alignas_op = {
 
 static struct symbol_op auto_op = {
 	.type = KW_MODIFIER,
-	.declarator = auto_specifier,
+	.declarator = storage_specifier,
 };
 
 static struct symbol_op register_op = {
 	.type = KW_MODIFIER,
-	.declarator = register_specifier,
+	.declarator = storage_specifier,
 };
 
 static struct symbol_op static_op = {
 	.type = KW_MODIFIER,
-	.declarator = static_specifier,
+	.declarator = storage_specifier,
 };
 
 static struct symbol_op extern_op = {
 	.type = KW_MODIFIER,
-	.declarator = extern_specifier,
+	.declarator = storage_specifier,
 };
 
 static struct symbol_op thread_op = {
@@ -183,23 +179,23 @@ static struct symbol_op thread_op = {
 
 static struct symbol_op const_op = {
 	.type = KW_QUALIFIER,
-	.declarator = const_qualifier,
+	.declarator = generic_qualifier,
 };
 
 static struct symbol_op volatile_op = {
 	.type = KW_QUALIFIER,
-	.declarator = volatile_qualifier,
+	.declarator = generic_qualifier,
 	.asm_modifier = asm_modifier_volatile,
 };
 
 static struct symbol_op restrict_op = {
 	.type = KW_QUALIFIER,
-	.declarator = restrict_qualifier,
+	.declarator = generic_qualifier,
 };
 
 static struct symbol_op atomic_op = {
 	.type = KW_QUALIFIER,
-	.declarator = atomic_qualifier,
+	.declarator = generic_qualifier,
 };
 
 static struct symbol_op typeof_op = {
@@ -478,27 +474,27 @@ static struct init_keyword {
 #define U(I, O,...)	N("__" I,O,##__VA_ARGS__),	\
 			N("__" I "__",O,##__VA_ARGS__)
 	/* Storage classes */
-	N("auto",		&auto_op),
-	N("register",		&register_op),
-	N("static",		&static_op),
-	N("extern",		&extern_op),
+	N("auto",		&auto_op,	.mods = MOD_AUTO),
+	N("register",		&register_op,	.mods = MOD_REGISTER),
+	N("static",		&static_op,	.mods = MOD_STATIC),
+	N("extern",		&extern_op,	.mods = MOD_EXTERN),
 	N("__thread",		&thread_op),
 	N("_Thread_local",	&thread_op),
 
-	A("inline",		&inline_op),
+	A("inline",		&inline_op,	.mods = MOD_INLINE),
 
 	/* Typedef ... */
-	N("typedef",		&typedef_op),
+	N("typedef",		&typedef_op,	.mods = MOD_USERTYPE),
 	A("typeof",		&typeof_op),
 	N("__auto_type",	&autotype_op),
 
 	/* Type qualifiers */
-	A("const",		&const_op),
-	A("volatile",		&volatile_op),
-	A("restrict",		&restrict_op),
+	A("const",		&const_op,	.mods = MOD_CONST),
+	A("volatile",		&volatile_op,	.mods = MOD_VOLATILE),
+	A("restrict",		&restrict_op,	.mods = MOD_RESTRICT),
 
-	N("_Atomic",		&atomic_op),
-	N("_Noreturn",		&noreturn_op),
+	N("_Atomic",		&atomic_op,	.mods = MOD_ATOMIC),
+	N("_Noreturn",		&noreturn_op,	.mods = MOD_NORETURN),
 	N("_Alignas",		&alignas_op),
 
 	U("attribute",		&attribute_op),
@@ -826,12 +822,12 @@ static struct token *parse_union_declaration(struct token *token, struct symbol
 	return struct_declaration_list(token, &sym->symbol_list);
 }
 
-static struct token *struct_specifier(struct token *token, struct decl_state *ctx)
+static struct token *struct_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	return struct_union_enum_specifier(SYM_STRUCT, token, ctx, parse_struct_declaration);
 }
 
-static struct token *union_specifier(struct token *token, struct decl_state *ctx)
+static struct token *union_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	return struct_union_enum_specifier(SYM_UNION, token, ctx, parse_union_declaration);
 }
@@ -1065,7 +1061,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 	return token;
 }
 
-static struct token *enum_specifier(struct token *token, struct decl_state *ctx)
+static struct token *enum_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	struct token *ret = struct_union_enum_specifier(SYM_ENUM, token, ctx, parse_enum_declaration);
 	struct ctype *ctype = &ctx->ctype.base_type->ctype;
@@ -1078,15 +1074,15 @@ static struct token *enum_specifier(struct token *token, struct decl_state *ctx)
 
 static void apply_ctype(struct position pos, struct ctype *thistype, struct ctype *ctype);
 
-static struct token *typeof_specifier(struct token *token, struct decl_state *ctx)
+static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
-	struct symbol *sym;
 
 	if (!match_op(token, '(')) {
 		sparse_error(token->pos, "expected '(' after typeof");
 		return token;
 	}
 	if (lookup_type(token->next)) {
+		struct symbol *sym;
 		token = typename(token->next, &sym, NULL);
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
@@ -1104,7 +1100,7 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 	return expect(token, ')', "after typeof");
 }
 
-static struct token *autotype_specifier(struct token *token, struct decl_state *ctx)
+static struct token *autotype_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	ctx->ctype.base_type = &autotype_ctype;
 	ctx->autotype = 1;
@@ -1158,7 +1154,7 @@ static void apply_qualifier(struct position *pos, struct ctype *ctx, unsigned lo
 
 static struct token *attribute_modifier(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	apply_qualifier(&token->pos, &ctx->ctype, attr->ctype.modifiers);
+	apply_mod(&token->pos, &ctx->ctype.modifiers, attr->ctype.modifiers);
 	return token;
 }
 
@@ -1353,7 +1349,7 @@ static struct token *recover_unknown_attribute(struct token *token)
 	return token;
 }
 
-static struct token *attribute_specifier(struct token *token, struct decl_state *ctx)
+static struct token *attribute_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	token = expect(token, '(', "after attribute");
 	token = expect(token, '(', "after attribute");
@@ -1392,57 +1388,29 @@ static unsigned long decl_modifiers(struct decl_state *ctx)
 	return ctx->storage_class | mods;
 }
 
-static void set_storage_class(struct position *pos, struct decl_state *ctx, unsigned long class)
+static struct token *storage_specifier(struct token *next, struct symbol *sym, struct decl_state *ctx)
 {
 	int is_tls = ctx->ctype.modifiers & MOD_TLS;
+	unsigned long class = sym->ctype.modifiers;
 	const char *storage = modifier_string(class);
 
 	/* __thread can be used alone, or with extern or static */
 	if (is_tls && (class & ~(MOD_STATIC|MOD_EXTERN))) {
-		sparse_error(*pos, "__thread can only be used alone, or with "
+		sparse_error(next->pos, "__thread can only be used alone, or with "
 				"extern or static");
-		return;
+		return next;
 	}
 
 	if (!ctx->storage_class)
 		ctx->storage_class = class;
 	else if (ctx->storage_class == class)
-		sparse_error(*pos, "duplicate %s", storage);
+		sparse_error(next->pos, "duplicate %s", storage);
 	else
-		sparse_error(*pos, "multiple storage classes");
-}
-
-static struct token *typedef_specifier(struct token *next, struct decl_state *ctx)
-{
-	set_storage_class(&next->pos, ctx, MOD_USERTYPE);
-	return next;
-}
-
-static struct token *auto_specifier(struct token *next, struct decl_state *ctx)
-{
-	set_storage_class(&next->pos, ctx, MOD_AUTO);
-	return next;
-}
-
-static struct token *register_specifier(struct token *next, struct decl_state *ctx)
-{
-	set_storage_class(&next->pos, ctx, MOD_REGISTER);
-	return next;
-}
-
-static struct token *static_specifier(struct token *next, struct decl_state *ctx)
-{
-	set_storage_class(&next->pos, ctx, MOD_STATIC);
-	return next;
-}
-
-static struct token *extern_specifier(struct token *next, struct decl_state *ctx)
-{
-	set_storage_class(&next->pos, ctx, MOD_EXTERN);
+		sparse_error(next->pos, "multiple storage classes");
 	return next;
 }
 
-static struct token *thread_specifier(struct token *next, struct decl_state *ctx)
+static struct token *thread_specifier(struct token *next, struct symbol *sym, struct decl_state *ctx)
 {
 	/* This GCC extension can be used alone, or with extern or static */
 	if (!(ctx->storage_class & ~(MOD_STATIC|MOD_EXTERN))) {
@@ -1461,19 +1429,7 @@ static struct token *attribute_force(struct token *token, struct symbol *attr, s
 	return token;
 }
 
-static struct token *inline_specifier(struct token *next, struct decl_state *ctx)
-{
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_INLINE);
-	return next;
-}
-
-static struct token *noreturn_specifier(struct token *next, struct decl_state *ctx)
-{
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_NORETURN);
-	return next;
-}
-
-static struct token *alignas_specifier(struct token *token, struct decl_state *ctx)
+static struct token *alignas_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	int alignment = 0;
 
@@ -1508,27 +1464,9 @@ static struct token *alignas_specifier(struct token *token, struct decl_state *c
 	return token;
 }
 
-static struct token *const_qualifier(struct token *next, struct decl_state *ctx)
-{
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_CONST);
-	return next;
-}
-
-static struct token *volatile_qualifier(struct token *next, struct decl_state *ctx)
-{
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_VOLATILE);
-	return next;
-}
-
-static struct token *restrict_qualifier(struct token *next, struct decl_state *ctx)
-{
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_RESTRICT);
-	return next;
-}
-
-static struct token *atomic_qualifier(struct token *next, struct decl_state *ctx)
+static struct token *generic_qualifier(struct token *next, struct symbol *sym, struct decl_state *ctx)
 {
-	apply_qualifier(&next->pos, &ctx->ctype, MOD_ATOMIC);
+	apply_qualifier(&next->pos, &ctx->ctype, sym->ctype.modifiers);
 	return next;
 }
 
@@ -1615,7 +1553,7 @@ static struct token *handle_qualifiers(struct token *t, struct decl_state *ctx)
 			break;
 		t = t->next;
 		if (s->op->declarator)
-			t = s->op->declarator(t, ctx);
+			t = s->op->declarator(t, s, ctx);
 	}
 	return t;
 }
@@ -1667,7 +1605,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 		}
 		token = token->next;
 		if (s->op->declarator)	// Note: this eats attributes
-			token = s->op->declarator(token, ctx);
+			token = s->op->declarator(token, s, ctx);
 		if (s->op->type & KW_EXACT) {
 			ctx->ctype.base_type = s->ctype.base_type;
 			ctx->ctype.modifiers |= s->ctype.modifiers;
@@ -1791,7 +1729,7 @@ static struct token *handle_attributes(struct token *token, struct decl_state *c
 			break;
 		if (!(keyword->op->type & keywords))
 			break;
-		token = keyword->op->declarator(token->next, ctx);
+		token = keyword->op->declarator(token->next, keyword, ctx);
 		keywords &= KW_ATTRIBUTE;
 	}
 	return token;
@@ -2157,7 +2095,7 @@ static struct token *parse_asm_statement(struct token *token, struct statement *
 	return expect(token, ';', "at end of asm-statement");
 }
 
-static struct token *parse_asm_declarator(struct token *token, struct decl_state *ctx)
+static struct token *parse_asm_declarator(struct token *token, struct symbol *sym, struct decl_state *ctx)
 {
 	struct expression *expr;
 	token = expect(token, '(', "after asm");
diff --git a/symbol.h b/symbol.h
index d2ca3d2ded0e..657a6e0fb354 100644
--- a/symbol.h
+++ b/symbol.h
@@ -126,7 +126,7 @@ struct symbol_op {
 	struct pseudo *(*linearize)(struct entrypoint *, struct expression *);
 
 	/* keywords */
-	struct token *(*declarator)(struct token *token, struct decl_state *ctx);
+	struct token *(*declarator)(struct token *token, struct symbol *, struct decl_state *ctx);
 	struct token *(*statement)(struct token *token, struct statement *stmt);
 	struct token *(*toplevel)(struct token *token, struct symbol_list **list);
 	struct token *(*attribute)(struct token *token, struct symbol *attr, struct decl_state *ctx);
-- 
2.28.0

