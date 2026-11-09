Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256417;
	b=3xaDk8Os86rbtXmS9cXpFlqbflQUKkjzucPylzKgzy7lBApFBYXz8NIxB/JWK870oEjA
	 moGXY+/tnRYvrer2a4jumXCIrK2KY8g5Zw61Gve4gk8XaKfnd+TxVSPwZL3Zo6Zobk70R
	 J8Ij7WJLydOlEiseva6lyc37A3UfSAonTQzaYXDd2lhScLUKpChmn+RVd/VAkTLmhYgjO
	 1ehUk1Wv9Opg+Q+s+wBuHyvxX1TVaUbwdmuYj0i/B+T04/MshaPOpxgON7PLlaGY2ViKC
	 0/MyfPcB15d1IZ/Hyo6/tSi4Ak0F0XCZXyJ5PoUUecT50VLkFkBUaJYj2Eu3rMAfikg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JBythO/Etaca6V+fIPI1MM6a+Ro0XI0YyobgUZ0ALps=;
	b=sbfMGPzN/+4s/qBDsnTMwWLuE39kj9buxeesduNVh8Qz+ZJWmSS5Z6M7KEUdwzcBwMKl
	 DzHAKrOmxi04VGxYJPEexPJPekdYUrFo/MmQP+QCfV4fscDJnvm6r/18AY2RxjL/Q9xCI
	 1Gy1ra9DFYrHbP1FZvdLLCfFzeRDhuxfqkIFeqWoyuoWlNzSHClePjiqAV6UfevBSrul1
	 Bu0s17ODt5AJwu8S9mDaoG+XdbCK/PfKN8nfNYbdtHLAtdv8ACFmrXnU5uAnBKoFv06jw
	 c8vQjUWO9S4BkwQGoi0eixKoFEILihmvEIFnuDAIfX4fo6jPuB4i7/AVbzV+PfnSt5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FU6vrMF6;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA46606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBA46606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FU6vrMF6
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM34bkvz1XMYJg;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=JByth
	O/Etaca6V+fIPI1MM6a+Ro0XI0YyobgUZ0ALps=; b=FU6vrMF6j8SZd3mQI5Di8
	cfbPNxYn6JyohBBaW0AWEQJLt807X0bUaEs4qtA8eJAMSzfye9te2cV9ZtG8uXZ6
	sdAJaiNaIGjvxpGssTEdCN8SvWVZYoEF3rQVa8dWx/zzwuZE3iOjGHEStsSNEZfk
	BPj3h4hEquoi2AfwI0t/ZrgFXhdMsmGHUHkZjOYt2MeF1g2YNVdVvUNBXmJ3ci6n
	tb0TYrelQGI1dLPZFR9Z9xRiDG25aOir7tFUWx2QPcXucjLOX0RAqnYFn6RSZP7I
	yLwmpwxhMdxdPrfyEa/cFZk6h7VLGX/21UqlpEjVglmbnbb82iXZ0G5W1+WGVSZ5
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XHs4NnubcUZS; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLx2mPJz1XMYJK;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 23/73] dissect: Unwrap array element type via base_type()
Date: Mon,  9 Nov 2026 12:32:09 -0800
Message-ID: <20261109203259.362845-24-bvanassche@acm.org>
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

Use base_type(in) instead of in->ctype.base_type when stepping through
array subscripts in dissect.c so SYM_NODE wrappers are unwrapped properly=
.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 dissect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index 9419c5931fbb..5d25e02fa1ad 100644
--- a/dissect.c
+++ b/dissect.c
@@ -467,7 +467,7 @@ again:
 					lookup_member(in, expr->ident, NULL));
 			} else {
 				do_expression(U_R_VAL, expr->index);
-				in =3D in->ctype.base_type;
+				in =3D base_type(in);
 			}
 		} while ((expr =3D expr->down));
 	}
