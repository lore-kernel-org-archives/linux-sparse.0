From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: [PATCH] Support the __thread storage class
Date: Sat, 16 May 2009 12:36:58 -0300
Message-ID: <1242488218-19811-1-git-send-email-albertito@blitiri.com.ar>
References: <70318cbf0904270020v78c98b7awee9ef64a6d60e14b@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alerce.vps.bitfolk.com ([212.13.194.134]:3227 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbZEPPko (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 May 2009 11:40:44 -0400
In-Reply-To: <70318cbf0904270020v78c98b7awee9ef64a6d60e14b@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, josh@kernel.org, Alberto Bertogli <albertito@blitiri.com.ar>

GCC supports a __thread storage class, used to indicate thread-local
storage. It may be used alone, or with extern or static.

This patch makes sparse aware of it, and check those restrictions.

Signed-off-by: Alberto Bertogli <albertito@blitiri.com.ar>
---
 parse.c  |   34 +++++++++++++++++++++++++++++++---
 symbol.h |    3 ++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/parse.c b/parse.c
index 14ae25d..ed79538 100644
--- a/parse.c
+++ b/parse.c
@@ -41,7 +41,7 @@ static declarator_t
 	attribute_specifier, typeof_specifier, parse_asm_declarator,
 	typedef_specifier, inline_specifier, auto_specifier,
 	register_specifier, static_specifier, extern_specifier,
-	const_qualifier, volatile_qualifier;
+	thread_specifier, const_qualifier, volatile_qualifier;
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -125,6 +125,11 @@ static struct symbol_op extern_op = {
 	.declarator = extern_specifier,
 };
 
+static struct symbol_op thread_op = {
+	.type = KW_MODIFIER,
+	.declarator = thread_specifier,
+};
+
 static struct symbol_op const_op = {
 	.type = KW_QUALIFIER,
 	.declarator = const_qualifier,
@@ -407,6 +412,7 @@ static struct init_keyword {
 	{ "register",	NS_TYPEDEF, .op = &register_op },
 	{ "static",	NS_TYPEDEF, .op = &static_op },
 	{ "extern",	NS_TYPEDEF, .op = &extern_op },
+	{ "__thread",	NS_TYPEDEF, .op = &thread_op },
 
 	/* Statement */
 	{ "if",		NS_KEYWORD, .op = &if_op },
@@ -1165,11 +1171,19 @@ static unsigned long storage_modifiers(struct decl_state *ctx)
 		[SStatic] = MOD_STATIC,
 		[SRegister] = MOD_REGISTER
 	};
-	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0);
+	return mod[ctx->storage_class] | (ctx->is_inline ? MOD_INLINE : 0)
+		| (ctx->is_tls ? MOD_TLS : 0);
 }
 
 static void set_storage_class(struct position *pos, struct decl_state *ctx, int class)
 {
+	/* __thread can be used alone, or with extern or static */
+	if (ctx->is_tls && (class != SStatic && class != SExtern)) {
+		sparse_error(*pos, "__thread can only be used alone, or with "
+				"extern or static");
+		return;
+	}
+
 	if (!ctx->storage_class) {
 		ctx->storage_class = class;
 		return;
@@ -1210,6 +1224,20 @@ static struct token *extern_specifier(struct token *next, struct decl_state *ctx
 	return next;
 }
 
+static struct token *thread_specifier(struct token *next, struct decl_state *ctx)
+{
+	/* This GCC extension can be used alone, or with extern or static */
+	if (!ctx->storage_class || ctx->storage_class == SStatic
+			|| ctx->storage_class == SExtern) {
+		ctx->is_tls = 1;
+	} else {
+		sparse_error(next->pos, "__thread can only be used alone, or "
+				"with extern or static");
+	}
+
+	return next;
+}
+
 static struct token *attribute_force(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	set_storage_class(&token->pos, ctx, SForced);
@@ -1871,7 +1899,7 @@ static struct statement *start_function(struct symbol *sym)
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
 	ret->ctype = sym->ctype.base_type->ctype;
-	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_ACCESSED | MOD_TOPLEVEL);
+	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_ACCESSED | MOD_TOPLEVEL);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
 	bind_symbol(ret, &return_ident, NS_ITERATOR);
 	stmt->ret = ret;
diff --git a/symbol.h b/symbol.h
index da4d64a..751dec1 100644
--- a/symbol.h
+++ b/symbol.h
@@ -93,7 +93,7 @@ struct decl_state {
 	struct ctype ctype;
 	struct ident **ident;
 	struct symbol_op *mode;
-	unsigned char prefer_abstract, is_inline, storage_class;
+	unsigned char prefer_abstract, is_inline, storage_class, is_tls;
 };
 
 struct symbol_op {
@@ -199,6 +199,7 @@ struct symbol {
 
 #define MOD_TYPEDEF	0x1000
 
+#define MOD_TLS		0x20000
 #define MOD_INLINE	0x40000
 #define MOD_ADDRESSABLE	0x80000
 
-- 
1.6.2.2.646.gb214

