Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256414;
	b=RQ6PP2xsrcVq7YN92vg8CrLpDZqxOrU/KR2HYG8uMYqCh+6/VGRlhAuQ5Pc3iPSe1ZQq
	 DHBfviuI52aXQ8NtuEVUyYAcs8PzE0iv8H7W3+UGdUROlAFRWMoUMcZfExozjIragYRRM
	 z3bCX1+T7UqwT8ApsRdU8qPqHBCeioSDo1J6Ex2cizMjtE9QnvdVPQnoS1P6k5oY5lIoY
	 zhaxV+Zsf7KXpkmNU8OPBxR80IoW6ZpOUmy3g0SzwV+QJsYX9UBZgC1oeH1NhVqzyWnC7
	 eCLu4iuJGQMJOx5zJwZMG+NOJayeWyuTITFkAhCi/tKmbevw0+2/J4vmA20voHY0+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=9FBQO8XqR3rCRiGxjwkwbjGHffmWT6D0RMxIUpTiTLM=;
	b=EfEMECKFzb+5ANzMw9CeHWtOys1eJIYqssz2czvWka/HSmMavZVP4huOpbBUeibhPtyG
	 vm6dQpzuq+SuJobIolWZY2PGGTsgzEgSVh3V8OBtf17RZ/O2m6aNo717WU8OTi663G+YE
	 wKjyPDYCDcTilm4FBPTeJC0RHFfCozcS/QQuJ1SimkqlEs2kjA05T1LFsUwt2Z0PaZ8zL
	 bgytY3crOOh7Vuv980XS7peQO8BlqIBFsMyeTEZF7uyQt+6uenrk8VUQKZa+i+HU2xELw
	 5/dh9u8QOAvgr7X6+wKI4a6dCu+U830oGJ1jUR+x4l8d0E1x6LBtKvzhwgz+RfBeO+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=pUYmu2OT;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143A606A326
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7143A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=pUYmu2OT
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhM16sNyz1XMYJf;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256409; x=1796848410; bh=9FBQO
	8XqR3rCRiGxjwkwbjGHffmWT6D0RMxIUpTiTLM=; b=pUYmu2OT5jzqYH7rmpY45
	BB4+CIjaMaF5po5QSB9MFij0AzbzLpHlVpyTOOyDOlbqtjmUhsHZQF8TdDX7Psmg
	KzJTiVGaNScInegr9QQmjdV7qOMuRFOT1jWNlTt14OucAI81hPDlhWAiUzKjXg98
	iWeq1lG44oeveX2Myfq9iFH0IvL5K6VwprTs+gTXcIPhjT5Mkaz4n3Qd+7wGfbcR
	oz0RAaIhU4LC/Ubmyt9kiXPpBSa2UD6b1+KuakYFR/rPHNwDYkhSjE2E619bPOGD
	xzzKHG5eLXtJ6NCRGVQ+fL+qh6D4MngiIVS/K5p3N+DptHARNa2M7AWzsImyxI2u
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bWBmyuJy5e9r; Mon,  9 Nov 2026 20:33:29 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLs5vwrz1XM6J7;
	Mon,  9 Nov 2026 20:33:25 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 07/73] pre-process: Fix macro expansion and include directive handling
Date: Mon,  9 Nov 2026 12:31:53 -0800
Message-ID: <20261109203259.362845-8-bvanassche@acm.org>
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

Fix buffer bounds, unterminated macro arguments, and include path checks
in pre-process.c:
- Handle TOKEN_STREAMEND and TOKEN_STREAMBEGIN on unterminated macro
  argument lists and bound token-pasting buffers in combine().
- Widen token_name_sequence() to PATH_MAX and check remaining capacity
  with pointer subtraction to prevent buffer and pointer overflows.
- Reject directory paths in try_include() via fstat() and diagnose
  incomplete defined() expressions in #if directives.
- Add regression tests in
  validation/preprocessor/preprocess-crash-fixes.c and
  validation/preprocessor/preprocess-errors-and-limits.c.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c                                 | 83 +++++++++++++++----
 .../preprocessor/preprocess-crash-fixes.c     | 25 ++++++
 .../preprocess-errors-and-limits.c            | 33 ++++++++
 3 files changed, 123 insertions(+), 18 deletions(-)
 create mode 100644 validation/preprocessor/preprocess-crash-fixes.c
 create mode 100644 validation/preprocessor/preprocess-errors-and-limits.=
c

diff --git a/pre-process.c b/pre-process.c
index 7b6555677570..ca019d704a10 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -35,6 +35,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <time.h>
+#include <sys/stat.h>
=20
 #include "lib.h"
 #include "allocate.h"
@@ -107,8 +108,12 @@ static int expand(struct token **, struct symbol *);
=20
 static void replace_with_string(struct token *token, const char *str)
 {
-	int size =3D strlen(str) + 1;
-	struct string *s =3D __alloc_string(size);
+	size_t size =3D strlen(str) + 1;
+	struct string *s;
+
+	if (size > INT_MAX - sizeof(struct string))
+		die("string too large");
+	s =3D __alloc_string(size);
=20
 	s->length =3D size;
 	memcpy(s->data, str, size);
@@ -312,6 +317,13 @@ struct arg {
 	int n_str;
 };
=20
+static inline bool stream_end_token(const struct token *t)
+{
+	return eof_token(t) ||
+	       token_type(t) =3D=3D TOKEN_STREAMEND ||
+	       token_type(t) =3D=3D TOKEN_STREAMBEGIN;
+}
+
 static int collect_arguments(struct token *start, struct token *arglist,=
 struct arg *args, struct token *what)
 {
 	int wanted =3D arglist->count.normal;
@@ -322,7 +334,7 @@ static int collect_arguments(struct token *start, str=
uct token *arglist, struct
=20
 	if (!wanted) {
 		next =3D collect_arg(start, 0, &what->pos);
-		if (eof_token(next))
+		if (stream_end_token(next))
 			goto Eclosing;
 		if (!eof_token(start->next) || !match_op(next, ')')) {
 			count++;
@@ -332,7 +344,7 @@ static int collect_arguments(struct token *start, str=
uct token *arglist, struct
 		for (count =3D 0; count < wanted; count++) {
 			struct argcount *p =3D &arglist->next->count;
 			next =3D collect_arg(start, p->vararg, &what->pos);
-			if (eof_token(next))
+			if (stream_end_token(next))
 				goto Eclosing;
 			if (p->vararg && wanted =3D=3D 1 && eof_token(start->next))
 				break;
@@ -373,7 +385,7 @@ Emany:
 		next =3D collect_arg(next, 0, &what->pos);
 		count++;
 	}
-	if (eof_token(next))
+	if (stream_end_token(next))
 		goto Eclosing;
 	sparse_error(what->pos, "macro \"%s\" passed %d arguments, but takes ju=
st %d",
 		show_token(what), count, wanted);
@@ -382,7 +394,10 @@ Eclosing:
 	sparse_error(what->pos, "unterminated argument list invoking macro \"%s=
\"",
 		show_token(what));
 out:
-	what->next =3D next->next;
+	if (stream_end_token(next))
+		what->next =3D next;
+	else
+		what->next =3D next->next;
 	return 0;
 }
=20
@@ -499,12 +514,22 @@ static enum token_type combine(struct token *left, =
struct token *right, char *p)
 	if (t2 !=3D TOKEN_IDENT && t2 !=3D TOKEN_NUMBER && t2 !=3D TOKEN_SPECIA=
L)
 		return TOKEN_ERROR;
=20
-	strcpy(p, show_token(left));
-	strcat(p, show_token(right));
-	len =3D strlen(p);
+	{
+		const char *s1 =3D show_token(left);
+		int l1 =3D strlen(s1);
+		const char *s2;
+		int l2;
=20
-	if (len >=3D 256)
-		return TOKEN_ERROR;
+		if (l1 > 4096)
+			return TOKEN_ERROR;
+		memcpy(p, s1, l1);
+		s2 =3D show_token(right);
+		l2 =3D strlen(s2);
+		if (l1 + l2 > 4096)
+			return TOKEN_ERROR;
+		memcpy(p + l1, s2, l2 + 1);
+		len =3D l1 + l2;
+	}
=20
 	if (t1 =3D=3D TOKEN_IDENT) {
 		if (t2 =3D=3D TOKEN_SPECIAL)
@@ -537,7 +562,7 @@ static enum token_type combine(struct token *left, st=
ruct token *right, char *p)
=20
 static int merge(struct token *left, struct token *right)
 {
-	static char buffer[512];
+	static char buffer[4097];
 	enum token_type res =3D combine(left, right, buffer);
 	int n;
=20
@@ -782,17 +807,22 @@ static int expand(struct token **list, struct symbo=
l *sym)
=20
 static const char *token_name_sequence(struct token *token, int endop, s=
truct token *start)
 {
-	static char buffer[256];
+	static char buffer[PATH_MAX];
 	char *ptr =3D buffer;
=20
 	while (!eof_token(token) && !match_op(token, endop)) {
-		int len;
+		size_t len, rem;
 		const char *val;
 		if (token_type(token) =3D=3D TOKEN_STRING)
 			val =3D token->string->data;
 		else
 			val =3D show_token(token);
 		len =3D strlen(val);
+		rem =3D sizeof(buffer) - (size_t)(ptr - buffer);
+		if (len >=3D rem) {
+			sparse_error(token->pos, "header name too long");
+			return NULL;
+		}
 		memcpy(ptr, val, len);
 		ptr +=3D len;
 		token =3D token->next;
@@ -896,23 +926,30 @@ static void set_stream_include_path(struct stream *=
stream)
 static int try_include(struct position pos, const char *path, const char=
 *filename, int flen, struct token **where, const char **next_path)
 {
 	int fd;
+	struct stat st;
 	int plen =3D strlen(path);
-	static char fullname[PATH_MAX];
+	char fullname[PATH_MAX];
=20
+	if (!flen || plen + flen + 2 > sizeof(fullname))
+		return 0;
 	memcpy(fullname, path, plen);
 	if (plen && path[plen-1] !=3D '/') {
 		fullname[plen] =3D '/';
 		plen++;
 	}
 	memcpy(fullname+plen, filename, flen);
+	fullname[plen + flen] =3D '\0';
 	if (already_tokenized(fullname))
 		return 1;
 	fd =3D open(fullname, O_RDONLY);
 	if (fd >=3D 0) {
-		char *streamname =3D xmemdup(fullname, plen + flen);
-		*where =3D tokenize(&pos, streamname, fd, *where, next_path);
+		if (fstat(fd, &st) =3D=3D 0 && !S_ISDIR(st.st_mode)) {
+			char *streamname =3D xmemdup(fullname, plen + flen + 1);
+			*where =3D tokenize(&pos, streamname, fd, *where, next_path);
+			close(fd);
+			return 1;
+		}
 		close(fd);
-		return 1;
 	}
 	return 0;
 }
@@ -961,6 +998,8 @@ static int handle_include_path(struct stream *stream,=
 struct token **list, struc
=20
 	token =3D next->next;
 	filename =3D token_name_sequence(token, expect, token);
+	if (!filename)
+		return 1;
 	flen =3D strlen(filename) + 1;
=20
 	/* Absolute path? */
@@ -1649,6 +1688,14 @@ static int expression_value(struct token **where)
 		list =3D &p->next;
 	}
=20
+	if (state =3D=3D 1 || state =3D=3D 2) {
+		sparse_error((*beginning)->pos, "expected identifier after \"defined\"=
");
+		replace_with_bool(*beginning, 0);
+		(*beginning)->next =3D &eof_token_entry;
+	} else if (state =3D=3D 3) {
+		sparse_error((*beginning)->pos, "missing ')' after \"defined\"");
+	}
+
 	p =3D constant_expression(*where, &expr);
 	if (!eof_token(p))
 		sparse_error(p->pos, "garbage at end: %s", show_token_sequence(p, 0));
diff --git a/validation/preprocessor/preprocess-crash-fixes.c b/validatio=
n/preprocessor/preprocess-crash-fixes.c
new file mode 100644
index 000000000000..92ea1ecde717
--- /dev/null
+++ b/validation/preprocessor/preprocess-crash-fixes.c
@@ -0,0 +1,25 @@
+#define REC_A(...) REC_B(__VA_ARGS__)
+#define REC_B(...) REC_A(__VA_ARGS__)
+extern int REC_A(int, ...);
+int rec_nonempty =3D sizeof(REC_A(1));
+
+/* Recursive macro with empty __VA_ARGS__ must terminate without crash *=
/
+#define REC_E(...) REC_F(__VA_ARGS__)
+#define REC_F(...) REC_E(__VA_ARGS__)
+extern int REC_E(void);
+int rec_empty =3D sizeof(REC_E());
+
+#define ID(x) x
+int a =3D ID(1);
+
+/* Octal escape > 0377 */
+int oct_overflow =3D '\400';
+
+/*
+ * check-name: preprocess-crash-fixes
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+preprocessor/preprocess-crash-fixes.c:16:20: warning: octal escape seque=
nce out of range
+ * check-error-end
+ */
diff --git a/validation/preprocessor/preprocess-errors-and-limits.c b/val=
idation/preprocessor/preprocess-errors-and-limits.c
new file mode 100644
index 000000000000..7ad1265ba9c0
--- /dev/null
+++ b/validation/preprocessor/preprocess-errors-and-limits.c
@@ -0,0 +1,33 @@
+#if defined()
+#endif
+#if defined(FOO
+#endif
+#if defined
+#endif
+#if defined(
+#endif
+#include "."
+static const char *s =3D "\x";
+
+/* 300-character identifier */
+static int aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaa =3D 42;
+
+static int get_val(void)
+{
+	return aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaa;
+}
+
+/*
+ * check-name: preprocess-errors-and-limits
+ * check-command: sparse $file
+ * check-exit-value: 1
+ *
+ * check-error-start
+preprocessor/preprocess-errors-and-limits.c:10:27: warning: \x used with=
 no following hex digits
+preprocessor/preprocess-errors-and-limits.c:1:13: error: expected prepro=
cessor identifier
+preprocessor/preprocess-errors-and-limits.c:3:13: error: missing ')' aft=
er "defined"
+preprocessor/preprocess-errors-and-limits.c:5:5: error: expected identif=
ier after "defined"
+preprocessor/preprocess-errors-and-limits.c:7:5: error: expected identif=
ier after "defined"
+preprocessor/preprocess-errors-and-limits.c:9:10: error: unable to open =
'.'
+ * check-error-end
+ */
