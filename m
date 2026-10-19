Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432615;
	b=v8a/wFIDtygijwWNHlESRIkK01Km8iV8BPPcWndfCIYXxMDQHpeLBl1ZHfXU9BbXMgEK
	 g5yPHJsXiLzUupFmvVDFEs6AC/sOF1Be8a9teYNJERXNyvrS+PCJZyWvG6cOZF1W64sBp
	 KYIjoGCDR/tVyvHvZH2ajs/GdIO08RrcLWpmoNH7oTI7gbi5vApRd8l789n8iGeYpgMvq
	 GgWTEapkPsNws1zVIuQvC1sfrzAhoqC9hIk0DFx2W27oH+Yu1djIq4KMrf8qLbWftjiBz
	 GVYWioerZ/8H+R+wDEF277udUYiEtsZ+ew8s2VsYUVjK9+Bz9dd8VqjAoei/48U/Kcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=SPV3nbPM36HDSPJOqsi/0LDta5+Qs4FzbgL1cTG129w=;
	b=ow6j13l3q4ViOJmsX846GgWyF0EwTGKrxhfHahXkvuNn9VENFI3WHuMzktDao9OeEiYA
	 5n5Bb33/zw7n4kYdlbY/Nmd+HHV1bTLFxGx1PWl0a6Qi7k+MkjfFcDg6Xzv/bWATTFBFP
	 Q7tblyNx+YMW9tuboacV5qvEjl6v3VXh/ZcTIDDhADekE63Zq/iirUzl13Ap4ZnR6vIxS
	 d4w7NG8W39NipdzsX8CnmJoY1Uv8DZ/6/qbZfTZdiGzWybbDUoxXm0HmCYGskCBnkuUgc
	 1efMTOqLvH6a3RtZT5Fic3PgrRajPHfH+m+gC8czlM4wDqxO3pjn6Af80C5WiCR5PLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=awODcrbC;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBDB606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DBDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=awODcrbC
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq1sTvz1XM4Tn;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=SPV3n
	bPM36HDSPJOqsi/0LDta5+Qs4FzbgL1cTG129w=; b=awODcrbCnGB200bWgPFFz
	0yqhPLLVEQj0bw2DEMfLJJ5KyiP4qrxZp8aH+ptgAUcKnJtVzFymRoZ7xX18Ypxl
	BKXWjZb8q9J5wf0uIhzzJMFeROHy695aKWtWwLF/cGFEeM2m0NiAad2INaOuPGrq
	5G04W+LexY1+RjSV0B9SSAdKrKf94D6+ZpeTKYOyyH1hNHpTaYm9XRN2NhGPoryH
	6V9BE1kWIDyxD3g5AWRF2NkrXTA9+bK8HYEak53RYU44ulXDGsAFnwR3ZKf1PrHG
	k8ru+Z59vvBPdDYpiLoEIE155poLhzM5kgDGMEfRIxoTYPHH2NkpM3JHyNL6C4rf
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MsujHDAu7m4P; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsm3wDhz1XM4Tl;
	Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/20] evaluate: Use bitmask helpers in evaluate_ptr_add()
Date: Mon, 19 Oct 2026 10:56:24 -0700
Message-ID: <20261019175633.415493-12-bvanassche@acm.org>
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

Include "bits.h" in evaluate.c and replace the open-coded 1ULL shifts in
evaluate_ptr_add() with sign_bit(itype->bit_size) and
bits_mask(bits_in_pointer).

Avoid undefined shift behavior when folding constant pointer offsets whos=
e
integer index type has zero bit size (on invalid types) or exceeds 64 bit=
s
(such as __int128), or when bits_in_pointer equals 64.

Fixes: fbab5f78de94 ("[PATCH] fix index conversions in evaluate_ptr_add()=
")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 85a6447ba3ce..988ace95abed 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -37,6 +37,7 @@
 #include "evaluate.h"
 #include "lib.h"
 #include "allocate.h"
+#include "bits.h"
 #include "parse.h"
 #include "token.h"
 #include "symbol.h"
@@ -601,14 +602,13 @@ static struct symbol *evaluate_ptr_add(struct expre=
ssion *expr, struct symbol *i
 	if (index->type =3D=3D EXPR_VALUE) {
 		struct expression *val =3D alloc_expression(expr->pos, EXPR_VALUE);
 		unsigned long long v =3D index->value, mask;
-		mask =3D 1ULL << (itype->bit_size - 1);
+		mask =3D sign_bit(itype->bit_size);
 		if (v & mask)
 			v |=3D -mask;
 		else
 			v &=3D mask - 1;
 		v *=3D multiply;
-		mask =3D 1ULL << (bits_in_pointer - 1);
-		v &=3D mask | (mask - 1);
+		v &=3D bits_mask(bits_in_pointer);
 		val->value =3D v;
 		val->ctype =3D ssize_t_ctype;
 		expr->right =3D val;
