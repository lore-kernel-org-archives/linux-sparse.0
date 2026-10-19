Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432617;
	b=eyKdxU3ESFsfNdocp9gtNExI/b187DsxxFBfw4GVX+X3FzsqO6jYNHoULZIbpV/Uct3a
	 ZHxTH4bc25Tj41u6FEvYiQ/JkyuhmNrBu/cG7WO3WYq7KJ5fLs1yzZTlo9nm1aIAfBCtO
	 tMhamnfYfEcLV5oj/YjWwhiVzXb7b0KyAVUohPb92NfTkBcYZ0vq/sHx0U+c1zI7riBbD
	 8BOGtuoBq/VA5auS7gDGkClre99qUcpNrlULGwXlSqbMVRTzVENRGSTCbv8peME25tzGo
	 LbiVLYJd6SMqBpAoTMb7yETZNr4dc3nYmTm4+iuGRsyvlbAA8yiCBFtpJIjuErSaaHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=n3qmANtApaIh8Dsd/0EelJXgs3L9G8PAEtZaYpHfDE4=;
	b=m2UIIvA41r3biyRvjJMqnybRjr+6xNigkE/R6We2yR/AykQnmytwARDIcusnvVGIEJIN
	 YF7FnEC0JC5kfUP2BO8a8KOh7FVAxvc4JCHC3lPbMzKJIXDb3WMxsezKBbj1gfnxt+GNa
	 GBChLqGjZ2pO5gPkE/vOgrMGyTePa5SKN0YN+G1cMF84EcWeyK7gemu8BdLA3bZ9svxdU
	 39E1XBnYO0wQaeg1aKTQ86PahP6Oa/5e2rx3ICHRn+PfdYTI8osNUdxb5hiBI52G4sYep
	 YFGaEQwCcMEpCQqH0C7tnHEVauuK7zgJB9KxZ7L6eh0Q7IdRtHVArDDrD7tQ4EcClLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EtJCfDqc;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD6606A31D
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79DD6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=EtJCfDqc
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jss35Lbz1XM6J6;
	Mon, 19 Oct 2026 17:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432606; x=1795024607; bh=n3qmA
	NtApaIh8Dsd/0EelJXgs3L9G8PAEtZaYpHfDE4=; b=EtJCfDqcNyz+FuU7JDr/o
	Jc/Q3NRQs+tWRDC3av6Mp7T7FaqJywKqPE6KKRGYonlzxSrF2XWL8W6FSsfkx5/u
	HPhP4B1tKZrs+b6/MoUmuRHXCyRvwNGI4aBdQFpisGxlRiTSvwto0XyMFvs6As2v
	ailiOnC6qtTfaaJCFdlUdjsPChgqeaHKdiBlg6UKGcSlpZxNPnfaOfKHJRPwlD1t
	tleargc3Vc33GGb+YlXrobbFHu+ok4v259QmlH+TL3fsnaykkXUkKIiNJxFdrw8+
	M9g0/qbE+8LEcDsCgCKqu29Rm4P58w5fDd0R05GCFxOkDzkCuzRin/yzJRBMwtbj
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id S-cc--g16-Yb; Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsn2gM8z1XM6J7;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 14/20] simplify: Avoid undefined shifts and signed overflow in simplification
Date: Mon, 19 Oct 2026 10:56:27 -0700
Message-ID: <20261019175633.415493-15-bvanassche@acm.org>
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

Use unsigned long long masks and arithmetic with sign_bit() and
bits_mask() in eval_op(), simplify_mul_div(), simplify_constant_mask(),
simplify_constant_rightside(), simplify_constant_unop(), and
simplify_cast(), guard shift counts in eval_op() against 64-bit overflow,
and skip 64-bit mask simplifications in simplify_shift() when insn->size
exceeds 64 bits.

Eliminate undefined host C behavior from signed 64-bit overflow during
constant negation, addition, and subtraction, and from out-of-range
shifts when simplifying 0-bit, 32-bit, 64-bit, or 128-bit integer
instructions.

Fixes: 29946c577c13 ("Do first-approximation constant binop simplificatio=
n.")
Fixes: 08778dab2167 ("Simplify constant unops")
Fixes: 62cab21fe13b ("add support for __int128")
Fixes: 0b9963941148 ("simplify 'x | ~0' to '~0'")
Fixes: 97e6515a7944 ("unop: add helper eval_unop()")
Fixes: f1252a541ac8 ("simplify '(x * -1)' to '-x'")
Fixes: c68bfab0e487 ("simplify ((x & M) >> S) when (M >> S) =3D=3D 0")
Fixes: cb4bed63e19e ("simplify ((x & M) << S) when (M << S) =3D=3D 0")
Fixes: 3a729e93ba9f ("simplify ((x >> S) << S)")
Fixes: 1ed0dfb47362 ("cast: simplify TRUNC + ZEXT to AND")
Fixes: 5da4e09b4701 ("cast: simplify AND(ZEXT(x,M),N)")
Fixes: 780d796a478f ("cast: simplify [ZS]EXT(AND(x,M),N)")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 simplify.c | 53 ++++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/simplify.c b/simplify.c
index 68c5f9c74021..f20b6f1a9881 100644
--- a/simplify.c
+++ b/simplify.c
@@ -632,10 +632,11 @@ static pseudo_t eval_op(int op, unsigned size, pseu=
do_t src1, pseudo_t src2)
 	long long left =3D src1->value;
 	long long right =3D src2->value;
 	unsigned long long ul, ur;
-	long long res, mask, bits;
+	long long res;
+	unsigned long long mask, bits;
=20
-	mask =3D 1ULL << (size-1);
-	bits =3D mask | (mask-1);
+	mask =3D sign_bit(size);
+	bits =3D bits_mask(size);
=20
 	if (left & mask)
 		left |=3D ~bits;
@@ -646,17 +647,17 @@ static pseudo_t eval_op(int op, unsigned size, pseu=
do_t src1, pseudo_t src2)
=20
 	switch (op) {
 	case OP_NEG:
-		res =3D -left;
+		res =3D -ul;
 		break;
 	case OP_NOT:
 		res =3D ~ul;
 		break;
=20
 	case OP_ADD:
-		res =3D left + right;
+		res =3D ul + ur;
 		break;
 	case OP_SUB:
-		res =3D left - right;
+		res =3D ul - ur;
 		break;
 	case OP_MUL:
 		res =3D ul * ur;
@@ -688,17 +689,17 @@ static pseudo_t eval_op(int op, unsigned size, pseu=
do_t src1, pseudo_t src2)
 	case OP_SHL:
 		if (ur >=3D size)
 			goto undef;
-		res =3D left << right;
+		res =3D ur < 64 ? ul << ur : 0;
 		break;
 	case OP_LSR:
 		if (ur >=3D size)
 			goto undef;
-		res =3D ul >> ur;
+		res =3D ur < 64 ? ul >> ur : 0;
 		break;
 	case OP_ASR:
 		if (ur >=3D size)
 			goto undef;
-		res =3D left >> right;
+		res =3D left >> (ur < 63 ? ur : 63);
 		break;
        /* Logical */
 	case OP_AND:
@@ -967,7 +968,7 @@ static int simplify_shift(struct instruction *insn, p=
seudo_t pseudo, long long v
 		case OP_AND:
 			// replace (A & M) >> S
 			// by      (A >> S) & (M >> S)
-			if (!constant(def->src2))
+			if (!constant(def->src2) || insn->size > 64)
 				break;
 			mask =3D bits_mask(insn->size - value) << value;
 			omask =3D def->src2->value;
@@ -991,7 +992,7 @@ static int simplify_shift(struct instruction *insn, p=
seudo_t pseudo, long long v
 		case OP_SHL:
 			// replace ((x << S) >> S)
 			// by      (x & (-1 >> S))
-			if (def->src2 !=3D insn->src2)
+			if (def->src2 !=3D insn->src2 || insn->size > 64)
 				break;
 			mask =3D bits_mask(insn->size - value);
 			goto replace_mask;
@@ -1003,7 +1004,7 @@ static int simplify_shift(struct instruction *insn,=
 pseudo_t pseudo, long long v
 		switch(DEF_OPCODE(def, pseudo)) {
 		case OP_AND:
 			// simplify (A & M) << S
-			if (!constant(def->src2))
+			if (!constant(def->src2) || insn->size > 64)
 				break;
 			mask =3D bits_mask(insn->size) >> value;
 			omask =3D def->src2->value;
@@ -1017,7 +1018,7 @@ static int simplify_shift(struct instruction *insn,=
 pseudo_t pseudo, long long v
 		case OP_LSR:
 			// replace ((x >> S) << S)
 			// by      (x & (-1 << S))
-			if (def->src2 !=3D insn->src2)
+			if (def->src2 !=3D insn->src2 || insn->size > 64)
 				break;
 			mask =3D bits_mask(insn->size - value) << value;
 			goto replace_mask;
@@ -1056,8 +1057,8 @@ replace_mask:
=20
 static int simplify_mul_div(struct instruction *insn, long long value)
 {
-	unsigned long long sbit =3D 1ULL << (insn->size - 1);
-	unsigned long long bits =3D sbit | (sbit - 1);
+	unsigned long long sbit =3D sign_bit(insn->size);
+	unsigned long long bits =3D bits_mask(insn->size);
=20
 	if (value =3D=3D 1)
 		return replace_with_pseudo(insn, insn->src1);
@@ -1523,7 +1524,7 @@ static int simplify_constant_mask(struct instructio=
n *insn, unsigned long long m
 		osize =3D def->orig_type->bit_size;
 		/* fall through */
 	oldsize:
-		omask =3D (1ULL << osize) - 1;
+		omask =3D bits_mask(osize);
 		nmask =3D mask & omask;
 		if (nmask =3D=3D omask)
 			// the AND mask is redundant
@@ -1559,8 +1560,7 @@ static int simplify_const_rightadd(struct instructi=
on *def, struct instruction *
 static int simplify_constant_rightside(struct instruction *insn)
 {
 	long long value =3D insn->src2->value;
-	long long sbit =3D 1ULL << (insn->size - 1);
-	long long bits =3D sbit | (sbit - 1);
+	unsigned long long bits =3D bits_mask(insn->size);
 	int changed =3D 0;
=20
 	switch (insn->opcode) {
@@ -2138,19 +2138,19 @@ static int simplify_xor(struct instruction *insn)
 static int simplify_constant_unop(struct instruction *insn)
 {
 	long long val =3D insn->src1->value;
-	long long res, mask;
+	unsigned long long res, mask;
=20
 	switch (insn->opcode) {
 	case OP_NOT:
 		res =3D ~val;
 		break;
 	case OP_NEG:
-		res =3D -val;
+		res =3D -(unsigned long long)val;
 		break;
 	case OP_SEXT:
-		mask =3D 1ULL << (insn->orig_type->bit_size-1);
+		mask =3D sign_bit(insn->orig_type->bit_size);
 		if (val & mask)
-			val |=3D ~(mask | (mask-1));
+			val |=3D ~bits_mask(insn->orig_type->bit_size);
 		/* fall through */
 	case OP_ZEXT:
 	case OP_TRUNC:
@@ -2159,8 +2159,7 @@ static int simplify_constant_unop(struct instructio=
n *insn)
 	default:
 		return 0;
 	}
-	mask =3D 1ULL << (insn->size-1);
-	res &=3D mask | (mask-1);
+	res &=3D bits_mask(insn->size);
 =09
 	return replace_with_value(insn, res);
 }
@@ -2329,12 +2328,12 @@ static int simplify_cast(struct instruction *insn=
)
=20
 			insn->opcode =3D OP_AND;
 			mask =3D val->value;
-			mask &=3D (1ULL << size) - 1;
+			mask &=3D bits_mask(size);
 			insn->src2 =3D value_pseudo(mask);
 			return REPEAT_CSE;
=20
 		case OP_SEXT:
-			if (val->value & (1 << (def->size - 1)))
+			if (val->value & sign_bit(def->size))
 				break;
 			// OK, sign bit is 0
 		case OP_ZEXT:
@@ -2426,7 +2425,7 @@ static int simplify_cast(struct instruction *insn)
 			if (size !=3D def->orig_type->bit_size)
 				break;
 			insn->opcode =3D OP_AND;
-			insn->src2 =3D value_pseudo((1ULL << def->size) - 1);
+			insn->src2 =3D value_pseudo(bits_mask(def->size));
 			return replace_pseudo(insn, &insn->src1, def->src);
 		}
 		break;
