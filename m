Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256440;
	b=rtcaufBs3EJaxIPtcEdA/B8pRJua9xL//wnHUEC8wByMFPTwQQK9cB+z8EIUk6nwZnLN
	 z5cd8ZmpQx/5Wqyu7uxsEMdBP3gQaQL9dRAcXmJacqMhoPp/cwOZK0D+BBFR0CGE7Bpjc
	 ztYn4KiroE4mKrMegtGquQT7ydN4Vy2HJ2cp5jH8d+eV4y+v94mP8f0Kc7jIWO26jBxEo
	 l4YGxTyqWR0AmLqu3dWwlvZLnh6i2a1jyzXlAQOZVMFKSAkWbitjwOiNg428tlJT6aYC+
	 d/aofRTwnlo0tuxaml+C4SkGamCJsXxf5Qd2JqyGNTnZhoBDWlkkopf07L5oci1mnUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=rKCPZn9KO7AucvZbZAozewzJSWMqApBBmAVJ5Hl7utQ=;
	b=FwA/T6Y0TrCFxGcr5wZ8Jq6BkiRJNCrJFD6Jp1W4ZjXcLK2/eeTui1HGbqEp0A88tasV
	 2B6ZPGpUXVQ7JwECtlAVkFlNa1IhF12ElPIaVkPMzs7I2k6RWUMWDxrd8OQ0Ln6kAeh9F
	 kAlDEYWrAQM+fJo4TZNnBRTdTPgGlZnhePap68jQL20bU1N/khmAr3l4j7FCv/qre2mE5
	 s0UC+y6ShChPaDL/W9NhS7tXpj4leOl3gL8W5Mq3ML98z7yiRmMzv+CWyOD/P5eMXQ06s
	 +FT7ch63/QbYuy7L+iU0OUo6IPZLmmermM+LkL/UUMTdt54w99TpdggNVGiheWJzrrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eE2WL5jE;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D9606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4D9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=eE2WL5jE
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMN4nCgz1XM6J7;
	Mon,  9 Nov 2026 20:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256417; x=1796848418; bh=rKCPZ
	n9KO7AucvZbZAozewzJSWMqApBBmAVJ5Hl7utQ=; b=eE2WL5jEQRBZd5TJQxXpU
	mo9UsWp7hDzZh9vxAFHjFnOSw6UbKTRknq8qrkPQiV3gxRTbA4740oi+MnIX9klp
	TVMim+J0WXaGcMrgx48Ddzq3QKjraKBV+W4i1xc0gs+z+NYB3EmncU80PgBBXFdJ
	0+1GpmyDr21QNgN6MKeAk160ExUkLnvTU3VdF3HKig4Z1o9Yj5TyGexrh4Dfn7Ur
	y82sSEj/MWlFGm5sv3puS1b2FukSi67BqBWMmElqO6bigTmqD478e+J9jpfa13Jj
	O+I1AoixI0iXnYvc5I3R7BVl9XD+i3kBpZflvLEB6okua0geF//OUZITXOjRyLb+
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t6u7WNaLOykj; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM34cVxz1XMYJp;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 51/73] c23: Support enumerations with fixed underlying types
Date: Mon,  9 Nov 2026 12:32:37 -0800
Message-ID: <20261109203259.362845-52-bvanassche@acm.org>
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

Implement ISO C23 enumerations with fixed underlying types
('enum [tag] : type { ... }' and standalone 'enum tag : type;'):
- Parse and canonicalize fixed integer underlying types, enforce
  redeclaration compatibility, and reject non-standalone opaque
  specifiers per C23 6.7.2.2p5.
- Disambiguate fixed-type ': type' from unnamed enum bit-fields and
  _Generic 'enum tag: expr' associations.
- Type enumerators per C23 6.7.2.2p12-13 in C23 mode (giving fixed-enum
  members the underlying type during and after the brace list, and giving
  unfixed-enum members 'int' only when the entire enum fits in 'int'),
  while preserving per-enumerator GNU typing in pre-C23 modes.
- Support bool-backed enums and diagnose ULLONG_MAX auto-increment
  overflow before wraparound.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                       |   2 +-
 expand.c                         |  13 +-
 parse.c                          | 269 +++++++++++++++++++++++++------
 symbol.c                         |  19 ++-
 symbol.h                         |  38 ++---
 validation/c23-enum-type-cast.c  |  70 ++++++++
 validation/c23-enum-type-error.c |  40 +++++
 validation/c23-enum-type.c       | 116 +++++++++++++
 8 files changed, 494 insertions(+), 73 deletions(-)
 create mode 100644 validation/c23-enum-type-cast.c
 create mode 100644 validation/c23-enum-type-error.c
 create mode 100644 validation/c23-enum-type.c

diff --git a/evaluate.c b/evaluate.c
index b7e352f55e6c..43ad5f59b860 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2486,7 +2486,7 @@ static struct symbol *evaluate_sizeof(struct expres=
sion *expr)
 	}
=20
 	if (is_bool_type(type)) {
-		if (Wsizeof_bool)
+		if (Wsizeof_bool && cbase_type(type) =3D=3D &bool_ctype)
 			warning(expr->pos, "expression using sizeof _Bool");
 		size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
 	}
diff --git a/expand.c b/expand.c
index 73b37b93534e..13a3bc0457ba 100644
--- a/expand.c
+++ b/expand.c
@@ -106,12 +106,23 @@ void cast_value(struct expression *expr, struct sym=
bol *newtype, struct expressi
 	// For pointers and integers, we can just move the value around
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D old->taint;
-	if (old_size =3D=3D new_size) {
+	if (old_size =3D=3D new_size && !is_bool_type(newtype)) {
 		expr->value =3D old->value;
 		expr->ctype =3D newtype;
 		return;
 	}
=20
+	if (is_bool_type(newtype)) {
+		bool non_zero =3D old->value !=3D 0;
+		bool is_one =3D old->value =3D=3D 1;
+		expr->ctype =3D newtype;
+		expr->value =3D non_zero;
+		if (!conservative && non_zero && !is_one)
+			warning(old->pos, "odd constant _Bool cast (%llx becomes 1)",
+				old->value);
+		return;
+	}
+
 	// expand it to the full "long long" value
 	value =3D get_longlong(old);
 	expr->ctype =3D newtype;
diff --git a/parse.c b/parse.c
index a7d31fad1a10..48793dd51671 100644
--- a/parse.c
+++ b/parse.c
@@ -50,6 +50,7 @@ struct statement_list *function_computed_goto_list;
=20
 static struct token *statement(struct token *token, struct statement **t=
ree);
 static struct token *handle_attributes(struct token *token, struct decl_=
state *ctx);
+static struct token *skip_attributes(struct token *token);
=20
 typedef struct token *declarator_t(struct token *, struct symbol *, stru=
ct decl_state *);
 static declarator_t
@@ -765,6 +766,32 @@ struct symbol *label_symbol(struct token *token, int=
 used)
 	return sym;
 }
=20
+static struct symbol *canonical_enum_underlying_type(struct symbol *sym)
+{
+	sym =3D cbase_type(sym);
+	if (sym =3D=3D &sshort_ctype)
+		return &short_ctype;
+	if (sym =3D=3D &sint_ctype)
+		return &int_ctype;
+	if (sym =3D=3D &slong_ctype)
+		return &long_ctype;
+	if (sym =3D=3D &sllong_ctype)
+		return &llong_ctype;
+	if (sym =3D=3D &sint128_ctype)
+		return &int128_ctype;
+	return sym;
+}
+
+static bool has_enum_type_specifier(struct token *token)
+{
+	struct token *next;
+
+	if (!match_op(token, ':'))
+		return false;
+	next =3D skip_attributes(token->next);
+	return lookup_type(next) !=3D 0;
+}
+
 static struct token *struct_union_enum_specifier(enum type type,
 	struct token *token, struct decl_state *ctx,
 	struct token *(*parse)(struct token *, struct symbol *))
@@ -778,7 +805,10 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 		sym =3D lookup_symbol(token->ident, NS_STRUCT);
 		if (!sym ||
 		    (is_outer_scope(sym->scope) &&
-		     (match_op(token->next,';') || match_op(token->next,'{')))) {
+		     (match_op(token->next, ';') ||
+		      match_op(token->next, '{') ||
+		      (type =3D=3D SYM_ENUM &&
+		       has_enum_type_specifier(token->next))))) {
 			// Either a new symbol, or else an out-of-scope
 			// symbol being redefined.
 			sym =3D alloc_symbol(token->pos, type);
@@ -789,6 +819,60 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 		ctx->ctype.base_type =3D sym;
 		repos =3D &token->pos;
 		token =3D token->next;
+
+		if (type =3D=3D SYM_ENUM && has_enum_type_specifier(token)) {
+			struct position colon_pos =3D token->pos;
+			struct symbol *underlying =3D NULL;
+			if (standard < STANDARD_C23 && Wpedantic)
+				warning(token->pos,
+					"ISO C does not support specifying 'enum' underlying types before C=
23");
+			token =3D typename(token->next, &underlying, NULL);
+			underlying =3D examine_symbol_type(underlying);
+			if (!underlying || !is_int_type(underlying) ||
+			    is_enum_type(underlying)) {
+				sparse_error(token->pos,
+					     "invalid 'enum' underlying type");
+				underlying =3D &int_ctype;
+			}
+			underlying =3D canonical_enum_underlying_type(underlying);
+			if (sym->fixed_type) {
+				if (canonical_enum_underlying_type(sym->ctype.base_type) !=3D
+				    underlying)
+					sparse_error(
+						token->pos,
+						"'enum' underlying type incompatible with previous declaration");
+			} else if (sym->examined || sym->symbol_list ||
+				   (sym->ctype.base_type =3D=3D
+				    &incomplete_ctype)) {
+				sparse_error(
+					token->pos,
+					"'enum' declared both with and without fixed underlying type");
+			} else {
+				sym->fixed_type =3D 1;
+				sym->ctype.base_type =3D underlying;
+				sym->ctype.modifiers |=3D
+					(underlying->ctype.modifiers &
+					 MOD_UNSIGNED);
+				if (underlying =3D=3D &bool_ctype)
+					sym->bit_size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
+				else
+					sym->bit_size =3D underlying->bit_size;
+				sym->ctype.alignment =3D
+					underlying->ctype.alignment;
+				sym->rank =3D underlying->rank;
+			}
+			token =3D handle_attributes(token, &attr);
+			if (!match_op(token, '{')) {
+				ctx->opaque_fixed_enum =3D 1;
+				ctx->opaque_fixed_enum_pos =3D colon_pos;
+			}
+		} else if (type =3D=3D SYM_ENUM && sym->fixed_type &&
+			   match_op(token, '{')) {
+			sparse_error(
+				token->pos,
+				"'enum' declared with but defined without fixed underlying type");
+		}
+
 		if (!match_op(token, '{')) {
 			if (attr.designated_init) {
 				if (sym->type =3D=3D SYM_STRUCT)
@@ -814,11 +898,44 @@ static struct token *struct_union_enum_specifier(en=
um type type,
=20
 		// Mark the structure as needing re-examination
 		sym->examined =3D 0;
-	} else if (match_op(token, '{')) {
+	} else if (match_op(token, '{') ||
+		   (type =3D=3D SYM_ENUM && match_op(token, ':'))) {
 		// private struct/union/enum type
 		sym =3D alloc_symbol(token->pos, type);
 		set_current_scope(sym);		// used by dissect
 		ctx->ctype.base_type =3D sym;
+		if (type =3D=3D SYM_ENUM && match_op(token, ':')) {
+			struct symbol *underlying =3D NULL;
+			if (standard < STANDARD_C23 && Wpedantic)
+				warning(token->pos,
+					"ISO C does not support specifying 'enum' underlying types before C=
23");
+			token =3D typename(token->next, &underlying, NULL);
+			underlying =3D examine_symbol_type(underlying);
+			if (!underlying || !is_int_type(underlying) ||
+			    is_enum_type(underlying)) {
+				sparse_error(token->pos,
+					     "invalid 'enum' underlying type");
+				underlying =3D &int_ctype;
+			}
+			underlying =3D canonical_enum_underlying_type(underlying);
+			sym->fixed_type =3D 1;
+			sym->ctype.base_type =3D underlying;
+			sym->ctype.modifiers |=3D
+				(underlying->ctype.modifiers & MOD_UNSIGNED);
+			if (underlying =3D=3D &bool_ctype)
+				sym->bit_size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
+			else
+				sym->bit_size =3D underlying->bit_size;
+			sym->ctype.alignment =3D underlying->ctype.alignment;
+			sym->rank =3D underlying->rank;
+			token =3D handle_attributes(token, &attr);
+			if (!match_op(token, '{')) {
+				sparse_error(
+					token->pos,
+					"expected '{' after enum type specifier");
+				return token;
+			}
+		}
 	} else {
 		sparse_error(token->pos, "expected declaration");
 		ctx->ctype.base_type =3D &bad_ctype;
@@ -941,8 +1058,8 @@ static struct range type_range(struct symbol *type)
 	long long min;
=20
 	if (is_signed_type(type)) {
-		min =3D sign_bit(size);
-		max =3D min - 1;
+		min =3D sign_extend(sign_bit(size), size);
+		max =3D sign_mask(size);
 	} else {
 		min =3D 0;
 		max =3D bits_mask(size);
@@ -963,24 +1080,37 @@ static int val_in_range(struct range *range, long =
long sval, struct symbol *vtyp
 		return uval <=3D range->pos;
 }
=20
-static void cast_enum_list(struct symbol_list *list, struct symbol *base=
_type)
+static void cast_enum_list(struct symbol_list *list, struct symbol *base=
_type,
+			   struct range range)
 {
 	struct range irange =3D type_range(&int_ctype);
+	struct symbol *target =3D base_type;
 	struct symbol *sym;
=20
+	if (is_int_type(base_type) && range.neg >=3D irange.neg &&
+	    range.pos <=3D irange.pos)
+		target =3D &int_ctype;
+
 	FOR_EACH_PTR(list, sym) {
 		struct expression *expr =3D sym->initializer;
 		struct symbol *ctype;
-		long long val;
+		struct symbol *etype =3D target;
+
 		if (expr->type !=3D EXPR_VALUE)
 			continue;
 		ctype =3D expr->ctype;
-		val =3D get_expression_value(expr);
-		if (is_int_type(ctype) && val_in_range(&irange, val, ctype)) {
-			expr->ctype =3D &int_ctype;
-			continue;
+		if (standard < STANDARD_C23 && etype !=3D &int_ctype &&
+		    is_int_type(ctype)) {
+			long long val =3D get_expression_value(expr);
+
+			if (!(is_signed_type(ctype) && val < 0) &&
+			    (unsigned long long)val <=3D irange.pos)
+				etype =3D &int_ctype;
 		}
-		cast_value(expr, base_type, expr);
+		if (!is_int_type(ctype) && etype =3D=3D &int_ctype)
+			continue;
+		cast_value(expr, etype, expr);
+		expr->ctype =3D etype;
 	} END_FOR_EACH_PTR(sym);
 }
=20
@@ -992,13 +1122,16 @@ static struct token *parse_enum_declaration(struct=
 token *token, struct symbol *
 	int mix_bitwise =3D 0;
=20
 	parent->examined =3D 1;
-	parent->ctype.base_type =3D &int_ctype;
+	if (parent->fixed_type)
+		base_type =3D parent->ctype.base_type;
+	else
+		parent->ctype.base_type =3D &int_ctype;
 	while (token_type(token) =3D=3D TOKEN_IDENT) {
 		struct expression *expr =3D NULL;
 		struct token *next =3D token->next;
 		struct decl_state ctx =3D { };
 		struct symbol *sym;
-		bool overflow =3D false;
+		bool overflowed =3D false;
=20
 		// FIXME: only 'deprecated' should be accepted
 		next =3D handle_attributes(next, &ctx);
@@ -1016,7 +1149,7 @@ static struct token *parse_enum_declaration(struct =
token *token, struct symbol *
 				ctype =3D &int_ctype;
 			}
 		} else if (!ctype) {
-			ctype =3D &int_ctype;
+			ctype =3D parent->fixed_type ? base_type : &int_ctype;
 		} else if (is_int_type(ctype)) {
 			struct range crange =3D type_range(ctype);
 			if (is_signed_type(ctype) && (long long)lastval =3D=3D crange.pos) {
@@ -1038,13 +1171,20 @@ static struct token *parse_enum_declaration(struc=
t token *token, struct symbol *
 				else if (ctype->bit_size < bits_in_longlong)
 					ctype =3D &ullong_ctype;
 				else {
-					sparse_error(token->pos,
-						"enumerator value for '%s' overflows",
-						show_ident(token->ident));
-					overflow =3D true;
+					if (parent->fixed_type)
+						sparse_error(
+							token->pos,
+							"enumerator value outside the range of underlying type");
+					else
+						sparse_error(
+							token->pos,
+							"enumerator value for '%s' overflows",
+							show_ident(token->ident));
+					ctype =3D &ullong_ctype;
+					overflowed =3D true;
 				}
 			}
-			if (!overflow)
+			if (!overflowed)
 				lastval++;
 		} else {
 			error_die(token->pos, "can't increment the last enum member");
@@ -1056,6 +1196,16 @@ static struct token *parse_enum_declaration(struct=
 token *token, struct symbol *
 			expr->ctype =3D ctype;
 		}
=20
+		if (parent->fixed_type) {
+			struct range urange =3D type_range(base_type);
+			if (!overflowed && !val_in_range(&urange, lastval, ctype))
+				sparse_error(
+					token->pos,
+					"enumerator value outside the range of underlying type");
+			cast_value(expr, base_type, expr);
+			ctype =3D base_type;
+		}
+
 		sym =3D alloc_symbol(token->pos, SYM_NODE);
 		bind_symbol(sym, token->ident, NS_SYMBOL);
 		sym->ctype.modifiers &=3D ~MOD_ADDRESSABLE;
@@ -1064,7 +1214,7 @@ static struct token *parse_enum_declaration(struct =
token *token, struct symbol *
 		sym->ctype.base_type =3D parent;
 		add_ptr_list(&parent->symbol_list, sym);
=20
-		if (base_type !=3D &bad_ctype) {
+		if (!parent->fixed_type && base_type !=3D &bad_ctype) {
 			if (ctype->type =3D=3D SYM_NODE)
 				ctype =3D ctype->ctype.base_type;
 			if (ctype->type =3D=3D SYM_ENUM) {
@@ -1104,7 +1254,7 @@ static struct token *parse_enum_declaration(struct =
token *token, struct symbol *
 			}
 			parent->ctype.base_type =3D base_type;
 		}
-		if (is_int_type(base_type)) {
+		if (!parent->fixed_type && is_int_type(base_type)) {
 			update_range(&range, lastval, ctype);
 		}
 		token =3D next;
@@ -1115,33 +1265,40 @@ static struct token *parse_enum_declaration(struc=
t token *token, struct symbol *
 			break;
 		token =3D token->next;
 	}
-	if (!base_type) {
-		sparse_error(token->pos, "empty enum definition");
-		base_type =3D &bad_ctype;
-	}
-	else if (!is_int_type(base_type))
-		;
-	else if (type_is_ok(&uint_ctype, range))
-		base_type =3D &uint_ctype;
-	else if (type_is_ok(&int_ctype, range))
-		base_type =3D &int_ctype;
-	else if (type_is_ok(&ulong_ctype, range))
-		base_type =3D &ulong_ctype;
-	else if (type_is_ok(&long_ctype, range))
-		base_type =3D &long_ctype;
-	else if (type_is_ok(&ullong_ctype, range))
-		base_type =3D &ullong_ctype;
-	else if (type_is_ok(&llong_ctype, range))
-		base_type =3D &llong_ctype;
-	else
-		base_type =3D &bad_ctype;
-	parent->ctype.base_type =3D base_type;
-	parent->ctype.modifiers |=3D (base_type->ctype.modifiers & MOD_UNSIGNED=
);
-	parent->examined =3D 0;
+	if (!parent->fixed_type) {
+		if (!base_type) {
+			sparse_error(token->pos, "empty enum definition");
+			base_type =3D &bad_ctype;
+		} else if (!is_int_type(base_type))
+			;
+		else if (type_is_ok(&uint_ctype, range))
+			base_type =3D &uint_ctype;
+		else if (type_is_ok(&int_ctype, range))
+			base_type =3D &int_ctype;
+		else if (type_is_ok(&ulong_ctype, range))
+			base_type =3D &ulong_ctype;
+		else if (type_is_ok(&long_ctype, range))
+			base_type =3D &long_ctype;
+		else if (type_is_ok(&ullong_ctype, range))
+			base_type =3D &ullong_ctype;
+		else if (type_is_ok(&llong_ctype, range))
+			base_type =3D &llong_ctype;
+		else
+			base_type =3D &bad_ctype;
+		parent->ctype.base_type =3D base_type;
+		parent->ctype.modifiers |=3D
+			(base_type->ctype.modifiers & MOD_UNSIGNED);
+		parent->examined =3D 0;
=20
-	if (mix_bitwise)
-		return token;
-	cast_enum_list(parent->symbol_list, base_type);
+		if (mix_bitwise)
+			return token;
+		cast_enum_list(parent->symbol_list, base_type, range);
+	} else {
+		if (!parent->symbol_list) {
+			sparse_error(token->pos, "empty enum definition");
+		}
+		parent->examined =3D 0;
+	}
=20
 	return token;
 }
@@ -2130,6 +2287,9 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 	unsigned long mod;
=20
 	token =3D declaration_specifiers(token, &ctx);
+	if (ctx.opaque_fixed_enum)
+		sparse_error(ctx.opaque_fixed_enum_pos,
+			     "'enum' underlying type may not be specified here");
 	mod =3D decl_modifiers(&ctx);
 	saved =3D ctx.ctype;
 	for (;;) {
@@ -2200,6 +2360,9 @@ static struct token *parameter_declaration(struct t=
oken *token, struct symbol *s
 	struct decl_state ctx =3D {.prefer_abstract =3D 1};
=20
 	token =3D declaration_specifiers(token, &ctx);
+	if (ctx.opaque_fixed_enum)
+		sparse_error(ctx.opaque_fixed_enum_pos,
+			     "'enum' underlying type may not be specified here");
 	ctx.ident =3D &sym->ident;
 	token =3D declarator(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
@@ -2240,6 +2403,9 @@ struct token *typename(struct token *token, struct =
symbol **p, int *forced)
 	token =3D declaration_specifiers(token, &ctx);
 	if (ctx.has_alignas)
 		sparse_error(sym->pos, "alignment specified for type name");
+	if (ctx.opaque_fixed_enum)
+		sparse_error(ctx.opaque_fixed_enum_pos,
+			     "'enum' underlying type may not be specified here");
 	if (ctx.autotype) {
 		sparse_error(sym->pos, "'%s' in type name",
 			     ctx.has_auto ? "auto" : "__auto_type");
@@ -3309,6 +3475,12 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 	decl =3D alloc_symbol(token->pos, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
+		if (ctx.opaque_fixed_enum &&
+		    (ctx.storage_class || (mod & ~MOD_UNUSED) ||
+		     ctx.ctype.modifiers || ctx.has_auto || ctx.is_constexpr))
+			sparse_error(
+				ctx.opaque_fixed_enum_pos,
+				"'enum' underlying type may not be specified here");
 		if (ctx.autotype)
 			sparse_error(token->pos, "%s in empty declaration",
 				     ctx.has_auto ? "auto" : "__auto_type");
@@ -3318,6 +3490,9 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		apply_modifiers(token->pos, &ctx);
 		return token->next;
 	}
+	if (ctx.opaque_fixed_enum)
+		sparse_error(ctx.opaque_fixed_enum_pos,
+			     "'enum' underlying type may not be specified here");
=20
 	saved =3D ctx.ctype;
 	token =3D declarator(token, &ctx);
diff --git a/symbol.c b/symbol.c
index fc11e1bbcec3..28fa12352569 100644
--- a/symbol.c
+++ b/symbol.c
@@ -584,12 +584,21 @@ static struct symbol *examine_enum_type(struct symb=
ol *sym)
 	struct symbol *base_type =3D examine_base_type(sym);
=20
 	sym->ctype.modifiers |=3D (base_type->ctype.modifiers & MOD_SIGNEDNESS)=
;
-	sym->bit_size =3D bits_in_enum;
-	if (base_type->bit_size > sym->bit_size)
-		sym->bit_size =3D base_type->bit_size;
-	sym->ctype.alignment =3D enum_alignment;
-	if (base_type->ctype.alignment > sym->ctype.alignment)
+	if (sym->fixed_type) {
+		if (base_type =3D=3D &bool_ctype)
+			sym->bit_size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
+		else
+			sym->bit_size =3D base_type->bit_size;
 		sym->ctype.alignment =3D base_type->ctype.alignment;
+	} else {
+		sym->bit_size =3D bits_in_enum;
+		if (base_type->bit_size > sym->bit_size)
+			sym->bit_size =3D base_type->bit_size;
+		sym->ctype.alignment =3D enum_alignment;
+		if (base_type->ctype.alignment > sym->ctype.alignment)
+			sym->ctype.alignment =3D base_type->ctype.alignment;
+	}
+	sym->rank =3D base_type->rank;
 	return sym;
 }
=20
diff --git a/symbol.h b/symbol.h
index f8556fdf3b86..8035d9d21b3c 100644
--- a/symbol.h
+++ b/symbol.h
@@ -120,6 +120,8 @@ struct decl_state {
 	unsigned char is_constexpr;
 	unsigned char designated_init;
 	unsigned char transparent_union;
+	unsigned char opaque_fixed_enum;
+	struct position opaque_fixed_enum_pos;
 };
=20
 struct pseudo;
@@ -186,22 +188,14 @@ struct symbol {
 		struct /* NS_SYMBOL */ {
 			unsigned long	offset;
 			int		bit_size;
-			unsigned int	bit_offset:8,
-					bogus_linear:1,
-					variadic:1,
-					initialized:1,
-					examined:1,
-					expanding:1,
-					evaluated:1,
-					has_flex_array:1,
-					string:1,
-					designated_init:1,
-					forced_arg:1,
-					accessed:1,
-					builtin:1,
-					torename:1,
-					packed:1,
-					transparent_union:1;
+			unsigned int bit_offset : 8, bogus_linear : 1,
+				variadic : 1, initialized : 1, examined : 1,
+				expanding : 1, evaluated : 1,
+				has_flex_array : 1, string : 1,
+				designated_init : 1, forced_arg : 1,
+				accessed : 1, builtin : 1, torename : 1,
+				packed : 1, transparent_union : 1,
+				fixed_type : 1;
 			unsigned int has_alignas : 1;
 			unsigned int underspecified : 1;
 			unsigned int c23_auto : 1;
@@ -435,6 +429,13 @@ static inline int is_func_type(struct symbol *type)
 	return type->type =3D=3D SYM_FN;
 }
=20
+static inline struct symbol *cbase_type(struct symbol *sym)
+{
+	while (sym && sym->type =3D=3D SYM_NODE)
+		sym =3D sym->ctype.base_type;
+	return sym;
+}
+
 static inline int is_array_type(struct symbol *type)
 {
 	if (type->type =3D=3D SYM_NODE)
@@ -484,9 +485,8 @@ static inline int is_void_type(struct symbol *type)
=20
 static inline int is_bool_type(struct symbol *type)
 {
-	if (type->type =3D=3D SYM_NODE)
-		type =3D type->ctype.base_type;
-	if (type->type =3D=3D SYM_BITFIELD)
+	while (type && (type->type =3D=3D SYM_NODE || type->type =3D=3D SYM_ENU=
M ||
+			type->type =3D=3D SYM_BITFIELD))
 		type =3D type->ctype.base_type;
 	return type =3D=3D &bool_ctype;
 }
diff --git a/validation/c23-enum-type-cast.c b/validation/c23-enum-type-c=
ast.c
new file mode 100644
index 000000000000..447a9882ca3e
--- /dev/null
+++ b/validation/c23-enum-type-cast.c
@@ -0,0 +1,70 @@
+/*
+ * Check enumerator types and explicit/implicit casts involving enums
+ * with fixed underlying types.
+ */
+
+enum E1 : unsigned long long {
+	A =3D 0,
+	B =3D 1ULL << 40,
+};
+
+_Static_assert(_Generic(A, unsigned long long: 1, default: 0) =3D=3D 1, =
"A type");
+_Static_assert(_Generic(B, unsigned long long: 1, default: 0) =3D=3D 1, =
"B type");
+_Static_assert(sizeof(A) =3D=3D sizeof(unsigned long long), "A size");
+_Static_assert(sizeof(B) =3D=3D sizeof(unsigned long long), "B size");
+_Static_assert(A =3D=3D 0, "A value");
+_Static_assert(B =3D=3D (1ULL << 40), "B value");
+_Static_assert((enum E1)(1ULL << 40) =3D=3D B, "cast to E1");
+_Static_assert((unsigned long long)B =3D=3D (1ULL << 40), "cast from B")=
;
+_Static_assert((short)A =3D=3D 0, "cast A to short");
+_Static_assert((unsigned short)B =3D=3D 0, "narrow cast B to ushort");
+
+enum E2 : long long {
+	C =3D -1LL,
+	D =3D 1LL << 40,
+};
+
+_Static_assert(_Generic(C, long long: 1, default: 0) =3D=3D 1, "C type")=
;
+_Static_assert(_Generic(D, long long: 1, default: 0) =3D=3D 1, "D type")=
;
+_Static_assert(sizeof(C) =3D=3D sizeof(long long), "C size");
+_Static_assert(sizeof(D) =3D=3D sizeof(long long), "D size");
+_Static_assert((enum E2)-1 =3D=3D C, "cast -1 to E2");
+
+enum U8 : unsigned char {
+	U8_ZERO =3D 0,
+};
+
+_Static_assert((enum U8)200 =3D=3D 200, "narrow u8 cast");
+_Static_assert((enum U8)258 =3D=3D 2, "out-of-range u8 cast wraps");
+_Static_assert((enum U8)-1 =3D=3D 255, "negative u8 cast wraps");
+_Static_assert(_Generic((enum U8)200, enum U8: 1, int: 0, default: 0) =3D=
=3D 1,
+	       "cast yields enum U8");
+_Static_assert(_Generic((enum U8)200, unsigned char: 1, int: 0, default:=
 0) =3D=3D 1,
+	       "enum U8 compatible with unsigned char");
+
+enum S8 : signed char {
+	S8_NEG =3D -1,
+};
+
+_Static_assert((enum S8)-128 =3D=3D -128, "narrow s8 cast");
+_Static_assert(_Generic((enum S8)0, signed char: 1, int: 0, default: 0) =
=3D=3D 1,
+	       "enum S8 compatible with signed char");
+
+enum B : bool {
+	B_FALSE =3D false,
+	B_TRUE =3D true,
+};
+
+_Static_assert((enum B)2 =3D=3D 1, "bool enum cast from 2");
+_Static_assert((enum B)-5 =3D=3D 1, "bool enum cast from -5");
+_Static_assert((enum B)0 =3D=3D 0, "bool enum cast from 0");
+
+/*
+ * check-name: C23 enum underlying type casting
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-enum-type-cast.c:20:32: warning: cast truncates bits from constant v=
alue (10000000000 becomes 0)
+c23-enum-type-cast.c:38:25: warning: cast truncates bits from constant v=
alue (102 becomes 2)
+ * check-error-end
+ */
diff --git a/validation/c23-enum-type-error.c b/validation/c23-enum-type-=
error.c
new file mode 100644
index 000000000000..3d2a9d5ec6a4
--- /dev/null
+++ b/validation/c23-enum-type-error.c
@@ -0,0 +1,40 @@
+enum E1 : char { A =3D 300 };
+enum E2 : unsigned char { B =3D -1 };
+enum E3 : unsigned char { C =3D 255, D };
+enum E4 : short;
+enum E4 : int;
+enum E5;
+enum E5 : short;
+enum E6 : short;
+enum E6 { F };
+enum E7 : float;
+enum E8 : bool { B0 =3D 0, B1, B2 };
+enum E9 : unsigned long long { UMAX =3D ~0ULL, UOVER };
+enum E10 : int bad_var;
+typedef enum E11 : short e11_t;
+void bad_enum_param(enum E12 : int p);
+int bad_enum_sizeof =3D sizeof(enum E13 : int);
+enum E14 : char;
+enum E14 : signed char;
+
+/*
+ * check-name: C23 enum with fixed underlying type errors
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-enum-type-error.c:1:18: error: enumerator value outside the range of=
 underlying type
+c23-enum-type-error.c:2:27: error: enumerator value outside the range of=
 underlying type
+c23-enum-type-error.c:3:36: error: enumerator value outside the range of=
 underlying type
+c23-enum-type-error.c:5:14: error: 'enum' underlying type incompatible w=
ith previous declaration
+c23-enum-type-error.c:7:16: error: 'enum' declared both with and without=
 fixed underlying type
+c23-enum-type-error.c:9:9: error: 'enum' declared with but defined witho=
ut fixed underlying type
+c23-enum-type-error.c:10:16: error: invalid 'enum' underlying type
+c23-enum-type-error.c:11:30: error: enumerator value outside the range o=
f underlying type
+c23-enum-type-error.c:12:46: error: enumerator value outside the range o=
f underlying type
+c23-enum-type-error.c:13:10: error: 'enum' underlying type may not be sp=
ecified here
+c23-enum-type-error.c:14:18: error: 'enum' underlying type may not be sp=
ecified here
+c23-enum-type-error.c:15:30: error: 'enum' underlying type may not be sp=
ecified here
+c23-enum-type-error.c:16:39: error: 'enum' underlying type may not be sp=
ecified here
+c23-enum-type-error.c:18:23: error: 'enum' underlying type incompatible =
with previous declaration
+ * check-error-end
+ */
diff --git a/validation/c23-enum-type.c b/validation/c23-enum-type.c
new file mode 100644
index 000000000000..03571bc99e06
--- /dev/null
+++ b/validation/c23-enum-type.c
@@ -0,0 +1,116 @@
+enum E_char : char {
+	A =3D 0,
+	B,
+};
+static_assert(sizeof(enum E_char) =3D=3D sizeof(char), "sizeof E_char");
+static_assert(sizeof(A) =3D=3D sizeof(char), "sizeof A");
+static_assert(A =3D=3D 0, "val A");
+static_assert(B =3D=3D 1, "val B");
+
+enum E_short : short;
+static_assert(sizeof(enum E_short) =3D=3D sizeof(short), "sizeof E_short=
 fwd");
+enum E_short : short {
+	C =3D 10,
+	D,
+};
+static_assert(sizeof(enum E_short) =3D=3D sizeof(short), "sizeof E_short=
 def");
+static_assert(sizeof(C) =3D=3D sizeof(short), "sizeof C");
+static_assert(C =3D=3D 10, "val C");
+static_assert(D =3D=3D 11, "val D");
+
+enum : unsigned long long {
+	ULL1 =3D 0x100000000ULL,
+	ULL2,
+};
+static_assert(sizeof(ULL1) =3D=3D sizeof(unsigned long long), "sizeof UL=
L1");
+static_assert(ULL1 =3D=3D 0x100000000ULL, "val ULL1");
+static_assert(ULL2 =3D=3D 0x100000001ULL, "val ULL2");
+
+enum E_redecl : int;
+enum E_redecl : signed int;
+enum E_redecl : int {
+	R1 =3D 100,
+	R2 =3D 200,
+};
+static_assert(sizeof(enum E_redecl) =3D=3D sizeof(int), "sizeof E_redecl=
");
+static_assert(R1 =3D=3D 100, "val R1");
+static_assert(R2 =3D=3D 200, "val R2");
+
+enum E_compat : signed short;
+enum E_compat : short {
+	EC1 =3D -10,
+};
+static_assert(sizeof(enum E_compat) =3D=3D sizeof(short), "sizeof E_comp=
at");
+static_assert(EC1 =3D=3D -10, "val EC1");
+
+enum E_signed : signed char {
+	NEG =3D -5,
+	NEG_PLUS_ONE,
+};
+static_assert(sizeof(enum E_signed) =3D=3D 1, "sizeof E_signed");
+static_assert(NEG =3D=3D -5, "val NEG");
+static_assert(NEG_PLUS_ONE =3D=3D -4, "val NEG_PLUS_ONE");
+
+enum E_uchar : unsigned char {
+	MAX_BYTE =3D 255,
+};
+static_assert(sizeof(enum E_uchar) =3D=3D 1, "sizeof E_uchar");
+static_assert(MAX_BYTE =3D=3D 255, "val MAX_BYTE");
+
+typedef unsigned short uint16_t;
+enum E_typedef : uint16_t {
+	T1 =3D 65535,
+};
+static_assert(sizeof(enum E_typedef) =3D=3D sizeof(uint16_t), "sizeof E_=
typedef");
+static_assert(T1 =3D=3D 65535, "val T1");
+
+enum E_bool : bool {
+	EB_FALSE,
+	EB_TRUE,
+};
+static_assert(sizeof(enum E_bool) =3D=3D sizeof(bool), "sizeof E_bool");
+static_assert(EB_FALSE =3D=3D 0 && EB_TRUE =3D=3D 1, "val E_bool");
+
+enum E_qual : const unsigned int {
+	EQ1 =3D 42,
+};
+static_assert(_Generic(EQ1, unsigned int: 1, default: 0) =3D=3D 1, "EQ1 =
type");
+
+enum E_brace : unsigned long long {
+	EB_A =3D 1,
+	EB_B =3D _Generic(EB_A, unsigned long long: 2, default: 0),
+};
+static_assert(EB_B =3D=3D 2, "inside-brace fixed type");
+static_assert(_Generic(EB_A, unsigned long long: 1, default: 0) =3D=3D 1=
,
+	      "after-brace fixed type");
+
+struct E_unnamed_bf {
+	enum E_uchar : 8;
+	int x;
+};
+static_assert(sizeof(struct E_unnamed_bf) >=3D sizeof(int), "unnamed enu=
m bitfield");
+
+enum E_unfixed_fit {
+	UF_A =3D 1U,
+};
+static_assert(_Generic(UF_A, int: 1, default: 0) =3D=3D 1, "unfixed fits=
 int");
+
+enum E_unfixed_wide {
+	UW_A =3D 1,
+	UW_B =3D ~0U,
+};
+static_assert(_Generic(UW_A, unsigned int: 1, default: 0) =3D=3D 1,
+	      "C23 unfixed wide enum gives all members underlying type");
+static_assert(_Generic(UW_B, unsigned int: 1, default: 0) =3D=3D 1,
+	      "C23 unfixed wide enum second member");
+
+enum FwdFixed : int;
+static int add_fwd_fixed_enum(enum FwdFixed x)
+{
+	return x + 1;
+}
+
+/*
+ * check-name: C23 enumerations with fixed underlying types
+ * check-command: sparse -std=3Dc23 $file
+ */
