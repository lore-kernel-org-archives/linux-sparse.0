From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] attribute: '__tls' is just another 'declaration' modifier
Date: Tue, 19 May 2020 01:42:05 +0200
Message-ID: <20200518234207.84150-2-luc.vanoostenryck@gmail.com>
References: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXmP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 19:42:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A34C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so1387681wmd.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:14 -0700 (PDT)
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
 parse.c  | 6 +++---
 symbol.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/parse.c b/parse.c
index 9e7b74f98638..81b2116fcf8b 100644
--- a/parse.c
+++ b/parse.c
@@ -1400,14 +1400,14 @@ static unsigned long decl_modifiers(struct decl_state *ctx)
 	unsigned long mods = ctx->ctype.modifiers & MOD_DECLARE;
 	ctx->ctype.modifiers &= ~MOD_DECLARE;
 	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0)
-		| (ctx->is_tls ? MOD_TLS : 0)
 		| (ctx->is_ext_visible ? MOD_EXT_VISIBLE : 0) | mods;
 }
 
 static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
 {
+	int is_tls = ctx->ctype.modifiers & MOD_TLS;
 	/* __thread can be used alone, or with extern or static */
-	if (ctx->is_tls && (class != SStatic && class != SExtern)) {
+	if (is_tls && (class != SStatic && class != SExtern)) {
 		sparse_error(*pos, "__thread can only be used alone, or with "
 				"extern or static");
 		return;
@@ -1458,7 +1458,7 @@ static struct token *thread_specifier(struct token *next, struct decl_state *ctx
 	/* This GCC extension can be used alone, or with extern or static */
 	if (!ctx->storage_class || ctx->storage_class == SStatic
 			|| ctx->storage_class == SExtern) {
-		ctx->is_tls = 1;
+		apply_qualifier(&next->pos, &ctx->ctype, MOD_TLS);
 	} else {
 		sparse_error(next->pos, "__thread can only be used alone, or "
 				"with extern or static");
diff --git a/symbol.h b/symbol.h
index 7241f13df4e4..95f90a5c33be 100644
--- a/symbol.h
+++ b/symbol.h
@@ -108,7 +108,7 @@ struct decl_state {
 	struct ident **ident;
 	struct symbol_op *mode;
 	unsigned long f_modifiers;		// function attributes
-	unsigned char prefer_abstract, is_inline, storage_class, is_tls;
+	unsigned char prefer_abstract, is_inline, storage_class;
 	unsigned char is_ext_visible;
 	unsigned char autotype;
 };
@@ -264,7 +264,7 @@ struct symbol {
 /* do not warn when these are duplicated */
 #define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE)
 /* must be part of the declared symbol, not its type */
-#define MOD_DECLARE	(MOD_STORAGE|MOD_GNU_INLINE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
+#define MOD_DECLARE	(MOD_STORAGE|MOD_TLS|MOD_GNU_INLINE|MOD_UNUSED|MOD_PURE|MOD_NORETURN|MOD_EXT_VISIBLE)
 
 
 
-- 
2.26.2
