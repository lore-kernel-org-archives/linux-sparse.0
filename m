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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B8C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221AC206B2
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh/nUC0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgHIQw4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHIQwm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 12:52:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A8C061788
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 09:52:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id f24so7081164ejx.6
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PyGkVLbJYJpNLeBbNSWO81L5q6b6ERJ3bqERVKnsaq4=;
        b=Lh/nUC0yUJBQQb9RqWAaBFA7iY3z2l4/15uGH97MQGVNmzTmTwdk6RZfpfEIS1twtG
         KpsvH7BUuZ+Jv2hcImt50yMLitCqIu9CFCED1yCFChy0oEnsJzjqQ5AjSB+k7kLFinPR
         fa/M0W0q+iiDOrJCWeGuyJjBEGC+q6sGC7tDyem3lSEOGg5xVRj0IhyIuF0jCuLkZ8mV
         f4ljziV6BSNmo6LvIbaRjFcM4yPTz87OGeqo67uuMRaR+TMyeif0g0Zdx3Xzln5IZBlR
         K0JUv2L84Qv+VcocgheliVEqmQa2RGXE3TXOaB5+FF2XgA3oLXq2dTBazoR1uiFPGdpH
         MO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PyGkVLbJYJpNLeBbNSWO81L5q6b6ERJ3bqERVKnsaq4=;
        b=BYuHGrj9Hqy9MbaB8GKIvmJn5OMQ+zYaidLS7JoPf1eKlGAf1OE9Cxve+ocGtb4dyv
         ac9a1qE2tG+XUrtzp5BmgdDBH8t4DixxJok3iI6lQqrmDvHF7fQZJ2gSPtHid1GvDLi3
         yWfVwAuWYfNfLzzdB7Osuj71WTxWBcPu6pzKL5lCMD4OXw0Wy7LuDDwpVQVYbfwALE2T
         +ZGM+madEPgjC5XT828QYttwE3zE4alsMz1yBWMarwKBqXs6Pp0B5WGrwox4iet3ClgF
         D+vfbarY2MiVfEFyNOkeyAmxZR5qK56noQ8WNjPv8G3GwfqldOv38zqJkyYzYEuafjaF
         6gmw==
X-Gm-Message-State: AOAM533GN7cKSdF15ZgnDMvEGYr9IQbh4OM9SREBCxZYvByIMHF3wuxW
        utn7DYjty862HXDx2sg67B5QtGdv
X-Google-Smtp-Source: ABdhPJye1DLXmsILgkTuPc75/zpmuyI/Is1ejFOz6LGy5LlF54f7ZQIb+dOYT8wkj7O/1/vn1TrkCw==
X-Received: by 2002:a17:906:7e0b:: with SMTP id e11mr17108716ejr.540.1596991959325;
        Sun, 09 Aug 2020 09:52:39 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:79f2:f43a:7be8:9ec8])
        by smtp.gmail.com with ESMTPSA id j11sm10810427ejx.0.2020.08.09.09.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:52:38 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] parse: rework handling of storage_class
Date:   Sun,  9 Aug 2020 18:52:25 +0200
Message-Id: <20200809165229.36677-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
References: <20200809165229.36677-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The handling of the storage class modifiers is done
differently than the other modifiers:
* they don't use MOD_... but their own enums
* consequently they can't use modifier_string() and have
  their own string table to display them.
* the attribute 'force' is considered as a kind of storage
  class. Fine, but it means that 'register' or '__tls' can't
  be used with 'force' (which is probably very fine but
  seems more as a side-effect than something really desired).

The real justification for these difference seems to be
that storage class modifiers *must* be treated differently
than the other modifiers because they don't apply at the same
level. For example, in a declaration like:
	static const int a[N];
'static' applies to the array/the whole object, while 'const'
only applies to the (type of the) elements of the array.

Storage class specifiers must thus be parsed, stored aside
and only be applied after the whole declarator have been parsed.
But other modifiers are also in the same situation (for example,
'__noreturn' or '__pure' for functions).

So, use the generic keyword/attribute handling of modifiers
for storage class specifiers but for simplicity, store them
separately in decl_state to easily do duplication tests on them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 71 ++++++++++++++++++--------------------------------------
 symbol.h |  4 +++-
 2 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/parse.c b/parse.c
index cc46f1a6c5a6..2711022aba69 100644
--- a/parse.c
+++ b/parse.c
@@ -116,10 +116,6 @@ enum {
 	CInt = 0, CSInt, CUInt, CReal,
 };
 
-enum {
-	SNone = 0, STypedef, SAuto, SRegister, SExtern, SStatic, SForced, SMax,
-};
-
 static void asm_modifier(struct token *token, unsigned long *mods, unsigned long mod)
 {
 	if (*mods & mod)
@@ -1389,85 +1385,67 @@ static struct token *attribute_specifier(struct token *token, struct decl_state
 	return token;
 }
 
-static const char *storage_class[] = 
-{
-	[STypedef] = "typedef",
-	[SAuto] = "auto",
-	[SExtern] = "extern",
-	[SStatic] = "static",
-	[SRegister] = "register",
-	[SForced] = "[force]"
-};
-
 static unsigned long decl_modifiers(struct decl_state *ctx)
 {
-	static unsigned long mod[SMax] =
-	{
-		[SAuto] = MOD_AUTO,
-		[SExtern] = MOD_EXTERN,
-		[SStatic] = MOD_STATIC,
-		[SRegister] = MOD_REGISTER
-	};
 	unsigned long mods = ctx->ctype.modifiers & MOD_DECLARE;
 	ctx->ctype.modifiers &= ~MOD_DECLARE;
-	return mod[ctx->storage_class] | mods;
+	return ctx->storage_class | mods;
 }
 
-static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
+static void set_storage_class(struct position *pos, struct decl_state *ctx, unsigned long class)
 {
 	int is_tls = ctx->ctype.modifiers & MOD_TLS;
+	const char *storage = modifier_string(class);
+
 	/* __thread can be used alone, or with extern or static */
-	if (is_tls && (class != SStatic && class != SExtern)) {
+	if (is_tls && (class & ~(MOD_STATIC|MOD_EXTERN))) {
 		sparse_error(*pos, "__thread can only be used alone, or with "
 				"extern or static");
 		return;
 	}
 
-	if (!ctx->storage_class) {
+	if (!ctx->storage_class)
 		ctx->storage_class = class;
-		return;
-	}
-	if (ctx->storage_class == class)
-		sparse_error(*pos, "duplicate %s", storage_class[class]);
+	else if (ctx->storage_class == class)
+		sparse_error(*pos, "duplicate %s", storage);
 	else
 		sparse_error(*pos, "multiple storage classes");
 }
 
 static struct token *typedef_specifier(struct token *next, struct decl_state *ctx)
 {
-	set_storage_class(&next->pos, ctx, STypedef);
+	set_storage_class(&next->pos, ctx, MOD_USERTYPE);
 	return next;
 }
 
 static struct token *auto_specifier(struct token *next, struct decl_state *ctx)
 {
-	set_storage_class(&next->pos, ctx, SAuto);
+	set_storage_class(&next->pos, ctx, MOD_AUTO);
 	return next;
 }
 
 static struct token *register_specifier(struct token *next, struct decl_state *ctx)
 {
-	set_storage_class(&next->pos, ctx, SRegister);
+	set_storage_class(&next->pos, ctx, MOD_REGISTER);
 	return next;
 }
 
 static struct token *static_specifier(struct token *next, struct decl_state *ctx)
 {
-	set_storage_class(&next->pos, ctx, SStatic);
+	set_storage_class(&next->pos, ctx, MOD_STATIC);
 	return next;
 }
 
 static struct token *extern_specifier(struct token *next, struct decl_state *ctx)
 {
-	set_storage_class(&next->pos, ctx, SExtern);
+	set_storage_class(&next->pos, ctx, MOD_EXTERN);
 	return next;
 }
 
 static struct token *thread_specifier(struct token *next, struct decl_state *ctx)
 {
 	/* This GCC extension can be used alone, or with extern or static */
-	if (!ctx->storage_class || ctx->storage_class == SStatic
-			|| ctx->storage_class == SExtern) {
+	if (!(ctx->storage_class & ~(MOD_STATIC|MOD_EXTERN))) {
 		apply_qualifier(&next->pos, &ctx->ctype, MOD_TLS);
 	} else {
 		sparse_error(next->pos, "__thread can only be used alone, or "
@@ -1479,7 +1457,7 @@ static struct token *thread_specifier(struct token *next, struct decl_state *ctx
 
 static struct token *attribute_force(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	set_storage_class(&token->pos, ctx, SForced);
+	ctx->forced = 1;
 	return token;
 }
 
@@ -2070,14 +2048,14 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	sym->ctype = ctx.ctype;
 	sym->ctype.modifiers |= decl_modifiers(&ctx);
 	sym->endpos = token->pos;
-	sym->forced_arg = ctx.storage_class == SForced;
+	sym->forced_arg = ctx.forced;
 	return token;
 }
 
 struct token *typename(struct token *token, struct symbol **p, int *forced)
 {
 	struct decl_state ctx = {.prefer_abstract = 1};
-	int class;
+	unsigned long class;
 	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &ctx);
@@ -2086,16 +2064,11 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
 	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
 	class = ctx.storage_class;
-	if (forced) {
-		*forced = 0;
-		if (class == SForced) {
-			*forced = 1;
-			class = 0;
-		}
-	}
+	if (forced)
+		*forced = ctx.forced;
 	if (class)
-		warning(sym->pos, "storage class in typename (%s %s)",
-			storage_class[class], show_typename(sym));
+		warning(sym->pos, "storage class in typename (%s%s)",
+			modifier_string(class), show_typename(sym));
 	return token;
 }
 
@@ -3048,7 +3021,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	}
 
 	/* type define declaration? */
-	is_typedef = ctx.storage_class == STypedef;
+	is_typedef = ctx.storage_class == MOD_USERTYPE;
 
 	/* Typedefs don't have meaningful storage */
 	if (is_typedef)
diff --git a/symbol.h b/symbol.h
index 4792b008efe3..d2ca3d2ded0e 100644
--- a/symbol.h
+++ b/symbol.h
@@ -108,8 +108,10 @@ struct decl_state {
 	struct ident **ident;
 	struct symbol_op *mode;
 	unsigned long f_modifiers;		// function attributes
-	unsigned char prefer_abstract, storage_class;
+	unsigned long storage_class;
+	unsigned char prefer_abstract;
 	unsigned char autotype;
+	unsigned char forced;
 };
 
 struct pseudo;
-- 
2.28.0

