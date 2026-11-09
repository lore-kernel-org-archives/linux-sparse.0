Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256423;
	b=zXOEXsyNYthl4VQ/9Vtaokip/4hCuvF6kGonB6b0iUNk1Ds0xK2ioP+aR1eMXRfsHFGY
	 xie4eLNO4hryb75iQGxigaC+joP/5RrO5nGvMMEV850ns7iDHxVbfOIEqApVFpGsZhF28
	 aGt9350XMAz6/fYM1pbHevsRitL36yEiJySoilOrUoa/Y7rOsaHhavjl08MuiOTgAaKev
	 GxzJo2ndgyJ7iJsf2zxGM3HQXzUAq7LI9hrgHyj3cTve2TyWvuyF/8keZKPZQmZUdv/E4
	 0EecC3GVUZ2MJ9twb3lHc/f+KfZs8H5KOuKtJiOhLiLKwXbc7HTQONN+xqOTUO+LUWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256423;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VFFSzS6V/6cfUKw5CEFEdh/0JOx1o8F3jyucObGZdTQ=;
	b=rq/4do0CQxQswlKrOALldZY+XYzKavf6ck6uoHJDwNKoj03FFvRBc41ZzWNM6Pjibxkx
	 xL19Fq3zQZI4pCa4kEj5lDXA+lowwi08xs8bqmS3YYFyuLRJ+Vbo6+RuCTlbuo6/2FskP
	 y5+RfvMbZcf5Gd26rR/ogm04Hti+dpQUkhKMV7PZsAZA9vxa/jgVSoFuCRVb5uLL7c9Fq
	 zff4z32yt/puTqj8U8ZUmHVSwP5czwOpvBmCjzlhUwJUnDJPlStcpXEyrn+U3+rO5SUFS
	 iCtUQNVGqaTPMpvRxNzKTbRQTaAjMD7trceFt5mIoStGB6qkgZmOIuQTLG8tSRAXIiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="Dr/lNTLo";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1630606A331
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1630606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Dr/lNTLo
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM62s5wz1XM6JG;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=VFFSz
	S6V/6cfUKw5CEFEdh/0JOx1o8F3jyucObGZdTQ=; b=Dr/lNTLomJl9sDxBJsP5C
	ijCjLV8mQ+ZOk7pgOrUOwP/4IQbuRKPZ8e9wnyKjOrHUINny88HDXcSaRVxOVAPd
	/03NpRbWMWdGxRlsRdue5lCtjgbOYG3wFaA84OMK50W95iV2OSvqOfOfirkPUTxz
	CVvpJ7t2T1fz0Uno51h52WpFRTSAsoQzjvM4ASJ83y4/BRddebRO4nGTkkRJB8yX
	MJIyNzMHjSjkhIaGOG0VSPESFFeLneZtZ2xqBz70/9N9hLHqNJx+AKvSA9R3bvNx
	urOjq4HpJWu3NV7F7hflKC0K04aJ5It47DhvIgGgzgBOl5YP2lMGkupsELegbe4b
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id odj8r4uwjf8V; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLz4d6bz1XMYJR;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 33/73] bitwise: Allow all-bits-set as a restricted value
Date: Mon,  9 Nov 2026 12:32:19 -0800
Message-ID: <20261109203259.362845-34-bvanassche@acm.org>
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

Allow all-bits-set (~0) as a valid constant for bitwise restricted types
alongside zero, and suppress restricted value warnings on '~0' unless
-Wtypesign is enabled.

Avoid false-positive bitwise warnings on wait-flag masks and similar
bitwise types that use ~0 to represent all flags set.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, check bit widths
  and signedness in restricted_value(), and add
  validation/bitwise-all-bits-and-casts.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                              | 33 ++++++++++++++++++++++-
 validation/bitwise-all-bits-and-casts.c | 36 +++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 validation/bitwise-all-bits-and-casts.c

diff --git a/evaluate.c b/evaluate.c
index 23f87c8dff5b..f4d59d2679d6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -425,12 +425,43 @@ static struct symbol *bad_expr_type(struct expressi=
on *expr)
 	return expr->ctype =3D &bad_ctype;
 }
=20
+static bool is_unsigned_restricted_or_int(struct symbol *sym)
+{
+	while (sym) {
+		if (sym->type =3D=3D SYM_NODE || sym->type =3D=3D SYM_ENUM ||
+		    sym->type =3D=3D SYM_RESTRICT || sym->type =3D=3D SYM_FOULED ||
+		    sym->type =3D=3D SYM_BITFIELD) {
+			if (sym->ctype.modifiers & MOD_UNSIGNED)
+				return true;
+			sym =3D sym->ctype.base_type;
+			continue;
+		}
+		break;
+	}
+	return sym && (sym->ctype.modifiers & MOD_UNSIGNED);
+}
+
 static int restricted_value(struct expression *v, struct symbol *type)
 {
 	if (v->type !=3D EXPR_VALUE)
 		return 1;
-	if (v->value !=3D 0)
+	if (v->value !=3D 0) {
+		int vbits =3D v->ctype ? v->ctype->bit_size : 0;
+		int tbits =3D type ? type->bit_size : 0;
+		bool vsigned =3D v->ctype && !is_unsigned_restricted_or_int(v->ctype);
+		unsigned long long uval, tmask, vmask;
+
+		if (vbits <=3D 0 || tbits <=3D 0 || vbits > 64 || tbits > 64)
+			return 1;
+		uval =3D (unsigned long long)bits_extend(v->value, vbits, vsigned);
+		tmask =3D bits_mask(tbits);
+		vmask =3D bits_mask(vbits);
+		if (uval =3D=3D tmask || uval =3D=3D ~0ULL)
+			return 0;
+		if (vbits >=3D tbits && (v->value & vmask) =3D=3D vmask)
+			return 0;
 		return 1;
+	}
 	return 0;
 }
=20
diff --git a/validation/bitwise-all-bits-and-casts.c b/validation/bitwise=
-all-bits-and-casts.c
new file mode 100644
index 000000000000..c69041f80318
--- /dev/null
+++ b/validation/bitwise-all-bits-and-casts.c
@@ -0,0 +1,36 @@
+typedef unsigned long long __attribute__((bitwise)) be64;
+typedef unsigned int __attribute__((bitwise)) be32;
+typedef unsigned short __attribute__((bitwise)) be16;
+
+static be32 test_all_bits(void)
+{
+	be32 a =3D ~0;
+	be32 b =3D ~0U;
+	be32 c =3D -1;
+	be32 d =3D 0;
+	be32 e =3D +0;
+	be32 f =3D -0;
+
+	return a | b | c | d | e | f;
+}
+
+static be64 test_all_bits_64(void)
+{
+	be64 a =3D ~0;
+	be64 b =3D ~0ULL;
+	be64 c =3D -1;
+
+	return a | b | c;
+}
+
+static be16 test_narrow_all_bits(void)
+{
+	be16 a =3D ~0;
+	be16 b =3D 0xffff;
+	return a | b;
+}
+
+/*
+ * check-name: bitwise-all-bits-and-casts
+ * check-command: sparse -Wbitwise $file
+ */
