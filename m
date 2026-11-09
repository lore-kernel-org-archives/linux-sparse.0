Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256416;
	b=OMi/h6JiNSXl7EC5bPk5r2amxT1+VDIESptWHVmGAt9jXBLr3T6dv7g3kmS40/l0R82p
	 jfXM/ckSZyta2o0TjJxGDtrETXemei2p5s72VMgcgLkkVYGD0DPjh0Hvj22s6G+xwG+xp
	 +BWN1WxoXdKvPXbW56O988rtlrL3G6WIXYLOx974SImx2lLyssrYDiE94M3kodttvTjx3
	 3NQxHtbXGSqp9Fj6s2VbXBPgXHwRDAoqF9803+nSWD+qjoJzJ5DXORsYC2bXlMMaxsHG0
	 3haOgLffEoGkswXgLBgvPOaoG4wkaINj8ofbDqmGq2xOc+VT4gR2wqPjoH35+3sg1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JthUbFotaac6PS/yd6IN6TU6VMCmNPQJFLmtYOF5Apo=;
	b=lRx/6XoUYiHCnndSqpM7DdlXeSSXmmkxdTaG7ejN+gscnogdCkPgsF5zDmcG6RCCG2VR
	 uO4MZt2Pyp30LAGmFXwtuvsMplLxTP9WHpHZnD1ro/eC6lc9Qma/dnxQWMP10HtReCWkb
	 bEyPEhWukn/7RDhKoDXPwRqq2js+2ZsDB29oVGzXjdAg/tVWjcnzqslR1Xb9WqSNKp/oU
	 hCUPjgbRg0TX8mYxqU8BDm4v6TKTD/BCMGLI6CMQlaWWyxOqjmrYbes6vGMBPosEvsuVN
	 USfbH1dOXzAvXhx6+1T4Jp3+ZflF/KLkd8VY6ssgtz/Qf/LNoij9uDJJUxXeoqUx6Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rJf4YtC1;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3415606A321
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3415606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=rJf4YtC1
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM335K5z1XMFx6;
	Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=JthUb
	Fotaac6PS/yd6IN6TU6VMCmNPQJFLmtYOF5Apo=; b=rJf4YtC1QySWH9vF5QQvm
	tYneQ9SOnwle5ShswyJVr5PkioxLEnpGRh4Vfxh667eLeDJ2ZvqEYih2jDZTIEVe
	4532qI/UsLoCTR1uNgeic5OosQNMZcwzzcJZ/f+N74zYR5lG8Y7AHocwbK4prwPY
	AMTclDH6wEVeVGqB/mPtvlEm/7DXl5rfqqOEFlT4AdCmwcL2cqE0UfU1ccubMpEx
	LUTuEL5XZ7KfHMPUyT0hihjmyonqeWDRcMemzB6nTRL5R9Gjt1Qh3F1L0B5P7C5j
	Wji0CSl8UEE5SJXAAbrVqE8wEh+UVCDqjU/cqa27ca9meYZ78vgbtg6RnEiwaA8N
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cal9LllH_YaY; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLx4dbLz1XM6JG;
	Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 24/73] example: Fix show_op() rotating buffer dimensions
Date: Mon,  9 Nov 2026 12:32:10 -0800
Message-ID: <20261109203259.362845-25-bvanassche@acm.org>
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

Declare buf as char buf[4][256] instead of char buf[256][4] in show_op() =
so
each of the 4 rotating slots holds 256 bytes instead of 4 bytes.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/example.c b/example.c
index 0c2ddf50c015..94f82d874920 100644
--- a/example.c
+++ b/example.c
@@ -168,7 +168,7 @@ struct operand {
=20
 static const char *show_op(struct bb_state *state, struct operand *op)
 {
-	static char buf[256][4];
+	static char buf[4][256];
 	static int bufnr;
 	char *p, *ret;
 	int nr;
