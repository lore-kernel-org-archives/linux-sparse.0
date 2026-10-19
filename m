Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432613;
	b=1nYQXkajoYQz+zE/cX/YsPMw1irv7aKje3EmBqu5tUQfsnT77tM9LUFaYI0l8ppaqNPI
	 +NwQJFYvzcbnSvhLXKYUWGhqdAcXSkWc67B7L5ryxqa+Hac4H2TeyBi4o9mYVoUgZNSZd
	 CTem36Sevuck1UKCa/Jsh13NVynv+T1h+kRHX4xQIuyue4g3KUrr6oW+gJ/xEX+KFfVSa
	 YW3NK2YFJWzknmfRwgkcAlt0pBGbc++9rwyAEtZgkvtRtMTZV4Id3vqfPAc2AKtZYPykS
	 W4FayE0tWpegXGUEoYmgZRdF9xbyvOpVi9K0LVcvpjoR3pKj9UtZUwgon2RjRaC6DqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432613;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=5I6nE1cRQH6+qNDHv8dD+4vGL84txjRo3wUdq3nchBc=;
	b=bY2utTzVqNVNUdEeZkpnkAiH0qWQoLUwtIiANXH5kfieujr8qVJ2lcmHJmp1Lr4Tl8yv
	 3seDrKIR92PixYb9dN3TQG9mTHujhyt2uyIVvwK5AtsvUIlUBoaf9fn2D0QeWbwuNkZSX
	 Es+Bh/spTwW2PBbjx2zrGeDpXG+mQw84cbkZbjmNkaq9PJ1hfXXMKetSOyT3621Ia8Xb1
	 xRWL1GGmnqLsSD6n5fGCwne4te9xiLLdYv2+FTYEBWAnjLxQGMUJkFvDB8Yripj6ST5OG
	 riQEnuxjh/7Xxjl9tuZNNyqYbRUVZCVXbW8goTFJE218SlnmXAqYHms1RyN1JZpiI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="RZ34TE/m";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78436606A31F
	for <linux-sparse@vger.kernel.org>; Mon, 19 Oct 2026 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78436606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=RZ34TE/m
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4j7jsp5yy2z1XM6JJ;
	Mon, 19 Oct 2026 17:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1792432605; x=1795024606; bh=5I6nE
	1cRQH6+qNDHv8dD+4vGL84txjRo3wUdq3nchBc=; b=RZ34TE/mf7vR3H9EA2fz9
	icfQUxuNcw3+BmEEO493I2C95zsHBOYh59zA0ONYYKu1CdwZCwMuV1B+YZkLREke
	QdM/CEjaF654DYFAxSOyiTvCeyiFFKvYW9/zFtaJNdFhZqeeVeFloWPBonm/3ce7
	Iklt/e85MQSRzCyUeq5qb4CfKqQA29dKmxQd5OZenbDThE3D5yFgPl+1yoVlxdFe
	/HZzcNCstEYBNu0n8rnDDSIrbQNHrSyfbhzLPr59RgwN4qmXlmlGrIPE1gjCEu8u
	fYKvo7kZbZr4GxqhSsJ1/+BR+wI9JUVkKTkJuaOH2FPYs60ZiwfYucaQlovrsJZN
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ai4waKNGf14o; Mon, 19 Oct 2026 17:56:45 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4j7jsl3s7Qz1XM30y;
	Mon, 19 Oct 2026 17:56:43 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 07/20] parse: Avoid incrementing rank on invalid long real specifiers
Date: Mon, 19 Oct 2026 10:56:20 -0700
Message-ID: <20261019175633.415493-8-bvanassche@acm.org>
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

Check whether rank is already non-zero before incrementing rank for a
Set_Long type specifier in declaration_specifiers(), and break out of the
loop before incrementing rank when class is CReal.

Prevent out-of-bounds reads past the end of real_types[] when indexing
types[class][rank] for invalid specifier combinations such as "long long
double", where incrementing rank to 2 before breaking exceeded the valid
[-1, 1] index range of real_types + 1.

Fixes: 319206abe1f2 ("Rewrite and fix specifiers handling")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 parse.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/parse.c b/parse.c
index 9389079eb173..0e3e384550c5 100644
--- a/parse.c
+++ b/parse.c
@@ -1595,14 +1595,17 @@ static struct token *declaration_specifiers(struc=
t token *token, struct decl_sta
 				rank =3D -2;
 			if (s->op->set & (Set_Short|Set_Float)) {
 				rank =3D -1;
-			} else if (s->op->set & Set_Long && rank++) {
-				if (class =3D=3D CReal) {
-					specifier_conflict(token->pos,
-							   Set_Vlong,
-							   &double_ident);
-					break;
+			} else if (s->op->set & Set_Long) {
+				if (rank) {
+					if (class =3D=3D CReal) {
+						specifier_conflict(token->pos,
+								   Set_Vlong,
+								   &double_ident);
+						break;
+					}
+					seen |=3D Set_Vlong;
 				}
-				seen |=3D Set_Vlong;
+				rank++;
 			}
 		}
 		token =3D token->next;
