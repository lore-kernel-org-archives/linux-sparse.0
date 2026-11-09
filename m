Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256443;
	b=vTUaT8et2jSWDOzxJVcGDetP/d0UHPfRzY6XnezFaSCQjefn7rQg4XHwIRMqMHctxUIY
	 kYw9AYws0Vhq2n0s8WjMQmJDjXRtKMuKcZZL9qNg/msDL5c+jF5+ZVr/HwBNuOqDcXIBH
	 xuaQcQ42rM6093VWPexL0F5MKfHa7K1OpCvdcWameZR4crl+rluMp5dNilcvvbIm16Cff
	 MWIPAlmMOMbpl6tQOFPnAHUXe1vCcjOv/LkJRCeHmxKUV1ulNkkQFIkdEbUybLISrXNe+
	 1nTcfp6hWtSaa/KvuOPMVc+veEJLzE6fP74nAHEMkYyMdMt+tp5b2u9DJBOju9n4IWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=RvzvpqNqWXN09Fh+JWIJqAamBZhOXy81rhau8zJylJs=;
	b=gELsdOoGcQa5gdsxL3UdBvhI4q5j+XNq2TDnJlVQ2O+j2afxrMnz6MiRS263lhEiauv0
	 M5iIk8o5JkUz/qWH+OArvKWP8D8txvjxkKL7Oe/qFszG80TU4z7W0J2ieEyPierMFgO7A
	 m9WMxPpPqOEO5g6chGWBG4DxHrskdG9UF00Te+mATQ/z6PHCgoUcHeRaCr529dG2KccXO
	 OcbJa3rmu1QEYwFYIwAqhxt/1zYYvLCxbnb3dKxPATcqXeMfybR/O8gCn2zhNC4jZ332t
	 7AfiwDHXnsuB8qHpGSO3nZ/1tAkycD0AW1pqaRKEtMh+PqTNhpSauIukUJSVGTf66bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=iJkVBUOZ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1C0606A336
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1C0606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=iJkVBUOZ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMW4kTZz1XM0nl;
	Mon,  9 Nov 2026 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256419; x=1796848420; bh=Rvzvp
	qNqWXN09Fh+JWIJqAamBZhOXy81rhau8zJylJs=; b=iJkVBUOZaza5MH3ee4IPY
	QRgVDaeVs5934Yf+0FbuHJ6fOPblK2MS+eK9tf6QyNtmm/u9HfNnOgdbDxnofiYY
	ImCN9Fys85PRYmzNw6yKY4tqdvw53RIAHZ1tnDMmjBpmeLGeWXOjoIhuLr+VocZq
	B2evetpWQ/pWtLLZLpgqnm1Swmffhe2q2kk+hImCsErYjA4I95LBJL0ybb86ClOZ
	5/SAL656896RV9LWJi/MJwdcDvxuAJmXHnPHynRST5+2MIV33xYcpID0JaGvYT9D
	EAOv8oCvl+A560umT7UsrwZXoM22nl1p+DWlUrSliVxw/Ltctx97/H13cIxmbUrv
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id s6H6G3cxw73w; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM71Nt9z1XM5kt;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 67/73] builtin: Add support for __builtin_has_attribute()
Date: Mon,  9 Nov 2026 12:32:53 -0800
Message-ID: <20261109203259.362845-68-bvanassche@acm.org>
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

Implement EXPR_HAS_ATTRIBUTE to evaluate __builtin_has_attribute queries
at compile time across symbols, expressions, and anonymous type names:
- Distinguish __attribute__((const)) and [[unsequenced]] from pure via
  MOD_FCONST (0x80000000UL) and report const on const-qualified object
  declarations without conflating pure functions or pointer targets.
- Define MOD_NONSTRING (0x40000000) for the nonstring attribute instead o=
f
  ignoring it, and support nonstring in __builtin_has_attribute() so Linu=
x
  kernel strtomem_pad() static assertions succeed.
- Match GCC packed+aligned struct, union, bitfield, typedef, and _Alignas
  ABI layout via explicit_alignment on decl_state and symbol, and prevent
  typedef MOD_ALIGNED, MOD_WEAK, and MOD_NONSTRING modifiers from leaking
  onto pointers.
- Support bitwise SYM_RESTRICT types, struct member attribute queries
  without parent leakage, redeclaration attribute inheritance, and
  TOKEN_IDENT validation.

Add validation/struct-packed-aligned-layout.c,
validation/builtin-has-attribute-more.c,
validation/builtin-has-attribute-nonstring.c, and
validation/builtin-has-attribute-err.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ast-inspect.c                                |   1 +
 builtin.c                                    |   1 +
 c2xml.c                                      |  44 +++---
 dissect.c                                    |   4 +
 evaluate.c                                   |  36 ++++-
 expand.c                                     | 121 +++++++++++++-
 expression.c                                 |  82 ++++++++++
 expression.h                                 |   8 +
 gcc-attr-list.h                              |   2 -
 ident-list.h                                 |   1 +
 inline.c                                     |   6 +
 parse.c                                      | 108 ++++++++++---
 show-parse.c                                 |   5 +
 simplify.c                                   |   2 +-
 symbol.c                                     |  30 ++--
 symbol.h                                     |  20 ++-
 validation/builtin-has-attribute-err.c       |  19 +++
 validation/builtin-has-attribute-more.c      | 157 +++++++++++++++++++
 validation/builtin-has-attribute-nonstring.c |  35 +++++
 validation/builtins-kernel.c                 |  31 ++++
 validation/struct-packed-aligned-layout.c    | 135 ++++++++++++++++
 validation/weak-const-no-fold.c              |  15 ++
 22 files changed, 801 insertions(+), 62 deletions(-)
 create mode 100644 validation/builtin-has-attribute-err.c
 create mode 100644 validation/builtin-has-attribute-more.c
 create mode 100644 validation/builtin-has-attribute-nonstring.c
 create mode 100644 validation/struct-packed-aligned-layout.c
 create mode 100644 validation/weak-const-no-fold.c

diff --git a/ast-inspect.c b/ast-inspect.c
index e940a93a411e..578dfca0e1cf 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -180,6 +180,7 @@ static const char *expression_type_name(enum expressi=
on_type type)
 		[EXPR_FVALUE] =3D "EXPR_FVALUE",
 		[EXPR_SLICE] =3D "EXPR_SLICE",
 		[EXPR_OFFSETOF] =3D "EXPR_OFFSETOF",
+		[EXPR_HAS_ATTRIBUTE] =3D "EXPR_HAS_ATTRIBUTE",
 	};
 	return expression_type_name[type] ?: "UNKNOWN_EXPRESSION_TYPE";
 }
diff --git a/builtin.c b/builtin.c
index e8ea7721b771..34af6d82b846 100644
--- a/builtin.c
+++ b/builtin.c
@@ -900,6 +900,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_fmal", &ldouble_ctype, 0, { &ldouble_ctype, &ldouble_ctype=
, &ldouble_ctype }},
 	{ "__builtin_frame_address", &ptr_ctype, 0, { &uint_ctype }},
 	{ "__builtin_free", &void_ctype, 0, { &ptr_ctype }},
+	{ "__builtin_has_attribute", &int_ctype, 1 },
 	{ "__builtin_huge_val", &double_ctype, 0 },
 	{ "__builtin_huge_valf", &float_ctype, 0 },
 	{ "__builtin_huge_vall", &ldouble_ctype, 0 },
diff --git a/c2xml.c b/c2xml.c
index f23ec1a72de4..8abcadcd2320 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -113,34 +113,34 @@ static void examine_modifiers(struct symbol *sym, x=
mlNodePtr node)
 			"register",
 			"static",
 			"extern",
+			"toplevel",
+			"tls",
+			"inline",
+			"assigned",
+			"addressable",
 			"const",
 			"volatile",
+			"restrict",
+			"atomic",
 			"signed",
 			"unsigned",
-			"char",
-			"short",
-			"long",
-			"long-long",
-			"typedef",
-			NULL,
-			NULL,
-			NULL,
-			NULL,
-			NULL,
-			"inline",
-			"addressable",
+			"explicitly-signed",
+			"gnu-inline",
+			"user-type",
+			"constexpr",
+			"bitint",
+			"weak",
+			"aligned",
+			"unused",
+			"safe",
+			"pure",
+			"bitwise",
 			"nocast",
 			"noderef",
-			"accessed",
-			"toplevel",
-			"label",
-			"assigned",
-			"type-type",
-			"safe",
-			"user-type",
-			"force",
-			"explicitly-signed",
-			"bitwise"};
+			"noreturn",
+			"ext-visible",
+			"nonstring",
+			"fconst"};
=20
 	int i;
=20
diff --git a/dissect.c b/dissect.c
index 5d25e02fa1ad..7dd6161a29fa 100644
--- a/dissect.c
+++ b/dissect.c
@@ -483,6 +483,10 @@ again:
 			ret =3D do_expression(mode, expr->def);
 	}
=20
+	break; case EXPR_HAS_ATTRIBUTE:
+		if (expr->has_attr_expr)
+			do_expression(mode, expr->has_attr_expr);
+
 	break; case EXPR_SYMBOL:
 		ret =3D report_symbol(mode, expr);
 	}
diff --git a/evaluate.c b/evaluate.c
index 1c169ad60382..27bfe1c0fe88 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2433,7 +2433,8 @@ static struct symbol *evaluate_member_dereference(s=
truct expression *expr)
 	 * The member needs to take on the address space and modifiers of
 	 * the "parent" type.
 	 */
-	member =3D convert_to_as_mod(member, address_space, mod);
+	member =3D convert_to_as_mod(member, address_space,
+				    mod & (MOD_PTRINHERIT | MOD_CONSTEXPR));
 	ctype =3D get_base_type(member);
=20
 	if (!lvalue_expression(deref)) {
@@ -4098,6 +4099,39 @@ struct symbol *evaluate_expression(struct expressi=
on *expr)
 	case EXPR_GENERIC:
 		return evaluate_generic_selection(expr);
=20
+	case EXPR_HAS_ATTRIBUTE:
+		if (expr->has_attr_expr) {
+			struct expression *sub =3D expr->has_attr_expr;
+			while (sub && sub->type =3D=3D EXPR_PREOP && sub->op =3D=3D '(')
+				sub =3D sub->unop;
+			if (sub && sub->type =3D=3D EXPR_SYMBOL) {
+				expr->has_attr_decl =3D true;
+				evaluate_expression(expr->has_attr_expr);
+			} else if (sub && sub->type =3D=3D EXPR_DEREF) {
+				struct symbol *dctype =3D evaluate_expression(sub->deref);
+				if (dctype && sub->member) {
+					int offset =3D 0;
+					examine_symbol_type(dctype);
+					if (dctype->type =3D=3D SYM_NODE)
+						dctype =3D dctype->ctype.base_type;
+					if (dctype && (dctype->type =3D=3D SYM_STRUCT ||
+						       dctype->type =3D=3D SYM_UNION)) {
+						expr->has_attr_sym =3D find_identifier(
+							sub->member, dctype->symbol_list, &offset);
+						expr->has_attr_decl =3D true;
+					}
+				}
+				evaluate_expression(expr->has_attr_expr);
+			} else {
+				evaluate_expression(expr->has_attr_expr);
+			}
+		}
+		if (expr->has_attr_sym)
+			examine_symbol_type(expr->has_attr_sym);
+		expr->ctype =3D &int_ctype;
+		expr->flags =3D CEF_SET_ICE;
+		return &int_ctype;
+
 	/* These can not exist as stand-alone expressions */
 	case EXPR_INITIALIZER:
 	case EXPR_IDENTIFIER:
diff --git a/expand.c b/expand.c
index 57d3aeba0f4e..696662ad11ea 100644
--- a/expand.c
+++ b/expand.c
@@ -1011,7 +1011,7 @@ static struct expression *constant_symbol_value(str=
uct symbol *sym, int offset)
=20
 	if (offset < 0 || sym->expanding)
 		return NULL;
-	if (sym->ctype.modifiers & MOD_VOLATILE)
+	if (sym->ctype.modifiers & (MOD_VOLATILE | MOD_WEAK))
 		return NULL;
 	if ((sym->ctype.modifiers & MOD_ACCESS) &&
 	    !(sym->ctype.modifiers & MOD_CONSTEXPR))
@@ -1330,7 +1330,7 @@ static int expand_symbol_call(struct expression *ex=
pr, int cost)
 	if (ctype->op && ctype->op->expand)
 		return ctype->op->expand(expr, cost);
=20
-	if (ctype->ctype.modifiers & MOD_PURE)
+	if (ctype->ctype.modifiers & (MOD_PURE | MOD_FCONST))
 		return cost + 1;
=20
 	return SIDE_EFFECTS;
@@ -1502,6 +1502,120 @@ static void verify_nonoverlapping(struct expressi=
on_list **list, struct expressi
 	} END_FOR_EACH_PTR(b);
 }
=20
+static const char *normalize_attr_name(const char *name)
+{
+	static char buf[64];
+	size_t len;
+	if (!name)
+		return "";
+	len =3D strlen(name);
+	if (len >=3D 4 && name[0] =3D=3D '_' && name[1] =3D=3D '_' &&
+	    name[len-1] =3D=3D '_' && name[len-2] =3D=3D '_') {
+		if (len - 4 < sizeof(buf)) {
+			memcpy(buf, name + 2, len - 4);
+			buf[len - 4] =3D '\0';
+			return buf;
+		}
+	}
+	return name;
+}
+
+static bool is_fun_attr_name(const char *name)
+{
+	return !strcmp(name, "pure") || !strcmp(name, "reproducible") ||
+	       !strcmp(name, "const") || !strcmp(name, "unsequenced") ||
+	       !strcmp(name, "noreturn") || !strcmp(name, "_Noreturn") ||
+	       !strcmp(name, "gnu_inline");
+}
+
+static bool check_symbol_has_attr(struct symbol *sym, const char *name, =
bool is_decl)
+{
+	if (!sym || !name)
+		return false;
+
+	if (!strcmp(name, "packed"))
+		return sym->packed !=3D 0;
+	if (!strcmp(name, "aligned"))
+		return (sym->ctype.modifiers & MOD_ALIGNED) !=3D 0;
+	if (!strcmp(name, "weak"))
+		return (sym->ctype.modifiers & MOD_WEAK) !=3D 0;
+	if (!strcmp(name, "pure") || !strcmp(name, "reproducible"))
+		return (sym->ctype.modifiers & MOD_PURE) !=3D 0;
+	if (!strcmp(name, "unsequenced"))
+		return (sym->ctype.modifiers & MOD_FCONST) !=3D 0;
+	if (!strcmp(name, "const")) {
+		if (sym->ctype.modifiers & MOD_FCONST)
+			return true;
+		return is_decl && (sym->ctype.modifiers & MOD_CONST) !=3D 0;
+	}
+	if (!strcmp(name, "noreturn") || !strcmp(name, "_Noreturn"))
+		return (sym->ctype.modifiers & MOD_NORETURN) !=3D 0;
+	if (!strcmp(name, "noderef"))
+		return (sym->ctype.modifiers & MOD_NODEREF) !=3D 0;
+	if (!strcmp(name, "unused") || !strcmp(name, "maybe_unused"))
+		return (sym->ctype.modifiers & MOD_UNUSED) !=3D 0;
+	if (!strcmp(name, "externally_visible"))
+		return (sym->ctype.modifiers & MOD_EXT_VISIBLE) !=3D 0;
+	if (!strcmp(name, "gnu_inline"))
+		return (sym->ctype.modifiers & MOD_GNU_INLINE) !=3D 0;
+	if (!strcmp(name, "address_space"))
+		return sym->ctype.as !=3D NULL;
+	if (!strcmp(name, "bitwise"))
+		return (sym->ctype.modifiers & MOD_BITWISE) !=3D 0 ||
+		       sym->type =3D=3D SYM_RESTRICT;
+	if (!strcmp(name, "nocast"))
+		return (sym->ctype.modifiers & MOD_NOCAST) !=3D 0;
+	if (!strcmp(name, "transparent_union"))
+		return sym->transparent_union !=3D 0;
+	if (!strcmp(name, "designated_init"))
+		return sym->designated_init !=3D 0;
+	if (!strcmp(name, "nonstring"))
+		return (sym->ctype.modifiers & MOD_NONSTRING) !=3D 0;
+
+	return false;
+}
+
+static int expand_has_attribute(struct expression *expr)
+{
+	struct symbol *sym =3D expr->has_attr_sym;
+	struct expression *sub =3D expr->has_attr_expr;
+	struct ident *attr_id =3D expr->has_attr_ident;
+	const char *attr_name =3D attr_id ? normalize_attr_name(show_ident(attr=
_id)) : "";
+	bool has_attr =3D false;
+
+	if (!sym && sub) {
+		if (sub->type =3D=3D EXPR_PREOP && sub->op =3D=3D '*' &&
+		    sub->unop && sub->unop->type =3D=3D EXPR_SYMBOL)
+			sym =3D sub->unop->symbol;
+		else if (sub->type =3D=3D EXPR_SYMBOL)
+			sym =3D sub->symbol;
+		else if (sub->ctype)
+			sym =3D sub->ctype;
+	}
+
+	if (sym) {
+		bool is_decl =3D expr->has_attr_decl;
+		if (sym->type =3D=3D SYM_NODE && sym->ctype.base_type) {
+			struct symbol *base =3D sym->ctype.base_type;
+			if (check_symbol_has_attr(sym, attr_name, is_decl))
+				has_attr =3D true;
+			else if (base->type !=3D SYM_PTR)
+				has_attr =3D check_symbol_has_attr(base, attr_name, false);
+			else if (base->ctype.base_type &&
+				 base->ctype.base_type->type =3D=3D SYM_FN &&
+				 is_fun_attr_name(attr_name))
+				has_attr =3D check_symbol_has_attr(base, attr_name, false);
+		} else {
+			has_attr =3D check_symbol_has_attr(sym, attr_name, is_decl);
+		}
+	}
+
+	expr->type =3D EXPR_VALUE;
+	expr->value =3D has_attr ? 1 : 0;
+	expr->taint =3D 0;
+	return 0;
+}
+
 static int expand_expression(struct expression *expr)
 {
 	if (!expr)
@@ -1577,6 +1691,9 @@ static int expand_expression(struct expression *exp=
r)
 	case EXPR_INDEX:
 		return UNSAFE;
=20
+	case EXPR_HAS_ATTRIBUTE:
+		return expand_has_attribute(expr);
+
 	case EXPR_SLICE:
 		return expand_expression(expr->base) + 1;
=20
diff --git a/expression.c b/expression.c
index 15b9eca351cb..e6f58df84e39 100644
--- a/expression.c
+++ b/expression.c
@@ -185,6 +185,83 @@ static struct token *builtin_types_compatible_p_expr=
(struct token *token,
 	return token;
 }
=20
+static struct token *builtin_has_attribute_expr(struct token *token,
+						struct expression **tree)
+{
+	struct expression *expr =3D alloc_expression(token->pos, EXPR_HAS_ATTRI=
BUTE);
+	struct symbol *type_sym =3D NULL;
+	struct expression *val_expr =3D NULL;
+	struct ident *attr_ident =3D NULL;
+
+	token =3D token->next;
+	if (!match_op(token, '('))
+		return expect(token, '(', "after __builtin_has_attribute");
+	token =3D token->next;
+
+	if (lookup_type(token)) {
+		token =3D typename(token, &type_sym, NULL);
+		check_typename_storage(type_sym);
+	} else {
+		token =3D assignment_expression(token, &val_expr);
+	}
+
+	if (!match_op(token, ','))
+		return expect(token, ',', "in __builtin_has_attribute");
+	token =3D token->next;
+
+	if (token_type(token) =3D=3D TOKEN_IDENT &&
+	    (token->ident =3D=3D &__attribute_ident ||
+	     token->ident =3D=3D &__attribute___ident)) {
+		token =3D token->next;
+		if (match_op(token, '(')) {
+			int depth =3D 1;
+			token =3D token->next;
+			while (depth && !eof_token(token)) {
+				if (token_type(token) =3D=3D TOKEN_IDENT && !attr_ident)
+					attr_ident =3D token->ident;
+				if (token_type(token) =3D=3D TOKEN_SPECIAL) {
+					if (token->special =3D=3D '(')
+						depth++;
+					else if (token->special =3D=3D ')')
+						depth--;
+				}
+				token =3D token->next;
+			}
+		}
+		if (!attr_ident)
+			sparse_error(token->pos, "expected attribute name");
+	} else if (token_type(token) =3D=3D TOKEN_IDENT) {
+		attr_ident =3D token->ident;
+		token =3D token->next;
+		if (match_op(token, '(')) {
+			int depth =3D 1;
+			token =3D token->next;
+			while (depth && !eof_token(token)) {
+				if (token_type(token) =3D=3D TOKEN_SPECIAL) {
+					if (token->special =3D=3D '(')
+						depth++;
+					else if (token->special =3D=3D ')')
+						depth--;
+				}
+				token =3D token->next;
+			}
+		}
+	} else {
+		sparse_error(token->pos, "expected attribute name");
+		while (!eof_token(token) && !match_op(token, ')'))
+			token =3D token->next;
+	}
+
+	token =3D expect(token, ')', "at end of __builtin_has_attribute");
+
+	expr->has_attr_sym =3D type_sym;
+	expr->has_attr_expr =3D val_expr;
+	expr->has_attr_ident =3D attr_ident;
+	expr->flags =3D CEF_SET_ICE;
+	*tree =3D expr;
+	return token;
+}
+
 static struct token *builtin_offsetof_expr(struct token *token,
 					   struct expression **tree)
 {
@@ -765,6 +842,11 @@ struct token *primary_expression(struct token *token=
, struct expression **tree)
 			break;
 		}
=20
+		if (token->ident =3D=3D &__builtin_has_attribute_ident) {
+			token =3D builtin_has_attribute_expr(token, &expr);
+			break;
+		}
+
 		sym =3D lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
=20
 		if (!sym) {
diff --git a/expression.h b/expression.h
index 83857cffc7dc..747056fed5d4 100644
--- a/expression.h
+++ b/expression.h
@@ -65,6 +65,7 @@ enum expression_type {
 	EXPR_SLICE,
 	EXPR_OFFSETOF,
 	EXPR_GENERIC,
+	EXPR_HAS_ATTRIBUTE,
 };
=20
=20
@@ -265,6 +266,13 @@ struct expression {
 			struct expression *def;
 			struct type_expression *map;
 		};
+		// EXPR_HAS_ATTRIBUTE
+		struct {
+			struct symbol *has_attr_sym;
+			struct expression *has_attr_expr;
+			struct ident *has_attr_ident;
+			bool has_attr_decl;
+		};
 	};
 };
=20
diff --git a/gcc-attr-list.h b/gcc-attr-list.h
index 928ea3889e01..3db28e8cc592 100644
--- a/gcc-attr-list.h
+++ b/gcc-attr-list.h
@@ -127,7 +127,6 @@ GCC_ATTR(noipa)
 GCC_ATTR(nomicromips)
 GCC_ATTR(nomips16)
 GCC_ATTR(nonnull)
-GCC_ATTR(nonstring)
 GCC_ATTR(noplt)
 GCC_ATTR(nosave_low_regs)
 GCC_ATTR(not_nested)
@@ -204,6 +203,5 @@ GCC_ATTR(warn_if_not_aligned)
 GCC_ATTR(warn_unused)
 GCC_ATTR(warn_unused_result)
 GCC_ATTR(warning)
-GCC_ATTR(weak)
 GCC_ATTR(weakref)
 GCC_ATTR(zda)
diff --git a/ident-list.h b/ident-list.h
index 4427527580ee..c4a0179ca523 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -66,6 +66,7 @@ IDENT_RESERVED(__alignof__);
 IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
+IDENT(__builtin_has_attribute);
 IDENT_RESERVED(__label__);
 IDENT(gnu);
 IDENT(__gnu__);
diff --git a/inline.c b/inline.c
index d3f27952138b..c857cd953702 100644
--- a/inline.c
+++ b/inline.c
@@ -363,6 +363,12 @@ static struct expression * copy_expression(struct ex=
pression *expr)
 		break;
 	}
=20
+	case EXPR_HAS_ATTRIBUTE:
+		expr =3D dup_expression(expr);
+		if (expr->has_attr_expr)
+			expr->has_attr_expr =3D copy_expression(expr->has_attr_expr);
+		break;
+
 	default:
 		warning(expr->pos, "trying to copy expression type %d", expr->type);
 	}
diff --git a/parse.c b/parse.c
index 3235274e6659..7010d412fdab 100644
--- a/parse.c
+++ b/parse.c
@@ -587,6 +587,8 @@ static struct init_keyword {
 	D("unused",		&attr_mod_op,		.mods =3D MOD_UNUSED),
 	D("maybe_unused",	&attr_mod_op,		.mods =3D MOD_UNUSED),
 	D("externally_visible",	&attr_mod_op,		.mods =3D MOD_EXT_VISIBLE),
+	D("weak",		&attr_mod_op,		.mods =3D MOD_WEAK),
+	D("nonstring",		&attr_mod_op,		.mods =3D MOD_NONSTRING),
 	D("force",		&attr_force_op),
 	D("bitwise",		&attr_bitwise_op,	.mods =3D MOD_BITWISE),
 	D("address_space",	&address_space_op),
@@ -595,11 +597,11 @@ static struct init_keyword {
 	D("noreturn",		&attr_fun_op,		.mods =3D MOD_NORETURN),
 	D("_Noreturn",		&attr_fun_op,		.mods =3D MOD_NORETURN),
 	D("pure",		&attr_fun_op,		.mods =3D MOD_PURE),
-	A("const",		&attr_fun_op,		.mods =3D MOD_PURE),
+	A("const",		&attr_fun_op,		.mods =3D MOD_FCONST),
 	D("gnu_inline",		&attr_fun_op,		.mods =3D MOD_GNU_INLINE),
 	D("nodiscard",		&ignore_attr_op),
 	D("fallthrough",	&ignore_attr_op),
-	D("unsequenced",	&attr_fun_op,		.mods =3D MOD_PURE),
+	D("unsequenced",	&attr_fun_op,		.mods =3D MOD_FCONST),
 	D("reproducible",	&attr_fun_op,		.mods =3D MOD_PURE),
=20
 	/* Modes */
@@ -985,6 +987,8 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
 	sym->packed |=3D attr.packed;
 	sym->has_aligned |=3D attr.has_aligned;
+	if (attr.explicit_alignment > sym->explicit_alignment)
+		sym->explicit_alignment =3D attr.explicit_alignment;
 	if (sym->type =3D=3D SYM_ENUM && sym->packed && sym->has_aligned)
 		warning(sym->pos,
 			"Clang and GCC treat 'packed' and 'aligned' attributes on enum types =
differently");
@@ -1462,8 +1466,10 @@ static struct token *ignore_attribute(struct token=
 *token, struct symbol *attr,
=20
 static struct token *attribute_packed(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
-	if (!ctx->ctype.alignment)
+	if (!ctx->explicit_alignment)
 		ctx->ctype.alignment =3D 1;
+	else
+		ctx->ctype.alignment =3D ctx->explicit_alignment;
 	ctx->packed =3D 1;
 	return token;
 }
@@ -1481,9 +1487,17 @@ static struct token *attribute_aligned(struct toke=
n *token, struct symbol *attr,
 	if (alignment <=3D 0 || alignment > INT_MAX || (alignment & (alignment =
- 1))) {
 		warning(token->pos, "I don't like non-power-of-2 alignments");
 		return token;
-	} else if (alignment > ctx->ctype.alignment)
-		ctx->ctype.alignment =3D alignment;
+	} else {
+		if (alignment > ctx->explicit_alignment)
+			ctx->explicit_alignment =3D alignment;
+		if (ctx->packed)
+			ctx->ctype.alignment =3D ctx->explicit_alignment;
+		else if (alignment > ctx->ctype.alignment)
+			ctx->ctype.alignment =3D alignment;
+	}
 	ctx->has_aligned =3D 1;
+	ctx->ctype.modifiers |=3D MOD_ALIGNED;
+	ctx->typedef_mods &=3D ~MOD_ALIGNED;
 	return token;
 }
=20
@@ -1522,6 +1536,7 @@ static void apply_qualifier(struct position *pos, s=
truct ctype *ctx, unsigned lo
 static struct token *attribute_modifier(struct token *token, struct symb=
ol *attr, struct decl_state *ctx)
 {
 	apply_mod(&token->pos, &ctx->ctype.modifiers, attr->ctype.modifiers);
+	ctx->typedef_mods &=3D ~attr->ctype.modifiers;
 	return token;
 }
=20
@@ -1779,8 +1794,9 @@ static struct token *attribute_specifier(struct tok=
en *token, struct symbol *sym
=20
 static unsigned long decl_modifiers(struct decl_state *ctx)
 {
-	unsigned long mods =3D ctx->ctype.modifiers & MOD_DECLARE;
-	ctx->ctype.modifiers &=3D ~MOD_DECLARE;
+	unsigned long mask =3D MOD_DECLARE & ~ctx->typedef_mods;
+	unsigned long mods =3D ctx->ctype.modifiers & mask;
+	ctx->ctype.modifiers &=3D ~mask;
 	return ctx->storage_class | mods;
 }
=20
@@ -1853,8 +1869,16 @@ static struct token *alignas_specifier(struct toke=
n *token, struct symbol *sym,
 		warning(token->pos, "non-power-of-2 alignment");
 		return token;
 	}
-	if (alignment > ctx->ctype.alignment)
-		ctx->ctype.alignment =3D alignment;
+	if (alignment > 0) {
+		if ((unsigned int)alignment > ctx->explicit_alignment)
+			ctx->explicit_alignment =3D alignment;
+		if (ctx->packed)
+			ctx->ctype.alignment =3D ctx->explicit_alignment;
+		else if ((unsigned int)alignment > ctx->ctype.alignment)
+			ctx->ctype.alignment =3D alignment;
+		ctx->ctype.modifiers |=3D MOD_ALIGNED;
+		ctx->typedef_mods &=3D ~MOD_ALIGNED;
+	}
 	return token;
 }
=20
@@ -1972,9 +1996,12 @@ static struct token *declaration_specifiers(struct=
 token *token, struct decl_sta
 		if (s->type !=3D SYM_KEYWORD) {
 			if (seen & Set_Any)
 				break;
+			unsigned long prev_mods =3D ctx->ctype.modifiers;
 			seen |=3D Set_S | Set_T;
 			ctx->ctype.base_type =3D s->ctype.base_type;
 			apply_ctype(token->pos, &ctx->ctype, &s->ctype);
+			ctx->typedef_mods |=3D (s->ctype.modifiers & ~prev_mods) &
+					     (MOD_ALIGNED | MOD_WEAK | MOD_NONSTRING);
 			if (s->ctype.alignment > ctx->typedef_alignment)
 				ctx->typedef_alignment =3D s->ctype.alignment;
 			token =3D token->next;
@@ -2464,6 +2491,7 @@ static struct token *pointer(struct token *token, s=
truct decl_state *ctx)
 		ctx->ctype.as =3D NULL;
 		ctx->ctype.contexts =3D NULL;
 		ctx->ctype.alignment =3D 0;
+		ctx->explicit_alignment =3D 0;
 		ctx->typedef_alignment =3D 0;
=20
 		token =3D handle_qualifiers(token->next, ctx);
@@ -2528,12 +2556,28 @@ static struct token *handle_bitfield(struct token=
 *token, struct decl_state *ctx
 	return token;
 }
=20
+static void apply_fn_ptr_modifiers(struct symbol *decl, unsigned long f_=
modifiers)
+{
+	struct symbol *base;
+
+	if (!decl)
+		return;
+	f_modifiers |=3D decl->ctype.modifiers & MOD_FUN_ATTR;
+	if (!f_modifiers)
+		return;
+	base =3D decl->ctype.base_type;
+	if (base && base->type =3D=3D SYM_PTR &&
+	    base->ctype.base_type && base->ctype.base_type->type =3D=3D SYM_FN)
+		base->ctype.modifiers |=3D f_modifiers;
+}
+
 static struct token *declaration_list(struct token *token, struct symbol=
_list **list)
 {
 	struct decl_state ctx =3D {.prefer_abstract =3D 0};
 	struct ctype saved;
-	unsigned long mod;
-	unsigned int saved_td_align;
+	unsigned long mod, saved_f_modifiers;
+	unsigned int saved_explicit_alignment, saved_td_align;
+	unsigned char saved_packed;
=20
 	token =3D declaration_specifiers(token, &ctx);
 	if (ctx.opaque_fixed_enum)
@@ -2541,12 +2585,18 @@ static struct token *declaration_list(struct toke=
n *token, struct symbol_list **
 			     "'enum' underlying type may not be specified here");
 	mod =3D decl_modifiers(&ctx);
 	saved =3D ctx.ctype;
+	saved_packed =3D ctx.packed;
+	saved_explicit_alignment =3D ctx.explicit_alignment;
 	saved_td_align =3D ctx.typedef_alignment;
+	saved_f_modifiers =3D ctx.f_modifiers;
 	for (;;) {
 		struct symbol *decl =3D alloc_symbol(token->pos, SYM_NODE);
 		ctx.cleanup =3D NULL;
 		ctx.ident_modifiers =3D 0;
+		ctx.packed =3D saved_packed;
+		ctx.explicit_alignment =3D saved_explicit_alignment;
 		ctx.typedef_alignment =3D saved_td_align;
+		ctx.f_modifiers =3D saved_f_modifiers;
 		ctx.ident =3D &decl->ident;
=20
 		token =3D declarator(token, &ctx);
@@ -2560,6 +2610,9 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 		decl->ctype =3D ctx.ctype;
 		decl->ctype.modifiers |=3D mod;
 		decl->cleanup =3D ctx.cleanup;
+		decl->packed =3D ctx.packed;
+		decl->explicit_alignment =3D ctx.explicit_alignment;
+		apply_fn_ptr_modifiers(decl, ctx.f_modifiers);
 		decl->endpos =3D token->pos;
 		if (ctx.has_auto) {
 			sparse_error(
@@ -2623,6 +2676,9 @@ static struct token *parameter_declaration(struct t=
oken *token, struct symbol *s
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
 	sym->ctype.modifiers |=3D decl_modifiers(&ctx);
+	sym->packed =3D ctx.packed;
+	sym->explicit_alignment =3D ctx.explicit_alignment;
+	apply_fn_ptr_modifiers(sym, ctx.f_modifiers);
 	sym->endpos =3D token->pos;
 	sym->forced_arg =3D ctx.forced;
 	if (ctx.has_auto || ctx.autotype) {
@@ -2691,7 +2747,9 @@ struct token *typename(struct token *token, struct =
symbol **p, int *forced)
 	ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
+	sym->packed =3D ctx.packed;
 	sym->c23_auto =3D ctx.autotype && ctx.has_auto;
+	sym->explicit_alignment =3D ctx.explicit_alignment;
 	sym->endpos =3D token->pos;
 	if (ctx.storage_class =3D=3D MOD_USERTYPE)
 		sym->explicit_typedef =3D 1;
@@ -2702,6 +2760,10 @@ struct token *typename(struct token *token, struct=
 symbol **p, int *forced)
 		sym->ctype.modifiers |=3D MOD_CONSTEXPR;
 	}
 	sym->ctype.modifiers |=3D mod | decl_modifiers(&ctx);
+	if (sym->ctype.base_type && sym->ctype.base_type->type =3D=3D SYM_FN)
+		sym->ctype.modifiers |=3D ctx.f_modifiers;
+	else
+		apply_fn_ptr_modifiers(sym, ctx.f_modifiers);
 	if (forced)
 		*forced =3D ctx.forced;
 	return token;
@@ -3783,10 +3845,10 @@ struct token *external_declaration(struct token *=
token, struct symbol_list **lis
 	struct symbol *decl;
 	struct decl_state ctx =3D { .ident =3D &ident };
 	struct ctype saved;
-	unsigned long saved_f_modifiers;
-	unsigned int saved_td_align;
 	struct symbol *base_type;
-	unsigned long mod;
+	unsigned long mod, saved_f_modifiers;
+	unsigned int saved_explicit_alignment, saved_td_align;
+	unsigned char saved_packed;
 	int is_typedef;
 	bool delay_bind =3D false;
=20
@@ -3822,9 +3884,11 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		sparse_error(ctx.opaque_fixed_enum_pos,
 			     "'enum' underlying type may not be specified here");
=20
-	saved =3D ctx.ctype;
-	saved_f_modifiers =3D ctx.f_modifiers;
+	saved_packed =3D ctx.packed;
+	saved_explicit_alignment =3D ctx.explicit_alignment;
 	saved_td_align =3D ctx.typedef_alignment;
+	saved_f_modifiers =3D ctx.f_modifiers;
+	saved =3D ctx.ctype;
 	token =3D declarator(token, &ctx);
 	token =3D handle_asm_name(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
@@ -3834,7 +3898,10 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 	decl->ctype =3D ctx.ctype;
 	decl->ctype.modifiers |=3D mod;
 	decl->cleanup =3D ctx.cleanup;
+	decl->packed =3D ctx.packed;
 	decl->c23_auto =3D ctx.autotype && ctx.has_auto;
+	decl->explicit_alignment =3D ctx.explicit_alignment;
+	apply_fn_ptr_modifiers(decl, ctx.f_modifiers);
 	decl->endpos =3D token->pos;
=20
 	/* Just a type declaration? */
@@ -4089,11 +4156,13 @@ struct token *external_declaration(struct token *=
token, struct symbol_list **lis
 		token =3D token->next;
 		ident =3D NULL;
 		decl =3D alloc_symbol(token->pos, SYM_NODE);
+		ctx.packed =3D saved_packed;
+		ctx.explicit_alignment =3D saved_explicit_alignment;
+		ctx.typedef_alignment =3D saved_td_align;
+		ctx.f_modifiers =3D saved_f_modifiers;
 		ctx.ctype =3D saved;
 		ctx.cleanup =3D NULL;
 		ctx.ident_modifiers =3D 0;
-		ctx.f_modifiers =3D saved_f_modifiers;
-		ctx.typedef_alignment =3D saved_td_align;
 		token =3D handle_attributes(token, &ctx);
 		token =3D declarator(token, &ctx);
 		token =3D handle_asm_name(token, &ctx);
@@ -4103,7 +4172,10 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		decl->ctype =3D ctx.ctype;
 		decl->ctype.modifiers |=3D mod;
 		decl->cleanup =3D ctx.cleanup;
+		decl->packed =3D ctx.packed;
 		decl->c23_auto =3D ctx.autotype && ctx.has_auto;
+		decl->explicit_alignment =3D ctx.explicit_alignment;
+		apply_fn_ptr_modifiers(decl, ctx.f_modifiers);
 		decl->endpos =3D token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition=
");
diff --git a/show-parse.c b/show-parse.c
index 9ed95f141cfe..f44a5f052ae7 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -138,6 +138,7 @@ static const char *show_modifiers(unsigned long mod, =
int term)
 		{ MOD_NODEREF, "[noderef]" },
 		{ MOD_NORETURN, "[noreturn]" },
 		{ MOD_PURE, "[pure]" },
+		{ MOD_FCONST, "[const]" },
 		{ MOD_SAFE, "[safe]" },
 		{ MOD_SIGNED, "[signed]" },
 		{ MOD_TLS, "[tls]" },
@@ -145,6 +146,9 @@ static const char *show_modifiers(unsigned long mod, =
int term)
 		{ MOD_UNSIGNED, "[unsigned]" },
 		{ MOD_UNUSED, "[unused]" },
 		{ MOD_USERTYPE, "[usertype]" },
+		{ MOD_WEAK, "[weak]" },
+		{ MOD_ALIGNED, "[aligned]" },
+		{ MOD_NONSTRING, "[nonstring]" },
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(mod_names); i++) {
@@ -1188,6 +1192,7 @@ int show_expression(struct expression *expr)
 	case EXPR_PTRSIZEOF:
 	case EXPR_ALIGNOF:
 	case EXPR_OFFSETOF:
+	case EXPR_HAS_ATTRIBUTE:
 		warning(expr->pos, "invalid expression after evaluation");
 		return 0;
 	case EXPR_CAST:
diff --git a/simplify.c b/simplify.c
index 88f261da297e..b93fbf950d3d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -365,7 +365,7 @@ int kill_insn(struct instruction *insn, int force)
 			/* a "pure" function can be killed too */
 			struct symbol *fntype =3D first_symbol(insn->fntypes);
=20
-			if (!(fntype->ctype.modifiers & MOD_PURE))
+			if (!(fntype->ctype.modifiers & (MOD_PURE | MOD_FCONST)))
 				return 0;
 		}
 		kill_use_list(insn->arguments);
diff --git a/symbol.c b/symbol.c
index 69fb0670c341..d2f308519cdc 100644
--- a/symbol.c
+++ b/symbol.c
@@ -141,19 +141,23 @@ static void lay_out_struct(struct symbol *sym, stru=
ct struct_union_info *info)
 		info->flex_array =3D sym;
 	}
=20
-	alignment =3D info->packed ? 1 : sym->ctype.alignment;
+	bool packed =3D info->packed || sym->packed;
+
+	alignment =3D packed ? (sym->explicit_alignment ? : 1) : sym->ctype.ali=
gnment;
 	align_bit_mask =3D bytes_to_bits(alignment) - 1;
=20
 	/*
 	 * Bitfields have some very special rules..
 	 */
 	if (is_bitfield_type (sym)) {
+		if (sym->explicit_alignment)
+			bit_size =3D (bit_size + align_bit_mask) & ~align_bit_mask;
 		unsigned long bit_offset =3D bit_size & align_bit_mask;
 		int room =3D bitfield_base_size(sym) - bit_offset;
 		// Zero-width fields just fill up the unit.
 		int width =3D base_size ? : (bit_offset ? room : 0);
=20
-		if (width > room && !info->packed) {
+		if (width > room && !packed) {
 			bit_size =3D (bit_size + align_bit_mask) & ~align_bit_mask;
 			bit_offset =3D 0;
 		}
@@ -163,7 +167,7 @@ static void lay_out_struct(struct symbol *sym, struct=
 struct_union_info *info)
 		info->bit_size =3D bit_size + width;
 		// warning (sym->pos, "bitfield: offset=3D%d:%d  size=3D:%d", sym->off=
set, sym->bit_offset, width);
=20
-		if (info->packed && sym->type =3D=3D SYM_NODE)
+		if (packed && sym->type =3D=3D SYM_NODE)
 			sym->packed =3D 1;
 		return;
 	}
@@ -232,10 +236,13 @@ static struct symbol * examine_struct_union_type(st=
ruct symbol *sym, int advance
 		if (!member->ident)
 			examine_anonymous_member(member);
=20
-		if (member->ctype.alignment > info.max_align && !sym->packed) {
+		unsigned long member_align =3D (sym->packed || member->packed)
+			? (member->explicit_alignment ? : 1)
+			: member->ctype.alignment;
+		if (member_align > info.max_align) {
 			// Unnamed bitfields do not affect alignment.
 			if (member->ident || !is_bitfield_type(member))
-				info.max_align =3D member->ctype.alignment;
+				info.max_align =3D member_align;
 		}
=20
 		if (has_flexible_array(member))
@@ -245,7 +252,7 @@ static struct symbol * examine_struct_union_type(stru=
ct symbol *sym, int advance
 		fn(member, &info);
 	} END_FOR_EACH_PTR(member);
=20
-	if (!sym->ctype.alignment)
+	if (sym->ctype.alignment < info.max_align)
 		sym->ctype.alignment =3D info.max_align;
 	bit_size =3D info.bit_size;
 	if (info.align_size) {
@@ -566,7 +573,7 @@ static struct symbol * examine_node_type(struct symbo=
l *sym)
 	/* Pick up signedness information into the node */
 	sym->ctype.modifiers |=3D (MOD_SIGNEDNESS & base_type->ctype.modifiers)=
;
=20
-	if (!sym->ctype.alignment)
+	if (!sym->ctype.alignment || (!sym->packed && sym->ctype.alignment < al=
ignment))
 		sym->ctype.alignment =3D alignment;
=20
 	/* Unsized array? The size might come from the initializer.. */
@@ -885,8 +892,12 @@ static void inherit_declaration(struct symbol *sym, =
struct symbol *prev)
 {
 	unsigned long mods =3D prev->ctype.modifiers;
=20
-	// inherit function attributes
-	sym->ctype.modifiers |=3D mods & MOD_FUN_ATTR;
+	// inherit function and declaration attributes
+	sym->ctype.modifiers |=3D mods & (MOD_FUN_ATTR | MOD_WEAK | MOD_ALIGNED=
 | MOD_NONSTRING);
+	if ((mods & MOD_ALIGNED) && prev->ctype.alignment > sym->ctype.alignmen=
t)
+		sym->ctype.alignment =3D prev->ctype.alignment;
+	if (prev->explicit_alignment > sym->explicit_alignment)
+		sym->explicit_alignment =3D prev->explicit_alignment;
 }
=20
 void check_declaration(struct symbol *sym)
@@ -906,6 +917,7 @@ void check_declaration(struct symbol *sym)
 		if (sym->ctype.modifiers & MOD_EXTERN) {
 			if ((next->ctype.modifiers & (MOD_TOPLEVEL|MOD_STATIC)) =3D=3D MOD_TO=
PLEVEL) {
 				sym->same_symbol =3D next;
+				inherit_declaration(sym, next);
 				return;
 			}
 		}
diff --git a/symbol.h b/symbol.h
index 691213a0b454..cd9268703192 100644
--- a/symbol.h
+++ b/symbol.h
@@ -117,6 +117,8 @@ struct decl_state {
 	unsigned long f_modifiers;		// function attributes
 	unsigned long ident_modifiers;		// declarator-id C23 attributes
 	unsigned long storage_class;
+	unsigned long typedef_mods;
+	unsigned int explicit_alignment;
 	unsigned int typedef_alignment;
 	unsigned char prefer_abstract;
 	unsigned char autotype;
@@ -199,6 +201,7 @@ struct symbol {
 			unsigned long	offset;
 			int		bit_size;
 			int bitint_width;
+			unsigned int explicit_alignment;
 			unsigned int bit_offset : 8;
 			unsigned int bogus_linear : 1;
 			unsigned int variadic : 1;
@@ -276,8 +279,8 @@ struct symbol {
 #define MOD_USERTYPE		0x00020000
 #define MOD_CONSTEXPR 0x00040000
 #define MOD_BITINT 0x00080000
-// MOD UNUSED		0x00100000
-// MOD UNUSED		0x00200000
+#define MOD_WEAK		0x00100000
+#define MOD_ALIGNED		0x00200000
=20
 #define MOD_UNUSED		0x00400000
 #define MOD_SAFE		0x00800000	// non-null/non-trapping pointer
@@ -287,6 +290,8 @@ struct symbol {
 #define MOD_NODEREF		0x08000000
 #define MOD_NORETURN		0x10000000
 #define MOD_EXT_VISIBLE		0x20000000
+#define MOD_NONSTRING		0x40000000
+#define MOD_FCONST		0x80000000UL
=20
=20
 #define MOD_ACCESS	(MOD_ASSIGNED | MOD_ADDRESSABLE)
@@ -295,21 +300,22 @@ struct symbol {
 #define MOD_ESIGNED	(MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNE=
D)
 #define MOD_SPECIFIER (MOD_SIGNEDNESS | MOD_BITINT)
-#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE | MOD_CONSTEX=
PR)
+#define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE | MOD_WEAK | =
MOD_ALIGNED | MOD_NONSTRING | MOD_CONSTEXPR)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 /* modifiers for function attributes */
-#define MOD_FUN_ATTR	(MOD_PURE|MOD_NORETURN)
+#define MOD_FUN_ATTR	(MOD_PURE|MOD_NORETURN|MOD_FCONST)
 #define MOD_PTRINHERIT	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NODEREF | MOD_F=
UN_ATTR | MOD_NOCAST)
 /* modifiers preserved by typeof() operator */
 #define MOD_TYPEOF	(MOD_QUALIFIER | MOD_ATOMIC | MOD_NOCAST | MOD_SPECIF=
IER)
 /* like cvr-qualifiers but 'reversed' (OK: source <=3D target) */
-#define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
+#define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN|MOD_FCONST)
 /* do not warn when these are duplicated */
-#define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE|MOD_USERTYPE)
+#define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE|MOD_WEAK|MOD_ALIGNED|MOD_U=
SERTYPE|MOD_NONSTRING|MOD_FUN_ATTR)
 /* must be part of the declared symbol, not its type */
 #define MOD_DECLARE                                                     =
    \
 	(MOD_STORAGE | MOD_INLINE | MOD_TLS | MOD_GNU_INLINE | MOD_UNUSED | \
-	 MOD_PURE | MOD_NORETURN | MOD_EXT_VISIBLE | MOD_CONSTEXPR)
+	 MOD_PURE | MOD_NORETURN | MOD_FCONST | MOD_EXT_VISIBLE |           \
+	 MOD_CONSTEXPR | MOD_WEAK | MOD_ALIGNED | MOD_NONSTRING)
=20
 /* Current parsing/evaluation function */
 extern struct symbol *current_fn;
diff --git a/validation/builtin-has-attribute-err.c b/validation/builtin-=
has-attribute-err.c
new file mode 100644
index 000000000000..cb756fdd2bab
--- /dev/null
+++ b/validation/builtin-has-attribute-err.c
@@ -0,0 +1,19 @@
+static int x;
+
+static int test_err(void)
+{
+	return __builtin_has_attribute(x, 123) +
+	       __builtin_has_attribute(x, "aligned") +
+	       __builtin_has_attribute(x, );
+}
+
+/*
+ * check-name: builtin-has-attribute-err
+ * check-command: sparse $file
+ *
+ * check-error-start
+builtin-has-attribute-err.c:5:43: error: expected attribute name
+builtin-has-attribute-err.c:6:43: error: expected attribute name
+builtin-has-attribute-err.c:7:43: error: expected attribute name
+ * check-error-end
+ */
diff --git a/validation/builtin-has-attribute-more.c b/validation/builtin=
-has-attribute-more.c
new file mode 100644
index 000000000000..295301d06930
--- /dev/null
+++ b/validation/builtin-has-attribute-more.c
@@ -0,0 +1,157 @@
+extern void fn_noreturn(void) __attribute__((noreturn));
+_Static_assert(__builtin_has_attribute(fn_noreturn, noreturn), "noreturn=
");
+_Static_assert(__builtin_has_attribute(fn_noreturn, __noreturn__), "__no=
return__");
+
+extern int fn_pure(int) __attribute__((pure));
+_Static_assert(__builtin_has_attribute(fn_pure, pure), "pure");
+_Static_assert(__builtin_has_attribute(fn_pure, __pure__), "__pure__");
+_Static_assert(!__builtin_has_attribute(fn_pure, const), "pure is not co=
nst");
+_Static_assert(!__builtin_has_attribute(fn_pure, __const__), "pure is no=
t __const__");
+
+extern int fn_const(int) __attribute__((const));
+_Static_assert(__builtin_has_attribute(fn_const, const), "const");
+_Static_assert(__builtin_has_attribute(fn_const, __const__), "__const__"=
);
+_Static_assert(!__builtin_has_attribute(fn_const, pure), "const is not p=
ure");
+_Static_assert(!__builtin_has_attribute(fn_const, __pure__), "const is n=
ot __pure__");
+
+/* const on object/member declarations vs expressions/types */
+static const int ci =3D 5;
+static int vi =3D 5;
+static const int ca[3] =3D { 0 };
+static const int *cip;
+static int * const cpi =3D (void *)0;
+
+_Static_assert(__builtin_has_attribute(ci, const), "const var");
+_Static_assert(!__builtin_has_attribute(vi, const), "non-const var");
+_Static_assert(__builtin_has_attribute(ca, const), "const array");
+_Static_assert(!__builtin_has_attribute(cip, const), "ptr to const");
+_Static_assert(!__builtin_has_attribute(*cip, const), "deref ptr to cons=
t");
+_Static_assert(__builtin_has_attribute(cpi, const), "const ptr");
+_Static_assert(!__builtin_has_attribute(const int, const), "const int ty=
pename");
+
+struct SConst {
+	const int cfield;
+	int plain;
+};
+static struct SConst sc;
+static const struct SConst csc =3D { 0, 0 };
+
+_Static_assert(__builtin_has_attribute(sc.cfield, const), "const field")=
;
+_Static_assert(__builtin_has_attribute(((struct SConst *)0)->cfield, con=
st), "arrow const field");
+_Static_assert(!__builtin_has_attribute(sc.plain, const), "plain field")=
;
+_Static_assert(!__builtin_has_attribute(csc.plain, const), "const struct=
 plain field");
+_Static_assert(!__builtin_has_attribute(((const struct SConst *)0)->plai=
n, const), "const arrow plain field");
+
+/* aligned, _Alignas, typedef pointer non-leakage, and member non-inheri=
tance */
+typedef int aligned_int __attribute__((aligned(16)));
+static aligned_int ax;
+static aligned_int *ap;
+static aligned_int mx, *mp;
+static _Alignas(16) int a16;
+static _Alignas(0) int a0;
+
+_Static_assert(_Alignof(ax) =3D=3D 16, "ax align 16");
+_Static_assert(_Alignof(ap) =3D=3D sizeof(void *), "ap ptr align");
+_Static_assert(_Alignof(mx) =3D=3D 16, "mx align 16");
+_Static_assert(_Alignof(mp) =3D=3D sizeof(void *), "mp ptr align");
+_Static_assert(__builtin_has_attribute(aligned_int, aligned), "typedef a=
ligned");
+_Static_assert(__builtin_has_attribute(ax, aligned), "ax aligned");
+_Static_assert(!__builtin_has_attribute(ap, aligned), "ap not aligned");
+_Static_assert(__builtin_has_attribute(*ap, aligned), "*ap aligned");
+_Static_assert(__builtin_has_attribute(mx, aligned), "mx aligned");
+_Static_assert(!__builtin_has_attribute(mp, aligned), "mp not aligned");
+_Static_assert(__builtin_has_attribute(*mp, aligned), "*mp aligned");
+_Static_assert(__builtin_has_attribute(a16, aligned), "_Alignas(16) alig=
ned");
+_Static_assert(!__builtin_has_attribute(a0, aligned), "_Alignas(0) not a=
ligned");
+
+struct SAligned {
+	int a;
+	int b __attribute__((aligned(8)));
+} __attribute__((aligned(16)));
+static struct SAligned sa;
+static struct SAligned sa_var __attribute__((aligned(32)));
+
+_Static_assert(__builtin_has_attribute(struct SAligned, aligned), "struc=
t SAligned aligned");
+_Static_assert(!__builtin_has_attribute(sa.a, aligned), "sa.a not aligne=
d");
+_Static_assert(!__builtin_has_attribute(sa_var.a, aligned), "sa_var.a no=
t aligned");
+_Static_assert(__builtin_has_attribute(sa.b, aligned), "sa.b aligned");
+
+struct SOuter {
+	struct SAligned inner;
+	struct SAligned arr[2];
+};
+static struct SOuter *so_ptr;
+static struct SAligned sa_arr[2];
+
+_Static_assert(__builtin_has_attribute(so_ptr->inner.b, aligned), "neste=
d member aligned");
+_Static_assert(!__builtin_has_attribute(so_ptr->inner.a, aligned), "nest=
ed member not aligned");
+_Static_assert(__builtin_has_attribute(sa_arr[1].b, aligned), "array sub=
script member aligned");
+_Static_assert(!__builtin_has_attribute(sa_arr[1].a, aligned), "array su=
bscript member not aligned");
+_Static_assert(__builtin_has_attribute(so_ptr->arr[1].b, aligned), "nest=
ed array member aligned");
+
+/* typename operands */
+_Static_assert(__builtin_has_attribute(int __attribute__((aligned(8))), =
aligned), "typename aligned");
+_Static_assert(!__builtin_has_attribute(int, aligned), "typename int not=
 aligned");
+_Static_assert(__builtin_has_attribute(struct __attribute__((packed)) { =
int x; }, packed), "typename pre-packed");
+_Static_assert(__builtin_has_attribute(struct { int x; } __attribute__((=
packed)), packed), "typename post-packed");
+_Static_assert(!__builtin_has_attribute(struct { int x; }, packed), "typ=
ename unpacked");
+extern void (*fp_noreturn)(void) __attribute__((noreturn));
+_Static_assert(__builtin_has_attribute(fp_noreturn, noreturn), "fnptr de=
cl noreturn");
+extern int (*fp_after_ident [[unsequenced]])(int);
+extern int (*fn_ret_fp_a(void) [[unsequenced]])(int);
+extern int (*fn_ret_fp_b(void))(int) [[unsequenced]];
+extern int (*fn_ret_fp_c [[unsequenced]] (void))(int);
+_Static_assert(__builtin_has_attribute(fp_after_ident, unsequenced), "fn=
ptr after ident");
+_Static_assert(__builtin_has_attribute(fn_ret_fp_a, unsequenced), "neste=
d fn unseq");
+_Static_assert(!__builtin_has_attribute(fn_ret_fp_a(), unsequenced), "re=
t fp not unseq");
+_Static_assert(!__builtin_has_attribute(fn_ret_fp_b, unsequenced), "oute=
r fn not unseq");
+_Static_assert(__builtin_has_attribute(fn_ret_fp_b(), unsequenced), "ret=
 fp unseq");
+_Static_assert(__builtin_has_attribute(fn_ret_fp_c, unsequenced), "fn af=
ter ident unseq");
+_Static_assert(!__builtin_has_attribute(fn_ret_fp_c(), unsequenced), "fn=
 after ident ret fp");
+
+/* Redeclaration attribute inheritance */
+void ext_redecl_weak(void) __attribute__((weak));
+void ext_redecl_weak(void) {}
+_Static_assert(__builtin_has_attribute(ext_redecl_weak, weak), "redecl w=
eak");
+
+int ext_redecl_const(int x) __attribute__((const));
+int ext_redecl_const(int x) { return x; }
+_Static_assert(__builtin_has_attribute(ext_redecl_const, const), "redecl=
 const");
+_Static_assert(!__builtin_has_attribute(ext_redecl_const, pure), "redecl=
 const not pure");
+
+int ext_redecl_pure(int x) __attribute__((pure));
+int ext_redecl_pure(int x) { return x; }
+_Static_assert(__builtin_has_attribute(ext_redecl_pure, pure), "redecl p=
ure");
+_Static_assert(!__builtin_has_attribute(ext_redecl_pure, const), "redecl=
 pure not const");
+
+extern int ext_redecl_aligned __attribute__((aligned(16)));
+int ext_redecl_aligned;
+_Static_assert(__builtin_has_attribute(ext_redecl_aligned, aligned), "re=
decl aligned");
+_Static_assert(_Alignof(ext_redecl_aligned) =3D=3D 16, "redecl align 16"=
);
+
+#ifdef __CHECKER__
+static int __attribute__((noderef)) *ptr_noderef;
+_Static_assert(__builtin_has_attribute(*ptr_noderef, noderef), "noderef"=
);
+_Static_assert(__builtin_has_attribute(*ptr_noderef, __noderef__), "__no=
deref__");
+_Static_assert(!__builtin_has_attribute(ptr_noderef, noderef), "ptr itse=
lf not noderef");
+
+static int __attribute__((address_space(1))) *ptr_as;
+_Static_assert(__builtin_has_attribute(*ptr_as, address_space), "address=
_space");
+_Static_assert(__builtin_has_attribute(*ptr_as, __address_space__), "__a=
ddress_space__");
+_Static_assert(!__builtin_has_attribute(ptr_as, address_space), "ptr its=
elf not address_space");
+
+typedef unsigned int __attribute__((bitwise)) __be32;
+static __be32 be_var;
+static __be32 *be_ptr;
+_Static_assert(__builtin_has_attribute(__be32, bitwise), "__be32 bitwise=
");
+_Static_assert(__builtin_has_attribute(__be32, __bitwise__), "__be32 __b=
itwise__");
+_Static_assert(__builtin_has_attribute(be_var, bitwise), "be_var bitwise=
");
+_Static_assert(__builtin_has_attribute(*be_ptr, bitwise), "*be_ptr bitwi=
se");
+_Static_assert(!__builtin_has_attribute(be_ptr, bitwise), "be_ptr not bi=
twise");
+_Static_assert(!__builtin_has_attribute(int, bitwise), "int not bitwise"=
);
+#endif
+
+/*
+ * check-name: builtin-has-attribute-more
+ * check-command: sparse -Wno-decl $file
+ */
diff --git a/validation/builtin-has-attribute-nonstring.c b/validation/bu=
iltin-has-attribute-nonstring.c
new file mode 100644
index 000000000000..7662cbc13040
--- /dev/null
+++ b/validation/builtin-has-attribute-nonstring.c
@@ -0,0 +1,35 @@
+struct s_msg {
+	char str[16];
+	char nonstr[16] __attribute__((__nonstring__));
+};
+
+static struct s_msg msg;
+static char global_nonstr[32] __attribute__((nonstring));
+static char global_str[32];
+static char *ptr_nonstr __attribute__((nonstring));
+static char *ptr_str;
+
+extern char ext_nonstr[8] __attribute__((nonstring));
+char ext_nonstr[8];
+
+_Static_assert(__has_attribute(nonstring), "has_attribute nonstring");
+_Static_assert(__has_attribute(__nonstring__), "has_attribute __nonstrin=
g__");
+_Static_assert(__builtin_has_attribute(msg.nonstr, nonstring), "msg.nons=
tr has nonstring");
+_Static_assert(__builtin_has_attribute(msg.nonstr, __nonstring__), "msg.=
nonstr has __nonstring__");
+_Static_assert(!__builtin_has_attribute(msg.str, nonstring), "msg.str do=
es not have nonstring");
+_Static_assert(__builtin_has_attribute(global_nonstr, nonstring), "globa=
l_nonstr has nonstring");
+_Static_assert(!__builtin_has_attribute(global_str, nonstring), "global_=
str does not have nonstring");
+_Static_assert(__builtin_has_attribute(ptr_nonstr, nonstring), "ptr_nons=
tr has nonstring");
+_Static_assert(!__builtin_has_attribute(ptr_str, nonstring), "ptr_str do=
es not have nonstring");
+_Static_assert(__builtin_has_attribute(ext_nonstr, nonstring), "redecl n=
onstring");
+
+#ifdef __CHECKER__
+typedef char nonstr_arr[8] __attribute__((nonstring));
+static nonstr_arr *ns_p;
+_Static_assert(!__builtin_has_attribute(ns_p, nonstring), "ptr to typede=
f nonstring does not leak");
+#endif
+
+/*
+ * check-name: builtin-has-attribute-nonstring
+ * check-command: sparse -Wno-decl $file
+ */
diff --git a/validation/builtins-kernel.c b/validation/builtins-kernel.c
index 05c13f4c1eae..f4b1d4b45b68 100644
--- a/validation/builtins-kernel.c
+++ b/validation/builtins-kernel.c
@@ -2,6 +2,10 @@
 #error "missing __builtin_dynamic_object_size"
 #endif
=20
+#if !__has_builtin(__builtin_has_attribute)
+#error "missing __builtin_has_attribute"
+#endif
+
 #if !__has_builtin(__builtin_thread_pointer)
 #error "missing __builtin_thread_pointer"
 #endif
@@ -14,6 +18,33 @@
 #error "missing __builtin_counted_by_ref"
 #endif
=20
+extern int weak_var __attribute__((__weak__));
+_Static_assert(__builtin_has_attribute(weak_var, __weak__), "weak_var ha=
s __weak__");
+_Static_assert(__builtin_has_attribute(weak_var, weak), "weak_var has we=
ak");
+_Static_assert(__builtin_has_attribute(*&weak_var, __weak__), "*&weak_va=
r has __weak__");
+
+struct s_packed {
+	int a;
+	char b;
+} __attribute__((__packed__));
+
+_Static_assert(__builtin_has_attribute(struct s_packed, packed), "s_pack=
ed has packed");
+_Static_assert(__builtin_has_attribute(struct s_packed, __packed__), "s_=
packed has __packed__");
+
+struct s_normal {
+	int a;
+	char b;
+	int c __attribute__((__packed__));
+};
+static struct s_normal s_norm_inst;
+
+_Static_assert(!__builtin_has_attribute(struct s_normal, packed), "s_nor=
mal not packed");
+_Static_assert(__builtin_has_attribute(s_norm_inst.c, packed), "s_norm_i=
nst.c packed");
+_Static_assert(!__builtin_has_attribute(weak_var, packed), "weak_var not=
 packed");
+
+static int aligned_var __attribute__((aligned(16)));
+_Static_assert(__builtin_has_attribute(aligned_var, aligned), "aligned_v=
ar has aligned");
+
 struct fam {
 	int count;
 	char arr[];
diff --git a/validation/struct-packed-aligned-layout.c b/validation/struc=
t-packed-aligned-layout.c
new file mode 100644
index 000000000000..c85a4a24ac7f
--- /dev/null
+++ b/validation/struct-packed-aligned-layout.c
@@ -0,0 +1,135 @@
+typedef int aligned16 __attribute__((aligned(16)));
+
+/* 1. Post-brace packed struct with explicitly aligned member */
+struct S1 {
+	char a;
+	int b __attribute__((aligned(8)));
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S1, b) =3D=3D 8, "S1 offset b")=
;
+_Static_assert(_Alignof(struct S1) =3D=3D 8, "S1 align");
+_Static_assert(sizeof(struct S1) =3D=3D 16, "S1 size");
+
+/* 2. Pre-tag packed struct with explicitly aligned member */
+struct __attribute__((packed)) S2 {
+	char a;
+	int b __attribute__((aligned(8)));
+};
+_Static_assert(__builtin_offsetof(struct S2, b) =3D=3D 8, "S2 offset b")=
;
+_Static_assert(_Alignof(struct S2) =3D=3D 8, "S2 align");
+_Static_assert(sizeof(struct S2) =3D=3D 16, "S2 size");
+
+/* 3. Struct with both packed and aligned(8) on the struct itself */
+struct S3 {
+	char a;
+	int b;
+} __attribute__((packed, aligned(8)));
+_Static_assert(__builtin_offsetof(struct S3, b) =3D=3D 1, "S3 offset b")=
;
+_Static_assert(_Alignof(struct S3) =3D=3D 8, "S3 align");
+_Static_assert(sizeof(struct S3) =3D=3D 8, "S3 size");
+
+/* 4. Nested S1 inside packed S4 without explicit aligned on inner */
+struct S4 {
+	char a;
+	struct S1 inner;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S4, inner) =3D=3D 1, "S4 offset=
 inner");
+_Static_assert(_Alignof(struct S4) =3D=3D 1, "S4 align");
+_Static_assert(sizeof(struct S4) =3D=3D 17, "S4 size");
+
+/* 5. Nested S3 inside packed S5 without explicit aligned on inner */
+struct S5 {
+	char a;
+	struct S3 inner;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S5, inner) =3D=3D 1, "S5 offset=
 inner");
+_Static_assert(_Alignof(struct S5) =3D=3D 1, "S5 align");
+_Static_assert(sizeof(struct S5) =3D=3D 9, "S5 size");
+
+/* 6. Nested S1 inside packed S6 with smaller explicit aligned(4) on inn=
er */
+struct S6 {
+	char a;
+	struct S1 inner __attribute__((aligned(4)));
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S6, inner) =3D=3D 4, "S6 offset=
 inner");
+_Static_assert(_Alignof(struct S6) =3D=3D 4, "S6 align");
+_Static_assert(sizeof(struct S6) =3D=3D 20, "S6 size");
+
+/* 7. Unpacked struct with member carrying both packed and aligned(8) */
+struct S7 {
+	char a;
+	int b __attribute__((packed, aligned(8)));
+};
+_Static_assert(__builtin_offsetof(struct S7, b) =3D=3D 8, "S7 offset b")=
;
+_Static_assert(_Alignof(struct S7) =3D=3D 8, "S7 align");
+_Static_assert(sizeof(struct S7) =3D=3D 16, "S7 size");
+
+/* 8. _Alignas(8) and _Alignas(0) inside packed structs */
+struct S8 {
+	char a;
+	_Alignas(8) int b;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S8, b) =3D=3D 8, "S8 offset b")=
;
+_Static_assert(_Alignof(struct S8) =3D=3D 8, "S8 align");
+_Static_assert(sizeof(struct S8) =3D=3D 16, "S8 size");
+
+struct S9 {
+	char a;
+	_Alignas(0) int b;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct S9, b) =3D=3D 1, "S9 offset b")=
;
+_Static_assert(_Alignof(struct S9) =3D=3D 1, "S9 align");
+_Static_assert(sizeof(struct S9) =3D=3D 5, "S9 size");
+
+/* 9. Aligned typedef inside packed struct / packed field / pointer */
+struct ST1 {
+	char a;
+	aligned16 b;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct ST1, b) =3D=3D 1, "ST1 offset b=
");
+_Static_assert(_Alignof(struct ST1) =3D=3D 1, "ST1 align");
+_Static_assert(sizeof(struct ST1) =3D=3D 5, "ST1 size");
+
+struct ST2 {
+	char a;
+	aligned16 b __attribute__((packed));
+};
+_Static_assert(__builtin_offsetof(struct ST2, b) =3D=3D 1, "ST2 offset b=
");
+_Static_assert(_Alignof(struct ST2) =3D=3D 1, "ST2 align");
+_Static_assert(sizeof(struct ST2) =3D=3D 5, "ST2 size");
+
+struct ST3 {
+	char a;
+	aligned16 b __attribute__((aligned(8)));
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct ST3, b) =3D=3D 8, "ST3 offset b=
");
+_Static_assert(_Alignof(struct ST3) =3D=3D 8, "ST3 align");
+_Static_assert(sizeof(struct ST3) =3D=3D 16, "ST3 size");
+
+struct ST4 {
+	char a;
+	aligned16 *p;
+} __attribute__((packed));
+_Static_assert(__builtin_offsetof(struct ST4, p) =3D=3D 1, "ST4 offset p=
");
+_Static_assert(_Alignof(struct ST4) =3D=3D 1, "ST4 align");
+_Static_assert(sizeof(struct ST4) =3D=3D 1 + sizeof(void *), "ST4 size")=
;
+
+/* 10. Packed union with explicitly aligned member */
+union U1 {
+	char a;
+	int b __attribute__((aligned(8)));
+} __attribute__((packed));
+_Static_assert(_Alignof(union U1) =3D=3D 8, "U1 align");
+_Static_assert(sizeof(union U1) =3D=3D 8, "U1 size");
+
+/* 11. Packed struct with explicitly aligned bitfield */
+struct BF1 {
+	unsigned char a : 1;
+	unsigned int b : 3 __attribute__((aligned(8)));
+} __attribute__((packed));
+_Static_assert(_Alignof(struct BF1) =3D=3D 8, "BF1 align");
+_Static_assert(sizeof(struct BF1) =3D=3D 16, "BF1 size");
+
+/*
+ * check-name: struct-packed-aligned-layout
+ * check-command: sparse $file
+ */
diff --git a/validation/weak-const-no-fold.c b/validation/weak-const-no-f=
old.c
new file mode 100644
index 000000000000..5486a759226b
--- /dev/null
+++ b/validation/weak-const-no-fold.c
@@ -0,0 +1,15 @@
+const int __attribute__((weak)) weak_const =3D 10;
+
+int read_weak_const(void)
+{
+	return weak_const;
+}
+
+/*
+ * check-name: weak-const-no-fold
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: load\\.32.*\\[weak_const\\]
+ * check-output-excludes: ret\\.32.*\\$10
+ */
