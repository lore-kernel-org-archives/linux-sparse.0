Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256412;
	b=4Cz6UnGeeR95xbeatQQvR6H+fllXGhn9EuGi1NfIE0omZf9POfS2fme+wlhShaImhVWp
	 aJ7adnrU1CVDb2lDttnsLm4BAcOugvqAOC8cCNmO/w9wmkJhiuXPihYngJmbGMZYTBuyY
	 xpBL6p7MJYx/LBpTkm0iDCYo/2+Ec1jyxYSgViDF6HZD4ZqRQNgdiLaSOfJsO9O2Z3LT5
	 MsTmCbkVwgzVqn1oKeaLSj2ZS/T0Y8/uDzxCI43ktIZdpjYf9woh/YJ0zVziy8+h53QHY
	 MK24ii+Y4Sy/vfLVdIAwgO/G4uhA3uVfaY2o2Sx4GWAk1BF06tiwZ43C3hMjnP+A7vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=tjTO9Lik0fwmE+rhaafsmkjPOlw2bGvprzGZLseceNI=;
	b=deSIUjabEzvyMojf+IOsOWDrqHzoui1y1mIOq9f5YKcGWyALNEX6LysVsiUvqcUqETvx
	 LeTWtcbKpNFjcnf3RJXKgg16V7XenzpItiFywP1IxhRHUj2+UGnovZmbQY0k4PuGYr/T0
	 SGJLecd3M6Z9VnkWmPqoKshlas+NL0d50ppWG3lmn296YKRj2bZMFQPJrP1aQYWjju6uC
	 MxO+aPsS3BXLKgAyysBmfIk9/gQnDqdOkCti5ddEG/6TsGkCBqYHnPXfkkrEOsIDy5njF
	 rhajxZcWZv4kody5z0GFuP1iQfaUCTjFobqqNoDaFwtRF/NTkhn1XbEZLcR9/ck/4FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1yC5Wwcd;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940DA606A332
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 940DA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1yC5Wwcd
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLz0jt5z1XMYJL;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256410; x=1796848411; bh=tjTO9
	Lik0fwmE+rhaafsmkjPOlw2bGvprzGZLseceNI=; b=1yC5WwcdW7W8/V4GvqhSw
	+YLhL3KhD876Ppdyr/CpR//fTVp6BFXI9Girhhwsyy6nNB0QTIK+pRSXwuLIzGaw
	TS28dgM7BnSCcgNo/A92jUTLB2jLi27wgTvORmDOPLBMbTSwLHQYzCgUxnBQOZOG
	0Cyb7/vsphPd5sauzN8YTGt3g9VeQ68PzUvCMgywRhFx/1Aj9j41AeIj+zkqwurj
	Ao470gF41h+IqL2cPthf3PNZ2KedIh5sQYLzq0JP2xywP5dUByXyG94aqy4XGy3N
	WrltDADyquIPT8BI6Ll84V6tVDWOsl7QL6dfyD7DnScP8NmsnEFwiA9xMDdOqMxi
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BR-GRs1G4plJ; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLt51d3z1XLwXF;
	Mon,  9 Nov 2026 20:33:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 11/73] target-openrisc: Set target_openrisc.mach to MACH_OPENRISC
Date: Mon,  9 Nov 2026 12:31:57 -0800
Message-ID: <20261109203259.362845-12-bvanassche@acm.org>
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

Set target_openrisc.mach to MACH_OPENRISC instead of MACH_NDS32 in
target-openrisc.c so that OpenRISC targets report the correct machine
architecture identifier.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 target-openrisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target-openrisc.c b/target-openrisc.c
index ad25ff2791d3..8f576339858e 100644
--- a/target-openrisc.c
+++ b/target-openrisc.c
@@ -20,7 +20,7 @@ static void predefine_openrisc(const struct target *sel=
f)
 }
=20
 const struct target target_openrisc =3D {
-	.mach =3D MACH_NDS32,
+	.mach =3D MACH_OPENRISC,
 	.bitness =3D ARCH_LP32,
 	.big_endian =3D true,
=20
