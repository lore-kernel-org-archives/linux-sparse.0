Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256434;
	b=j3qv41n1L6H4Dr073sgRgkRjfKOLQ9ToFa30KkndO9oLZtN/HkRpmNvcHhM5+dT55nhD
	 Hyhn9fw8wA8naQLKCD+lQ7nIi8LVOjpL1HSC2DQdEWx8S5tpIZKcYLFb0uil64Z2N99a4
	 tCxmn8mKQIT/KTUBp08mnO3CDvv7GX+pLMGt7mHNceqO+tMvehE0+FlxoMm2sNxSQlLzl
	 AjALzyc7J1vcUnjo+fdNybno8AUtdC4kZvnmk0pRV03Q+UkUupGkK6PaVQFv4TRl0NM8z
	 CeDYu1jXKOrcOv5AA1ZRk4WHEN6eABmDpFVQdFIixxUZr0qKNyPys5pWw/4Qu6t5XLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=GZSLDKaGztjxMYWTFLN0EEblO/EHGqCWRCS6JONvF8g=;
	b=rvvQDSEVPjoCsC0UxqjwmWK8mnEb3AJkQSrsyyK/dsVHDR+m7WGf+SALRaae/t58aVTB
	 kCwZuBRTFl2baja+QlO/C5ebDmdutLnrisYs/KWE6/SQC8fZELeVkW//YHZSANj84GmmK
	 yMrNKXjBxPNyNhbr8NsNsHCnTR5thuLblBjzkVfjzDkzwPPCvPWQeMJDlVGUiprQVCRom
	 AzEfXke7WLs82ajOci8sH/uehTMSvyvwp/ioVFqbn/hYuNyvSxi50up2mooKcWPL7d3pP
	 9BlyckqYFDPWNF5uz73EnI9BeO85UwjEjo/ML/gzeLnblEFZDyiTtsvg1zuFgFUIQyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=sMxS2RlC;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BA606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 745BA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=sMxS2RlC
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMG10JHz1XLyNK;
	Mon,  9 Nov 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=GZSLD
	KaGztjxMYWTFLN0EEblO/EHGqCWRCS6JONvF8g=; b=sMxS2RlCGFNehYVuDm23q
	c0NI2gqSBmnaVLBOUpArsPhZHaaGgb29WOEqqh48je8hNxSHwBuEUBPlx1Wo/K3t
	1v8Li3cDjdd1vfj9Mq3IpsoMUTwX74JSDdHWPcpL/FNwm2pOcrIdmzdKjRzHrrRZ
	7Wmg+B4ryO+Ddfn0Fnb1NJiKsbSWESo8TEf01r04xrICkArOUvLLvUiOZU6gkv+I
	41H4Hl2tH/q8rG6bUlLrBJd+VZvCpwdYqyb5xgPgMVNI2lzwRx0ZH9qsZya7EGMh
	1E3oAq24Pu2a1uS6PGJsTVfUDbU8zg5Q/CQBUwRS9odiRm0yCeA3nmtizFpxzGFK
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ERnsv8N4pk0I; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM14jFbz1XMYJb;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 42/73] c23: Add support for static_assert, alignas, alignof, thread_local
Date: Mon,  9 Nov 2026 12:32:28 -0800
Message-ID: <20261109203259.362845-43-bvanassche@acm.org>
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

Register static_assert, alignas, alignof, and thread_local as reserved
C23 keywords and support single-argument static_assert(expr) without a
message string per ISO C23 6.7.12:
- Mark static_assert and alignof as reserved identifiers in C23 mode
  while keeping them available as ordinary identifiers in pre-C23 modes.
- Warn under -Wpedantic when alignof or _Alignof is applied to an
  expression rather than a type name.
- Enforce ISO C23 constraints on alignas and thread_local declarations,
  and avoid materializing block-scope thread_local symbols as stack
  locals during linearization.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expression.c                        |  15 ++++-
 ident-list.h                        |   9 ++-
 linearize.c                         |   2 +-
 options.c                           |   2 +
 parse.c                             | 100 ++++++++++++++++++++++++++--
 parse.h                             |   1 +
 symbol.h                            |   2 +
 validation/c11-c23-keywords-ident.c |  19 ++++++
 validation/c23-alignof-pedantic.c   |  20 ++++++
 validation/c23-keywords-error.c     |  48 +++++++++++++
 validation/c23-keywords.c           |  30 +++++++++
 11 files changed, 241 insertions(+), 7 deletions(-)
 create mode 100644 validation/c11-c23-keywords-ident.c
 create mode 100644 validation/c23-alignof-pedantic.c
 create mode 100644 validation/c23-keywords-error.c
 create mode 100644 validation/c23-keywords.c

diff --git a/expression.c b/expression.c
index 04b1a242d08a..4545adcf4c02 100644
--- a/expression.c
+++ b/expression.c
@@ -646,13 +646,21 @@ static struct token *type_info_expression(struct to=
ken *token,
 	struct expression **tree, int type)
 {
 	struct expression *expr =3D alloc_expression(token->pos, type);
+	struct ident *op_ident =3D token->ident;
+	bool std_alignof =3D (op_ident =3D=3D &_Alignof_ident ||
+			    op_ident =3D=3D &alignof_ident);
 	struct token *p;
=20
 	*tree =3D expr;
 	expr->flags =3D CEF_SET_ICE; /* XXX: VLA support will need that changed=
 */
 	token =3D token->next;
-	if (!match_op(token, '(') || !lookup_type(token->next))
+	if (!match_op(token, '(') || !lookup_type(token->next)) {
+		if (std_alignof && Wpedantic)
+			warning(expr->pos,
+				"ISO C does not allow '%s' on an expression",
+				show_ident(op_ident));
 		return unary_expression(token, &expr->cast_expression);
+	}
 	p =3D token;
 	token =3D typename(token->next, &expr->cast_type, NULL);
=20
@@ -672,6 +680,10 @@ static struct token *type_info_expression(struct tok=
en *token,
 	 */
 	if (match_op(token, '{')) {
 		struct expression *cast =3D alloc_expression(p->pos, EXPR_CAST);
+		if (std_alignof && Wpedantic)
+			warning(expr->pos,
+				"ISO C does not allow '%s' on an expression",
+				show_ident(op_ident));
 		cast->cast_type =3D expr->cast_type;
 		expr->cast_type =3D NULL;
 		expr->cast_expression =3D cast;
@@ -691,6 +703,7 @@ static struct token *unary_expression(struct token *t=
oken, struct expression **t
 				int type;
 			} type_information[] =3D {
 				{ &sizeof_ident, EXPR_SIZEOF },
+				{ &alignof_ident, EXPR_ALIGNOF },
 				{ &__alignof___ident, EXPR_ALIGNOF },
 				{ &__alignof_ident, EXPR_ALIGNOF },
 				{ &_Alignof_ident, EXPR_ALIGNOF },
diff --git a/ident-list.h b/ident-list.h
index 5f4d1fef5a81..83031b265388 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -43,12 +43,19 @@ IDENT(_Noreturn);
 IDENT_RESERVED(_Static_assert);
 IDENT(_Thread_local);
=20
+/* C23 keywords */
+IDENT(alignas);
+IDENT(alignof);
+IDENT(static_assert);
+IDENT(thread_local);
+
 /* Special case for L'\t' */
 IDENT(L);
=20
 /* Extended gcc identifiers */
 IDENT(asm); IDENT_RESERVED(__asm); IDENT_RESERVED(__asm__);
-IDENT(alignof); IDENT_RESERVED(__alignof); IDENT_RESERVED(__alignof__);=20
+IDENT_RESERVED(__alignof);
+IDENT_RESERVED(__alignof__);
 IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
diff --git a/linearize.c b/linearize.c
index 24b402622b83..bb3a5a9ecf16 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1995,7 +1995,7 @@ static pseudo_t linearize_one_symbol(struct entrypo=
int *ep, struct symbol *sym)
 		return VOID;
=20
 	/* We need to output these puppies some day too.. */
-	if (sym->ctype.modifiers & (MOD_STATIC | MOD_TOPLEVEL))
+	if (sym->ctype.modifiers & (MOD_STATIC | MOD_TOPLEVEL | MOD_TLS))
 		return VOID;
=20
 	sym->initialized =3D 1;
diff --git a/options.c b/options.c
index c140a912e8e9..2de74afc5c35 100644
--- a/options.c
+++ b/options.c
@@ -11,6 +11,7 @@
 #include "lib.h"
 #include "machine.h"
 #include "target.h"
+#include "parse.h"
 #include <ctype.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -1068,4 +1069,5 @@ void handle_switch_finalize(void)
 {
 	handle_switch_v_finalize();
 	handle_switch_W_finalize();
+	init_parser_finalize();
 }
diff --git a/parse.c b/parse.c
index c30a00eafb3e..d6c23fcdfb5d 100644
--- a/parse.c
+++ b/parse.c
@@ -465,6 +465,7 @@ static struct init_keyword {
 	struct symbol_op *op;
 	struct symbol *type;
 	unsigned long mods;
+	int std;
 } typedefs[] =3D {
 #define N(I, O,...)	{ I, O,##__VA_ARGS__ }
 #define D(I, O,...)	N(I,O,##__VA_ARGS__ ),		\
@@ -481,6 +482,7 @@ static struct init_keyword {
 	N("extern",		&extern_op,	.mods =3D MOD_EXTERN),
 	N("__thread",		&thread_op),
 	N("_Thread_local",	&thread_op),
+	N("thread_local",	&thread_op,	.std =3D STANDARD_C23),
=20
 	A("inline",		&inline_op,	.mods =3D MOD_INLINE),
=20
@@ -498,6 +500,7 @@ static struct init_keyword {
 	N("_Atomic",		&atomic_op,	.mods =3D MOD_ATOMIC),
 	N("_Noreturn",		&noreturn_op,	.mods =3D MOD_NORETURN),
 	N("_Alignas",		&alignas_op),
+	N("alignas",		&alignas_op,	.std =3D STANDARD_C23),
=20
 	U("attribute",		&attribute_op),
=20
@@ -546,6 +549,7 @@ static struct init_keyword {
 	N("__context__",	&__context___op),
 	N("__range__",		&range_op),
 	N("_Static_assert",	&static_assert_op),
+	N("static_assert",	&static_assert_op, .std =3D STANDARD_C23),
=20
 	/* Attributes */
 	D("packed",		&packed_op),
@@ -607,14 +611,23 @@ static void init_keyword(int stream, struct init_ke=
yword *kw, enum namespace ns)
 	sym->op =3D kw->op;
 }
=20
+static int parser_stream;
+
 void init_parser(int stream)
 {
 	int i;
=20
-	for (i =3D 0; i < ARRAY_SIZE(typedefs); i++)
+	parser_stream =3D stream;
+	for (i =3D 0; i < ARRAY_SIZE(typedefs); i++) {
+		if (typedefs[i].std)
+			continue;
 		init_keyword(stream, &typedefs[i], NS_TYPEDEF);
-	for (i =3D 0; i < ARRAY_SIZE(keywords); i++)
+	}
+	for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
+		if (keywords[i].std)
+			continue;
 		init_keyword(stream, &keywords[i], NS_KEYWORD);
+	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(ignored_attributes); i++) {
 		const char * name =3D ignored_attributes[i];
@@ -627,6 +640,23 @@ void init_parser(int stream)
 	}
 }
=20
+void init_parser_finalize(void)
+{
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(typedefs); i++) {
+		if (typedefs[i].std && standard >=3D typedefs[i].std)
+			init_keyword(parser_stream, &typedefs[i], NS_TYPEDEF);
+	}
+	for (i =3D 0; i < ARRAY_SIZE(keywords); i++) {
+		if (keywords[i].std && standard >=3D keywords[i].std)
+			init_keyword(parser_stream, &keywords[i], NS_KEYWORD);
+	}
+	if (standard >=3D STANDARD_C23) {
+		static_assert_ident.reserved =3D 1;
+		alignof_ident.reserved =3D 1;
+	}
+}
=20
 static struct token *skip_to(struct token *token, int op)
 {
@@ -1513,6 +1543,7 @@ static struct token *alignas_specifier(struct token=
 *token, struct symbol *sym,
 {
 	int alignment =3D 0;
=20
+	ctx->has_alignas =3D 1;
 	if (!match_op(token, '(')) {
 		sparse_error(token->pos, "expected '(' after _Alignas");
 		return token;
@@ -1986,6 +2017,9 @@ static struct token *handle_bitfield(struct token *=
token, struct decl_state *ctx
 	}
=20
 	bitfield =3D alloc_indirect_symbol(token->pos, ctype, SYM_BITFIELD);
+	if (ctx->has_alignas)
+		sparse_error(token->pos, "alignment specified for bitfield '%s'",
+			show_ident(*ctx->ident));
 	token =3D conditional_expression(token->next, &expr);
 	width =3D const_expression_value(expr);
 	bitfield->bit_size =3D width;
@@ -2042,6 +2076,11 @@ static struct token *declaration_list(struct token=
 *token, struct symbol_list **
 		decl->ctype.modifiers |=3D mod;
 		decl->cleanup =3D ctx.cleanup;
 		decl->endpos =3D token->pos;
+		if (decl->ctype.modifiers & MOD_TLS)
+			sparse_error(
+				decl->pos,
+				"struct or union member '%s' cannot be thread-local",
+				show_ident(decl->ident));
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
 			break;
@@ -2054,7 +2093,9 @@ static struct token *declaration_list(struct token =
*token, struct symbol_list **
 static struct token *struct_declaration_list(struct token *token, struct=
 symbol_list **list)
 {
 	while (!match_op(token, '}')) {
-		if (match_ident(token, &_Static_assert_ident)) {
+		if (match_ident(token, &_Static_assert_ident) ||
+		    (standard >=3D STANDARD_C23 &&
+		     match_ident(token, &static_assert_ident))) {
 			token =3D parse_static_assert(token, NULL);
 			continue;
 		}
@@ -2082,6 +2123,14 @@ static struct token *parameter_declaration(struct =
token *token, struct symbol *s
 	sym->ctype.modifiers |=3D decl_modifiers(&ctx);
 	sym->endpos =3D token->pos;
 	sym->forced_arg =3D ctx.forced;
+	if (ctx.has_alignas)
+		sparse_error(sym->pos,
+			     "alignment specified for parameter '%s'",
+			     show_ident(sym->ident));
+	if (sym->ctype.modifiers & MOD_TLS)
+		sparse_error(sym->pos,
+			     "parameter '%s' cannot be thread-local",
+			     show_ident(sym->ident));
 	return token;
 }
=20
@@ -2092,6 +2141,8 @@ struct token *typename(struct token *token, struct =
symbol **p, int *forced)
 	struct symbol *sym =3D alloc_symbol(token->pos, SYM_NODE);
 	*p =3D sym;
 	token =3D declaration_specifiers(token, &ctx);
+	if (ctx.has_alignas)
+		sparse_error(sym->pos, "alignment specified for type name");
 	token =3D declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype =3D ctx.ctype;
@@ -2654,7 +2705,9 @@ static struct token * statement_list(struct token *=
token, struct statement_list
 			break;
 		if (match_op(token, '}'))
 			break;
-		if (match_ident(token, &_Static_assert_ident)) {
+		if (match_ident(token, &_Static_assert_ident) ||
+		    (standard >=3D STANDARD_C23 &&
+		     match_ident(token, &static_assert_ident))) {
 			token =3D parse_static_assert(token, NULL);
 			continue;
 		}
@@ -3104,6 +3157,16 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 		decl->ctype.modifiers |=3D ctx.f_modifiers;
=20
 		/* K&R argument declaration? */
+		if (lookup_type(token) || match_op(token, '{')) {
+			if (ctx.has_alignas)
+				sparse_error(decl->pos,
+					     "alignment specified for function '%s'",
+					     show_ident(decl->ident));
+			if (decl->ctype.modifiers & MOD_TLS)
+				sparse_error(decl->pos,
+					     "function '%s' cannot be thread-local",
+					     show_ident(decl->ident));
+		}
 		if (lookup_type(token))
 			return parse_k_r_arguments(token, decl, list);
 		if (match_op(token, '{'))
@@ -3167,6 +3230,35 @@ struct token *external_declaration(struct token *t=
oken, struct symbol_list **lis
 			}
 		}
=20
+		if (ctx.has_alignas) {
+			if (is_typedef)
+				sparse_error(decl->pos,
+					     "alignment specified for typedef '%s'",
+					     show_ident(decl->ident));
+			else if (decl->ctype.base_type &&
+				 decl->ctype.base_type->type =3D=3D SYM_FN)
+				sparse_error(decl->pos,
+					     "alignment specified for function '%s'",
+					     show_ident(decl->ident));
+			else if (decl->ctype.modifiers & MOD_REGISTER)
+				sparse_error(decl->pos,
+					     "alignment specified for 'register' object '%s'",
+					     show_ident(decl->ident));
+		}
+
+		if (!is_typedef && (decl->ctype.modifiers & MOD_TLS)) {
+			if (decl->ctype.base_type &&
+			    decl->ctype.base_type->type =3D=3D SYM_FN)
+				sparse_error(decl->pos,
+					     "function '%s' cannot be thread-local",
+					     show_ident(decl->ident));
+			else if (!(decl->ctype.modifiers &
+				   (MOD_TOPLEVEL | MOD_STATIC | MOD_EXTERN)))
+				sparse_error(decl->pos,
+					     "thread-local variable '%s' at block scope must be 'static' or=
 'extern'",
+					     show_ident(decl->ident));
+		}
+
 		if (!match_op(token, ','))
 			break;
=20
diff --git a/parse.h b/parse.h
index e7ea3642b65c..6a528bc8ca4d 100644
--- a/parse.h
+++ b/parse.h
@@ -139,6 +139,7 @@ extern struct symbol *ctype_integer(int size, int wan=
t_unsigned);
 extern int inline_function(struct expression *expr, struct symbol *sym);
 extern void uninline(struct symbol *sym);
 extern void init_parser(int);
+extern void init_parser_finalize(void);
=20
 struct token *expect(struct token *, int, const char *);
=20
diff --git a/symbol.h b/symbol.h
index a14686fe863b..2c6731f88399 100644
--- a/symbol.h
+++ b/symbol.h
@@ -115,6 +115,7 @@ struct decl_state {
 	unsigned char autotype;
 	unsigned char forced;
 	unsigned char packed;
+	unsigned char has_alignas;
 	unsigned char designated_init;
 	unsigned char transparent_union;
 };
@@ -199,6 +200,7 @@ struct symbol {
 					torename:1,
 					packed:1,
 					transparent_union:1;
+			unsigned int has_alignas : 1;
 			int		rank:3;	// arithmetic's rank
 			struct expression *array_size;
 			struct ctype ctype;
diff --git a/validation/c11-c23-keywords-ident.c b/validation/c11-c23-key=
words-ident.c
new file mode 100644
index 000000000000..8fdb011268e4
--- /dev/null
+++ b/validation/c11-c23-keywords-ident.c
@@ -0,0 +1,19 @@
+static int test_c11_idents(void)
+{
+	int alignas =3D 1;
+	int alignof =3D 2;
+	int static_assert =3D 3;
+	int thread_local =3D 4;
+	int bool =3D 5;
+	int true =3D 6;
+	int false =3D 7;
+	int nullptr =3D 8;
+
+	return alignas + alignof + static_assert + thread_local +
+	       bool + true + false + nullptr;
+}
+
+/*
+ * check-name: c11-c23-keywords-ident
+ * check-command: sparse -std=3Dc11 $file
+ */
diff --git a/validation/c23-alignof-pedantic.c b/validation/c23-alignof-p=
edantic.c
new file mode 100644
index 000000000000..d17eabb79108
--- /dev/null
+++ b/validation/c23-alignof-pedantic.c
@@ -0,0 +1,20 @@
+static int test(void)
+{
+	alignas(8) int x =3D 0;
+	int a =3D alignof(int);
+	int b =3D alignof(x);
+	int c =3D _Alignof(x);
+	int d =3D __alignof__(x);
+	int e =3D __alignof(x);
+	return a + b + c + d + e;
+}
+
+/*
+ * check-name: c23-alignof-pedantic
+ * check-command: sparse -std=3Dc23 -pedantic $file
+ *
+ * check-error-start
+c23-alignof-pedantic.c:5:17: warning: ISO C does not allow 'alignof' on =
an expression
+c23-alignof-pedantic.c:6:17: warning: ISO C does not allow '_Alignof' on=
 an expression
+ * check-error-end
+ */
diff --git a/validation/c23-keywords-error.c b/validation/c23-keywords-er=
ror.c
new file mode 100644
index 000000000000..25d3adac3ce8
--- /dev/null
+++ b/validation/c23-keywords-error.c
@@ -0,0 +1,48 @@
+static_assert(0);
+static_assert(0, "must fail");
+
+typedef alignas(8) int bad_typedef;
+
+struct bf {
+	alignas(4) unsigned int x : 2;
+};
+
+static void bad_param(alignas(8) int p)
+{
+	(void)p;
+}
+
+static void bad_fn_locals(void)
+{
+	thread_local int local_tl =3D 0;
+	register alignas(8) int reg_a =3D 0;
+	int sz =3D sizeof(alignas(8) int);
+	(void)local_tl;
+	(void)reg_a;
+	(void)sz;
+}
+
+static int (alignas);
+static int (alignof);
+static int (static_assert);
+static int (thread_local);
+
+/*
+ * check-name: c23-keywords-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-keywords-error.c:1:15: error: static assertion failed
+c23-keywords-error.c:2:15: error: static assertion failed: "must fail"
+c23-keywords-error.c:4:24: error: alignment specified for typedef 'bad_t=
ypedef'
+c23-keywords-error.c:7:35: error: alignment specified for bitfield 'x'
+c23-keywords-error.c:10:23: error: alignment specified for parameter 'p'
+c23-keywords-error.c:17:26: error: thread-local variable 'local_tl' at b=
lock scope must be 'static' or 'extern'
+c23-keywords-error.c:18:33: error: alignment specified for 'register' ob=
ject 'reg_a'
+c23-keywords-error.c:19:25: error: alignment specified for type name
+c23-keywords-error.c:25:12: error: Trying to use reserved word 'alignas'=
 as identifier
+c23-keywords-error.c:26:12: error: Trying to use reserved word 'alignof'=
 as identifier
+c23-keywords-error.c:27:12: error: Trying to use reserved word 'static_a=
ssert' as identifier
+c23-keywords-error.c:28:12: error: Trying to use reserved word 'thread_l=
ocal' as identifier
+ * check-error-end
+ */
diff --git a/validation/c23-keywords.c b/validation/c23-keywords.c
new file mode 100644
index 000000000000..a6f44a735c7e
--- /dev/null
+++ b/validation/c23-keywords.c
@@ -0,0 +1,30 @@
+static_assert(1);
+static_assert(1, "file scope");
+
+struct s {
+	static_assert(1);
+	static_assert(1, "struct scope");
+	alignas(16) int a;
+};
+
+static_assert(alignof(struct s) =3D=3D 16);
+
+thread_local int tl;
+alignas(double) static int aligned_dbl;
+
+static int test(void)
+{
+	static_assert(1);
+	static_assert(1, "func scope");
+	alignas(8) int x =3D 0;
+	static thread_local int local_tl =3D 3;
+	extern thread_local int tl;
+	static_assert(alignof(int) <=3D 8);
+	static_assert(alignof(double) <=3D 16);
+	return x + tl + local_tl + aligned_dbl;
+}
+
+/*
+ * check-name: c23-keywords
+ * check-command: sparse -std=3Dc23 -pedantic -Wno-decl $file
+ */
