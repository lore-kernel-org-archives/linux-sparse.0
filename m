Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432611;
	b=RB/ye8N/xcQ86pqgp7BTlPAU3jyJN4dcDdA5j6q0z6hrzQujyLSLG//rqkr43VHV0wR4
	 gBHWLeJvDvfXCVC+VAe/pIO5FFZWxsL6IAqYf0+5Kjh1AYYjV23dNOoRop/jBBK90yP5j
	 VMQlOloFVMaJsE/09mIuQee18+DUfgppnbfSdqB3r7vIQpiYr2v60iE6YgLgeln3Kri7I
	 qQP2zOGV+XV9D+NlTP0G5nwtsIjKq5UjAASx6aJF4curKw2XStNus8cblLozxbcTe5Ge1
	 D1S5rNv0Y2YeM73R/sFYHexFKUxdbfSwnvaR72+jbqhvowsBQpGyROX58qh6n70clRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432611;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=DreDO2AJsALB7qq1060EfMBKCRI8UDLOHh4uejtOw6M=;
	b=IMeCmnINOOwAA+NLnRIyDIXRaogRi3SHPmUm/t2LBOg7Eo3K7vu9qgLtWIAemTLNdMrS
	 RlBdS4B7/RpR/JOINveJi20SnNrS9C6f1XlSVbWtYEQO7F2BHxlw8UWRaSpiwwyQITFc0
	 0dCRUARM/a615rIH7uRNj7XhL4668780SZs0D98nQyReEu5eBGb9inqxjLvrBbZX3LK1B
	 QTkmeZcTpcRe4+Q2JZzmU9I2gl2SyVMPi1+McDm8VQsFIKfyjJiSl3Cmp4sT8rMUuf/kb
	 MqjMbshzu6+ofFlwDOwJLJlNL7lSobyXjusv8MIP68u8L2KPnrQzpUK16iFMf7Jx7ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=himNnIpc;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B9A606A31B
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18B9A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=himNnIpc
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsn2vsRz1XM6J9;
	Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432603; x=1795024604; bh=DreDO
	2AJsALB7qq1060EfMBKCRI8UDLOHh4uejtOw6M=; b=himNnIpcBsOlty+xzeA6k
	5Qjp/OiPBPmk1yfwffoLXWYkh3KxHuPqPGg79xt3aVZwxb9HsPR80jCMKTBC2uuG
	jARryjBxfWysGVVSYg45TVZkMkiVpYXnzkF6Nv03jXITT1Ho4JzOY48bQbpJl712
	LnWl/gyc+uQl0P+S/zIi71x7MyzulyGzan7zXBshu72fMh8iW5h75eGxuTy7M1XY
	QU1wouXD/eWzs/dG1BWlB48x0QPZ5qGXKfaN6tl3Vhdu32LlnqCX7xnDciWPUvfq
	0CM/IHkuaK5JpEX1JjLTknyzeNlGspwgkarMYXhi+F+wNithQ2dIhszRgyFp5rsg
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mrZGFsalEs67; Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsk3wZWz1XM30h;
	Mon, 19 Oct 2026 17:56:42 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 03/20] bits: Guard against out-of-bounds bit shifts in bitmask helpers
Date: Mon, 19 Oct 2026 10:56:16 -0700
Message-ID: <20261019175633.415493-4-bvanassche@acm.org>
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

Clamp bit widths to [0, 64] in bits.h and fix 64-bit shift calculations
in bitmap.h to avoid undefined shift behavior on 64-bit integers.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 bitmap.h |  2 +-
 bits.h   | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitmap.h b/bitmap.h
index 4d81ffc07538..1f5d2ce48b24 100644
--- a/bitmap.h
+++ b/bitmap.h
@@ -2,7 +2,7 @@
 #define BITMAP_H
=20
 #define BITS_IN_LONG	(sizeof(unsigned long)*8)
-#define LONGS(x)	((x + BITS_IN_LONG - 1) & -BITS_IN_LONG)
+#define LONGS(x)	(((x) + BITS_IN_LONG - 1) / BITS_IN_LONG)
=20
 /* Every bitmap gets its own type */
 #define DECLARE_BITMAP(name, x) unsigned long name[LONGS(x)]
diff --git a/bits.h b/bits.h
index 9908190d8c2f..23ee8805479c 100644
--- a/bits.h
+++ b/bits.h
@@ -12,19 +12,23 @@
=20
 static inline unsigned long long sign_bit(unsigned size)
 {
+	if (!size)
+		return 0;
+	if (size > 64)
+		size =3D 64;
 	return 1ULL << (size - 1);
 }
=20
 static inline unsigned long long sign_mask(unsigned size)
 {
 	unsigned long long sbit =3D sign_bit(size);
-	return sbit - 1;
+	return sbit ? sbit - 1 : 0;
 }
=20
 static inline unsigned long long bits_mask(unsigned size)
 {
 	unsigned long long sbit =3D sign_bit(size);
-	return sbit | (sbit - 1);
+	return sbit | (sbit ? sbit - 1 : 0);
 }
=20
=20
@@ -58,7 +62,7 @@ static inline long long bits_extend(long long val, unsi=
gned size, int is_signed)
 	return val;
 }
=20
-static inline int is_power_of_2(long long val)
+static inline int is_power_of_2(unsigned long long val)
 {
 	return val && !(val & (val - 1));
 }
@@ -67,7 +71,7 @@ static inline int is_power_of_2(long long val)
 // log base 2 of an exact power-of-2
 static inline int log2_exact(unsigned long long val)
 {
-	return 8 * sizeof(val) - __builtin_clzl(val) - 1;
+	return 8 * sizeof(val) - __builtin_clzll(val) - 1;
 }
=20
 #endif
