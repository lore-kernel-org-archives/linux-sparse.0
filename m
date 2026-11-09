Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256412;
	b=H45hgnpJC5DsUGHE3ZOPZO/irK0P2WJ1iN46Ddl0Iyaa9AF3+2cLzZtC0dLH6wR4uemv
	 Fs5+qaoDcfpADowS04BuAgEJaxzQ+YGd8c68rquAPPdmIeY2L2Tyb5J673y1ukl0iQ5VJ
	 PSZe01u+wmqmA5QrUAwgd3soiSd0QPpvVQQtdPPjPZiM2ig8JBxGFUXZpt19P2R03czaV
	 C2YAenqt8XLvHab1QPlbG1nGhPyxq2K4iqYTMm1Cc36hYefemCkyWqXmIaN6H/L28MxF7
	 MFEmcv7i2oKWo6qLsAjwQL4+pCrKBRxhxY2pCD+7d9d1ZNZ4RsPpJY3Uadho1Do8WtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=OxvJgIGcUjVmGXFn6/gtvk8IIpDNmbsUC+xGWqriHAc=;
	b=HJnGQ5ma5xU/oTcWdP6xBOdkWdjlj2jpl7Z/UOgLQFXCxl9KhdIFgQ+j547Y+paFkOw8
	 jpY5UfZj9YfAtGXqRpFzxqh1QmO06W1da5mKyy0qyNdMxp5z0Ze2xVlkdiwPCwMV6n/gg
	 NX8j1FpTmZmV4BfqAr4ARoDHzHNdHAzpQNtz/ruLoefMvxX+OUzb7wq7ynkWRdQQD/QCj
	 oZtnyLqsFpZqBu57cpsKeNK2JvfyG/qL1yzhsZ3qe/UwxI962tVPjtnRvMwKSeJBfHWGi
	 tbHcUb5vQkp5+WbM4IJaWEYcgQ7xiyZPX2ZPp91XoZhgJLh1MrtDa4dVgjTBoBjBksg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wmMnDHUd;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2D606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F2D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=wmMnDHUd
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM00vN7z1XMYJX;
	Mon,  9 Nov 2026 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256409; x=1796848410; bh=OxvJg
	IGcUjVmGXFn6/gtvk8IIpDNmbsUC+xGWqriHAc=; b=wmMnDHUd2rT5U8ARyNOfh
	mvjfwXvocOxvoyMRFRe9R0QTrKICgygyR0aT0AkBeqfssZ0T7sRAMXu2nCEjvY42
	arXCGpeaa/boJXaER2ABZwZLemrisj2TTrUd5g0qI0paPbgtG1uSWDs6j6knCcwy
	bAS3QQUq28E/CEgdqLm4juQ9sw3EvvlDr8G/ikCiVKlMFCUZcz4L3aWzUSWvCDmr
	Zq0hAtCgxNi3hVg3KDdp1jmv75851DlWo03ncMrlIR5+ANl60koCGxMEldLjXFa8
	7j3hnx9d9S88PTQ5UOmS7/visewj1SpCJSYKQihjEr69DCkXW486jxyv2GrVC+Yf
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ctfly8dMfUpj; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLs4LSBz1XLyhl;
	Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 06/73] tokenize: Support 4096-byte identifiers and fix escape bounds
Date: Mon,  9 Nov 2026 12:31:52 -0800
Message-ID: <20261109203259.362845-7-bvanassche@acm.org>
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

Support long identifiers and harden character escape and token handling
in char.c, token.h, and tokenize.c:
- Widen struct ident's len field to unsigned short and enlarge identifier
  buffers in get_one_identifier() and show_ident() to 4096 bytes so
  identifiers longer than 255 bytes are not truncated.
- Guard parse_escape() against reading past the end of the buffer on a
  trailing backslash and cast input bytes to unsigned char.
- Format TOKEN_GNU_KLUDGE in show_token() and quote_token(), and use
  logical && when checking stream->pos && Wnewline_eof.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 char.c     |  5 +++--
 token.h    |  2 +-
 tokenize.c | 29 +++++++++++++++++------------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/char.c b/char.c
index 730ae3f5d8ca..1f6eb1f6be83 100644
--- a/char.c
+++ b/char.c
@@ -8,14 +8,15 @@
=20
 static const char *parse_escape(const char *p, unsigned *val, const char=
 *end, int bits, struct position pos)
 {
-	unsigned c =3D *p++;
+	unsigned c =3D (unsigned char)*p++;
 	unsigned d;
 	if (c !=3D '\\') {
 		*val =3D c;
 		return p;
 	}
=20
-	c =3D *p++;
+	if (p < end)
+		c =3D (unsigned char)*p++;
 	switch (c) {
 	case 'a': c =3D '\a'; break;
 	case 'b': c =3D '\b'; break;
diff --git a/token.h b/token.h
index 9000e0cb6574..8c8a496bee89 100644
--- a/token.h
+++ b/token.h
@@ -70,7 +70,7 @@ extern int *hash_stream(const char *name);
 struct ident {
 	struct ident *next;	/* Hash chain of identifiers */
 	struct symbol *symbols;	/* Pointer to semantic meaning list */
-	unsigned char len;	/* Length of identifier name */
+	unsigned short len;	/* Length of identifier name */
 	unsigned char tainted:1,
 	              reserved:1,
 		      keyword:1;
diff --git a/tokenize.c b/tokenize.c
index 54ea348cab91..76b0278925ed 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -98,14 +98,14 @@ const char *show_special(int val)
=20
 const char *show_ident(const struct ident *ident)
 {
-	static char buff[4][256];
+	static char buff[4][4097];
 	static int n;
 	char *buffer;
=20
 	if (!ident)
 		return "<noident>";
 	buffer =3D buff[3 & ++n];
-	sprintf(buffer, "%.*s", ident->len, ident->name);
+	snprintf(buffer, sizeof(buff[0]), "%.*s", ident->len, ident->name);
 	return buffer;
 }
=20
@@ -230,11 +230,11 @@ const char *show_token(const struct token *token)
 			token->string->length - 1, 'L', '"');
=20
 	case TOKEN_STREAMBEGIN:
-		sprintf(buffer, "<beginning of '%s'>", stream_name(token->pos.stream))=
;
+		snprintf(buffer, sizeof(buffer), "<beginning of '%s'>", stream_name(to=
ken->pos.stream));
 		return buffer;
=20
 	case TOKEN_STREAMEND:
-		sprintf(buffer, "<end of '%s'>", stream_name(token->pos.stream));
+		snprintf(buffer, sizeof(buffer), "<end of '%s'>", stream_name(token->p=
os.stream));
 		return buffer;
=20
 	case TOKEN_UNTAINT:
@@ -245,6 +245,9 @@ const char *show_token(const struct token *token)
 		sprintf(buffer, "<argcnt>");
 		return buffer;
=20
+	case TOKEN_GNU_KLUDGE:
+		return ",";
+
 	default:
 		sprintf(buffer, "unhandled token type '%d' ", token_type(token));
 		return buffer;
@@ -287,6 +290,8 @@ const char *quote_token(const struct token *token)
 	case TOKEN_WIDE_STRING:=20
 		return quote_char(token->string->data,
 			token->string->length - 1, 'L', '"');
+	case TOKEN_GNU_KLUDGE:
+		return ",";
 	default:
 		sprintf(buffer, "unhandled token type '%d' ", token_type(token));
 		return buffer;
@@ -427,7 +432,7 @@ got_eof:
 		c =3D '\\';
 		goto out;
 	}
-	if (stream->pos & Wnewline_eof)
+	if (stream->pos && Wnewline_eof)
 		warning(stream_pos(stream), "no newline at end of file");
 	else if (spliced)
 		warning(stream_pos(stream), "backslash-newline at end of file");
@@ -860,7 +865,7 @@ static struct ident *create_hashed_ident(const char *=
name, int len, unsigned lon
=20
 	p =3D &hash_table[hash];
 	while ((ident =3D *p) !=3D NULL) {
-		if (ident->len =3D=3D (unsigned char) len) {
+		if (ident->len =3D=3D (unsigned short) len) {
 			if (memcmp(name, ident->name, len) !=3D 0)
 				goto next;
=20
@@ -919,7 +924,7 @@ static int get_one_identifier(int c, stream_t *stream=
)
 	struct token *token;
 	struct ident *ident;
 	unsigned long hash;
-	char buf[256];
+	char buf[4096];
 	int len =3D 1;
 	int next;
=20
@@ -929,11 +934,11 @@ static int get_one_identifier(int c, stream_t *stre=
am)
 		next =3D nextchar(stream);
 		if (!(cclass[next + 1] & (Letter | Digit)))
 			break;
-		if (len >=3D sizeof(buf))
-			break;
-		hash =3D ident_hash_add(hash, next);
-		buf[len] =3D next;
-		len++;
+		if (len < sizeof(buf)) {
+			hash =3D ident_hash_add(hash, next);
+			buf[len] =3D next;
+			len++;
+		}
 	};
 	if (cclass[next + 1] & Quote) {
 		if (len =3D=3D 1 && buf[0] =3D=3D 'L') {
