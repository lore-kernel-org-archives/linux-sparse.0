Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256424;
	b=EZvvCnQfbXrxXJGUJc/gfKwLAk07yx121fcOZQNKGiiAOsGWsW9UEMGjDnuUvFeazUKe
	 bo0VqzGtQVUk+c7iyLqm3k8wKiINB+JDqKhuRMz6rN5wfM0ra8vRZjCNQpSnhyxRmsr4c
	 i3j5XrKtG0hgbVMs+evIqi3cjGpnmWtCO5FlgEVWK7yTx5bV4bv0ZFpjpI3Tqsh8JIPHu
	 M1tW8kXPHwLNA7QdEVxK32YLaFes8mC5F+V+9Ec7g66LvfVJG9zWxc+yIPS9i7+2tHzXL
	 BMf/llNQaIB2pPShcPVPOVhS0iRXp/TQVtYDZSAMYS3novAGXM4n9R/pWG56Y/Kl34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Lu7F3BLG3iWeyy+p9LpyQ8DSZ7tg2utLxqEbzmsg16g=;
	b=aonhMpQ9GGTuJY9rB4zoHnYNbybqyuSANDgWkZByb3/soxnH6GJV2oIazQdDsC2dywjR
	 4JdlZnilvbIvx5bhjRjTbY3lX4c3V+aK25rcq0Wjm72flT1rTIoluLv8usUR3qnnQzpqe
	 XZeQKFQshESdZdvPBHcsUieZt8+buUo3/kv5pPHfGa1DwoY2fCFsIG93y6Y0LV8hxyUxw
	 PsVj0e27yFPMkq+MHTi3ma2QUFoSbFutTRctMUtO/ncTh4j2sFRY0SyG4QgamRw9siNFE
	 P5UYETA+qASJYLLrMOTyP20mVcb9Z+BmgFAqiUYPGWybubksisQGa9JFGQ6pQId8zYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=h1SHWeiF;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FF606A333
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A4FF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=h1SHWeiF
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM63yTLz1XMYJW;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=Lu7F3
	BLG3iWeyy+p9LpyQ8DSZ7tg2utLxqEbzmsg16g=; b=h1SHWeiFs64a8mwJuCyEi
	WOnatl8VEyi+filKL+T8s2Cz0mABW0KuVsHjROUCWbOMaf7jocQA/YmAaKddp8yg
	kkd9HWe2QQcSvtwWHmPxB5glnDlnjCbZKotGQI/IRrSlCJLgSX7NV5hOul7kw183
	ozkymdOR4uL+GijmwMkPBalzc667u62UPdJYQoXF8XrE3xOL3KdIU+0GOYIKc+Rg
	7qm6szBq6tnb3hz4iObYfnv3cBoH9FUgn5IRKfDZ2O4RCb0eeLM68lSuSMDhQEX+
	CES6b0CIfZemF8WYF0t/t5kOyRZP20UUf6jOU3Qn41nKnYTLlq+jCRsJPBqer5rM
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tZdtNdiPMRvV; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM00c9Vz1XLyht;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 35/73] bitwise: Keep unrestricted values unrestricted after a cast
Date: Mon,  9 Nov 2026 12:32:21 -0800
Message-ID: <20261109203259.362845-36-bvanassche@acm.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

Allow a cast of 0 or ~0 to its own restricted type (such as
'(__le32) 0' or '(__le32) ~0') to remain an unrestricted constant in
restricted_value().

Allow 0 or ~0 cast to a restricted type to match another restricted type
even when the macro definition does not use '__force'.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[ bvanassche: Rewrite commit message in imperative mood, fix typo, reject
  narrowing non-zero casts in restricted_value(), and extend
  validation/bitwise-all-bits-and-casts.c ]
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 evaluate.c                              | 17 +++++++++++++++++
 validation/bitwise-all-bits-and-casts.c | 18 ++++++++++++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 23f9e0fcdc4a..4e8856aa6bcc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -443,6 +443,23 @@ static bool is_unsigned_restricted_or_int(struct sym=
bol *sym)
=20
 static int restricted_value(struct expression *v, struct symbol *type)
 {
+	if (v->type =3D=3D EXPR_CAST) {
+		struct symbol *ctype;
+		int cclass =3D classify_type(v->ctype, &ctype);
+		struct expression *leaf =3D v->cast_expression;
+
+		if (!is_int(cclass))
+			return 1;
+		if (restricted_value(v->cast_expression, ctype))
+			return 1;
+		while (leaf && leaf->type =3D=3D EXPR_CAST)
+			leaf =3D leaf->cast_expression;
+		if (leaf && leaf->type =3D=3D EXPR_VALUE && leaf->value =3D=3D 0)
+			return 0;
+		if (ctype->bit_size < type->bit_size && is_unsigned_restricted_or_int(=
ctype))
+			return 1;
+		return 0;
+	}
 	if (v->type !=3D EXPR_VALUE)
 		return 1;
 	if (v->value !=3D 0) {
diff --git a/validation/bitwise-all-bits-and-casts.c b/validation/bitwise=
-all-bits-and-casts.c
index 08f2b4c43285..01c8d84fcd67 100644
--- a/validation/bitwise-all-bits-and-casts.c
+++ b/validation/bitwise-all-bits-and-casts.c
@@ -10,8 +10,10 @@ static be32 test_all_bits(void)
 	be32 d =3D 0;
 	be32 e =3D +0;
 	be32 f =3D -0;
+	be32 g =3D (be32)0;
+	be32 i =3D (be32)~0;
=20
-	return a | b | c | d | e | f;
+	return a | b | c | d | e | f | g | i;
 }
=20
 static be64 test_all_bits_64(void)
@@ -19,15 +21,19 @@ static be64 test_all_bits_64(void)
 	be64 a =3D ~0;
 	be64 b =3D ~0ULL;
 	be64 c =3D -1;
+	be64 d =3D (be64)0;
+	be64 f =3D (be64)~0;
=20
-	return a | b | c;
+	return a | b | c | d | f;
 }
=20
-static be16 test_narrow_all_bits(void)
+static be16 test_cross_cast_zero(void)
 {
-	be16 a =3D ~0;
-	be16 b =3D 0xffff;
-	return a | b;
+	be16 k =3D (be32)0;
+	be16 m =3D (be32)~0;
+	be16 o =3D (unsigned short)~0;
+
+	return k | m | o;
 }
=20
 static int test_ordered_compare(be32 x, be16 y)
