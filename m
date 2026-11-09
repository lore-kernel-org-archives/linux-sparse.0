Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256422;
	b=zf6kbi1GhRk+aymd1io2VaULxB7R0K56vhliCKPmRqIL5XlBOVkumWv2ppJbPTSuENVb
	 ZtVDmxFElkbgWAQjtmKJIQWx6yAYVv6YuaZvqkPYXNkAjfhni0xIHGC70eLqxy+RHVr+w
	 a/YuSxU6ceiDV96cz22H8DVcYb8MuATS8vuK7DN1Ez56IMfQ1VThzlK5MkZdQXKJfi2DY
	 WEVdVIgpPZuDFKSXWo+7/la+nAFhnXzI8TSU1DhN6LxpjJycYR4J1ooLeW7LpM/un0aGC
	 DkhtySVbPcrqfwtlAtA5Qk2Sk66T/WipuEG2MHsklsP3tyXl+cuYSGOt6ecuyb5W8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=b/O6i0tLcPc5bETxpnHwHudH8iH8U/KyqR//y8QJD2A=;
	b=pWyQayIf1vyMr4lenpxMEtnR0s4IlF0hXR8sov9teqZ85EUcoo7sNIjDoNcB95LaFHOj
	 83jCYRwgtRWQ5zDoR4Qkk7j4sQKp4qXdxLLnzslZhsSaDkWnpco8NV8TEl8F5F7cd4NHX
	 B6gz2NIA4rrokn10oVrUJK6rcHBsdSVY+Lvx3INGNDdE1w9x5jK03FhWp52KlIkwKXUv0
	 4ZcDQY9P0Q3zji9oCKuZj7sVI/zQW4bOemMl2nEIcRaZUBfWpscnL152IvAh4eH2dGClA
	 CUUYCq2id1fYAxuiMZiq4+s+HpNBeMaEdsfIbTx+ZsEYlkJSRVpzirBGVd76UBbFgzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tAjA1FN6;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C437606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C437606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tAjA1FN6
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM61BQlz1XM0nl;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256410; x=1796848411; bh=b/O6i
	0tLcPc5bETxpnHwHudH8iH8U/KyqR//y8QJD2A=; b=tAjA1FN6mMYtbbEe2nwra
	HAGBFE/9V6ZHO+FPpr7/d6Un3pPO6G8j3IrZUHisLCmMYbFJZcUMIK7QZOl1vxmv
	YrGUMiWs/8tVcDRXGigxZ5ZZfq0/8JSdT5YFFm24GqlozYpKYG8NwxjiXCIhwY24
	G+qrHRKGH7/HVxjMmKkX9gI2HnR/4ULZ/DJoFnN0W408yc50fKtWCpRIxECEav0A
	eBSe1+JY79byJitISDVD/Ky/cRHDnJtpkgnvu5xNVlqXP1AUELrDMCfcx8mAq0qU
	T53ZqA1WVFvwsclYLmYiAdcG+IizkuRMh2Inr/6h1+39EC7RhsPUJOy340omQ+QY
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id X65DQCouF7mt; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLt3TMhz1XLyNK;
	Mon,  9 Nov 2026 20:33:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/73] parse, show-parse: Fix attribute propagation, enum overflow, and bounds
Date: Mon,  9 Nov 2026 12:31:56 -0800
Message-ID: <20261109203259.362845-11-bvanassche@acm.org>
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

Fix parser attribute handling, enumerator overflow promotion, and type
formatting bounds in expression.c, parse.c, show-parse.c, and symbol.h:
- Reject invalid integer suffixes and missing _Generic association
  expressions in expression.c.
- Propagate designated_init and transparent_union attributes on forward
  and post-brace tag declarations, promote overflowing enumerators while
  diagnosing ULLONG_MAX wraparound, validate alignment and address_space
  bounds, transfer context attributes across pointer return types, and
  guard null current_fn.
- Enlarge show-parse.c formatting buffers, reserve space for the trailing
  NUL byte, and route all type formatting through prepend() and append()
  with pointer-subtraction capacity checks.
- Add regression tests in validation/parser-type-fixes.c and
  validation/parser-enum-overflow.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expression.c                      | 16 +++++-
 parse.c                           | 81 ++++++++++++++++++++++++---
 show-parse.c                      | 61 ++++++++++++--------
 symbol.h                          |  2 +
 validation/parser-enum-overflow.c | 13 +++++
 validation/parser-type-fixes.c    | 93 +++++++++++++++++++++++++++++++
 6 files changed, 233 insertions(+), 33 deletions(-)
 create mode 100644 validation/parser-enum-overflow.c
 create mode 100644 validation/parser-type-fixes.c

diff --git a/expression.c b/expression.c
index 727e7056e460..04b1a242d08a 100644
--- a/expression.c
+++ b/expression.c
@@ -290,8 +290,12 @@ static void get_number_value(struct expression *expr=
, struct token *token)
 				size =3D 2;
 				end++;
 			}
-		} else
+		} else if (c =3D=3D '.' || c =3D=3D 'e' || c =3D=3D 'E' || c =3D=3D 'p=
' || c =3D=3D 'P' ||
+			   strchr(end, '.') || strchr(end, 'e') || strchr(end, 'E')) {
 			goto Float;
+		} else {
+			goto Enoint;
+		}
 	}
 	if (overflow)
 		goto Eoverflow;
@@ -402,8 +406,12 @@ static struct token *generic_selection(struct token =
*token, struct expression **
 			token =3D typename(token, &map->type, NULL);
 			token =3D expect(token, ':', "after typename");
 			token =3D assignment_expression(token, &map->expr);
-			*last =3D map;
-			last =3D &map->next;
+			if (!map->expr)
+				sparse_error(token->pos, "expected expression after ':'");
+			else {
+				*last =3D map;
+				last =3D &map->next;
+			}
 		} else if (match_ident(token, &default_ident)) {
 			if (expr->def) {
 				warning(token->pos, "multiple default in generic expression");
@@ -412,6 +420,8 @@ static struct token *generic_selection(struct token *=
token, struct expression **
 			token =3D token->next;
 			token =3D expect(token, ':', "after typename");
 			token =3D assignment_expression(token, &expr->def);
+			if (!expr->def)
+				sparse_error(token->pos, "expected expression after ':'");
 		}
 	}
 end:
diff --git a/parse.c b/parse.c
index f349cc75bff4..ea90d088a244 100644
--- a/parse.c
+++ b/parse.c
@@ -753,8 +753,21 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 		ctx->ctype.base_type =3D sym;
 		repos =3D &token->pos;
 		token =3D token->next;
-		if (!match_op(token, '{'))
+		if (!match_op(token, '{')) {
+			if (attr.designated_init) {
+				if (sym->type =3D=3D SYM_STRUCT)
+					sym->designated_init =3D 1;
+				else
+					warning(token->pos, "attribute designated_init applied to non-struc=
ture type");
+			}
+			if (attr.transparent_union) {
+				if (sym->type =3D=3D SYM_UNION)
+					sym->transparent_union =3D 1;
+				else
+					warning(token->pos, "attribute __transparent_union__ applied to non=
-union type");
+			}
 			return token;
+		}
=20
 		// The following test is actually wrong for empty
 		// structs, but (1) they are not C99, (2) gcc does
@@ -782,6 +795,18 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 	token =3D handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 	sym->packed =3D attr.packed;
+	if (attr.designated_init) {
+		if (sym->type =3D=3D SYM_STRUCT)
+			sym->designated_init =3D 1;
+		else
+			warning(token->pos, "attribute designated_init applied to non-structu=
re type");
+	}
+	if (attr.transparent_union) {
+		if (sym->type =3D=3D SYM_UNION)
+			sym->transparent_union =3D 1;
+		else
+			warning(token->pos, "attribute __transparent_union__ applied to non-u=
nion type");
+	}
=20
 	sym->endpos =3D token->pos;
=20
@@ -935,6 +960,7 @@ static struct token *parse_enum_declaration(struct to=
ken *token, struct symbol *
 		struct token *next =3D token->next;
 		struct decl_state ctx =3D { };
 		struct symbol *sym;
+		bool overflow =3D false;
=20
 		// FIXME: only 'deprecated' should be accepted
 		next =3D handle_attributes(next, &ctx);
@@ -948,14 +974,41 @@ static struct token *parse_enum_declaration(struct =
token *token, struct symbol *
 		} else if (!ctype) {
 			ctype =3D &int_ctype;
 		} else if (is_int_type(ctype)) {
-			lastval++;
+			struct range crange =3D type_range(ctype);
+			if (is_signed_type(ctype) && (long long)lastval =3D=3D crange.pos) {
+				if (ctype->bit_size < bits_in_int)
+					ctype =3D &int_ctype;
+				else if (ctype->bit_size < bits_in_long)
+					ctype =3D &long_ctype;
+				else if (ctype->bit_size < bits_in_longlong)
+					ctype =3D &llong_ctype;
+				else
+					ctype =3D &ullong_ctype;
+			} else if (!is_signed_type(ctype) && lastval =3D=3D crange.pos) {
+				if (ctype->bit_size < bits_in_int - 1)
+					ctype =3D &int_ctype;
+				else if (ctype->bit_size < bits_in_int)
+					ctype =3D &uint_ctype;
+				else if (ctype->bit_size < bits_in_long)
+					ctype =3D &ulong_ctype;
+				else if (ctype->bit_size < bits_in_longlong)
+					ctype =3D &ullong_ctype;
+				else {
+					sparse_error(token->pos,
+						"enumerator value for '%s' overflows",
+						show_ident(token->ident));
+					overflow =3D true;
+				}
+			}
+			if (!overflow)
+				lastval++;
 		} else {
 			error_die(token->pos, "can't increment the last enum member");
 		}
=20
 		if (!expr) {
 			expr =3D alloc_expression(token->pos, EXPR_VALUE);
-			expr->value =3D lastval;
+			expr->value =3D lastval & bits_mask(ctype->bit_size);
 			expr->ctype =3D ctype;
 		}
=20
@@ -1135,7 +1188,7 @@ static struct token *attribute_packed(struct token =
*token, struct symbol *attr,
=20
 static struct token *attribute_aligned(struct token *token, struct symbo=
l *attr, struct decl_state *ctx)
 {
-	int alignment =3D max_alignment;
+	long long alignment =3D max_alignment;
 	struct expression *expr =3D NULL;
=20
 	if (match_op(token, '(')) {
@@ -1143,7 +1196,7 @@ static struct token *attribute_aligned(struct token=
 *token, struct symbol *attr,
 		if (expr)
 			alignment =3D const_expression_value(expr);
 	}
-	if (alignment & (alignment-1)) {
+	if (alignment <=3D 0 || alignment > INT_MAX || (alignment & (alignment =
- 1))) {
 		warning(token->pos, "I don't like non-power-of-2 alignments");
 		return token;
 	} else if (alignment > ctx->ctype.alignment)
@@ -1222,7 +1275,7 @@ static struct token *attribute_address_space(struct=
 token *token, struct symbol
 	switch (token_type(token)) {
 	case TOKEN_NUMBER:
 		next =3D primary_expression(token, &expr);
-		if (expr->type !=3D EXPR_VALUE)
+		if (expr->type !=3D EXPR_VALUE || expr->value > INT_MAX)
 			goto invalid;
 		as =3D numerical_address_space(expr->value);
 		break;
@@ -1351,6 +1404,8 @@ static struct token *attribute_designated_init(stru=
ct token *token, struct symbo
 {
 	if (ctx->ctype.base_type && ctx->ctype.base_type->type =3D=3D SYM_STRUC=
T)
 		ctx->ctype.base_type->designated_init =3D 1;
+	else if (!ctx->ctype.base_type)
+		ctx->designated_init =3D 1;
 	else
 		warning(token->pos, "attribute designated_init applied to non-structur=
e type");
 	return token;
@@ -1363,6 +1418,8 @@ static struct token *attribute_transparent_union(st=
ruct token *token, struct sym
=20
 	if (ctx->ctype.base_type && ctx->ctype.base_type->type =3D=3D SYM_UNION=
)
 		ctx->ctype.base_type->transparent_union =3D 1;
+	else if (!ctx->ctype.base_type)
+		ctx->transparent_union =3D 1;
 	else
 		warning(token->pos, "attribute __transparent_union__ applied to non-un=
ion type");
 	return token;
@@ -1856,9 +1913,16 @@ static struct token *direct_declarator(struct toke=
n *token, struct decl_state *c
=20
 	if (match_op(token, '(')) {
 		enum kind kind =3D which_func(token, p, ctx->prefer_abstract);
-		struct symbol *fn;
+		struct symbol *fn, *walk;
 		fn =3D alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 		ctype->modifiers |=3D ctx->f_modifiers;
+		for (walk =3D fn->ctype.base_type; walk && walk->type =3D=3D SYM_PTR; =
walk =3D walk->ctype.base_type) {
+			if (walk->ctype.contexts) {
+				concat_ptr_list((struct ptr_list *)walk->ctype.contexts,
+						(struct ptr_list **)&ctype->contexts);
+				walk->ctype.contexts =3D NULL;
+			}
+		}
 		token =3D token->next;
 		if (kind =3D=3D K_R)
 			token =3D identifier_list(token, fn);
@@ -2440,7 +2504,8 @@ static void warn_label_usage(struct position def, s=
truct position use, struct id
 	const char *id =3D show_ident(ident);
 	sparse_error(use, "label '%s' used outside statement expression", id);
 	info(def, "   label '%s' defined here", id);
-	current_fn->bogus_linear =3D 1;
+	if (current_fn)
+		current_fn->bogus_linear =3D 1;
 }
=20
 void check_label_usage(struct symbol *label, struct position use_pos)
diff --git a/show-parse.c b/show-parse.c
index ceb6b3cb6f82..8ef59b5ee255 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -204,17 +204,27 @@ const char *show_as(struct ident *as)
 struct type_name {
 	char *start;
 	char *end;
+	char *buf_start;
+	char *buf_end;
 };
=20
 static void FORMAT_ATTR(2) prepend(struct type_name *name, const char *f=
mt, ...)
 {
-	static char buffer[512];
+	static char buffer[4096];
 	int n;
=20
 	va_list args;
 	va_start(args, fmt);
-	n =3D vsprintf(buffer, fmt, args);
+	n =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
+	if (n <=3D 0)
+		return;
+	if (n >=3D sizeof(buffer))
+		n =3D sizeof(buffer) - 1;
+	if (n > name->start - name->buf_start)
+		n =3D name->start - name->buf_start;
+	if (n <=3D 0)
+		return;
=20
 	name->start -=3D n;
 	memcpy(name->start, buffer, n);
@@ -222,13 +232,21 @@ static void FORMAT_ATTR(2) prepend(struct type_name=
 *name, const char *fmt, ...)
=20
 static void FORMAT_ATTR(2) append(struct type_name *name, const char *fm=
t, ...)
 {
-	static char buffer[512];
+	static char buffer[4096];
 	int n;
=20
 	va_list args;
 	va_start(args, fmt);
-	n =3D vsprintf(buffer, fmt, args);
+	n =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
+	if (n <=3D 0)
+		return;
+	if (n >=3D sizeof(buffer))
+		n =3D sizeof(buffer) - 1;
+	if (n > name->buf_end - name->end)
+		n =3D name->buf_end - name->end;
+	if (n <=3D 0)
+		return;
=20
 	memcpy(name->end, buffer, n);
 	name->end +=3D n;
@@ -314,17 +332,14 @@ deeper:
 	if (sym && (sym->type !=3D SYM_NODE && sym->type !=3D SYM_ARRAY &&
 		     sym->type !=3D SYM_BITFIELD)) {
 		const char *s;
-		size_t len;
=20
 		if (as)
 			prepend(name, "%s ", show_as(as));
=20
-		if (sym && (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_ENUM=
))
+		if (sym->type =3D=3D SYM_BASETYPE || sym->type =3D=3D SYM_ENUM)
 			mod &=3D ~MOD_SPECIFIER;
 		s =3D modifier_string(mod);
-		len =3D strlen(s);
-		name->start -=3D len;
-		memcpy(name->start, s, len);
+		prepend(name, "%s", s);
 		mod =3D 0;
 		as =3D NULL;
 	}
@@ -333,11 +348,9 @@ deeper:
 		goto out;
=20
 	if ((typename =3D builtin_typename(sym))) {
-		int len =3D strlen(typename);
 		if (name->start !=3D name->end)
-			*--name->start =3D ' ';
-		name->start -=3D len;
-		memcpy(name->start, typename, len);
+			prepend(name, " ");
+		prepend(name, "%s", typename);
 		goto out;
 	}
=20
@@ -362,13 +375,13 @@ deeper:
=20
 	case SYM_STRUCT:
 		if (name->start !=3D name->end)
-			*--name->start =3D ' ';
+			prepend(name, " ");
 		prepend(name, "struct %s", show_ident(sym->ident));
 		goto out;
=20
 	case SYM_UNION:
 		if (name->start !=3D name->end)
-			*--name->start =3D ' ';
+			prepend(name, " ");
 		prepend(name, "union %s", show_ident(sym->ident));
 		goto out;
=20
@@ -401,7 +414,7 @@ deeper:
 			append(name, " )");
 			was_ptr =3D 0;
 		}
-		append(name, "[%lld]", get_expression_value(sym->array_size));
+		append(name, "[%lld]", get_expression_value_silent(sym->array_size));
 		break;
=20
 	case SYM_RESTRICT:
@@ -410,7 +423,7 @@ deeper:
 			break;
 		}
 		if (name->start !=3D name->end)
-			*--name->start =3D ' ';
+			prepend(name, " ");
 		prepend(name, "restricted %s", show_ident(sym->ident));
 		goto out;
=20
@@ -420,7 +433,7 @@ deeper:
=20
 	default:
 		if (name->start !=3D name->end)
-			*--name->start =3D ' ';
+			prepend(name, " ");
 		prepend(name, "unknown type %d", sym->type);
 		goto out;
 	}
@@ -441,10 +454,12 @@ out:
=20
 void show_type(struct symbol *sym)
 {
-	char array[200];
+	char array[8192];
 	struct type_name name;
=20
-	name.start =3D name.end =3D array+100;
+	name.start =3D name.end =3D array + 4096;
+	name.buf_start =3D array;
+	name.buf_end =3D array + sizeof(array) - 1;
 	do_show_type(sym, &name);
 	*name.end =3D 0;
 	printf("%s", name.start);
@@ -452,10 +467,12 @@ void show_type(struct symbol *sym)
=20
 const char *show_typename(struct symbol *sym)
 {
-	static char array[200];
+	static char array[8192];
 	struct type_name name;
=20
-	name.start =3D name.end =3D array+100;
+	name.start =3D name.end =3D array + 4096;
+	name.buf_start =3D array;
+	name.buf_end =3D array + sizeof(array) - 1;
 	do_show_type(sym, &name);
 	*name.end =3D 0;
 	return name.start;
diff --git a/symbol.h b/symbol.h
index 9d657fbba260..9a8e58d5da28 100644
--- a/symbol.h
+++ b/symbol.h
@@ -115,6 +115,8 @@ struct decl_state {
 	unsigned char autotype;
 	unsigned char forced;
 	unsigned char packed;
+	unsigned char designated_init;
+	unsigned char transparent_union;
 };
=20
 struct pseudo;
diff --git a/validation/parser-enum-overflow.c b/validation/parser-enum-o=
verflow.c
new file mode 100644
index 000000000000..3e72a56b9e50
--- /dev/null
+++ b/validation/parser-enum-overflow.c
@@ -0,0 +1,13 @@
+enum {
+	E_ULLMAX =3D ~0ULL,
+	E_ULL_OVERFLOW,
+};
+
+/*
+ * check-name: parser-enum-overflow
+ * check-command: sparse $file
+ *
+ * check-error-start
+parser-enum-overflow.c:3:9: error: enumerator value for 'E_ULL_OVERFLOW'=
 overflows
+ * check-error-end
+ */
diff --git a/validation/parser-type-fixes.c b/validation/parser-type-fixe=
s.c
new file mode 100644
index 000000000000..dafcdd4a3f75
--- /dev/null
+++ b/validation/parser-type-fixes.c
@@ -0,0 +1,93 @@
+/* 1. designated_init propagation on forward and post-brace declarations=
 */
+struct __attribute__((designated_init)) s_fwd;
+struct s_fwd {
+	int a;
+	int b;
+};
+static struct s_fwd fwd_pos =3D { 1, 2 };
+static struct s_fwd fwd_des =3D { .a =3D 1, .b =3D 2 };
+
+struct s_post {
+	int a;
+	int b;
+} __attribute__((designated_init));
+static struct s_post post_pos =3D { 3, 4 };
+static struct s_post post_des =3D { .a =3D 3, .b =3D 4 };
+
+/* 2. transparent_union propagation on forward and post-brace declaratio=
ns */
+union __attribute__((__transparent_union__)) u_fwd;
+union u_fwd {
+	int *ip;
+	long *lp;
+};
+void take_u_fwd(union u_fwd u);
+
+union u_post {
+	int *ip;
+	long *lp;
+} __attribute__((__transparent_union__));
+void take_u_post(union u_post u);
+
+void call_transparent(int *ip, long *lp)
+{
+	take_u_fwd(ip);
+	take_u_fwd(lp);
+	take_u_post(ip);
+	take_u_post(lp);
+}
+
+/* 3. Function context attribute transferred through pointer return type=
 */
+int *acquire_ptr(void) __attribute__((context(0, 1)));
+
+void good_context(void)
+{
+	(void)acquire_ptr();
+	__context__(-1);
+}
+
+void bad_context(void)
+{
+	(void)acquire_ptr();
+}
+
+/* 4. typeof on restrict-qualified pointer */
+void typeof_restrict(int * restrict p)
+{
+	typeof(p) q =3D p;
+	(void)q;
+}
+
+/* 5. Sub-int enum auto-increment promotes to int before long/ulong */
+enum {
+	E_SCHAR =3D (signed char)127,
+	E_SCHAR_NEXT,
+	E_SHRT =3D (short)32767,
+	E_SHRT_NEXT,
+	E_UCHAR =3D (unsigned char)255,
+	E_UCHAR_NEXT,
+};
+_Static_assert(E_SCHAR_NEXT =3D=3D 128, "schar + 1");
+_Static_assert(__builtin_types_compatible_p(typeof(E_SCHAR_NEXT), int), =
"schar + 1 is int");
+_Static_assert(E_SHRT_NEXT =3D=3D 32768, "short + 1");
+_Static_assert(__builtin_types_compatible_p(typeof(E_SHRT_NEXT), int), "=
short + 1 is int");
+_Static_assert(E_UCHAR_NEXT =3D=3D 256, "uchar + 1");
+_Static_assert(__builtin_types_compatible_p(typeof(E_UCHAR_NEXT), int), =
"uchar + 1 is int");
+
+/* 6. Out-of-range address_space and aligned warnings */
+int __attribute__((address_space(0x100000000ULL))) *bad_as;
+int __attribute__((aligned(0x100000000ULL))) bad_align;
+
+/*
+ * check-name: parser-type-fixes
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+parser-type-fixes.c:77:34: warning: invalid address space name
+parser-type-fixes.c:78:43: warning: I don't like non-power-of-2 alignmen=
ts
+parser-type-fixes.c:7:33: warning: in initializer for fwd_pos: positiona=
l init of field in struct s_fwd, declared with attribute designated_init
+parser-type-fixes.c:7:36: warning: in initializer for fwd_pos: positiona=
l init of field in struct s_fwd, declared with attribute designated_init
+parser-type-fixes.c:14:35: warning: in initializer for post_pos: positio=
nal init of field in struct s_post, declared with attribute designated_in=
it
+parser-type-fixes.c:14:38: warning: in initializer for post_pos: positio=
nal init of field in struct s_post, declared with attribute designated_in=
it
+parser-type-fixes.c:48:6: warning: context imbalance in 'bad_context' - =
wrong count at exit
+ * check-error-end
+ */
