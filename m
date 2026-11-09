Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256438;
	b=wVzqi0NbMKhIOju56S66Z97VHXbqsQWfUEHv2Lz8urGKouzClxd5n0z9QrAwME1dRzAB
	 8cWJ+u0Wjp8/eDxsU30Xq1Nz2GdK8VF3v3J3OnR7hWAexrOE4t5pmHlWzK+BeQPzoz0ax
	 ShwlDSBTXex6aoUey1A9S7QnlE6eZqVTW7+oI6p80TUk93AeNdzGtCuR5kGxPi4yCgShN
	 sp1Rr8wrSBqBwf0fbLjZWizCxWWIPMVgm4QDU4qSFQJzpv4vbUaGgScCyyJ4ERz2sdBX8
	 agRKeSElNOSL3KJAj8SM0EvZQCMobc4DYJTKZ1ZelcxNwUpBU5y/j/2XBRSQlP7nnqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=VP4jJCPzQE5lk6R6FyjYFtZcTh2uDlCjstApDWc64y4=;
	b=LKG9MhQMitk5hiHzPwHH0+VuTt8lxm3Y0Vz/mq1masOpUor9KJI8JT+SXl6elcLd02CU
	 KQL/+pvzJbXJH39lVridGsnU9DgPWTbwSgZu6PRAbIxsKuJwPaJXLtP32C2V4WAOKhHpH
	 OM7rvroeS5TEpg5NnzgwJpEloq5tYJhBDp6E0ZmigqoWoAwQ/macB3k1h2GqW+BtfqI7h
	 Ijl4pTiKHR4bC+KzuEzVkJAahIY8DBtCdHhF3JiH5iyrxo6p60iXMz9oH6KmKdpiS9Q6O
	 TUfY3g8YckXjrdLp7YVcWtdynurIr6ccp7FcWY4GAYpwk/htoe+dUvJNjkJxQnJ8nXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tOPkanzw;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC9606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40BC9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=tOPkanzw
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhML1Bdfz1XMYJT;
	Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=VP4jJ
	CPzQE5lk6R6FyjYFtZcTh2uDlCjstApDWc64y4=; b=tOPkanzwxDqaPj3+n3Zc6
	4wz4CsSq/qHaUaM4BdnzD5qOrt7F0qiiMqFxZCCtkQ1ep/Kg41KFMHqO4yLafaVB
	ZAdU/nvTSGcQAMtS1lMfEK6CkxNwH7tyg3kVIxOu3DAy8dznGSitzOoDzmQBra3R
	SeVs5NCYKNllcMQgpsZm7kNZcKvVsV56WfpBu8ZRUhMM+JyZNac696AHZAp0/q0c
	7h98eMPsphmMIoX9sRcfTZyf9/n4/9pkRE5Fx3P+105cKtilztcPFifY1A2TLXT+
	nIT/aj2lzpMcwYACDo2ZopGYXQEeXlMuClhwV0IwXpTwxxbeQGdMeExNpnXF42fV
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vSPEnZzUJJZi; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM470Y6z1XMYJM;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 57/73] c23: Add support for u8 character constants and string literals
Date: Mon,  9 Nov 2026 12:32:43 -0800
Message-ID: <20261109203259.362845-58-bvanassche@acm.org>
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

Support C23 UTF-8 character constants (u8'c') and UTF-8 string literals
(u8"...") with unsigned char (char8_t) element type per ISO C23 6.4.4.4
and 6.4.5:
- Type u8"..." literals (including narrow + u8"" concatenations) as
  arrays of unsigned char in C23 mode while preserving char[] typing in
  C11/C17, and diagnose pointer signedness mismatches with char * in C23.
- Parse \uXXXX and \UXXXXXXXX universal character names in character and
  string literals, reject u8"" concatenation with wide strings, and emit
  errors on multi-byte or multi-character u8'...' constants.
- Warn under -Wpedantic when u8 character constants are used before C23.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 char.c                            | 111 ++++++++++++++++++++++++++++--
 evaluate.c                        |   7 +-
 expression.c                      |  15 ++--
 expression.h                      |   3 +-
 ident-list.h                      |   3 +-
 pre-process.c                     |  21 +++++-
 token.h                           |   6 ++
 tokenize.c                        | 102 ++++++++++++++++++---------
 validation/c23-u8-char-error.c    |  16 +++++
 validation/c23-u8-char-pedantic.c |  10 +++
 validation/c23-u8-char-warn.c     |  14 ++++
 validation/c23-u8-char.c          |  37 ++++++++++
 12 files changed, 296 insertions(+), 49 deletions(-)
 create mode 100644 validation/c23-u8-char-error.c
 create mode 100644 validation/c23-u8-char-pedantic.c
 create mode 100644 validation/c23-u8-char-warn.c
 create mode 100644 validation/c23-u8-char.c

diff --git a/char.c b/char.c
index 1f6eb1f6be83..a0776b560e29 100644
--- a/char.c
+++ b/char.c
@@ -6,6 +6,54 @@
 #include "expression.h"
 #include "char.h"
=20
+static const char *parse_ucn(const char *p, const char *end, int digits,
+			     unsigned *cp, struct position pos)
+{
+	unsigned val =3D 0;
+	int i;
+
+	for (i =3D 0; i < digits; i++) {
+		unsigned d;
+		if (p >=3D end || (d =3D hexval(*p)) > 15) {
+			sparse_error(pos, "incomplete universal character name");
+			*cp =3D 0;
+			return p;
+		}
+		val =3D (val << 4) + d;
+		p++;
+	}
+	if ((val >=3D 0xd800 && val <=3D 0xdfff) || val > 0x10ffff) {
+		sparse_error(pos, "invalid universal character name");
+		val =3D 0;
+	}
+	*cp =3D val;
+	return p;
+}
+
+static int encode_utf8(unsigned cp, char out[4])
+{
+	if (cp <=3D 0x7f) {
+		out[0] =3D cp;
+		return 1;
+	}
+	if (cp <=3D 0x7ff) {
+		out[0] =3D 0xc0 | (cp >> 6);
+		out[1] =3D 0x80 | (cp & 0x3f);
+		return 2;
+	}
+	if (cp <=3D 0xffff) {
+		out[0] =3D 0xe0 | (cp >> 12);
+		out[1] =3D 0x80 | ((cp >> 6) & 0x3f);
+		out[2] =3D 0x80 | (cp & 0x3f);
+		return 3;
+	}
+	out[0] =3D 0xf0 | (cp >> 18);
+	out[1] =3D 0x80 | ((cp >> 12) & 0x3f);
+	out[2] =3D 0x80 | ((cp >> 6) & 0x3f);
+	out[3] =3D 0x80 | (cp & 0x3f);
+	return 4;
+}
+
 static const char *parse_escape(const char *p, unsigned *val, const char=
 *end, int bits, struct position pos)
 {
 	unsigned c =3D (unsigned char)*p++;
@@ -26,6 +74,11 @@ static const char *parse_escape(const char *p, unsigne=
d *val, const char *end, i
 	case 'f': c =3D '\f'; break;
 	case 'r': c =3D '\r'; break;
 	case 'e': c =3D '\e'; break;
+	case 'u':
+	case 'U':
+		p =3D parse_ucn(p, end, c =3D=3D 'u' ? 4 : 8, &c, pos);
+		*val =3D c;
+		return p;
 	case 'x': {
 		unsigned mask =3D -(1U << (bits - 4));
 		for (c =3D 0; p < end; c =3D (c << 4) + d) {
@@ -75,6 +128,7 @@ void get_char_constant(struct token *token, unsigned l=
ong long *val)
 	switch (type) {
 	case TOKEN_CHAR:
 	case TOKEN_WIDE_CHAR:
+	case TOKEN_UTF8_CHAR:
 		p =3D token->string->data;
 		end =3D p + token->string->length - 1;
 		if (end =3D=3D p) {
@@ -86,14 +140,34 @@ void get_char_constant(struct token *token, unsigned=
 long long *val)
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 		end =3D p + type - TOKEN_CHAR;
 		break;
-	default:
+	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		end =3D p + type - TOKEN_WIDE_CHAR;
+		break;
+	default:
+		end =3D p + type - TOKEN_UTF8_CHAR;
+		break;
 	}
 	p =3D parse_escape(p, &v, end,
-			type < TOKEN_WIDE_CHAR ? bits_in_char : wchar_ctype->bit_size, token-=
>pos);
-	if (p !=3D end)
+			 (type >=3D TOKEN_WIDE_CHAR &&
+			  type <=3D TOKEN_WIDE_CHAR_EMBEDDED_3) ?
+				 wchar_ctype->bit_size :
+				 bits_in_char,
+			 token->pos);
+	if (type >=3D TOKEN_UTF8_CHAR && type <=3D TOKEN_UTF8_CHAR_EMBEDDED_3) =
{
+		if (p !=3D end || v > 0xff ||
+		    (token->embedded[0] =3D=3D '\\' &&
+		     (token->embedded[1] =3D=3D 'u' || token->embedded[1] =3D=3D 'U') =
&&
+		     v > 0x7f) ||
+		    (type =3D=3D TOKEN_UTF8_CHAR && token->string->data[0] =3D=3D '\\'=
 &&
+		     (token->string->data[1] =3D=3D 'u' ||
+		      token->string->data[1] =3D=3D 'U') &&
+		     v > 0x7f))
+			sparse_error(token->pos,
+				     "multi-character UTF-8 character constant");
+	} else if (p !=3D end) {
 		warning(token->pos,
 			"multi-character character constant");
+	}
 	*val =3D v;
 }
=20
@@ -103,6 +177,7 @@ struct token *get_string_constant(struct token *token=
, struct expression *expr)
 	struct token *next =3D token->next, *done =3D NULL;
 	int stringtype =3D token_type(token);
 	int is_wide =3D stringtype =3D=3D TOKEN_WIDE_STRING;
+	int is_utf8 =3D stringtype =3D=3D TOKEN_UTF8_STRING;
 	static char buffer[MAX_STRING];
 	int len =3D 0;
 	int bits;
@@ -112,6 +187,12 @@ struct token *get_string_constant(struct token *toke=
n, struct expression *expr)
 		switch (token_type(next)) {
 		case TOKEN_WIDE_STRING:
 			is_wide =3D 1;
+			next =3D next->next;
+			break;
+		case TOKEN_UTF8_STRING:
+			is_utf8 =3D 1;
+			next =3D next->next;
+			break;
 		case TOKEN_STRING:
 			next =3D next->next;
 			break;
@@ -119,18 +200,35 @@ struct token *get_string_constant(struct token *tok=
en, struct expression *expr)
 			done =3D next;
 		}
 	}
+	if (is_wide && is_utf8) {
+		sparse_error(token->pos,
+			     "unsupported non-standard concatenation of string literals");
+		is_utf8 =3D 0;
+	}
 	bits =3D is_wide ? wchar_ctype->bit_size: bits_in_char;
 	while (token !=3D done) {
 		unsigned v;
 		const char *p =3D token->string->data;
 		const char *end =3D p + token->string->length - 1;
 		while (p < end) {
+			bool is_ucn =3D (*p =3D=3D '\\' && p + 1 < end &&
+				       (p[1] =3D=3D 'u' || p[1] =3D=3D 'U'));
 			if (*p =3D=3D '\\')
 				esc_count++;
 			p =3D parse_escape(p, &v, end, bits, token->pos);
-			if (len < MAX_STRING)
-				buffer[len] =3D v;
-			len++;
+			if (is_ucn && !is_wide) {
+				char utf8[4];
+				int i, n =3D encode_utf8(v, utf8);
+				for (i =3D 0; i < n; i++) {
+					if (len < MAX_STRING)
+						buffer[len] =3D utf8[i];
+					len++;
+				}
+			} else {
+				if (len < MAX_STRING)
+					buffer[len] =3D v;
+				len++;
+			}
 		}
 		token =3D token->next;
 	}
@@ -148,5 +246,6 @@ struct token *get_string_constant(struct token *token=
, struct expression *expr)
 	}
 	expr->string =3D string;
 	expr->wide =3D is_wide;
+	expr->utf8 =3D is_utf8;
 	return token;
 }
diff --git a/evaluate.c b/evaluate.c
index f40e35773639..e46b1a7d4f70 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -135,7 +135,8 @@ static struct symbol *evaluate_string(struct expressi=
on *expr)
 	struct expression *addr =3D alloc_expression(expr->pos, EXPR_SYMBOL);
 	struct expression *initstr =3D alloc_expression(expr->pos, EXPR_STRING)=
;
 	unsigned int length =3D expr->string->length;
-	struct symbol *char_type =3D expr->wide ? wchar_ctype : &char_ctype;
+	struct symbol *char_type =3D expr->wide ? wchar_ctype :
+		(expr->utf8 && standard >=3D STANDARD_C23) ? &uchar_ctype : &char_ctyp=
e;
=20
 	sym->array_size =3D alloc_const_expression(expr->pos, length);
 	sym->bit_size =3D length * char_type->bit_size;
@@ -148,6 +149,8 @@ static struct symbol *evaluate_string(struct expressi=
on *expr)
 	sym->evaluated =3D 1;
=20
 	initstr->ctype =3D sym;
+	initstr->wide =3D expr->wide;
+	initstr->utf8 =3D expr->utf8;
 	initstr->string =3D expr->string;
=20
 	array->array_size =3D sym->array_size;
@@ -1599,7 +1602,7 @@ static int whitelist_pointers(struct symbol *t1, st=
ruct symbol *t2)
 	if (t1 =3D=3D t2)
 		return 1;
 	if (t1->rank =3D=3D -2 && t2->rank =3D=3D -2)
-		return 1;
+		return !Wtypesign && !Wpedantic && standard < STANDARD_C23;
 	if (t1->rank !=3D t2->rank)
 		return 0;
 	return !Wtypesign;
diff --git a/expression.c b/expression.c
index 1b04d977a2d5..ace0bf6d1a31 100644
--- a/expression.c
+++ b/expression.c
@@ -599,17 +599,23 @@ struct token *primary_expression(struct token *toke=
n, struct expression **tree)
 	struct expression *expr =3D NULL;
=20
 	switch (token_type(token)) {
-	case TOKEN_CHAR ... TOKEN_WIDE_CHAR_EMBEDDED_3:
+	case TOKEN_CHAR ... TOKEN_UTF8_CHAR_EMBEDDED_3:
 		expr =3D alloc_expression(token->pos, EXPR_VALUE);
 		expr->flags =3D CEF_SET_CHAR;
 		get_char_constant(token, &expr->value);
=20
-		// TODO: handle 'u8', 'u' & 'U' prefixes.
-		if (token_type(token) < TOKEN_WIDE_CHAR) {
+		// TODO: handle 'u' & 'U' prefixes.
+		if (token_type(token) <=3D TOKEN_CHAR_EMBEDDED_3) {
 			expr->ctype =3D &char_ctype;
 			cast_value(expr, &int_ctype, expr);
-		} else {
+		} else if (token_type(token) <=3D TOKEN_WIDE_CHAR_EMBEDDED_3) {
 			expr->ctype =3D wchar_ctype;
+		} else {
+			if (standard < STANDARD_C23 && Wpedantic)
+				warning(token->pos,
+					"UTF-8 character constants are a C23 feature");
+			expr->ctype =3D &uchar_ctype;
+			cast_value(expr, &uchar_ctype, expr);
 		}
 		token =3D token->next;
 		break;
@@ -709,6 +715,7 @@ struct token *primary_expression(struct token *token,=
 struct expression **tree)
=20
 	case TOKEN_STRING:
 	case TOKEN_WIDE_STRING:
+	case TOKEN_UTF8_STRING:
 		expr =3D alloc_expression(token->pos, EXPR_STRING);
 		token =3D get_string_constant(token, expr);
 		break;
diff --git a/expression.h b/expression.h
index 8bf40d32e10b..8c387adf9d5b 100644
--- a/expression.h
+++ b/expression.h
@@ -175,7 +175,8 @@ struct expression {
=20
 		// EXPR_STRING
 		struct {
-			int wide;
+			char wide;
+			char utf8;
 			struct string *string;
 		};
=20
diff --git a/ident-list.h b/ident-list.h
index f51f2048f5ca..3340f11641fa 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -54,8 +54,9 @@ IDENT(static_assert);
 IDENT(thread_local);
 IDENT(true);
=20
-/* Special case for L'\t' */
+/* Special case for L'\t' and u8'a' */
 IDENT(L);
+IDENT(u8);
=20
 /* Extended gcc identifiers */
 IDENT(asm); IDENT_RESERVED(__asm); IDENT_RESERVED(__asm__);
diff --git a/pre-process.c b/pre-process.c
index 428b96f990fb..9ebf09cffbdd 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -507,12 +507,19 @@ static enum token_type combine(struct token *left, =
struct token *right, char *p)
 		return TOKEN_ERROR;
=20
 	if (t1 =3D=3D TOKEN_IDENT && left->ident =3D=3D &L_ident) {
-		if (t2 >=3D TOKEN_CHAR && t2 < TOKEN_WIDE_CHAR)
+		if (t2 >=3D TOKEN_CHAR && t2 <=3D TOKEN_CHAR_EMBEDDED_3)
 			return t2 + TOKEN_WIDE_CHAR - TOKEN_CHAR;
 		if (t2 =3D=3D TOKEN_STRING)
 			return TOKEN_WIDE_STRING;
 	}
=20
+	if (t1 =3D=3D TOKEN_IDENT && left->ident =3D=3D &u8_ident) {
+		if (t2 >=3D TOKEN_CHAR && t2 <=3D TOKEN_CHAR_EMBEDDED_3)
+			return t2 + TOKEN_UTF8_CHAR - TOKEN_CHAR;
+		if (t2 =3D=3D TOKEN_STRING)
+			return TOKEN_UTF8_STRING;
+	}
+
 	if (t2 !=3D TOKEN_IDENT && t2 !=3D TOKEN_NUMBER && t2 !=3D TOKEN_SPECIA=
L)
 		return TOKEN_ERROR;
=20
@@ -592,12 +599,15 @@ static int merge(struct token *left, struct token *=
right)
=20
 	case TOKEN_WIDE_CHAR:
 	case TOKEN_WIDE_STRING:
+	case TOKEN_UTF8_CHAR:
+	case TOKEN_UTF8_STRING:
 		token_type(left) =3D res;
 		left->pos.noexpand =3D 0;
 		left->string =3D right->string;
 		return 1;
=20
 	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
+	case TOKEN_UTF8_CHAR_EMBEDDED_0 ... TOKEN_UTF8_CHAR_EMBEDDED_3:
 		token_type(left) =3D res;
 		left->pos.noexpand =3D 0;
 		memcpy(left->embedded, right->embedded, 4);
@@ -620,7 +630,9 @@ static struct token *dup_token(const struct token *to=
ken, struct position *strea
 	alloc->pos.stream =3D pos.stream;
 	alloc->pos.line =3D pos.line;
 	alloc->pos.pos =3D pos.pos;
-	if (token_type(alloc) =3D=3D TOKEN_STRING || token_type(alloc) =3D=3D T=
OKEN_WIDE_STRING)
+	if (token_type(alloc) =3D=3D TOKEN_STRING ||
+	    token_type(alloc) =3D=3D TOKEN_WIDE_STRING ||
+	    token_type(alloc) =3D=3D TOKEN_UTF8_STRING)
 		token->string->immutable =3D 1;
 	return alloc;=09
 }
@@ -2165,12 +2177,15 @@ static int token_different(struct token *t1, stru=
ct token *t2)
 		break;
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
+	case TOKEN_UTF8_CHAR_EMBEDDED_0 ... TOKEN_UTF8_CHAR_EMBEDDED_3:
 		different =3D memcmp(t1->embedded, t2->embedded, 4);
 		break;
 	case TOKEN_CHAR:
 	case TOKEN_WIDE_CHAR:
+	case TOKEN_UTF8_CHAR:
 	case TOKEN_STRING:
-	case TOKEN_WIDE_STRING: {
+	case TOKEN_WIDE_STRING:
+	case TOKEN_UTF8_STRING: {
 		struct string *s1, *s2;
=20
 		s1 =3D t1->string;
diff --git a/token.h b/token.h
index 8c8a496bee89..b421f166f1f7 100644
--- a/token.h
+++ b/token.h
@@ -94,8 +94,14 @@ enum token_type {
 	TOKEN_WIDE_CHAR_EMBEDDED_1,
 	TOKEN_WIDE_CHAR_EMBEDDED_2,
 	TOKEN_WIDE_CHAR_EMBEDDED_3,
+	TOKEN_UTF8_CHAR,
+	TOKEN_UTF8_CHAR_EMBEDDED_0,
+	TOKEN_UTF8_CHAR_EMBEDDED_1,
+	TOKEN_UTF8_CHAR_EMBEDDED_2,
+	TOKEN_UTF8_CHAR_EMBEDDED_3,
 	TOKEN_STRING,
 	TOKEN_WIDE_STRING,
+	TOKEN_UTF8_STRING,
 	TOKEN_SPECIAL,
 	TOKEN_STREAMBEGIN,
 	TOKEN_STREAMEND,
diff --git a/tokenize.c b/tokenize.c
index b0d4059c8782..4ac40e9e1506 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -152,12 +152,16 @@ const char *show_string(const struct string *string=
)
 	return buffer;
 }
=20
-static const char *show_char(const char *s, size_t len, char prefix, cha=
r delim)
+static const char *show_char(const char *s, size_t len, const char *pref=
ix,
+			     char delim)
 {
-	static char buffer[MAX_STRING + 4];
+	static char buffer[MAX_STRING + 8];
 	char *p =3D buffer;
-	if (prefix)
-		*p++ =3D prefix;
+	if (prefix) {
+		size_t plen =3D strlen(prefix);
+		memcpy(p, prefix, plen);
+		p +=3D plen;
+	}
 	*p++ =3D delim;
 	memcpy(p, s, len);
 	p +=3D len;
@@ -166,13 +170,17 @@ static const char *show_char(const char *s, size_t =
len, char prefix, char delim)
 	return buffer;
 }
=20
-static const char *quote_char(const char *s, size_t len, char prefix, ch=
ar delim)
+static const char *quote_char(const char *s, size_t len, const char *pre=
fix,
+			      char delim)
 {
-	static char buffer[2*MAX_STRING + 6];
+	static char buffer[2 * MAX_STRING + 8];
 	size_t i;
 	char *p =3D buffer;
-	if (prefix)
-		*p++ =3D prefix;
+	if (prefix) {
+		size_t plen =3D strlen(prefix);
+		memcpy(p, prefix, plen);
+		p +=3D plen;
+	}
 	if (delim =3D=3D '"')
 		*p++ =3D '\\';
 	*p++ =3D delim;
@@ -211,24 +219,35 @@ const char *show_token(const struct token *token)
 	case TOKEN_SPECIAL:
 		return show_special(token->special);
=20
-	case TOKEN_CHAR:=20
-		return show_char(token->string->data,
-			token->string->length - 1, 0, '\'');
+	case TOKEN_CHAR:
+		return show_char(token->string->data, token->string->length - 1,
+				 NULL, '\'');
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 		return show_char(token->embedded,
-			token_type(token) - TOKEN_CHAR, 0, '\'');
-	case TOKEN_WIDE_CHAR:=20
-		return show_char(token->string->data,
-			token->string->length - 1, 'L', '\'');
+				 token_type(token) - TOKEN_CHAR, NULL, '\'');
+	case TOKEN_WIDE_CHAR:
+		return show_char(token->string->data, token->string->length - 1,
+				 "L", '\'');
 	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		return show_char(token->embedded,
-			token_type(token) - TOKEN_WIDE_CHAR, 'L', '\'');
-	case TOKEN_STRING:=20
-		return show_char(token->string->data,
-			token->string->length - 1, 0, '"');
-	case TOKEN_WIDE_STRING:=20
-		return show_char(token->string->data,
-			token->string->length - 1, 'L', '"');
+				 token_type(token) - TOKEN_WIDE_CHAR, "L",
+				 '\'');
+	case TOKEN_UTF8_CHAR:
+		return show_char(token->string->data, token->string->length - 1,
+				 "u8", '\'');
+	case TOKEN_UTF8_CHAR_EMBEDDED_0 ... TOKEN_UTF8_CHAR_EMBEDDED_3:
+		return show_char(token->embedded,
+				 token_type(token) - TOKEN_UTF8_CHAR, "u8",
+				 '\'');
+	case TOKEN_STRING:
+		return show_char(token->string->data, token->string->length - 1,
+				 NULL, '"');
+	case TOKEN_WIDE_STRING:
+		return show_char(token->string->data, token->string->length - 1,
+				 "L", '"');
+	case TOKEN_UTF8_STRING:
+		return show_char(token->string->data, token->string->length - 1,
+				 "u8", '"');
=20
 	case TOKEN_STREAMBEGIN:
 		snprintf(buffer, sizeof(buffer), "<beginning of '%s'>", stream_name(to=
ken->pos.stream));
@@ -273,24 +292,35 @@ const char *quote_token(const struct token *token)
 	case TOKEN_SPECIAL:
 		return show_special(token->special);
=20
-	case TOKEN_CHAR:=20
+	case TOKEN_CHAR:
 		return quote_char(token->string->data,
-			token->string->length - 1, 0, '\'');
+				  token->string->length - 1, NULL, '\'');
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
 		return quote_char(token->embedded,
-			token_type(token) - TOKEN_CHAR, 0, '\'');
-	case TOKEN_WIDE_CHAR:=20
+				  token_type(token) - TOKEN_CHAR, NULL, '\'');
+	case TOKEN_WIDE_CHAR:
 		return quote_char(token->string->data,
-			token->string->length - 1, 'L', '\'');
+				  token->string->length - 1, "L", '\'');
 	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		return quote_char(token->embedded,
-			token_type(token) - TOKEN_WIDE_CHAR, 'L', '\'');
-	case TOKEN_STRING:=20
+				  token_type(token) - TOKEN_WIDE_CHAR, "L",
+				  '\'');
+	case TOKEN_UTF8_CHAR:
+		return quote_char(token->string->data,
+				  token->string->length - 1, "u8", '\'');
+	case TOKEN_UTF8_CHAR_EMBEDDED_0 ... TOKEN_UTF8_CHAR_EMBEDDED_3:
+		return quote_char(token->embedded,
+				  token_type(token) - TOKEN_UTF8_CHAR, "u8",
+				  '\'');
+	case TOKEN_STRING:
+		return quote_char(token->string->data,
+				  token->string->length - 1, NULL, '"');
+	case TOKEN_WIDE_STRING:
 		return quote_char(token->string->data,
-			token->string->length - 1, 0, '"');
-	case TOKEN_WIDE_STRING:=20
+				  token->string->length - 1, "L", '"');
+	case TOKEN_UTF8_STRING:
 		return quote_char(token->string->data,
-			token->string->length - 1, 'L', '"');
+				  token->string->length - 1, "u8", '"');
 	case TOKEN_GNU_KLUDGE:
 		return ",";
 	default:
@@ -979,6 +1009,14 @@ static int get_one_identifier(int c, stream_t *stre=
am)
 				return eat_string(nextchar(stream), stream,
 							TOKEN_WIDE_STRING);
 		}
+		if (len =3D=3D 2 && buf[0] =3D=3D 'u' && buf[1] =3D=3D '8') {
+			if (next =3D=3D '\'')
+				return eat_string(nextchar(stream), stream,
+						  TOKEN_UTF8_CHAR);
+			else
+				return eat_string(nextchar(stream), stream,
+						  TOKEN_UTF8_STRING);
+		}
 	}
 	hash =3D ident_hash_end(hash);
 	ident =3D create_hashed_ident(buf, len, hash);
diff --git a/validation/c23-u8-char-error.c b/validation/c23-u8-char-erro=
r.c
new file mode 100644
index 000000000000..da03b604e8cd
--- /dev/null
+++ b/validation/c23-u8-char-error.c
@@ -0,0 +1,16 @@
+static unsigned char e1 =3D u8'';
+static unsigned char e2 =3D u8'ab';
+static unsigned char e3 =3D u8'\u00e9';
+static const void *e4 =3D u8"a" L"b";
+
+/*
+ * check-name: c23-u8-char-error
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-u8-char-error.c:1:27: error: empty character constant
+c23-u8-char-error.c:2:27: error: multi-character UTF-8 character constan=
t
+c23-u8-char-error.c:3:27: error: multi-character UTF-8 character constan=
t
+c23-u8-char-error.c:4:25: error: unsupported non-standard concatenation =
of string literals
+ * check-error-end
+ */
diff --git a/validation/c23-u8-char-pedantic.c b/validation/c23-u8-char-p=
edantic.c
new file mode 100644
index 000000000000..8c2fbbaeecf6
--- /dev/null
+++ b/validation/c23-u8-char-pedantic.c
@@ -0,0 +1,10 @@
+static int x =3D u8'a';
+
+/*
+ * check-name: c23-u8-char-pedantic
+ * check-command: sparse -std=3Dc11 -Wpedantic $file
+ *
+ * check-error-start
+c23-u8-char-pedantic.c:1:16: warning: UTF-8 character constants are a C2=
3 feature
+ * check-error-end
+ */
diff --git a/validation/c23-u8-char-warn.c b/validation/c23-u8-char-warn.=
c
new file mode 100644
index 000000000000..2ccf459e01f3
--- /dev/null
+++ b/validation/c23-u8-char-warn.c
@@ -0,0 +1,14 @@
+static unsigned char w1 =3D u8'\x100';
+static const char *w2 =3D u8"test";
+
+/*
+ * check-name: c23-u8-char-warn
+ * check-command: sparse -std=3Dc23 $file
+ *
+ * check-error-start
+c23-u8-char-warn.c:1:27: warning: hex escape sequence out of range
+c23-u8-char-warn.c:2:25: warning: incorrect type in initializer (differe=
nt signedness)
+c23-u8-char-warn.c:2:25:    expected char const *static [toplevel] w2
+c23-u8-char-warn.c:2:25:    got unsigned char *
+ * check-error-end
+ */
diff --git a/validation/c23-u8-char.c b/validation/c23-u8-char.c
new file mode 100644
index 000000000000..60e0c2a02e36
--- /dev/null
+++ b/validation/c23-u8-char.c
@@ -0,0 +1,37 @@
+static_assert(sizeof(u8'a') =3D=3D 1, "sizeof u8 char");
+static_assert(u8'a' =3D=3D 97, "value u8 char");
+static_assert(u8'\0' =3D=3D 0, "u8 nul");
+static_assert(u8'\xff' =3D=3D 255, "u8 0xff is unsigned");
+static_assert(u8'\u0041' =3D=3D 65, "u8 UCN ASCII");
+static_assert(_Generic(u8'a', unsigned char: 1, char: 0, int: 0, default=
: 0) =3D=3D 1,
+	      "type u8 char");
+
+static_assert(sizeof(u8"hello") =3D=3D 6, "sizeof u8 string");
+static_assert(sizeof(u8"\u00e9") =3D=3D 3, "sizeof 2-byte UTF-8 UCN stri=
ng");
+static_assert(sizeof(u8"\U0001F600") =3D=3D 5, "sizeof 4-byte UTF-8 UCN =
string");
+static_assert(sizeof(u8"ab" "cd") =3D=3D 5, "concat u8 + narrow");
+static_assert(sizeof("ab" u8"cd") =3D=3D 5, "concat narrow + u8");
+static_assert(_Generic(u8"hello", unsigned char *: 1, char *: 0, default=
: 0) =3D=3D 1,
+	      "u8 string decays to unsigned char *");
+static_assert(_Generic("ab" u8"cd", unsigned char *: 1, char *: 0, defau=
lt: 0) =3D=3D 1,
+	      "narrow + u8 string decays to unsigned char *");
+
+static const unsigned char c =3D u8'z';
+static const unsigned char *s =3D u8"test";
+static char s1[] =3D u8"abc";
+static unsigned char s2[] =3D u8"abc";
+static signed char s3[] =3D u8"abc";
+
+#define CAT(a, b) a##b
+static const unsigned char c2 =3D CAT(u8, 'x');
+static const unsigned char *s_cat =3D CAT(u8, "yz");
+
+static int use_vars(void)
+{
+	return c + s[0] + s1[0] + s2[0] + s3[0] + c2 + s_cat[0];
+}
+
+/*
+ * check-name: c23-u8-char
+ * check-command: sparse -std=3Dc23 -pedantic $file
+ */
