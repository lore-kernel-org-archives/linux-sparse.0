From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] attribute: 'inline' is just another 'declaration' modifier
Date: Tue, 19 May 2020 01:42:06 +0200
Message-ID: <20200518234207.84150-3-luc.vanoostenryck@gmail.com>
References: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXmQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 19:42:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE68BC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z72so1367922wmc.2
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:15 -0700 (PDT)
In-Reply-To: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that the distinction is made between type modifiers and
'declaration' modifiers, there is no more reasons to parse
this attribute differently than other attributes/modifiers.

So, use the the generic code for 'declaration modifiers'
to parse this attribute.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 4 ++--
 symbol.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 81b2116fcf8b..8e4be227cec1 100644
--- a/parse.c
+++ b/parse.c
@@ -1399,7 +1399,7 @@ static unsigned long decl_modifiers(struct decl_state *ctx)
 	};
 	unsigned long mods = ctx->ctype.modifiers & MOD_DECLARE;
 	ctx->ctype.modifiers &= ~MOD_DECLARE;
-	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0)
+	return mod[ctx->storage_class]
 		| (ctx->is_ext_visible ? MOD_EXT_VISIBLE : 0) | mods;
 }
 
@@ -1475,7 +1475,7 @@ static struct token *attribute_force(struct token *token, struct symbol *attr, s
 
 static struct token *inline_specifier(struct token *next, struct decl_state *ctx)
 {
-	ctx->is_inline = 1;
+	apply_qualifier(&next->pos, &ctx->ctype, MOD_INLINE);
 	return next;
 }
 
diff --git a/symbol.h b/symbol.h
index 95f90a5c33be..26f92ca79492 100644
--- a/symbol.h
+++ b/symbol.h
@@ -108,7 +108,7 @@ struct decl_state {
 	struct ident **ident;
 	struct symbol_op *mode;
 	unsigned long f_modifiers;		// function attributes
-	unsigned char prefer_abstract, is_inline, storage_class;
+	unsigned char prefer_abstract, storage_class;
 	unsigned char is_ext_visible;
 	unsigned char autotype;
 };
@@ -264,7 +264,7 @@ struct symbol {
 /* do not warn when these are duplicated */
 #define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE)
 /* must be part of the declared symbol, not its type */
-#define MOD_DECLARE	(MOD_STORAGE|MOD_TLS|MOD_GNU_INLINE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
+#define MOD_DECLARE	(MOD_STORAGE|MOD_INLINE|MOD_TLS|MOD_GNU_INLINE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
 
 
 
-- 
2.26.2
