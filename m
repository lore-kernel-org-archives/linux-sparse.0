Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256430;
	b=wTcxiR4Q36sQwXMtLGVvHeKD+p6jXTOENU3TbZiMEEy4PuzMmzAunngcuLlV8t9i81gm
	 E0eR/5DLKj1N17kcARFoGNXSeIrc8EwxMj5YP/5YmGB2GyUzGeIxSw21UOuSopu+NHeFG
	 3MA/w32C2s4TcOe2g2Qx41qT2FWd4lw6GxOgrjzmr12tJMfpMbnJfhk6y2udW/dQNMqbp
	 ICo3eVmMRYkSJUmEyypiu523jN1oIxkeUFM6A23sl8ri0dcoyskBurCBbf+5TJbzKMYzR
	 vFj3ssGsZGsynUOqJO9xXInd7Aca+nAcdU2DALF3agbtpIcvJtP0yNQG0bi/Vt83Z4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=q6KxZcJrYDtHOBRvYdDgBmUz2EipdyA5srTPXlKgkac=;
	b=G4GSDHpIP0wzaUxKdAm7N3kwTmO1VbxYbVHzwKeaeDdeCahbT+KnDZFNP1/dpHwPZqnu
	 sKEgihgv/fmEl3/eneDfxz48AEa1ssitavsO8cPnkKWt+VSmoxQ5yHc6g4EOWrIsfPzAD
	 kbhIVkcE8hJb/fAU+V7F8VKGayUHGDrSEwJOhzo709J2a8Cff0wW7Xhc3VMFDam7vFzOu
	 cjlM/LvSCJiQ5hwiAiFECAVINC6D04++CTFXJSJKYpLkZ8Re1b7io/ko+qxiH6oUqQJrI
	 jMtgNiYAxOkrWapAoNZeDA10Shc+63deAYNoy5WrULpOK9CSigrchkkCqRL69TE0oNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MJFq6qMN;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F0606A32A
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818F0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=MJFq6qMN
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMD0zX7z1XM0nj;
	Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256419; x=1796848420; bh=q6KxZ
	cJrYDtHOBRvYdDgBmUz2EipdyA5srTPXlKgkac=; b=MJFq6qMNEuO2ObEY/zMlr
	7sHIBG8ke5mzj0Ja4aZzJHZ/qxeMA2Qdm9MY2RGpWqVsSUJD2GRVnA3xDbL6sDpF
	9mzFtxFrO1nF092z3FFlf9Z64hFwggvgbfPMIctud1m0gK7Np59uJOVY868nqRm5
	9LcXDsiyiILNYhFFbS5dFRt3CqMlf12UcXN3pn3XcAj2xpHKKPoP91meBGPBH7Oj
	cH8Ayf5NIGQtLpdDVxNQq4NPG2NAAkdazGgewGkONmZXJP5EEGdl8IRnMsxLL8aD
	s+lMVFVwCk+8Aps4cjtnWxl0HZU21QQGBB3vFp+IAkB3ncwratohcP99B4TFiPBR
	w==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id woRU7NJqc1rb; Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM66xtwz1XMYJg;
	Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 66/73] builtin: Add support for Linux kernel compiler builtins
Date: Mon,  9 Nov 2026 12:32:52 -0800
Message-ID: <20261109203259.362845-67-bvanassche@acm.org>
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

Add support for compiler builtins used across the Linux kernel:
- Support __builtin_dynamic_object_size(ptr, type) via object_size_op.
- Support __builtin_thread_pointer() returning void * and
  __builtin_alloca_uninitialized(size) returning void *.
- Validate that __builtin_counted_by_ref() receives one argument and fold
  it to (void *)0 for flexible array members.

Add validation tests in validation/builtins-kernel.c and
validation/builtin-counted-by-ref-err.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 builtin.c                               | 22 +++++++++++++
 validation/builtin-counted-by-ref-err.c | 20 ++++++++++++
 validation/builtins-kernel.c            | 42 +++++++++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 validation/builtin-counted-by-ref-err.c
 create mode 100644 validation/builtins-kernel.c

diff --git a/builtin.c b/builtin.c
index ba3326970391..e8ea7721b771 100644
--- a/builtin.c
+++ b/builtin.c
@@ -733,6 +733,24 @@ static struct symbol_op va_start_op =3D {
 	.evaluate =3D evaluate_va_start,
 };
=20
+static int args_counted_by_ref(struct expression *expr)
+{
+	return eval_args(expr, 1);
+}
+
+static int expand_counted_by_ref(struct expression *expr, int cost)
+{
+	expr->type =3D EXPR_VALUE;
+	expr->value =3D 0;
+	expr->taint =3D 0;
+	return 0;
+}
+
+static struct symbol_op counted_by_ref_op =3D {
+	.args =3D args_counted_by_ref,
+	.expand =3D expand_counted_by_ref,
+};
+
 static int evaluate_strlen(struct expression *expr)
 {
 	struct expression *arg =3D first_expression(expr->args);
@@ -852,6 +870,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_add_overflow", &bool_ctype, 1, .op =3D &overflow_op },
 	{ "__builtin_add_overflow_p", &bool_ctype, 1, .op =3D &overflow_p_op },
 	{ "__builtin_alloca", &ptr_ctype, 0, { size_t_ctype }},
+	{ "__builtin_alloca_uninitialized", &ptr_ctype, 0, { size_t_ctype }},
 	{ "__builtin_bcmp", &int_ctype , 0, { &const_ptr_ctype, &const_ptr_ctyp=
e, size_t_ctype }},
 	{ "__builtin_bcopy", &void_ctype, 0, { &const_ptr_ctype, &ptr_ctype, si=
ze_t_ctype }},
 	{ "__builtin_bswap16", &ushort_ctype, 0, { &ushort_ctype }, .op =3D &bs=
wap_op },
@@ -859,6 +878,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_bswap64", &ullong_ctype, 0, { &ullong_ctype }, .op =3D &bs=
wap_op },
 	{ "__builtin_bzero", &void_ctype, 0, { &ptr_ctype, size_t_ctype }},
 	{ "__builtin_calloc", &ptr_ctype, 0, { size_t_ctype, size_t_ctype }},
+	{ "__builtin_counted_by_ref", &ptr_ctype, 1, .op =3D &counted_by_ref_op=
 },
 	{ "__builtin_clrsb", &int_ctype, 0, { &int_ctype }, .op =3D &clrsb_op }=
,
 	{ "__builtin_clrsbl", &int_ctype, 0, { &long_ctype }, .op =3D &clrsb_op=
 },
 	{ "__builtin_clrsbll", &int_ctype, 0, { &llong_ctype }, .op =3D &clrsb_=
op },
@@ -868,6 +888,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_ctz", &int_ctype, 0, { &int_ctype }, .op =3D &ctz_op },
 	{ "__builtin_ctzl", &int_ctype, 0, { &long_ctype }, .op =3D &ctz_op },
 	{ "__builtin_ctzll", &int_ctype, 0, { &llong_ctype }, .op =3D &ctz_op }=
,
+	{ "__builtin_dynamic_object_size", size_t_ctype, 0, { &const_ptr_ctype,=
 &int_ctype }, .op =3D &object_size_op},
 	{ "__builtin_exit", &void_ctype, 0, { &int_ctype }},
 	{ "__builtin_extract_return_addr", &ptr_ctype, 0, { &ptr_ctype }},
 	{ "__builtin_fabs", &double_ctype, 0, { &double_ctype }},
@@ -961,6 +982,7 @@ static const struct builtin_fn builtins_common[] =3D =
{
 	{ "__builtin_strstr", &string_ctype, 0, { &const_string_ctype, &const_s=
tring_ctype }},
 	{ "__builtin_sub_overflow", &bool_ctype, 1, .op =3D &overflow_op },
 	{ "__builtin_sub_overflow_p", &bool_ctype, 1, .op =3D &overflow_p_op },
+	{ "__builtin_thread_pointer", &ptr_ctype, 0 },
 	{ "__builtin_trap", &void_ctype, 0 },
 	{ "__builtin_uadd_overflow", &bool_ctype, 0, { &uint_ctype, &uint_ctype=
, &uint_ptr_ctype }},
 	{ "__builtin_uaddl_overflow", &bool_ctype, 0, { &ulong_ctype, &ulong_ct=
ype, &ulong_ptr_ctype }},
diff --git a/validation/builtin-counted-by-ref-err.c b/validation/builtin=
-counted-by-ref-err.c
new file mode 100644
index 000000000000..242e1a3f441c
--- /dev/null
+++ b/validation/builtin-counted-by-ref-err.c
@@ -0,0 +1,20 @@
+struct fam {
+	int count;
+	char arr[];
+};
+
+static void test_cbr_args(struct fam *f)
+{
+	(void)__builtin_counted_by_ref();
+	(void)__builtin_counted_by_ref(f->arr, 1);
+}
+
+/*
+ * check-name: builtin-counted-by-ref-err
+ * check-command: sparse $file
+ *
+ * check-error-start
+builtin-counted-by-ref-err.c:8:39: error: not enough arguments for __bui=
ltin_counted_by_ref
+builtin-counted-by-ref-err.c:9:39: error: too many arguments for __built=
in_counted_by_ref
+ * check-error-end
+ */
diff --git a/validation/builtins-kernel.c b/validation/builtins-kernel.c
new file mode 100644
index 000000000000..05c13f4c1eae
--- /dev/null
+++ b/validation/builtins-kernel.c
@@ -0,0 +1,42 @@
+#if !__has_builtin(__builtin_dynamic_object_size)
+#error "missing __builtin_dynamic_object_size"
+#endif
+
+#if !__has_builtin(__builtin_thread_pointer)
+#error "missing __builtin_thread_pointer"
+#endif
+
+#if !__has_builtin(__builtin_alloca_uninitialized)
+#error "missing __builtin_alloca_uninitialized"
+#endif
+
+#if !__has_builtin(__builtin_counted_by_ref)
+#error "missing __builtin_counted_by_ref"
+#endif
+
+struct fam {
+	int count;
+	char arr[];
+};
+
+static void test_builtins(struct fam *f)
+{
+	char buf[10];
+	void *tp =3D __builtin_thread_pointer();
+	void *al =3D __builtin_alloca_uninitialized(32);
+	void *cbr =3D __builtin_counted_by_ref(f->arr);
+	int is_null =3D (__builtin_counted_by_ref(f->arr) =3D=3D (void *)0);
+	unsigned long sz0 =3D __builtin_dynamic_object_size(buf, 0);
+	unsigned long sz1 =3D __builtin_dynamic_object_size(buf, 1);
+
+	(void)tp;
+	(void)al;
+	(void)cbr;
+	(void)is_null;
+	(void)sz0;
+	(void)sz1;
+}
+
+/*
+ * check-name: builtins-kernel
+ */
