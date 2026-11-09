Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256419;
	b=mCeetzeatrw14JmX9UHPgf8RVd4B/B80b9IU0Q4TurkoUvWRUyuut0xnThx897J7NkU9
	 nmvbCclCOA6TuYt0HOx/Lk3L0C2LroYddC5Die/m7FYbC/xk0rTjFQ3SgnRtceaiNm8Qw
	 LLoMT0gHyo6qlh87p47uXB2YgUwzh7YZQot04NBUPE5U+C+T7WzjT6QLwDT8z2R8ngtd8
	 kpi7EWexJTKRcWgVxgxf0vQqy41ELWLdonIBbtwuDeAXp43ordUKKjbSJ76WOy6x388NT
	 3r8duaTdhZuzTC4w0JYNzBLoqGctqjpLizhakfEeirRnEAl6+Op7ULU43SNizFn2WCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=h0JCawNv+ekp5IxOJsxY4NyIkeqnYpBsv3KhOQRfQQ4=;
	b=HmGCKdgUoUpLk0dLfGectAagDlItVpkV/MsAy3Qe7/NZY3mB2UVD8zI3VwkOHdQCgC1J
	 ZfYjU6dqfa9B8PGq/m2EG37bSQeavRCJys6A5FC8EkJVQ1v7qjoGcv1ocLjczzqk0UGhi
	 GaHDuyxpQ4rYeErS9KbDCeo60lP3wQygCp9r2MZyO92dXANS9hHgiHxYoG2YP/NPTKTNd
	 1G13EoMuaz/6G3GQx90T0oAfx6il0MafDbr9jvzrv0cS+1hE/Uu+y9iY3IW7TWRIsYDJK
	 pIx1GTh/SM/fuDGfy4n92xBlJWUNB7RhivVgunya3dzp4qvtTg76Fyti4lHwg1nJftQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="ufci/ukD";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5CD606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=ufci/ukD
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM43tR3z1XMYJn;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256415; x=1796848416; bh=h0JCa
	wNv+ekp5IxOJsxY4NyIkeqnYpBsv3KhOQRfQQ4=; b=ufci/ukDxCo1G90E0NEbX
	nTPbM9X4elXrqss+boQtbmBUduPDvSVehKe9aaRLGkgcN0C9OWxWxOVqBEEnQPFx
	VvtqxhDSQAptZ+LoQ7NAT8CU2MKz1WhtKFphpLvdlw5yOE5+aLLK8erD8YBe7JcK
	lij0qzh9kpQuO0Vkxk8XOj6Gljkhxipnd68t8m0f2amJS4V7m8C4ltPi7QugF28g
	sBmJVkxO74nHyQNO/AtXcjqjEl6B0vi3KpV8NwFp8il+s63JTxFkJ89AbjdDaIBs
	Ufq9YjInJYSHnlfUdf2/fszyqY4JjHnR8QqAOdFSeCbyee2mDs8y/Mb49p9KwYsC
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NheekPoImPaa; Mon,  9 Nov 2026 20:33:35 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLy5XYKz1XMYJM;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 29/73] lib: Avoid mutating fmt before va_start() in warning()
Date: Mon,  9 Nov 2026 12:32:15 -0800
Message-ID: <20261109203259.362845-30-bvanassche@acm.org>
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

Introduce a separate local pointer variable warn_fmt for the format
string passed to do_warn(). Avoid reassigning the function parameter fmt
before va_start(args, fmt) to maintain standard variadic argument
initialization semantics across ABIs and compilers.

Fixes: 8fa23ccfe298 ("Add "info()" for informational messages...")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib.c b/lib.c
index ff8efb157f39..6670e3b46657 100644
--- a/lib.c
+++ b/lib.c
@@ -182,6 +182,7 @@ void warning(struct position pos, const char * fmt, .=
..)
 {
 	va_list args;
 	static unsigned int warnings =3D 0;
+	const char *warn_fmt =3D fmt;
=20
 	if (Wsparse_error) {
 		va_start(args, fmt);
@@ -200,12 +201,12 @@ void warning(struct position pos, const char * fmt,=
 ...)
 		show_info =3D 0;
 		if (once)
 			return;
-		fmt =3D "too many warnings";
+		warn_fmt =3D "too many warnings";
 		once =3D 1;
 	}
=20
 	va_start(args, fmt);
-	do_warn("warning: ", pos, fmt, args);
+	do_warn("warning: ", pos, warn_fmt, args);
 	va_end(args);
 }
=20
