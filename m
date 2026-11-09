Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256430;
	b=uTdvV9G7rYRnetTDVTuD6dZ7dZK19Zw7hTnEiftK9VcpDWqcp+WMGkH523JDKaYgBZU2
	 44WmPXgmcYb1b0IVGMyA72+6F/kp4GVud97zS6xQ6K+2eKkpzV3SyjMV81aNS6nXzm/Nz
	 7HcQYMZLUFSMQLRNB+g99qUEb5+zYo+E2lHWsuNDJYMtviSL7na+xg87MTYwT5ZcTTtkb
	 KDYHSKrVLt5UD9cHrcb0Et0cnuXYTGp1mRcTjtdDRY+MkBIXGtwp0kXBtjmOczBj426Fa
	 dnmT0OkEo/Q/EnJrYu7J8eZkgJO9LssfJ3U1Aedm5k4Jk0bvyVsACWOk7gfn4725eFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=jp6XtKKEghuCtcdv2XmqhPkn9OpVaRn3SmhSjpiJhzM=;
	b=ulA3WCXqHp/HjlPx1UKn1HY3ntNGQQi4uZfq1kUTNYad0pHaqhos10nltlIIdUPw6lsr
	 SLbYZ9/7FePWQUwr1sXVWO6jT5P6CVEcreKMzd70tzKRQe/cl95yy7XazYUJyR2JeKKrQ
	 RdVwqGRE4bir+sWJgwR5IvU0C3Nlwle3l+l/0qTwRdYMWcm7/Tj1AHg006szh3uB7ibBk
	 f3fS+bzRRghCzWyBWTT2PqmG9FHQuPuT3DZRcafGPnTpUXDFhQo0isPrcSsE+9k1ESUBm
	 0AW0UP0F/3sYK1fylNQpr0z1scE/buxD1vEywiQ8j25uTgUhD95q7H2ts3bhTSb4pEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=q86nQpf2;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD4606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5AD4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=q86nQpf2
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMC72lvz1XLyhl;
	Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=jp6Xt
	KKEghuCtcdv2XmqhPkn9OpVaRn3SmhSjpiJhzM=; b=q86nQpf2sKjUuGpaufWZt
	NjpZRdXnXVYc72mo/fSJSs3uTYl/eYJGMbrBvXOHi2+LXzipv9Bw9HQY6ZwQp3uj
	Gxtl6cmdeuVPylF9V/R8vP8UDqg1JrFNRh53btmngMfuEWYuo+KiUmGsD8D9J+BY
	LmCRCMTTh88C9gnLpG6SvdmP9fnpcKomgHR8qzm9i5hysc4PgXurtQTKYh25IwcX
	FHL2Z/LlAsJDFwx90Mm5qYMdgi5wNFAAKP+98AKbL0FhxMw0v3fAvmupKXb0w+Hc
	MR3MrAiqAYWxXNLs8zaWjNZXKvaNDPSvTO1S271TpM8tNYPMMTr3E1VJ3BRJ6Quk
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CYQfcxX62SBL; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM60bBFz1XM0nj;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 62/73] enum: Support machine mode attributes on enumeration types
Date: Mon,  9 Nov 2026 12:32:48 -0800
Message-ID: <20261109203259.362845-63-bvanassche@acm.org>
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

Support GCC machine mode attributes (such as mode(__byte__)) on both
enum declarations and enum type definitions:
- Apply prefix and postfix mode attributes on enum definitions to the
  enum's underlying type, size, alignment, and rank when no C23 fixed
  underlying type is present.
- Inspect underlying SYM_NODE and SYM_ENUM signedness in to_*_mode()
  so unsigned enums preserve unsignedness when converted to a mode.
- Expand validation/enum+mode.c and remove check-known-to-fail.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c                | 84 ++++++++++++++++++++++++++++++------------
 symbol.c               |  2 +-
 symbol.h               |  1 +
 validation/enum+mode.c | 26 ++++++++++++-
 4 files changed, 87 insertions(+), 26 deletions(-)

diff --git a/parse.c b/parse.c
index d89f60113152..b686d2d55c36 100644
--- a/parse.c
+++ b/parse.c
@@ -992,6 +992,20 @@ static struct token *struct_union_enum_specifier(enu=
m type type,
 		else
 			warning(token->pos, "attribute __transparent_union__ applied to non-u=
nion type");
 	}
+	if (sym->type =3D=3D SYM_ENUM && attr.mode && attr.mode->to_mode &&
+	    !sym->fixed_type && sym->ctype.base_type &&
+	    is_int_type(sym->ctype.base_type)) {
+		struct symbol *mtype =3D attr.mode->to_mode(sym);
+		if (mtype) {
+			sym->ctype.base_type =3D mtype;
+			sym->has_mode =3D 1;
+			sym->ctype.modifiers &=3D ~MOD_SIGNEDNESS;
+			sym->ctype.modifiers |=3D (mtype->ctype.modifiers & MOD_SIGNEDNESS);
+			sym->bit_size =3D mtype->bit_size;
+			sym->ctype.alignment =3D mtype->ctype.alignment;
+			sym->rank =3D mtype->rank;
+		}
+	}
=20
 	sym->endpos =3D token->pos;
=20
@@ -1599,62 +1613,86 @@ static struct token *attribute_address_space(stru=
ct token *token, struct symbol
 	return token;
 }
=20
+static inline bool is_int_or_enum(struct symbol *ctype)
+{
+	if (!ctype)
+		return false;
+	if (ctype->type =3D=3D SYM_ENUM)
+		return true;
+	if (ctype->ctype.base_type =3D=3D &int_type)
+		return true;
+	if (ctype->type =3D=3D SYM_NODE && ctype->ctype.base_type &&
+	    (ctype->ctype.base_type->type =3D=3D SYM_ENUM ||
+	     ctype->ctype.base_type->ctype.base_type =3D=3D &int_type))
+		return true;
+	return false;
+}
+
+static inline bool is_unsigned_mode_type(struct symbol *ctype)
+{
+	if (!ctype)
+		return false;
+	if (ctype->type =3D=3D SYM_NODE || ctype->type =3D=3D SYM_ENUM)
+		examine_symbol_type(ctype);
+	while (ctype && (ctype->type =3D=3D SYM_NODE || ctype->type =3D=3D SYM_=
ENUM)) {
+		if (ctype->ctype.modifiers & MOD_UNSIGNED)
+			return true;
+		if (ctype->ctype.modifiers & MOD_SIGNED)
+			return false;
+		ctype =3D ctype->ctype.base_type;
+	}
+	return ctype && (ctype->ctype.modifiers & MOD_UNSIGNED);
+}
+
 static struct symbol *to_QI_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	if (ctype =3D=3D &char_ctype)
-		return ctype;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &uchar_ctype
-						     : &schar_ctype;
+	if (cbase_type(ctype) =3D=3D &char_ctype)
+		return &char_ctype;
+	return is_unsigned_mode_type(ctype) ? &uchar_ctype : &schar_ctype;
 }
=20
 static struct symbol *to_HI_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ushort_ctype
-						     : &sshort_ctype;
+	return is_unsigned_mode_type(ctype) ? &ushort_ctype : &sshort_ctype;
 }
=20
 static struct symbol *to_SI_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &uint_ctype
-						     : &sint_ctype;
+	return is_unsigned_mode_type(ctype) ? &uint_ctype : &sint_ctype;
 }
=20
 static struct symbol *to_DI_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ullong_ctype
-						     : &sllong_ctype;
+	return is_unsigned_mode_type(ctype) ? &ullong_ctype : &sllong_ctype;
 }
=20
 static struct symbol *to_TI_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &uint128_ctype
-						     : &sint128_ctype;
+	return is_unsigned_mode_type(ctype) ? &uint128_ctype : &sint128_ctype;
 }
=20
 static struct symbol *to_pointer_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? uintptr_ctype
-						     :  intptr_ctype;
+	return is_unsigned_mode_type(ctype) ? uintptr_ctype : intptr_ctype;
 }
=20
 static struct symbol *to_word_mode(struct symbol *ctype)
 {
-	if (ctype->ctype.base_type !=3D &int_type)
+	if (!is_int_or_enum(ctype))
 		return NULL;
-	return ctype->ctype.modifiers & MOD_UNSIGNED ? &ulong_ctype
-						     : &slong_ctype;
+	return is_unsigned_mode_type(ctype) ? &ulong_ctype : &slong_ctype;
 }
=20
 static struct token *attribute_mode(struct token *token, struct symbol *=
attr, struct decl_state *ctx)
diff --git a/symbol.c b/symbol.c
index 721dd1e81ae5..d4b945d9e161 100644
--- a/symbol.c
+++ b/symbol.c
@@ -592,7 +592,7 @@ static struct symbol *examine_enum_type(struct symbol=
 *sym)
 	struct symbol *base_type =3D examine_base_type(sym);
=20
 	sym->ctype.modifiers |=3D (base_type->ctype.modifiers & MOD_SIGNEDNESS)=
;
-	if (sym->fixed_type) {
+	if (sym->fixed_type || sym->has_mode) {
 		if (base_type =3D=3D &bool_ctype)
 			sym->bit_size =3D bits_to_bytes(bits_in_bool) * bits_in_char;
 		else
diff --git a/symbol.h b/symbol.h
index bb063dc622e0..aa180ac4f514 100644
--- a/symbol.h
+++ b/symbol.h
@@ -214,6 +214,7 @@ struct symbol {
 			unsigned int kr_args : 1;
 			unsigned int underspecified : 1;
 			unsigned int c23_auto : 1;
+			unsigned int has_mode : 1;
 			int		rank:3;	// arithmetic's rank
 			struct expression *array_size;
 			struct ctype ctype;
diff --git a/validation/enum+mode.c b/validation/enum+mode.c
index 182af1895d49..cfd037e8617b 100644
--- a/validation/enum+mode.c
+++ b/validation/enum+mode.c
@@ -3,6 +3,7 @@ enum e { ZERO, ONE, TWO };
 struct s {
 	enum e __attribute__ ((mode(__byte__))) b;
 	enum e __attribute__ ((mode(__word__))) w;
+	enum e __attribute__ ((mode(__DI__))) d;
 	enum e __attribute__ ((mode(__TI__))) t;
 };
=20
@@ -10,9 +11,30 @@ static struct s s;
=20
 _Static_assert(sizeof(s.b) =3D=3D 1, "");
 _Static_assert(sizeof(s.w) =3D=3D sizeof(long), "");
-_Static_assert(sizeof(s.t) =3D=3D sizeof(long long), "");
+_Static_assert(sizeof(s.d) =3D=3D sizeof(long long), "");
+_Static_assert(sizeof(s.t) =3D=3D 16, "");
+
+typedef enum { M_ZERO, M_ONE } __attribute__((mode(__byte__))) byte_enum=
_t;
+_Static_assert(sizeof(byte_enum_t) =3D=3D 1, "typedef anon enum mode");
+_Static_assert((byte_enum_t)-1 > 0, "unsigned enum mode stays unsigned")=
;
+
+typedef enum tagged_m { TM_0, TM_1 } __attribute__((mode(__byte__))) tag=
ged_byte_t;
+_Static_assert(sizeof(tagged_byte_t) =3D=3D 1, "typedef tagged enum mode=
");
+_Static_assert(sizeof(enum tagged_m) =3D=3D 1, "tagged enum itself gets =
mode");
+
+enum __attribute__((mode(__HI__))) hi_enum { HI_0 =3D -1, HI_1 =3D 1 };
+_Static_assert(sizeof(enum hi_enum) =3D=3D 2, "prefix mode on enum");
+_Static_assert((enum hi_enum)-1 < 0, "signed enum mode stays signed");
+
+enum post_qi { PQ_0 =3D 0, PQ_1 =3D 200 } __attribute__((mode(__QI__)));
+_Static_assert(sizeof(enum post_qi) =3D=3D 1, "postfix mode on enum");
+_Static_assert((enum post_qi)-1 > 0, "postfix QI mode unsigned");
+
+typedef enum { UE_0 =3D 0, UE_1 =3D 1 } uenum_t;
+static uenum_t __attribute__((mode(__byte__))) ub;
+_Static_assert(sizeof(ub) =3D=3D 1, "typedef var mode size");
+_Static_assert((typeof(ub))-1 > 0, "typedef var mode unsigned");
=20
 /*
  * check-name: enum+mode
- * check-known-to-fail
  */
