Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256439;
	b=YijSDRDfK3OIQkvia+w7MQ1MxxADli508BKxwYACex9QbtxSlKY4OaS/auyBVrQn+Wbg
	 b9R6Nks1l2cXgFWCiZDxtpaE6SkfYK1VMYEiZpAZ0rsYSFeYFC3nxG3ybX8e87w2VJsOr
	 dUv0oZm6luQV9ZEsc+lAO+7jdI0qoqLJDTF+zm5yW9H7vhJbiL4yqawkW63iG1wShcX34
	 inj/+8I+vlqBnJpO/Fyy8L4LLbIWP9/ssFaPSTCTYefhg4zuLA5EXCC7qz3c1KQvnp53R
	 zq5/KnRteANTKOuHPvrMFPQ/FztRohuNiJhdV7w2j7PMEuxNRtOrWyVR5A1VqTqO35w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Y/7hUH2oj7d7vQDVJ1RSbK/GJlsJ0+HryhVYXUA4550=;
	b=j3FUbZKHGZQ0eyn5PanjsFgsEKOswdLs5OuW6b6kKp0bFALMBWJbjydhialvdoFclI2h
	 y3V4oXskBeULHQWlu/Bs6WZO9Di/orVoD6+4LOKBVKvxdrQQTpmE4sQ1hsB51pxVR7VC8
	 wICNEYRatFPv8uUNXhQi9bL/BpRjjCVEiCCyjy2NpzBoCzahysamg0oDaMuK/J/4xB4V2
	 bTro+OryjJ/xFO6/k1a0ObeNA4pZh2/OQjCn3UBXeIDbzZBCyiVUwa2t+nWrsnR9nIYK8
	 KxkJMLnrsT1At0VCPBBevk147CsJPpPaaoSx8Unu1Vq+Taep7a2P449/0KtIzv/ylXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rMqXPpgU;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595D3606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595D3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rMqXPpgU
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhML4RQqz1XMYJW;
	Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=Y/7hU
	H2oj7d7vQDVJ1RSbK/GJlsJ0+HryhVYXUA4550=; b=rMqXPpgU27jMn4Z4HMMbp
	VmI+L5/auwfBWnAY/PXF8rc1j8AFxpg0H6V9P0ToAHY2kPq5apKK67NytCaDTJm5
	K8yjKfPBcEljbEwxA2kzGUYYsm5VzG7UwSHNoRYuhnfR7PdvYyYU7D5F8t2UN4Fw
	RhYDWZUQ48HbMo7JrbGay9ugbG+xa4t944ydqv5k8qXcLQoeCw4kj1yClbpcpgtD
	+oRo2zO1u2cRqeaNZMdgsYbnw5EuxUJhs/hBDzqjGp1V0WLQw/cYgSAtSzoHSD75
	3uTI1XwapAy0z9FsqXHwdYvOI4M/6EKDwxRePrLli0aRJU65MY9Y6LzDg9SBhYGG
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RY1SvDMRUoZV; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM54Y78z1XMfrY;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 60/73] c23: Support storage-class specifiers in compound literals
Date: Mon,  9 Nov 2026 12:32:46 -0800
Message-ID: <20261109203259.362845-61-bvanassche@acm.org>
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

Support C23 storage-class specifiers (constexpr, static, register, and
thread_local) in compound literals per ISO C23 6.5.2.5:
- Allow static, register, constexpr, and static thread_local compound
  literals while rejecting extern, typedef, auto, file-scope register,
  and un-static block-scope thread_local compound literals.
- Keep block-scope constexpr compound literals at automatic storage
  duration unless static is also specified, enforce constant initializers
  on static and thread_local objects in C23 mode, and warn when taking
  the address or decaying an array of a register compound literal.
- Emit anonymous static and thread_local compound literal globals and
  their constant scalar or array initializers in sparse-llvm, and warn
  under -Wpedantic before C23.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                                    | 28 +++++++--
 expand.c                                      |  5 +-
 expression.c                                  | 61 ++++++++++++++++---
 expression.h                                  |  1 +
 parse.c                                       | 59 +++++++++++++-----
 sparse-llvm.c                                 | 10 ++-
 symbol.h                                      |  4 +-
 .../backend/c23-compound-literal-storage.c    | 27 ++++++++
 .../c23-compound-literal-register-addr.c      | 17 ++++++
 .../c23-compound-literal-storage-error.c      | 37 +++++++++++
 .../c23-compound-literal-storage-pedantic.c   | 10 +++
 validation/c23-compound-literal-storage.c     | 27 ++++++++
 12 files changed, 252 insertions(+), 34 deletions(-)
 create mode 100644 validation/backend/c23-compound-literal-storage.c
 create mode 100644 validation/c23-compound-literal-register-addr.c
 create mode 100644 validation/c23-compound-literal-storage-error.c
 create mode 100644 validation/c23-compound-literal-storage-pedantic.c
 create mode 100644 validation/c23-compound-literal-storage.c

diff --git a/evaluate.c b/evaluate.c
index e46b1a7d4f70..32621d04a17e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1918,7 +1918,10 @@ static struct symbol *create_pointer(struct expres=
sion *expr, struct symbol *sym
=20
 	access_symbol(sym);
 	if (sym->ctype.modifiers & MOD_REGISTER) {
-		warning(expr->pos, "taking address of 'register' variable '%s'", show_=
ident(sym->ident));
+		if (sym->ident)
+			warning(expr->pos, "taking address of 'register' variable '%s'", show=
_ident(sym->ident));
+		else
+			warning(expr->pos, "taking address of 'register' compound literal");
 		sym->ctype.modifiers &=3D ~MOD_REGISTER;
 	}
 	if (sym->type =3D=3D SYM_NODE) {
@@ -2944,7 +2947,7 @@ found:
 		else
 			v =3D &top->ident_expression;
=20
-		mods |=3D ctype->ctype.modifiers & (MOD_STORAGE | MOD_CONSTEXPR);
+		mods |=3D ctype->ctype.modifiers & (MOD_STORAGE | MOD_TLS | MOD_CONSTE=
XPR);
 		if (handle_initializer(v, 1, lclass, top->ctype, mods))
 			continue;
=20
@@ -3236,10 +3239,14 @@ static int handle_initializer(struct expression *=
*ep, int nested,
 		mods |=3D ctype->ctype.modifiers;
 		if (mods & MOD_CONSTEXPR)
 			check_constexpr_scalar_init(&orig, ctype);
-		if ((mods & (MOD_TOPLEVEL | MOD_STATIC)) &&
-		    !(e->flags & (CEF_ACE | CEF_ADDR)))
-			if (Wconstexpr_not_const)
+		else if ((mods & (MOD_TOPLEVEL | MOD_STATIC | MOD_TLS)) &&
+			 valid_type(ctype->ctype.base_type) &&
+			 !(e->flags & (CEF_ACE | CEF_ADDR))) {
+			if (standard >=3D STANDARD_C23)
+				sparse_error(e->pos, "non-constant initializer for static object");
+			else if (Wconstexpr_not_const)
 				warning(e->pos, "non-constant initializer for static object");
+		}
=20
 		return 1;
 	}
@@ -3443,13 +3450,22 @@ static struct symbol *evaluate_compound_literal(s=
truct expression *expr, struct
=20
 	addr->ctype =3D &lazy_ptr_ctype;	/* Lazy eval */
 	addr->symbol =3D sym;
-	if (sym->ctype.modifiers & MOD_TOPLEVEL)
+	if (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC | MOD_TLS))
 		addr->flags |=3D CEF_ADDR;
=20
 	expr->type =3D EXPR_PREOP;
 	expr->op =3D '*';
 	expr->deref =3D addr;
 	expr->ctype =3D sym;
+	if (sym->ctype.modifiers & MOD_CONSTEXPR) {
+		struct symbol *base_type =3D get_base_type(sym);
+		if (is_float_type(base_type))
+			expr->flags =3D CEF_SET_FLOAT;
+		else if (is_int_type(base_type))
+			expr->flags =3D CEF_SET_ICE;
+		else
+			expr->flags =3D CEF_ADDR;
+	}
 	return sym;
 }
=20
diff --git a/expand.c b/expand.c
index 13a3bc0457ba..7c85b66ab02f 100644
--- a/expand.c
+++ b/expand.c
@@ -848,9 +848,8 @@ static int expand_dereference(struct expression *expr=
)
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D value->value;
 				expr->taint =3D 0;
-				if ((sym->ctype.modifiers & MOD_CONSTEXPR) &&
-				    is_int_type(ctype))
-					expr->flags =3D CEF_SET_ICE;
+				if (sym->ctype.modifiers & MOD_CONSTEXPR)
+					expr->flags =3D is_int_type(ctype) ? CEF_SET_ICE : CEF_ADDR;
 				return 0;
 			} else if (value->type =3D=3D EXPR_FVALUE) {
 				if (!is_float_type(ctype))
diff --git a/expression.c b/expression.c
index ace0bf6d1a31..65efff3b61fe 100644
--- a/expression.c
+++ b/expression.c
@@ -150,6 +150,7 @@ static struct token *parse_type(struct token *token, =
struct expression **tree)
 	struct symbol *sym;
 	*tree =3D alloc_expression(token->pos, EXPR_TYPE);
 	token =3D typename(token, &sym, NULL);
+	check_typename_storage(sym);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -198,6 +199,7 @@ static struct token *builtin_offsetof_expr(struct tok=
en *token,
=20
 	token =3D token->next;
 	token =3D typename(token, &sym, NULL);
+	check_typename_storage(sym);
 	if (sym->ident)
 		sparse_error(token->pos,
 			     "type expression should not include identifier "
@@ -569,6 +571,7 @@ static struct token *generic_selection(struct token *=
token, struct expression **
 		if (lookup_type(token)) {
 			struct type_expression *map =3D __alloc_type_expression(0);
 			token =3D typename(token, &map->type, NULL);
+			check_typename_storage(map->type);
 			token =3D expect(token, ':', "after typename");
 			token =3D assignment_expression(token, &map->expr);
 			if (!map->expr)
@@ -730,6 +733,7 @@ struct token *primary_expression(struct token *token,=
 struct expression **tree)
 		if (token->special =3D=3D '[' && lookup_type(token->next)) {
 			expr =3D alloc_expression(token->pos, EXPR_TYPE);
 			token =3D typename(token->next, &expr->symbol, NULL);
+			check_typename_storage(expr->symbol);
 			token =3D expect(token, ']', "in type expression");
 			break;
 		}
@@ -837,6 +841,46 @@ static struct token *postfix_expression(struct token=
 *token, struct expression *
 static struct token *cast_expression(struct token *token, struct express=
ion **tree);
 static struct token *unary_expression(struct token *token, struct expres=
sion **tree);
=20
+static void check_compound_literal_storage(struct symbol *sym, int is_fo=
rce)
+{
+	unsigned long mods;
+
+	if (toplevel(block_scope))
+		sym->ctype.modifiers |=3D MOD_TOPLEVEL;
+	if (is_force)
+		warning(sym->pos, "[force] in compound literal");
+	mods =3D sym->ctype.modifiers;
+	if (mods & MOD_EXTERN) {
+		sparse_error(sym->pos, "'extern' is not allowed in compound literal");
+		return;
+	}
+	if (sym->explicit_typedef) {
+		sparse_error(sym->pos, "'typedef' is not allowed in compound literal")=
;
+		return;
+	}
+	if ((mods & MOD_AUTO) || sym->ctype.base_type =3D=3D &autotype_ctype) {
+		sparse_error(sym->pos, "'auto' is not allowed in compound literal");
+		if (sym->ctype.base_type =3D=3D &autotype_ctype)
+			sym->ctype.base_type =3D &int_ctype;
+		return;
+	}
+	if ((mods & MOD_TOPLEVEL) && (mods & MOD_REGISTER)) {
+		sparse_error(sym->pos,
+			     "file-scope compound literal cannot specify 'register'");
+		return;
+	}
+	if (!(mods & MOD_TOPLEVEL) && (mods & MOD_TLS) && !(mods & MOD_STATIC))=
 {
+		sparse_error(sym->pos,
+			     "block-scope compound literal with 'thread_local' requires 'stat=
ic'");
+		return;
+	}
+	if (mods & (MOD_STATIC | MOD_REGISTER | MOD_TLS | MOD_CONSTEXPR)) {
+		if (standard < STANDARD_C23 && Wpedantic)
+			warning(sym->pos,
+				"storage-class specifiers in compound literals are a C23 feature");
+	}
+}
+
 static struct token *type_info_expression(struct token *token,
 	struct expression **tree, int type)
 {
@@ -845,6 +889,7 @@ static struct token *type_info_expression(struct toke=
n *token,
 	bool std_alignof =3D (op_ident =3D=3D &_Alignof_ident ||
 			    op_ident =3D=3D &alignof_ident);
 	struct token *p;
+	int is_force =3D 0;
=20
 	*tree =3D expr;
 	expr->flags =3D CEF_SET_ICE; /* XXX: VLA support will need that changed=
 */
@@ -857,7 +902,7 @@ static struct token *type_info_expression(struct toke=
n *token,
 		return unary_expression(token, &expr->cast_expression);
 	}
 	p =3D token;
-	token =3D typename(token->next, &expr->cast_type, NULL);
+	token =3D typename(token->next, &expr->cast_type, &is_force);
=20
 	if (!match_op(token, ')')) {
 		static const char * error[] =3D {
@@ -865,6 +910,7 @@ static struct token *type_info_expression(struct toke=
n *token,
 			[EXPR_ALIGNOF] =3D "at end of __alignof__",
 			[EXPR_PTRSIZEOF] =3D "at end of __sizeof_ptr__"
 		};
+		check_typename_storage(expr->cast_type);
 		return expect(token, ')', error[type]);
 	}
=20
@@ -874,16 +920,20 @@ static struct token *type_info_expression(struct to=
ken *token,
 	 * of a typed initializer expression..
 	 */
 	if (match_op(token, '{')) {
+		struct symbol *sym =3D expr->cast_type;
 		struct expression *cast =3D alloc_expression(p->pos, EXPR_CAST);
 		if (std_alignof && Wpedantic)
 			warning(expr->pos,
 				"ISO C does not allow '%s' on an expression",
 				show_ident(op_ident));
-		cast->cast_type =3D expr->cast_type;
+		check_compound_literal_storage(sym, is_force);
+		cast->cast_type =3D sym;
 		expr->cast_type =3D NULL;
 		expr->cast_expression =3D cast;
 		token =3D initializer(&cast->cast_expression, token);
 		token =3D postfix_expression(token, &expr->cast_expression, cast);
+	} else {
+		check_typename_storage(expr->cast_type);
 	}
 	return token;
 }
@@ -993,14 +1043,11 @@ static struct token *cast_expression(struct token =
*token, struct expression **tr
 			cast->cast_type =3D sym;
 			token =3D expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
-				if (toplevel(block_scope))
-					sym->ctype.modifiers |=3D MOD_TOPLEVEL;
-				if (is_force)
-					warning(sym->pos,
-						"[force] in compound literal");
+				check_compound_literal_storage(sym, is_force);
 				token =3D initializer(&cast->cast_expression, token);
 				return postfix_expression(token, tree, cast);
 			}
+			check_typename_storage(sym);
 			*tree =3D cast;
 			if (is_force)
 				cast->type =3D EXPR_FORCE_CAST;
diff --git a/expression.h b/expression.h
index 8c387adf9d5b..213c31d246aa 100644
--- a/expression.h
+++ b/expression.h
@@ -319,6 +319,7 @@ static inline struct expression *alloc_const_expressi=
on(struct position pos, int
=20
 /* Type name parsing */
 struct token *typename(struct token *, struct symbol **, int *);
+void check_typename_storage(struct symbol *sym);
=20
 static inline int lookup_type(struct token *token)
 {
diff --git a/parse.c b/parse.c
index 782683a84fba..0787ad2af576 100644
--- a/parse.c
+++ b/parse.c
@@ -840,6 +840,7 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 				warning(token->pos,
 					"ISO C does not support specifying 'enum' underlying types before C=
23");
 			token =3D typename(token->next, &underlying, NULL);
+			check_typename_storage(underlying);
 			underlying =3D examine_symbol_type(underlying);
 			if (!underlying || !is_int_type(underlying) ||
 			    is_enum_type(underlying)) {
@@ -923,6 +924,7 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 				warning(token->pos,
 					"ISO C does not support specifying 'enum' underlying types before C=
23");
 			token =3D typename(token->next, &underlying, NULL);
+			check_typename_storage(underlying);
 			underlying =3D examine_symbol_type(underlying);
 			if (!underlying || !is_int_type(underlying) ||
 			    is_enum_type(underlying)) {
@@ -1337,6 +1339,7 @@ static struct token *typeof_specifier_helper(struct=
 token *token, struct symbol
 	if (lookup_type(token->next)) {
 		struct symbol *sym;
 		token =3D typename(token->next, &sym, NULL);
+		check_typename_storage(sym);
 		sym =3D examine_symbol_type(sym);
 		if (!qual) {
 			sym->ctype.modifiers &=3D ~MOD_QUALIFIER;
@@ -1780,6 +1783,7 @@ static struct token *alignas_specifier(struct token=
 *token, struct symbol *sym,
 	if (lookup_type(token->next)) {
 		struct symbol *sym =3D NULL;
 		token =3D typename(token->next, &sym, NULL);
+		check_typename_storage(sym);
 		sym =3D examine_symbol_type(sym);
 		alignment =3D sym->ctype.alignment;
 		token =3D expect(token, ')', "after _Alignas(...");
@@ -2550,37 +2554,62 @@ static struct token *parameter_declaration(struct=
 token *token, struct symbol *s
 	return token;
 }
=20
-struct token *typename(struct token *token, struct symbol **p, int *forc=
ed)
+void check_typename_storage(struct symbol *sym)
 {
-	struct decl_state ctx =3D {.prefer_abstract =3D 1};
+	struct symbol *base;
 	unsigned long class;
+	if (!sym)
+		return;
+	for (base =3D sym; base && (base->type =3D=3D SYM_NODE ||
+				  base->type =3D=3D SYM_PTR ||
+				  base->type =3D=3D SYM_ARRAY);
+	     base =3D base->ctype.base_type)
+		;
+	if (base =3D=3D &autotype_ctype) {
+		sparse_error(sym->pos, "'%s' in type name",
+			     sym->c23_auto ? "auto" : "__auto_type");
+		sym->ctype.base_type =3D &bad_ctype;
+		return;
+	}
+	if (sym->has_alignas)
+		sparse_error(sym->pos, "alignment specified for type name");
+	if (sym->ctype.modifiers & MOD_CONSTEXPR)
+		sparse_error(sym->pos, "constexpr in typename");
+	class =3D sym->ctype.modifiers & (MOD_STORAGE | MOD_TLS);
+	if (class)
+		warning(sym->pos, "storage class in typename (%s%s)",
+			modifier_string(class), show_typename(sym));
+}
+
+struct token *typename(struct token *token, struct symbol **p, int *forc=
ed)
+{
+	struct decl_state ctx =3D { .prefer_abstract =3D 1 };
 	struct symbol *sym =3D alloc_symbol(token->pos, SYM_NODE);
+	unsigned long mod;
 	*p =3D sym;
 	token =3D declaration_specifiers(token, &ctx);
-	if (ctx.has_alignas)
-		sparse_error(sym->pos, "alignment specified for type name");
+	mod =3D decl_modifiers(&ctx);
 	if (ctx.opaque_fixed_enum)
 		sparse_error(ctx.opaque_fixed_enum_pos,
 			     "'enum' underlying type may not be specified here");
-	if (ctx.autotype) {
-		sparse_error(sym->pos, "'%s' in type name",
-			     ctx.has_auto ? "auto" : "__auto_type");
-		ctx.ctype.base_type =3D &bad_ctype;
-	}
 	token =3D declarator(token, &ctx);
 	token =3D handle_attributes(token, &ctx);
 	ctx.ctype.modifiers |=3D ctx.ident_modifiers;
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
+	sym->c23_auto =3D ctx.autotype && ctx.has_auto;
 	sym->endpos =3D token->pos;
-	if (ctx.is_constexpr)
-		sparse_error(sym->pos, "constexpr in typename");
-	class =3D ctx.storage_class;
+	if (ctx.storage_class =3D=3D MOD_USERTYPE)
+		sym->explicit_typedef =3D 1;
+	if (ctx.has_alignas)
+		sym->has_alignas =3D 1;
+	if (ctx.is_constexpr) {
+		apply_constexpr_const(sym);
+		sym->ctype.modifiers |=3D MOD_CONSTEXPR;
+	}
+	sym->ctype.modifiers |=3D mod | decl_modifiers(&ctx);
 	if (forced)
 		*forced =3D ctx.forced;
-	if (class)
-		warning(sym->pos, "storage class in typename (%s%s)",
-			modifier_string(class), show_typename(sym));
 	return token;
 }
=20
diff --git a/sparse-llvm.c b/sparse-llvm.c
index f3f6b7e01171..7d15d7a70e54 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -318,7 +318,7 @@ static LLVMValueRef get_sym_value(LLVMModuleRef modul=
e, struct symbol *sym)
 	LLVMValueRef result =3D NULL;
 	struct expression *expr;
=20
-	assert(sym->bb_target =3D=3D NULL);
+	assert(sym->namespace !=3D NS_LABEL);
=20
 	expr =3D sym->initializer;
 	if (expr && !sym->ident) {
@@ -348,6 +348,14 @@ static LLVMValueRef get_sym_value(LLVMModuleRef modu=
le, struct symbol *sym)
 		}
 	}
=20
+	if (!sym->ident && (sym->ctype.modifiers & (MOD_STATIC | MOD_TOPLEVEL |=
 MOD_TLS))) {
+		if (!sym->aux) {
+			expand_symbol(sym);
+			sym->aux =3D output_data(module, sym);
+		}
+		return sym->aux;
+	}
+
 	if (LLVMGetTypeKind(type) =3D=3D LLVMFunctionTypeKind) {
 		result =3D LLVMGetNamedFunction(module, name);
 		if (!result)
diff --git a/symbol.h b/symbol.h
index 942baad97df5..435fa18a4990 100644
--- a/symbol.h
+++ b/symbol.h
@@ -196,7 +196,7 @@ struct symbol {
 				designated_init : 1, forced_arg : 1,
 				accessed : 1, builtin : 1, torename : 1,
 				packed : 1, transparent_union : 1,
-				fixed_type : 1;
+				fixed_type : 1, explicit_typedef : 1;
 			unsigned int has_alignas : 1;
 			unsigned int kr_args : 1;
 			unsigned int underspecified : 1;
@@ -282,7 +282,7 @@ struct symbol {
 /* like cvr-qualifiers but 'reversed' (OK: source <=3D target) */
 #define MOD_REV_QUAL	(MOD_PURE|MOD_NORETURN)
 /* do not warn when these are duplicated */
-#define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE)
+#define MOD_DUP_OK	(MOD_UNUSED|MOD_GNU_INLINE|MOD_USERTYPE)
 /* must be part of the declared symbol, not its type */
 #define MOD_DECLARE                                                     =
    \
 	(MOD_STORAGE | MOD_INLINE | MOD_TLS | MOD_GNU_INLINE | MOD_UNUSED | \
diff --git a/validation/backend/c23-compound-literal-storage.c b/validati=
on/backend/c23-compound-literal-storage.c
new file mode 100644
index 000000000000..e4f0d430e6c8
--- /dev/null
+++ b/validation/backend/c23-compound-literal-storage.c
@@ -0,0 +1,27 @@
+static const int *g_arr =3D (static int[]){ 1, 2, 3 };
+
+int *test_cl_static_scalar_addr(void);
+int *test_cl_static_scalar_addr(void)
+{
+	return &(static int){ 42 };
+}
+
+int test_cl_llvm(void);
+int test_cl_llvm(void)
+{
+	int *lp =3D (static int[]){ 7, 8, 9 };
+	int *tp =3D (static thread_local int[]){ 14 };
+	register int rv =3D (register int){ 12 };
+	int ce =3D (constexpr int){ 42 };
+
+	lp[0] +=3D 1;
+	return g_arr[0] + lp[0] + tp[0] + rv + ce;
+}
+
+/*
+ * check-name: backend-c23-compound-literal-storage
+ * check-command: sparse-llvm-dis -m64 -std=3Dc23 $file
+ * check-output-ignore
+ * check-output-contains: private global i32 42
+ * check-output-contains: define i32 @test_cl_llvm(
+ */
diff --git a/validation/c23-compound-literal-register-addr.c b/validation=
/c23-compound-literal-register-addr.c
new file mode 100644
index 000000000000..0bd817efcc6a
--- /dev/null
+++ b/validation/c23-compound-literal-register-addr.c
@@ -0,0 +1,17 @@
+static void bad_reg_addr(void)
+{
+	int *p =3D &(register int){ 1 };
+	int *q =3D (register int[]){ 1, 2 };
+	(void)p;
+	(void)q;
+}
+
+/*
+ * check-name: c23-compound-literal-register-addr
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-compound-literal-register-addr.c:3:20: warning: taking address of 'r=
egister' compound literal
+c23-compound-literal-register-addr.c:4:19: warning: taking address of 'r=
egister' compound literal
+ * check-error-end
+ */
diff --git a/validation/c23-compound-literal-storage-error.c b/validation=
/c23-compound-literal-storage-error.c
new file mode 100644
index 000000000000..c6bf45d7cb1d
--- /dev/null
+++ b/validation/c23-compound-literal-storage-error.c
@@ -0,0 +1,37 @@
+void *e =3D (extern int[]){ 1 };
+void *t =3D (typedef int[]){ 1 };
+int f_reg =3D sizeof((register int){ 1 });
+
+static void bad_block_literals(int non_const)
+{
+	int *a1 =3D (auto int[]){ 1, 2 };
+	int a2 =3D (auto){ 1 };
+	int *tl =3D (thread_local int[]){ 14 };
+	int *nc =3D (static int[]){ non_const };
+	int *dup_s =3D (static static int[]){ 1 };
+	int s_reg =3D (static register int){ 1 };
+
+	(void)a1;
+	(void)a2;
+	(void)tl;
+	(void)nc;
+	(void)dup_s;
+	(void)s_reg;
+}
+
+/*
+ * check-name: c23-compound-literal-storage-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-compound-literal-storage-error.c:1:12: error: 'extern' is not allowe=
d in compound literal
+c23-compound-literal-storage-error.c:2:12: error: 'typedef' is not allow=
ed in compound literal
+c23-compound-literal-storage-error.c:3:21: error: file-scope compound li=
teral cannot specify 'register'
+c23-compound-literal-storage-error.c:7:20: error: 'auto' is not allowed =
in compound literal
+c23-compound-literal-storage-error.c:8:19: error: 'auto' is not allowed =
in compound literal
+c23-compound-literal-storage-error.c:9:20: error: block-scope compound l=
iteral with 'thread_local' requires 'static'
+c23-compound-literal-storage-error.c:11:37: error: duplicate static
+c23-compound-literal-storage-error.c:12:38: error: multiple storage clas=
ses
+c23-compound-literal-storage-error.c:10:35: error: non-constant initiali=
zer for static object
+ * check-error-end
+ */
diff --git a/validation/c23-compound-literal-storage-pedantic.c b/validat=
ion/c23-compound-literal-storage-pedantic.c
new file mode 100644
index 000000000000..a4ddc95fdb0f
--- /dev/null
+++ b/validation/c23-compound-literal-storage-pedantic.c
@@ -0,0 +1,10 @@
+static const int *p =3D (static int[]){ 1, 2, 3 };
+
+/*
+ * check-name: c23-compound-literal-storage-pedantic
+ * check-command: sparse -std=3Dc11 -Wpedantic $file
+ *
+ * check-error-start
+c23-compound-literal-storage-pedantic.c:1:24: warning: storage-class spe=
cifiers in compound literals are a C23 feature
+ * check-error-end
+ */
diff --git a/validation/c23-compound-literal-storage.c b/validation/c23-c=
ompound-literal-storage.c
new file mode 100644
index 000000000000..75a4552eecde
--- /dev/null
+++ b/validation/c23-compound-literal-storage.c
@@ -0,0 +1,27 @@
+static const int *p =3D (static int[]){ 1, 2, 3 };
+static const int *cp =3D (constexpr int[]){ 4, 5, 6 };
+
+static int test(void)
+{
+	static int *lp =3D (static int[]){ 7, 8, 9 };
+	register int rv =3D (register int){ 12 };
+	int *tp =3D (static thread_local int[]){ 14 };
+	const int *lcp =3D &(static constexpr int){ 99 };
+	int auto_ce =3D (constexpr int){ 42 };
+
+	return lp[0] + rv + tp[0] + *lcp + auto_ce + p[0] + cp[0];
+}
+
+static_assert(sizeof((static int[]){ 1, 2, 3 }) =3D=3D 3 * sizeof(int),
+	      "sizeof static compound literal");
+static_assert(sizeof((constexpr int[]){ 1, 2, 3, 4 }) =3D=3D 4 * sizeof(=
int),
+	      "sizeof constexpr compound literal");
+static_assert(sizeof((thread_local int[]){ 14, 15 }) =3D=3D 2 * sizeof(i=
nt),
+	      "sizeof file-scope thread_local compound literal");
+static_assert((constexpr int){ 42 } =3D=3D 42,
+	      "constexpr scalar compound literal in ICE");
+
+/*
+ * check-name: c23-compound-literal-storage
+ * check-command: sparse -std=3Dc23 -pedantic $file
+ */
