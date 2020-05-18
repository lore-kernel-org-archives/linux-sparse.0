From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] attribute: 'externally_visible' is just another 'declaration' modifier
Date: Tue, 19 May 2020 01:42:07 +0200
Message-ID: <20200518234207.84150-4-luc.vanoostenryck@gmail.com>
References: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgERXmR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 19:42:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7951C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n18so1349313wmj.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 16:42:16 -0700 (PDT)
In-Reply-To: <20200518234207.84150-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Now that the distinction is made between type modifiers and
'declaration' modifiers, there is no more reasons to parse
this attribute differently than other attributes/modifiers.
Even more so because this special casing made this attribute
to be ignored when placed after the declarator.

So, use the the generic code for 'declaration modifiers'
to parse this attribute.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                    | 18 +++---------------
 symbol.h                   |  1 -
 validation/attr-visible.c  |  1 -
 validation/attr-visible2.c |  1 -
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/parse.c b/parse.c
index 8e4be227cec1..c1a72ae250d3 100644
--- a/parse.c
+++ b/parse.c
@@ -84,7 +84,6 @@ typedef struct token *attr_t(struct token *, struct symbol *,
 static attr_t
 	attribute_packed, attribute_aligned, attribute_modifier,
 	attribute_function,
-	attribute_ext_visible,
 	attribute_bitwise,
 	attribute_address_space, attribute_context,
 	attribute_designated_init,
@@ -389,10 +388,6 @@ static struct symbol_op attr_fun_op = {
 	.attribute = attribute_function,
 };
 
-static struct symbol_op ext_visible_op = {
-	.attribute = attribute_ext_visible,
-};
-
 static struct symbol_op attr_bitwise_op = {
 	.attribute = attribute_bitwise,
 };
@@ -573,6 +568,8 @@ static struct init_keyword {
 	{ "__safe__",	NS_KEYWORD,	MOD_SAFE, 	.op = &attr_mod_op },
 	{ "unused",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
 	{ "__unused__",	NS_KEYWORD,	MOD_UNUSED,	.op = &attr_mod_op },
+	{ "externally_visible",	NS_KEYWORD, MOD_EXT_VISIBLE,.op = &attr_mod_op },
+	{ "__externally_visible__", NS_KEYWORD,MOD_EXT_VISIBLE,.op = &attr_mod_op },
 	{ "force",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "__force__",	NS_KEYWORD,	.op = &attr_force_op },
 	{ "bitwise",	NS_KEYWORD,	MOD_BITWISE,	.op = &attr_bitwise_op },
@@ -592,8 +589,6 @@ static struct init_keyword {
 	{"__const__",	NS_KEYWORD,	MOD_PURE,	.op = &attr_fun_op },
 	{"gnu_inline",	NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
 	{"__gnu_inline__",NS_KEYWORD,	MOD_GNU_INLINE,	.op = &attr_fun_op },
-	{"externally_visible",	NS_KEYWORD,	.op = &ext_visible_op },
-	{"__externally_visible__",	NS_KEYWORD,	.op = &ext_visible_op },
 
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "__mode__",	NS_KEYWORD,	.op = &mode_op },
@@ -1155,12 +1150,6 @@ static struct token *attribute_function(struct token *token, struct symbol *attr
 	return token;
 }
 
-static struct token *attribute_ext_visible(struct token *token, struct symbol *attr, struct decl_state *ctx)
-{
-	ctx->is_ext_visible = 1;
-	return token;
-}
-
 static struct token *attribute_bitwise(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	if (Wbitwise)
@@ -1399,8 +1388,7 @@ static unsigned long decl_modifiers(struct decl_state *ctx)
 	};
 	unsigned long mods = ctx->ctype.modifiers & MOD_DECLARE;
 	ctx->ctype.modifiers &= ~MOD_DECLARE;
-	return mod[ctx->storage_class]
-		| (ctx->is_ext_visible ? MOD_EXT_VISIBLE : 0) | mods;
+	return mod[ctx->storage_class] | mods;
 }
 
 static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
diff --git a/symbol.h b/symbol.h
index 26f92ca79492..92ccbddb2c04 100644
--- a/symbol.h
+++ b/symbol.h
@@ -109,7 +109,6 @@ struct decl_state {
 	struct symbol_op *mode;
 	unsigned long f_modifiers;		// function attributes
 	unsigned char prefer_abstract, storage_class;
-	unsigned char is_ext_visible;
 	unsigned char autotype;
 };
 
diff --git a/validation/attr-visible.c b/validation/attr-visible.c
index 38ee857522ca..ce35e4e53ac8 100644
--- a/validation/attr-visible.c
+++ b/validation/attr-visible.c
@@ -9,5 +9,4 @@ int flag __visible;
 /*
  * check-name: attr-visible
  * check-command: sparse -Wdecl $file
- * check-known-to-fail
  */
diff --git a/validation/attr-visible2.c b/validation/attr-visible2.c
index 62949b479aea..989181692107 100644
--- a/validation/attr-visible2.c
+++ b/validation/attr-visible2.c
@@ -6,5 +6,4 @@ int arr[2] __visible;
 /*
  * check-name: attr-visible-after
  * check-command: sparse -Wdecl $file
- * check-known-to-fail
  */
-- 
2.26.2
