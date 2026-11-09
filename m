Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256436;
	b=bpbKCXdG6PCr7qfvy2Eazlo/48EE88VVXFaDqCXWE8Uenwc38gohdccDZNrJ6pKqFQwl
	 Jij4uToKi2TC2dagFfDTOZvjov3IRc6ZH2DpBfFHI9gQf5lP0pqv3dJYDoPnQPPqqROLv
	 L7bgIZ60JPefRxQ/l2hNMTss0KFqLqt1tlwrgFXHmFC/aaWpsqjtZ2XLggxYV5xVUi87a
	 NP7XCBzHJRSMG1iZC9rXPZ3jn+gSXDxiIaMch4t1Uj4XS+qFVKMUwQ7odID81XJO03kTK
	 6s34dtm/WlY65WDJrAZZkYaYK6P5PSLpIsI3vjBWBckR5b/nRKjaNo8Q6DXOj00tSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Go4KUPFVEM09Z19vVz/BZGVFeRzdMUdInvW9lVLJtvM=;
	b=kzgDLyMgZVva0UFjgR8esQSUO2B12mnFuaxCLYcZvjfOOyh0GtnGOeSp8hbDEk5HXUbk
	 QIIDT7fpmsUc8pvF8bOVR1kgbxeQ6220EXEqBjpmzyp3X2RcsdhWWsJtTtO5hghrUEwMo
	 fsNWDh8NNoSPYqu7uYzScVXzESk+vLFdDQWHl+5KXEmakG1Q/VKq3tlf1DLzxZFe1sD7G
	 xdGZdNrYwRn/EURDn/rJsG2H9zfGRqJW0/5NGxftSoyIcZ2+WJjQp44RLgRot61LdRvGf
	 vfNFXQwTRyIP5c3OQWtUu8CiRWUNyfrm40lxSRMxR6qhjr3cCDk2Rj3V92zXc25waIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kDPjurER;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52211606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52211606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=kDPjurER
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMJ0wr4z1XMYJK;
	Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=Go4KU
	PFVEM09Z19vVz/BZGVFeRzdMUdInvW9lVLJtvM=; b=kDPjurERfIW6DHhbaW48N
	DTNyeLBv0PYzRnECdjka6oncmGNh3DGJc0PFsMkGFXWNp8cZRs/4gURo8j/xtIyT
	md/rJKzIypTb3LSFyg8DNAYc97369SubjxwWiLqYF3cstMl1L13zvhZKPTm9WNJq
	77AR5U/xzK7HgET1ESYo+hK5TOu6hwnb0O/7bMYTsV1vMPFRjePy3OlPCc0RqBlT
	VH3NKH0wSC/AzNavu7DBBS89lF5p3pC+xI69ee/P9ZQH3V2TvlwdWleurbF+SRkw
	32Y37szFE0okc7pzNSFvNc6mKQ7KCBPKqb++GB5eSSDabYh2isBKqWiuj0nXxPPa
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SNjp3iaPaH5T; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM629N9z1XMYJV;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 63/73] enum: Support __attribute__((packed)) on enumeration types
Date: Mon,  9 Nov 2026 12:32:49 -0800
Message-ID: <20261109203259.362845-64-bvanassche@acm.org>
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

Support GCC/Clang __attribute__((packed)) on enumeration types so
packed enums select the narrowest integer type fitting their range:
- Define get_enum_base_type() and record the enumerator range on the
  enum symbol so prefix and postfix packed attributes shrink the enum
  size and alignment.
- Preserve sym->packed across subsequent tag lookups with '|=3D' instead
  of '=3D'.
- Warn when both 'packed' and 'aligned' attributes are applied to an
  enum type since Clang and GCC treat that combination differently, and
  diagnose array element types whose size is not a multiple of their
  alignment in examine_array_type().
- Avoid overwriting invalid (&bad_ctype), incomplete, bitwise
  (SYM_RESTRICT), mode-attributed, or C23 fixed-underlying-type enums.
- Add regression tests in validation/enum-packed.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                  | 92 +++++++++++++++++-----------------------
 symbol.c                 | 87 ++++++++++++++++++++++++++++++++++---
 symbol.h                 | 10 +++++
 validation/enum-packed.c | 85 +++++++++++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+), 60 deletions(-)
 create mode 100644 validation/enum-packed.c

diff --git a/parse.c b/parse.c
index b686d2d55c36..3235274e6659 100644
--- a/parse.c
+++ b/parse.c
@@ -891,6 +891,8 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 				sym->rank =3D underlying->rank;
 			}
 			token =3D handle_attributes(token, &attr);
+			sym->packed |=3D attr.packed;
+			sym->has_aligned |=3D attr.has_aligned;
 			if (!match_op(token, '{')) {
 				ctx->opaque_fixed_enum =3D 1;
 				ctx->opaque_fixed_enum_pos =3D colon_pos;
@@ -972,6 +974,8 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 		return token;
 	}
=20
+	sym->packed |=3D attr.packed;
+	sym->has_aligned |=3D attr.has_aligned;
 	token =3D parse(token->next, sym);
 	token =3D expect(token, '}', "at end of specifier");
 	sym->defined =3D 1;
@@ -979,7 +983,11 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 	attr.ctype.base_type =3D sym;
 	token =3D handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
-	sym->packed =3D attr.packed;
+	sym->packed |=3D attr.packed;
+	sym->has_aligned |=3D attr.has_aligned;
+	if (sym->type =3D=3D SYM_ENUM && sym->packed && sym->has_aligned)
+		warning(sym->pos,
+			"Clang and GCC treat 'packed' and 'aligned' attributes on enum types =
differently");
 	if (attr.designated_init) {
 		if (sym->type =3D=3D SYM_STRUCT)
 			sym->designated_init =3D 1;
@@ -1006,6 +1014,16 @@ static struct token *struct_union_enum_specifier(e=
num type type,
 			sym->rank =3D mtype->rank;
 		}
 	}
+	if (sym->type =3D=3D SYM_ENUM && sym->packed && !sym->fixed_type &&
+	    !sym->has_mode && sym->ctype.base_type &&
+	    is_int_type(sym->ctype.base_type)) {
+		struct symbol *base =3D get_enum_base_type(sym->range, 1);
+		if (base && base !=3D &bad_ctype) {
+			sym->ctype.base_type =3D base;
+			sym->ctype.modifiers &=3D ~MOD_SIGNEDNESS;
+			sym->ctype.modifiers |=3D (base->ctype.modifiers & MOD_SIGNEDNESS);
+		}
+	}
=20
 	sym->endpos =3D token->pos;
=20
@@ -1045,24 +1063,6 @@ static struct token *union_specifier(struct token =
*token, struct symbol *sym, st
 	return struct_union_enum_specifier(SYM_UNION, token, ctx, parse_union_d=
eclaration);
 }
=20
-///
-// safe right shift
-//
-// This allow to use a shift amount as big (or bigger)
-// than the width of the value to be shifted, in which case
-// the result is, of course, 0.
-static unsigned long long rshift(unsigned long long val, unsigned int n)
-{
-	if (n >=3D (sizeof(val) * 8))
-		return 0;
-	return val >> n;
-}
-
-struct range {
-	long long		neg;
-	unsigned long long	pos;
-};
-
 static void update_range(struct range *range, unsigned long long uval, s=
truct symbol *vtype)
 {
 	long long sval =3D uval;
@@ -1076,24 +1076,6 @@ static void update_range(struct range *range, unsi=
gned long long uval, struct sy
 	}
 }
=20
-static int type_is_ok(struct symbol *type, struct range range)
-{
-	int shift =3D type->bit_size;
-	int is_unsigned =3D type->ctype.modifiers & MOD_UNSIGNED;
-
-	if (!is_unsigned)
-		shift--;
-	if (rshift(range.pos, shift))
-		return 0;
-	if (range.neg =3D=3D 0)
-		return 1;
-	if (is_unsigned)
-		return 0;
-	if (rshift(~range.neg, shift))
-		return 0;
-	return 1;
-}
-
 static struct range type_range(struct symbol *type)
 {
 	struct range range;
@@ -1315,20 +1297,9 @@ static struct token *parse_enum_declaration(struct=
 token *token, struct symbol *
 			base_type =3D &bad_ctype;
 		} else if (!is_int_type(base_type))
 			;
-		else if (type_is_ok(&uint_ctype, range))
-			base_type =3D &uint_ctype;
-		else if (type_is_ok(&int_ctype, range))
-			base_type =3D &int_ctype;
-		else if (type_is_ok(&ulong_ctype, range))
-			base_type =3D &ulong_ctype;
-		else if (type_is_ok(&long_ctype, range))
-			base_type =3D &long_ctype;
-		else if (type_is_ok(&ullong_ctype, range))
-			base_type =3D &ullong_ctype;
-		else if (type_is_ok(&llong_ctype, range))
-			base_type =3D &llong_ctype;
 		else
-			base_type =3D &bad_ctype;
+			base_type =3D get_enum_base_type(range, parent->packed);
+		parent->range =3D range;
 		parent->ctype.base_type =3D base_type;
 		parent->ctype.modifiers |=3D
 			(base_type->ctype.modifiers & MOD_UNSIGNED);
@@ -1491,10 +1462,9 @@ static struct token *ignore_attribute(struct token=
 *token, struct symbol *attr,
=20
 static struct token *attribute_packed(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
-	if (!ctx->ctype.alignment) {
+	if (!ctx->ctype.alignment)
 		ctx->ctype.alignment =3D 1;
-		ctx->packed =3D 1;
-	}
+	ctx->packed =3D 1;
 	return token;
 }
=20
@@ -1513,6 +1483,7 @@ static struct token *attribute_aligned(struct token=
 *token, struct symbol *attr,
 		return token;
 	} else if (alignment > ctx->ctype.alignment)
 		ctx->ctype.alignment =3D alignment;
+	ctx->has_aligned =3D 1;
 	return token;
 }
=20
@@ -2004,6 +1975,8 @@ static struct token *declaration_specifiers(struct =
token *token, struct decl_sta
 			seen |=3D Set_S | Set_T;
 			ctx->ctype.base_type =3D s->ctype.base_type;
 			apply_ctype(token->pos, &ctx->ctype, &s->ctype);
+			if (s->ctype.alignment > ctx->typedef_alignment)
+				ctx->typedef_alignment =3D s->ctype.alignment;
 			token =3D token->next;
 			continue;
 		}
@@ -2422,12 +2395,14 @@ static struct token *direct_declarator(struct tok=
en *token, struct decl_state *c
 	} else if (match_op(token, '(') &&
 	    is_nested(token, &next, ctx->prefer_abstract)) {
 		struct symbol *base_type =3D ctype->base_type;
+		unsigned int saved_td_align =3D ctx->typedef_alignment;
 		if (token->next !=3D next)
 			next =3D handle_attributes(token->next, ctx);
 		token =3D declarator(next, ctx);
 		token =3D expect(token, ')', "in nested declarator");
 		while (ctype->base_type !=3D base_type)
 			ctype =3D &ctype->base_type->ctype;
+		ctx->typedef_alignment =3D saved_td_align;
 		p =3D NULL;
 	}
=20
@@ -2459,6 +2434,7 @@ static struct token *direct_declarator(struct token=
 *token, struct decl_state *c
 		return token;
 	}
=20
+	bool saw_array =3D false;
 	while (match_op(token, '[') && !match_c23_attribute(token)) {
 		struct symbol *array;
 		array =3D alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
@@ -2466,9 +2442,12 @@ static struct token *direct_declarator(struct toke=
n *token, struct decl_state *c
 		token =3D expect(token, ']', "in abstract_array_declarator");
 		array->endpos =3D token->pos;
 		ctype =3D &array->ctype;
+		saw_array =3D true;
 		if (match_c23_attribute(token))
 			token =3D handle_attributes(token, ctx);
 	}
+	if (saw_array && ctx->typedef_alignment > ctype->alignment)
+		ctype->alignment =3D ctx->typedef_alignment;
 	return token;
 }
=20
@@ -2485,6 +2464,7 @@ static struct token *pointer(struct token *token, s=
truct decl_state *ctx)
 		ctx->ctype.as =3D NULL;
 		ctx->ctype.contexts =3D NULL;
 		ctx->ctype.alignment =3D 0;
+		ctx->typedef_alignment =3D 0;
=20
 		token =3D handle_qualifiers(token->next, ctx);
 		ctx->ctype.base_type->endpos =3D token->pos;
@@ -2553,6 +2533,7 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 	struct decl_state ctx =3D {.prefer_abstract =3D 0};
 	struct ctype saved;
 	unsigned long mod;
+	unsigned int saved_td_align;
=20
 	token =3D declaration_specifiers(token, &ctx);
 	if (ctx.opaque_fixed_enum)
@@ -2560,10 +2541,12 @@ static struct token *declaration_list(struct toke=
n *token, struct symbol_list **
 			     "'enum' underlying type may not be specified here");
 	mod =3D decl_modifiers(&ctx);
 	saved =3D ctx.ctype;
+	saved_td_align =3D ctx.typedef_alignment;
 	for (;;) {
 		struct symbol *decl =3D alloc_symbol(token->pos, SYM_NODE);
 		ctx.cleanup =3D NULL;
 		ctx.ident_modifiers =3D 0;
+		ctx.typedef_alignment =3D saved_td_align;
 		ctx.ident =3D &decl->ident;
=20
 		token =3D declarator(token, &ctx);
@@ -3801,6 +3784,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 	struct decl_state ctx =3D { .ident =3D &ident };
 	struct ctype saved;
 	unsigned long saved_f_modifiers;
+	unsigned int saved_td_align;
 	struct symbol *base_type;
 	unsigned long mod;
 	int is_typedef;
@@ -3840,6 +3824,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
=20
 	saved =3D ctx.ctype;
 	saved_f_modifiers =3D ctx.f_modifiers;
+	saved_td_align =3D ctx.typedef_alignment;
 	token =3D declarator(token, &ctx);
 	token =3D handle_asm_name(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
@@ -4108,6 +4093,7 @@ struct token *external_declaration(struct token *to=
ken, struct symbol_list **lis
 		ctx.cleanup =3D NULL;
 		ctx.ident_modifiers =3D 0;
 		ctx.f_modifiers =3D saved_f_modifiers;
+		ctx.typedef_alignment =3D saved_td_align;
 		token =3D handle_attributes(token, &ctx);
 		token =3D declarator(token, &ctx);
 		token =3D handle_asm_name(token, &ctx);
diff --git a/symbol.c b/symbol.c
index d4b945d9e161..69fb0670c341 100644
--- a/symbol.c
+++ b/symbol.c
@@ -352,6 +352,7 @@ static struct symbol * examine_array_type(struct symb=
ol *sym)
 	struct symbol *base_type =3D examine_base_type(sym);
 	unsigned long bit_size =3D -1, alignment;
 	struct expression *array_size =3D sym->array_size;
+	int elem_size;
=20
 	if (!base_type)
 		return sym;
@@ -376,8 +377,13 @@ static struct symbol * examine_array_type(struct sym=
bol *sym)
 	if (has_flexible_array(base_type) && Wflexible_array_array)
 		warning(sym->pos, "array of flexible structures");
 	alignment =3D base_type->ctype.alignment;
-	if (!sym->ctype.alignment)
+	if (!sym->ctype.alignment || sym->ctype.alignment < alignment)
 		sym->ctype.alignment =3D alignment;
+	elem_size =3D bits_to_bytes(base_type->bit_size);
+	if (elem_size > 0 && sym->ctype.alignment &&
+	    (elem_size % sym->ctype.alignment))
+		sparse_error(sym->pos,
+			     "size of array element is not a multiple of its alignment");
 	sym->bit_size =3D bit_size;
 	return sym;
 }
@@ -587,25 +593,92 @@ static struct symbol * examine_node_type(struct sym=
bol *sym)
 	return sym;
 }
=20
+static unsigned long long rshift(unsigned long long val, unsigned int n)
+{
+	if (n >=3D (sizeof(val) * 8))
+		return 0;
+	return val >> n;
+}
+
+static int type_is_ok(struct symbol *type, struct range range)
+{
+	int shift =3D type->bit_size;
+	int is_unsigned =3D type->ctype.modifiers & MOD_UNSIGNED;
+
+	if (!is_unsigned)
+		shift--;
+	if (rshift(range.pos, shift))
+		return 0;
+	if (range.neg =3D=3D 0)
+		return 1;
+	if (is_unsigned)
+		return 0;
+	if (rshift(~range.neg, shift))
+		return 0;
+	return 1;
+}
+
+struct symbol *get_enum_base_type(struct range range, int packed)
+{
+	if (packed) {
+		if (type_is_ok(&uchar_ctype, range))
+			return &uchar_ctype;
+		if (type_is_ok(&schar_ctype, range))
+			return &schar_ctype;
+		if (type_is_ok(&ushort_ctype, range))
+			return &ushort_ctype;
+		if (type_is_ok(&short_ctype, range))
+			return &short_ctype;
+	}
+	if (type_is_ok(&uint_ctype, range))
+		return &uint_ctype;
+	if (type_is_ok(&int_ctype, range))
+		return &int_ctype;
+	if (type_is_ok(&ulong_ctype, range))
+		return &ulong_ctype;
+	if (type_is_ok(&long_ctype, range))
+		return &long_ctype;
+	if (type_is_ok(&ullong_ctype, range))
+		return &ullong_ctype;
+	if (type_is_ok(&llong_ctype, range))
+		return &llong_ctype;
+	return &bad_ctype;
+}
+
 static struct symbol *examine_enum_type(struct symbol *sym)
 {
-	struct symbol *base_type =3D examine_base_type(sym);
+	struct symbol *base_type;
+	unsigned long alignment;
+
+	if (sym->packed && !sym->fixed_type && !sym->has_mode &&
+	    sym->ctype.base_type && is_int_type(sym->ctype.base_type) &&
+	    sym->ctype.base_type !=3D &incomplete_ctype) {
+		base_type =3D get_enum_base_type(sym->range, 1);
+		if (base_type && base_type !=3D &bad_ctype) {
+			sym->ctype.base_type =3D base_type;
+			sym->ctype.modifiers &=3D ~MOD_SIGNEDNESS;
+			sym->ctype.modifiers |=3D (base_type->ctype.modifiers & MOD_SIGNEDNES=
S);
+		}
+	}
+	base_type =3D examine_base_type(sym);
=20
 	sym->ctype.modifiers |=3D (base_type->ctype.modifiers & MOD_SIGNEDNESS)=
;
-	if (sym->fixed_type || sym->has_mode) {
+	if (sym->fixed_type || sym->packed || sym->has_mode) {
 		if (base_type =3D=3D &bool_ctype)
 			sym->bit_size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
 		else
 			sym->bit_size =3D base_type->bit_size;
-		sym->ctype.alignment =3D base_type->ctype.alignment;
+		alignment =3D base_type->ctype.alignment;
 	} else {
 		sym->bit_size =3D bits_in_enum;
 		if (base_type->bit_size > sym->bit_size)
 			sym->bit_size =3D base_type->bit_size;
-		sym->ctype.alignment =3D enum_alignment;
-		if (base_type->ctype.alignment > sym->ctype.alignment)
-			sym->ctype.alignment =3D base_type->ctype.alignment;
+		alignment =3D enum_alignment;
+		if (base_type->ctype.alignment > alignment)
+			alignment =3D base_type->ctype.alignment;
 	}
+	if (sym->ctype.alignment < alignment)
+		sym->ctype.alignment =3D alignment;
 	sym->rank =3D base_type->rank;
 	return sym;
 }
diff --git a/symbol.h b/symbol.h
index aa180ac4f514..691213a0b454 100644
--- a/symbol.h
+++ b/symbol.h
@@ -87,6 +87,11 @@ enum keyword {
 	KW_EXACT	=3D 1 << 9,
 };
=20
+struct range {
+	long long		neg;
+	unsigned long long	pos;
+};
+
 struct context {
 	struct expression *context;
 	unsigned int in, out;
@@ -112,10 +117,12 @@ struct decl_state {
 	unsigned long f_modifiers;		// function attributes
 	unsigned long ident_modifiers;		// declarator-id C23 attributes
 	unsigned long storage_class;
+	unsigned int typedef_alignment;
 	unsigned char prefer_abstract;
 	unsigned char autotype;
 	unsigned char forced;
 	unsigned char packed;
+	unsigned char has_aligned;
 	unsigned char has_auto;
 	unsigned char has_alignas;
 	unsigned char is_constexpr;
@@ -215,6 +222,7 @@ struct symbol {
 			unsigned int underspecified : 1;
 			unsigned int c23_auto : 1;
 			unsigned int has_mode : 1;
+			unsigned int has_aligned : 1;
 			int		rank:3;	// arithmetic's rank
 			struct expression *array_size;
 			struct ctype ctype;
@@ -225,6 +233,7 @@ struct symbol {
 			struct symbol_list *inline_symbol_list;
 			struct expression *initializer;
 			struct expression *cleanup;
+			struct range range;
 			struct entrypoint *ep;
 			struct symbol *definition;
 		};
@@ -373,6 +382,7 @@ extern void bind_symbol_with_scope(struct symbol *, s=
truct ident *, enum namespa
 extern struct symbol *strip_array_qualifiers(struct symbol *);
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
+extern struct symbol *get_enum_base_type(struct range range, int packed)=
;
 extern const char *show_as(struct ident *as);
 extern const char *show_typename(struct symbol *sym);
 extern const char *builtin_typename(struct symbol *sym);
diff --git a/validation/enum-packed.c b/validation/enum-packed.c
new file mode 100644
index 000000000000..4d1ba40a2781
--- /dev/null
+++ b/validation/enum-packed.c
@@ -0,0 +1,85 @@
+/*
+ * Check that __attribute__((packed)) on enums selects the smallest
+ * integer type that can hold all enumerator values.
+ */
+
+enum e_u8 {
+	U8_0 =3D 0,
+	U8_1 =3D 200,
+} __attribute__((packed));
+
+enum e_s8 {
+	S8_0 =3D -10,
+	S8_1 =3D 100,
+} __attribute__((packed));
+
+enum __attribute__((packed)) e_u16 {
+	U16_0 =3D 0,
+	U16_1 =3D 1000,
+};
+
+enum e_s16 {
+	S16_0 =3D -1000,
+	S16_1 =3D 50,
+} __attribute__((__packed__));
+
+enum e_u32 {
+	U32_0 =3D 0,
+	U32_1 =3D 70000,
+} __attribute__((packed));
+
+_Static_assert(sizeof(enum e_u8) =3D=3D 1, "e_u8 size");
+_Static_assert(_Alignof(enum e_u8) =3D=3D 1, "e_u8 align");
+_Static_assert(sizeof(enum e_s8) =3D=3D 1, "e_s8 size");
+_Static_assert(_Alignof(enum e_s8) =3D=3D 1, "e_s8 align");
+
+_Static_assert(sizeof(enum e_u16) =3D=3D 2, "e_u16 size");
+_Static_assert(_Alignof(enum e_u16) =3D=3D 2, "e_u16 align");
+_Static_assert(sizeof(enum e_s16) =3D=3D 2, "e_s16 size");
+_Static_assert(_Alignof(enum e_s16) =3D=3D 2, "e_s16 align");
+
+_Static_assert(sizeof(enum e_u32) =3D=3D 4, "e_u32 size");
+
+/* Subsequent tag lookups must not clear the packed flag */
+static enum e_u8 var_u8;
+static enum e_u16 var_u16;
+_Static_assert(sizeof(var_u8) =3D=3D 1, "var_u8 size");
+_Static_assert(sizeof(var_u16) =3D=3D 2, "var_u16 size");
+
+enum __attribute__((aligned(2), packed)) e_aligned_packed {
+	AP_0 =3D 0,
+};
+_Static_assert(sizeof(enum e_aligned_packed) =3D=3D 1, "e_aligned_packed=
 size");
+_Static_assert(_Alignof(enum e_aligned_packed) =3D=3D 2, "e_aligned_pack=
ed align");
+
+static enum e_aligned_packed bad_enum_arr[2];
+typedef char __attribute__((aligned(2))) aligned_char;
+static aligned_char bad_char_arr[2];
+static aligned_char *ok_char_ptr_arr[2];
+__attribute__((aligned(16))) static char ok_aligned_arr[2];
+static enum e_u8 ok_u8_arr[4];
+
+enum __attribute__((packed, mode(__SI__))) e_packed_si {
+	PSI_0 =3D 0,
+};
+_Static_assert(sizeof(enum e_packed_si) =3D=3D 4, "mode overrides packed=
");
+
+enum __attribute__((packed)) e_fixed_packed : int {
+	EFP_0 =3D 0,
+};
+_Static_assert(sizeof(enum e_fixed_packed) =3D=3D sizeof(int),
+	       "fixed type overrides packed");
+
+_Static_assert(sizeof(U8_0) =3D=3D sizeof(int), "enumerator has int size=
");
+_Static_assert(sizeof(S8_0) =3D=3D sizeof(int), "enumerator has int size=
");
+
+/*
+ * check-name: packed enum support
+ * check-command: sparse $file
+ *
+ * check-error-start
+enum-packed.c:49:42: warning: Clang and GCC treat 'packed' and 'aligned'=
 attributes on enum types differently
+enum-packed.c:55:42: error: size of array element is not a multiple of i=
ts alignment
+enum-packed.c:57:33: error: size of array element is not a multiple of i=
ts alignment
+ * check-error-end
+ */
