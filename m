Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256429;
	b=vKWQpC4ptkI+bQtO/bM6z3CjRjfYGMRYZx3h1++q7xajdmk76/5X6q9Al0eLWhpA+4vc
	 d23ST8n6HCe5SdJ5knSs9nNtcCY7Bb7146ybzSTyEjZHTPEnieZqD4tFt2L5dfp9Yw8oj
	 u069Dq/MUFKbp9YeDT+p6X2G13lvpl5tANUwDv7P9+ZCRpSquhklmx5UtBVMgOI5SrUHu
	 eWzN1kSYJPO75Ng9UU4ocrxnI1IyG8VfF0grx6h7DZHI3tkfG6e8/W8n1pKXKrVzhWEMN
	 0EC10fpGdS0BUPv1amnSAVK9DqbahZ5strw3Q+vv1YRrWXX+pE8jNRe1uZY53z3f2Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=kofcE5CnMIBedP2uVX+ajyVnCp68q5w4jXgIWvhfTY0=;
	b=EhOHaWH/q+lzob3YcQQ8ZBWOgNBgkF0u85Vk4rpn7F4t9DRD1khuGjhICDGOKeuJVLZT
	 TM7dY/U6k/is/s9BhgMtwI3AdQOMsNseidrD2mfKuzbeqJq8F4DQJX+T+BDe9vQpXow6e
	 7nukS629jmSyDVNoJdrFjd/RtPSHP2uulSxC3YuyFnqktjrK5Pz/NZS9ttgzPpEG1mZEL
	 wRP50vLMIu+dsvnuP9oQ4B1HO039jne4ls0o03Vbnz9bYMlW5mxqtrxBHzR2AIGanwUVj
	 sTp/KdizkAFe3AqXC1TESAxrhj3pcZIvIlup2p3ToLs2b+3xN7fIlACJ+cjjFtcbdxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=VB7KITfo;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA57C606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA57C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=VB7KITfo
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMC4M9nz1XLwXP;
	Mon,  9 Nov 2026 20:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=kofcE
	5CnMIBedP2uVX+ajyVnCp68q5w4jXgIWvhfTY0=; b=VB7KITfoLGAMck3TKRXnh
	c8k87n+REOjFyPfLb3+JztN4s/sdO9Y+0nEvy0msON8k55dTrfqNXQpu3y7aNsne
	0ddNuwM2eWBy93dH2Cogjj6mNFAAvdVdbToI/6keXe+dmc6SabkdX6SxkJ/siTkD
	UW5lwgozUvEtm/PfAxHqyvjVGQw+9jOetJJLB+l69ZqPTrc2ySWGRLbLLBRBuhob
	abnvJ2jbOiTQfrPJMMnzn7XV5hP5se3nkWRstnAJFuhOD99GVhd0PFNZWQ6D5Scm
	MzIVFpd0jL2cnna2KzOVuVjSBaMcC0EyQIyB3PGS9AbU6lv+TZ0WuF83tTotJGu2
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3yxDox-OSJ9L; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM22H2Vz1XMFx7;
	Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 45/73] c23: Add support for digit separators in numeric literals
Date: Mon,  9 Nov 2026 12:32:31 -0800
Message-ID: <20261109203259.362845-46-bvanassche@acm.org>
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

Allow single quotes (') between digits in preprocessing numbers and
strip them before parsing integer and floating-point values in
expression.c to support C23 digit separators (WG14 N2626) and emit a
pedantic warning in pre-C23 modes.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 expression.c                               | 165 +++++++++++++++++++++
 tokenize.c                                 |  35 ++++-
 validation/c23-digit-separators-error.c    |  36 +++++
 validation/c23-digit-separators-pedantic.c |  12 ++
 validation/c23-digit-separators.c          |  29 ++++
 5 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 validation/c23-digit-separators-error.c
 create mode 100644 validation/c23-digit-separators-pedantic.c
 create mode 100644 validation/c23-digit-separators.c

diff --git a/expression.c b/expression.c
index da2c14b458db..1b04d977a2d5 100644
--- a/expression.c
+++ b/expression.c
@@ -258,6 +258,157 @@ static unsigned long long parse_num(const char *npt=
r, char **end)
 	return strtoull(nptr, end, 0);
 }
=20
+static int is_digit_for_base(int c, int base)
+{
+	if (base =3D=3D 2)
+		return c =3D=3D '0' || c =3D=3D '1';
+	if (base =3D=3D 8)
+		return c >=3D '0' && c <=3D '7';
+	if (base =3D=3D 16)
+		return isxdigit((unsigned char)c);
+	return isdigit((unsigned char)c);
+}
+
+static int validate_digit_separators(struct expression *expr, const char=
 *str)
+{
+	enum {
+		NUM_INT,
+		NUM_FRAC,
+		NUM_EXP_SIGN,
+		NUM_EXP,
+		NUM_SUFFIX,
+	} state =3D NUM_INT;
+	int is_hex =3D (str[0] =3D=3D '0' && (str[1] =3D=3D 'x' || str[1] =3D=3D=
 'X'));
+	int is_bin =3D (str[0] =3D=3D '0' && (str[1] =3D=3D 'b' || str[1] =3D=3D=
 'B'));
+	int is_oct =3D (str[0] =3D=3D '0' && !is_hex && !is_bin &&
+		      strchr(str, '.') =3D=3D NULL && strchr(str, 'e') =3D=3D NULL &&
+		      strchr(str, 'E') =3D=3D NULL);
+	int base =3D is_hex ? 16 : is_bin ? 2 : is_oct ? 8 : 10;
+	int in_digits =3D 0;
+	int i =3D (is_hex || is_bin) ? 2 : 0;
+
+	for (; str[i]; i++) {
+		char c =3D str[i];
+
+		if (c =3D=3D '\'') {
+			char prev =3D i > 0 ? str[i - 1] : 0;
+			char next =3D str[i + 1];
+
+			if (prev =3D=3D '\'' || next =3D=3D '\'') {
+				sparse_error(expr->pos,
+					     "adjacent digit separators");
+				return 0;
+			}
+			if (i =3D=3D 2 && (is_hex || is_bin)) {
+				sparse_error(
+					expr->pos,
+					"digit separator after base indicator");
+				return 0;
+			}
+			if (prev =3D=3D '.' || next =3D=3D '.') {
+				sparse_error(
+					expr->pos,
+					"digit separator adjacent to decimal point");
+				return 0;
+			}
+			if (state =3D=3D NUM_EXP_SIGN ||
+			    (state !=3D NUM_SUFFIX &&
+			     ((is_hex && (next =3D=3D 'p' || next =3D=3D 'P')) ||
+			      (!is_hex && (next =3D=3D 'e' || next =3D=3D 'E')))) ||
+			    (!in_digits && state =3D=3D NUM_EXP)) {
+				sparse_error(
+					expr->pos,
+					"digit separator adjacent to exponent");
+				return 0;
+			}
+			if (state =3D=3D NUM_SUFFIX || !in_digits ||
+			    !is_digit_for_base(next, base)) {
+				sparse_error(
+					expr->pos,
+					"digit separator outside digit sequence");
+				return 0;
+			}
+			in_digits =3D 0;
+			continue;
+		}
+
+		switch (state) {
+		case NUM_INT:
+			if (is_digit_for_base(c, base)) {
+				in_digits =3D 1;
+			} else if (c =3D=3D '.' && (base =3D=3D 10 || base =3D=3D 16)) {
+				state =3D NUM_FRAC;
+				in_digits =3D 0;
+			} else if ((base =3D=3D 10 && (c =3D=3D 'e' || c =3D=3D 'E')) ||
+				   (base =3D=3D 16 && (c =3D=3D 'p' || c =3D=3D 'P'))) {
+				state =3D NUM_EXP_SIGN;
+				base =3D 10;
+				in_digits =3D 0;
+			} else {
+				state =3D NUM_SUFFIX;
+				in_digits =3D 0;
+			}
+			break;
+		case NUM_FRAC:
+			if (is_digit_for_base(c, base)) {
+				in_digits =3D 1;
+			} else if ((base =3D=3D 10 && (c =3D=3D 'e' || c =3D=3D 'E')) ||
+				   (base =3D=3D 16 && (c =3D=3D 'p' || c =3D=3D 'P'))) {
+				state =3D NUM_EXP_SIGN;
+				base =3D 10;
+				in_digits =3D 0;
+			} else {
+				state =3D NUM_SUFFIX;
+				in_digits =3D 0;
+			}
+			break;
+		case NUM_EXP_SIGN:
+			state =3D NUM_EXP;
+			if (c =3D=3D '+' || c =3D=3D '-') {
+				in_digits =3D 0;
+			} else if (isdigit((unsigned char)c)) {
+				in_digits =3D 1;
+			} else {
+				state =3D NUM_SUFFIX;
+				in_digits =3D 0;
+			}
+			break;
+		case NUM_EXP:
+			if (isdigit((unsigned char)c)) {
+				in_digits =3D 1;
+			} else {
+				state =3D NUM_SUFFIX;
+				in_digits =3D 0;
+			}
+			break;
+		case NUM_SUFFIX:
+			break;
+		}
+	}
+	return 1;
+}
+
+static const char *strip_digit_separators(const char *str)
+{
+	size_t len;
+	char *buf, *dst;
+
+	if (!strchr(str, '\''))
+		return str;
+
+	len =3D strlen(str);
+	buf =3D __alloc_bytes(len + 1);
+	dst =3D buf;
+
+	while (*str) {
+		if (*str !=3D '\'')
+			*dst++ =3D *str;
+		str++;
+	}
+	*dst =3D '\0';
+	return buf;
+}
+
 static void get_number_value(struct expression *expr, struct token *toke=
n)
 {
 	const char *str =3D token->number;
@@ -268,6 +419,19 @@ static void get_number_value(struct expression *expr=
, struct token *token)
 	int try_unsigned =3D 1;
 	int bits;
=20
+	if (strchr(str, '\'')) {
+		if (!validate_digit_separators(expr, str)) {
+			expr->type =3D EXPR_VALUE;
+			expr->flags =3D CEF_SET_ICE;
+			expr->ctype =3D &bad_ctype;
+			return;
+		}
+		if (standard < STANDARD_C23 && Wpedantic)
+			warning(expr->pos,
+				"ISO C does not support digit separators before C23");
+		str =3D strip_digit_separators(str);
+	}
+
 	errno =3D 0;
 	value =3D parse_num(str, &end);
 	if (end =3D=3D str)
@@ -385,6 +549,7 @@ Float:
 Enoint:
 	sparse_error(expr->pos, "constant %s is not a valid number", show_token=
(token));
 	expr->type =3D EXPR_VALUE;
+	expr->flags =3D CEF_SET_ICE;
 	expr->value =3D 0;
 	expr->ctype =3D &int_ctype;
 }
diff --git a/tokenize.c b/tokenize.c
index 76b0278925ed..b0d4059c8782 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -50,6 +50,7 @@ typedef struct {
 	int fd, offset, size;
 	int pos, line, nr;
 	int newline, whitespace;
+	int pushed_char;
 	struct token **tokenlist;
 	struct token *token;
 	unsigned char *buffer;
@@ -446,8 +447,14 @@ got_eof:
  */
 static inline int nextchar(stream_t *stream)
 {
-	int offset =3D stream->offset;
+	int offset;
=20
+	if (stream->pushed_char !=3D -2) {
+		int c =3D stream->pushed_char;
+		stream->pushed_char =3D -2;
+		return c;
+	}
+	offset =3D stream->offset;
 	if (offset < stream->size) {
 		int c =3D stream->buffer[offset++];
 		static const char special[256] =3D {
@@ -462,6 +469,19 @@ static inline int nextchar(stream_t *stream)
 	return nextchar_slow(stream);
 }
=20
+static int peekchar(stream_t *stream)
+{
+	if (stream->pushed_char !=3D -2)
+		return stream->pushed_char;
+	if (stream->offset < stream->size) {
+		int c =3D stream->buffer[stream->offset];
+		if (c !=3D '\r' && c !=3D '\\')
+			return c;
+	}
+	stream->pushed_char =3D nextchar_slow(stream);
+	return stream->pushed_char;
+}
+
 struct token eof_token_entry;
=20
 static struct token *mark_eof(stream_t *stream)
@@ -558,8 +578,18 @@ static int get_one_number(int c, int next, stream_t =
*stream)
 	*p++ =3D c;
 	for (;;) {
 		long class =3D  cclass[next + 1];
-		if (!(class & (Dot | Digit | Letter)))
+		if (!(class & (Dot | Digit | Letter))) {
+			if (next =3D=3D '\'') {
+				int after =3D peekchar(stream);
+				if (cclass[after + 1] & (Digit | Letter)) {
+					if (p !=3D buffer_end)
+						*p++ =3D next;
+					next =3D nextchar(stream);
+					continue;
+				}
+			}
 			break;
+		}
 		if (p !=3D buffer_end)
 			*p++ =3D next;
 		next =3D nextchar(stream);
@@ -987,6 +1017,7 @@ static struct token *setup_stream(stream_t *stream, =
int idx, int fd,
 	stream->offset =3D 0;
 	stream->size =3D buf_size;
 	stream->buffer =3D buf;
+	stream->pushed_char =3D -2;
=20
 	begin =3D alloc_token(stream);
 	token_type(begin) =3D TOKEN_STREAMBEGIN;
diff --git a/validation/c23-digit-separators-error.c b/validation/c23-dig=
it-separators-error.c
new file mode 100644
index 000000000000..10ddeffcd99c
--- /dev/null
+++ b/validation/c23-digit-separators-error.c
@@ -0,0 +1,36 @@
+int a =3D 1''0;
+int b =3D 0x'1;
+int b2 =3D 0b'1;
+int c =3D 1'u;
+int c2 =3D 123'u;
+double d =3D 1.'0;
+double e =3D 1'.';
+double f =3D 1e'0;
+double g =3D 1'e0;
+double h =3D 1e+'0;
+float i =3D 0x1p'0f;
+float j =3D 0x1.0p1'f;
+float k =3D 1.0'f;
+
+/*
+ * check-name: c23-digit-separators-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+c23-digit-separators-error.c:1:10: error: Expected ; at end of declarati=
on
+c23-digit-separators-error.c:1:10: error: got ''
+c23-digit-separators-error.c:2:9: error: digit separator after base indi=
cator
+c23-digit-separators-error.c:3:10: error: digit separator after base ind=
icator
+c23-digit-separators-error.c:4:9: error: digit separator outside digit s=
equence
+c23-digit-separators-error.c:5:10: error: digit separator outside digit =
sequence
+c23-digit-separators-error.c:6:12: error: digit separator adjacent to de=
cimal point
+c23-digit-separators-error.c:7:13: error: Expected ; at end of declarati=
on
+c23-digit-separators-error.c:7:13: error: got '.'
+c23-digit-separators-error.c:8:12: error: digit separator adjacent to ex=
ponent
+c23-digit-separators-error.c:9:12: error: digit separator adjacent to ex=
ponent
+c23-digit-separators-error.c:10:12: error: digit separator adjacent to e=
xponent
+c23-digit-separators-error.c:11:11: error: digit separator adjacent to e=
xponent
+c23-digit-separators-error.c:12:11: error: digit separator outside digit=
 sequence
+c23-digit-separators-error.c:13:11: error: digit separator outside digit=
 sequence
+ * check-error-end
+ */
diff --git a/validation/c23-digit-separators-pedantic.c b/validation/c23-=
digit-separators-pedantic.c
new file mode 100644
index 000000000000..d1f374d805e1
--- /dev/null
+++ b/validation/c23-digit-separators-pedantic.c
@@ -0,0 +1,12 @@
+int a =3D 1'000;
+double b =3D 1'0.5;
+
+/*
+ * check-name: c23-digit-separators-pedantic
+ * check-command: sparse -std=3Dc17 -Wpedantic -Wno-decl $file
+ *
+ * check-error-start
+c23-digit-separators-pedantic.c:1:9: warning: ISO C does not support dig=
it separators before C23
+c23-digit-separators-pedantic.c:2:12: warning: ISO C does not support di=
git separators before C23
+ * check-error-end
+ */
diff --git a/validation/c23-digit-separators.c b/validation/c23-digit-sep=
arators.c
new file mode 100644
index 000000000000..65af74822cb6
--- /dev/null
+++ b/validation/c23-digit-separators.c
@@ -0,0 +1,29 @@
+#if 0
+0' '
+1'+'2
+#endif
+
+#if 1'000 + 2'000 =3D=3D 3'000
+int pp =3D 1;
+#endif
+
+_Static_assert(1'000'000 =3D=3D 1000000, "dec");
+_Static_assert(0xdead'beef =3D=3D 0xdeadbeef, "hex");
+_Static_assert(0XCAFE'BABE =3D=3D 0xCAFEBABE, "hex upper");
+_Static_assert(0b1010'0101 =3D=3D 0xa5, "bin");
+_Static_assert(0B1111'0000 =3D=3D 0xf0, "bin upper");
+_Static_assert(0'123'456 =3D=3D 0123456, "oct");
+_Static_assert(1'000ULL =3D=3D 1000ULL, "ull");
+
+static int a =3D 1'000'000;
+static unsigned int b =3D 0xdead'beef;
+static int c =3D 0b1010'0101;
+static int d =3D 0'123'456;
+static double e =3D 1'000.000'1;
+static double f =3D 1'2.3'4e1'0;
+static float g =3D 0x1'a.b'cp1'0f;
+
+/*
+ * check-name: c23-digit-separators
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ */
