Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432616;
	b=YVDQYyMeB5wsEimvggmFdoOdCobQ1RIpKb5ibNc6COYaHPb4IqXPxdj7GlXHcPod1XQY
	 62ZA1SrssvO5mdshCD33H+DMVsFI1oDyGlbS5xCq+kW0G3GUuSdQQ2L8gKLC/PIksx79/
	 XQpkIbcGJorOkdIsVboo0vGX8QnEd1vzQs8NASoku0CLuI/5Q1QX4qo1Qyn29tsSpczT5
	 Ye42f2OYAaBp8BwBRU0YiU0uVCPJK4O/XPpR1rryFFCH8YDTDHeS5wq0CkUCPYHVeeVOQ
	 TmjStGf5vudsNO30E+zP0YY+zOUhYuA7p8BJ4RBDu9ZGrYVwrTTN3GVsVuhHAT9IkGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q/rgJeI3DLBIDXo5jLipkkBBXyRi2qBAFJMN9CSZh8s=;
	b=Cpioii9YtBmVl+Y6mCjBJg6dIxNFIAiEWg8e522HI99ehal1M10O4IxOKJzLh/h9uYej
	 HWu/WOhKfeui+31U1yl+m2WtEHc9Z6FKhq30IVfhe2B2cXWLEh5j1PtftOK92hrr70lvn
	 wprRamnCWKcWdh+SuJxvMyNghmr/Z1bD5+oIfDbnvUadeH0jEDCOAjAlEaUH3NnxbIM0b
	 VoiQdor1DNh0uxCXy878vDV/fLT3GE37WPqR0lhN9zTrHa7gfSi9vlo/M7LWxLIgAOns4
	 ABFlCZfxHbDc/gjB0u5sbN5ESfzbTCGs4YzrVQo6u2vWws1TsOJdc/2LYPiixiVaILQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xnvHqeDJ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A3606A322
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 009A3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xnvHqeDJ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsr3738z1XM30h;
	Mon, 19 Oct 2026 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=q/rgJ
	eI3DLBIDXo5jLipkkBBXyRi2qBAFJMN9CSZh8s=; b=xnvHqeDJH7ogN4nV3zOTZ
	lb5rgehDMDNIfdnkWNPFCKP/29Su5/+MqU62kp9x0DZtB7fcQJkevwPEV65Ng/R+
	ovPPtA36C8c1CAcCw+hgKi0RNHGVD+bwt2tmprPEpb7bjPSfUlQpE4UX1rZhQms8
	pCMSJnO4mdyTGNVukFojKuy7J4afqyHDUuP4x/ggV3AFTYZKM1eEQuElM2n/Ink3
	9cFl6llWVgXu6gLea2hunzf3899gSdk5QF1+pFLfulDaibGEoWIQu06dmyxwnApu
	01eNIbGvYkjwZFCFHnwgyQZkXXzoV/h9z3msNfJYuDxa5ewBlMjn+GcScEjhtUDi
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Kgf3ej_GZPyK; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsn02rwz1XM6J6;
	Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 13/20] expand: Avoid undefined shifts and signed overflow in constant folding
Date: Mon, 19 Oct 2026 10:56:26 -0700
Message-ID: <20261019175633.415493-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261019175633.415493-1-bvanassche@acm.org>
References: <20261019175633.415493-1-bvanassche@acm.org>
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

Include "bits.h" in expand.c, rewrite get_longlong() using bits_extend(),
use unsigned long long bitmasks with sign_bit() and bits_mask() across
cast_value(), simplify_int_binop(), simplify_cmp_binop(),
simplify_preop(), and __get_expression_value(), evaluate signed
multiplication in simplify_int_binop() via unsigned arithmetic, and clamp
shift counts in simplify_int_binop() to valid 64-bit host shift ranges.

Eliminate undefined host C behavior from out-of-range shifts (when type
bit_size is 0 or 128 or when folding over-wide constant shift expressions=
)
and from signed 64-bit multiplication overflow when folding constant
integer multiplications.

Fixes: 8d121d51b6f8 ("Split tree evaluation into two phases: the first ph=
ase does type evaluation, the second one does value evaluation and inline=
 expansion.")
Fixes: 1c8c7d7237cf ("simplify_int_binop: split signed and unsigned opera=
tions and handle signed division overflow.")
Fixes: 411aed021d36 ("big-shift: don't take the modulo at expand time")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expand.c | 52 +++++++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/expand.c b/expand.c
index f14e718187bc..bbb30ae605dc 100644
--- a/expand.c
+++ b/expand.c
@@ -36,6 +36,7 @@
=20
 #include "lib.h"
 #include "allocate.h"
+#include "bits.h"
 #include "parse.h"
 #include "token.h"
 #include "symbol.h"
@@ -80,18 +81,8 @@ static int expand_symbol_expression(struct expression =
*expr)
=20
 static long long get_longlong(struct expression *expr)
 {
-	int no_expand =3D expr->ctype->ctype.modifiers & MOD_UNSIGNED;
-	long long mask =3D 1ULL << (expr->ctype->bit_size - 1);
-	long long value =3D expr->value;
-	long long ormask, andmask;
-
-	if (!(value & mask))
-		no_expand =3D 1;
-	andmask =3D mask | (mask-1);
-	ormask =3D ~andmask;
-	if (no_expand)
-		ormask =3D 0;
-	return (value & andmask) | ormask;
+	int is_signed =3D !(expr->ctype->ctype.modifiers & MOD_UNSIGNED);
+	return bits_extend(expr->value, expr->ctype->bit_size, is_signed);
 }
=20
 void cast_value(struct expression *expr, struct symbol *newtype, struct =
expression *old)
@@ -99,8 +90,9 @@ void cast_value(struct expression *expr, struct symbol =
*newtype, struct expressi
 	struct symbol *oldtype =3D old->ctype;
 	int old_size =3D oldtype->bit_size;
 	int new_size =3D newtype->bit_size;
-	long long value, mask, signmask;
-	long long oldmask, oldsignmask, dropped;
+	long long value;
+	unsigned long long mask, signmask;
+	unsigned long long oldmask, oldsignmask, dropped;
=20
 	if (is_float_type(newtype) || is_float_type(oldtype))
 		goto Float;
@@ -128,8 +120,8 @@ Int:
 	}
=20
 	// Truncate it to the new size
-	signmask =3D 1ULL << (new_size-1);
-	mask =3D signmask | (signmask-1);
+	signmask =3D sign_bit(new_size);
+	mask =3D bits_mask(new_size);
 	expr->value =3D value & mask;
=20
 	// Stop here unless checking for truncation
@@ -137,8 +129,8 @@ Int:
 		return;
 =09
 	// Check if we dropped any bits..
-	oldsignmask =3D 1ULL << (old_size-1);
-	oldmask =3D oldsignmask | (oldsignmask-1);
+	oldsignmask =3D sign_bit(old_size);
+	oldmask =3D bits_mask(old_size);
 	dropped =3D oldmask & ~mask;
=20
 	// OK if the bits were (and still are) purely sign bits
@@ -210,7 +202,7 @@ static int simplify_int_binop(struct expression *expr=
, struct symbol *ctype)
 		return 0;
 	l =3D left->value; r =3D right->value;
 	is_signed =3D !(ctype->ctype.modifiers & MOD_UNSIGNED);
-	mask =3D 1ULL << (ctype->bit_size-1);
+	mask =3D sign_bit(ctype->bit_size);
 	sl =3D l; sr =3D r;
 	if (is_signed && (sl & mask))
 		sl |=3D ~(mask-1);
@@ -244,9 +236,6 @@ static int simplify_int_binop(struct expression *expr=
, struct symbol *ctype)
 		break;
=20
 	case SIGNED('*'):
-		v =3D sl * sr;
-		break;
-
 	case UNSIGNED('*'):
 		v =3D l * r;
 		break;
@@ -279,21 +268,21 @@ static int simplify_int_binop(struct expression *ex=
pr, struct symbol *ctype)
=20
 	case SIGNED(SPECIAL_LEFTSHIFT):
 	case UNSIGNED(SPECIAL_LEFTSHIFT):
-		v =3D l << r;
+		v =3D r < 64 ? l << r : 0;
 		break;=20
=20
 	case SIGNED(SPECIAL_RIGHTSHIFT):
-		v =3D sl >> r;
+		v =3D sl >> (r < 63 ? r : 63);
 		break;
=20
 	case UNSIGNED(SPECIAL_RIGHTSHIFT):
-		v =3D l >> r;
+		v =3D r < 64 ? l >> r : 0;
 		break;
=20
 	default:
 		return 0;
 	}
-	mask =3D mask | (mask-1);
+	mask =3D bits_mask(ctype->bit_size);
 	expr->value =3D v & mask;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D left->taint | right->taint;
@@ -317,7 +306,7 @@ static int simplify_cmp_binop(struct expression *expr=
, struct symbol *ctype)
 	if (left->type !=3D EXPR_VALUE || right->type !=3D EXPR_VALUE)
 		return 0;
 	l =3D left->value; r =3D right->value;
-	mask =3D 1ULL << (ctype->bit_size-1);
+	mask =3D sign_bit(ctype->bit_size);
 	sl =3D l; sr =3D r;
 	if (sl & mask)
 		sl |=3D ~(mask-1);
@@ -773,7 +762,7 @@ static int simplify_preop(struct expression *expr)
 	if (op->type !=3D EXPR_VALUE)
 		return 0;
=20
-	mask =3D 1ULL << (expr->ctype->bit_size-1);
+	mask =3D sign_bit(expr->ctype->bit_size);
 	v =3D op->value;
 	switch (expr->op) {
 	case '+': break;
@@ -786,7 +775,7 @@ static int simplify_preop(struct expression *expr)
 	case '~': v =3D ~v; break;
 	default: return 0;
 	}
-	mask =3D mask | (mask-1);
+	mask =3D bits_mask(expr->ctype->bit_size);
 	expr->value =3D v & mask;
 	expr->type =3D EXPR_VALUE;
 	expr->taint =3D op->taint;
@@ -1377,7 +1366,8 @@ static inline int bad_integer_constant_expression(s=
truct expression *expr)
=20
 static long long __get_expression_value(struct expression *expr, int str=
ict)
 {
-	long long value, mask;
+	long long value;
+	unsigned long long mask;
 	struct symbol *ctype;
=20
 	if (!expr)
@@ -1399,7 +1389,7 @@ static long long __get_expression_value(struct expr=
ession *expr, int strict)
 	}
=20
 	value =3D expr->value;
-	mask =3D 1ULL << (ctype->bit_size-1);
+	mask =3D sign_bit(ctype->bit_size);
=20
 	if (value & mask) {
 		while (ctype->type !=3D SYM_BASETYPE)
