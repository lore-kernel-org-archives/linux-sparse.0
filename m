Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432614;
	b=SxDbHpl+Hx88ObmnFfm5SAxYFH9p6dENrOXbaG37Eb8+lrPypVNdqaaPmqc1Y17j2Aht
	 Ci7n/0daJN7wEWOz69e1MRatZIrQMNkdL5hpCp98WUN9IcbJVxAxXpwD58pqWl9nVHMX1
	 +vpgb7+r+e/uxLYD8yTuvNFOzEgTfZKGjU2tysKEeR+b1bWlZTVXDyDtAE2hY5G0Oimfk
	 4WBPSKcMWKOg1Ss7JpGeIWnppuW/Bv+Yqw97qrqHunQtJBJsdz3b9hm5wQTO2fWlvj3f+
	 YxJb/Xh0bRi3xayaduMA4n1wgWA8eW4sUar+rjUPfpdnXnE7UmydVBxmKqt5DEm1kgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=WnXyqFSz+eL5Y2f0ffR0AP1UG4Sa/toK10ZuA5Ep/7s=;
	b=CYCHvMTIRwCrzXBhBhvjQpB6srxW4S/115sldl7o1Nc1u/XuVaLbxdFTz9pb9byeaPHp
	 P8AVR8QTutFKSBCthWKgkTOkFBUgn34GqMPWHwUPHcCQpGLmD1ZIhrYnRb6+NUesRt7ra
	 RWhwqJBtiAuVQRdvCo5YI0aZQ4LfhUTkt9OpaUB9Ep9qeIjuAc2Met+T+JUFdI/ezqyDM
	 sCPFuteTlH7paYFaB/TuQ0zRg1VETKegO99RfZI4GBR1HtREQWTZupSNOcjVz6Z9ZPSAr
	 llvaoQxHEdaNeKkgWfSnU377jLQ6h5z0nUVcx0TUrQVvVRI5RXicTSQRd8pP2hB4Dvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Ps7KnEok;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EE606A31C
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Ps7KnEok
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsq089qz1XM30y;
	Mon, 19 Oct 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=WnXyq
	FSz+eL5Y2f0ffR0AP1UG4Sa/toK10ZuA5Ep/7s=; b=Ps7KnEoksCZjS/0EYVmYh
	A7cEyqS1vP+Arlxv5esbr/wBIBpDU1Zb9tA9BRXM/ACVSeGe6ptntqBoajiCcaLW
	G1F1Nmu8cYi2PHRUt8yCG8RZEAcCwbO96X/Gl614TTzOg5i91Z/ENdg0shyvn9d0
	pBwQHMaGRE2IJ7r9UBE+z/ZUc5zYgFkgxWsHc9O8LTAZkPR7D2Sdt3+JMKMnFY19
	/IJzM9WJypwhQ9nGPhdAJlySXlW/wCwH0eGCLQ5ETPOPy+YNTGK5DxC9ece8ZsyM
	ai8vxLpiUnchztk1d8hyVFvgnsqmdKcxrIL/4HI29/wtFB/qeww+5sBwJqHCKLEs
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6Yio8y6Yg3GN; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsm2HHYz1XM6Hv;
	Mon, 19 Oct 2026 17:56:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 10/20] target: Avoid signed overflow in bit and byte conversion helpers
Date: Mon, 19 Oct 2026 10:56:23 -0700
Message-ID: <20261019175633.415493-11-bvanassche@acm.org>
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

Cast bits to unsigned int before adding bits_in_char - 1 in
bits_to_bytes(), and widen bytes_to_bits() to accept and return long whil=
e
performing the multiplication by bits_in_char in unsigned long.

Prevent signed integer addition overflow in bits_to_bytes() near INT_MAX
and prevent 32-bit signed multiplication overflow and truncation in
bytes_to_bits() on large array offsets and sparse initializers.

Fixes: eb800bdc3791 ("Unhardcode byte size being 8 bits.")
Fixes: b3e9d87c6a98 ("sparse: make bits_to_bytes round up instead of down=
")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 target.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target.h b/target.h
index 92b8af9169d7..0b21702c45f1 100644
--- a/target.h
+++ b/target.h
@@ -143,12 +143,12 @@ void target_init(void);
=20
 static inline int bits_to_bytes(int bits)
 {
-	return bits >=3D 0 ? (bits + bits_in_char - 1) / bits_in_char : -1;
+	return bits >=3D 0 ? ((unsigned int)bits + bits_in_char - 1) / bits_in_=
char : -1;
 }
=20
-static inline int bytes_to_bits(int bytes)
+static inline long bytes_to_bits(long bytes)
 {
-	return bytes * bits_in_char;
+	return (unsigned long)bytes * bits_in_char;
 }
=20
 static inline unsigned long array_element_offset(unsigned long base_bits=
, int idx)
