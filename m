Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256439;
	b=3clQ6Ibh2dCFJvViCh3wdKVOLWTdVdUo6Ikd/w1Muf/6xJbbDkfQj0DGBuUjHt9dikI+
	 r5k7AleehTDh111W6+CoAFbiPiiZvAJwz2LTKgE8SaHu6OJWYjNpAaxNuNBRmM3IxzHJj
	 gA/AmGrKF1+dnDHaZMv7PyLeNnaxSyTjyn9GU0is+Ec3nADAtdKmNHJFp8aZi7/2lZ2P+
	 tUkVTC8SguRWgNSsweYNO3fEuJRX8ls5+saklKUKo57VLKaGu2Hsay/v17dcKce3+4loO
	 vLhDThYpmV/VWSTCZN7D1kyiBdMLkaGEQQkpeKY7uaDQvF9qtUuxLs3mOXOX5Bq6lhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Y1u8L0oBsM4YtANH+6u6MHR9FfKSGwm6c3ZrFO5iCW0=;
	b=hFgonjTool/lOH3fNI8iW1vO2NYiJIhB+I8p9FayUDnjxywv1yGU5GTN4ggxxgWNxB5A
	 Hu/cP1ElVuUFKePf7L86mMItATPqQyMUNWUHrBoTq6Dim/sihGbSTNwLDnAsoZEnFjusr
	 hNyqDcryK2bMUAFk4sdMADBK7rJ7RmUzdTZh5FbzmHFLhCZjtsMLXmWqfoh2cC2i0aAwC
	 VXijNY7WlnztfoTxOtyPwj7mNua5SKD+k73elDYrcFof4beYaWexLUemn4ZJ09iszdy5O
	 /tELoJG1w8SW/hxDXjqff2BHLRbqFR1JMEzmfBhVleU4iGbbTKEJ3s71CsGeDvkCkGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=V3+jr91M;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BBB606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5BBB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=V3+jr91M
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhML63Jfz1XM0nk;
	Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256417; x=1796848418; bh=Y1u8L
	0oBsM4YtANH+6u6MHR9FfKSGwm6c3ZrFO5iCW0=; b=V3+jr91MNQ2VOyoFHWkcO
	Qc898gWD1zGUq/oMzr4l8LMcCyykO3CKJfm7HQRc7fxDVNNhpVhzbYUuYkLwFrDb
	DxWV3lICTq+TnXAUXeXZW0ZkMn9xEefrqhdzlLPNdrZMhz987VvMRPZ/JUA0sjQz
	3Tf1c0z+CKMKE7iFnViWaPp3G/xi2w8ALQMhPLag1Hw6ouGgtdRP8VCRoQLoGxvm
	Grd7U7XyHxKBoyonSJxkohzD+HhX4xC/+r+hz3rukaeSNaqyZZZFvm5eFSWvEP6T
	AeSeEfULptUBRSUr9FoWgAfyDrnf9hpQnaEQKyozN8vlTBOlfJyoSrbp50AXWx++
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K6Q1C1rizeyp; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM36BPsz1XMYJH;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 52/73] c23: Support standard [[]] attribute syntax
Date: Mon,  9 Nov 2026 12:32:38 -0800
Message-ID: <20261109203259.362845-53-bvanassche@acm.org>
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

Parse C23 '[[]]' attribute specifier sequences across declarations,
declarators, types, structs, enums, parameters, labels, and statements
per ISO C23 6.7.12:
- Map standard attributes (nodiscard, maybe_unused, deprecated,
  fallthrough, noreturn, _Noreturn, reproducible, unsequenced) and
  gnu::/__gnu__:: scoped attributes to their Sparse modifiers, while
  ignoring unknown vendor-scoped attributes cleanly.
- Support '[[]]' attributes after declarator identifiers and after
  function parameter lists without misapplying function modifiers to
  pointer declarators.
- Distinguish attributed case and default labels from named goto labels
  inside switch statements, and warn under -Wpedantic in pre-C23 modes.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ident-list.h                         |   2 +
 parse.c                              | 275 +++++++++++++++++++++++----
 symbol.h                             |   7 +-
 validation/attr_in_parameter.c       |   2 +
 validation/c23-attributes-error.c    |  20 ++
 validation/c23-attributes-pedantic.c |  10 +
 validation/c23-attributes.c          | 149 +++++++++++++++
 validation/c23-param-attribute.c     |  28 +++
 8 files changed, 448 insertions(+), 45 deletions(-)
 create mode 100644 validation/c23-attributes-error.c
 create mode 100644 validation/c23-attributes-pedantic.c
 create mode 100644 validation/c23-attributes.c
 create mode 100644 validation/c23-param-attribute.c

diff --git a/ident-list.h b/ident-list.h
index 46e6cd9e4f61..bc5df947913a 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -65,6 +65,8 @@ IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
 IDENT_RESERVED(__label__);
+IDENT(gnu);
+IDENT(__gnu__);
=20
 /* Preprocessor idents.  Direct use of __IDENT avoids mentioning the key=
word
  * itself by name, preventing these tokens from expanding when compiling
diff --git a/parse.c b/parse.c
index 48793dd51671..13b8cf5d43c1 100644
--- a/parse.c
+++ b/parse.c
@@ -50,6 +50,13 @@ struct statement_list *function_computed_goto_list;
=20
 static struct token *statement(struct token *token, struct statement **t=
ree);
 static struct token *handle_attributes(struct token *token, struct decl_=
state *ctx);
+static inline bool match_c23_attribute(struct token *token)
+{
+	return match_op(token, '[') && match_op(token->next, '[');
+}
+static struct token *c23_attribute_specifier(struct token *token,
+					     struct decl_state *ctx);
+static struct token *skip_c23_attributes(struct token *token);
 static struct token *skip_attributes(struct token *token);
=20
 typedef struct token *declarator_t(struct token *, struct symbol *, stru=
ct decl_state *);
@@ -563,6 +570,7 @@ static struct init_keyword {
 	D("noderef",		&attr_mod_op,		.mods =3D MOD_NODEREF),
 	D("safe",		&attr_mod_op,		.mods =3D MOD_SAFE),
 	D("unused",		&attr_mod_op,		.mods =3D MOD_UNUSED),
+	D("maybe_unused",	&attr_mod_op,		.mods =3D MOD_UNUSED),
 	D("externally_visible",	&attr_mod_op,		.mods =3D MOD_EXT_VISIBLE),
 	D("force",		&attr_force_op),
 	D("bitwise",		&attr_bitwise_op,	.mods =3D MOD_BITWISE),
@@ -570,9 +578,14 @@ static struct init_keyword {
 	D("designated_init",	&designated_init_op),
 	D("transparent_union",	&transparent_union_op),
 	D("noreturn",		&attr_fun_op,		.mods =3D MOD_NORETURN),
+	D("_Noreturn",		&attr_fun_op,		.mods =3D MOD_NORETURN),
 	D("pure",		&attr_fun_op,		.mods =3D MOD_PURE),
 	A("const",		&attr_fun_op,		.mods =3D MOD_PURE),
 	D("gnu_inline",		&attr_fun_op,		.mods =3D MOD_GNU_INLINE),
+	D("nodiscard",		&ignore_attr_op),
+	D("fallthrough",	&ignore_attr_op),
+	D("unsequenced",	&attr_fun_op,		.mods =3D MOD_PURE),
+	D("reproducible",	&attr_fun_op,		.mods =3D MOD_PURE),
=20
 	/* Modes */
 	D("mode",		&mode_op),
@@ -1666,22 +1679,29 @@ static struct token *attribute_transparent_union(=
struct token *token, struct sym
 	return token;
 }
=20
-static struct token *recover_unknown_attribute(struct token *token)
+static struct token *skip_parens(struct token *token)
 {
-	struct expression *expr =3D NULL;
-
-	if (Wunknown_attribute)
-		warning(token->pos, "unknown attribute '%s'", show_ident(token->ident)=
);
-	token =3D token->next;
 	if (match_op(token, '(')) {
-		if (match_op(token->next, ')'))
-			token =3D token->next->next;
-		else
-			token =3D parens_expression(token, &expr, "in attribute");
+		int depth =3D 1;
+		token =3D token->next;
+		while (depth && !eof_token(token)) {
+			if (match_op(token, '('))
+				depth++;
+			else if (match_op(token, ')'))
+				depth--;
+			token =3D token->next;
+		}
 	}
 	return token;
 }
=20
+static struct token *recover_unknown_attribute(struct token *token)
+{
+	if (Wunknown_attribute)
+		warning(token->pos, "unknown attribute '%s'", show_ident(token->ident)=
);
+	return skip_parens(token->next);
+}
+
 static struct token *attribute_specifier(struct token *token, struct sym=
bol *sym, struct decl_state *ctx)
 {
 	token =3D expect(token, '(', "after attribute");
@@ -1863,7 +1883,11 @@ struct symbol *ctype_integer(int size, int want_un=
signed)
=20
 static struct token *handle_qualifiers(struct token *t, struct decl_stat=
e *ctx)
 {
-	while (token_type(t) =3D=3D TOKEN_IDENT) {
+	while (token_type(t) =3D=3D TOKEN_IDENT || match_c23_attribute(t)) {
+		if (match_c23_attribute(t)) {
+			t =3D c23_attribute_specifier(t, ctx);
+			continue;
+		}
 		struct symbol *s =3D lookup_keyword(t->ident, NS_TYPEDEF);
 		if (!s || !s->op)
 			break;
@@ -1882,7 +1906,11 @@ static struct token *declaration_specifiers(struct=
 token *token, struct decl_sta
 	int class =3D CInt;
 	int rank =3D 0;
=20
-	while (token_type(token) =3D=3D TOKEN_IDENT) {
+	while (token_type(token) =3D=3D TOKEN_IDENT || match_c23_attribute(toke=
n)) {
+		if (match_c23_attribute(token)) {
+			token =3D c23_attribute_specifier(token, ctx);
+			continue;
+		}
 		struct symbol *s =3D lookup_symbol(token->ident,
 						 NS_TYPEDEF | NS_SYMBOL);
 		if (!s || !(s->namespace & NS_TYPEDEF))
@@ -2040,16 +2068,22 @@ static bool match_attribute(struct token *token)
=20
 static struct token *skip_attribute(struct token *token)
 {
-	token =3D token->next;
-	if (match_op(token, '(')) {
-		int depth =3D 1;
-		token =3D token->next;
-		while (depth && !eof_token(token)) {
-			if (token_type(token) =3D=3D TOKEN_SPECIAL) {
-				if (token->special =3D=3D '(')
-					depth++;
-				else if (token->special =3D=3D ')')
-					depth--;
+	return skip_parens(token->next);
+}
+
+static struct token *skip_c23_attributes(struct token *token)
+{
+	while (match_c23_attribute(token)) {
+		token =3D token->next->next;
+		while (!eof_token(token)) {
+			if (match_op(token, ']') &&
+			    match_op(token->next, ']')) {
+				token =3D token->next->next;
+				break;
+			}
+			if (match_op(token, '(')) {
+				token =3D skip_parens(token);
+				continue;
 			}
 			token =3D token->next;
 		}
@@ -2057,27 +2091,113 @@ static struct token *skip_attribute(struct token=
 *token)
 	return token;
 }
=20
-static struct token *skip_attributes(struct token *token)
+static struct token *c23_attribute_specifier(struct token *token,
+					     struct decl_state *ctx)
 {
-	while (match_attribute(token)) {
-		token =3D expect(token->next, '(', "after attribute");
-		token =3D expect(token, '(', "after attribute");
-		while (token_type(token) =3D=3D TOKEN_IDENT) {
-			token =3D skip_attribute(token);
-			if (!match_op(token, ','))
+	if (standard < STANDARD_C23 && Wpedantic)
+		warning(token->pos, "C23 attribute syntax is a C23 extension");
+
+	token =3D expect(token, '[', "in attribute specifier");
+	token =3D expect(token, '[', "in attribute specifier");
+
+	while (!match_op(token, ']') && !eof_token(token)) {
+		struct ident *prefix =3D NULL;
+		struct ident *attr_ident =3D NULL;
+		struct token *id_tok =3D NULL;
+
+		if (match_op(token, ',')) {
+			token =3D token->next;
+			continue;
+		}
+
+		if (token_type(token) !=3D TOKEN_IDENT) {
+			sparse_error(token->pos, "expected attribute name");
+			break;
+		}
+
+		id_tok =3D token;
+		attr_ident =3D token->ident;
+		token =3D token->next;
+
+		if (match_op(token, ':') && match_op(token->next, ':')) {
+			prefix =3D attr_ident;
+			token =3D token->next->next;
+			if (token_type(token) !=3D TOKEN_IDENT) {
+				sparse_error(
+					token->pos,
+					"expected attribute name after '::'");
 				break;
+			}
+			id_tok =3D token;
+			attr_ident =3D token->ident;
 			token =3D token->next;
 		}
-		token =3D expect(token, ')', "after attribute");
-		token =3D expect(token, ')', "after attribute");
+
+		if (!prefix || prefix =3D=3D &gnu_ident ||
+		    prefix =3D=3D &__gnu___ident) {
+			struct symbol *attr =3D
+				lookup_keyword(attr_ident, NS_KEYWORD);
+			if (attr && attr->op && attr->op->attribute)
+				token =3D attr->op->attribute(token, attr, ctx);
+			else {
+				if (Wunknown_attribute)
+					warning(id_tok->pos,
+						"unknown attribute '%s'",
+						show_ident(attr_ident));
+				token =3D skip_parens(token);
+			}
+		} else {
+			/* Other vendor prefixes (e.g. clang::...): ignore */
+			token =3D skip_parens(token);
+		}
+
+		if (match_op(token, ','))
+			token =3D token->next;
+		else if (match_op(token, ']'))
+			break;
+		else {
+			sparse_error(token->pos,
+				     "expected ']' or ',' after attribute");
+			break;
+		}
+	}
+
+	token =3D expect(token, ']', "at end of attribute specifier");
+	token =3D expect(token, ']', "at end of attribute specifier");
+	return token;
+}
+
+static struct token *skip_attributes(struct token *token)
+{
+	for (;;) {
+		if (match_attribute(token)) {
+			token =3D expect(token->next, '(', "after attribute");
+			token =3D expect(token, '(', "after attribute");
+			while (token_type(token) =3D=3D TOKEN_IDENT) {
+				token =3D skip_attribute(token);
+				if (!match_op(token, ','))
+					break;
+				token =3D token->next;
+			}
+			token =3D expect(token, ')', "after attribute");
+			token =3D expect(token, ')', "after attribute");
+		} else if (match_c23_attribute(token)) {
+			token =3D skip_c23_attributes(token);
+		} else {
+			break;
+		}
 	}
 	return token;
 }
=20
 static struct token *handle_attributes(struct token *token, struct decl_=
state *ctx)
 {
-	while (match_attribute(token))
-		token =3D attribute_specifier(token->next, NULL, ctx);
+	while (match_attribute(token) || match_c23_attribute(token)) {
+		if (match_attribute(token))
+			token =3D attribute_specifier(token->next, NULL, ctx);
+		else
+			token =3D c23_attribute_specifier(token, ctx);
+	}
 	return token;
 }
=20
@@ -2115,10 +2235,10 @@ static enum kind which_func(struct token *token,
 			    struct ident **n,
 			    int prefer_abstract)
 {
-	struct token *next =3D token->next;
+	struct token *next =3D skip_attributes(token->next);
=20
 	if (token_type(next) =3D=3D TOKEN_IDENT) {
-		if (lookup_type(next))
+		if (lookup_type(next) || next !=3D token->next)
 			return Proto;
 		/* identifier list not in definition; complain */
 		if (prefer_abstract)
@@ -2160,6 +2280,24 @@ static struct token *direct_declarator(struct toke=
n *token, struct decl_state *c
 	if (ctx->ident && token_type(token) =3D=3D TOKEN_IDENT) {
 		*ctx->ident =3D token->ident;
 		token =3D token->next;
+		if (match_c23_attribute(token)) {
+			struct decl_state attr =3D { };
+			token =3D handle_attributes(token, &attr);
+			ctx->ident_modifiers |=3D (attr.ctype.modifiers & MOD_DECLARE) |
+						attr.f_modifiers;
+			if (attr.cleanup)
+				ctx->cleanup =3D attr.cleanup;
+			if (attr.packed)
+				ctx->packed =3D attr.packed;
+			if (attr.transparent_union)
+				ctx->transparent_union =3D attr.transparent_union;
+			if (attr.designated_init)
+				ctx->designated_init =3D attr.designated_init;
+			if (attr.ctype.alignment > ctx->ctype.alignment)
+				ctx->ctype.alignment =3D attr.ctype.alignment;
+			attr.ctype.modifiers &=3D ~MOD_DECLARE;
+			apply_ctype(token->pos, &ctx->ctype, &attr.ctype);
+		}
 	} else if (match_op(token, '(') &&
 	    is_nested(token, &next, ctx->prefer_abstract)) {
 		struct symbol *base_type =3D ctype->base_type;
@@ -2191,16 +2329,24 @@ static struct token *direct_declarator(struct tok=
en *token, struct decl_state *c
 			token =3D parameter_type_list(token, fn);
 		token =3D expect(token, ')', "in function declarator");
 		fn->endpos =3D token->pos;
+		if (match_c23_attribute(token)) {
+			struct decl_state attr =3D { };
+			token =3D handle_attributes(token, &attr);
+			ctype->modifiers |=3D attr.f_modifiers;
+			apply_ctype(token->pos, ctype, &attr.ctype);
+		}
 		return token;
 	}
=20
-	while (match_op(token, '[')) {
+	while (match_op(token, '[') && !match_c23_attribute(token)) {
 		struct symbol *array;
 		array =3D alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
 		token =3D abstract_array_declarator(token->next, array);
 		token =3D expect(token, ']', "in abstract_array_declarator");
 		array->endpos =3D token->pos;
 		ctype =3D &array->ctype;
+		if (match_c23_attribute(token))
+			token =3D handle_attributes(token, ctx);
 	}
 	return token;
 }
@@ -2295,6 +2441,7 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 	for (;;) {
 		struct symbol *decl =3D alloc_symbol(token->pos, SYM_NODE);
 		ctx.cleanup =3D NULL;
+		ctx.ident_modifiers =3D 0;
 		ctx.ident =3D &decl->ident;
=20
 		token =3D declarator(token, &ctx);
@@ -2302,6 +2449,7 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 			token =3D handle_bitfield(token, &ctx);
=20
 		token =3D handle_attributes(token, &ctx);
+		ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 		apply_modifiers(token->pos, &ctx);
=20
 		decl->ctype =3D ctx.ctype;
@@ -2366,6 +2514,7 @@ static struct token *parameter_declaration(struct t=
oken *token, struct symbol *s
 	ctx.ident =3D &sym->ident;
 	token =3D declarator(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
+	ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
 	sym->ctype.modifiers |=3D decl_modifiers(&ctx);
@@ -2412,6 +2561,8 @@ struct token *typename(struct token *token, struct =
symbol **p, int *forced)
 		ctx.ctype.base_type =3D &bad_ctype;
 	}
 	token =3D declarator(token, &ctx);
+	token =3D handle_attributes(token, &ctx);
+	ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
 	sym->endpos =3D token->pos;
@@ -2700,7 +2851,10 @@ static struct token *parse_for_statement(struct to=
ken *token, struct statement *
 	syms =3D NULL;
 	e1 =3D NULL;
 	/* C99 variable declaration? */
-	if (lookup_type(token)) {
+	struct token *next =3D token;
+	if (match_c23_attribute(token))
+		next =3D skip_c23_attributes(token);
+	if (lookup_type(next)) {
 		token =3D external_declaration(token, &syms, validate_for_loop_decl);
 	} else {
 		token =3D parse_expression(token, &e1);
@@ -2873,13 +3027,13 @@ static struct token *handle_label_attributes(stru=
ct token *token, struct symbol
 	struct decl_state ctx =3D { };
=20
 	token =3D handle_attributes(token, &ctx);
-	label->label_modifiers =3D ctx.ctype.modifiers;
+	label->label_modifiers |=3D ctx.ctype.modifiers;
 	return token;
 }
=20
 static bool is_label_token(struct token *token)
 {
-	struct token *p =3D token;
+	struct token *p =3D skip_c23_attributes(token);
 	struct symbol *s;
=20
 	if (token_type(p) !=3D TOKEN_IDENT)
@@ -2903,6 +3057,8 @@ static struct token *parse_one_label(struct token *=
token,
=20
 	*stmtp =3D NULL;
 	*is_case =3D false;
+	if (match_c23_attribute(token))
+		token =3D handle_attributes(token, &attr_state);
=20
 	if (token->ident =3D=3D &case_ident) {
 		stmt =3D alloc_statement(token->pos, STMT_CASE);
@@ -2950,7 +3106,7 @@ static struct token *parse_one_label(struct token *=
token,
=20
 static struct token *statement(struct token *token, struct statement **t=
ree)
 {
-	struct statement *stmt =3D alloc_statement(token->pos, STMT_NONE);
+	struct statement *stmt;
=20
 	if (is_label_token(token)) {
 		struct statement *lbl =3D NULL;
@@ -2971,6 +3127,27 @@ static struct token *statement(struct token *token=
, struct statement **tree)
 		return statement(token, tree);
 	}
=20
+	if (match_c23_attribute(token)) {
+		struct token *next =3D skip_c23_attributes(token);
+		if (lookup_type(next)) {
+			sparse_error(token->pos, "declaration is not a statement");
+			stmt =3D alloc_statement(token->pos, STMT_DECLARATION);
+			*tree =3D stmt;
+			start_block_scope();
+			token =3D external_declaration(token, &stmt->declaration, NULL);
+			end_block_scope();
+			return token;
+		}
+		struct decl_state attr_state =3D {};
+		token =3D handle_attributes(token, &attr_state);
+		if (match_op(token, ';')) {
+			stmt =3D alloc_statement(token->pos, STMT_NONE);
+			*tree =3D stmt;
+			return token->next;
+		}
+		return statement(token, tree);
+	}
+	stmt =3D alloc_statement(token->pos, STMT_NONE);
 	*tree =3D stmt;
 	if (token_type(token) =3D=3D TOKEN_IDENT) {
 		struct symbol *s =3D lookup_keyword(token->ident, NS_KEYWORD);
@@ -3031,6 +3208,7 @@ static struct token * statement_list(struct token *=
token, struct statement_list
 		struct statement *label_head =3D NULL;
 		struct statement **label_tail =3D &label_head;
 		bool last_is_case =3D false;
+		struct token *next;
=20
 		while (is_label_token(token)) {
 			struct statement *lbl =3D NULL;
@@ -3054,10 +3232,13 @@ static struct token * statement_list(struct token=
 *token, struct statement_list
 				add_statement(list, label_head);
 				break;
 			}
+			next =3D match_c23_attribute(token) ?
+				       skip_c23_attributes(token) :
+				       token;
 			if (match_ident(token, &_Static_assert_ident) ||
 			    (standard >=3D STANDARD_C23 &&
 			     match_ident(token, &static_assert_ident)) ||
-			    lookup_type(token)) {
+			    lookup_type(next)) {
 				if (standard < STANDARD_C23 && Wpedantic)
 					warning(token->pos,
 						"a label can only be part of a statement and a declaration is not =
a statement");
@@ -3081,7 +3262,10 @@ static struct token * statement_list(struct token =
*token, struct statement_list
 			token =3D parse_static_assert(token, NULL);
 			continue;
 		}
-		if (lookup_type(token)) {
+		next =3D token;
+		if (match_c23_attribute(token))
+			next =3D skip_c23_attributes(token);
+		if (lookup_type(next)) {
 			if (seen_statement) {
 				warning(token->pos, "mixing declarations and code");
 				seen_statement =3D 0;
@@ -3457,6 +3641,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	struct symbol *decl;
 	struct decl_state ctx =3D { .ident =3D &ident };
 	struct ctype saved;
+	unsigned long saved_f_modifiers;
 	struct symbol *base_type;
 	unsigned long mod;
 	int is_typedef;
@@ -3495,9 +3680,11 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 			     "'enum' underlying type may not be specified here");
=20
 	saved =3D ctx.ctype;
+	saved_f_modifiers =3D ctx.f_modifiers;
 	token =3D declarator(token, &ctx);
 	token =3D handle_asm_name(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
+	ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 	apply_modifiers(token->pos, &ctx);
=20
 	decl->ctype =3D ctx.ctype;
@@ -3753,10 +3940,13 @@ struct token *external_declaration(struct token *=
token, struct symbol_list **lis
 		decl =3D alloc_symbol(token->pos, SYM_NODE);
 		ctx.ctype =3D saved;
 		ctx.cleanup =3D NULL;
+		ctx.ident_modifiers =3D 0;
+		ctx.f_modifiers =3D saved_f_modifiers;
 		token =3D handle_attributes(token, &ctx);
 		token =3D declarator(token, &ctx);
 		token =3D handle_asm_name(token, &ctx);
 		token =3D handle_attributes(token, &ctx);
+		ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 		apply_modifiers(token->pos, &ctx);
 		decl->ctype =3D ctx.ctype;
 		decl->ctype.modifiers |=3D mod;
@@ -3781,6 +3971,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		/* Function declarations are automatically extern unless specifically =
static */
 		base_type =3D decl->ctype.base_type;
 		if (!is_typedef && base_type && base_type->type =3D=3D SYM_FN) {
+			decl->ctype.modifiers |=3D ctx.f_modifiers;
 			if (!(decl->ctype.modifiers & MOD_STATIC))
 				decl->ctype.modifiers |=3D MOD_EXTERN;
 		}
diff --git a/symbol.h b/symbol.h
index 8035d9d21b3c..a072ac8fc739 100644
--- a/symbol.h
+++ b/symbol.h
@@ -110,6 +110,7 @@ struct decl_state {
 	struct symbol_op *mode;
 	struct expression *cleanup;
 	unsigned long f_modifiers;		// function attributes
+	unsigned long ident_modifiers;		// declarator-id C23 attributes
 	unsigned long storage_class;
 	unsigned char prefer_abstract;
 	unsigned char autotype;
@@ -272,11 +273,11 @@ struct symbol {
 #define MOD_SPECIFIER	MOD_SIGNEDNESS
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE | MOD_CONSTEX=
PR)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
-#define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_N=
ORETURN | MOD_NOCAST)
-/* modifiers preserved by typeof() operator */
-#define MOD_TYPEOF	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NOCAST | MOD_SPECIF=
IER)
 /* modifiers for function attributes */
 #define MOD_FUN_ATTR	(MOD_PURE|MOD_NORETURN)
+#define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_F=
UN_ATTR | MOD_NOCAST)
+/* modifiers preserved by typeof() operator */
+#define MOD_TYPEOF	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NOCAST | MOD_SPECIF=
IER)
 /* like cvr-qualifiers but 'reversed' (OK: source <=3D target) */
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
 /* do not warn when these are duplicated */
diff --git a/validation/attr_in_parameter.c b/validation/attr_in_paramete=
r.c
index 1b104ea43ec5..33d8b85aa5cb 100644
--- a/validation/attr_in_parameter.c
+++ b/validation/attr_in_parameter.c
@@ -7,6 +7,8 @@ static void g(int A *x)
 	f(x, x);
 	p =3D q;
 }
+static void h(__attribute__((unused)) int x);
+
 /*
  * check-name: attribute after ( in direct-declarator
  */
diff --git a/validation/c23-attributes-error.c b/validation/c23-attribute=
s-error.c
new file mode 100644
index 000000000000..a78086311c1c
--- /dev/null
+++ b/validation/c23-attributes-error.c
@@ -0,0 +1,20 @@
+[[nodiscard] static int unclosed;
+[[gnu::]] static int missing_scoped;
+
+static void test_if_attr_decl(int c)
+{
+	if (c)
+		[[maybe_unused]] int z =3D 3;
+}
+
+/*
+ * check-name: c23-attributes-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-attributes-error.c:1:14: error: Expected ] at end of attribute speci=
fier
+c23-attributes-error.c:1:14: error: got static
+c23-attributes-error.c:2:8: error: expected attribute name after '::'
+c23-attributes-error.c:7:17: error: declaration is not a statement
+ * check-error-end
+ */
diff --git a/validation/c23-attributes-pedantic.c b/validation/c23-attrib=
utes-pedantic.c
new file mode 100644
index 000000000000..224f36f5bdf3
--- /dev/null
+++ b/validation/c23-attributes-pedantic.c
@@ -0,0 +1,10 @@
+[[maybe_unused]] static int x;
+
+/*
+ * check-name: C23 [[]] standard attribute syntax pedantic warning
+ * check-command: sparse -std=3Dc11 -Wpedantic $file
+ *
+ * check-error-start
+c23-attributes-pedantic.c:1:1: warning: C23 attribute syntax is a C23 ex=
tension
+ * check-error-end
+ */
diff --git a/validation/c23-attributes.c b/validation/c23-attributes.c
new file mode 100644
index 000000000000..8b53ce06d0cf
--- /dev/null
+++ b/validation/c23-attributes.c
@@ -0,0 +1,149 @@
+[[maybe_unused]] static int unused_var;
+
+[[nodiscard]] static int get_val(void)
+{
+	return 42;
+}
+
+[[deprecated("use new_func instead")]] static void old_func(void)
+{
+}
+
+[[noreturn]] static void fatal(void)
+{
+	for (;;) {
+	}
+}
+
+[[_Noreturn]] static void fatal2(void)
+{
+	for (;;) {
+	}
+}
+
+static int pure_add(int a, int b) [[unsequenced]]
+{
+	return a + b;
+}
+
+static int pure_mul(int a, int b) [[reproducible]]
+{
+	return a * b;
+}
+
+static int (*fp_unseq)(int, int) [[unsequenced]] =3D pure_add;
+typedef int (*plain_int_fp_t)(int);
+typedef int (__attribute__((__pure__)) *repro_int_fp_t)(int);
+static int plain_inc(int a)
+{
+	return a + 1;
+}
+static int repro_inc(int a) [[reproducible]]
+{
+	return a + 1;
+}
+static int (*get_plain_fp(void) [[reproducible]])(int)
+{
+	return plain_inc;
+}
+static int (*get_repro_fp(void))(int) [[reproducible]]
+{
+	return repro_inc;
+}
+static_assert([typeof(&get_plain_fp)] =3D=3D
+	      [plain_int_fp_t (__attribute__((__pure__)) *)(void)],
+	      "inner [[]] applies to outer function");
+static_assert([typeof(get_plain_fp())] =3D=3D [plain_int_fp_t],
+	      "inner [[]] does not leak to returned function pointer");
+static_assert([typeof(&get_repro_fp)] =3D=3D [repro_int_fp_t (*)(void)],
+	      "outer [[]] does not leak to outer function");
+static_assert([typeof(get_repro_fp())] =3D=3D [repro_int_fp_t],
+	      "outer [[]] applies to returned function pointer");
+
+struct [[deprecated]] S {
+	[[maybe_unused]] int field;
+};
+
+enum [[deprecated]] E {
+	ITEM1 [[deprecated]],
+	ITEM2,
+};
+
+typedef int T_attr_label;
+
+static void param_fn([[maybe_unused]] int a, int b [[maybe_unused]],
+		     [[maybe_unused]] int)
+{
+	(void)a;
+	(void)b;
+}
+
+struct [[gnu::packed]] PackedStruct {
+	char c;
+	int i;
+};
+static_assert(sizeof(struct PackedStruct) =3D=3D sizeof(char) + sizeof(i=
nt),
+	      "packed");
+
+struct [[gnu::aligned(16)]] AlignedStruct {
+	int x;
+};
+static_assert(alignof(struct AlignedStruct) =3D=3D 16, "align");
+
+[[gnu::aligned(16)]] static int aligned_var;
+
+[[maybe_unused]] [[nodiscard]] static int multi_attr(void)
+{
+	return 0;
+}
+
+[[maybe_unused, nodiscard]] static int comma_attr(void)
+{
+	return 0;
+}
+
+[[]] static int empty_attr;
+[[
+	,
+]] static int empty_attr2;
+
+static int test_statements(int val)
+{
+	[[maybe_unused]] int x =3D val;
+	if (x < 0)
+		goto lbl1;
+	switch (x) {
+	case 1:
+		x++;
+		[[fallthrough]];
+	case 2:
+		return x;
+	[[maybe_unused]] case 3:
+		return 3;
+	[[maybe_unused]] default:
+		break;
+	}
+
+lbl1:
+	[[]];
+[[maybe_unused]] lbl2:
+	[[maybe_unused]] int y =3D 10;
+	if (!y)
+		goto T_attr_label;
+[[maybe_unused]] T_attr_label:
+	return y;
+}
+
+[[clang::annotate_type("ptr_attr", void *)]] static int *vendor_attr_var=
;
+[[vendor::custom(struct foo, (1 + 2))]] static int vendor_attr_var2;
+
+static void fn_after_ident [[deprecated]] (void)
+{
+}
+
+static int arr_after_ident [[maybe_unused]] [4];
+
+/*
+ * check-name: C23 [[]] standard attribute syntax
+ * check-command: sparse -std=3Dc23 $file
+ */
diff --git a/validation/c23-param-attribute.c b/validation/c23-param-attr=
ibute.c
new file mode 100644
index 000000000000..a89c025ed002
--- /dev/null
+++ b/validation/c23-param-attribute.c
@@ -0,0 +1,28 @@
+/*
+ * Check that function declarators properly parse parameter lists
+ * where parameters have standard C23 attributes.
+ */
+
+static void f1([[maybe_unused]] int x)
+{
+}
+
+static int f2([[maybe_unused]] int a, [[maybe_unused]] int b)
+{
+	return a;
+}
+
+static void (*fp)([[maybe_unused]] int);
+
+static void test_call(void)
+{
+	f1(10);
+	f2(1, 2);
+	fp =3D f1;
+	fp(20);
+}
+
+/*
+ * check-name: C23 parameter attributes
+ * check-command: sparse -std=3Dc23 $file
+ */
