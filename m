Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256410;
	b=SFo77hM5f6SGpD8PwwjLWHAon3ekY7DLVVuD2QLpph6Vn1BuOgvmQc8BBWh+RfAnnKeP
	 8e2yoUJgBM1myq4OkpXAN/Z5pz/QVMzR/anGqYb1/t2hFQu+sfd3hZwhnMgV74puJ5oqH
	 0ee9WQ6wp5A9Doct5t/O2habhSzmCUXbheS4zqRDURmCxpCYHqxIvHDVdsm3WmL+RwdMr
	 97W2vF6LOxZvtOPYHJyGkikd/G+fEOGYyYOv9uDMDWBA1GH2IsXVQXgnmaOWYprNnIQVg
	 CE2/D3IBFQJRoFRG8So5oCxbwu0ydK9mu2SX4ePIyR1vY113grwOwL6yj8E+3fCyhLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=klFu+5IPtIBhPKZkAmaDJS4ng0B5It6YGLH5GLGH4TY=;
	b=s4iiH8/8BYPfV52qGnV/Pv7s+RlWRTifQWFcf4RJVQ9r+s+zqe99RU9Jra5hv5f3Oa1B
	 AAG/kzsm9TAayu79iar2Ggt68bIs4MVCHLVu4YEajiasa7uoFZ22mB9vfSyQMONPEOSrU
	 LHTHbSVtihiJpShtBF9a7UdKk+3e0D4A8c3enMzh5bK4zGZYANAVWMGG7Z+zXKkv++zkh
	 vNZGH7ElCtbKgvWcMs3xGFHH0aMg+3cwpwT44xFbY1SwmBemzQ98YScGQPhagemGzvJZH
	 AK+GWcdJ4BVw6vVHjHNkoQjm6OftlnuJk56gYHiYWSDDCuDJ/Q8pXH3LSzh8fQ8VsHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dXqiVTpM;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9A606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6F9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=dXqiVTpM
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLx2wSMz1XMYJL;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256405; x=1796848406; bh=klFu+
	5IPtIBhPKZkAmaDJS4ng0B5It6YGLH5GLGH4TY=; b=dXqiVTpMfm0lEZkNOyNP3
	f9hnCi7cmlhwDeVyaffbD7dMqSkvCbZ2oV0gd7NKaHw0Mw0QqAnqGH3n0gfv42F9
	BnH8aXbIvv0owFk4gcJgZE5K8SwyEKftWaHDA9jXLwWXgl5WShMT9cI2Z4lVNPP1
	g8+UjsXSqlBLH+HbQSRzSDCPs0Sg+BAmh6IEh0ObMRv2HgJdJCFbQormYKDO5t34
	lXeVEbIv/3k5DW9X61XrRiTFfA+OpKV5b6X4ptw2tVotoI1h/TiVID2/j5K2wiF+
	EKpBcU9WiKEaEAsoGlCtmBDHKKJLDEzYZJaqa53/pFhYe9LbiES8lZA7z6kCTrCc
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TaSZFenuM30A; Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLr6njHz1XM6JG;
	Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/73] typeof_unqual: Strip qualifiers and address space from types and arrays
Date: Mon,  9 Nov 2026 12:31:49 -0800
Message-ID: <20261109203259.362845-4-bvanassche@acm.org>
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

Examine the target symbol type and clear MOD_QUALIFIER, non-array
MOD_ATOMIC, and ctype.as in typeof_specifier_helper() and
examine_typeof_helper() when qual is false. Add strip_array_qualifiers()
to recursively clone SYM_ARRAY chains and strip element qualifiers and
address spaces without mutating shared typedef or declaration symbols,
while preserving MOD_ATOMIC on array element types per ISO C23 6.7.2.5p4.

Ensure that typeof_unqual() and __typeof_unqual__() remove qualifiers and
address spaces from type names, expressions, and qualified array types
instead of retaining qualifiers on the resulting type.

Fixes: dc9efe442b89 ("sparse: implement typeof_unqual()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                        |   8 +++
 symbol.c                       |  32 +++++++++-
 symbol.h                       |   1 +
 validation/c23-typeof-unqual.c | 113 +++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 3 deletions(-)
 create mode 100644 validation/c23-typeof-unqual.c

diff --git a/parse.c b/parse.c
index 1a889ccb6a90..f349cc75bff4 100644
--- a/parse.c
+++ b/parse.c
@@ -1070,6 +1070,14 @@ static struct token *typeof_specifier_helper(struc=
t token *token, struct symbol
 	if (lookup_type(token->next)) {
 		struct symbol *sym;
 		token =3D typename(token->next, &sym, NULL);
+		sym =3D examine_symbol_type(sym);
+		if (!qual) {
+			sym->ctype.modifiers &=3D ~MOD_QUALIFIER;
+			if (!sym->ctype.base_type || sym->ctype.base_type->type !=3D SYM_ARRA=
Y)
+				sym->ctype.modifiers &=3D ~MOD_ATOMIC;
+			sym->ctype.as =3D NULL;
+			sym->ctype.base_type =3D strip_array_qualifiers(sym->ctype.base_type)=
;
+		}
 		ctx->ctype.base_type =3D sym->ctype.base_type;
 		apply_ctype(token->pos, &ctx->ctype, &sym->ctype);
 	} else {
diff --git a/symbol.c b/symbol.c
index 7060acb666d9..5470880db271 100644
--- a/symbol.c
+++ b/symbol.c
@@ -541,6 +541,27 @@ static struct symbol *examine_pointer_type(struct sy=
mbol *sym)
 	return sym;
 }
=20
+struct symbol *strip_array_qualifiers(struct symbol *type)
+{
+	struct symbol *elem, *copy;
+	unsigned long strip;
+
+	if (!type)
+		return NULL;
+	if (type->type !=3D SYM_ARRAY && type->type !=3D SYM_NODE)
+		return type;
+	elem =3D strip_array_qualifiers(type->ctype.base_type);
+	strip =3D type->ctype.modifiers & MOD_QUALIFIER;
+	if (elem =3D=3D type->ctype.base_type && !strip && !type->ctype.as)
+		return type;
+	copy =3D alloc_symbol(type->pos, type->type);
+	*copy =3D *type;
+	copy->ctype.base_type =3D elem;
+	copy->ctype.modifiers &=3D ~MOD_QUALIFIER;
+	copy->ctype.as =3D NULL;
+	return copy;
+}
+
 static struct symbol *examine_typeof_helper(struct symbol *sym, bool qua=
l)
 {
 	struct symbol *base =3D evaluate_expression(sym->initializer);
@@ -548,12 +569,17 @@ static struct symbol *examine_typeof_helper(struct =
symbol *sym, bool qual)
=20
 	if (!base)
 		base =3D &bad_ctype;
-	if (base->type =3D=3D SYM_NODE) {
+	while (base->type =3D=3D SYM_NODE) {
 		mod |=3D base->ctype.modifiers & MOD_TYPEOF;
-		if (!qual)
-			mod &=3D ~MOD_QUALIFIER;
 		base =3D base->ctype.base_type;
 	}
+	if (!qual) {
+		mod &=3D ~MOD_QUALIFIER;
+		if (base->type !=3D SYM_ARRAY)
+			mod &=3D ~MOD_ATOMIC;
+		sym->ctype.as =3D NULL;
+		base =3D strip_array_qualifiers(base);
+	}
 	if (base->type =3D=3D SYM_BITFIELD)
 		warning(base->pos, "typeof applied to bitfield type");
 	sym->type =3D SYM_NODE;
diff --git a/symbol.h b/symbol.h
index 3552d4391621..9ff2733021b8 100644
--- a/symbol.h
+++ b/symbol.h
@@ -351,6 +351,7 @@ extern void add_symbol(struct symbol_list **, struct =
symbol *);
 extern void bind_symbol(struct symbol *, struct ident *, enum namespace)=
;
 extern void bind_symbol_with_scope(struct symbol *, struct ident *, enum=
 namespace, struct scope *);
=20
+extern struct symbol *strip_array_qualifiers(struct symbol *);
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern struct symbol *examine_pointer_target(struct symbol *);
 extern const char *show_as(struct ident *as);
diff --git a/validation/c23-typeof-unqual.c b/validation/c23-typeof-unqua=
l.c
new file mode 100644
index 000000000000..5738fafd2fca
--- /dev/null
+++ b/validation/c23-typeof-unqual.c
@@ -0,0 +1,113 @@
+/* Test typeof_unqual on type names */
+typedef const int const_int;
+typedef typeof_unqual(const_int) unqual_int;
+
+typedef volatile int vol_int;
+typedef typeof_unqual(vol_int) nonvol_int;
+
+typedef int * const const_ptr;
+typedef typeof_unqual(const_ptr) mod_ptr;
+
+typedef _Atomic int atomic_int;
+typedef typeof_unqual(atomic_int) nonatomic_int;
+
+typedef const int ca[3];
+typedef typeof_unqual(ca) unqual_ca;
+
+typedef const int cmatrix[2][3];
+typedef typeof_unqual(cmatrix) unqual_matrix;
+
+typedef const _Atomic int const_atomic_arr[2];
+typedef typeof_unqual(const_atomic_arr) unqual_atomic_arr;
+
+typedef const int *cip_arr_t[2];
+typedef int * const cpi_arr_t[2];
+
+#ifdef __CHECKER__
+typedef int __attribute__((address_space(1))) as1_int;
+typedef typeof_unqual(as1_int) as0_int;
+typedef int __attribute__((address_space(1))) as1_arr[2];
+typedef typeof_unqual(as1_arr) as0_arr;
+#endif
+
+_Static_assert(!__builtin_types_compatible_p(ca *, int (*)[3]), "ca stay=
s const");
+_Static_assert(__builtin_types_compatible_p(ca *, const int (*)[3]), "ca=
 is const int[3]");
+_Static_assert(__builtin_types_compatible_p(unqual_ca *, int (*)[3]), "u=
nqual_ca strips const");
+_Static_assert(!__builtin_types_compatible_p(cmatrix *, int (*)[2][3]), =
"cmatrix stays const");
+_Static_assert(__builtin_types_compatible_p(unqual_matrix *, int (*)[2][=
3]), "unqual_matrix strips const");
+_Static_assert(!__builtin_types_compatible_p(const_atomic_arr *, _Atomic=
 int (*)[2]), "const_atomic_arr stays const");
+_Static_assert(__builtin_types_compatible_p(unqual_atomic_arr *, _Atomic=
 int (*)[2]), "unqual_atomic_arr strips const, keeps _Atomic");
+_Static_assert(__builtin_types_compatible_p(typeof_unqual(cip_arr_t) *, =
const int *(*)[2]), "pointee const kept");
+_Static_assert(!__builtin_types_compatible_p(typeof_unqual(cip_arr_t) *,=
 int *(*)[2]), "pointee const not stripped");
+_Static_assert(__builtin_types_compatible_p(typeof_unqual(cpi_arr_t) *, =
int *(*)[2]), "element ptr const stripped");
+
+static void test_types(void)
+{
+	unqual_int a =3D 1;
+	a =3D 2;
+
+	mod_ptr p =3D (void *)0;
+	p =3D (int *)0;
+
+	unqual_ca b;
+	b[0] =3D 1;
+
+	unqual_matrix u;
+	u[0][0] =3D 1;
+
+	unqual_atomic_arr na;
+	na[0] =3D 1;
+
+	typeof_unqual(cpi_arr_t) ucpi;
+	ucpi[0] =3D (int *)0;
+
+#ifdef __CHECKER__
+	as0_int x =3D 0;
+	int *px =3D &x;
+	(void)px;
+
+	as0_arr ax;
+	int *pax =3D ax;
+	(void)pax;
+#endif
+}
+
+/* Test typeof_unqual on expressions */
+static void test_exprs(const int c, _Atomic int a)
+{
+	typeof_unqual(c) uc =3D 10;
+	uc =3D 20;
+
+	typeof_unqual(a) ua =3D 30;
+	ua =3D 40;
+
+	const int arr[3] =3D { 0 };
+	typeof_unqual(arr) uarr;
+	uarr[0] =3D 1;
+	_Static_assert(!__builtin_types_compatible_p(typeof(&arr), int (*)[3]),=
 "arr stays const");
+	_Static_assert(__builtin_types_compatible_p(typeof(&uarr), int (*)[3]),=
 "uarr is int[3]");
+
+	const int m[2][3] =3D { { 0 } };
+	typeof_unqual(m) um;
+	um[0][0] =3D 1;
+	_Static_assert(!__builtin_types_compatible_p(typeof(&m), int (*)[2][3])=
, "m stays const");
+	_Static_assert(__builtin_types_compatible_p(typeof(&um), int (*)[2][3])=
, "um is int[2][3]");
+
+	const _Atomic int aa[2] =3D { 0 };
+	typeof_unqual(aa) uaa;
+	uaa[0] =3D 1;
+	_Static_assert(!__builtin_types_compatible_p(typeof(&aa), _Atomic int (=
*)[2]), "aa stays const");
+	_Static_assert(__builtin_types_compatible_p(typeof(&uaa), _Atomic int (=
*)[2]), "uaa is _Atomic int[2]");
+
+#ifdef __CHECKER__
+	static int __attribute__((address_space(1))) asa[2];
+	typeof_unqual(asa) uasa;
+	int *p =3D uasa;
+	(void)p;
+#endif
+}
+
+/*
+ * check-name: c23-typeof-unqual
+ * check-command: sparse $file
+ */
