Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256418;
	b=cxoKnwDKUPK/HEumukvUUeNPv5LKSiDlvbor1G61AQK/jvOADxX8EZfPEDGw1mZJyIxK
	 3RBakzpn2vVodkqN2GzTKk8B2pNkigL8D/XocJACVF7VoYlV0+j5hFUv8AvNaIRh1rHeh
	 5/AZV1r6gDBB+fyA3ac7A0KuQoHzz3j8MAKbrTefimxXotYaH/kwhisfRCYbI5M38UNUT
	 6fMEcf4UrtT/Chr0uLKZZJSj9jXb0xDsRYNObM0Sjxkw3Hj6JRyx2MrFDUZqeyQ74nTVP
	 aB7arBODftLgXbdfOG5cV1HdulNjtn7Dy+OEHEdcD9hQWwzB67zofdYs7WC9R31ze+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=olt1WD8muqx074YsF8jO5kaJi8+xlFNuQo9DLXcZRxc=;
	b=s36ggmUX5Vx6T2U37zB/ttAM7Y3NmE4XXMwrt4ep+XEjZHV5MLDtClSmdQE3LoJo31kf
	 9rcCI47fF44otg91kLgBC4k+kF6pn6JjdacLI4eNLqKQGVFWV1Lh3+vOU1lv70OGkaLOS
	 k5y9DmuoyLBTzsZ8GHPwJxxf6z25XoAI7wP3UQYoD6JdyoDMZZmZv/9V6ZTykPfQU4LjZ
	 lLIBGJRmdkvQDNu5usL/4zlqTrq7ljo+zGJPf8tC817dUYmUsCuMQKYYdt6xd/2o83MAK
	 Ttt0EwT992ulMu2HUavqheRpqpwwv4rwg6JX+ZaivSQO0PHDTu/IT85Yto6f+smnNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0eT4r9em;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E981606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E981606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0eT4r9em
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM403k1z1XM0nk;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=olt1W
	D8muqx074YsF8jO5kaJi8+xlFNuQo9DLXcZRxc=; b=0eT4r9emUSlmHx99amZ7M
	ad7W4eB+vfkjsslqwgl48vjIm7J+lis5Iaw2v3IZhMTI3XAnfku8tN2VynPaD3Hm
	hZw2o09Txwdb8PrSLP+/SZ7nSdP4yiXJZ5tdmixXgb1HEUqNIxwi8zSf80qzYQp3
	qyOUtezhTBhF0e4yiahrv2pmFw1FsnbxZYLKoM0IjRfpTMtfDs5gCmLYB35oXO33
	lkxD9DMUhVIH0YFKaUwaZU2w+edXBSWbhAf88OB4b9QYbQtoQCkKlBEbZoN2/fXa
	vm/3vu2MsYqVZ2klP6Lt2lMS/mwHGaIMhjPlcSTV+5lp2X3k1/eeGmi3kgJBrHGl
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1RbqjWtqdhXa; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLy0v1zz1XMYJN;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 26/73] scheck: Fix slice() upper bit index calculation
Date: Mon,  9 Nov 2026 12:32:12 -0800
Message-ID: <20261109203259.362845-27-bvanassche@acm.org>
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

Pass new - 1 instead of old - new - 1 as the upper bit index to
boolector_slice() in slice() so narrowing casts extract the low 'new' bit=
s
of the bit-vector.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 scheck.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scheck.c b/scheck.c
index bb052d97996d..2189f4138d81 100644
--- a/scheck.c
+++ b/scheck.c
@@ -107,9 +107,8 @@ static BoolectorNode *sext(Btor *btor, struct instruc=
tion *insn, BoolectorNode *
=20
 static BoolectorNode *slice(Btor *btor, struct instruction *insn, Boolec=
torNode *s)
 {
-	int old =3D boolector_get_width(btor, s);
 	int new =3D insn->type->bit_size;
-	return boolector_slice(btor, s, old - new - 1, 0);
+	return boolector_slice(btor, s, new - 1, 0);
 }
=20
 static void binary(Btor *btor, BoolectorSort s, struct instruction *insn=
)
