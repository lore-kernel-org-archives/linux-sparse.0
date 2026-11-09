Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256436;
	b=NnV7K5IOB2w/3Qe/9Zw+ee/Iet4yYQOj1a5Op5ugMbyfatK61ZM9PKYwQ8i/usF1jbek
	 v/bvehPp5Ims8RKJwz2yh9JjXtuMlCfLbNrqaDjxCf2bZ+I/8iSSbRlg0lqfPDJE/5ilY
	 GSL7NYeUKp8hQ8yWxes1vAan7fY/B4l3VRqiOexsy/4Uf1FOsjcmTDTqXafilACouA9Ou
	 zJzo1HRORtjC94PNcDTgAHYt9O4Z5xmrVT4CGjlHu9ZZzIT30UoJAAeDpLcKqYntrhiOK
	 yu//H2L4J6HBsBOFUUoIGB3bpq0IAY+Fo71oYEXfPVD3YvWx6FYuoXG0ngZ1bAhGoCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=BcGfm8YLnNtKzYtUmkmmKp74W4S9IVIEPuwqyQxUzbg=;
	b=F3R95dkZFKCagrBFthVkWNi8+POj7l6gwhOdQpm2uqlO70aFQ9YJRKZsDamQe2ymx3FF
	 hNLb95yeoli9J4MqnuEdyH9BA1V3tv5RPvu+18AwO1BgwSoaUVL4wbaj1yzv152pFiNEl
	 mmKGrSl/Vm2VPDBzw7q1u2YcEbT6k040tAynGncte+borI2RSIXW/pM5/zQzoHRshQDU2
	 rP6qVrjMfDgzDHwzWlBVX2eDK4zi5ii0dnA2x1cbacYLIbv/L2KhZp5xgZ0KO8k7yDsnl
	 pP/xMgAdHyRsfEMAQWps4Hm05ieDNmzSXzUQxSNPVHrHw2QOS3+d4+NKVkCWjVlOViw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=vEfv5Rj3;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B4606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 561B4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=vEfv5Rj3
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMH4XXfz1XMG4F;
	Mon,  9 Nov 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=BcGfm
	8YLnNtKzYtUmkmmKp74W4S9IVIEPuwqyQxUzbg=; b=vEfv5Rj3rB5A/hQ32SJrO
	iNxJqtAQfzJ1DnLy8rolArSELMKBD4VRLRtj2LD4u5Psuze1XvnLT5+8BTgEaql0
	p6K9+CxPwtn0NUxIodzzBYro2nk4LI9U/QObqIcE7vHfweZHAv28pRgNMR49Ux7B
	pEHZ/Gsb++qhjbAFyD6gjf+gsLD9zt79x+0MLbYqE+EWKAR0y9pI8042YmceK8SQ
	WP3RVOkj14r62IpL7jirPvTYt/vYbHbh5FUGigzq3e78XZpYtRTJrDnK1xkzfBPQ
	4dlEo1GuLk35dRuUjk6TOpFmHrNUNE3a5SXFtDtJ8vpoXf59hg+RfSt5XmrUAc+F
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2Zh0IvECrHqq; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM31Rlxz1XMYJf;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 49/73] c23: Support auto type inference
Date: Mon,  9 Nov 2026 12:32:35 -0800
Message-ID: <20261109203259.362845-50-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109203259.362845-1-bvanassche@acm.org>
References: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ISO C23 'auto' type inference when 'auto' appears without a type
specifier, while preserving 'auto' as a block-scope storage-class
specifier when combined with an explicit type:
- Infer the variable type from its assignment-expression initializer
  after array-to-pointer, function-to-pointer, and lvalue conversion so
  top-level qualifiers and _Atomic are stripped per C23 6.7.10p2.
- Bind C23 'auto' symbols before parsing their initializers and mark
  them underspecified during initializer parsing and evaluation so
  self-references are diagnosed per C23 6.2.1p7.
- Diagnose underspecified redeclarations in the same scope per C23
  6.7p12, braced initializers, typedefs, empty declarations, type names,
  parameters, struct/union members, and file-scope 'auto' specifiers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                  |  14 +++-
 parse.c                     | 129 +++++++++++++++++++++++++++++++++---
 symbol.c                    |  59 ++++++++++++++++-
 symbol.h                    |   3 +
 validation/c23-auto-error.c |  68 +++++++++++++++++++
 validation/c23-auto.c       | 107 ++++++++++++++++++++++++++++++
 6 files changed, 365 insertions(+), 15 deletions(-)
 create mode 100644 validation/c23-auto-error.c
 create mode 100644 validation/c23-auto.c

diff --git a/evaluate.c b/evaluate.c
index c0d039105881..1b1a72577d18 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -87,6 +87,12 @@ static struct symbol *evaluate_symbol_expression(struc=
t expression *expr)
 		expression_error(expr, "undefined identifier '%s'", show_ident(expr->s=
ymbol_name));
 		return NULL;
 	}
+	if (sym->underspecified) {
+		expression_error(expr,
+				 "underspecified symbol '%s' used in its own initializer",
+				 show_ident(sym->ident));
+		return NULL;
+	}
=20
 	examine_symbol_type(sym);
=20
@@ -3853,8 +3859,14 @@ static struct symbol *evaluate_symbol(struct symbo=
l *sym)
 		return NULL;
=20
 	/* Evaluate the initializers */
-	if (sym->initializer)
+	if (sym->initializer) {
+		bool mark_underspec =3D sym->c23_auto;
+		if (mark_underspec)
+			sym->underspecified =3D 1;
 		evaluate_initializer(sym, &sym->initializer);
+		if (mark_underspec)
+			sym->underspecified =3D 0;
+	}
=20
 	/* And finally, evaluate the body of the symbol too */
 	if (base_type->type =3D=3D SYM_FN) {
diff --git a/parse.c b/parse.c
index 1e91825f8d38..324da8e40423 100644
--- a/parse.c
+++ b/parse.c
@@ -57,7 +57,7 @@ static declarator_t
 	attribute_specifier, typeof_specifier, typeof_unqual_specifier,
 	storage_specifier, thread_specifier;
 static declarator_t generic_qualifier;
-static declarator_t autotype_specifier;
+static declarator_t autotype_specifier, auto_specifier;
=20
 static struct token *parse_if_statement(struct token *token, struct stat=
ement *stmt);
 static struct token *parse_return_statement(struct token *token, struct =
statement *stmt);
@@ -143,7 +143,7 @@ static struct symbol_op alignas_op =3D {
=20
 static struct symbol_op auto_op =3D {
 	.type =3D KW_MODIFIER,
-	.declarator =3D storage_specifier,
+	.declarator =3D auto_specifier,
 };
=20
 static struct symbol_op register_op =3D {
@@ -472,7 +472,7 @@ static struct init_keyword {
 #define U(I, O,...)	N("__" I,O,##__VA_ARGS__),	\
 			N("__" I "__",O,##__VA_ARGS__)
 	/* Storage classes */
-	N("auto",		&auto_op,	.mods =3D MOD_AUTO),
+	N("auto",		&auto_op),
 	N("register",		&register_op,	.mods =3D MOD_REGISTER),
 	N("static",		&static_op,	.mods =3D MOD_STATIC),
 	N("extern",		&extern_op,	.mods =3D MOD_EXTERN),
@@ -1202,6 +1202,15 @@ static struct token *autotype_specifier(struct tok=
en *token, struct symbol *sym,
 	return token;
 }
=20
+static struct token *auto_specifier(struct token *token, struct symbol *=
sym,
+				    struct decl_state *ctx)
+{
+	if (ctx->has_auto)
+		sparse_error(token->pos, "duplicate auto");
+	ctx->has_auto =3D 1;
+	return token;
+}
+
 static struct token *ignore_attribute(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
 	struct expression *expr =3D NULL;
@@ -1732,6 +1741,23 @@ static struct token *declaration_specifiers(struct=
 token *token, struct decl_sta
 		}
 	}
=20
+	if (ctx->has_auto) {
+		if (seen & (Set_S | Set_Any)) {
+			if (ctx->storage_class)
+				sparse_error(token->pos,
+					     "multiple storage classes");
+			else
+				ctx->storage_class =3D MOD_AUTO;
+		} else {
+			if (standard < STANDARD_C23 && Wpedantic)
+				warning(token->pos,
+					"'auto' type inference is a C23 feature");
+			ctx->ctype.base_type =3D &autotype_ctype;
+			ctx->autotype =3D 1;
+			seen |=3D Set_S;
+		}
+	}
+
 	if (!(seen & Set_S)) {	/* not set explicitly? */
 		struct symbol *base =3D &incomplete_ctype;
 		if (seen & Set_Any)
@@ -2085,6 +2111,14 @@ static struct token *declaration_list(struct token=
 *token, struct symbol_list **
 		decl->ctype.modifiers |=3D mod;
 		decl->cleanup =3D ctx.cleanup;
 		decl->endpos =3D token->pos;
+		if (ctx.has_auto) {
+			sparse_error(
+				decl->pos,
+				"struct or union member '%s' cannot be declared auto",
+				show_ident(decl->ident));
+			if (ctx.autotype)
+				decl->ctype.base_type =3D &bad_ctype;
+		}
 		if (decl->ctype.modifiers & MOD_TLS)
 			sparse_error(
 				decl->pos,
@@ -2136,6 +2170,14 @@ static struct token *parameter_declaration(struct =
token *token, struct symbol *s
 		sparse_error(sym->pos,
 			     "alignment specified for parameter '%s'",
 			     show_ident(sym->ident));
+	if (ctx.has_auto || ctx.autotype) {
+		sparse_error(sym->pos,
+			     "parameter '%s' cannot be declared %s",
+			     show_ident(sym->ident),
+			     ctx.has_auto ? "auto" : "__auto_type");
+		if (ctx.autotype)
+			sym->ctype.base_type =3D &bad_ctype;
+	}
 	if (sym->ctype.modifiers & MOD_TLS)
 		sparse_error(sym->pos,
 			     "parameter '%s' cannot be thread-local",
@@ -2152,6 +2194,11 @@ struct token *typename(struct token *token, struct=
 symbol **p, int *forced)
 	token =3D declaration_specifiers(token, &ctx);
 	if (ctx.has_alignas)
 		sparse_error(sym->pos, "alignment specified for type name");
+	if (ctx.autotype) {
+		sparse_error(sym->pos, "'%s' in type name",
+			     ctx.has_auto ? "auto" : "__auto_type");
+		ctx.ctype.base_type =3D &bad_ctype;
+	}
 	token =3D declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
@@ -3199,6 +3246,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	struct symbol *base_type;
 	unsigned long mod;
 	int is_typedef;
+	bool delay_bind =3D false;
=20
 	/* Top-level inline asm or static assertion? */
 	if (token_type(token) =3D=3D TOKEN_IDENT) {
@@ -3213,6 +3261,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	decl =3D alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
+		if (ctx.autotype)
+			sparse_error(token->pos, "%s in empty declaration",
+				     ctx.has_auto ? "auto" : "__auto_type");
 		apply_modifiers(token->pos, &ctx);
 		return token->next;
 	}
@@ -3226,6 +3277,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	decl->ctype =3D ctx.ctype;
 	decl->ctype.modifiers |=3D mod;
 	decl->cleanup =3D ctx.cleanup;
+	decl->c23_auto =3D ctx.autotype && ctx.has_auto;
 	decl->endpos =3D token->pos;
=20
 	/* Just a type declaration? */
@@ -3241,9 +3293,15 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 	if (is_typedef)
 		decl->ctype.modifiers |=3D MOD_USERTYPE;
=20
-	bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF: NS_SYMBOL);
-
 	base_type =3D decl->ctype.base_type;
+	if (!is_typedef && ctx.autotype && !ctx.has_auto &&
+	    base_type =3D=3D &autotype_ctype) {
+		struct symbol *prev =3D lookup_symbol(ident, NS_SYMBOL | NS_TYPEDEF);
+		if (prev && is_outer_scope(prev->scope))
+			delay_bind =3D true;
+	}
+	if (!delay_bind)
+		bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF: NS_SYMBOL);
=20
 	if (is_typedef) {
 		if (base_type && !base_type->ident) {
@@ -3260,8 +3318,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		}
 	} else if (base_type && base_type->type =3D=3D SYM_FN) {
 		if (base_type->ctype.base_type =3D=3D &autotype_ctype) {
-			sparse_error(decl->pos, "'%s()' has __auto_type return type",
-				show_ident(decl->ident));
+			sparse_error(decl->pos, "'%s()' has %s return type",
+				     show_ident(decl->ident),
+				     ctx.has_auto ? "auto" : "__auto_type");
 			base_type->ctype.base_type =3D &int_ctype;
 		}
 		if (base_type->ctype.base_type =3D=3D &incomplete_ctype) {
@@ -3301,11 +3360,26 @@ struct token *external_declaration(struct token *=
token, struct symbol_list **lis
 	for (;;) {
 		if (!is_typedef && match_op(token, '=3D')) {
 			struct token *next =3D token->next;
+			bool mark_underspec =3D decl->c23_auto;
+			if (mark_underspec)
+				decl->underspecified =3D 1;
 			token =3D initializer(&decl->initializer, next);
+			if (mark_underspec)
+				decl->underspecified =3D 0;
 			if (token =3D=3D next)
 				sparse_error(token->pos, "expression expected before '%s'", show_tok=
en(token));
 		}
+		if (delay_bind) {
+			bind_symbol(decl, ident, is_typedef ? NS_TYPEDEF : NS_SYMBOL);
+			delay_bind =3D false;
+		}
 		if (!is_typedef) {
+			if (!ctx.autotype && (ctx.storage_class & MOD_AUTO) &&
+			    toplevel(block_scope))
+				sparse_error(
+					decl->pos,
+					"file-scope declaration of '%s' specifies 'auto'",
+					show_ident(decl->ident));
 			if (validate_decl)
 				validate_decl(decl);
=20
@@ -3329,19 +3403,51 @@ struct token *external_declaration(struct token *=
token, struct symbol_list **lis
 			}
 		}
=20
+		if (!is_typedef && decl->c23_auto &&
+		    (!decl->ctype.base_type ||
+		     decl->ctype.base_type->type !=3D SYM_FN)) {
+			struct symbol *prev;
+			for (prev =3D decl->next_id; prev; prev =3D prev->next_id) {
+				if (prev->namespace !=3D decl->namespace ||
+				    prev->builtin)
+					continue;
+				if (prev->scope =3D=3D decl->scope ||
+				    (toplevel(decl->scope) &&
+				     toplevel(prev->scope))) {
+					sparse_error(
+						decl->pos,
+						"underspecified declaration of '%s', which is already declared in =
this scope",
+						show_ident(decl->ident));
+					break;
+				}
+			}
+		}
+
 		if (ctx.autotype) {
 			const char *msg =3D NULL;
-			if (decl->ctype.base_type !=3D &autotype_ctype)
+			struct expression *init =3D decl->initializer;
+			while (init && init->type =3D=3D EXPR_PREOP && init->op =3D=3D '(')
+				init =3D init->unop;
+			if (is_typedef)
+				msg =3D "cannot be used with typedef";
+			else if (decl->ctype.base_type !=3D &autotype_ctype)
 				msg =3D "on non-identifier";
 			else if (match_op(token, ','))
 				msg =3D "on declaration list";
 			else if (!decl->initializer)
 				msg =3D "without initializer";
-			else if (decl->initializer->type =3D=3D EXPR_SYMBOL &&
-				 decl->initializer->symbol =3D=3D decl)
+			else if (decl->initializer->type =3D=3D EXPR_INITIALIZER) {
+				msg =3D "requires a scalar initializer expression";
+				decl->initializer =3D NULL;
+			} else if (!ctx.has_auto && init &&
+				   init->type =3D=3D EXPR_SYMBOL &&
+				   init->symbol =3D=3D decl)
 				msg =3D "on self-init var";
 			if (msg) {
-				sparse_error(decl->pos, "__auto_type %s", msg);
+				sparse_error(decl->pos, "%s %s",
+					     ctx.has_auto ? "auto" :
+							    "__auto_type",
+					     msg);
 				decl->ctype.base_type =3D &bad_ctype;
 			}
 		}
@@ -3391,6 +3497,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		decl->ctype =3D ctx.ctype;
 		decl->ctype.modifiers |=3D mod;
 		decl->cleanup =3D ctx.cleanup;
+		decl->c23_auto =3D ctx.autotype && ctx.has_auto;
 		decl->endpos =3D token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition=
");
diff --git a/symbol.c b/symbol.c
index a05e240cdfaa..b0bdf0b1122f 100644
--- a/symbol.c
+++ b/symbol.c
@@ -266,15 +266,68 @@ static struct symbol *examine_base_type(struct symb=
ol *sym)
 	struct symbol *base_type;
=20
 	if (sym->ctype.base_type =3D=3D &autotype_ctype) {
-		struct symbol *type =3D evaluate_expression(sym->initializer);
-		if (!type)
+		struct symbol *type;
+		sym->ctype.base_type =3D &bad_ctype;
+		if (!sym->initializer || sym->initializer->type =3D=3D EXPR_INITIALIZE=
R) {
+			type =3D &bad_ctype;
+		} else {
+			if (sym->c23_auto)
+				sym->underspecified =3D 1;
+			type =3D evaluate_expression(sym->initializer);
+			if (sym->c23_auto)
+				sym->underspecified =3D 0;
+		}
+		if (!type || type =3D=3D sym || type->ctype.base_type =3D=3D &autotype=
_ctype)
 			type =3D &bad_ctype;
 		if (is_bitfield_type(type)) {
-			warning(sym->pos, "__auto_type on bitfield");
+			if (!sym->c23_auto)
+				warning(sym->pos, "__auto_type on bitfield");
 			if (type->type =3D=3D SYM_NODE)
 				type =3D type->ctype.base_type;
 			type =3D type->ctype.base_type;
 		}
+		if (type->type =3D=3D SYM_NODE &&
+		    type->ctype.base_type->type =3D=3D SYM_ARRAY) {
+			struct symbol *array =3D type->ctype.base_type;
+			struct symbol *ptr =3D alloc_symbol(sym->pos, SYM_PTR);
+			ptr->ctype.base_type =3D array->ctype.base_type;
+			combine_address_space(sym->pos, &ptr->ctype.as, type->ctype.as);
+			combine_address_space(sym->pos, &ptr->ctype.as, array->ctype.as);
+			ptr->ctype.modifiers |=3D (type->ctype.modifiers | array->ctype.modif=
iers) & MOD_PTRINHERIT;
+			ptr->bit_size =3D bits_in_pointer;
+			ptr->ctype.alignment =3D pointer_alignment;
+			type =3D ptr;
+		} else if (type->type =3D=3D SYM_ARRAY) {
+			struct symbol *ptr =3D alloc_symbol(sym->pos, SYM_PTR);
+			ptr->ctype.base_type =3D type->ctype.base_type;
+			combine_address_space(sym->pos, &ptr->ctype.as, type->ctype.as);
+			ptr->ctype.modifiers |=3D type->ctype.modifiers & MOD_PTRINHERIT;
+			ptr->bit_size =3D bits_in_pointer;
+			ptr->ctype.alignment =3D pointer_alignment;
+			type =3D ptr;
+		} else if (type->type =3D=3D SYM_NODE &&
+			   type->ctype.base_type->type =3D=3D SYM_FN) {
+			struct symbol *ptr =3D alloc_symbol(sym->pos, SYM_PTR);
+			ptr->ctype.base_type =3D type->ctype.base_type;
+			ptr->bit_size =3D bits_in_pointer;
+			ptr->ctype.alignment =3D pointer_alignment;
+			type =3D ptr;
+		} else if (type->type =3D=3D SYM_FN) {
+			struct symbol *ptr =3D alloc_symbol(sym->pos, SYM_PTR);
+			ptr->ctype.base_type =3D type;
+			ptr->bit_size =3D bits_in_pointer;
+			ptr->ctype.alignment =3D pointer_alignment;
+			type =3D ptr;
+		} else if (sym->c23_auto) {
+			/*
+			 * C23 6.7.10p2: inferred type is the type of the
+			 * assignment expression after lvalue, array-to-pointer,
+			 * or function-to-pointer conversion (stripping top-level
+			 * qualifiers and atomic).
+			 */
+			while (type->type =3D=3D SYM_NODE)
+				type =3D type->ctype.base_type;
+		}
 		sym->ctype.base_type =3D type;
 	}
=20
diff --git a/symbol.h b/symbol.h
index acd381fe64fd..61ca70afe83b 100644
--- a/symbol.h
+++ b/symbol.h
@@ -115,6 +115,7 @@ struct decl_state {
 	unsigned char autotype;
 	unsigned char forced;
 	unsigned char packed;
+	unsigned char has_auto;
 	unsigned char has_alignas;
 	unsigned char designated_init;
 	unsigned char transparent_union;
@@ -201,6 +202,8 @@ struct symbol {
 					packed:1,
 					transparent_union:1;
 			unsigned int has_alignas : 1;
+			unsigned int underspecified : 1;
+			unsigned int c23_auto : 1;
 			int		rank:3;	// arithmetic's rank
 			struct expression *array_size;
 			struct ctype ctype;
diff --git a/validation/c23-auto-error.c b/validation/c23-auto-error.c
new file mode 100644
index 000000000000..b88ebd37d2d9
--- /dev/null
+++ b/validation/c23-auto-error.c
@@ -0,0 +1,68 @@
+auto no_init;
+auto arr[2] =3D { 0, 1 };
+auto foo(void)
+{
+}
+auto x =3D 1, y =3D 2;
+auto self =3D self;
+auto auto dup =3D 1;
+auto self_expr =3D self_expr + 1;
+auto self_sz =3D sizeof(self_sz);
+struct bad_s {
+	auto m;
+};
+void bad_param(auto p);
+typedef auto bad_td;
+auto;
+auto int bad_file_storage =3D 1;
+extern int already_in_scope;
+auto already_in_scope =3D 1;
+
+void block_errors(void)
+{
+	int shadow =3D 5;
+	{
+		auto shadow =3D shadow + 1;
+	}
+	int bad_sz =3D sizeof(auto);
+	int bad_cast =3D (auto)1;
+	_Atomic(auto) bad_atomic =3D 1;
+	auto braced =3D { 1 };
+	(void)bad_sz;
+	(void)bad_cast;
+	(void)bad_atomic;
+	(void)braced;
+}
+
+/*
+ * check-name: C23 auto error cases
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-auto-error.c:1:6: error: auto without initializer
+c23-auto-error.c:2:6: error: auto on non-identifier
+c23-auto-error.c:3:6: error: 'foo()' has auto return type
+c23-auto-error.c:6:6: error: auto on declaration list
+c23-auto-error.c:8:11: error: duplicate auto
+c23-auto-error.c:12:14: error: struct or union member 'm' cannot be decl=
ared auto
+c23-auto-error.c:14:16: error: parameter 'p' cannot be declared auto
+c23-auto-error.c:15:14: error: auto cannot be used with typedef
+c23-auto-error.c:16:5: error: auto in empty declaration
+c23-auto-error.c:17:10: error: file-scope declaration of 'bad_file_stora=
ge' specifies 'auto'
+c23-auto-error.c:19:6: error: underspecified declaration of 'already_in_=
scope', which is already declared in this scope
+c23-auto-error.c:27:29: error: 'auto' in type name
+c23-auto-error.c:28:25: error: 'auto' in type name
+c23-auto-error.c:29:16: error: Trying to use reserved word 'auto' as ide=
ntifier
+c23-auto-error.c:29:23: error: Expected ; at end of declaration
+c23-auto-error.c:29:23: error: got bad_atomic
+c23-auto-error.c:30:14: error: auto requires a scalar initializer expres=
sion
+c23-auto-error.c:2:15: error: invalid initializer
+c23-auto-error.c:7:13: error: underspecified symbol 'self' used in its o=
wn initializer
+c23-auto-error.c:9:18: error: underspecified symbol 'self_expr' used in =
its own initializer
+c23-auto-error.c:10:23: error: underspecified symbol 'self_sz' used in i=
ts own initializer
+c23-auto-error.c:10:16: error: cannot size expression
+c23-auto-error.c:25:31: error: underspecified symbol 'shadow' used in it=
s own initializer
+c23-auto-error.c:27:22: error: cannot size expression
+c23-auto-error.c:33:15: error: undefined identifier 'bad_atomic'
+ * check-error-end
+ */
diff --git a/validation/c23-auto.c b/validation/c23-auto.c
new file mode 100644
index 000000000000..f9c461d9bed7
--- /dev/null
+++ b/validation/c23-auto.c
@@ -0,0 +1,107 @@
+#ifdef __CHECKER__
+#define ASSERT_TYPE(expr, T) _Static_assert([typeof(expr)] =3D=3D [T], "=
")
+#else
+#define ASSERT_TYPE(expr, T) \
+	_Static_assert(_Generic((typeof(expr) *)0, typeof(T) *: 1, default: 0),=
 "")
+#endif
+
+struct s {
+	int a;
+};
+static void fn(void)
+{
+}
+
+static auto file_static =3D 42L;
+ASSERT_TYPE(file_static, long);
+
+static void test(void)
+{
+	auto i =3D 0;
+	ASSERT_TYPE(i, int);
+
+	auto l =3D 1L;
+	ASSERT_TYPE(l, long);
+
+	auto d =3D 1.0;
+	ASSERT_TYPE(d, double);
+
+	auto f =3D 1.0f;
+	ASSERT_TYPE(f, float);
+
+	auto p =3D &i;
+	ASSERT_TYPE(p, int *);
+
+	const auto ci =3D 42;
+	ASSERT_TYPE(ci, const int);
+
+	volatile auto vi =3D 1;
+	ASSERT_TYPE(vi, volatile int);
+
+	_Atomic auto ai =3D 2;
+	ASSERT_TYPE(ai, _Atomic int);
+
+	/* Top-level qualifiers and _Atomic are stripped by lvalue conversion *=
/
+	auto stripped_c =3D ci;
+	ASSERT_TYPE(stripped_c, int);
+	stripped_c =3D 43;
+
+	auto stripped_v =3D vi;
+	ASSERT_TYPE(stripped_v, int);
+	stripped_v =3D 2;
+
+	auto stripped_a =3D ai;
+	ASSERT_TYPE(stripped_a, int);
+	stripped_a =3D 3;
+
+	/* Pointee qualifiers and decayed array element qualifiers are kept */
+	const int *cp =3D &ci;
+	auto p_to_const =3D cp;
+	ASSERT_TYPE(p_to_const, const int *);
+
+	int *const top_const_p =3D &i;
+	auto stripped_p =3D top_const_p;
+	ASSERT_TYPE(stripped_p, int *);
+	stripped_p =3D nullptr;
+
+	const int carr[2] =3D { 1, 2 };
+	auto decayed_carr =3D carr;
+	ASSERT_TYPE(decayed_carr, const int *);
+
+	static auto si =3D 100;
+	ASSERT_TYPE(si, int);
+
+	auto s =3D "hello";
+	ASSERT_TYPE(s, char *);
+
+	int arr[10];
+	auto a =3D arr;
+	ASSERT_TYPE(a, int *);
+
+	auto fp =3D fn;
+	ASSERT_TYPE(fp, void (*)(void));
+
+	struct s st =3D { 1 };
+	auto sv =3D st;
+	ASSERT_TYPE(sv, struct s);
+
+	const struct s cst =3D { 2 };
+	auto stripped_st =3D cst;
+	ASSERT_TYPE(stripped_st, struct s);
+	stripped_st.a =3D 3;
+
+	auto int normal =3D 1;
+	ASSERT_TYPE(normal, int);
+
+	int auto normal2 =3D 2;
+	ASSERT_TYPE(normal2, int);
+
+	for (auto idx =3D 0; idx < 1; idx++) {
+		ASSERT_TYPE(idx, int);
+	}
+}
+
+/*
+ * check-name: C23 auto type inference
+ * check-command: sparse -std=3Dc23 $file
+ */
