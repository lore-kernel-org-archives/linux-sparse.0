Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256424;
	b=BzF2u5oHXRjZupinslTIRxeBCkxFNOB0fftMvFavM0wjrO/pN8Va9RPHf7XNFAH3VAE7
	 XE3GF2pe4foQm025BXvou8JdehrSjsQQ8C2CIghpGDk38NTn+hGx8079cvvX319+wz1kw
	 sOo5tcECJ/n+cQ4GCqp9o6UgEPP5f3CXK+Jwp79YeELgI6E4/gm5FzOfP7zYC/QFhX4DE
	 isTclm0AdWFL5U17USzJ/oCmvtpyUvoEuhh5mvE6X2BFkt5e+/c8oQDyT1tnVrJeHT+49
	 O4BtACCOQbV5nxSr8byJ1/qPJqYpKVJljyB1IbENGgMHwdLU97sMAv/BfHGRdei4XAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=2DoHalgXsGm4MQPgCcz+W7r6EthSg2PHWL6edC7PBbA=;
	b=mi5+QlPPvTrI3zIeYfnhI5+h6tskwRuPx075BPLbKp9rri+XljZO8LRlC7oqrNhXism0
	 DBVOlT/YETgVyjA7xVwZ6nGdeHA9BcJzpcf0jqP+sd5+KpEE+0HQWHiXuPluY1edzfH44
	 qdo8bXlya8WRzslFxI7/WWYs2V97EcLyH1M7VOu34xjocnVyeihfOAh5bCkw1I5jTuOd+
	 AhRyn/BeDptTpXJR8gCuvcI8DRi5W5FTM1bi3vzoA16og2TDDNlosgjDWP/qvfRNTvSKW
	 f3q5lF6seG6oLvLXNoHZVl1j8CiRdJY9ZprJPF8tQRyfo/R2R3YSzxRa9FAcMWnSuPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Du6fxk28;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1710A606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1710A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Du6fxk28
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM70MJ8z1XMfrd;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=2DoHa
	lgXsGm4MQPgCcz+W7r6EthSg2PHWL6edC7PBbA=; b=Du6fxk28MLyvQ5/8Q0SqA
	CxAOh5Usja7HLe+OV+zAmBUDpPtNjeOHZ6JDrsJFy23jinq/vUnd8FeC6nHdwTXC
	jFqFm8oi7wnK/Gn/aTuiJeFANZ6ssu0L7NntZNnrQzIkx0h+E0PMG2aMh4sa+X7G
	mrT5jSbg+w+vZoWqr0xPiIV3kC0vnV3zXOsi3M6D1KNorDpzvr5BVwL+BY7xfsVX
	QYFU0Yc6jV8+zj5ei4PCyTtxAsUBV/wEAky2+ZEl8WaPYTgSJ9yQ7IIY6tXdnAnK
	PQXPASSJhkyk3jKVYwpGrjoswmlthUQmTNqqAvDvgQUgFzvv1tX2PoJj58WCdBrB
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id O0DXxhCGHY7a; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM040Bqz1XM5kt;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 37/73] bitwise: Allow both regular casts and forced casts for restricted values
Date: Mon,  9 Nov 2026 12:32:23 -0800
Message-ID: <20261109203259.362845-38-bvanassche@acm.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Allow EXPR_FORCE_CAST as well as EXPR_CAST in restricted_value() when
checking whether an expression is a cast of 0 or ~0.

Support restricted constants defined with '__force' in kernel headers
(for example, '#define EPOLLIN (__force __poll_t)0x00000001') by
recognizing both forced and unforced casts of 0 and ~0 in
restricted_value().

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, fix typo, unwrap
  EXPR_FORCE_CAST in restricted_value(), and extend
  validation/bitwise-all-bits-and-casts.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                              |  4 +--
 validation/bitwise-all-bits-and-casts.c | 46 +++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b84eedbe4d33..ec02e5bbc4fe 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -443,7 +443,7 @@ static bool is_unsigned_restricted_or_int(struct symb=
ol *sym)
=20
 static int restricted_value(struct expression *v, struct symbol *type)
 {
-	if (v->type =3D=3D EXPR_CAST) {
+	if (v->type =3D=3D EXPR_CAST || v->type =3D=3D EXPR_FORCE_CAST) {
 		struct symbol *ctype;
 		int cclass =3D classify_type(v->ctype, &ctype);
 		struct expression *leaf =3D v->cast_expression;
@@ -452,7 +452,7 @@ static int restricted_value(struct expression *v, str=
uct symbol *type)
 			return 1;
 		if (restricted_value(v->cast_expression, ctype))
 			return 1;
-		while (leaf && leaf->type =3D=3D EXPR_CAST)
+		while (leaf && (leaf->type =3D=3D EXPR_CAST || leaf->type =3D=3D EXPR_=
FORCE_CAST))
 			leaf =3D leaf->cast_expression;
 		if (leaf && leaf->type =3D=3D EXPR_VALUE && leaf->value =3D=3D 0)
 			return 0;
diff --git a/validation/bitwise-all-bits-and-casts.c b/validation/bitwise=
-all-bits-and-casts.c
index 01c8d84fcd67..ae0be1269ec4 100644
--- a/validation/bitwise-all-bits-and-casts.c
+++ b/validation/bitwise-all-bits-and-casts.c
@@ -1,6 +1,9 @@
+#define __force __attribute__((force))
+
 typedef unsigned long long __attribute__((bitwise)) be64;
 typedef unsigned int __attribute__((bitwise)) be32;
 typedef unsigned short __attribute__((bitwise)) be16;
+typedef signed int __attribute__((bitwise)) sbe32;
=20
 static be32 test_all_bits(void)
 {
@@ -11,9 +14,11 @@ static be32 test_all_bits(void)
 	be32 e =3D +0;
 	be32 f =3D -0;
 	be32 g =3D (be32)0;
+	be32 h =3D (__force be32)0;
 	be32 i =3D (be32)~0;
+	be32 j =3D (__force be32)~0;
=20
-	return a | b | c | d | e | f | g | i;
+	return a | b | c | d | e | f | g | h | i | j;
 }
=20
 static be64 test_all_bits_64(void)
@@ -22,18 +27,22 @@ static be64 test_all_bits_64(void)
 	be64 b =3D ~0ULL;
 	be64 c =3D -1;
 	be64 d =3D (be64)0;
+	be64 e =3D (__force be64)0;
 	be64 f =3D (be64)~0;
+	be64 g =3D (__force be64)~0;
=20
-	return a | b | c | d | f;
+	return a | b | c | d | e | f | g;
 }
=20
 static be16 test_cross_cast_zero(void)
 {
 	be16 k =3D (be32)0;
+	be16 l =3D (__force be32)0;
 	be16 m =3D (be32)~0;
+	be16 n =3D (__force be32)~0;
 	be16 o =3D (unsigned short)~0;
=20
-	return k | m | o;
+	return k | l | m | n | o;
 }
=20
 static int test_ordered_compare(be32 x, be16 y)
@@ -54,7 +63,38 @@ static int test_ordered_compare(be32 x, be16 y)
 	return res;
 }
=20
+static void test_bad_narrow_and_signed(sbe32 sx)
+{
+	be64 bad_u32 =3D ~0U;
+	be32 bad_u16 =3D (unsigned short)~0;
+	be32 bad_c16 =3D (be16)~0;
+	be32 bad_f16 =3D (__force be16)~0;
+	int bad_ord =3D (sx > 0);
+
+	(void)bad_u32;
+	(void)bad_u16;
+	(void)bad_c16;
+	(void)bad_f16;
+	(void)bad_ord;
+}
+
 /*
  * check-name: bitwise-all-bits-and-casts
  * check-command: sparse -Wbitwise $file
+ *
+ * check-error-start
+bitwise-all-bits-and-casts.c:68:24: warning: incorrect type in initializ=
er (different base types)
+bitwise-all-bits-and-casts.c:68:24:    expected restricted be64 [usertyp=
e] bad_u32
+bitwise-all-bits-and-casts.c:68:24:    got unsigned int
+bitwise-all-bits-and-casts.c:69:25: warning: incorrect type in initializ=
er (different base types)
+bitwise-all-bits-and-casts.c:69:25:    expected restricted be32 [usertyp=
e] bad_u16
+bitwise-all-bits-and-casts.c:69:25:    got unsigned short
+bitwise-all-bits-and-casts.c:70:25: warning: incorrect type in initializ=
er (different base types)
+bitwise-all-bits-and-casts.c:70:25:    expected restricted be32 [usertyp=
e] bad_c16
+bitwise-all-bits-and-casts.c:70:25:    got restricted be16 [usertype]
+bitwise-all-bits-and-casts.c:71:25: warning: incorrect type in initializ=
er (different base types)
+bitwise-all-bits-and-casts.c:71:25:    expected restricted be32 [usertyp=
e] bad_f16
+bitwise-all-bits-and-casts.c:71:25:    got restricted be16 [usertype]
+bitwise-all-bits-and-casts.c:72:24: warning: restricted sbe32 degrades t=
o integer
+ * check-error-end
  */
