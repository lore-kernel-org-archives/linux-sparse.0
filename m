Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256411;
	b=acE2yemKeoMWECL9BimQXyssAjhM9gvaH7klj3D/mYOgJiv3Qa9625dG8eyupy6T2SQi
	 pdepaKA63lt5HJEgcjaRozEcPJWfK8fq2cgc3ZTMSR5qBeBk62HGiOp+Dl1l5dbnKn/CL
	 VPeDU6u2x71yKz97qjLbuZgxLZ5rAVHAttsd7RFzKyDZcqOxjjAW/4Q/jjekaJFvaHKYG
	 7MjDLPnbAZU1w+miZrTmHQU24Cd95vCr9dyTcw3hz/uunvbub9wMgeC8Bt1pdElMRUMfO
	 C7TIJc67SVh0nTXkm3E+P7c4rZz+O1bA13PWfn0F1/vYvE3bHjLwmAGt0aV2wjxOgig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=lw1L2dlNsziBacXYFayL2PETUEPgdB8ejRdl1Giyrds=;
	b=KP5Z8inLTE2NOhKRk0000ndGxA2Nvt7XLQ2N5tp7/Zmh2OMpSNjVgkq7boMLoO+eDliW
	 W31cp5JkcHYE2UilwtKC8acVuS3FSL9ju+Pkf4XNlCFZQBszvHauyA5wEDLYFwcGP2r5x
	 6pgPeZxMyt1l4PXSVe8mnq2r8LWOcVr7Uv+L62y/s+X0VpnAFwoFTHfE8OL+hPl6NVn/y
	 BSyQOOnWcGURpLXBs0pHXreX4CeYC9MuMS1hfUN6eCnMIfnCh2KBYrDOo93bF6E+p0bpp
	 lvJRflwwGyVyQmV68FDFUO17bY1ogNBApN5dVTkN6N0lRCOIaz4s5xRhfl1q78v85cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hkA+U2FR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64D606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A64D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=hkA+U2FR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLy0xS6z1XMYJR;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256407; x=1796848408; bh=lw1L2
	dlNsziBacXYFayL2PETUEPgdB8ejRdl1Giyrds=; b=hkA+U2FR/27Q3ThA9DV8T
	9+90zBXmppHTXvZ+lzh352OEPp7RcpLt1vr2GT56Lj1TfaFn3KiBUdMhCL7jL361
	y7yoPEwXsp6j5+rmP1Dx/Hm0FhjpprVDD6fHpyQUddLm81Xddn1o/6pRJS+Ar7wO
	gGGY2qHfgWjWEbsTun+pMCFzjQauhEroYPOB15c+YVHecBNoa0oddtkyCROyZ/Ah
	QZlenP3B219Q+OvcR+IWOx4xeKR7Kb7CT7bBqUvhkZrk9FbOfwmCocsgaN6iMFKy
	xhTfOSX+S8ZzCZA+IcWK2wCZRv7v4Nc/Inel+kI4ULkb5LJBRfCke+JY1zdQz8C1
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zsH1vPj_HNDU; Mon,  9 Nov 2026 20:33:27 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLs1D4Sz1XM0nj;
	Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 04/73] bitfield: Pack consecutive _Bool bitfields into byte containers
Date: Mon,  9 Nov 2026 12:31:50 -0800
Message-ID: <20261109203259.362845-5-bvanassche@acm.org>
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

Round bitfield base storage unit sizes smaller than a byte up to
bits_in_char in bitfield_base_size() and widen sub-byte bitfield access
containers to uchar_ctype in bitfield_base_type() so _Bool bitfields use
an 8-bit storage unit during both struct layout and IR linearization.

Allow consecutive _Bool bitfields to pack into a single byte in
examine_struct_union_type() and emit bitfield extract and insert
instructions at each member's bit_offset, matching the System V ABI,
GCC, and Clang. Remove check-known-to-fail from
validation/bitfield-bool-layout.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                        | 18 ++++++-------
 linearize.c                       |  2 ++
 symbol.c                          |  2 ++
 symbol.h                          |  2 ++
 validation/bitfield-bool-layout.c |  9 +++----
 validation/linear/bitfield-bool.c | 44 +++++++++++++++++++++++++++++++
 6 files changed, 62 insertions(+), 15 deletions(-)
 create mode 100644 validation/linear/bitfield-bool.c

diff --git a/evaluate.c b/evaluate.c
index 988ace95abed..40778f4e8a63 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1406,12 +1406,12 @@ static int check_assignment_types(struct symbol *=
target, struct expression **rp,
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
 			goto Cast;
-                if (t =3D=3D &bool_ctype) {
-                        if (is_fouled_type(s))
-                                warning((*rp)->pos, "%s degrades to inte=
ger",
-                                        show_typename(s->ctype.base_type=
));
-                        goto Cast;
-                }
+		if (is_bool_type(t)) {
+			if (is_fouled_type(s))
+				warning((*rp)->pos, "%s degrades to integer",
+					show_typename(s->ctype.base_type));
+			goto Cast;
+		}
 		*typediff =3D "different base types";
 		return 0;
 	}
@@ -1475,7 +1475,7 @@ static int check_assignment_types(struct symbol *ta=
rget, struct expression **rp,
=20
 	if (tclass & TYPE_NUM) {
 		/* XXX: need to turn into comparison with NULL */
-		if (t =3D=3D &bool_ctype && (sclass & TYPE_PTR))
+		if (is_bool_type(t) && (sclass & TYPE_PTR))
 			goto Cast;
 		*typediff =3D "different base types";
 		return 0;
@@ -3064,7 +3064,7 @@ static struct symbol *evaluate_cast(struct expressi=
on *expr)
 			warning(expr->pos, "cast to %s",
 				show_typename(ttype));
 		if (sclass & TYPE_RESTRICT) {
-			if (ttype =3D=3D &bool_ctype) {
+			if (is_bool_type(ttype)) {
 				if (sclass & TYPE_FOULED)
 					warning(expr->pos, "%s degrades to integer",
 						show_typename(stype));
@@ -3111,7 +3111,7 @@ static struct symbol *evaluate_cast(struct expressi=
on *expr)
 		}
 	}
=20
-	if (ttype =3D=3D &bool_ctype)
+	if (is_bool_type(ttype))
 		cast_to_bool(expr);
=20
 	// checks pointers to restricted
diff --git a/linearize.c b/linearize.c
index 5bdd6119260f..75850df0a90f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -934,6 +934,8 @@ static struct symbol *bitfield_base_type(struct symbo=
l *sym)
 			base =3D base->ctype.base_type;
 		if (base->type =3D=3D SYM_BITFIELD) {
 			base =3D base->ctype.base_type;
+			if (base->bit_size < bits_in_char)
+				base =3D &uchar_ctype;
 			if (sym->packed) {
 				int size =3D bits_to_bytes(sym->bit_offset + sym->bit_size);
 				sym =3D __alloc_symbol(0);
diff --git a/symbol.c b/symbol.c
index 5470880db271..feaaed3b8a2d 100644
--- a/symbol.c
+++ b/symbol.c
@@ -113,6 +113,8 @@ static int bitfield_base_size(struct symbol *sym)
 		sym =3D sym->ctype.base_type;
 	if (sym->type =3D=3D SYM_BITFIELD)
 		sym =3D sym->ctype.base_type;
+	if (sym->bit_size < bits_in_char)
+		return bits_in_char;
 	return sym->bit_size;
 }
=20
diff --git a/symbol.h b/symbol.h
index 9ff2733021b8..bd163450628b 100644
--- a/symbol.h
+++ b/symbol.h
@@ -477,6 +477,8 @@ static inline int is_bool_type(struct symbol *type)
 {
 	if (type->type =3D=3D SYM_NODE)
 		type =3D type->ctype.base_type;
+	if (type->type =3D=3D SYM_BITFIELD)
+		type =3D type->ctype.base_type;
 	return type =3D=3D &bool_ctype;
 }
=20
diff --git a/validation/bitfield-bool-layout.c b/validation/bitfield-bool=
-layout.c
index 4e0a2b4a2b60..2f559f98491f 100644
--- a/validation/bitfield-bool-layout.c
+++ b/validation/bitfield-bool-layout.c
@@ -12,14 +12,11 @@ struct bfb foo(struct bfb s)
=20
 /*
  * check-name: bitfield-bool-layout
- * check-description: given that bool is here 1-bit wide
- *	each field here above completely 'fill' a bool.
- *	Thus 3 bools need to be allocated, but since the
- *	alignment is 1-byte the result has a size of 3
- *	bytes, 24 bits thus instead of 8.
+ * check-description: Verify that consecutive _Bool bitfields pack into =
a
+ *	single 1-byte (8-bit) storage unit rather than allocating a separate
+ *	byte per bitfield (24 bits).
  * check-command: test-linearize -Wno-decl $file
  *
- * check-known-to-fail
  * check-output-ignore
  * check-output-excludes: ret\\.24
  * check-output-contains: ret\\.8
diff --git a/validation/linear/bitfield-bool.c b/validation/linear/bitfie=
ld-bool.c
new file mode 100644
index 000000000000..91c9111eb91d
--- /dev/null
+++ b/validation/linear/bitfield-bool.c
@@ -0,0 +1,44 @@
+struct bfb {
+	_Bool a:1;
+	_Bool f:1;
+	_Bool z:1;
+};
+
+_Bool get_z(struct bfb *p)
+{
+	return p->z;
+}
+
+void set_f_one(struct bfb *p)
+{
+	p->f =3D 1;
+}
+
+void set_f_two(struct bfb *p)
+{
+	p->f =3D 2;
+}
+
+void set_f_ptr(struct bfb *p, int *ptr)
+{
+	p->f =3D ptr;
+}
+
+int init_bfb(void)
+{
+	struct bfb s =3D { .a =3D 1, .z =3D 1 };
+	return s.a + s.f + s.z;
+}
+
+/*
+ * check-name: bitfield-bool-linearize
+ * check-command: test-linearize -Wno-decl $file
+ *
+ * check-output-ignore
+ * check-output-excludes: load\\.1
+ * check-output-excludes: store\\.1
+ * check-output-contains: load\\.8
+ * check-output-contains: store\\.8
+ * check-output-pattern(2): or\\.8.*\\$2
+ * check-output-contains: ret\\.32.*\\$2
+ */
