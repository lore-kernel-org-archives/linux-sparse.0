Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256428;
	b=Li+qUKcLyWTAV/iMANJQxslpuV7pXR9MWu57CRcadGpJ2uKfEtEZ0ViH2FhK+KjE7O/h
	 OPTU58yQpINxQMzIFWNT7O/cbeT6K+xljJVoVFn5Kv1gNHPvOh+qlbz/0qiMNELs+u516
	 oyqvipl8hLpnFcamfGpKsixSe0KAMvYu0zAbzhynK4A3cKCiBDjE+6Fl3QG7N+/loaUCi
	 hvQtyXhD84rkDJpcvBQHor/xgwCuwvsmfYEtCiHAIzM/To3X8r3uj5ETm3X2wJ+0galkT
	 oNePla89i0AqiXZsKggEyd6HR0PP9NqtHquoSlishSuSMdYn4LhLsfnECNIb+eTC+KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=xVDN7PLTNq+//rS43OA2V0is5hgCyk8bzYmiUy4KxZQ=;
	b=ABV3CJGTkQvVrVuVueXdXgWcfAIyYBgOGfjFjDsa14Oq+w+3QDSrePJr0VyEqpYGL/ji
	 GKcNeBj3r2zc2fTcGLR30tRNJKS3Zegdv5jtOH1Evr4GQs5+B2l1QFQz6mRuIsL3OJ3r3
	 xH3wgQ2wYY50kF/MvM7N+mA0wSgAuaG80sXvwzaQTNMKIZPBNv+BKT4IP1N1Q7qu9rLQ2
	 7Mj+I8rYhC9vMmNWhQQ+zhhFqHkjzJdc2xrIANSbVTzo+u7jkEqHTTSHA+OTG31WLAkOn
	 dNs5xXEc5xDK0BMjpmqsOUqlecMS6/fyXfimtWVyMiQ4jtT049upgAxrZe/mbSTmJAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FoURPfP3;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADC606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47ADC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=FoURPfP3
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMC0L5lz1XLwXN;
	Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256419; x=1796848420; bh=xVDN7
	PLTNq+//rS43OA2V0is5hgCyk8bzYmiUy4KxZQ=; b=FoURPfP3WvTfoCVpnp7Eb
	Aa0pfYjU6wFi2fZfs4S6qHT3iqQTnaPWHzVeA42mnRg/QS3LRIrmjp9G97yfjY4h
	rpumC+S8ZbeyvbgtoGlcf+VJosqOOol9ot7kAJCVyzoG1VsGjZUnSJkEzGE2IIWN
	RjO3R+oHw61bC/kr0qwKealLczj3nT1H9zer8HZdBqnl1A4Zb79T+2MsDFqzSwpb
	sZChOGNwGD7fUtOBd6dbLriytydpNQeUnTIRo61t7NlaYciXuCDJCC2ZYvMLS0zB
	3L1k/ifPhbZt7kxnsZ302ADKdujOyFDcTZBPbmGon9BEN02o1irsFm8yWY7dy79o
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CPjSTDvvaYAT; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM74WDyz1XMG49;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 69/73] builtin: Do not evaluate __builtin_clz(0) and __builtin_ctz(0)
Date: Mon,  9 Nov 2026 12:32:55 -0800
Message-ID: <20261109203259.362845-70-bvanassche@acm.org>
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

Do not evaluate __builtin_clz() and __builtin_ctz() at compile time when
the argument is zero. Return SIDE_EFFECTS instead so that the expression
is not constant-folded.

Avoid undefined behavior in the host compiler. Prevent crashes when
sparse is built with -fsanitize=3Dundefined and run with
UBSAN_OPTIONS=3Dhalt_on_error=3D1, as passing zero to the host compiler
builtins invokes undefined behavior.

Add a regression test in validation/builtin-clz-ctz-zero.c to verify that
passing zero to __builtin_clz() and __builtin_ctz() does not cause sparse
to crash.

Fixes: 3df9233e87de ("expand more builtins like __builtin_ffs()")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c                         | 16 +++++++++-------
 validation/builtin-clz-ctz-zero.c | 11 +++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)
 create mode 100644 validation/builtin-clz-ctz-zero.c

diff --git a/builtin.c b/builtin.c
index 34af6d82b846..93377718f1fc 100644
--- a/builtin.c
+++ b/builtin.c
@@ -246,7 +246,7 @@ static struct symbol_op bswap_op =3D {
 };
=20
=20
-#define EXPAND_FINDBIT(name)					\
+#define EXPAND_FINDBIT(name, zero_is_ub)			\
 static int expand_##name(struct expression *expr, int cost)	\
 {								\
 	struct expression *arg;					\
@@ -257,6 +257,8 @@ static int expand_##name(struct expression *expr, int=
 cost)	\
 								\
 	arg =3D first_expression(expr->args);			\
 	val =3D get_expression_value_silent(arg);			\
+	if (zero_is_ub && !val)					\
+		return SIDE_EFFECTS;				\
 	switch (arg->ctype->bit_size) {				\
 	case sizeof(int) * 8:					\
 		val =3D __builtin_##name(val); break;		\
@@ -277,12 +279,12 @@ static struct symbol_op name##_op =3D {				\
 	.expand =3D expand_##name,				\
 }
=20
-EXPAND_FINDBIT(clz);
-EXPAND_FINDBIT(ctz);
-EXPAND_FINDBIT(clrsb);
-EXPAND_FINDBIT(ffs);
-EXPAND_FINDBIT(parity);
-EXPAND_FINDBIT(popcount);
+EXPAND_FINDBIT(clz, 1);
+EXPAND_FINDBIT(ctz, 1);
+EXPAND_FINDBIT(clrsb, 0);
+EXPAND_FINDBIT(ffs, 0);
+EXPAND_FINDBIT(parity, 0);
+EXPAND_FINDBIT(popcount, 0);
=20
 static int evaluate_fp_unop(struct expression *expr)
 {
diff --git a/validation/builtin-clz-ctz-zero.c b/validation/builtin-clz-c=
tz-zero.c
new file mode 100644
index 000000000000..eb49f0c175d9
--- /dev/null
+++ b/validation/builtin-clz-ctz-zero.c
@@ -0,0 +1,11 @@
+static int ctz_zero =3D __builtin_ctz(0);
+static int clz_zero =3D __builtin_clz(0);
+static int ctzll_zero =3D __builtin_ctzll(0);
+static int clzll_zero =3D __builtin_clzll(0);
+
+/*
+ * check-name: __builtin_clz and __builtin_ctz with zero
+ * check-command: sparse -Wno-decl $file
+ * check-error-start
+ * check-error-end
+ */
