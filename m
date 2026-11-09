Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256427;
	b=uGXxK0ro4c2FFV7vj7v0s7659B1oED8XVChQXk1FEelsXzKZKsElmah1PI8O+iOQfYLM
	 dKMNdtp7j+Y9nLUPMSaQi/vy1o8yeAzdLw36C20TYwm9MTHurO5HEfgEDFvzdRQMqgBqO
	 BJHBvwNiY76bw3Chy/35/GY/kF9L4xYL1lzgB52c5rVSFwULmRSti/KcY0Xh+kyVFo84n
	 xx+gIwTUnZdhvyT5FxdeWugDEZZdqeP/rInFt6NMUH3ozobSxZGWma1y5aSHm0+HZKGIN
	 KPba0pnCWuurnm8vIlA9Voc+THJcKa77maTpoMdTUm4bV2q3f1uFYbWlmn5uyi7CYXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=iXX8EuJubFe7hZnkkPk/dG40LXQ8zpOrFkXdfsUWnVQ=;
	b=KbOSVArh2jQuAnjqugUHl20eMAraZmnz5j1goT3xi6GF2uNXA+DpcSbIduQC7Teun7dU
	 DZ3jOtOlJQcVPR2cDwAIzMtHoJLOpMIVvB2s+J1Elqd3A6voyMMuKy1ytX/buHyVqMMKt
	 KChC3Rev9APGEf1cXaDihEKC2p3WwISSEZGBhjE099PyEtueCz5S7JIq63KRviQ+Z4C0N
	 1lvef+wBI+0tVSweVhbnOwdCGpYJ/RwChJ/0xO3gfwOSYfhZ0sWC/5eLZO8xjuMFlleHk
	 pUOSrRnDOjE3z5USyH/qQfSDtvZZQMT6pjnj7X8cYi+5Wy2rHw2WzU5KcQUV6pZNxig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=OxeQXV+R;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C19606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C19606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=OxeQXV+R
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM95ZxTz1XM6JF;
	Mon,  9 Nov 2026 20:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=iXX8E
	uJubFe7hZnkkPk/dG40LXQ8zpOrFkXdfsUWnVQ=; b=OxeQXV+RDH2m65rpz5NQh
	WDOccYa9HwU6dU6qDYHv9GGpE8au9OrIAd7rKOH0o9nrxXSkChCYb0dq6TnRWGZE
	yJHMMw9ygyFcnZ0LhXUFidB5vJ7DkDBxNdUVwdHf1dPgIi2BtIQnfnuk4v8NanhB
	xTy99yoUJY/8DRKHyvQ9zL2D5fMdVLW1uIbRKxNa3Y9vdOHZpXN7i1GOTmJ3NVV8
	tzpT14OuS+O6DG7nw9OkUU6rlTetwRdy4TzdpC/DmYPt1ImyZhspfHnxDT/M7B9W
	topSJIVTla89Qn4Ae/Kk/z0DxpSdZBb2Vjr7UeBxzROe/fRokBcURX4+bVQmyuUm
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1P_rBkDeYWIU; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM65N20z1XLyht;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 65/73] builtin: Support __builtin_infer_alloc_token() as a size_t ICE
Date: Mon,  9 Nov 2026 12:32:51 -0800
Message-ID: <20261109203259.362845-66-bvanassche@acm.org>
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

Declare __builtin_infer_alloc_token() returning size_t_ctype and fold
calls to integer constant expression 0 (CEF_SET_ICE) while evaluating all
arguments without type restrictions.

Support __kmalloc_token(...) in the Linux kernel's slab allocator on both
32-bit and 64-bit targets without an #ifdef __CHECKER__ workaround, and
add validation/builtin-infer-alloc-token.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c                              | 21 +++++++++++++++++++
 validation/builtin-infer-alloc-token.c | 28 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 validation/builtin-infer-alloc-token.c

diff --git a/builtin.c b/builtin.c
index 0be03c51aedd..ba3326970391 100644
--- a/builtin.c
+++ b/builtin.c
@@ -638,6 +638,26 @@ static struct symbol_op object_size_op =3D {
 	.expand =3D expand_object_size,
 };
=20
+static int evaluate_infer_alloc_token(struct expression *expr)
+{
+	expr->flags |=3D CEF_SET_ICE;
+	return 1;
+}
+
+static int expand_infer_alloc_token(struct expression *expr, int cost)
+{
+	expr->flags =3D CEF_SET_ICE;
+	expr->type =3D EXPR_VALUE;
+	expr->value =3D 0;
+	expr->taint =3D 0;
+	return 0;
+}
+
+static struct symbol_op infer_alloc_token_op =3D {
+	.evaluate =3D evaluate_infer_alloc_token,
+	.expand =3D expand_infer_alloc_token,
+};
+
 static int args_va_start(struct expression *expr)
 {
 	struct symbol *sym =3D expr->fn->ctype;
@@ -865,6 +885,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_index", &string_ctype, 0, { &const_string_ctype, &int_ctyp=
e }},
 	{ "__builtin_inf", &double_ctype, 0 },
 	{ "__builtin_inff", &float_ctype, 0 },
+	{ "__builtin_infer_alloc_token", size_t_ctype, 1, .op =3D &infer_alloc_=
token_op },
 	{ "__builtin_infl", &ldouble_ctype, 0 },
 	{ "__builtin_isdigit", &int_ctype, 0, { &int_ctype }, .op =3D &isdigit_=
op },
 	{ "__builtin_isfinite", &int_ctype, 1, .op =3D &fp_unop_op },
diff --git a/validation/builtin-infer-alloc-token.c b/validation/builtin-=
infer-alloc-token.c
new file mode 100644
index 000000000000..0ec460d80edb
--- /dev/null
+++ b/validation/builtin-infer-alloc-token.c
@@ -0,0 +1,28 @@
+typedef struct { __SIZE_TYPE__ v; } kmalloc_token_t;
+
+_Static_assert(__builtin_infer_alloc_token(1) =3D=3D 0, "infer_alloc_tok=
en ICE");
+_Static_assert(__builtin_infer_alloc_token(1, 2) =3D=3D 0, "infer_alloc_=
token 2-arg ICE");
+_Static_assert(__builtin_types_compatible_p(typeof(__builtin_infer_alloc=
_token(1)),
+					    __SIZE_TYPE__), "size_t return type");
+
+static const __SIZE_TYPE__ static_tok =3D __builtin_infer_alloc_token(64=
);
+
+static __SIZE_TYPE__ test_infer(int size, int flags)
+{
+	__SIZE_TYPE__ tok =3D __builtin_infer_alloc_token(size, flags);
+	return tok + static_tok;
+}
+
+static __SIZE_TYPE__ test_infer_single(int size)
+{
+	return __builtin_infer_alloc_token(size);
+}
+
+static kmalloc_token_t test_struct(int size)
+{
+	return (kmalloc_token_t){ .v =3D __builtin_infer_alloc_token(size) };
+}
+
+/*
+ * check-name: builtin-infer-alloc-token
+ */
