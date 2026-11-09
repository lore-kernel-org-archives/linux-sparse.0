Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256436;
	b=SdQTJVdm5OSFZYqgAxBA7qNVO++SUCCE1Wx1kLPOUqeb1Xn1xHAcjyb/UgkwW0YSi3Rq
	 rRiw4V6IvDR+JiEnzK09odJrK3h1GyvaFA9inPczsovgT2eISJawBuf/uCTTLxPJAt5/O
	 dDSfMO6WZQ3SfONYHDHilof3rAPm+mgDGPRAxMSR+4AiIM/TH5FOdFJ80xaoAk2y38AtC
	 vxe9NKqovevikn0mUYWsCt1Tf4/txVI7SjG4dm77Bwr+545aTJkh9fmmk6xL0xFzI7TpG
	 P9Det//BxQCbP+zQuaL+wkp+tmoLsbNxpIWiHy0N7FtMwA1Y5AYeJH9/J/Wb2S8mMzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=vhWC9TpGTQmlXm0b3H0dlQ7/47qmLg7l22598OVrbvs=;
	b=I1NqmrQQ0MU3T1ks0+syW5ddmUSgsqDK73/w5BWC3OPFo4cUaUMQPYs2f04L/q6lSgeP
	 eyPJrMmeAeYXHT9YmzaQarvTVLgavGGy1BeEE/u+r+oo05shSgi0U1EIEY1CnHt52hfUF
	 yDXXovFB2D2yiyElT49vPFSZ/tWY0ED3KL3QVN+K4b5fEEIsN9BblI+FlWc2sWALm+WyI
	 QVKXToLhRtZAL1Dn+g8Pgi8cjDcnzKAbplxJVM5nVO8qBinPtu7db3oWFShcsbAmRYVrr
	 zpK+BJn8dHY9vxhJ99v6e7WqjVw2Dvg+/8U+JL5iaxd3I4Ivkm+lePeLkd5mC9SQD5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mlS6HlSu;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03D606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E03D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mlS6HlSu
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMJ0JFLz1XMYJN;
	Mon,  9 Nov 2026 20:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256420; x=1796848421; bh=vhWC9
	TpGTQmlXm0b3H0dlQ7/47qmLg7l22598OVrbvs=; b=mlS6HlSuknenEtxHd9OfA
	HcBdztBbuuoa/yIrhRtLiYVeFQXakNcVdpW7glXkJU3aq47j8cHzyhkaJS/ePnSe
	k7kCAhEf69ptc9RcybiajZ7jJEzBrQGe7ia+ATdzM0P86+1XODeE/9dwjEIs5hD0
	HqO80gQXM66NXywRnwD2MRZroNFtcGFxoTcRGN1/wk39Y0jIMEM/J5df60PZpDRW
	z3m6AS3HL+ajgXzDxOx02etFWPWSz9F4YjI/3+tD3qmdNhskAUTjBzw6i8RmzuKT
	c0apKECA0+MIr3UPgEsKt33je1QTvQh7FYff6KqDFwvnoHZR+xNMmMtchzAoNVnk
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WKmnlU_x706t; Mon,  9 Nov 2026 20:33:40 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM764xZz1XMYJK;
	Mon,  9 Nov 2026 20:33:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 70/73] pre-process: Support long token and string expansions dynamically
Date: Mon,  9 Nov 2026 12:32:56 -0800
Message-ID: <20261109203259.362845-71-bvanassche@acm.org>
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

Dynamically resize token and string buffers in show_token_sequence(),
tokenize.c, and get_string_constant() in char.c, check allocation and siz=
e
bounds, increase MAX_STRING in token.h to 65535, and round oversized slab
allocations up to chunk multiples in allocate.c.

Prevent "too long token expansion" errors, 64 KB string literal truncatio=
n,
die("alloc too big") aborts, and fixed-buffer overflows when formatting,
stringifying, or concatenating deeply nested macro expansions such as tho=
se
found in modern Linux kernel headers.

Add a regression test in validation/long-string-expansion.c.

Fixes: fbc8230fa8c4 ("Larger buffer size for token concatenation")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 allocate.c                         | 27 ++++++++---
 allocate.h                         |  1 +
 char.c                             | 46 +++++++++++-------
 pre-process.c                      | 58 ++++++++++++++++------
 token.h                            |  2 +-
 tokenize.c                         | 78 +++++++++++++++++++++---------
 validation/long-string-expansion.c | 30 ++++++++++++
 7 files changed, 179 insertions(+), 63 deletions(-)
 create mode 100644 validation/long-string-expansion.c

diff --git a/allocate.c b/allocate.c
index 2aca1815e5f2..75cd8f3befef 100644
--- a/allocate.c
+++ b/allocate.c
@@ -30,6 +30,7 @@
  * efficient: allocate larger "blobs", and give out individual
  * small bits and pieces of it with no maintenance overhead.
  */
+#include <limits.h>
 #include <stdlib.h>
 #include <stddef.h>
 #include <stdio.h>
@@ -60,7 +61,7 @@ void drop_all_allocations(struct allocator_struct *desc=
)
 	desc->freelist =3D NULL;
 	while (blob) {
 		struct allocation_blob *next =3D blob->next;
-		blob_free(blob, desc->chunking);
+		blob_free(blob, blob->size);
 		blob =3D next;
 	}
 }
@@ -97,22 +98,32 @@ void *allocate(struct allocator_struct *desc, unsigne=
d int size)
 	desc->useful_bytes +=3D size;
 	size =3D (size + alignment - 1) & ~(alignment-1);
 	if (!blob || blob->left < size) {
-		unsigned int offset, chunking =3D desc->chunking;
+		unsigned long offset, chunking =3D desc->chunking;
 		struct allocation_blob *newblob;
=20
 		offset =3D offsetof(struct allocation_blob, data);
 		offset =3D (offset + alignment - 1) & ~(alignment-1);
-		if (size > chunking - offset)
-			die("alloc too big");
+		if (size > chunking - offset) {
+			unsigned long need =3D (unsigned long)size + offset;
+			chunking =3D (need + chunking - 1) & ~(chunking - 1);
+			if (chunking < need || chunking - offset > UINT_MAX)
+				die("alloc too big");
+		}
 		newblob =3D blob_alloc(chunking);
 		if (!newblob)
 			die("out of memory");
 		desc->total_bytes +=3D chunking;
-		newblob->next =3D blob;
+		newblob->size =3D chunking;
+		newblob->left =3D chunking - offset;
+		newblob->offset =3D offset - offsetof(struct allocation_blob, data);
+		if (blob && blob->left > newblob->left - size) {
+			newblob->next =3D blob->next;
+			blob->next =3D newblob;
+		} else {
+			newblob->next =3D blob;
+			desc->blobs =3D newblob;
+		}
 		blob =3D newblob;
-		desc->blobs =3D newblob;
-		blob->left =3D chunking - offset;
-		blob->offset =3D offset - offsetof(struct allocation_blob, data);
 	}
 	retval =3D blob->data + blob->offset;
 	blob->offset +=3D size;
diff --git a/allocate.h b/allocate.h
index a6d305371c28..be99d1053608 100644
--- a/allocate.h
+++ b/allocate.h
@@ -5,6 +5,7 @@
=20
 struct allocation_blob {
 	struct allocation_blob *next;
+	unsigned long size;
 	unsigned int left, offset;
 	unsigned char data[];
 };
diff --git a/char.c b/char.c
index a0776b560e29..5614a887f095 100644
--- a/char.c
+++ b/char.c
@@ -1,3 +1,6 @@
+#include <limits.h>
+#include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 #include "target.h"
 #include "lib.h"
@@ -171,6 +174,22 @@ void get_char_constant(struct token *token, unsigned=
 long long *val)
 	*val =3D v;
 }
=20
+static void append_string_byte(char **buf, size_t *cap, size_t *len, cha=
r ch)
+{
+	if (*len >=3D INT_MAX - sizeof(struct string))
+		die("string too large");
+	if (*len + 1 > *cap) {
+		size_t new_cap =3D *cap ? *cap * 2 : 4096;
+		if (new_cap < *len + 1)
+			new_cap =3D *len + 1;
+		*buf =3D realloc(*buf, new_cap);
+		if (!*buf)
+			die("out of memory");
+		*cap =3D new_cap;
+	}
+	(*buf)[(*len)++] =3D ch;
+}
+
 struct token *get_string_constant(struct token *token, struct expression=
 *expr)
 {
 	struct string *string =3D token->string;
@@ -178,8 +197,9 @@ struct token *get_string_constant(struct token *token=
, struct expression *expr)
 	int stringtype =3D token_type(token);
 	int is_wide =3D stringtype =3D=3D TOKEN_WIDE_STRING;
 	int is_utf8 =3D stringtype =3D=3D TOKEN_UTF8_STRING;
-	static char buffer[MAX_STRING];
-	int len =3D 0;
+	static char *buffer;
+	static size_t buf_size;
+	size_t len =3D 0;
 	int bits;
 	int esc_count =3D 0;
=20
@@ -219,29 +239,21 @@ struct token *get_string_constant(struct token *tok=
en, struct expression *expr)
 			if (is_ucn && !is_wide) {
 				char utf8[4];
 				int i, n =3D encode_utf8(v, utf8);
-				for (i =3D 0; i < n; i++) {
-					if (len < MAX_STRING)
-						buffer[len] =3D utf8[i];
-					len++;
-				}
+				for (i =3D 0; i < n; i++)
+					append_string_byte(&buffer, &buf_size, &len, utf8[i]);
 			} else {
-				if (len < MAX_STRING)
-					buffer[len] =3D v;
-				len++;
+				append_string_byte(&buffer, &buf_size, &len, v);
 			}
 		}
 		token =3D token->next;
 	}
-	if (len > MAX_STRING) {
-		warning(token->pos, "trying to concatenate %d-character string (%d byt=
es max)", len, MAX_STRING);
-		len =3D MAX_STRING;
-	}
=20
 	if (esc_count || len >=3D string->length) {
 		if (string->immutable || len >=3D string->length)	/* can't cannibalize=
 */
-			string =3D __alloc_string(len+1);
-		string->length =3D len+1;
-		memcpy(string->data, buffer, len);
+			string =3D __alloc_string(len + 1);
+		string->length =3D len + 1;
+		if (len)
+			memcpy(string->data, buffer, len);
 		string->data[len] =3D '\0';
 	}
 	expr->string =3D string;
diff --git a/pre-process.c b/pre-process.c
index 8eb70ca7a1a4..1ea6c71b9a7e 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -34,6 +34,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <stdint.h>
 #include <time.h>
 #include <errno.h>
 #include <sys/stat.h>
@@ -420,38 +421,65 @@ static struct token *dup_list(struct token *list)
=20
 static const char *show_token_sequence(struct token *token, int quote)
 {
-	static char buffer[MAX_STRING];
-	char *ptr =3D buffer;
-	int whitespace =3D 0;
+	static char *buffer;
+	static size_t buf_size;
+	size_t offset =3D 0;
+	size_t whitespace =3D 0;
=20
 	if (!token && !quote)
 		return "<none>";
 	while (!eof_token(token)) {
 		const char *val =3D quote ? quote_token(token) : show_token(token);
-		int len =3D strlen(val);
-
-		if (ptr + whitespace + len >=3D buffer + sizeof(buffer)) {
-			sparse_error(token->pos, "too long token expansion");
-			break;
+		size_t len =3D strlen(val);
+		size_t needed;
+
+		if (len > SIZE_MAX - offset - whitespace - 1)
+			die("out of memory");
+		needed =3D offset + whitespace + len + 1;
+
+		if (needed > buf_size) {
+			size_t new_size =3D buf_size ? buf_size : 65536;
+			while (new_size < needed) {
+				if (new_size > SIZE_MAX / 2) {
+					new_size =3D needed;
+					break;
+				}
+				new_size *=3D 2;
+			}
+			buffer =3D realloc(buffer, new_size);
+			if (!buffer)
+				die("out of memory");
+			buf_size =3D new_size;
 		}
=20
 		if (whitespace)
-			*ptr++ =3D ' ';
-		memcpy(ptr, val, len);
-		ptr +=3D len;
+			buffer[offset++] =3D ' ';
+		memcpy(buffer + offset, val, len);
+		offset +=3D len;
 		token =3D token->next;
 		whitespace =3D token->pos.whitespace;
 	}
-	*ptr =3D 0;
+	if (!buffer) {
+		buf_size =3D 64;
+		buffer =3D malloc(buf_size);
+		if (!buffer)
+			die("out of memory");
+	}
+	buffer[offset] =3D 0;
 	return buffer;
 }
=20
 static struct token *stringify(struct token *arg)
 {
 	const char *s =3D show_token_sequence(arg, 1);
-	int size =3D strlen(s)+1;
-	struct token *token =3D __alloc_token(0);
-	struct string *string =3D __alloc_string(size);
+	size_t size =3D strlen(s) + 1;
+	struct token *token;
+	struct string *string;
+
+	if (size > INT_MAX - sizeof(struct string))
+		die("string too large");
+	token =3D __alloc_token(0);
+	string =3D __alloc_string(size);
=20
 	memcpy(string->data, s, size);
 	string->length =3D size;
diff --git a/token.h b/token.h
index 998d83a123c9..e8276757ca5f 100644
--- a/token.h
+++ b/token.h
@@ -206,7 +206,7 @@ struct token {
 	};
 };
=20
-#define MAX_STRING 8191
+#define MAX_STRING 65535
=20
 static inline struct token *containing_token(struct token **p)
 {
diff --git a/tokenize.c b/tokenize.c
index 775c54667af7..95dad56a8096 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -30,6 +30,7 @@
 #include <string.h>
 #include <ctype.h>
 #include <unistd.h>
+#include <limits.h>
 #include <stdint.h>
=20
 #include "lib.h"
@@ -110,6 +111,25 @@ const char *show_ident(const struct ident *ident)
 	return buffer;
 }
=20
+static char *grow_buffer(char **buf, size_t *cap, size_t needed)
+{
+	if (needed > *cap) {
+		size_t new_cap =3D *cap ? *cap : 4096;
+		while (new_cap < needed) {
+			if (new_cap > SIZE_MAX / 2) {
+				new_cap =3D needed;
+				break;
+			}
+			new_cap *=3D 2;
+		}
+		*buf =3D realloc(*buf, new_cap);
+		if (!*buf)
+			die("out of memory");
+		*cap =3D new_cap;
+	}
+	return *buf;
+}
+
 static char *charstr(char *ptr, unsigned char c, unsigned char escape, u=
nsigned char next)
 {
 	if (isprint(c)) {
@@ -135,13 +155,18 @@ static char *charstr(char *ptr, unsigned char c, un=
signed char escape, unsigned
=20
 const char *show_string(const struct string *string)
 {
-	static char buffer[4 * MAX_STRING + 3];
+	static char *buffer;
+	static size_t buf_size;
+	size_t len;
 	char *ptr;
 	int i;
=20
 	if (!string || !string->length)
 		return "<bad_string>";
-	ptr =3D buffer;
+	len =3D string->length;
+	if (len > (SIZE_MAX - 3) / 4)
+		die("out of memory");
+	ptr =3D grow_buffer(&buffer, &buf_size, 4 * len + 3);
 	*ptr++ =3D '"';
 	for (i =3D 0; i < string->length-1; i++) {
 		const char *p =3D string->data + i;
@@ -155,10 +180,15 @@ const char *show_string(const struct string *string=
)
 static const char *show_char(const char *s, size_t len, const char *pref=
ix,
 			     char delim)
 {
-	static char buffer[MAX_STRING + 8];
-	char *p =3D buffer;
-	if (prefix) {
-		size_t plen =3D strlen(prefix);
+	static char *buffer;
+	static size_t buf_size;
+	size_t plen =3D prefix ? strlen(prefix) : 0;
+	char *p;
+
+	if (len > SIZE_MAX - plen - 3)
+		die("out of memory");
+	p =3D grow_buffer(&buffer, &buf_size, plen + len + 3);
+	if (plen) {
 		memcpy(p, prefix, plen);
 		p +=3D plen;
 	}
@@ -173,11 +203,16 @@ static const char *show_char(const char *s, size_t =
len, const char *prefix,
 static const char *quote_char(const char *s, size_t len, const char *pre=
fix,
 			      char delim)
 {
-	static char buffer[2 * MAX_STRING + 8];
+	static char *buffer;
+	static size_t buf_size;
+	size_t plen =3D prefix ? strlen(prefix) : 0;
 	size_t i;
-	char *p =3D buffer;
-	if (prefix) {
-		size_t plen =3D strlen(prefix);
+	char *p;
+
+	if (len > (SIZE_MAX - plen - 6) / 2)
+		die("out of memory");
+	p =3D grow_buffer(&buffer, &buf_size, plen + 2 * len + 6);
+	if (plen) {
 		memcpy(p, prefix, plen);
 		p +=3D plen;
 	}
@@ -661,18 +696,20 @@ static int get_one_number(int c, int next, stream_t=
 *stream)
=20
 static int eat_string(int next, stream_t *stream, enum token_type type)
 {
-	static char buffer[MAX_STRING];
+	static char *buffer;
+	static size_t buf_size;
 	struct string *string;
 	struct token *token =3D stream->token;
-	int len =3D 0;
+	size_t len =3D 0;
 	int escape;
 	int want_hex =3D 0;
 	char delim =3D type < TOKEN_STRING ? '\'' : '"';
=20
 	for (escape =3D 0; escape || next !=3D delim; next =3D nextchar(stream)=
) {
-		if (len < MAX_STRING)
-			buffer[len] =3D next;
-		len++;
+		if (len >=3D INT_MAX - sizeof(struct string))
+			die("string too large");
+		grow_buffer(&buffer, &buf_size, len + 4 < 64 ? 64 : len + 4);
+		buffer[len++] =3D next;
 		if (next =3D=3D '\n') {
 			warning(stream_pos(stream),
 				"missing terminating %c character", delim);
@@ -698,20 +735,17 @@ static int eat_string(int next, stream_t *stream, e=
num token_type type)
 	if (want_hex)
 		warning(stream_pos(stream),
 			"\\x used with no following hex digits");
-	if (len > MAX_STRING) {
-		warning(stream_pos(stream), "string too long (%d bytes, %d bytes max)"=
, len, MAX_STRING);
-		len =3D MAX_STRING;
-	}
 	if (delim =3D=3D '\'' && len && len <=3D 4) {
 		token_type(token) =3D type + len;
 		memset(buffer + len, '\0', 4 - len);
 		memcpy(token->embedded, buffer, 4);
 	} else {
 		token_type(token) =3D type;
-		string =3D __alloc_string(len+1);
-		memcpy(string->data, buffer, len);
+		string =3D __alloc_string(len + 1);
+		if (len)
+			memcpy(string->data, buffer, len);
 		string->data[len] =3D '\0';
-		string->length =3D len+1;
+		string->length =3D len + 1;
 		token->string =3D string;
 	}
=20
diff --git a/validation/long-string-expansion.c b/validation/long-string-=
expansion.c
new file mode 100644
index 000000000000..5523ae966c74
--- /dev/null
+++ b/validation/long-string-expansion.c
@@ -0,0 +1,30 @@
+#define S16 "0123456789abcdef"
+#define S64 S16 S16 S16 S16
+#define S256 S64 S64 S64 S64
+#define S1024 S256 S256 S256 S256
+#define S4096 S1024 S1024 S1024 S1024
+#define S16384 S4096 S4096 S4096 S4096
+#define S65536 S16384 S16384 S16384 S16384
+
+#define STR_INNER(x) #x
+#define STR(x) STR_INNER(x)
+
+#define T4 a+a+a+a
+#define T16 T4+T4+T4+T4
+#define T64 T16+T16+T16+T16
+#define T256 T64+T64+T64+T64
+#define T1024 T256+T256+T256+T256
+#define T4096 T1024+T1024+T1024+T1024
+#define T16384 T4096+T4096+T4096+T4096
+#define T65536 T16384+T16384+T16384+T16384
+
+/* Concatenated string literal > 65535 bytes */
+_Static_assert(sizeof(S65536 S16) =3D=3D 65536 + 16 + 1, "concat > 64KB"=
);
+
+/* Stringified macro expansion with escaped quotes > 65535 bytes */
+_Static_assert(sizeof(STR("q" T65536)) > 130000, "stringify > 64KB");
+
+/*
+ * check-name: long-string-expansion
+ * check-command: sparse $file
+ */
