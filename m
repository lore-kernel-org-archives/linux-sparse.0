Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWYFOG3o"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE86E3251
	for <linux-sparse@vger.kernel.org>; Fri,  8 Dec 2023 01:49:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332c0c32d19so2250450f8f.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2023 01:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702028979; x=1702633779; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsDFTWmgROVyZ8+wguvsGMplHjG7hkxcbhAtNR+Ddx4=;
        b=UWYFOG3oZMVQ8BNE/HVscVGmlEHm0Z/+P+7+iXpoPUC3ZtJO5OdvAXaPO1uL/tKO8S
         f+9+QOnyxidxxVo0+4pm6KkdFjsmLhcwcSISGFrV3AiXB/kUyuMJ0f6Ae+e0apVWNz3R
         BvNIimugimejWWb95X2McZU49jfVn5Omoz5DgMdai+Vd21TyXrocrC3A9SLbGZ6B3OKI
         R/ird0GxWuX0vWyycxXuU2LSEOqYYSXsA1jhRJhSGWLtNGSutsZzuTjEVGOF4/vHefmP
         cNr9Ogd7zAapO/HVkxJaB+Npt0eAne7/uR7LRnC+q8MaARQbVhXkhoUXSSXKH/oJrLgx
         e2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702028979; x=1702633779;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsDFTWmgROVyZ8+wguvsGMplHjG7hkxcbhAtNR+Ddx4=;
        b=IQDI8UCRa/MVGtW/taUN+iQdni9UzyHb3yOLG6O6iMJAxcva0lKK1uOcO7g0VY8sbX
         FT2+tt+L623xHq8h9VBoq/yD0JjoKkUsy2i8VeUbnpeaTsrJqVlXaE3vKP3uEmq65HDm
         EJtfiOOVBvAk9Z2DgZxqYPvOdS3+0AUpWlWmHwsB5Mo1K3wOvMC1RgYmUzOcmnAoD9ea
         6Uf8T1ZYLQltIrk87CLPZxmQXf3chu8MMMOnXu+5XHoUkg/id2quKJrWHruFrZFFj4Wb
         jgG9kkcikMXfT3p4ZHb28Tgd1xPHlqBVs1WlsHw+eVuQFww7pY0nmV4l0CIDMrJE19BU
         vnkg==
X-Gm-Message-State: AOJu0Yyu/ElzAQpavwBlrJFJKu/TqB4rGgvzCVgf3XXsoKTEYvpPHWbA
	VuJKUWVQWt53flsOsO9JZzTQ5ha/M6jEWXOKPho=
X-Google-Smtp-Source: AGHT+IE2z0hPh/iAw/reMr28ag7VN7lzDks8EV4C43GuxVFyVY0oEUmR4BhtcK2+HqV6SmwGIko/yQ==
X-Received: by 2002:a7b:c3d3:0:b0:40c:357e:273 with SMTP id t19-20020a7bc3d3000000b0040c357e0273mr183802wmj.142.1702028978722;
        Fri, 08 Dec 2023 01:49:38 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j16-20020a5d5650000000b0033344e2522dsm1633451wrw.37.2023.12.08.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:49:38 -0800 (PST)
Date: Fri, 8 Dec 2023 12:49:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The kernel has recently started using the __cleanup__ attribute.  Save
a pointer to cleanup function.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2:  The first version of this patch had a bug handling a list of
     declarations.  I had to add a .cleanup = NULL at the start of
     the loops iterations in declaration_list() and
     external_declaration().

 parse.c  | 26 +++++++++++++++++++++++++-
 symbol.h |  2 ++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/parse.c b/parse.c
index 3d6fef7cb011..e5b5e6acc062 100644
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
@@ -1899,6 +1917,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 	saved = ctx.ctype;
 	for (;;) {
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
+		ctx.cleanup = NULL;
 		ctx.ident = &decl->ident;
 
 		token = declarator(token, &ctx);
@@ -1910,6 +1929,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
+		decl->cleanup = ctx.cleanup;
 		decl->endpos = token->pos;
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
@@ -1964,6 +1984,7 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
+	sym->cleanup = ctx.cleanup;
 	sym->endpos = token->pos;
 	class = ctx.storage_class;
 	if (forced)
@@ -2924,6 +2945,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	decl->ctype = ctx.ctype;
 	decl->ctype.modifiers |= mod;
+	decl->cleanup = ctx.cleanup;
 	decl->endpos = token->pos;
 
 	/* Just a type declaration? */
@@ -3041,6 +3063,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		ident = NULL;
 		decl = alloc_symbol(token->pos, SYM_NODE);
 		ctx.ctype = saved;
+		ctx.cleanup = NULL;
 		token = handle_attributes(token, &ctx);
 		token = declarator(token, &ctx);
 		token = handle_asm_name(token, &ctx);
@@ -3048,6 +3071,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
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
2.42.0

