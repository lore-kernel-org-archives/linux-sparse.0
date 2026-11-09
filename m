Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256417;
	b=qhlMH7RqkY6/XK+ceWS1NkgiWnwfObLWCt91n9RcJdeXLtXjUVxw4U1s9I9EfcRND0/f
	 CQPkktpqagRQ/cSpbzDHxfItV8ouwj6XmAGIeyIFs5vWm6PFS2PvPCifHpt6cVQ6RqvaT
	 G5yHrVU9NWEi0PJbejFaUmcCYd85H4D3B54whRb2f9OZCZyv39Ik6gm8fRzy1KsaHpnDt
	 7oOK3yDEnBPo2rECrzcbQKgiogctOy7e08Yn8Vli8GrWcXTg7I0ZJKbpf3UqHxapqLGWy
	 0HX+u5P4rUtehS7S3FT0mIUUS1LpK3GZkvHe+p2ghk30A0M+d9+q6DYQ9a2hrIOqSug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VHM2ihSjJc2y10Zq78S65QZ2nQ38IO7jr+FKMRBX4EE=;
	b=C+SBVWV0mQWw+2MYpWHpdc5cAvk3mhyfMyKpvY9nc7tuxt4GvGd1zWFPaFjw3LVSZFrD
	 QO6JB9Y/MHJff/EqlYrmX/8zd1Iiz0MehwZY6mje8U/HVgRiwVymBZ/cmxNmtQtdgxcrt
	 +bWXrPg8dawLmA64+LX6xmAzfgDV2m8kEiDzcvkXl4+OxtKm6sqBkVG6TJPAwSTvTLlPA
	 sME/9WacbHib5At8IFnHMcFhpa5W/dR2hyCnbfYYlpx/FNtrs9+KFZE260ryLp+1UEo2C
	 smT0uNAZzYpSzlpuZUW0dwFJ36OYjuNrsZ0aFUF5W539PQCAOrsPs/37NqndeWOilUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=khxnphXO;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370B606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8370B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=khxnphXO
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM34xD3z1XMG49;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=VHM2i
	hSjJc2y10Zq78S65QZ2nQ38IO7jr+FKMRBX4EE=; b=khxnphXOuG/KOy1qHnAGw
	+apwegakIk/gmghLPi9OGhDZ9Jh6FguwYZZV6lGOCC5H753wwK1D7aYwlsWqgR8c
	q4T4E9aI/gwD31uDq54GYTecPwD/dshC0ysQQeBUotGLJh7TF8abgbzVl7dvg57J
	z9VBDksrUoGZTx8y9GbttyRh8sqQaAqQMB1GIE7l14+HU6ntZU8fbiMWUNm4emy7
	KKeyUlY3LMu1qKRHL3n17Dm7vfEfU6ooJ12oof1tjw4faiYRzdqpgQHczmquLlHS
	y4HfujQxp9H2o9CSL3SKgpRampyImB7hDKBYR5Wu04JS4PwutlCz3Q8SGtVQG/Lf
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id kX9fAf9pemm6; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLx1DFcz1XMYJH;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 22/73] ctags: Fix line comparison order and handle SYM_RESTRICT and SYM_LABEL
Date: Mon,  9 Nov 2026 12:32:08 -0800
Message-ID: <20261109203259.362845-23-bvanassche@acm.org>
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

Return a tri-state comparison result for line numbers in cmp_sym() instea=
d
of a boolean '<' check that violates qsort()'s strict weak ordering.

Handle SYM_RESTRICT by recursing into its base type and ignore SYM_LABEL
cleanly in examine_symbol().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ctags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ctags.c b/ctags.c
index afdc42b77b98..e6925510f278 100644
--- a/ctags.c
+++ b/ctags.c
@@ -50,7 +50,7 @@ static int cmp_sym(const void *m, const void *n)
 		ret =3D strcmp(stream_name(a_pos.stream),
 		             stream_name(b_pos.stream));
 		if (!ret)
-			return a_pos.line < b_pos.line;
+			return (a_pos.line > b_pos.line) - (a_pos.line < b_pos.line);
 	}
 	return ret;
 }
@@ -155,8 +155,10 @@ static void examine_symbol(struct symbol *sym)
 	case SYM_BITFIELD:
 	case SYM_FN:
 	case SYM_ARRAY:
+	case SYM_RESTRICT:
 		examine_symbol(sym->ctype.base_type);
 		break;
+	case SYM_LABEL:
 	case SYM_BASETYPE:
 		break;
=20
