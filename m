Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256421;
	b=IKlaJRcmPijpS+C23toR5UKBWmkMuPR6caUyvzLKUaGU784sKdvHjoTQmsf1D17KkiRe
	 R8D7k38JOMtpysNGWRXyBBpef43sZfdkexcEzKU280ZIoYrJnwd0DM/c6HvcnxT1PdQ8Y
	 XDFwPwVZdiUw7YDaAQw8oNu1fvlWRQTQIfOwGENn9sKwjcemrfpWbtIAuLNbsHzYHxDeB
	 Qqy0ezyDHGCghNZFBBbXSse4e0nxz61zYbL5wt/yW6mvpor5uG2y2iYHP56yJyzdRo1cZ
	 ZODQ2fHERP8LOGBWDOgSMpp7+xhJvgryj+7MUcqd5lP1xw71XQuGHjgm//6yWo/6zSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Kr1cIsyrjkK9Q56HY4xHrQlJIEjsSZGcCDb9d3hZ05k=;
	b=rNGuBxL9skf0R28lH+zgNAb8br5MHycl0TbSyu3H+eI1NB8iaG+1cSmcCPBVIn6s3zJN
	 pgnulP1/gTnHAhm8xj/3WUHG+FLeyPL9OddDC94gmkiqgRAerWqzFHO1dnJzBBBPDWmTC
	 jzj9OMb3eOUq+zHN/R6I2alHv3IHwMNYEXROMWmGuJLdSCPt9HRHzGru4AZeKi0sqr3Wf
	 UrCAC22vEjgzTDjVdTsx9aLqMmoR2cnuiwgCbTCEPEz+lkWLvFnhvhpMlO7F0kxtE4CS3
	 2JN19iUGlAO8hWYOOTygn0o9vYelDlRkzDAsxqVio0cr6pmD/ctgilaCphk7coxRjgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mlAzvBrZ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27D606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C27D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mlAzvBrZ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM56pwMz1XMfrZ;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256410; x=1796848411; bh=Kr1cI
	syrjkK9Q56HY4xHrQlJIEjsSZGcCDb9d3hZ05k=; b=mlAzvBrZDHG3Ozga9gbhc
	bPIoq2YAW3XR7HisQEBj63SQViDhT7pjwFrA49j5N/kC4hQiNznOD5Wfv473wxbY
	ofrNdThxBLL/+hyYYH4nG8DrqK3w7z8hnNGXBwSlOBXWi+WOOi+aEAUwlXFa/61Y
	QIR+w1qBTBYo9gG766zlDGZeS+Ae9QNFjqS8C9vgjS1jSz9ESwYx5Xb/EAGyQUpm
	aRk+dT+Tss2tUenw3cjumcfyTL/v22l5hzBMP4J7Jod9HgSL7YWGiIIn9bnYOxFQ
	svBv/w3OBPDa5YfYTxH91AmpfWBxO4T+k4lhxgsGB2atvNUjArtqgKwa9dp1TjiD
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id X_jSCE9g4K1o; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLt6rRsz1XM0nl;
	Mon,  9 Nov 2026 20:33:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 12/73] evaluate: Fix pointer arithmetic, incomplete types, and qualifiers
Date: Mon,  9 Nov 2026 12:31:58 -0800
Message-ID: <20261109203259.362845-13-bvanassche@acm.org>
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

Fix type checking and qualifier handling across evaluate.c, parse.c,
symbol.c, and symbol.h:
- Distinguish forward-declared incomplete structs and unions
  (bit_size =3D -1) from complete GNU empty structs (bit_size =3D 0) via
  sym->defined, and preserve bit_size =3D -1 on arrays of incomplete type=
s.
- Preserve unsigned integer index offsets in evaluate_ptr_add() and
  diagnose pointer addition and subtraction on incomplete types.
- Diagnose incomplete types in evaluate_alignof() and incomplete array or
  multi-dimensional VLA types in evaluate_generic_selection().
- Guard null index types in evaluate_offsetof(), null current_fn in
  check_label_declaration(), and symbolic '[...]' asm constraints.
- Preserve noderef and nocast qualifiers across conditional pointer
  targets and check pointee MOD_NOCAST on pointer casts.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                    | 104 ++++++++++++++++++++++++++++------
 parse.c                       |   2 +
 symbol.c                      |  12 +++-
 symbol.h                      |   2 +-
 validation/eval-type-checks.c |  89 +++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 22 deletions(-)
 create mode 100644 validation/eval-type-checks.c

diff --git a/evaluate.c b/evaluate.c
index 40778f4e8a63..0e4e64d33192 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -246,6 +246,8 @@ static struct symbol *base_type(struct symbol *node, =
unsigned long *modp, struct
 	return node;
 }
=20
+#define MOD_IGN (MOD_QUALIFIER | MOD_FUN_ATTR)
+
 static int is_same_type(struct expression *expr, struct symbol *new)
 {
 	struct symbol *old =3D expr->ctype;
@@ -273,6 +275,13 @@ static int is_same_type(struct expression *expr, str=
uct symbol *new)
 		if (difmod =3D=3D MOD_CONST)
 			return 0;
 	}
+	if (old->type =3D=3D SYM_PTR && new->type =3D=3D SYM_PTR && oldas =3D=3D=
 newas &&
+	    (oldmod & MOD_NOCAST) =3D=3D (newmod & MOD_NOCAST)) {
+		if (!type_difference(&old->ctype, &new->ctype,
+				     MOD_IGN | MOD_NODEREF, MOD_IGN | MOD_NODEREF) ||
+		    ((oldmod & MOD_NOCAST) && is_void_type(new->ctype.base_type)))
+			return 0;
+	}
 	if ((oldmod | newmod) & MOD_NOCAST) {
 		const char *tofrom =3D "to/from";
 		if (!(newmod & MOD_NOCAST))
@@ -588,6 +597,10 @@ static struct symbol *evaluate_ptr_add(struct expres=
sion *expr, struct symbol *i
 		expression_error(expr, "arithmetics on pointers to functions");
 		return NULL;
 	}
+	if (!is_void_type(base) && base->bit_size < 0) {
+		expression_error(expr, "arithmetics on pointers to incomplete type");
+		return NULL;
+	}
=20
 	/* Get the size of whatever the pointer points to */
 	multiply =3D is_void_type(base) ? 1 : bits_to_bytes(base->bit_size);
@@ -603,10 +616,10 @@ static struct symbol *evaluate_ptr_add(struct expre=
ssion *expr, struct symbol *i
 		struct expression *val =3D alloc_expression(expr->pos, EXPR_VALUE);
 		unsigned long long v =3D index->value, mask;
 		mask =3D sign_bit(itype->bit_size);
-		if (v & mask)
+		if (!(itype->ctype.modifiers & MOD_UNSIGNED) && (v & mask))
 			v |=3D -mask;
 		else
-			v &=3D mask - 1;
+			v &=3D mask | (mask - 1);
 		v *=3D multiply;
 		v &=3D bits_mask(bits_in_pointer);
 		val->value =3D v;
@@ -638,8 +651,6 @@ static struct symbol *evaluate_ptr_add(struct express=
ion *expr, struct symbol *i
=20
 static void examine_fn_arguments(struct symbol *fn);
=20
-#define MOD_IGN (MOD_QUALIFIER | MOD_FUN_ATTR)
-
 const char *type_difference(struct ctype *c1, struct ctype *c2,
 	unsigned long mod1, unsigned long mod2)
 {
@@ -812,6 +823,14 @@ static unsigned long target_qualifiers(struct symbol=
 *type)
 	return mod;
 }
=20
+static unsigned long cond_target_qualifiers(struct symbol *type)
+{
+	unsigned long mod =3D type->ctype.modifiers & (MOD_IGN | MOD_NODEREF | =
MOD_NOCAST);
+	if (type->ctype.base_type && type->ctype.base_type->type =3D=3D SYM_ARR=
AY)
+		mod =3D 0;
+	return mod;
+}
+
 static struct symbol *evaluate_ptr_sub(struct expression *expr)
 {
 	const char *typediff;
@@ -835,6 +854,10 @@ static struct symbol *evaluate_ptr_sub(struct expres=
sion *expr)
 		expression_error(expr, "subtraction of functions? Share your drugs");
 		return NULL;
 	}
+	if (!is_void_type(lbase) && lbase->bit_size < 0) {
+		expression_error(expr, "subtraction of pointers to incomplete type");
+		return NULL;
+	}
=20
 	expr->ctype =3D ssize_t_ctype;
 	if (lbase->bit_size > bits_in_char) {
@@ -1222,7 +1245,7 @@ static struct symbol *evaluate_conditional_expressi=
on(struct expression *expr)
 		/* need to be lazier here */
 		lbase =3D examine_pointer_target(ltype);
 		rbase =3D examine_pointer_target(rtype);
-		qual =3D target_qualifiers(ltype) | target_qualifiers(rtype);
+		qual =3D cond_target_qualifiers(ltype) | cond_target_qualifiers(rtype)=
;
=20
 		if (lbase =3D=3D &void_ctype) {
 			/* XXX: pointers to function should warn here */
@@ -1433,8 +1456,8 @@ static int check_assignment_types(struct symbol *ta=
rget, struct expression **rp,
 		}
 		b1 =3D examine_pointer_target(t);
 		b2 =3D examine_pointer_target(s);
-		mod1 =3D t->ctype.modifiers & MOD_IGN;
-		mod2 =3D s->ctype.modifiers & MOD_IGN;
+		mod1 =3D t->ctype.modifiers & (MOD_IGN | MOD_NODEREF);
+		mod2 =3D s->ctype.modifiers & (MOD_IGN | MOD_NODEREF);
 		if (whitelist_pointers(b1, b2)) {
 			/*
 			 * assignments to/from void * are OK, provided that
@@ -2310,14 +2333,32 @@ static struct symbol *evaluate_ptrsizeof(struct e=
xpression *expr)
 	return size_t_ctype;
 }
=20
+static bool is_incomplete_alignof_type(struct symbol *type, bool is_type=
)
+{
+	while (type && type->type =3D=3D SYM_NODE)
+		type =3D type->ctype.base_type;
+	while (type && type->type =3D=3D SYM_ARRAY) {
+		if (is_type && !type->array_size)
+			return true;
+		type =3D type->ctype.base_type;
+		while (type && type->type =3D=3D SYM_NODE)
+			type =3D type->ctype.base_type;
+	}
+	return !type || (type->bit_size < 0 && type->type !=3D SYM_FN);
+}
+
 static struct symbol *evaluate_alignof(struct expression *expr)
 {
 	struct symbol *type;
+	bool is_type =3D expr->cast_type !=3D NULL;
=20
 	type =3D evaluate_type_information(expr);
 	if (!type)
 		return NULL;
=20
+	if (is_incomplete_alignof_type(type, is_type))
+		expression_error(expr, "cannot size alignment of incomplete type");
+
 	expr->type =3D EXPR_VALUE;
 	expr->value =3D type->ctype.alignment;
 	expr->taint =3D 0;
@@ -3268,7 +3309,11 @@ static struct symbol *evaluate_offsetof(struct exp=
ression *expr)
 			struct expression *idx =3D expr->index, *m;
 			struct symbol *i_type =3D evaluate_expression(idx);
 			unsigned old_idx_flags;
-			int i_class =3D classify_type(i_type, &i_type);
+			int i_class;
+
+			if (!i_type)
+				return NULL;
+			i_class =3D classify_type(i_type, &i_type);
=20
 			if (!is_int(i_class)) {
 				expression_error(expr, "non-integer index");
@@ -3316,7 +3361,8 @@ static void check_label_declaration(struct position=
 pos, struct symbol *label)
 		sparse_error(pos, "label '%s' was not declared", show_ident(label->ide=
nt));
 		/* fallthrough */
 	case NS_NONE:
-		current_fn->bogus_linear =3D 1;
+		if (current_fn)
+			current_fn->bogus_linear =3D 1;
 	default:
 		break;
 	}
@@ -3337,10 +3383,14 @@ static struct symbol *evaluate_generic_selection(=
struct expression *expr)
 	struct symbol source;
 	struct symbol *ctrl;
=20
-	if (!evaluate_expression(expr->control))
+	if (!evaluate_expression(expr->control)) {
+		expr->ctype =3D &bad_ctype;
 		return NULL;
-	if (!(ctrl =3D degenerate(expr->control)))
+	}
+	if (!(ctrl =3D degenerate(expr->control))) {
+		expr->ctype =3D &bad_ctype;
 		return NULL;
+	}
=20
 	source =3D *ctrl;
 	source.ctype.modifiers &=3D ~(MOD_QUALIFIER|MOD_ATOMIC);
@@ -3352,18 +3402,31 @@ static struct symbol *evaluate_generic_selection(=
struct expression *expr)
 			continue;
=20
 		base =3D stype->ctype.base_type;
-		if (base->type =3D=3D SYM_ARRAY && base->array_size) {
-			get_expression_value_silent(base->array_size);
-			if (base->array_size->type =3D=3D EXPR_VALUE)
+		if (base && base->type =3D=3D SYM_ARRAY) {
+			bool is_vla =3D false;
+			struct symbol *arr =3D base;
+			while (arr && arr->type =3D=3D SYM_ARRAY) {
+				if (arr->array_size) {
+					get_expression_value_silent(arr->array_size);
+					if (arr->array_size->type !=3D EXPR_VALUE) {
+						is_vla =3D true;
+						break;
+					}
+				}
+				arr =3D arr->ctype.base_type;
+				while (arr && arr->type =3D=3D SYM_NODE)
+					arr =3D arr->ctype.base_type;
+			}
+			if (is_vla) {
+				sparse_error(stype->pos, "variable length array type in generic sele=
ction");
 				continue;
-			sparse_error(stype->pos, "variable length array type in generic selec=
tion");
-			continue;
+			}
 		}
 		if (is_func_type(stype)) {
 			sparse_error(stype->pos, "function type in generic selection");
 			continue;
 		}
-		if (stype->bit_size <=3D 0 || is_void_type(stype)) {
+		if (stype->bit_size < 0 || is_void_type(stype)) {
 			sparse_error(stype->pos, "incomplete type in generic selection");
 			continue;
 		}
@@ -3376,6 +3439,7 @@ static struct symbol *evaluate_generic_selection(st=
ruct expression *expr)
 	res =3D expr->def;
 	if (!res) {
 		sparse_error(expr->pos, "no generic selection for '%s'", show_typename=
(ctrl));
+		expr->ctype =3D &bad_ctype;
 		return NULL;
 	}
=20
@@ -3682,7 +3746,11 @@ static void parse_asm_constraint(struct asm_operan=
d *op)
 			break;
 		case '[':
 			// FIXME: symbolic matching constraint
-			return;
+			while (*str && *str !=3D ']')
+				str++;
+			if (*str =3D=3D ']')
+				str++;
+			break;
=20
 		default:
 			if (arch_target->asm_constraint)
diff --git a/parse.c b/parse.c
index ea90d088a244..2675a3976099 100644
--- a/parse.c
+++ b/parse.c
@@ -791,6 +791,8 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
=20
 	token =3D parse(token->next, sym);
 	token =3D expect(token, '}', "at end of specifier");
+	sym->defined =3D 1;
+	sym->examined =3D 0;
 	attr.ctype.base_type =3D sym;
 	token =3D handle_attributes(token, &attr);
 	apply_ctype(token->pos, &sym->ctype, &attr.ctype);
diff --git a/symbol.c b/symbol.c
index abf3a198acc8..06cd8ca2ede7 100644
--- a/symbol.c
+++ b/symbol.c
@@ -215,6 +215,11 @@ static struct symbol * examine_struct_union_type(str=
uct symbol *sym, int advance
 	void (*fn)(struct symbol *, struct struct_union_info *);
 	struct symbol *member;
=20
+	if (!sym->defined) {
+		sym->bit_size =3D -1;
+		return sym;
+	}
+
 	fn =3D advance ? lay_out_struct : lay_out_union;
 	FOR_EACH_PTR(sym->symbol_list, member) {
 		if (member->ctype.base_type =3D=3D &autotype_ctype) {
@@ -298,9 +303,10 @@ static struct symbol * examine_array_type(struct sym=
bol *sym)
 	if (!base_type)
 		return sym;
=20
-	if (array_size) {=09
-		bit_size =3D array_element_offset(base_type->bit_size,
-						get_expression_value_silent(array_size));
+	if (array_size) {
+		unsigned long count =3D get_expression_value_silent(array_size);
+		if (base_type->bit_size >=3D 0)
+			bit_size =3D array_element_offset(base_type->bit_size, count);
 		if (array_size->type !=3D EXPR_VALUE) {
 			if (Wvla)
 				warning(array_size->pos, "Variable length array is used.");
diff --git a/symbol.h b/symbol.h
index 9a8e58d5da28..a14686fe863b 100644
--- a/symbol.h
+++ b/symbol.h
@@ -149,7 +149,7 @@ struct symbol_op {
 struct symbol {
 	enum type type:8;
 	enum namespace namespace:9;
-	unsigned char used:1, attr:2, enum_member:1, bound:1;
+	unsigned char used:1, attr:2, enum_member:1, bound:1, defined:1;
 	struct position pos;		/* Where this symbol was declared */
 	struct position endpos;		/* Where this symbol ends*/
 	struct ident *ident;		/* What identifier this symbol is associated with=
 */
diff --git a/validation/eval-type-checks.c b/validation/eval-type-checks.=
c
new file mode 100644
index 000000000000..13b3ff22210d
--- /dev/null
+++ b/validation/eval-type-checks.c
@@ -0,0 +1,89 @@
+#define __noderef __attribute__((noderef))
+#define __nocast __attribute__((nocast))
+
+struct empty {};
+struct inc;
+struct __attribute__((aligned(16))) inc_aligned;
+
+extern struct empty es;
+extern int ext_arr[];
+
+_Static_assert(_Generic(es, struct empty: 1, default: 0) =3D=3D 1, "empt=
y struct generic");
+_Static_assert(_Generic(0, int[4]: 1, default: 2) =3D=3D 2, "fixed array=
 assoc");
+_Static_assert(_Alignof(struct empty) =3D=3D 1, "empty struct alignof");
+
+static unsigned long valid_alignof(int n)
+{
+	return _Alignof(int[n]) + _Alignof(void(void)) + __alignof__(ext_arr);
+}
+
+static void *valid_void_ptr_add(void *p)
+{
+	return p + 1;
+}
+
+static void test_incomplete_errors(struct inc *pi, int (*pa)[], int n)
+{
+	(void)(pi + 1);
+	(void)(pa + 1);
+	(void)_Alignof(void);
+	(void)_Alignof(int[]);
+	(void)_Alignof(struct inc);
+	(void)_Alignof(struct inc_aligned);
+	(void)_Alignof(struct inc[2]);
+	(void)_Generic(0, int[2][n]: 1, default: 0);
+	(void)_Generic(0, struct inc[2]: 1, default: 0);
+}
+
+static long test_qualifiers(int c, void *vp, void __nocast *vp_nc, int *=
p,
+			    int __noderef *p_nd, int __nocast *p_nc)
+{
+	void __nocast *ok_both_nc =3D c ? vp_nc : p_nc;
+	void __nocast *ok_one_nc =3D c ? vp : p_nc;
+	void __noderef *ok_nd =3D c ? vp : p_nd;
+	int *bad_nc =3D c ? vp_nc : p_nc;
+	int *bad_nd =3D c ? vp : p_nd;
+	long r =3D 0;
+
+	(void)ok_both_nc;
+	(void)ok_one_nc;
+	(void)ok_nd;
+	(void)bad_nc;
+	(void)bad_nd;
+
+	r +=3D (p_nd =3D=3D p);
+	r +=3D (p_nd - p);
+	r +=3D (p_nc =3D=3D p);
+	r +=3D (p_nc - p);
+	return r;
+}
+
+/*
+ * check-name: eval-type-checks
+ * check-command: sparse -Wno-vla $file
+ *
+ * check-error-start
+eval-type-checks.c:27:19: error: arithmetics on pointers to incomplete t=
ype
+eval-type-checks.c:28:19: error: arithmetics on pointers to incomplete t=
ype
+eval-type-checks.c:29:15: error: cannot size alignment of incomplete typ=
e
+eval-type-checks.c:30:15: error: cannot size alignment of incomplete typ=
e
+eval-type-checks.c:31:15: error: cannot size alignment of incomplete typ=
e
+eval-type-checks.c:32:15: error: cannot size alignment of incomplete typ=
e
+eval-type-checks.c:33:15: error: cannot size alignment of incomplete typ=
e
+eval-type-checks.c:34:27: error: variable length array type in generic s=
election
+eval-type-checks.c:35:27: error: incomplete type in generic selection
+eval-type-checks.c:42:40: warning: implicit cast to nocast type
+eval-type-checks.c:44:25: warning: implicit cast from nocast type
+eval-type-checks.c:45:25: warning: incorrect type in initializer (differ=
ent modifiers)
+eval-type-checks.c:45:25:    expected int *bad_nd
+eval-type-checks.c:45:25:    got void [noderef] *
+eval-type-checks.c:54:20: error: incompatible types in comparison expres=
sion (different modifiers):
+eval-type-checks.c:54:20:    int [noderef] *
+eval-type-checks.c:54:20:    int *
+eval-type-checks.c:55:20: error: subtraction of different types can't wo=
rk (different modifiers)
+eval-type-checks.c:56:20: error: incompatible types in comparison expres=
sion (different modifiers):
+eval-type-checks.c:56:20:    int [nocast] *
+eval-type-checks.c:56:20:    int *
+eval-type-checks.c:57:20: error: subtraction of different types can't wo=
rk (different modifiers)
+ * check-error-end
+ */
