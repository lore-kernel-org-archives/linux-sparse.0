Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256443;
	b=GYyS9dkVtOWLFUZRKlFs6vj0+0w62q1SZLtPmPQJumspv0+41oLuXL4ACyBJFABzVyzX
	 tJhne6lRGWAIGbesY5+kIc5dCBjFeqqxp2dpZNx5mmvbn9STdN3gr/AWZ2/4AvnKoYmQu
	 dnLam7+Y6KTGMkVh2vy4f6bOeBkjEkiBgY4OpOcq7d7e3KEmNigitGweHlehKpQTlGVCD
	 F7Ax7swHxNnAVngUhdxXtU3503k9p8mVZ6EuYCQhM/J2I+fO5eSbnvVzRkdTgurUiOkVM
	 Y/FFP+jgHQC7eZSf0IIyRTRVylq9i8Oz5K8UEXYgj23YwxoKq/+CEl5CLHtlcnKGgFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2gZ9EaqhF35vGE0ZZEvpLrs3mtmJJgrXPQtnbrCLY+Q=;
	b=z0byBf8DiZzzOiACVxY4tECZfWrIlSYIrFyB4BD3GzSCxE+hpzu+GSxZLfGvLl5fquQo
	 5iYXtUCENKWe7vl0Gxnb4FSJ4ulkVWQrSqFrb3tRM+fNES3nIwilRgGGnN4y1f3ynH7Lj
	 3y18r4inSxWDh7B+BMqa2GYG+aymQ5oaqrDjoZ0xq32KnkDbyVV7SG55ShQ6JYsadt5rA
	 /axIURkNyk6h14oXCKG5NmG7/zl6T+5ZbXG/X6HXcVcNq9IDKgtj9wHNQx9dhQaDk3E/+
	 RfPAWdJg0gmvJHseXE7s/JSzb0m7oJUNeIjgV9XOgsjnPiUG2ot+4qM7egM0TahADGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="oGy1l/35";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CA606A334
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F0CA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=oGy1l/35
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMX0pMlz1XLyhl;
	Mon,  9 Nov 2026 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=2gZ9E
	aqhF35vGE0ZZEvpLrs3mtmJJgrXPQtnbrCLY+Q=; b=oGy1l/35ocwcRfQBq1Ine
	A1wFIvE3CkxO65tZp+CwphLKuSE3jwlzoC0VWde+2oTPWPFLWoMbLXpgxRrUiJJz
	qiU9VwdoGEGyigYFy6CgDrjnZr1+PKJ5lAkHjRCBuKy5Qd2BVi6biHtbnGW1dwBj
	SvKcA0TDKeqH4MFJOm7I1fUHL6Svi21MPaMhqBqI6NTqGErzwcIwb8bvYiWwlhtQ
	NS/VyoNvxj1jIElzYKmshp3sOyRra1PsoT11VVr+Sujwf/IbwLkPumT8zQUg8M+w
	sFRqXsieD8D4LC8CtrEahTLeQSJmFnqmyq+s9J38+4ENXrg0UXGSbnh5OtD/NkSM
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id P9d6op0974Z5; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM566wWz1XLyhw;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 61/73] c23: Add support for _BitInt(N)
Date: Mon,  9 Nov 2026 12:32:47 -0800
Message-ID: <20261109203259.362845-62-bvanassche@acm.org>
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

Implement ISO C23 bit-precise integer types _BitInt(N) and unsigned
_BitInt(N) up to __BITINT_MAXWIDTH__ (128):
- Parse _BitInt(N) specifiers, validate signed (N >=3D 2) and unsigned
  (N >=3D 1) width bounds, and parse case-matching wb/WB and uwb/UWB
  integer constant suffixes while rejecting mixed-case wB/Wb.
- Keep _BitInt(N) unpromoted during integer promotions per C23
  6.3.1.1p2 and implement C23 6.3.1.8 usual arithmetic conversions
  between _BitInt(N) and standard integer types.
- Mask and sign-extend constant expressions to effective_int_width()
  and store the upper 64 bits in struct expression (value_hi) so
  65..128-bit constants parse, fold, and compare with full precision.
- Enforce _BitInt bit-field width/sign rules, reject string-literal
  array initialization of _BitInt(8)[], and check pointer width/rank
  compatibility.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                       | 105 ++++++++-
 expand.c                         | 366 +++++++++++++++++++++++++++----
 expression.c                     | 103 ++++++++-
 expression.h                     |   2 +
 ident-list.h                     |   1 +
 linearize.c                      |  23 +-
 parse.c                          |  89 +++++++-
 predefine.c                      |   1 +
 show-parse.c                     |   9 +
 sparse-llvm.c                    |   8 +
 symbol.c                         |  54 ++++-
 symbol.h                         |  61 +++++-
 validation/c23-bitint-error.c    |  61 ++++++
 validation/c23-bitint-pedantic.c |  13 ++
 validation/c23-bitint.c          | 214 ++++++++++++++++++
 validation/expand-bitint.c       |  49 +++++
 16 files changed, 1086 insertions(+), 73 deletions(-)
 create mode 100644 validation/c23-bitint-error.c
 create mode 100644 validation/c23-bitint-pedantic.c
 create mode 100644 validation/c23-bitint.c
 create mode 100644 validation/expand-bitint.c

diff --git a/evaluate.c b/evaluate.c
index 32621d04a17e..1c169ad60382 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -187,6 +187,8 @@ static inline struct symbol *integer_promotion(struct=
 symbol *type)
 		type =3D type->ctype.base_type;
 	}
 	mod =3D type->ctype.modifiers;
+	if (is_bitint_type(type))
+		return type;
 	if (width < bits_in_int)
 		return &int_ctype;
=20
@@ -229,6 +231,43 @@ static struct symbol *bigger_int_type(struct symbol =
*left, struct symbol *right)
 	if (left =3D=3D right)
 		return left;
=20
+	if (is_bitint_type(left) || is_bitint_type(right)) {
+		int lwidth =3D effective_int_width(left);
+		int rwidth =3D effective_int_width(right);
+		int lunsigned =3D (left->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+		int runsigned =3D (right->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+		int uwidth, swidth;
+
+		if (lunsigned =3D=3D runsigned) {
+			if (lwidth > rwidth)
+				return left;
+			if (rwidth > lwidth)
+				return right;
+			return is_bitint_type(left) ? right : left;
+		}
+
+		if (lunsigned) {
+			utype =3D left;
+			stype =3D right;
+			uwidth =3D lwidth;
+			swidth =3D rwidth;
+		} else {
+			utype =3D right;
+			stype =3D left;
+			uwidth =3D rwidth;
+			swidth =3D lwidth;
+		}
+
+		if (uwidth > swidth)
+			return utype;
+		if (uwidth =3D=3D swidth) {
+			if (!is_bitint_type(utype) || is_bitint_type(stype))
+				return utype;
+			return unsigned_types[stype->rank];
+		}
+		return stype;
+	}
+
 	lmod =3D left->ctype.modifiers;
 	rmod =3D right->ctype.modifiers;
 	if (((lmod ^ rmod) & MOD_UNSIGNED) =3D=3D 0)
@@ -879,8 +918,15 @@ const char *type_difference(struct ctype *c1, struct=
 ctype *c2,
 				return "different base types";
 			if (!base1 && t1->bit_size !=3D t2->bit_size)
 				return "different base types";
-			if (t1->rank !=3D t2->rank)
-				return "different type sizes";
+			if (is_bitint_type(t1) || is_bitint_type(t2)) {
+				if (!is_bitint_type(t1) || !is_bitint_type(t2))
+					return "different base types";
+				if (t1->bitint_width !=3D t2->bitint_width)
+					return "different bit widths";
+			} else {
+				if (t1->rank !=3D t2->rank)
+					return "different type sizes";
+			}
 			diff =3D (mod1 ^ mod2) & ~MOD_IGNORE;
 			if (!diff)
 				return NULL;
@@ -1601,6 +1647,13 @@ static int whitelist_pointers(struct symbol *t1, s=
truct symbol *t2)
 		return 0;
 	if (t1 =3D=3D t2)
 		return 1;
+	if (is_bitint_type(t1) || is_bitint_type(t2)) {
+		if (!is_bitint_type(t1) || !is_bitint_type(t2))
+			return 0;
+		if (t1->bitint_width !=3D t2->bitint_width)
+			return 0;
+		return !Wtypesign;
+	}
 	if (t1->rank =3D=3D -2 && t2->rank =3D=3D -2)
 		return !Wtypesign && !Wpedantic && standard < STANDARD_C23;
 	if (t1->rank !=3D t2->rank)
@@ -3101,19 +3154,49 @@ static void check_constexpr_scalar_init(struct ex=
pression *orig,
 				     "non-constant initializer for constexpr object");
 			return;
 		}
-		sw =3D stype->bit_size;
+		sw =3D effective_int_width(stype);
 		s_unsigned =3D (stype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
-		s_neg =3D !s_unsigned && sw > 0 && sw <=3D 64 &&
-			(tmp.value & sign_bit(sw)) !=3D 0;
+		s_neg =3D !s_unsigned &&
+			(sw > 64 ? tmp.value_neg :
+				   (sw > 0 && (tmp.value & sign_bit(sw)) !=3D 0));
 		if (is_bool_type(ttype)) {
-			if (s_neg || (tmp.value !=3D 0 && tmp.value !=3D 1))
+			if (s_neg || tmp.value_hi !=3D 0 ||
+			    (tmp.value !=3D 0 && tmp.value !=3D 1))
 				sparse_error(
 					orig->pos,
 					"constexpr initializer not representable in target type");
 			return;
 		}
-		tw =3D ttype->bit_size;
+		tw =3D effective_int_width(ttype);
 		t_unsigned =3D (ttype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
+#ifdef __SIZEOF_INT128__
+		if (s_neg) {
+			__int128 sval =3D
+				sw > 64 ?
+					(__int128)(((unsigned __int128)tmp.value_hi << 64) |
+						   tmp.value) :
+					(__int128)bits_extend(tmp.value, sw, 1);
+			if (t_unsigned ||
+			    (tw < 128 && sval < -((__int128)1 << (tw - 1))))
+				sparse_error(
+					orig->pos,
+					"constexpr initializer not representable in target type");
+		} else {
+			unsigned __int128 uval =3D
+				sw > 64 ?
+					(((unsigned __int128)tmp.value_hi << 64) |
+					 tmp.value) :
+					(unsigned __int128)(unsigned long long)zero_extend(
+						tmp.value, sw);
+			int max_bits =3D t_unsigned ? tw : (tw - 1);
+			if ((max_bits <=3D 0 && uval !=3D 0) ||
+			    (max_bits > 0 && max_bits < 128 &&
+			     (uval >> max_bits) !=3D 0))
+				sparse_error(
+					orig->pos,
+					"constexpr initializer not representable in target type");
+		}
+#else
 		if (s_neg) {
 			long long sval =3D sw > 64 ? (long long)tmp.value :
 						   bits_extend(tmp.value, sw, 1);
@@ -3134,6 +3217,7 @@ static void check_constexpr_scalar_init(struct expr=
ession *orig,
 					orig->pos,
 					"constexpr initializer not representable in target type");
 		}
+#endif
 		return;
 	}
=20
@@ -3166,10 +3250,11 @@ static void check_constexpr_scalar_init(struct ex=
pression *orig,
 						"constexpr initializer not representable in target type");
 			}
 		} else if (is_int(sclass)) {
-			int sw =3D stype->bit_size;
+			int sw =3D effective_int_width(stype);
 			bool s_unsigned =3D (stype->ctype.modifiers & MOD_UNSIGNED) !=3D 0;
-			bool s_neg =3D !s_unsigned && sw > 0 && sw <=3D 64 &&
-				     (tmp.value & sign_bit(sw)) !=3D 0;
+			bool s_neg =3D !s_unsigned &&
+				     (sw > 64 ? tmp.value_neg :
+						(sw > 0 && (tmp.value & sign_bit(sw)) !=3D 0));
 			if (tmp.type !=3D EXPR_VALUE) {
 				sparse_error(
 					orig->pos,
diff --git a/expand.c b/expand.c
index 7c85b66ab02f..815ff24ac487 100644
--- a/expand.c
+++ b/expand.c
@@ -80,17 +80,85 @@ static int expand_symbol_expression(struct expression=
 *expr)
 	return (sym->ctype.modifiers & (MOD_STATIC | MOD_EXTERN)) ? 2 : 1;
 }
=20
+static inline int clamp_mask_bits(int bits)
+{
+	if (bits <=3D 0)
+		return 0;
+	if (bits > 64)
+		return 64;
+	return bits;
+}
+
+static bool expr_is_neg_int(const struct expression *e)
+{
+	int w =3D effective_int_width(e->ctype);
+
+	if (e->ctype->ctype.modifiers & MOD_UNSIGNED)
+		return false;
+	if (w > 64)
+		return e->value_neg;
+	return w > 0 && (e->value & sign_bit(w)) !=3D 0;
+}
+
+#ifdef __SIZEOF_INT128__
+static unsigned __int128 get_uint128(const struct expression *e)
+{
+	int w =3D effective_int_width(e->ctype);
+
+	if (w > 64) {
+		if (e->value_neg && !e->value_hi)
+			return (unsigned __int128)(__int128)(long long)e->value;
+		return ((unsigned __int128)e->value_hi << 64) | e->value;
+	}
+	if (e->ctype->ctype.modifiers & MOD_UNSIGNED)
+		return (unsigned __int128)(unsigned long long)zero_extend(e->value, w)=
;
+	return (unsigned __int128)(__int128)bits_extend(e->value, w, 1);
+}
+
+static bool store_int128(struct expression *expr, struct symbol *ctype,
+			 unsigned __int128 uval)
+{
+	int w =3D effective_int_width(ctype);
+	int is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
+	unsigned __int128 mask =3D w >=3D 128 ? ~(unsigned __int128)0 :
+					    (((unsigned __int128)1 << w) - 1);
+	unsigned long long lo, hi;
+	int neg;
+
+	uval &=3D mask;
+	if (is_signed && (uval & ((unsigned __int128)1 << (w - 1)))) {
+		uval |=3D ~mask;
+		neg =3D 1;
+	} else {
+		neg =3D 0;
+	}
+	lo =3D (unsigned long long)uval;
+	hi =3D (unsigned long long)(uval >> 64);
+	if (!is_bitint_type(ctype) &&
+	    (hi !=3D (neg ? ~0ULL : 0ULL) || (neg && !(lo & (1ULL << 63)))))
+		return false;
+	expr->value =3D lo;
+	expr->value_hi =3D hi;
+	expr->value_neg =3D neg;
+	return true;
+}
+#endif
+
 static long long get_longlong(struct expression *expr)
 {
+	int w =3D effective_int_width(expr->ctype);
 	int is_signed =3D !(expr->ctype->ctype.modifiers & MOD_UNSIGNED);
-	return bits_extend(expr->value, expr->ctype->bit_size, is_signed);
+
+	if (w > 64)
+		return (long long)expr->value;
+	return bits_extend(expr->value, w, is_signed);
 }
=20
 void cast_value(struct expression *expr, struct symbol *newtype, struct =
expression *old)
 {
 	struct symbol *oldtype =3D old->ctype;
-	int old_size =3D oldtype->bit_size;
-	int new_size =3D newtype->bit_size;
+	int old_size =3D effective_int_width(oldtype);
+	int new_size =3D effective_int_width(newtype);
 	long long value;
 	unsigned long long mask, signmask;
 	unsigned long long oldmask, oldsignmask, dropped;
@@ -98,28 +166,44 @@ void cast_value(struct expression *expr, struct symb=
ol *newtype, struct expressi
 	if (is_float_type(newtype) || is_float_type(oldtype))
 		goto Float;
=20
-	if (!is_bool_type(newtype) && new_size > 64 && old_size >=3D 64 &&
-	    new_size > old_size && (oldtype->ctype.modifiers & MOD_UNSIGNED) &&
-	    (old->value & (1ULL << 63)))
+	if (!is_bool_type(newtype) && new_size > 64) {
+#ifdef __SIZEOF_INT128__
+		struct expression tmp =3D *expr;
+		if (!store_int128(&tmp, newtype, get_uint128(old)))
+			return;
+		expr->type =3D EXPR_VALUE;
+		expr->taint =3D old->taint;
+		expr->ctype =3D newtype;
+		expr->value =3D tmp.value;
+		expr->value_hi =3D tmp.value_hi;
+		expr->value_neg =3D tmp.value_neg;
+#endif
 		return;
+	}
=20
 	// For pointers and integers, we can just move the value around
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D old->taint;
-	if (old_size =3D=3D new_size && !is_bool_type(newtype)) {
-		expr->value =3D old->value;
+	if (old_size =3D=3D new_size && old_size <=3D 64 && !is_bool_type(newty=
pe)) {
+		expr->value =3D old->value & bits_mask(new_size);
+		expr->value_hi =3D 0;
+		expr->value_neg =3D 0;
 		expr->ctype =3D newtype;
 		return;
 	}
=20
 	if (is_bool_type(newtype)) {
-		bool non_zero =3D old->value !=3D 0;
-		bool is_one =3D old->value =3D=3D 1;
+		bool non_zero =3D old->value !=3D 0 || old->value_hi !=3D 0;
+		bool is_one =3D old->value =3D=3D 1 && old->value_hi =3D=3D 0 &&
+			      !expr_is_neg_int(old);
+		unsigned long long oval =3D old->value;
 		expr->ctype =3D newtype;
 		expr->value =3D non_zero;
+		expr->value_hi =3D 0;
+		expr->value_neg =3D 0;
 		if (!conservative && non_zero && !is_one)
 			warning(old->pos, "odd constant _Bool cast (%llx becomes 1)",
-				old->value);
+				oval);
 		return;
 	}
=20
@@ -128,6 +212,8 @@ void cast_value(struct expression *expr, struct symbo=
l *newtype, struct expressi
 	expr->ctype =3D newtype;
=20
 Int:
+	expr->value_hi =3D 0;
+	expr->value_neg =3D 0;
 	// _Bool requires a zero test rather than truncation.
 	if (is_bool_type(newtype)) {
 		expr->value =3D !!value;
@@ -136,13 +222,28 @@ Int:
 		return;
 	}
=20
+	if (new_size <=3D 0) {
+		expr->value =3D 0;
+		return;
+	}
+
+	if (new_size > 64) {
+		expr->value =3D value;
+		expr->value_neg =3D !(newtype->ctype.modifiers & MOD_UNSIGNED) &&
+				  value < 0;
+		expr->value_hi =3D expr->value_neg ? ~0ULL : 0ULL;
+		return;
+	}
+
 	// Truncate it to the new size
 	signmask =3D sign_bit(new_size);
 	mask =3D bits_mask(new_size);
 	expr->value =3D value & mask;
=20
 	// Stop here unless checking for truncation
-	if (!Wcast_truncate || conservative)
+	if (!Wcast_truncate || conservative || old_size <=3D 0)
+		return;
+	if (old_size > 64 && !old->value_neg && !old->value_hi && new_size =3D=3D=
 64)
 		return;
 =09
 	// Check if we dropped any bits..
@@ -168,6 +269,8 @@ Float:
 			expr->taint =3D 0;
 			expr->ctype =3D newtype;
 			expr->value =3D (fval !=3D 0);
+			expr->value_hi =3D 0;
+			expr->value_neg =3D 0;
 			return;
 		}
 		if (new_size <=3D 0 || new_size > 64 || !__builtin_isfinite(fval))
@@ -207,10 +310,19 @@ Float:
 	}
=20
 	if (!is_float_type(oldtype)) {
-		if ((oldtype->ctype.modifiers & MOD_UNSIGNED) &&
-		    old_size > 64 && (old->value & (1ULL << 63)))
-			return;
-		if (oldtype->ctype.modifiers & MOD_UNSIGNED)
+		if (old_size > 64) {
+#ifdef __SIZEOF_INT128__
+			if (old->value_neg)
+				expr->fvalue =3D (long double)(__int128)get_uint128(old);
+			else
+				expr->fvalue =3D (long double)get_uint128(old);
+#else
+			if (old->value_neg)
+				expr->fvalue =3D (long double)(long long)old->value;
+			else
+				expr->fvalue =3D (long double)(unsigned long long)old->value;
+#endif
+		} else if (oldtype->ctype.modifiers & MOD_UNSIGNED)
 			expr->fvalue =3D (long double)(unsigned long long)get_longlong(old);
 		else
 			expr->fvalue =3D (long double)get_longlong(old);
@@ -231,10 +343,12 @@ Float:
 static bool check_shift_count(struct expression *expr, struct expression=
 *right)
 {
 	struct symbol *ctype =3D expr->ctype;
-	long long count =3D get_longlong(right);
+	int width =3D effective_int_width(ctype);
=20
-	if (count >=3D 0 && count < ctype->bit_size)
-		return true;
+	if (expr_is_neg_int(right) || right->value_hi !=3D 0)
+		return false;
+	if (right->value < (unsigned long long)width && right->value < 128)
+		return width > 64 || right->value < 64;
 	return false;
 }
=20
@@ -250,7 +364,7 @@ static int simplify_int_binop(struct expression *expr=
, struct symbol *ctype)
 	struct expression *left =3D expr->left, *right =3D expr->right;
 	unsigned long long v, l, r, mask;
 	signed long long sl, sr;
-	int is_signed;
+	int is_signed, bits, raw_bits;
=20
 	if (right->type !=3D EXPR_VALUE)
 		return 0;
@@ -261,11 +375,92 @@ static int simplify_int_binop(struct expression *ex=
pr, struct symbol *ctype)
 	}
 	if (left->type !=3D EXPR_VALUE)
 		return 0;
-	if (!ctype || ctype->bit_size <=3D 0 || ctype->bit_size > 64)
+	raw_bits =3D effective_int_width(ctype);
+	if (raw_bits <=3D 0)
 		return 0;
-	l =3D left->value; r =3D right->value;
 	is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
-	mask =3D sign_bit(ctype->bit_size);
+	if (raw_bits > 64) {
+#ifdef __SIZEOF_INT128__
+		unsigned __int128 ul =3D get_uint128(left);
+		unsigned __int128 ur =3D get_uint128(right);
+		__int128 sl128 =3D (__int128)ul, sr128 =3D (__int128)ur;
+		unsigned __int128 sbit128 =3D (unsigned __int128)1 << (raw_bits - 1);
+		unsigned __int128 ures;
+
+		switch (CONVERT(expr->op, is_signed)) {
+		case SIGNED('+'):
+		case UNSIGNED('+'):
+			ures =3D ul + ur;
+			break;
+		case SIGNED('-'):
+		case UNSIGNED('-'):
+			ures =3D ul - ur;
+			break;
+		case SIGNED('&'):
+		case UNSIGNED('&'):
+			ures =3D ul & ur;
+			break;
+		case SIGNED('|'):
+		case UNSIGNED('|'):
+			ures =3D ul | ur;
+			break;
+		case SIGNED('^'):
+		case UNSIGNED('^'):
+			ures =3D ul ^ ur;
+			break;
+		case SIGNED('*'):
+		case UNSIGNED('*'):
+			ures =3D ul * ur;
+			break;
+		case SIGNED('/'):
+			if (!ur)
+				goto Div;
+			if ((ul & ((sbit128 << 1) - 1)) =3D=3D sbit128 && sr128 =3D=3D -1)
+				goto Overflow;
+			ures =3D (unsigned __int128)(sl128 / sr128);
+			break;
+		case UNSIGNED('/'):
+			if (!ur)
+				goto Div;
+			ures =3D ul / ur;
+			break;
+		case SIGNED('%'):
+			if (!ur)
+				goto Div;
+			if ((ul & ((sbit128 << 1) - 1)) =3D=3D sbit128 && sr128 =3D=3D -1)
+				goto Overflow;
+			ures =3D (unsigned __int128)(sl128 % sr128);
+			break;
+		case UNSIGNED('%'):
+			if (!ur)
+				goto Div;
+			ures =3D ul % ur;
+			break;
+		case SIGNED(SPECIAL_LEFTSHIFT):
+		case UNSIGNED(SPECIAL_LEFTSHIFT):
+			ures =3D r < 128 ? (ul << r) : 0;
+			break;
+		case SIGNED(SPECIAL_RIGHTSHIFT):
+			ures =3D (unsigned __int128)(sl128 >> (r < 127 ? r : 127));
+			break;
+		case UNSIGNED(SPECIAL_RIGHTSHIFT):
+			ures =3D r < 128 ? (ul >> r) : 0;
+			break;
+		default:
+			return 0;
+		}
+		if (!store_int128(expr, ctype, ures))
+			return 0;
+		expr->type =3D EXPR_VALUE;
+		expr->taint =3D left->taint | right->taint;
+		return 1;
+#else
+		return 0;
+#endif
+	}
+	bits =3D clamp_mask_bits(raw_bits);
+	l =3D left->value; r =3D right->value;
+	mask =3D sign_bit(bits);
 	sl =3D l; sr =3D r;
 	if (is_signed && (sl & mask))
 		sl |=3D ~(mask-1);
@@ -345,8 +540,10 @@ static int simplify_int_binop(struct expression *exp=
r, struct symbol *ctype)
 	default:
 		return 0;
 	}
-	mask =3D bits_mask(ctype->bit_size);
+	mask =3D bits_mask(bits);
 	expr->value =3D v & mask;
+	expr->value_hi =3D 0;
+	expr->value_neg =3D 0;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D left->taint | right->taint;
 	return 1;
@@ -365,13 +562,43 @@ static int simplify_cmp_binop(struct expression *ex=
pr, struct symbol *ctype)
 	struct expression *left =3D expr->left, *right =3D expr->right;
 	unsigned long long l, r, mask;
 	signed long long sl, sr;
+	int bits, raw_bits;
=20
 	if (left->type !=3D EXPR_VALUE || right->type !=3D EXPR_VALUE)
 		return 0;
-	if (!ctype || ctype->bit_size <=3D 0 || ctype->bit_size > 64)
+	raw_bits =3D effective_int_width(ctype);
+	if (raw_bits <=3D 0)
 		return 0;
+	if (raw_bits > 64) {
+#ifdef __SIZEOF_INT128__
+		unsigned __int128 ul =3D get_uint128(left);
+		unsigned __int128 ur =3D get_uint128(right);
+		__int128 sl128 =3D (__int128)ul, sr128 =3D (__int128)ur;
+
+		switch (expr->op) {
+		case '<':		expr->value =3D sl128 < sr128; break;
+		case '>':		expr->value =3D sl128 > sr128; break;
+		case SPECIAL_LTE:	expr->value =3D sl128 <=3D sr128; break;
+		case SPECIAL_GTE:	expr->value =3D sl128 >=3D sr128; break;
+		case SPECIAL_EQUAL:	expr->value =3D ul =3D=3D ur; break;
+		case SPECIAL_NOTEQUAL:	expr->value =3D ul !=3D ur; break;
+		case SPECIAL_UNSIGNED_LT:expr->value =3D ul < ur; break;
+		case SPECIAL_UNSIGNED_GT:expr->value =3D ul > ur; break;
+		case SPECIAL_UNSIGNED_LTE:expr->value =3D ul <=3D ur; break;
+		case SPECIAL_UNSIGNED_GTE:expr->value =3D ul >=3D ur; break;
+		}
+		expr->value_hi =3D 0;
+		expr->value_neg =3D 0;
+		expr->type =3D EXPR_VALUE;
+		expr->taint =3D left->taint | right->taint;
+		return 1;
+#else
+		return 0;
+#endif
+	}
+	bits =3D clamp_mask_bits(raw_bits);
 	l =3D left->value; r =3D right->value;
-	mask =3D sign_bit(ctype->bit_size);
+	mask =3D sign_bit(bits);
 	sl =3D l; sr =3D r;
 	if (sl & mask)
 		sl |=3D ~(mask-1);
@@ -389,6 +616,8 @@ static int simplify_cmp_binop(struct expression *expr=
, struct symbol *ctype)
 	case SPECIAL_UNSIGNED_LTE:expr->value =3D l <=3D r; break;
 	case SPECIAL_UNSIGNED_GTE:expr->value =3D l >=3D r; break;
 	}
+	expr->value_hi =3D 0;
+	expr->value_neg =3D 0;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D left->taint | right->taint;
 	return 1;
@@ -461,6 +690,8 @@ static int simplify_float_cmp(struct expression *expr=
, struct symbol *ctype)
 	case SPECIAL_EQUAL:	expr->value =3D l =3D=3D r; break;
 	case SPECIAL_NOTEQUAL:	expr->value =3D l !=3D r; break;
 	}
+	expr->value_hi =3D 0;
+	expr->value_neg =3D 0;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D 0;
 	return 1;
@@ -489,16 +720,20 @@ static int expand_logical(struct expression *expr)
 	cost =3D expand_expression(left);
 	if (left->type =3D=3D EXPR_VALUE) {
 		if (expr->op =3D=3D SPECIAL_LOGICAL_AND) {
-			if (!left->value) {
+			if (!left->value && !left->value_hi) {
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D 0;
+				expr->value_hi =3D 0;
+				expr->value_neg =3D 0;
 				expr->taint =3D left->taint;
 				return 0;
 			}
 		} else {
-			if (left->value) {
+			if (left->value || left->value_hi) {
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D 1;
+				expr->value_hi =3D 0;
+				expr->value_neg =3D 0;
 				expr->taint =3D left->taint;
 				return 0;
 			}
@@ -513,7 +748,9 @@ static int expand_logical(struct expression *expr)
 		 * otherwise we would have short-circuited it..
 		 */
 		expr->type =3D EXPR_VALUE;
-		expr->value =3D right->value !=3D 0;
+		expr->value =3D (right->value !=3D 0 || right->value_hi !=3D 0);
+		expr->value_hi =3D 0;
+		expr->value_neg =3D 0;
 		expr->taint =3D left->taint | right->taint;
 		return 0;
 	}
@@ -586,6 +823,8 @@ static int expand_compare(struct expression *expr)
 			int op =3D expr->op;
 			expr->type =3D EXPR_VALUE;
 			expr->value =3D compare_types(op, left->symbol, right->symbol);
+			expr->value_hi =3D 0;
+			expr->value_neg =3D 0;
 			expr->taint =3D 0;
 			return 0;
 		}
@@ -607,7 +846,7 @@ static int expand_conditional(struct expression *expr=
)
 	cond_cost =3D expand_expression(cond);
 	if (cond->type =3D=3D EXPR_VALUE) {
 		unsigned flags =3D expr->flags;
-		if (!cond->value)
+		if (!cond->value && !cond->value_hi)
 			valt =3D valf;
 		if (!valt)
 			valt =3D cond;
@@ -838,7 +1077,8 @@ static int expand_dereference(struct expression *exp=
r)
=20
 		/* Const symbol with a constant initializer? */
 		if (value && value->ctype) {
-			if (ctype->bit_size !=3D value->ctype->bit_size)
+			if (ctype->bit_size !=3D value->ctype->bit_size ||
+			    effective_int_width(ctype) !=3D effective_int_width(value->ctype)=
)
 				return UNSAFE;
 			if (value->type =3D=3D EXPR_VALUE) {
 				if (!is_integral_type(ctype))
@@ -847,6 +1087,8 @@ static int expand_dereference(struct expression *exp=
r)
 					return UNSAFE;
 				expr->type =3D EXPR_VALUE;
 				expr->value =3D value->value;
+				expr->value_hi =3D value->value_hi;
+				expr->value_neg =3D value->value_neg;
 				expr->taint =3D 0;
 				if (sym->ctype.modifiers & MOD_CONSTEXPR)
 					expr->flags =3D is_int_type(ctype) ? CEF_SET_ICE : CEF_ADDR;
@@ -882,13 +1124,48 @@ int early_simplify_preop(struct expression *expr)
 {
 	struct expression *op =3D expr->unop;
 	unsigned long long v, mask;
+	int bits, raw_bits;
=20
 	if (op->type !=3D EXPR_VALUE)
 		return 0;
-	if (!expr->ctype || expr->ctype->bit_size <=3D 0 || expr->ctype->bit_si=
ze > 64)
+
+	raw_bits =3D effective_int_width(expr->ctype);
+	if (raw_bits <=3D 0)
 		return 0;
+	if (raw_bits > 64) {
+#ifdef __SIZEOF_INT128__
+		unsigned __int128 u =3D get_uint128(op);
=20
-	mask =3D sign_bit(expr->ctype->bit_size);
+		switch (expr->op) {
+		case '+':
+			break;
+		case '!':
+			expr->value =3D (u =3D=3D 0);
+			expr->value_hi =3D 0;
+			expr->value_neg =3D 0;
+			expr->type =3D EXPR_VALUE;
+			expr->taint =3D op->taint;
+			return 1;
+		case '-':
+			u =3D -u;
+			break;
+		case '~':
+			u =3D ~u;
+			break;
+		default:
+			return 0;
+		}
+		if (!store_int128(expr, expr->ctype, u))
+			return 0;
+		expr->type =3D EXPR_VALUE;
+		expr->taint =3D op->taint;
+		return 1;
+#else
+		return 0;
+#endif
+	}
+	bits =3D clamp_mask_bits(raw_bits);
+	mask =3D sign_bit(bits);
 	v =3D op->value;
 	switch (expr->op) {
 	case '+': break;
@@ -901,8 +1178,10 @@ int early_simplify_preop(struct expression *expr)
 	case '~': v =3D ~v; break;
 	default: return 0;
 	}
-	mask =3D bits_mask(expr->ctype->bit_size);
+	mask =3D bits_mask(bits);
 	expr->value =3D v & mask;
+	expr->value_hi =3D 0;
+	expr->value_neg =3D 0;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D op->taint;
 	return 1;
@@ -998,6 +1277,11 @@ static int expand_cast(struct expression *expr)
=20
 	/* Simplify normal integer casts.. */
 	if (target->type =3D=3D EXPR_VALUE || target->type =3D=3D EXPR_FVALUE) =
{
+		if (target->type =3D=3D EXPR_VALUE &&
+		    effective_int_width(expr->ctype) > 64 &&
+		    (expr->ctype->ctype.modifiers & MOD_UNSIGNED) &&
+		    expr_is_neg_int(target))
+			return cost + 1;
 		cast_value(expr, expr->ctype, target);
 		if (expr->type =3D=3D EXPR_VALUE || expr->type =3D=3D EXPR_FVALUE)
 			return 0;
@@ -1508,6 +1792,7 @@ static long long __get_expression_value(struct expr=
ession *expr, int strict)
 	long long value;
 	unsigned long long mask;
 	struct symbol *ctype;
+	int bits;
=20
 	if (!expr)
 		return 0;
@@ -1528,13 +1813,18 @@ static long long __get_expression_value(struct ex=
pression *expr, int strict)
 	}
=20
 	value =3D expr->value;
-	mask =3D sign_bit(ctype->bit_size);
+	if (effective_int_width(ctype) > 64)
+		return value;
+	bits =3D clamp_mask_bits(effective_int_width(ctype));
+	if (!bits)
+		return value;
+	mask =3D sign_bit(bits);
=20
 	if (value & mask) {
 		while (ctype->type !=3D SYM_BASETYPE)
 			ctype =3D ctype->ctype.base_type;
 		if (!(ctype->ctype.modifiers & MOD_UNSIGNED))
-			value =3D value | mask | ~(mask-1);
+			value =3D value | mask | ~(mask - 1);
 	}
 	return value;
 }
@@ -1577,7 +1867,7 @@ redo:
 		expr =3D expr->right;
 		goto redo;
 	case EXPR_VALUE:
-		return expr->value !=3D 0;
+		return expr->value !=3D 0 || expr->value_hi !=3D 0;
 	case EXPR_FVALUE:
 		return expr->fvalue !=3D 0;
 	default:
@@ -1591,7 +1881,7 @@ int is_zero_constant(struct expression *expr)
 	conservative =3D 1;
 	expand_expression(expr);
 	conservative =3D saved;
-	return expr->type =3D=3D EXPR_VALUE && !expr->value;
+	return expr->type =3D=3D EXPR_VALUE && !expr->value && !expr->value_hi;
 }
=20
 void expand_constexpr_initializer(struct expression *expr)
diff --git a/expression.c b/expression.c
index 65efff3b61fe..15b9eca351cb 100644
--- a/expression.c
+++ b/expression.c
@@ -260,6 +260,49 @@ static unsigned long long parse_num(const char *nptr=
, char **end)
 	return strtoull(nptr, end, 0);
 }
=20
+#ifdef __SIZEOF_INT128__
+static bool parse_num128(const char *nptr, unsigned long long *lo,
+			 unsigned long long *hi)
+{
+	unsigned __int128 val =3D 0;
+	int base =3D 10;
+	const char *p =3D nptr;
+
+	if (p[0] =3D=3D '0') {
+		if (tolower((unsigned char)p[1]) =3D=3D 'x') {
+			base =3D 16;
+			p +=3D 2;
+		} else if (tolower((unsigned char)p[1]) =3D=3D 'b') {
+			base =3D 2;
+			p +=3D 2;
+		} else {
+			base =3D 8;
+		}
+	}
+	for (; *p; p++) {
+		unsigned int d;
+		unsigned char c =3D *p;
+
+		if (c >=3D '0' && c <=3D '9')
+			d =3D c - '0';
+		else if (c >=3D 'a' && c <=3D 'f')
+			d =3D c - 'a' + 10;
+		else if (c >=3D 'A' && c <=3D 'F')
+			d =3D c - 'A' + 10;
+		else
+			break;
+		if (d >=3D (unsigned int)base)
+			break;
+		if (val > (~(unsigned __int128)0 - d) / base)
+			return false;
+		val =3D val * base + d;
+	}
+	*lo =3D (unsigned long long)val;
+	*hi =3D (unsigned long long)(val >> 64);
+	return true;
+}
+#endif
+
 static int is_digit_for_base(int c, int base)
 {
 	if (base =3D=3D 2)
@@ -417,6 +460,7 @@ static void get_number_value(struct expression *expr,=
 struct token *token)
 	unsigned long long value;
 	char *end;
 	int size =3D 0, want_unsigned =3D 0;
+	int is_bitint =3D 0;
 	int overflow =3D 0, do_warn =3D 0;
 	int try_unsigned =3D 1;
 	int bits;
@@ -444,12 +488,19 @@ static void get_number_value(struct expression *exp=
r, struct token *token)
 		char c =3D *end++;
 		if (!c) {
 			break;
+		} else if (c =3D=3D 'w' || c =3D=3D 'W') {
+			if (is_bitint || size)
+				goto Enoint;
+			if (*end !=3D (c =3D=3D 'w' ? 'b' : 'B'))
+				goto Enoint;
+			end++;
+			is_bitint =3D 1;
 		} else if (c =3D=3D 'u' || c =3D=3D 'U') {
 			if (want_unsigned)
 				goto Enoint;
 			want_unsigned =3D 1;
 		} else if (c =3D=3D 'l' || c =3D=3D 'L') {
-			if (size)
+			if (size || is_bitint)
 				goto Enoint;
 			size =3D 1;
 			if (*end =3D=3D c) {
@@ -463,6 +514,56 @@ static void get_number_value(struct expression *expr=
, struct token *token)
 			goto Enoint;
 		}
 	}
+	if (is_bitint) {
+		unsigned long long value_hi =3D 0;
+		int width;
+
+		if (overflow) {
+#ifdef __SIZEOF_INT128__
+			if (!parse_num128(str, &value, &value_hi))
+				goto Ebitint_overflow;
+#else
+			goto Ebitint_overflow;
+#endif
+		}
+		if (standard < STANDARD_C23 && Wpedantic)
+			warning(expr->pos,
+				"bit-precise integer suffix is a C23 feature");
+		if (value_hi !=3D 0) {
+			int mag_bits =3D 128 - __builtin_clzll(value_hi);
+
+			width =3D want_unsigned ? mag_bits : (mag_bits + 1);
+			if (width > bits_in_longlonglong)
+				goto Ebitint_overflow;
+		} else if (want_unsigned) {
+			if (value =3D=3D 0)
+				width =3D 1;
+			else
+				width =3D 64 - __builtin_clzll(value);
+		} else {
+			if (value =3D=3D 0)
+				width =3D 2;
+			else
+				width =3D 64 - __builtin_clzll(value) + 1;
+		}
+		expr->type =3D EXPR_VALUE;
+		expr->flags =3D CEF_SET_INT;
+		expr->ctype =3D get_bitint_type(width, !want_unsigned);
+		expr->value =3D value;
+		expr->value_hi =3D value_hi;
+		return;
+Ebitint_overflow:
+		sparse_error(expr->pos,
+			     "constant %s is too big for %s_BitInt(%d)",
+			     show_token(token),
+			     want_unsigned ? "unsigned " : "",
+			     bits_in_longlonglong);
+		expr->type =3D EXPR_VALUE;
+		expr->flags =3D CEF_SET_ICE;
+		expr->ctype =3D get_bitint_type(bits_in_longlonglong,
+					      !want_unsigned);
+		return;
+	}
 	if (overflow)
 		goto Eoverflow;
 	/* OK, it's a valid integer */
diff --git a/expression.h b/expression.h
index 213c31d246aa..83857cffc7dc 100644
--- a/expression.h
+++ b/expression.h
@@ -160,6 +160,7 @@ struct expression {
 	enum expression_type type:8;
 	unsigned flags:8;
 	unsigned zero_init:1;
+	unsigned value_neg:1;
 	int op;
 	struct position pos;
 	struct symbol *ctype;
@@ -167,6 +168,7 @@ struct expression {
 		// EXPR_VALUE
 		struct {
 			unsigned long long value;
+			unsigned long long value_hi;
 			unsigned taint;
 		};
=20
diff --git a/ident-list.h b/ident-list.h
index b4e01e0a423c..4427527580ee 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -44,6 +44,7 @@ IDENT_RESERVED(_Static_assert);
 IDENT(_Thread_local);
=20
 /* C23 keywords */
+IDENT(_BitInt);
 IDENT(alignas);
 IDENT(alignof);
 IDENT(bool);
diff --git a/linearize.c b/linearize.c
index 268466f07886..f43502577649 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1824,7 +1824,7 @@ static pseudo_t linearize_cond_branch(struct entryp=
oint *ep, struct expression *
=20
 	case EXPR_STRING:
 	case EXPR_VALUE:
-		add_goto(ep, expr->value ? bb_true : bb_false);
+		add_goto(ep, (expr->value || expr->value_hi) ? bb_true : bb_false);
 		break;
 	case EXPR_FVALUE:
 		add_goto(ep, expr->fvalue ? bb_true : bb_false);
@@ -1920,6 +1920,27 @@ static pseudo_t linearize_expression(struct entryp=
oint *ep, struct expression *e
 		return add_symbol_address(ep, expr);
=20
 	case EXPR_VALUE:
+		if (effective_int_width(expr->ctype) > 64) {
+			if (expr->value_hi !=3D (expr->value_neg ? ~0ULL : 0ULL) ||
+			    (expr->value_neg && !(expr->value & (1ULL << 63)))) {
+				pseudo_t hi =3D cast_pseudo(
+					ep, value_pseudo(expr->value_hi),
+					&ullong_ctype, expr->ctype);
+				hi =3D add_binary_op(ep, expr->ctype, OP_SHL, hi,
+						   value_pseudo(64));
+				if (expr->value) {
+					pseudo_t lo =3D cast_pseudo(
+						ep, value_pseudo(expr->value),
+						&ullong_ctype, expr->ctype);
+					hi =3D add_binary_op(ep, expr->ctype,
+							   OP_OR, hi, lo);
+				}
+				return hi;
+			}
+			if (!expr->value_neg && (expr->value & (1ULL << 63)))
+				return cast_pseudo(ep, value_pseudo(expr->value),
+						   &ullong_ctype, expr->ctype);
+		}
 		return value_pseudo(expr->value);
=20
 	case EXPR_STRING:
diff --git a/parse.c b/parse.c
index 0787ad2af576..d89f60113152 100644
--- a/parse.c
+++ b/parse.c
@@ -66,6 +66,7 @@ static declarator_t
 	storage_specifier, thread_specifier;
 static declarator_t generic_qualifier;
 static declarator_t autotype_specifier, auto_specifier, constexpr_specif=
ier;
+static declarator_t bitint_specifier;
=20
 static struct token *parse_if_statement(struct token *token, struct stat=
ement *stmt);
 static struct token *parse_return_statement(struct token *token, struct =
statement *stmt);
@@ -113,7 +114,9 @@ enum {
 	Set_Long =3D 512,
 	Set_Vlong =3D 1024,
 	Set_Int128 =3D 2048,
-	Set_Any =3D Set_T | Set_Short | Set_Long | Set_Signed | Set_Unsigned
+	Set_BitInt =3D 4096,
+	Set_Any =3D Set_T | Set_Short | Set_Long | Set_Signed | Set_Unsigned |
+		Set_BitInt
 };
=20
 enum {
@@ -282,7 +285,8 @@ static struct symbol_op float_op =3D {
=20
 static struct symbol_op short_op =3D {
 	.type =3D KW_SPECIFIER,
-	.test =3D Set_S|Set_Char|Set_Float|Set_Double|Set_Long|Set_Short,
+	.test =3D Set_S | Set_Char | Set_Float | Set_Double | Set_Long |
+		Set_Short | Set_BitInt,
 	.set =3D Set_Short,
 };
=20
@@ -302,17 +306,27 @@ static struct symbol_op unsigned_op =3D {
=20
 static struct symbol_op long_op =3D {
 	.type =3D KW_SPECIFIER,
-	.test =3D Set_S|Set_Char|Set_Float|Set_Short|Set_Vlong,
+	.test =3D Set_S | Set_Char | Set_Float | Set_Short | Set_Vlong |
+		Set_BitInt,
 	.set =3D Set_Long,
 };
=20
 static struct symbol_op int128_op =3D {
 	.type =3D KW_SPECIFIER,
-	.test =3D Set_S|Set_T|Set_Char|Set_Short|Set_Int|Set_Float|Set_Double|S=
et_Long|Set_Vlong|Set_Int128,
-	.set =3D  Set_T|Set_Int128|Set_Vlong,
+	.test =3D Set_S | Set_T | Set_Char | Set_Short | Set_Int | Set_Float |
+		Set_Double | Set_Long | Set_Vlong | Set_Int128 | Set_BitInt,
+	.set =3D Set_T | Set_Int128 | Set_Vlong,
 	.class =3D CInt,
 };
=20
+static struct symbol_op bitint_op =3D {
+	.type =3D KW_SPECIFIER,
+	.test =3D Set_S | Set_T | Set_Char | Set_Short | Set_Int | Set_Float |
+		Set_Double | Set_Long | Set_Vlong | Set_Int128 | Set_BitInt,
+	.set =3D Set_T | Set_BitInt,
+	.declarator =3D bitint_specifier,
+};
+
 static struct symbol_op if_op =3D {
 	.statement =3D parse_if_statement,
 };
@@ -531,6 +545,7 @@ static struct init_keyword {
 	N("__int128",		&int128_op),
 	N("_Bool",		&spec_op,	.type =3D &bool_ctype),
 	N("bool",		&spec_op,	.type =3D &bool_ctype, .std =3D STANDARD_C23),
+	N("_BitInt",		&bitint_op),
=20
 	/* Predeclared types */
 	N("__builtin_va_list",	&spec_op,	.type =3D &ptr_ctype),
@@ -843,7 +858,7 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 			check_typename_storage(underlying);
 			underlying =3D examine_symbol_type(underlying);
 			if (!underlying || !is_int_type(underlying) ||
-			    is_enum_type(underlying)) {
+			    is_enum_type(underlying) || is_bitint_type(underlying)) {
 				sparse_error(token->pos,
 					     "invalid 'enum' underlying type");
 				underlying =3D &int_ctype;
@@ -927,7 +942,7 @@ static struct token *struct_union_enum_specifier(enum=
 type type,
 			check_typename_storage(underlying);
 			underlying =3D examine_symbol_type(underlying);
 			if (!underlying || !is_int_type(underlying) ||
-			    is_enum_type(underlying)) {
+			    is_enum_type(underlying) || is_bitint_type(underlying)) {
 				sparse_error(token->pos,
 					     "invalid 'enum' underlying type");
 				underlying =3D &int_ctype;
@@ -1421,6 +1436,32 @@ static void apply_constexpr_const(struct symbol *s=
ym)
 	}
 }
=20
+static struct token *bitint_specifier(struct token *token, struct symbol=
 *sym,
+				      struct decl_state *ctx)
+{
+	struct expression *expr =3D NULL;
+
+	if (standard < STANDARD_C23 && Wpedantic)
+		warning(token->pos, "'_BitInt' is a C23 feature");
+
+	ctx->bitint_pos =3D token->pos;
+	if (!match_op(token, '(')) {
+		sparse_error(token->pos, "expected '(' after '_BitInt'");
+		ctx->bitint_width =3D -1;
+		return token;
+	}
+	token =3D conditional_expression(token->next, &expr);
+	if (!expr) {
+		sparse_error(token->pos,
+			     "expected expression for _BitInt width");
+		ctx->bitint_width =3D -1;
+	} else {
+		ctx->bitint_width =3D const_expression_value(expr);
+	}
+	token =3D expect(token, ')', "after _BitInt width");
+	return token;
+}
+
 static struct token *ignore_attribute(struct token *token, struct symbol=
 *attr, struct decl_state *ctx)
 {
 	struct expression *expr =3D NULL;
@@ -1837,7 +1878,7 @@ static void apply_ctype(struct position pos, struct=
 ctype *dst, struct ctype *sr
 static void specifier_conflict(struct position pos, int what, struct ide=
nt *new)
 {
 	const char *old;
-	if (what & (Set_S | Set_T))
+	if (what & (Set_S | Set_T | Set_BitInt))
 		goto Catch_all;
 	if (what & Set_Char)
 		old =3D "char";
@@ -1984,6 +2025,37 @@ static struct token *declaration_specifiers(struct=
 token *token, struct decl_sta
 		}
 	}
=20
+	if (seen & Set_BitInt) {
+		int is_signed =3D !(seen & Set_Unsigned);
+		long long width =3D ctx->bitint_width;
+		struct position pos =3D ctx->bitint_pos;
+
+		if (width <=3D 0) {
+			sparse_error(pos, "invalid bit width %lld for _BitInt",
+				     width);
+			ctx->ctype.base_type =3D &bad_ctype;
+		} else if (is_signed && width < 2) {
+			sparse_error(pos,
+				     "signed _BitInt width must be at least 2");
+			ctx->ctype.base_type =3D &bad_ctype;
+		} else if (!is_signed && width < 1) {
+			sparse_error(
+				pos,
+				"unsigned _BitInt width must be at least 1");
+			ctx->ctype.base_type =3D &bad_ctype;
+		} else if (width > bits_in_longlonglong) {
+			sparse_error(
+				pos,
+				"_BitInt width %lld exceeds __BITINT_MAXWIDTH__ (%d)",
+				width, bits_in_longlonglong);
+			ctx->ctype.base_type =3D &bad_ctype;
+		} else {
+			ctx->ctype.base_type =3D
+				get_bitint_type(width, is_signed);
+		}
+		seen |=3D Set_S;
+	}
+
 	if (!(seen & Set_S)) {	/* not set explicitly? */
 		struct symbol *base =3D &incomplete_ctype;
 		if (seen & Set_Any)
@@ -2425,6 +2497,7 @@ static struct token *handle_bitfield(struct token *=
token, struct decl_state *ctx
 		}
 		if (Wdefault_bitfield_sign &&
 		    bitfield_type->type !=3D SYM_ENUM &&
+		    !is_bitint_type(bitfield_type) &&
 		    !(bitfield_type->ctype.modifiers & MOD_EXPLICITLY_SIGNED) &&
 		    is_signed) {
 			// The sign of bitfields is unspecified by default.
diff --git a/predefine.c b/predefine.c
index 5639fc6862e3..3ead07003637 100644
--- a/predefine.c
+++ b/predefine.c
@@ -128,6 +128,7 @@ void predefined_macros(void)
 	predefine("__STDC_EMBED_EMPTY__", 1, "2");
=20
 	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
+	predefine("__BITINT_MAXWIDTH__", 1, "%d", bits_in_longlonglong);
 	if (funsigned_char)
 		predefine("__CHAR_UNSIGNED__", 1, "1");
=20
diff --git a/show-parse.c b/show-parse.c
index 0a277ef67aac..9ed95f141cfe 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -350,6 +350,15 @@ deeper:
 	if (!sym)
 		goto out;
=20
+	if (sym->type =3D=3D SYM_BASETYPE && is_bitint_type(sym)) {
+		if (sym->ctype.modifiers & MOD_UNSIGNED)
+			prepend(name, "unsigned _BitInt(%d)",
+				sym->bitint_width);
+		else
+			prepend(name, "_BitInt(%d)", sym->bitint_width);
+		goto out;
+	}
+
 	if ((typename =3D builtin_typename(sym))) {
 		if (name->start !=3D name->end)
 			prepend(name, " ");
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 7d15d7a70e54..b6a0b6ce9134 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1270,6 +1270,14 @@ static LLVMValueRef expr_to_const_val(LLVMModuleRe=
f module, struct symbol *sym,
=20
 	switch (initializer->type) {
 	case EXPR_VALUE:
+		if (effective_int_width(initializer->ctype) > 64 &&
+		    LLVMGetTypeKind(dtype) =3D=3D LLVMIntegerTypeKind) {
+			uint64_t words[2] =3D {
+				initializer->value,
+				initializer->value_hi,
+			};
+			return LLVMConstIntOfArbitraryPrecision(dtype, 2, words);
+		}
 		return constant_value(initializer->value, dtype);
 	case EXPR_FVALUE:
 		return LLVMConstReal(dtype, initializer->fvalue);
diff --git a/symbol.c b/symbol.c
index 270e91d9c480..721dd1e81ae5 100644
--- a/symbol.c
+++ b/symbol.c
@@ -389,7 +389,7 @@ static struct symbol *examine_bitfield_type(struct sy=
mbol *sym)
=20
 	if (!base_type)
 		return sym;
-	if (sym->bit_size > base_type->bit_size) {
+	if (sym->bit_size > effective_int_width(base_type)) {
 		sparse_error(sym->pos, "bitfield '%s' is wider (%d) than its type (%s)=
",
 			show_ident(sym->ident), sym->bit_size, show_typename(base_type));
 		sym->bit_size =3D -1;
@@ -401,7 +401,8 @@ static struct symbol *examine_bitfield_type(struct sy=
mbol *sym)
 	modifiers =3D base_type->ctype.modifiers;
=20
 	/* use -funsigned-bitfields to determine the sign if not explicit */
-	if (!(modifiers & MOD_EXPLICITLY_SIGNED) && funsigned_bitfields)
+	if (!(modifiers & MOD_EXPLICITLY_SIGNED) &&
+	    !is_bitint_type(base_type) && funsigned_bitfields)
 		modifiers =3D (modifiers & ~MOD_SIGNED) | MOD_UNSIGNED;
 	sym->ctype.modifiers |=3D modifiers & MOD_SIGNEDNESS;
 	return sym;
@@ -456,7 +457,7 @@ static int count_array_initializer(struct symbol *t, =
struct expression *expr)
 	 * on T - if it's a character type, we get the length of string literal
 	 * (including NUL), otherwise we have one element here.
 	 */
-	if (t->ctype.base_type =3D=3D &int_type && t->rank =3D=3D -2)
+	if (t->ctype.base_type =3D=3D &int_type && t->rank =3D=3D -2 && !is_bit=
int_type(t))
 		is_char =3D 1;
 	else if (t =3D=3D wchar_ctype && is_wstring_expr(expr))
 		is_char =3D 1;
@@ -581,6 +582,7 @@ static struct symbol * examine_node_type(struct symbo=
l *sym)
 	}
 =09
 	sym->bit_size =3D bit_size;
+	sym->bitint_width =3D base_type->bitint_width;
 	sym->rank =3D base_type->rank;
 	return sym;
 }
@@ -1135,3 +1137,49 @@ void init_ctype(void)
 	const_wchar_ctype.ctype.alignment =3D wchar_ctype->ctype.alignment;
 	const_wchar_ctype.bit_size =3D wchar_ctype->bit_size;
 }
+
+struct symbol *get_bitint_type(int width, int is_signed)
+{
+	static struct symbol *bitint_types[2][129];
+	struct position pos =3D { .stream =3D 0 };
+	struct symbol *sym;
+	int u =3D !is_signed;
+
+	if (width < 1 || width > 128)
+		return &bad_ctype;
+
+	sym =3D bitint_types[u][width];
+	if (sym)
+		return sym;
+
+	sym =3D alloc_symbol(pos, SYM_BASETYPE);
+	sym->ctype.base_type =3D &int_type;
+	sym->ctype.modifiers =3D (is_signed ? MOD_SIGNED : MOD_UNSIGNED) |
+			       MOD_BITINT;
+	sym->bitint_width =3D width;
+
+	if (width <=3D 8) {
+		sym->bit_size =3D 8;
+		sym->ctype.alignment =3D 1;
+		sym->rank =3D -2;
+	} else if (width <=3D 16) {
+		sym->bit_size =3D 16;
+		sym->ctype.alignment =3D 2;
+		sym->rank =3D -1;
+	} else if (width <=3D 32) {
+		sym->bit_size =3D 32;
+		sym->ctype.alignment =3D 4;
+		sym->rank =3D 0;
+	} else if (width <=3D 64) {
+		sym->bit_size =3D 64;
+		sym->ctype.alignment =3D 8;
+		sym->rank =3D 2;
+	} else {
+		sym->bit_size =3D 128;
+		sym->ctype.alignment =3D 8;
+		sym->rank =3D 3;
+	}
+
+	bitint_types[u][width] =3D sym;
+	return sym;
+}
diff --git a/symbol.h b/symbol.h
index 435fa18a4990..bb063dc622e0 100644
--- a/symbol.h
+++ b/symbol.h
@@ -122,6 +122,8 @@ struct decl_state {
 	unsigned char designated_init;
 	unsigned char transparent_union;
 	unsigned char opaque_fixed_enum;
+	long long bitint_width;
+	struct position bitint_pos;
 	struct position opaque_fixed_enum_pos;
 };
=20
@@ -189,14 +191,25 @@ struct symbol {
 		struct /* NS_SYMBOL */ {
 			unsigned long	offset;
 			int		bit_size;
-			unsigned int bit_offset : 8, bogus_linear : 1,
-				variadic : 1, initialized : 1, examined : 1,
-				expanding : 1, evaluated : 1,
-				has_flex_array : 1, string : 1,
-				designated_init : 1, forced_arg : 1,
-				accessed : 1, builtin : 1, torename : 1,
-				packed : 1, transparent_union : 1,
-				fixed_type : 1, explicit_typedef : 1;
+			int bitint_width;
+			unsigned int bit_offset : 8;
+			unsigned int bogus_linear : 1;
+			unsigned int variadic : 1;
+			unsigned int initialized : 1;
+			unsigned int examined : 1;
+			unsigned int expanding : 1;
+			unsigned int evaluated : 1;
+			unsigned int has_flex_array : 1;
+			unsigned int string : 1;
+			unsigned int designated_init : 1;
+			unsigned int forced_arg : 1;
+			unsigned int accessed : 1;
+			unsigned int builtin : 1;
+			unsigned int torename : 1;
+			unsigned int packed : 1;
+			unsigned int transparent_union : 1;
+			unsigned int fixed_type : 1;
+			unsigned int explicit_typedef : 1;
 			unsigned int has_alignas : 1;
 			unsigned int kr_args : 1;
 			unsigned int underspecified : 1;
@@ -252,7 +265,7 @@ struct symbol {
 #define MOD_GNU_INLINE		0x00010000
 #define MOD_USERTYPE		0x00020000
 #define MOD_CONSTEXPR 0x00040000
-// MOD UNUSED		0x00080000
+#define MOD_BITINT 0x00080000
 // MOD UNUSED		0x00100000
 // MOD UNUSED		0x00200000
=20
@@ -271,7 +284,7 @@ struct symbol {
 #define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN |=
 MOD_INLINE | MOD_TOPLEVEL)
 #define MOD_ESIGNED	(MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNE=
D)
-#define MOD_SPECIFIER	MOD_SIGNEDNESS
+#define MOD_SPECIFIER (MOD_SIGNEDNESS | MOD_BITINT)
 #define MOD_IGNORE	(MOD_STORAGE | MOD_ACCESS | MOD_USERTYPE | MOD_EXPLIC=
ITLY_SIGNED | MOD_EXT_VISIBLE | MOD_UNUSED | MOD_GNU_INLINE | MOD_CONSTEX=
PR)
 #define MOD_QUALIFIER	(MOD_CONST | MOD_VOLATILE | MOD_RESTRICT)
 /* modifiers for function attributes */
@@ -412,6 +425,29 @@ static inline int is_signed_type(struct symbol *sym)
 	return !(sym->ctype.modifiers & MOD_UNSIGNED);
 }
=20
+static inline int is_bitint_type(const struct symbol *sym)
+{
+	while (sym && sym->type =3D=3D SYM_NODE)
+		sym =3D sym->ctype.base_type;
+	return sym && (sym->ctype.modifiers & MOD_BITINT);
+}
+
+static inline int effective_int_width(const struct symbol *type)
+{
+	if (!type)
+		return 0;
+	while (type->type =3D=3D SYM_NODE) {
+		type =3D type->ctype.base_type;
+		if (!type)
+			return 0;
+	}
+	if ((type->ctype.modifiers & MOD_BITINT) && type->bitint_width > 0)
+		return type->bitint_width;
+	return type->bit_size;
+}
+
+extern struct symbol *get_bitint_type(int width, int is_signed);
+
 static inline int is_type_type(struct symbol *type)
 {
 	return type =3D=3D &type_ctype;
@@ -468,7 +504,8 @@ static inline int is_float_type(struct symbol *type)
=20
 static inline int is_byte_type(struct symbol *type)
 {
-	return type->bit_size =3D=3D bits_in_char && type->type !=3D SYM_BITFIE=
LD;
+	return type->bit_size =3D=3D bits_in_char && type->type !=3D SYM_BITFIE=
LD &&
+	       !is_bitint_type(type);
 }
=20
 static inline int is_wchar_type(struct symbol *type)
@@ -575,7 +612,7 @@ static inline int get_sym_type(struct symbol *type)
 static inline long long extend_value(long long val, struct symbol *ctype=
)
 {
 	int is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
-	unsigned size =3D ctype->bit_size;
+	unsigned size =3D effective_int_width(ctype);
=20
 	return bits_extend(val, size, is_signed);
 }
diff --git a/validation/c23-bitint-error.c b/validation/c23-bitint-error.=
c
new file mode 100644
index 000000000000..1172334b3a71
--- /dev/null
+++ b/validation/c23-bitint-error.c
@@ -0,0 +1,61 @@
+static _BitInt(1) a;
+static unsigned _BitInt(0) b;
+static _BitInt(200) c;
+static _BitInt(8) bad_str[] =3D "abc";
+static struct bad_bf {
+	_BitInt(5) x : 7;
+} bf_instance;
+static _BitInt(8) bad_wb1 =3D 1wB;
+static _BitInt(8) bad_wb2 =3D 1Wb;
+enum E_bitint : _BitInt(8) { BI =3D 0 };
+static constexpr _BitInt(4) bad_ce_bi =3D 8;
+
+static void ptr_errors(_BitInt(8) *p8, _BitInt(5) *p5, char *pc,
+		       signed char *psc, _BitInt(7) *p7)
+{
+	p8 =3D pc;
+	p8 =3D psc;
+	p5 =3D p7;
+}
+
+static int _BitInt(5) d;
+static _BitInt(5) short e;
+static _BitInt(128) bad_wb_ovf =3D 0x80000000000000000000000000000000wb;
+static unsigned _BitInt(128) bad_uwb_ovf =3D 0x1000000000000000000000000=
00000000uwb;
+
+/*
+ * check-name: C23 _BitInt errors
+ * check-command: sparse -std=3Dc23 -Wsparse-error $file
+ * check-exit-value: 1
+ *
+ * check-error-start
+c23-bitint-error.c:1:15: error: signed _BitInt width must be at least 2
+c23-bitint-error.c:2:24: error: invalid bit width 0 for _BitInt
+c23-bitint-error.c:3:15: error: _BitInt width 200 exceeds __BITINT_MAXWI=
DTH__ (128)
+c23-bitint-error.c:8:29: error: constant 1wB is not a valid number
+c23-bitint-error.c:9:29: error: constant 1Wb is not a valid number
+c23-bitint-error.c:10:28: error: invalid 'enum' underlying type
+c23-bitint-error.c:21:12: error: two or more data types in declaration s=
pecifiers
+c23-bitint-error.c:21:20: error: Expected ) in function declarator
+c23-bitint-error.c:21:20: error: got 5
+c23-bitint-error.c:21:12: error: Trying to use reserved word '_BitInt' a=
s identifier
+c23-bitint-error.c:22:19: error: two or more data types in declaration s=
pecifiers
+c23-bitint-error.c:22:19: error: Trying to use reserved word 'short' as =
identifier
+c23-bitint-error.c:22:25: error: Expected ; at end of declaration
+c23-bitint-error.c:22:25: error: got e
+c23-bitint-error.c:23:34: error: constant 0x8000000000000000000000000000=
0000wb is too big for _BitInt(128)
+c23-bitint-error.c:24:44: error: constant 0x1000000000000000000000000000=
00000uwb is too big for unsigned _BitInt(128)
+c23-bitint-error.c:4:31: error: invalid initializer
+c23-bitint-error.c:6:22: error: bitfield 'x' is wider (7) than its type =
(_BitInt(5))
+c23-bitint-error.c:11:41: error: constexpr initializer not representable=
 in target type
+c23-bitint-error.c:16:12: error: incorrect type in assignment (different=
 base types)
+c23-bitint-error.c:16:12:    expected _BitInt(8)*p8
+c23-bitint-error.c:16:12:    got char *pc
+c23-bitint-error.c:17:12: error: incorrect type in assignment (different=
 base types)
+c23-bitint-error.c:17:12:    expected _BitInt(8)*p8
+c23-bitint-error.c:17:12:    got signed char *psc
+c23-bitint-error.c:18:12: error: incorrect type in assignment (different=
 bit widths)
+c23-bitint-error.c:18:12:    expected _BitInt(5)*p5
+c23-bitint-error.c:18:12:    got _BitInt(7)*p7
+ * check-error-end
+ */
diff --git a/validation/c23-bitint-pedantic.c b/validation/c23-bitint-ped=
antic.c
new file mode 100644
index 000000000000..d564d3c134b9
--- /dev/null
+++ b/validation/c23-bitint-pedantic.c
@@ -0,0 +1,13 @@
+static _BitInt(10) a;
+static auto b =3D 42wb;
+
+/*
+ * check-name: C23 _BitInt pedantic
+ * check-command: sparse -std=3Dc17 -Wpedantic $file
+ *
+ * check-error-start
+c23-bitint-pedantic.c:1:15: warning: '_BitInt' is a C23 feature
+c23-bitint-pedantic.c:2:13: warning: 'auto' type inference is a C23 feat=
ure
+c23-bitint-pedantic.c:2:17: warning: bit-precise integer suffix is a C23=
 feature
+ * check-error-end
+ */
diff --git a/validation/c23-bitint.c b/validation/c23-bitint.c
new file mode 100644
index 000000000000..dd86d23ac48e
--- /dev/null
+++ b/validation/c23-bitint.c
@@ -0,0 +1,214 @@
+/*
+ * Check C23 bit-precise integer types: _BitInt(N) and unsigned _BitInt(=
N)
+ */
+
+_Static_assert(__BITINT_MAXWIDTH__ >=3D 64, "BITINT_MAXWIDTH");
+
+/* Basic declarations */
+static _BitInt(2) s2;
+static _BitInt(7) s7;
+static _BitInt(8) s8;
+static _BitInt(9) s9;
+static _BitInt(16) s16;
+static _BitInt(24) s24;
+static _BitInt(32) s32;
+static _BitInt(40) s40;
+static _BitInt(64) s64;
+static _BitInt(65) s65;
+static _BitInt(128) s128;
+
+static unsigned _BitInt(1) u1;
+static unsigned _BitInt(7) u7;
+static unsigned _BitInt(8) u8;
+static unsigned _BitInt(9) u9;
+static unsigned _BitInt(16) u16;
+static unsigned _BitInt(24) u24;
+static unsigned _BitInt(32) u32;
+static unsigned _BitInt(40) u40;
+static unsigned _BitInt(64) u64;
+static unsigned _BitInt(65) u65;
+static unsigned _BitInt(128) u128;
+
+/* Sizing */
+_Static_assert(sizeof(s2) =3D=3D 1, "s2 size");
+_Static_assert(sizeof(s7) =3D=3D 1, "s7 size");
+_Static_assert(sizeof(s8) =3D=3D 1, "s8 size");
+_Static_assert(sizeof(s9) =3D=3D 2, "s9 size");
+_Static_assert(sizeof(s16) =3D=3D 2, "s16 size");
+_Static_assert(sizeof(s24) =3D=3D 4, "s24 size");
+_Static_assert(sizeof(s32) =3D=3D 4, "s32 size");
+_Static_assert(sizeof(s40) =3D=3D 8, "s40 size");
+_Static_assert(sizeof(s64) =3D=3D 8, "s64 size");
+_Static_assert(sizeof(s65) =3D=3D 16, "s65 size");
+_Static_assert(sizeof(s128) =3D=3D 16, "s128 size");
+
+_Static_assert(sizeof(u1) =3D=3D 1, "u1 size");
+_Static_assert(sizeof(u7) =3D=3D 1, "u7 size");
+_Static_assert(sizeof(u8) =3D=3D 1, "u8 size");
+_Static_assert(sizeof(u9) =3D=3D 2, "u9 size");
+_Static_assert(sizeof(u16) =3D=3D 2, "u16 size");
+_Static_assert(sizeof(u24) =3D=3D 4, "u24 size");
+_Static_assert(sizeof(u32) =3D=3D 4, "u32 size");
+_Static_assert(sizeof(u40) =3D=3D 8, "u40 size");
+_Static_assert(sizeof(u64) =3D=3D 8, "u64 size");
+_Static_assert(sizeof(u65) =3D=3D 16, "u65 size");
+_Static_assert(sizeof(u128) =3D=3D 16, "u128 size");
+
+/* Alignment */
+_Static_assert(_Alignof(_BitInt(7)) =3D=3D 1, "align 7");
+_Static_assert(_Alignof(_BitInt(12)) =3D=3D 2, "align 12");
+_Static_assert(_Alignof(_BitInt(24)) =3D=3D 4, "align 24");
+_Static_assert(_Alignof(_BitInt(40)) =3D=3D 8, "align 40");
+_Static_assert(_Alignof(_BitInt(65)) =3D=3D 8, "align 65");
+
+/* wb and uwb literal suffixes */
+_Static_assert(_Generic(0wb, _BitInt(2): 1, default: 0) =3D=3D 1, "0wb")=
;
+_Static_assert(_Generic(1wb, _BitInt(2): 1, default: 0) =3D=3D 1, "1wb")=
;
+_Static_assert(_Generic(1WB, _BitInt(2): 1, default: 0) =3D=3D 1, "1WB")=
;
+_Static_assert(_Generic(0uwb, unsigned _BitInt(1): 1, default: 0) =3D=3D=
 1, "0uwb");
+_Static_assert(_Generic(1uwb, unsigned _BitInt(1): 1, default: 0) =3D=3D=
 1, "1uwb");
+_Static_assert(_Generic(1UWB, unsigned _BitInt(1): 1, default: 0) =3D=3D=
 1, "1UWB");
+_Static_assert(_Generic(1wbU, unsigned _BitInt(1): 1, default: 0) =3D=3D=
 1, "1wbU");
+_Static_assert(_Generic(42wb, _BitInt(7): 1, default: 0) =3D=3D 1, "42wb=
");
+_Static_assert(_Generic(42uwb, unsigned _BitInt(6): 1, default: 0) =3D=3D=
 1,
+	       "42uwb");
+
+/* Type compatibility and distinctness */
+_Static_assert(_Generic(s8, _BitInt(8): 1, char: 0, signed char: 0, defa=
ult: 0) =3D=3D 1,
+	       "distinct s8");
+_Static_assert(_Generic(u8, unsigned _BitInt(8): 1, unsigned char: 0, de=
fault: 0) =3D=3D 1,
+	       "distinct u8");
+_Static_assert(_Generic(s24, _BitInt(24): 1, default: 0) =3D=3D 1, "dist=
inct s24");
+_Static_assert(_Generic(s32, _BitInt(32): 1, int: 0, default: 0) =3D=3D =
1,
+	       "distinct s32");
+_Static_assert(_Generic(u32,
+			       unsigned _BitInt(32): 1,
+			       unsigned int: 0,
+			       default: 0) =3D=3D 1,
+	       "distinct u32");
+
+/* Compound types and bit-fields */
+struct S {
+	_BitInt(7) a;
+	unsigned _BitInt(9) b;
+};
+_Static_assert(sizeof(struct S) =3D=3D 4, "struct size");
+
+struct BF {
+	_BitInt(5) sbf : 3;
+	unsigned _BitInt(5) ubf : 3;
+};
+static struct BF bf_val;
+_Static_assert(_Generic(+bf_val.sbf, _BitInt(5): 1, default: 0) =3D=3D 1=
,
+	       "signed _BitInt bitfield");
+_Static_assert(_Generic(+bf_val.ubf, unsigned _BitInt(5): 1, default: 0)=
 =3D=3D 1,
+	       "unsigned _BitInt bitfield");
+
+static _BitInt(10) arr[5];
+_Static_assert(sizeof(arr) =3D=3D 5 * sizeof(_BitInt(10)), "array size")=
;
+
+/* Exact-width masking and >64-bit constant folding */
+_Static_assert((unsigned _BitInt(3))7uwb + 1uwb =3D=3D 0uwb, "u3 wrap");
+_Static_assert(~0uwb =3D=3D 1uwb, "u1 ~0");
+_Static_assert((unsigned _BitInt(5))~0wb =3D=3D 31uwb, "u5 ~0wb");
+_Static_assert((unsigned _BitInt(33))0x1ffffffffULL + 1uwb =3D=3D 0uwb, =
"u33 wrap");
+_Static_assert((_BitInt(4))-8 =3D=3D -8, "s4 min");
+
+_Static_assert(_Generic(0x8000000000000000wb, _BitInt(65): 1, default: 0=
) =3D=3D 1,
+	       "2^63 wb width is 65");
+_Static_assert(0x8000000000000000wb > 0wb, "+2^63 > 0");
+_Static_assert(0x8000000000000000wb > -1wb, "+2^63 > -1");
+_Static_assert((_BitInt(65))0xffffffffffffffffULL > 0wb, "2^64-1 in s65 =
> 0");
+_Static_assert((_BitInt(65))0xffffffffffffffffULL !=3D -1wb, "2^64-1 in =
s65 !=3D -1");
+_Static_assert(-0x8000000000000000wb < 0wb, "-2^63 < 0");
+_Static_assert(0x8000000000000000wb + (-0x8000000000000000wb) =3D=3D 0wb=
,
+	       "+2^63 + -2^63 =3D=3D 0");
+_Static_assert(_Generic(0x1'00000000'00000000uwb,
+			unsigned _BitInt(65): 1, default: 0) =3D=3D 1,
+	       "2^64 uwb width is 65");
+_Static_assert(_Generic(0x1'00000000'00000000wb,
+			_BitInt(66): 1, default: 0) =3D=3D 1,
+	       "2^64 wb width is 66");
+_Static_assert(_Generic(0x7fffffffffffffff'ffffffffffffffffwb,
+			_BitInt(128): 1, default: 0) =3D=3D 1,
+	       "2^127-1 wb width is 128");
+_Static_assert(_Generic(0xffffffffffffffff'ffffffffffffffffuwb,
+			unsigned _BitInt(128): 1, default: 0) =3D=3D 1,
+	       "2^128-1 uwb width is 128");
+_Static_assert(0x1'00000000'00000000uwb > 0xffffffffffffffffuwb, "2^64 >=
 2^64-1");
+_Static_assert((0x1'00000000'00000000uwb >> 64) =3D=3D 1uwb, "2^64 >> 64=
 =3D=3D 1");
+_Static_assert(((unsigned _BitInt(128))1 << 100) >> 100 =3D=3D 1, "1 << =
100 >> 100");
+_Static_assert(~(unsigned _BitInt(100))0 =3D=3D
+	       ((unsigned _BitInt(128))1 << 100) - 1, "~u100");
+
+/* Arithmetic conversions and lack of integer promotion (C23 6.3.1.1, 6.=
3.1.8) */
+static void test_ops(void)
+{
+	_BitInt(40) a =3D 1;
+	_BitInt(50) b =3D 2;
+	_Static_assert(_Generic(a + b, _BitInt(50): 1, default: 0) =3D=3D 1,
+		       "a + b");
+
+	unsigned _BitInt(40) u =3D 1;
+	_Static_assert(_Generic(u + a, unsigned _BitInt(40): 1, default: 0) =3D=
=3D
+			       1,
+		       "u + a");
+	_Static_assert(_Generic(u + b, _BitInt(50): 1, default: 0) =3D=3D 1,
+		       "u + b");
+
+	_BitInt(10) x =3D 1;
+	_BitInt(10) y =3D 2;
+	_Static_assert(_Generic(x + y, _BitInt(10): 1, default: 0) =3D=3D 1,
+		       "narrow _BitInt does not promote to int");
+	_Static_assert(_Generic(+x, _BitInt(10): 1, default: 0) =3D=3D 1,
+		       "unary + does not promote _BitInt");
+
+	_BitInt(32) z =3D 1;
+	_Static_assert(_Generic(z + z, _BitInt(32): 1, default: 0) =3D=3D 1,
+		       "no promotion");
+
+	int si =3D 1;
+	unsigned int ui =3D 1;
+	unsigned _BitInt(32) uz =3D 1;
+	unsigned _BitInt(31) u31 =3D 1;
+	_BitInt(33) s33 =3D 1;
+	unsigned _BitInt(8) ub8 =3D 1;
+	_BitInt(16) sb16 =3D 1;
+	unsigned _BitInt(16) ub16 =3D 1;
+
+	_Static_assert(_Generic(z + si, int: 1, default: 0) =3D=3D 1,
+		       "_BitInt(32) + int -> int");
+	_Static_assert(_Generic(uz + ui, unsigned int: 1, default: 0) =3D=3D 1,
+		       "u_BitInt(32) + uint -> uint");
+	_Static_assert(_Generic(z + ui, unsigned int: 1, default: 0) =3D=3D 1,
+		       "_BitInt(32) + uint -> uint");
+	_Static_assert(_Generic(uz + si, unsigned int: 1, default: 0) =3D=3D 1,
+		       "u_BitInt(32) + int -> uint");
+	_Static_assert(_Generic(u31 + si, int: 1, default: 0) =3D=3D 1,
+		       "u_BitInt(31) + int -> int");
+	_Static_assert(_Generic(s33 + si, _BitInt(33): 1, default: 0) =3D=3D 1,
+		       "_BitInt(33) + int -> _BitInt(33)");
+	_Static_assert(_Generic(ub8 + sb16, _BitInt(16): 1, default: 0) =3D=3D =
1,
+		       "u_BitInt(8) + _BitInt(16) -> _BitInt(16)");
+	_Static_assert(_Generic(ub16 + sb16, unsigned _BitInt(16): 1, default: =
0) =3D=3D 1,
+		       "u_BitInt(16) + _BitInt(16) -> u_BitInt(16)");
+
+	constexpr _BitInt(8) ce_bi8 =3D -128wb;
+	constexpr _BitInt(70) ce_bi70 =3D 0x8000000000000000wb;
+	_Static_assert(ce_bi8 =3D=3D -128, "constexpr _BitInt(8)");
+	_Static_assert(ce_bi70 > 0, "constexpr _BitInt(70) >64-bit positive");
+}
+
+struct bitint128_bf {
+	unsigned _BitInt(128) f : 100;
+};
+
+static unsigned _BitInt(65) get_bitint65(void)
+{
+	return 1uwb;
+}
+
+/*
+ * check-name: C23 _BitInt(N)
+ * check-command: sparse -std=3Dc23 $file
+ */
diff --git a/validation/expand-bitint.c b/validation/expand-bitint.c
new file mode 100644
index 000000000000..99122f0f401f
--- /dev/null
+++ b/validation/expand-bitint.c
@@ -0,0 +1,49 @@
+/*
+ * Expand constant folding tests for C23 _BitInt(N) widths !=3D ABI bit_=
size
+ * and widths > 64 bits.
+ */
+
+_Static_assert((~(unsigned _BitInt(37))0) =3D=3D 0x1fffffffffULL, "~u37"=
);
+_Static_assert(((unsigned _BitInt(37))0x1fffffffffULL +
+		(unsigned _BitInt(37))1) =3D=3D 0, "wrap u37");
+_Static_assert((~(_BitInt(37))0) =3D=3D -1, "~s37");
+_Static_assert(-(_BitInt(128))0x8000000000000000ULL < 0, "-2^63 < 0");
+
+int cmp_u128_max(void)
+{
+	unsigned _BitInt(128) hi =3D (unsigned _BitInt(128))-1;
+	unsigned _BitInt(128) lo =3D (unsigned _BitInt(128))0xffffffffffffffffU=
LL;
+
+	return hi =3D=3D lo;
+}
+
+int neg_s128_bit63(void)
+{
+	_BitInt(128) x =3D (_BitInt(128))0x8000000000000000ULL;
+	_BitInt(128) y =3D -x;
+
+	return y < 0;
+}
+
+_BitInt(128) neg_s128_var(_BitInt(128) x)
+{
+	return -x;
+}
+
+double cast_u128_max_to_double(void)
+{
+	unsigned _BitInt(128) hi =3D (unsigned _BitInt(128))-1;
+
+	return (double)hi;
+}
+
+/*
+ * check-name: expand-bitint
+ * check-command: test-linearize -Wno-decl -std=3Dc23 $file
+ *
+ * check-output-ignore
+ * check-output-contains: seteq\\.
+ * check-output-contains: ret\\.32\\s*\\$1
+ * check-output-contains: neg\\.128
+ * check-output-contains: ucvtf\\.64
+ */
