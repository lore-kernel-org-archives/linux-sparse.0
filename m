Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432614;
	b=nIEWA5QS/vpTtEaE4s+2dysO0x1ee5cA3xiF1Eo0d8OYKC/J7+SxaW/EzuD9CI2mo/6b
	 NknGcrbeeZg775NIdmZfz3RPy0vvS3Y69zpHCSyvKJBkJM1/ixb+3JoK5/Q2vS9CBDkkb
	 qkOh77KkKXeqMgk6iVD6/s3MwZYgL1vkG9jACSSEqF95V5dxaqLPv0/RgBlm4y94XeH9b
	 y8DCwefkj7biytS9L4dALuQCbSsqtRbPUkli7+06mwjzVtlH8vTtPm32DAeQJK5Aqm5MS
	 KHrcKE5b2NJqhUfcFg4LwjPv/aPDkVXbeMv2Vk0Jn9Dny9jD8qCZz/7wTtnhB6IyoRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=BiixKBBjIoU9I50zuvKKjrIXbIMDPbeA7Bm1oqx2nW4=;
	b=PesKlbbuJHnht/giTXe1jbzzBniFYY9ACmugR9KzRxp7qETQ4miyzjBhgvMggiESZ40N
	 SAsHPf4UJysdr4t+KmnGNjqs0WYv0aLhDJvGDVF1OMJIFNLE0+HEIIAUh5GNZyxJhy9Xi
	 6WDwn5kiSzTsXTdQaUf/+0SVkKT+kTrjCcvbGaTnQoZoUJZqrU3D4AbR5JXvhtOvKj1gX
	 ovkEj+/zGw+P0dIODcTWdT1/zzDW6A+qy5piZ5rLcxSmXrNNXC68v4XOAGPUUYS7JDKqh
	 DhGQnIHiptiFnPY+ko3T1pxL7Aty1w3R8DEivP+7gBGyxYg5cNIsBHpdLu6/Zcr48Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="mdOe/6DO";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F300606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F300606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mdOe/6DO
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq0XXLz1XM6JN;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=BiixK
	BBjIoU9I50zuvKKjrIXbIMDPbeA7Bm1oqx2nW4=; b=mdOe/6DOF/oQEvemOxFQx
	nn314gQnU/8f1F7IeGUqWCJ19FM3Zyt1Gu6Qgt1SxdFA2U+iBuzM3erFZ4TCZH30
	nIu2xmx7lmTY2pHYJLAEkWOH8P8nQ8ngYA9yTAc9pRATMET8ORkZ4x+0owGkIdw/
	U7rAQVF1l95CQUIDXBtU2rg1K8d8Tq5c50hxihki79XW4Zj+UqebE2ml6MLVH/2i
	W/1s2kliXbPoY+cr3gOn1/62isnU1oHa5VEl/sK/RV4Wav405LfCcalHpGV8rHYQ
	P7pUpVOsmLMDJj/eynt+ZaKHrgxQhvHuUAi/aRvSIW7NKhN8H8Ww2sIKGRv6/Uto
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uJRbgHVXae8u; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsm5WYWz1XM6J5;
	Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 12/20] linearize: Use bits_mask() in linearize_bitfield_insert()
Date: Mon, 19 Oct 2026 10:56:25 -0700
Message-ID: <20261019175633.415493-13-bvanassche@acm.org>
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

Replace the open-coded ((1ULL << size) - 1) bitmask expression in
linearize_bitfield_insert() with bits_mask(size).

Avoid undefined 64-bit shift behavior when inserting into a 64-bit
bitfield (size =3D=3D 64), matching the existing bits_mask(btype->bit_siz=
e)
call in the same function.

Fixes: ff5cc9636a30 ("Add a semblance of sanity to structure member acces=
ses.")
Fixes: a8e1df57346c ("bitfield: extract linearize_bitfield_insert()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 1db2d505a7d4..5bdd6119260f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1003,7 +1003,7 @@ static pseudo_t linearize_bitfield_insert(struct en=
trypoint *ep,
 {
 	unsigned int shift =3D ctype->bit_offset;
 	unsigned int size =3D ctype->bit_size;
-	unsigned long long mask =3D ((1ULL << size) - 1);
+	unsigned long long mask =3D bits_mask(size);
 	unsigned long long smask=3D bits_mask(btype->bit_size);
=20
 	val =3D add_cast(ep, btype, ctype, OP_ZEXT, val);
