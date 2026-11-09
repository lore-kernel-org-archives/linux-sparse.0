Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256419;
	b=kLOVboxxWlpw09YZCBaJS/tYoFLtRPsR0NP5lzeoEBt7E5XG7nuGQaKP4a1FcKFuPa0k
	 encR4RVBozLhClQbv2TZjogUqcw7565GP8p/4mLHyjnRCB7DTZQ3ohdBtI2+SKD8xE76m
	 vu7rNLupFlF9hNFIyxZYcxAkCM0SOOyGJJflpgbCQPj3c+wUzUEwBsiuUBLStgCwzy7c2
	 YxURqlZPcjvJ0ijUO5S6fGhOEPsLGt48dZK9WHZi9N0tGtH0VrncjXuJ1rr56bVS2WVVd
	 ZDJmGgdDQRgeJ69poPJa5L2CivL4LcAIn1sSq1S0ztXpqlNjW+26moKNdzZNvyBqBQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=LQ1vZ1/4Lo/BrxsWZtqmvnw7TvXGmEi0GeoBlzYoMCE=;
	b=a0NDdNpeQ2Ga2vpwjbp5RNXyI4/ZMXJtQ7T24YNnoh6CvFl7bhXStGN6IOMEroRi1Ecm
	 0OG7HOb1Da6Mar0ikywED3Z0xnHCMWfpzRzAWv5lbG5KGktTEezmSdJtc2P7ldJmSvaLQ
	 TxihJkfqBlbiDSlB7P0pGGVgtr2rY4lqVp3X+iQprECqkoQFypEt//zn3JZlvbkiuQ2Tt
	 MqA/wkKfqxogxXdWnQmWC308OcB+XDMszrK78uT8REF2mfEgI7jiq51lQCZ5Hlbjkc4j5
	 1yb93+23p/P7eGuS15ly4lgxTvty1AsXkqQKz70Mq8MYGm4HKnUkWTuG3wQcUp684Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=HCpMzkxT;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2724B606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2724B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=HCpMzkxT
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM42BFcz1XM6JF;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256414; x=1796848415; bh=LQ1vZ
	1/4Lo/BrxsWZtqmvnw7TvXGmEi0GeoBlzYoMCE=; b=HCpMzkxTyngDWYhQcUsNf
	LTKJher0hXhuQgGdDma4gCCnTWIWu62XJ3ihRVFhy3H8R6ljfG3cAGLuXFmNh0iS
	CnYYG//zEEMb5KTJOmDev0YQlUo2uQ6sSiapD1lKbUGY9bVYV+CUrfYQbYylHUj3
	MhfCQFfJKBgpDuXlkMepv7s6gwV7m0YnUpAxK9vp2AJWpVyKPBfkIfyrwGkBzu3C
	M7j6lY05zFFpO0jEqbAhWRWvA9P4ZY1gVXG9ZiZzHum25NPuofJiWiwBBGl9oMqM
	XDFftBJkP/26eCJZEdamBN1PR5P8Bm8iW4RIT3i9ksHdKoESue3gRmN+EVeTmD4L
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cp3OT5k4-Qbq; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLw5G2kz1XMG4F;
	Mon,  9 Nov 2026 20:33:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 20/73] c2xml: Guard against recursive symbols and free xmlGetProp() string
Date: Mon,  9 Nov 2026 12:32:06 -0800
Message-ID: <20261109203259.362845-21-bvanassche@acm.org>
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

Return early in examine_namespace() when sym->aux is already populated so
mutually recursive struct definitions do not trigger infinite recursion.

Guard sym->ctype.base_type->aux in examine_symbol() and release the strin=
g
allocated by xmlGetProp() with xmlFree() after xmlNewProp() copies it so
analyzing recursive struct types does not leak memory under LeakSanitizer=
.

Add a regression test in validation/c2xml-recursive-types.c.

Fixes: f744a1419d92 ("add c2xml program")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 c2xml.c                            | 11 +++++++++--
 validation/c2xml-recursive-types.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 validation/c2xml-recursive-types.c

diff --git a/c2xml.c b/c2xml.c
index 519769f72a71..f23ec1a72de4 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -190,8 +190,13 @@ static void examine_symbol(struct symbol *sym, xmlNo=
dePtr node)
 			if (!sym->ctype.base_type->aux) {
 				examine_symbol(sym->ctype.base_type, root_node);
 			}
-			xmlNewProp(child, BAD_CAST "base-type",
-			           xmlGetProp((xmlNodePtr)sym->ctype.base_type->aux, BAD_CAST=
 "id"));
+			if (sym->ctype.base_type->aux) {
+				xmlChar *base_id =3D xmlGetProp((xmlNodePtr)sym->ctype.base_type->au=
x, BAD_CAST "id");
+				if (base_id) {
+					xmlNewProp(child, BAD_CAST "base-type", base_id);
+					xmlFree(base_id);
+				}
+			}
 		} else {
 			newProp(child, "base-type-builtin", base);
 		}
@@ -250,6 +255,8 @@ static void examine_macro(struct symbol *sym, xmlNode=
Ptr node)
=20
 static void examine_namespace(struct symbol *sym)
 {
+	if (sym->aux)		/*already visited */
+		return;
 	if (sym->ident && sym->ident->reserved)
 		return;
=20
diff --git a/validation/c2xml-recursive-types.c b/validation/c2xml-recurs=
ive-types.c
new file mode 100644
index 000000000000..210def55086b
--- /dev/null
+++ b/validation/c2xml-recursive-types.c
@@ -0,0 +1,15 @@
+struct B;
+struct A {
+	struct B *b;
+};
+struct B {
+	struct A *a;
+};
+
+/*
+ * check-name: c2xml-recursive-types
+ * check-command: c2xml $file
+ * check-output-ignore
+ * check-output-contains: <symbol type=3D"struct".*ident=3D"A"
+ * check-output-contains: <symbol type=3D"struct".*ident=3D"B"
+ */
