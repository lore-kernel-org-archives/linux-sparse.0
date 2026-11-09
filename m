Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256420;
	b=Fl/11u9EoknFwhGfEdMbOzLfdEu+DQtSUW5pLuFQPsyN5yorGIApWVsu0/ZtEKyZWJzj
	 /VwfyXsM5zm4Gd29x4HHZDSJ0NrvVOeouUa0KeyRwPUqQXqTCASMi8yX5u99g4GiKAqXt
	 ksIMCUrXUv68Xj2/oB2K93ANFFu+KVVJAOE2/KNUdZe5u1GLMt1LPudYyMqKlcqR5jX5g
	 DfXH1lYhH+Em83Pumanb6o+TufhQatj1lnoPwFwOzKPCZei10keej6Nl2b2rt1YGlJZix
	 4dN/kMqyylYcaBWgq+Je2/8byEY8Xmmtby6uva4BXg1nDHHEkPTmwBYwsvBZ0J82sNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=hGetKHTCL2uUwSexhr4Og9mrlzw2uRiAx03dh5e7dZE=;
	b=Yl+SrDaqJlTYvnIZ9uxZJ/NF3aVy4O+8Wd48Tp2YviLCzOYQoexwhNytTJQS12LieUns
	 lPVeBjY78UWUJry0FcHjj6dSDwkToP+QGclxOMV0VDg9uF6w4S1mQVLzWt3iaAB1z5NPs
	 8PIU6ls0zEVXhY3O/JUkT2BRQ5SaG6hvxinkSqhzmB40HFijlUo8cAkvw6D/WOdJbMuLn
	 bYgAoOYnQBf+JoqjUyYYviUBv37OjlV/QfQGEtLSP6ZQNNOpbEcIUFc/9YfNwdCm7y8/L
	 YAYAHAfEExf9cyrDh5rtIsnOsj6Svhjbm5NtJgKOSNXTCchLhEEmOjlddkp74FL+eYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=J6UapUTI;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E6606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D0E6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=J6UapUTI
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM54SJJz1XLX7j;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256409; x=1796848410; bh=hGetK
	HTCL2uUwSexhr4Og9mrlzw2uRiAx03dh5e7dZE=; b=J6UapUTIABGw4nLmXDYBM
	LobauWkPGw1J0uBxXjptOtZG5h5s8jbL4n3TuhEdASy3UiUC5aD6q5NMv67EQGGp
	jZ4Idktdeb/ohwESBpEQTq/Mjfdsk6FmOUa//FLRvA58NsRvbGisoW/9lcHGTyt2
	TZnYxN2Ncv+twm3Gm6MqAN4m3eHckEizOqz704DJf571vkX5atOrsSBtKOXMqqXL
	PZMex+P5mktVC6/miD7UgBFYplxNjF9tw/m57+kKQ8kODzmkYXsdRZIUeyS30nzl
	zegv4nDhivDB4PaSQpjDbz86JmO9QwQK4LsdyQoNqGu4mj1/f1QR3aqgcFb7hT10
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HOl4Oa7jHUIq; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLt1xC6z1XLyhw;
	Mon,  9 Nov 2026 20:33:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 09/73] builtin: Fix atomic builtin type checking and object_size bounds
Date: Mon,  9 Nov 2026 12:31:55 -0800
Message-ID: <20261109203259.362845-10-bvanassche@acm.org>
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

Fix builtin argument evaluation and __builtin_object_size() expansion in
builtin.c:
- Initialize sym upfront in eval_args() before reporting argument count
  errors.
- Accept integer, enum, pointer, and restricted bitwise types in
  eval_atomic_common() while preserving per-parameter const and volatile
  pointer qualifiers via make_atomic_ptr_type().
- Bound pointer-chasing hops, unwrap parenthesized expressions, guard
  null symbols, and clamp offset subtraction in expand_object_size().
- Add regression tests in validation/atomic-builtins-types.c,
  validation/atomic-builtins-const.c, and
  validation/builtin-object-size-cycle.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c                              | 112 +++++++++++++++++--------
 symbol.c                               |   3 +
 symbol.h                               |   1 +
 validation/atomic-builtins-const.c     |  67 +++++++++++++++
 validation/atomic-builtins-types.c     |  47 +++++++++++
 validation/builtin-object-size-cycle.c |  44 ++++++++++
 6 files changed, 239 insertions(+), 35 deletions(-)
 create mode 100644 validation/atomic-builtins-const.c
 create mode 100644 validation/atomic-builtins-types.c
 create mode 100644 validation/builtin-object-size-cycle.c

diff --git a/builtin.c b/builtin.c
index 1f3568bbad47..78a971ce4bb5 100644
--- a/builtin.c
+++ b/builtin.c
@@ -68,7 +68,7 @@ static int evaluate_pure_unop(struct expression *expr)
 static int eval_args(struct expression *expr, int n)
 {
 	struct expression *arg;
-	struct symbol *sym;
+	struct symbol *sym =3D expr->fn->ctype;
 	const char *msg;
 	int rc =3D 1;
=20
@@ -87,7 +87,6 @@ static int eval_args(struct expression *expr, int n)
 	return rc;
=20
 error:
-	sym =3D expr->fn->ctype;
 	expression_error(expr, "%s for %s", msg, show_ident(sym->ident));
 	return 0;
 }
@@ -454,47 +453,78 @@ struct symbol_op generic_int_op =3D {
 };
=20
=20
+static struct symbol *make_atomic_ptr_type(struct position pos,
+					   struct symbol *target,
+					   unsigned long mods,
+					   struct ident *as)
+{
+	struct symbol *ptr =3D alloc_symbol(pos, SYM_PTR);
+	ptr->ctype.base_type =3D target;
+	ptr->ctype.modifiers =3D mods;
+	ptr->ctype.as =3D as;
+	ptr->bit_size =3D bits_in_pointer;
+	ptr->ctype.alignment =3D pointer_alignment;
+	return ptr;
+}
+
 static int eval_atomic_common(struct expression *expr)
 {
 	struct symbol *fntype =3D expr->fn->ctype->ctype.base_type;
 	struct symbol_list *types =3D NULL;
 	struct symbol *ctype =3D NULL;
+	struct symbol *valtype =3D NULL;
+	struct symbol *aptr =3D NULL;
 	struct symbol *t;
 	struct expression *arg;
 	int n =3D 0;
=20
 	// The number of arguments has already be verified.
-	// The first arg must be a pointer to an integral type.
+	// The first arg must be a pointer to an integral or pointer type.
 	PREPARE_PTR_LIST(fntype->arguments, t);
 	FOR_EACH_PTR(expr->args, arg) {
-		struct symbol *ptrtype =3D NULL;
-
 		if (++n =3D=3D 1) {
-			t =3D arg->ctype;
-			if (!t)
+			struct symbol *proto_ptr =3D t ? t->ctype.base_type : NULL;
+			unsigned long proto_mods =3D MOD_VOLATILE;
+			if (proto_ptr && proto_ptr->ctype.base_type)
+				proto_mods =3D proto_ptr->ctype.base_type->ctype.modifiers;
+			aptr =3D arg->ctype;
+			if (!aptr)
 				return 0;
-			if (t->type =3D=3D SYM_NODE)
-				t =3D t->ctype.base_type;
-			if (!t)
+			if (aptr->type =3D=3D SYM_NODE)
+				aptr =3D aptr->ctype.base_type;
+			if (!aptr)
 				return 0;
-			if (t->type !=3D SYM_PTR)
+			if (aptr->type !=3D SYM_PTR)
 				goto err;
-			ptrtype =3D t;
-			t =3D t->ctype.base_type;
-			if (!t)
+			ctype =3D examine_pointer_target(aptr);
+			if (!ctype)
 				return 0;
-			if (t->type =3D=3D SYM_NODE)
-				t =3D t->ctype.base_type;
-			if (!t)
-				return 0;
-			if (t->type !=3D SYM_PTR && t->ctype.base_type !=3D &int_type)
+			if (ctype->type !=3D SYM_PTR && ctype->ctype.base_type !=3D &int_type=
 &&
+			    !is_int_type(ctype) && !is_restricted_type(ctype))
 				goto err;
-			ctype =3D t;
-			t =3D ptrtype;
+			valtype =3D ctype;
+			if (aptr->ctype.modifiers & MOD_NOCAST) {
+				struct symbol *node =3D alloc_symbol(arg->pos, SYM_NODE);
+				*node =3D *ctype;
+				node->type =3D SYM_NODE;
+				node->ctype.base_type =3D ctype;
+				node->ctype.modifiers |=3D MOD_NOCAST;
+				valtype =3D node;
+			}
+			t =3D make_atomic_ptr_type(
+				arg->pos, ctype,
+				proto_mods | (aptr->ctype.modifiers & (MOD_ATOMIC | MOD_NOCAST | MOD=
_NODEREF)),
+				aptr->ctype.as);
+		} else if (!t) {
+			break;
 		} else if (is_dynamic_type(t)) {
-			t =3D ctype;
-		} else if (t =3D=3D &ptr_ctype) {
-			t =3D ptrtype;
+			t =3D valtype;
+		} else if (t =3D=3D &ptr_ctype || t->ctype.base_type =3D=3D &ptr_ctype=
) {
+			t =3D make_atomic_ptr_type(arg->pos, ctype,
+						 aptr->ctype.modifiers & MOD_NOCAST, NULL);
+		} else if (t =3D=3D &const_ptr_ctype || t->ctype.base_type =3D=3D &con=
st_ptr_ctype) {
+			t =3D make_atomic_ptr_type(arg->pos, ctype,
+						 MOD_CONST | (aptr->ctype.modifiers & MOD_NOCAST), NULL);
 		}
 		add_ptr_list(&types, t);
 		NEXT_PTR_LIST(t);
@@ -502,7 +532,7 @@ static int eval_atomic_common(struct expression *expr=
)
 	FINISH_PTR_LIST(t);
=20
 	if (!expr->ctype)	// set the return type, if needed
-		expr->ctype =3D ctype;
+		expr->ctype =3D valtype;
 	return evaluate_arguments(types, expr->args);
=20
 err:
@@ -528,8 +558,13 @@ static int expand_object_size(struct expression *exp=
r, int cost)
 	struct expression *arg =3D first_expression(expr->args);
 	int type =3D get_expression_value_silent(ptr_list_nth(expr->args, 1));
 	unsigned long val =3D -1, off =3D 0;
+	int hops =3D 0;
=20
 	while (arg) {
+		if (++hops > 64) {
+			val =3D -1;
+			break;
+		}
 		switch (arg->type) {
 		case EXPR_IMPLIED_CAST:
 		case EXPR_CAST:
@@ -544,15 +579,20 @@ static int expand_object_size(struct expression *ex=
pr, int cost)
 			arg =3D arg->left;
 			continue;
 		case EXPR_PREOP:
+			if (arg->op =3D=3D '(') {
+				arg =3D arg->unop;
+				continue;
+			}
 			// a deref is just intermediate variable
 			// and so the offset needs to be zeroed.
 			if (arg->op =3D=3D '*') {
 				struct expression *parent =3D arg;
 				arg =3D arg->unop;
-				off =3D 0;
+				if (!arg)
+					break;
 				switch (arg->type) {
 				case EXPR_SYMBOL:
-					arg =3D arg->symbol->initializer;
+					arg =3D arg->symbol ? arg->symbol->initializer : NULL;
 					if (arg =3D=3D parent) {
 						// stop at self-initialized vars
 						// and do not expand them.
@@ -562,6 +602,7 @@ static int expand_object_size(struct expression *expr=
, int cost)
 					}
 					continue;
 				default:
+					off =3D 0;
 					break;
 				}
 			}
@@ -584,7 +625,7 @@ static int expand_object_size(struct expression *expr=
, int cost)
 	else if (type & 1)
 		return UNSAFE;
 	else
-		val -=3D off;
+		val =3D (off > val) ? 0 : val - off;
=20
 	expr->flags |=3D CEF_SET_ICE;
 	expr->type =3D EXPR_VALUE;
@@ -678,13 +719,14 @@ static const struct builtin_fn builtins_common[] =3D=
 {
 #define size_t_ctype	&size_t_alias
 #define va_list_ctype	&ptr_ctype
 #define vol_ptr		&volatile_ptr_ctype
+#define cv_ptr		&const_volatile_ptr_ctype
 	{ "__atomic_add_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
-	{ "__atomic_always_lock_free", &bool_ctype, 0, { size_t_ctype, vol_ptr =
}},
+	{ "__atomic_always_lock_free", &bool_ctype, 0, { size_t_ctype, cv_ptr }=
},
 	{ "__atomic_and_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_clear", &void_ctype, 0, { &volatile_bool_ptr_ctype, &int_ct=
ype }},
-	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &=
ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op =3D &atomic_op },
+	{ "__atomic_compare_exchange", &bool_ctype, 0, { vol_ptr, &ptr_ctype, &=
const_ptr_ctype, &bool_ctype, &int_ctype, &int_ctype }, .op =3D &atomic_o=
p },
 	{ "__atomic_compare_exchange_n", &bool_ctype, 0, { vol_ptr, &ptr_ctype,=
 &dyntype, &bool_ctype, &int_ctype, &int_ctype }, .op =3D &atomic_op },
-	{ "__atomic_exchange", &void_ctype, 0, { vol_ptr, &ptr_ctype, &ptr_ctyp=
e, &int_ctype }, .op =3D &atomic_op },
+	{ "__atomic_exchange", &void_ctype, 0, { vol_ptr, &const_ptr_ctype, &pt=
r_ctype, &int_ctype }, .op =3D &atomic_op },
 	{ "__atomic_exchange_n", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .o=
p =3D &atomic_op },
 	{ "__atomic_fetch_add", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_fetch_and", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
@@ -692,13 +734,13 @@ static const struct builtin_fn builtins_common[] =3D=
 {
 	{ "__atomic_fetch_or",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_fetch_sub", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_fetch_xor", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
-	{ "__atomic_is_lock_free", &bool_ctype, 0, { size_t_ctype, vol_ptr }},
-	{ "__atomic_load", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype },=
 .op =3D &atomic_op },
-	{ "__atomic_load_n", NULL, 0, { vol_ptr, &int_ctype }, .op =3D &atomic_=
op },
+	{ "__atomic_is_lock_free", &bool_ctype, 0, { size_t_ctype, cv_ptr }},
+	{ "__atomic_load", &void_ctype, 0, { cv_ptr, &ptr_ctype, &int_ctype }, =
.op =3D &atomic_op },
+	{ "__atomic_load_n", NULL, 0, { cv_ptr, &int_ctype }, .op =3D &atomic_o=
p },
 	{ "__atomic_nand_fetch",NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_or_fetch",  NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_signal_fence", &void_ctype, 0, { &int_ctype }},
-	{ "__atomic_store", &void_ctype, 0, { vol_ptr, &ptr_ctype, &int_ctype }=
, .op =3D &atomic_op },
+	{ "__atomic_store", &void_ctype, 0, { vol_ptr, &const_ptr_ctype, &int_c=
type }, .op =3D &atomic_op },
 	{ "__atomic_store_n", &void_ctype, 0, { vol_ptr, &dyntype, &int_ctype }=
, .op =3D &atomic_op },
 	{ "__atomic_sub_fetch", NULL, 0, { vol_ptr, &dyntype, &int_ctype }, .op=
 =3D &atomic_op },
 	{ "__atomic_test_and_set", &bool_ctype, 0, { vol_ptr, &int_ctype }},
diff --git a/symbol.c b/symbol.c
index feaaed3b8a2d..abf3a198acc8 100644
--- a/symbol.c
+++ b/symbol.c
@@ -883,6 +883,7 @@ struct symbol	const_void_ctype, const_char_ctype;
 struct symbol	const_ptr_ctype, const_string_ctype;
 struct symbol	const_wchar_ctype, const_wstring_ctype;
 struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+struct symbol	const_volatile_void_ctype, const_volatile_ptr_ctype;
 struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
=20
 struct symbol	zero_int;
@@ -990,6 +991,8 @@ static const struct ctype_declare {
 	{ &const_wchar_ctype,  T_CONST(&int_ctype, NULL, NULL) },
 	{ &volatile_void_ctype,T_NODE(MOD_VOLATILE, &void_ctype, NULL, NULL) },
 	{ &volatile_ptr_ctype, T_PTR(&volatile_void_ctype) },
+	{ &const_volatile_void_ctype, T_NODE(MOD_CONST | MOD_VOLATILE, &void_ct=
ype, NULL, NULL) },
+	{ &const_volatile_ptr_ctype, T_PTR(&const_volatile_void_ctype) },
 	{ &volatile_bool_ctype,T_NODE(MOD_VOLATILE, &bool_ctype, NULL, NULL) },
 	{ &volatile_bool_ptr_ctype, T_PTR(&volatile_bool_ctype) },
 	{ NULL, }
diff --git a/symbol.h b/symbol.h
index bd163450628b..9d657fbba260 100644
--- a/symbol.h
+++ b/symbol.h
@@ -316,6 +316,7 @@ extern struct symbol	const_void_ctype, const_char_cty=
pe;
 extern struct symbol	const_ptr_ctype, const_string_ctype;
 extern struct symbol	const_wchar_ctype, const_wstring_ctype;
 extern struct symbol	volatile_void_ctype, volatile_ptr_ctype;
+extern struct symbol	const_volatile_void_ctype, const_volatile_ptr_ctype=
;
 extern struct symbol	volatile_bool_ctype, volatile_bool_ptr_ctype;
=20
 /* Special internal symbols */
diff --git a/validation/atomic-builtins-const.c b/validation/atomic-built=
ins-const.c
new file mode 100644
index 000000000000..cce40c18cc5e
--- /dev/null
+++ b/validation/atomic-builtins-const.c
@@ -0,0 +1,67 @@
+static void test_atomic_const_writes(const int *cptr, int *ptr,
+				     int *exp, int *out,
+				     const _Bool *cflag)
+{
+	int val =3D 1;
+
+	__atomic_store(cptr, &val, 0);
+	__atomic_store_n(cptr, val, 0);
+	__atomic_load(ptr, cptr, 0);
+	__atomic_exchange(cptr, &val, out, 0);
+	__atomic_exchange(ptr, &val, cptr, 0);
+	(void)__atomic_exchange_n(cptr, val, 0);
+	(void)__atomic_compare_exchange(cptr, exp, &val, 0, 0, 0);
+	(void)__atomic_compare_exchange(ptr, cptr, &val, 0, 0, 0);
+	(void)__atomic_compare_exchange_n(cptr, exp, val, 0, 0, 0);
+	(void)__atomic_compare_exchange_n(ptr, cptr, val, 0, 0, 0);
+	(void)__atomic_fetch_add(cptr, 1, 0);
+	(void)__atomic_test_and_set(cflag, 0);
+	__atomic_clear(cflag, 0);
+}
+
+/*
+ * check-name: atomic-builtins-const
+ * check-command: sparse $file
+ *
+ * check-error-start
+atomic-builtins-const.c:7:24: warning: incorrect type in argument 1 (dif=
ferent modifiers)
+atomic-builtins-const.c:7:24:    expected int volatile *
+atomic-builtins-const.c:7:24:    got int const *cptr
+atomic-builtins-const.c:8:26: warning: incorrect type in argument 1 (dif=
ferent modifiers)
+atomic-builtins-const.c:8:26:    expected int volatile *
+atomic-builtins-const.c:8:26:    got int const *cptr
+atomic-builtins-const.c:9:28: warning: incorrect type in argument 2 (dif=
ferent modifiers)
+atomic-builtins-const.c:9:28:    expected int *
+atomic-builtins-const.c:9:28:    got int const *cptr
+atomic-builtins-const.c:10:27: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:10:27:    expected int volatile *
+atomic-builtins-const.c:10:27:    got int const *cptr
+atomic-builtins-const.c:11:38: warning: incorrect type in argument 3 (di=
fferent modifiers)
+atomic-builtins-const.c:11:38:    expected int *
+atomic-builtins-const.c:11:38:    got int const *cptr
+atomic-builtins-const.c:12:35: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:12:35:    expected int volatile *
+atomic-builtins-const.c:12:35:    got int const *cptr
+atomic-builtins-const.c:13:41: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:13:41:    expected int volatile *
+atomic-builtins-const.c:13:41:    got int const *cptr
+atomic-builtins-const.c:14:46: warning: incorrect type in argument 2 (di=
fferent modifiers)
+atomic-builtins-const.c:14:46:    expected int *
+atomic-builtins-const.c:14:46:    got int const *cptr
+atomic-builtins-const.c:15:43: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:15:43:    expected int volatile *
+atomic-builtins-const.c:15:43:    got int const *cptr
+atomic-builtins-const.c:16:48: warning: incorrect type in argument 2 (di=
fferent modifiers)
+atomic-builtins-const.c:16:48:    expected int *
+atomic-builtins-const.c:16:48:    got int const *cptr
+atomic-builtins-const.c:17:34: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:17:34:    expected int volatile *
+atomic-builtins-const.c:17:34:    got int const *cptr
+atomic-builtins-const.c:18:37: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:18:37:    expected void volatile *
+atomic-builtins-const.c:18:37:    got bool const *cflag
+atomic-builtins-const.c:19:24: warning: incorrect type in argument 1 (di=
fferent modifiers)
+atomic-builtins-const.c:19:24:    expected bool volatile *
+atomic-builtins-const.c:19:24:    got bool const *cflag
+ * check-error-end
+ */
diff --git a/validation/atomic-builtins-types.c b/validation/atomic-built=
ins-types.c
new file mode 100644
index 000000000000..5f163e5e60f8
--- /dev/null
+++ b/validation/atomic-builtins-types.c
@@ -0,0 +1,47 @@
+typedef unsigned int __attribute__((bitwise)) be32;
+enum E { E_ZERO, E_ONE, E_TWO };
+
+static be32 test_atomic_restricted(be32 *ptr, be32 val, be32 *expected)
+{
+	__atomic_store_n(ptr, val, 0);
+	be32 old =3D __atomic_exchange_n(ptr, val, 0);
+	_Bool ok =3D __atomic_compare_exchange_n(ptr, expected, val, 0, 0, 0);
+	(void)ok;
+	return old;
+}
+
+static enum E test_atomic_enum(enum E *ptr, enum E val)
+{
+	__atomic_store_n(ptr, val, 0);
+	return __atomic_load_n(ptr, 0);
+}
+
+static int test_atomic_const_reads(int *ptr, const int *cptr,
+				   volatile int *vptr,
+				   const volatile int *cvptr,
+				   int *expected, int *out,
+				   volatile _Bool *vflag)
+{
+	int v =3D __atomic_load_n(cptr, 0);
+	v +=3D __atomic_load_n(cvptr, 0);
+
+	__atomic_load(cptr, out, 0);
+	__atomic_load(cvptr, out, 0);
+	__atomic_store(ptr, cptr, 0);
+	__atomic_exchange(ptr, cptr, out, 0);
+	(void)__atomic_compare_exchange(ptr, expected, cptr, 0, 0, 0);
+
+	__atomic_store_n(vptr, v, 0);
+	v +=3D __atomic_fetch_add(vptr, 1, 0);
+	(void)__atomic_test_and_set(vflag, 0);
+	__atomic_clear(vflag, 0);
+
+	v +=3D __atomic_always_lock_free(sizeof(*cvptr), cvptr);
+	v +=3D __atomic_is_lock_free(sizeof(*cvptr), cvptr);
+	return v;
+}
+
+/*
+ * check-name: atomic-builtins-types
+ * check-command: sparse -Wbitwise $file
+ */
diff --git a/validation/builtin-object-size-cycle.c b/validation/builtin-=
object-size-cycle.c
new file mode 100644
index 000000000000..38e2a9786e9a
--- /dev/null
+++ b/validation/builtin-object-size-cycle.c
@@ -0,0 +1,44 @@
+static void *p2;
+static void *p1 =3D &p2;
+static void *p2 =3D &p1;
+
+static unsigned long test_static_max(void)
+{
+	return __builtin_object_size(*(void **)p1, 0);
+}
+
+static unsigned long test_static_min(void)
+{
+	return __builtin_object_size(*(void **)p1, 2);
+}
+
+/*
+ * Self-referential local pointer definitions (SSA/def cycle through OP_=
ADD
+ * and cast) that traverse expand_object_size()'s visited >=3D 64 cycle =
guard.
+ */
+static unsigned long test_self_add_max(void)
+{
+	char *p =3D p + 1;
+	return __builtin_object_size(p, 0);
+}
+
+static unsigned long test_self_add_min(void)
+{
+	char *p =3D p + 1;
+	return __builtin_object_size(p, 2);
+}
+
+static unsigned long test_self_cast_max(void)
+{
+	void *q =3D (void *)q;
+	return __builtin_object_size(q, 0);
+}
+
+/*
+ * check-name: builtin-object-size-cycle
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\..*\\$-1
+ * check-output-contains: ret\\..*\\$0
+ */
