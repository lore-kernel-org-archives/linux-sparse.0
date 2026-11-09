Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256428;
	b=QfYkbWx3o4ZWdJng2XMfTwvecjEbTCL3bXSD30/0CB6TU2zMlTY2cBEllfmpnQ2FkZX5
	 +/temGAr7ZDvTFRXEzBD4wzfnM2vjWMLfb+KtcIo3cGTYxGTFVaLAFVtp3iEYXwGvWYLd
	 a8+O0jxTXLFJAQ0zjxwYzIVYiZtLxcPMYHnstxw4IP6wODm5pDNDG0WvaQWoBEnye83CK
	 oPKcfEYmAbvwj9//OteUdlMog0d+nNGBoWo7k5IDF48Nf446n+4y7GUpJBQw3b2G/qQg8
	 7pJ9PGrH8o0U3xvUOW66nhIMkcLvSyjXzlM3pk5BVzO+9Te6bACDQ0Ye8QSS4qlgcsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256428;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=t9SMhsNzzfNoTY0LrKziwuFNN5/HCDlnFpgNW4Qtme0=;
	b=rBpl/ClD9R0A0UhFZGwQLfpuy971PKT5dYJziFaueq/OfMiutaFKQTa3kkK8bjJpPGSV
	 DYytvwb1GzqdExAiq58D7dkWi3g4POiQPauZJN9VSStdFbwEwQM79z+Vu/v3I+Lu96Y8+
	 vqRkkgO20L4+Un6LqgdYYPtfEblIBBf0cl/pWczfWFFsCxGK+S3v5J5yg7FQfFhl+vZ90
	 6tuLNah515h8D9uqM5ggUaUaOjoRrUTdeQWnFMb1VB7xNDD5RYpWewwPU07PDUctrumyy
	 V4TtV6ZJGWUaV0jHYbWiQg4qenADtCNuKKzy6vRpDXtspYwHuOayyyVAPReDI6KKp2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=cnNBuEYv;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEE606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17CEE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=cnNBuEYv
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMB4zPkz1XMYJc;
	Mon,  9 Nov 2026 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256417; x=1796848418; bh=t9SMh
	sNzzfNoTY0LrKziwuFNN5/HCDlnFpgNW4Qtme0=; b=cnNBuEYvtOHqHnRLMumoK
	u0aFnipPCnmwXDkCaoMEb2JFjiy2v+9LRhpeQ/DD8t8pysE2rxddWZhjtVFv7Rwm
	/IaLK+Hkdssi8rxbmNyRlwd3Kuj+SDx8g3tLliOhdxzX64A6gXmvxSZUFg8GT3gK
	49ZFXGMDZ1aRnMa18D+eJxLnrXzFAGgGnVOeAy0o2o0AJsxYX52JNjau18jAMicl
	rHaN/edpgNI303/FDwTrPY1Fej6fK95//ReLW8Odx/CDqm0/oH3t4HdRt8YpyC5C
	RFNTmx55BTnIVe+Yljn47QCZJh8apoX9Ty5M+jYK4efgd26II6M6E8hjkFxACefs
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id z8_zDnptEalZ; Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM40gQmz1XLwXP;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 53/73] preprocessor: Add support for __has_c_attribute
Date: Mon,  9 Nov 2026 12:32:39 -0800
Message-ID: <20261109203259.362845-54-bvanassche@acm.org>
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

Support the C23 __has_c_attribute preprocessor operator for testing
support for standard C23 and vendor attributes so that preprocessor
conditionals can probe whether specific attributes are supported before
using them.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c                                 | 66 +++++++++++++++++++
 validation/c23-attributes.c                   |  3 +
 validation/preprocessor/c23-has-c-attribute.c | 60 +++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 validation/preprocessor/c23-has-c-attribute.c

diff --git a/pre-process.c b/pre-process.c
index a733927c4c14..aac194cf4c01 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -2364,6 +2364,71 @@ static int handle_nondirective(struct stream *stre=
am, struct token **line, struc
 	return 1;
 }
=20
+static bool expand_has_c_attribute(struct token *token, struct arg *args=
)
+{
+	struct token *arg =3D args[0].expanded;
+	const char *name;
+	const char *val =3D "0";
+	char buf[4096];
+
+	if (token_type(arg) !=3D TOKEN_IDENT) {
+		sparse_error(eof_token(arg) ? token->pos : arg->pos,
+			     "identifier expected");
+		return false;
+	}
+
+	if (match_op(arg->next, ':') && match_op(arg->next->next, ':')) {
+		struct token *attr =3D arg->next->next->next;
+		if (token_type(attr) !=3D TOKEN_IDENT || !eof_token(attr->next)) {
+			sparse_error(eof_token(attr) ? token->pos : attr->pos,
+				     "identifier expected");
+			return false;
+		}
+		if (arg->ident =3D=3D &gnu_ident || arg->ident =3D=3D &__gnu___ident) =
{
+			struct symbol *sym =3D lookup_symbol(attr->ident, NS_KEYWORD);
+			if (sym && sym->op && sym->op->attribute)
+				val =3D "1";
+		}
+		token_type(token) =3D TOKEN_NUMBER;
+		token->number =3D val;
+		return true;
+	}
+
+	if (!eof_token(arg->next)) {
+		sparse_error(arg->next->pos, "expected ')'");
+		return false;
+	}
+
+	name =3D show_ident(arg->ident);
+	if (name[0] =3D=3D '_' && name[1] =3D=3D '_') {
+		size_t len =3D strlen(name);
+		if (len > 4 && name[len - 1] =3D=3D '_' && name[len - 2] =3D=3D '_') {
+			if (len - 4 < sizeof(buf)) {
+				memcpy(buf, name + 2, len - 4);
+				buf[len - 4] =3D '\0';
+				name =3D buf;
+			}
+		}
+	}
+
+	if (!strcmp(name, "deprecated"))
+		val =3D "201904L";
+	else if (!strcmp(name, "fallthrough"))
+		val =3D "201910L";
+	else if (!strcmp(name, "nodiscard"))
+		val =3D "202003L";
+	else if (!strcmp(name, "maybe_unused"))
+		val =3D "202106L";
+	else if (!strcmp(name, "noreturn") || !strcmp(name, "_Noreturn"))
+		val =3D "202202L";
+	else if (!strcmp(name, "reproducible") || !strcmp(name, "unsequenced"))
+		val =3D "202207L";
+
+	token_type(token) =3D TOKEN_NUMBER;
+	token->number =3D val;
+	return true;
+}
+
 static bool expand_has_attribute(struct token *token, struct arg *args)
 {
 	struct token *arg =3D args[0].expanded;
@@ -2528,6 +2593,7 @@ static void init_preprocessor(void)
 		{ "__INCLUDE_LEVEL__", expand_include_level },
 		{ "__has_attribute", NULL, expand_has_attribute },
 		{ "__has_builtin", NULL, expand_has_builtin },
+		{ "__has_c_attribute", NULL, expand_has_c_attribute },
 		{ "__has_extension", NULL, expand_has_extension },
 		{ "__has_feature", NULL, expand_has_feature },
 		{ "__has_include", NULL, NULL },
diff --git a/validation/c23-attributes.c b/validation/c23-attributes.c
index 8b53ce06d0cf..d288574dec1c 100644
--- a/validation/c23-attributes.c
+++ b/validation/c23-attributes.c
@@ -1,3 +1,6 @@
+static_assert(__has_c_attribute(maybe_unused) !=3D 0);
+static_assert(__has_c_attribute(nodiscard) !=3D 0);
+
 [[maybe_unused]] static int unused_var;
=20
 [[nodiscard]] static int get_val(void)
diff --git a/validation/preprocessor/c23-has-c-attribute.c b/validation/p=
reprocessor/c23-has-c-attribute.c
new file mode 100644
index 000000000000..583fe98d0b9e
--- /dev/null
+++ b/validation/preprocessor/c23-has-c-attribute.c
@@ -0,0 +1,60 @@
+#if defined(__has_c_attribute)
+int has_macro =3D 1;
+#endif
+
+#if __has_c_attribute(nodiscard) =3D=3D 202003L
+int has_nodiscard =3D __has_c_attribute(nodiscard);
+#endif
+
+#if __has_c_attribute(__maybe_unused__) =3D=3D 202106L
+int has_maybe_unused =3D __has_c_attribute(__maybe_unused__);
+#endif
+
+#if __has_c_attribute(deprecated) =3D=3D 201904L
+int has_deprecated =3D __has_c_attribute(deprecated);
+#endif
+
+#if __has_c_attribute(fallthrough) =3D=3D 201910L
+int has_fallthrough =3D __has_c_attribute(fallthrough);
+#endif
+
+#if __has_c_attribute(noreturn) =3D=3D 202202L && \
+    __has_c_attribute(_Noreturn) =3D=3D 202202L
+int has_noreturn =3D __has_c_attribute(noreturn);
+#endif
+
+#if __has_c_attribute(reproducible) =3D=3D 202207L && \
+    __has_c_attribute(unsequenced) =3D=3D 202207L
+long has_reproducible =3D __has_c_attribute(reproducible);
+#endif
+
+#if !__has_c_attribute(unknown_attr_12345)
+int no_unknown =3D 1;
+#endif
+
+#if __has_c_attribute(gnu::aligned)
+int has_gnu_aligned =3D __has_c_attribute(gnu::aligned);
+#endif
+
+#if !__has_c_attribute(nodiscard::invalid)
+int no_scoped_std =3D 1;
+#endif
+
+/*
+ * check-name: c23-has-c-attribute
+ * check-command: sparse -std=3Dc23 -E $file
+ *
+ * check-output-start
+
+int has_macro =3D 1;
+int has_nodiscard =3D 202003L;
+int has_maybe_unused =3D 202106L;
+int has_deprecated =3D 201904L;
+int has_fallthrough =3D 201910L;
+int has_noreturn =3D 202202L;
+long has_reproducible =3D 202207L;
+int no_unknown =3D 1;
+int has_gnu_aligned =3D 1;
+int no_scoped_std =3D 1;
+ * check-output-end
+ */
