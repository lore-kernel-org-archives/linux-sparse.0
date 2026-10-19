Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432613;
	b=MveWz7SG5dxsRbwO1aVkJch3H8iKmOPaL0EkW9Mal/F55KiXLGcz/15k3tZbs8LSBKEP
	 Iiz+37Bn/6mLwlzRPIEnv7mV3pqDsJcgV97bnUDhdE+phwhxPFNVdy/V6OteoUTcVTZm9
	 aI6TWjdkh1oaAjcd9Gagbl6diDSjyDSH2nmtaqEiujk73ITrLg24XgyoMwOQTHCajwOk8
	 niCfHcLuSMc/6fox4Hj8/wmsMtzQoV2RBBqwcR+IJLlVXka6rBQDmGLviutnNyERapo4p
	 WDE9ktjSiSc0hqGVzH70mZ/IoPa1zOoVgo6x4UR9Czu017JjsFMnfl2pEplrLyQzufg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LJZBHa6gvijy9qGTJ6Z05VRWdhPXa3CcahZz8NRMcDM=;
	b=XmPqs61TD6lrFjTZbYtdJvxUbCF5Zn7mpw8TlSVLS3Zg6qSls5aJetSy98dlHjbbrZ72
	 9PpihowDvQ4I227amhbQb5V1anxnPIy/0YiDWlSQrJhROjO45Qnua8FRW3yTmnBFqYIeX
	 M92q9iyROtb0oZHZvePK37KD+PYm0LKGrk1rzda436HGt/zbMR6K2MhrWoAd4y7cqgTwL
	 3kTzL6f22xLLfAnQZeyG1IAMixpswU3HsbvpHmTCgbh5+NchYzViajnZkR/KELC85vaze
	 AMvkXFTOFchw6S1C9Cu9iiBQnNzbxTtcQxtjJjlzoQ1CyonGad6irbJ8J8l+IqOvt8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JIS+f6bZ;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C7606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF1C7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=JIS+f6bZ
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsp4b8tz1XM6JH;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=LJZBH
	a6gvijy9qGTJ6Z05VRWdhPXa3CcahZz8NRMcDM=; b=JIS+f6bZhCSCKElGTV6bK
	J9vNBMZeFF+VRL+WrAxxmhW47Avj8weiT5pqDaNiCmuFkzHk90p15v9KZv6msEwZ
	MH/omANqlUj6xaz4VhsKi7YWTv0adUMGNSmTYSTIGn+C9/3hmCtm22BM9K9RQxoy
	J0ijsNvSgzgV2tuS+CWWK9vYFLJqqj03Rx9+W0B/Tn0zYu5J7Y5aLLfWFX7Go8t6
	U4FsXN6p/h+t5u8i+xA2OIe4NlqugRHZsUv0URwykBuE8TUSpVmUvlLNM1HmiyGl
	gQwabsusIQsgwmGcfTYhjZJ3WsY3j5wfwHN5wFqdNmk3ovpL5LBEQW3/+mzlXxtA
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bfmZiHynLT_w; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsl2F35z1XM30w;
	Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/20] c2xml: Use an unsigned shift in examine_modifiers()
Date: Mon, 19 Oct 2026 10:56:19 -0700
Message-ID: <20261019175633.415493-7-bvanassche@acm.org>
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

Replace the signed integer shift expression 1 << i with (1UL << i) in
examine_modifiers() when testing bits in sym->ctype.modifiers across
indices 0 through 31.

Avoid shifting a signed 32-bit int value into its sign bit when i is 31,
eliminating undefined signed left-shift behavior in C and matching the
unsigned long type of sym->ctype.modifiers.

Fixes: f744a1419d92 ("add c2xml program")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 c2xml.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/c2xml.c b/c2xml.c
index 1a24c3a8120a..519769f72a71 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -149,7 +149,7 @@ static void examine_modifiers(struct symbol *sym, xml=
NodePtr node)
=20
 	/*iterate over the 32 bit bitfield*/
 	for (i=3D0; i < 32; i++) {
-		if ((sym->ctype.modifiers & 1<<i) && modifiers[i])
+		if ((sym->ctype.modifiers & (1UL << i)) && modifiers[i])
 			newProp(node, modifiers[i], "1");
 	}
 }
