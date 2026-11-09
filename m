Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256412;
	b=QRqP63KrPFwPrlRXMek9PBxilTULQppjGihjJ32GNbOCz22pC+c9c06evofY9vV5q1Io
	 pWysrcDpCvspwtjF/dlWcTsgoVUsp+NSmAp6cow+MWhl+LTuI32MUpxEm0qLnGxXwKuuI
	 d7RwEdsi/HpvSsVP+9f5T4tSQIObt979WTbgUQo5LK19Cgvi/5qocNowjluN0CEzUCjNO
	 QQqu/Rn02xqWDxWkTYxl89itjnIE4YOgMzXOjGJ1sGI8BMivb6L5Fs0DG4aTueC+vYXld
	 JYs1IO3ilTBa3afQagr8EL5rxYFdy7TzZzOIh6+izCKgnebqIqvD6fbMU98CVOxUSKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1yOZS8U2l+biwusiWs5SYM0mzx70YBBbbbbE0rQof0o=;
	b=RrLTZ6F3U1WoKHtsxvlXp8UJ6X15oJOCng5vUcrA/FGkwEHd8E71KxwgzzzyaFrSvcbq
	 P1rq/mPGQ81z2jdYUgbHXLxL4KIP7yo+/WX1DRvB1Ic0NfkhDFW3C8iNlb8PYd3EB3p1a
	 nH8/gMwWifwG8+KoYXfXOZKcVuqEThXY3/yGVQ9ES1/Ihr+UhnMai22fI51L9sKx7vRiS
	 w/K4r2GRKXkwObYNzdmjqybMMAc8viG5TcdXYccVNu9EQBN9c0ob2KOcMob/qeF0rQ/Gw
	 E1rdwAzrzFPa4VPVeMZe0KxTnPDFwu9xA9jtbYcHQ4dejFxNTE9etPqz5arWr5mR29A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="k/m7q77y";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C9606A321
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C7C9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=k/m7q77y
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLz6kMhz1XMYJS;
	Mon,  9 Nov 2026 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256409; x=1796848410; bh=1yOZS
	8U2l+biwusiWs5SYM0mzx70YBBbbbbE0rQof0o=; b=k/m7q77yeN5w2Ab+DY61z
	xajnij1ZSkm/g7T3uE2bqt/J+IaeZcV6tWUQCGBju9zElrNNdPbX50IVNdob8Bq0
	5SQrq2tJvFAzOVHs0lJk36SjYpVcGH1oBdgSrSN7eI/H0lzUT3hKq6RcrniPfeD8
	AeTnCHpRlIHbc6edf5RL/YhpwosvZWLePumI2lICaKxcD5xz+IZD0/9zRoJyzMES
	g43AZUMi2HPgCX4fl2mI/RSCW5DGRRBCgq4g7IbIIunyTOE0dLqYrm8B8NfbM0HX
	fsAlHfxG0JioNd8d/EeA0I87y5A+iny49sSk7e7ZbtgRzfo/pgY2rUEhsGg7MZjM
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id n8maCtp6S9wd; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLt0M58z1XLyht;
	Mon,  9 Nov 2026 20:33:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 08/73] options, lib: Harden warning buffers and command-line option parsing
Date: Mon,  9 Nov 2026 12:31:54 -0800
Message-ID: <20261109203259.362845-9-bvanassche@acm.org>
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

Fix buffer sizing and command-line option parsing safety in lib.c and
options.c:
- Enlarge the warning buffer in do_warn(), format with vsnprintf(),
  track warning counts without underflowing fmax_warnings, and allocate
  oversized add_pre_buffer() strings dynamically.
- Reject trailing characters and honor OPT_INVERSE in
  handle_switch_setval(), and diagnose missing arguments in -G,
  -include, -imacros, and -MF/-MQ/-MT switches.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 lib.c     | 24 ++++++++++++++++++++----
 options.c | 19 +++++++++++--------
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/lib.c b/lib.c
index e282a4fb4d54..ff8efb157f39 100644
--- a/lib.c
+++ b/lib.c
@@ -128,13 +128,13 @@ static const char *show_stream_name(struct position=
 pos)
=20
 static void do_warn(const char *type, struct position pos, const char * =
fmt, va_list args)
 {
-	static char buffer[512];
+	static char buffer[4096];
=20
 	/* Shut up warnings if position is bad_token.pos */
 	if (pos.type =3D=3D TOKEN_BAD)
 		return;
=20
-	vsprintf(buffer, fmt, args);=09
+	vsnprintf(buffer, sizeof(buffer), fmt, args);
=20
 	fflush(stdout);
 	fprintf(stderr, "%s:%d:%d: %s%s%s\n",
@@ -181,6 +181,7 @@ static void do_error(struct position pos, const char =
* fmt, va_list args)
 void warning(struct position pos, const char * fmt, ...)
 {
 	va_list args;
+	static unsigned int warnings =3D 0;
=20
 	if (Wsparse_error) {
 		va_start(args, fmt);
@@ -194,9 +195,13 @@ void warning(struct position pos, const char * fmt, =
...)
 		return;
 	}
=20
-	if (!--fmax_warnings) {
+	if (++warnings > fmax_warnings) {
+		static int once =3D 0;
 		show_info =3D 0;
+		if (once)
+			return;
 		fmt =3D "too many warnings";
+		once =3D 1;
 	}
=20
 	va_start(args, fmt);
@@ -256,11 +261,22 @@ void add_pre_buffer(const char *fmt, ...)
 	unsigned int size;
 	struct token *begin, *end;
 	char buffer[4096];
+	char *buf =3D buffer;
=20
 	va_start(args, fmt);
 	size =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
-	begin =3D tokenize_buffer(buffer, size, &end);
+	if (size >=3D sizeof(buffer)) {
+		buf =3D malloc(size + 1);
+		if (!buf)
+			die("out of memory");
+		va_start(args, fmt);
+		vsnprintf(buf, size + 1, fmt, args);
+		va_end(args);
+	}
+	begin =3D tokenize_buffer(buf, size, &end);
+	if (buf !=3D buffer)
+		free(buf);
 	*pre_buffer_next =3D begin;
 	pre_buffer_next =3D &end->next;
 }
diff --git a/options.c b/options.c
index 6ee4d878a473..5aa3290e07da 100644
--- a/options.c
+++ b/options.c
@@ -315,7 +315,9 @@ static void handle_onoff_switch_finalize(const struct=
 flag flags[])
=20
 static int handle_switch_setval(const char *arg, const char *opt, const =
struct flag *flag, int options)
 {
-	*(flag->flag) =3D flag->mask;
+	if (*opt !=3D '\0')
+		return 0;
+	*(flag->flag) =3D (options & OPT_INVERSE) ? 0 : flag->mask;
 	return 1;
 }
=20
@@ -548,7 +550,7 @@ static char **handle_switch_f(char *arg, char **next)
=20
 static char **handle_switch_G(char *arg, char **next)
 {
-	if (!strcmp(arg, "G") && *next)
+	if (!strcmp(arg, "G") && next[1])
 		return next + 1; // "-G 0"
 	else
 		return next;     // "-G0" or (bogus) terminal "-G"
@@ -599,11 +601,12 @@ static void add_cmdline_include(char *filename)
=20
 static char **handle_switch_i(char *arg, char **next)
 {
-	if (*next && !strcmp(arg, "include"))
-		add_cmdline_include(*++next);
-	else if (*next && !strcmp(arg, "imacros"))
-		add_cmdline_include(*++next);
-	else if (*next && !strcmp(arg, "isystem")) {
+	if (!strcmp(arg, "include") || !strcmp(arg, "imacros")) {
+		char *path =3D *++next;
+		if (!path)
+			die("missing argument for -%s option", arg);
+		add_cmdline_include(path);
+	} else if (*next && !strcmp(arg, "isystem")) {
 		char *path =3D *++next;
 		if (!path)
 			die("missing argument for -isystem option");
@@ -620,7 +623,7 @@ static char **handle_switch_i(char *arg, char **next)
 static char **handle_switch_M(char *arg, char **next)
 {
 	if (!strcmp(arg, "MF") || !strcmp(arg,"MQ") || !strcmp(arg,"MT")) {
-		if (!*next)
+		if (!next[1])
 			die("missing argument for -%s option", arg);
 		return next + 1;
 	}
