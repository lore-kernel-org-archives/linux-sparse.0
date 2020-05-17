From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/6] attribute: separate modifiers into type/declaration
Date: Mon, 18 May 2020 01:31:21 +0200
Message-ID: <20200517233122.1872-6-luc.vanoostenryck@gmail.com>
References: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgEQXbc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 May 2020 19:31:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFD0C061A0C
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so9705803wrt.9
        for <linux-sparse@vger.kernel.org>; Sun, 17 May 2020 16:31:32 -0700 (PDT)
In-Reply-To: <20200517233122.1872-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When parsing a declaration, type specifiers, qualifiers and other
modifiers are handled by declaration_specifiers(). Some of these
are part of the type being declared but some others only concern
the object in itself. For example, the storage specifiers pertains
to the objects being declared but not their type. Because of this
the storage specifiers need to be processed separately in order to
be correctly applied to the object node. This is done via the helper:
storage_modifier().

However, some attributes are exactly in the same situation (an
obvious example is something like the section attribute).
These attributes should also be moved to the declaration and it's
only because they are currently ignored/without effect that they're
not causing problem in the type.

So generalize storage_modifiers() into decl_modifiers() to extract
all modifiers not pertaining to the type of the declared object.

The modifiers currently concerned are the attributes:
  - unused
  - pure
  - noreturn
  - externally_visible

Note: currently this change shouldn't have any effects other
      than not showing anymore the "[unused]" when displaying
      the type differences in diagnostics.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 14 ++++++++------
 symbol.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/parse.c b/parse.c
index 281140bf2ee4..96e6fda59663 100644
--- a/parse.c
+++ b/parse.c
@@ -1386,7 +1386,7 @@ static const char *storage_class[] =
 	[SForced] = "[force]"
 };
 
-static unsigned long storage_modifiers(struct decl_state *ctx)
+static unsigned long decl_modifiers(struct decl_state *ctx)
 {
 	static unsigned long mod[SMax] =
 	{
@@ -1395,9 +1395,11 @@ static unsigned long storage_modifiers(struct decl_state *ctx)
 		[SStatic] = MOD_STATIC,
 		[SRegister] = MOD_REGISTER
 	};
+	unsigned long mods = ctx->ctype.modifiers & MOD_DECLARE;
+	ctx->ctype.modifiers &= ~MOD_DECLARE;
 	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0)
 		| (ctx->is_tls ? MOD_TLS : 0)
-		| (ctx->is_ext_visible ? MOD_EXT_VISIBLE : 0);
+		| (ctx->is_ext_visible ? MOD_EXT_VISIBLE : 0) | mods;
 }
 
 static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
@@ -1674,7 +1676,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 			}
 		}
 		token = token->next;
-		if (s->op->declarator)
+		if (s->op->declarator)	// Note: this eats attributes
 			token = s->op->declarator(token, ctx);
 		if (s->op->type & KW_EXACT) {
 			ctx->ctype.base_type = s->ctype.base_type;
@@ -2001,7 +2003,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 	unsigned long mod;
 
 	token = declaration_specifiers(token, &ctx);
-	mod = storage_modifiers(&ctx);
+	mod = decl_modifiers(&ctx);
 	saved = ctx.ctype;
 	for (;;) {
 		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
@@ -2054,7 +2056,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
-	sym->ctype.modifiers |= storage_modifiers(&ctx);
+	sym->ctype.modifiers |= decl_modifiers(&ctx);
 	sym->endpos = token->pos;
 	sym->forced_arg = ctx.storage_class == SForced;
 	return token;
@@ -2957,7 +2959,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctx);
-	mod = storage_modifiers(&ctx);
+	mod = decl_modifiers(&ctx);
 	decl = alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
diff --git a/symbol.h b/symbol.h
index b594eb36ced0..4bce78d55e54 100644
--- a/symbol.h
+++ b/symbol.h
@@ -263,6 +263,9 @@ struct symbol {
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
 /* do not warn when these are duplicated */
 #define MOD_DUP_OK	(MOD_UNUSED)
+/* must be part of the declared symbol, not its type */
+#define MOD_DECLARE	(MOD_STORAGE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
+
 
 
 /* Current parsing/evaluation function */
-- 
2.26.2
