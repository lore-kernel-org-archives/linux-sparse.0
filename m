Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256431;
	b=SB8EAuM8kRlLv6WHiXPaI0uyHe5HYfKF8ebgK4MXkX6sZVGP2DIjHZmIadr/uwi+2ROr
	 Ge5O4VDJrZhv2gcgE6uJoRVvC1Vkz8zA9H/RFW59ur0uHVk7IwSLR71jqETQuVtPkwBQ/
	 yg5wODMRdZyUBkmnm4sPf/fByt1KhpV21TIHQOMW+AS/jox4jVwcATj970X2uZqZFcIrz
	 Wqg2IIboc1PDkHGsjuTgQDjxdsXa1h5RCSIX9H0cWcIHpKZtNJRIfXpena/+7s2YoXMXf
	 Ngn/vDidz51LoZ+ouUKnwPC6dZXBeVdFhCw1IC35JZDm8c6A9JfIm/o8zMRW8rPjcuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256431;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=MDM78Vta1MObj9S7Uyi6aDhbW9+LA9Bvp1zU9Sd6L4c=;
	b=s+IOre9iEqihjYSeVRUZkOTLf/lO0t9heki/M+N8e2RN0LKGG7lghxUTgKhf5nMR+9+Z
	 IsH8PJAEH3fsWPgKLMrXVAq/hds+eJjhTndo0KxF49kwUnUSVCSzzRjxpn7VEz7pFH3f0
	 rY0c/jUHsHkUnT9jB5I5EAybYEFGQKbZJB96Hs0b4obzGHJ2QsO2WdGiv06bAvTB7i3vY
	 U5/2xvQ516mIjIhBv/wwEAxnhYWmqGMVEoVbEhfTb5OotUIb/sJScDeBTS4qVrZ78WUUo
	 yXQgT7QNo//iom4FSYa4aR4V+KTEkOyiBtmo1qnfoSVlZtjhLlqQmb0sypVZS0tYUfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b="BYRO//cD";
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595F606A331
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4595F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=BYRO//cD
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMD4vbyz1XLwXQ;
	Mon,  9 Nov 2026 20:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256416; x=1796848417; bh=MDM78
	Vta1MObj9S7Uyi6aDhbW9+LA9Bvp1zU9Sd6L4c=; b=BYRO//cDNm3BDi7NqdkmM
	Jp9O6psuA0SJAo6UOcknlHgML6kSx/+0991jUHT1968ymBnZ/1ef/Le+1L85a+y1
	LgFYbboI6afnWZqAM0XTMoenPC4e/9hXhNKr1eW7wus5ygK6azV1vTdK+xi0TVxo
	Fd4LjSqv9GeDqohNeccgzvoQwq45gHWiw1e1mxoFoVPdsWncPt2C/e904dvUOpPk
	XSyRGUWoIIrkZuHTpnAQH7T/BR9olsL6uKTlVV5Bf2uJoFHEVJdOr6zc1p/mznww
	G7Rrju3CGzUs5/fbK6qhHCKmRHIdAVPYj0nS8djQ6lSWAES8cvGbbdPsT7MB434S
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fGbw0uXSuPj3; Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM136pwz1XMYJX;
	Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 41/73] preprocessor: Add support for __has_include and __has_include_next
Date: Mon,  9 Nov 2026 12:32:27 -0800
Message-ID: <20261109203259.362845-42-bvanassche@acm.org>
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

Support the C23 __has_include and __has_include_next preprocessor
operators for querying the availability of header files so that code
using feature test macros can conditionally include headers portably.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ident-list.h                                  |   2 +
 pre-process.c                                 | 303 +++++++++++++++++-
 .../preprocessor/c23-has-include-error.c      |  18 ++
 validation/preprocessor/c23-has-include.c     |  51 +++
 4 files changed, 363 insertions(+), 11 deletions(-)
 create mode 100644 validation/preprocessor/c23-has-include-error.c
 create mode 100644 validation/preprocessor/c23-has-include.c

diff --git a/ident-list.h b/ident-list.h
index 3c08e8ca9aa4..5f4d1fef5a81 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -68,6 +68,8 @@ __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
+__IDENT(__has_include_ident, "__has_include", 0);
+__IDENT(__has_include_next_ident, "__has_include_next", 0);
=20
 /* Sparse commands */
 IDENT_RESERVED(__context__);
diff --git a/pre-process.c b/pre-process.c
index aa59dca1ae97..fbe4ba215532 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -50,6 +50,7 @@ static int false_nesting =3D 0;
 static int counter_macro =3D 0;		// __COUNTER__ expansion
 static int include_level =3D 0;
 static int expanding =3D 0;
+static int in_cond_expr =3D 0;
=20
 #define INCLUDEPATHS 300
 const char *includepath[INCLUDEPATHS+1] =3D {
@@ -762,6 +763,32 @@ static struct token **substitute(struct token **list=
, const struct token *body,
 	return list;
 }
=20
+static bool parse_has_include(struct token **list, int how);
+
+static void reject_outside_directive(struct token *token)
+{
+	struct token *next;
+
+	sparse_error(token->pos, "'%s' used outside of preprocessing directive"=
,
+		     show_token(token));
+	next =3D scan_next(&token->next);
+	if (match_op(next, '(')) {
+		int depth =3D 1;
+
+		next =3D next->next;
+		while (!eof_token(next) && depth > 0) {
+			if (match_op(next, '('))
+				depth++;
+			else if (match_op(next, ')'))
+				depth--;
+			next =3D next->next;
+		}
+	}
+	token_type(token) =3D TOKEN_NUMBER;
+	token->number =3D "0";
+	token->next =3D next;
+}
+
 static int expand(struct token **list, struct symbol *sym)
 {
 	struct token *last;
@@ -777,6 +804,23 @@ static int expand(struct token **list, struct symbol=
 *sym)
 		return 1;
 	}
=20
+	if (expanding =3D=3D &__has_include_ident ||
+	    expanding =3D=3D &__has_include_next_ident) {
+		bool ok;
+
+		if (!in_cond_expr) {
+			reject_outside_directive(token);
+			return 0;
+		}
+		if (expanding =3D=3D &__has_include_ident)
+			ok =3D parse_has_include(list, 0);
+		else
+			ok =3D parse_has_include(list, 1);
+		if (!ok)
+			replace_with_bool(token, 0);
+		return 0;
+	}
+
 	if (sym->arglist) {
 		if (!match_op(scan_next(&token->next), '('))
 			return 1;
@@ -788,6 +832,9 @@ static int expand(struct token **list, struct symbol =
*sym)
 	if (sym->expand)
 		return sym->expand(token, args) ? 0 : 1;
=20
+	if (!expansion)
+		return 1;
+
 	expanding->tainted =3D 1;
=20
 	last =3D token->next;
@@ -966,6 +1013,224 @@ static int do_include_path(const char **pptr, stru=
ct token **list, struct token
 	return 0;
 }
=20
+static int test_include(const char *path, const char *filename)
+{
+	int fd;
+	struct stat st;
+	int plen =3D strlen(path);
+	int flen =3D strlen(filename);
+	char fullname[PATH_MAX];
+
+	if (plen + flen + 2 > sizeof(fullname))
+		return 0;
+	memcpy(fullname, path, plen);
+	if (plen && path[plen - 1] !=3D '/') {
+		fullname[plen] =3D '/';
+		plen++;
+	}
+	memcpy(fullname + plen, filename, flen + 1);
+	if (already_tokenized(fullname))
+		return 1;
+	fd =3D open(fullname, O_RDONLY);
+	if (fd >=3D 0) {
+		if (fstat(fd, &st) =3D=3D 0 && S_ISREG(st.st_mode)) {
+			close(fd);
+			return 1;
+		}
+		close(fd);
+	}
+	return 0;
+}
+
+static int check_include(const char **pptr, const char *filename)
+{
+	const char *path;
+	while ((path =3D *pptr++) !=3D NULL) {
+		if (test_include(path, filename))
+			return 1;
+	}
+	return 0;
+}
+
+static int check_has_include(struct stream *stream, const char *filename=
,
+			     int expect, int how)
+{
+	const char **path;
+
+	/* Absolute path? */
+	if (filename[0] =3D=3D '/')
+		return test_include("", filename);
+
+	switch (how) {
+	case 1:
+		path =3D stream->next_path;
+		break;
+	default:
+		set_stream_include_path(stream);
+		path =3D expect ? angle_includepath : quote_includepath;
+		break;
+	}
+	if (!path)
+		return 0;
+	return check_include(path, filename);
+}
+
+static struct token *skip_balanced_parens(struct token *lparen)
+{
+	struct token *t;
+	int depth =3D 1;
+
+	if (!match_op(lparen, '('))
+		return lparen;
+	t =3D lparen->next;
+	while (!eof_token(t) && depth > 0) {
+		if (match_op(t, '('))
+			depth++;
+		else if (match_op(t, ')'))
+			depth--;
+		t =3D t->next;
+	}
+	return t;
+}
+
+static bool collect_angle_filename(struct token **next_p, char *buf,
+				   size_t size, struct position pos)
+{
+	struct token *t =3D *next_p;
+	char *ptr =3D buf;
+
+	while (!eof_token(t) && !match_op(t, '>')) {
+		const char *s =3D (token_type(t) =3D=3D TOKEN_STRING) ?
+					t->string->data :
+					show_token(t);
+		size_t len =3D strlen(s);
+		size_t rem =3D size - (size_t)(ptr - buf);
+
+		if (len >=3D rem) {
+			sparse_error(t->pos, "header name too long");
+			return false;
+		}
+		memcpy(ptr, s, len);
+		ptr +=3D len;
+		t =3D t->next;
+	}
+	*ptr =3D '\0';
+	if (!match_op(t, '>')) {
+		sparse_error(pos, "expected '>'");
+		return false;
+	}
+	if (ptr =3D=3D buf) {
+		sparse_error(pos, "empty filename");
+		return false;
+	}
+	*next_p =3D t->next;
+	return true;
+}
+
+static bool extract_string_filename(struct token **next_p, char *buf,
+				    size_t size)
+{
+	struct token *t =3D *next_p;
+	const char *s =3D t->string->data;
+	size_t len =3D strlen(s);
+
+	if (!len) {
+		sparse_error(t->pos, "empty filename");
+		return false;
+	}
+	if (len >=3D size) {
+		sparse_error(t->pos, "header name too long");
+		return false;
+	}
+	memcpy(buf, s, len + 1);
+	*next_p =3D t->next;
+	return true;
+}
+
+static bool parse_has_include(struct token **list, int how)
+{
+	struct token *token =3D *list;
+	struct token *lparen =3D scan_next(&token->next);
+	struct token *next;
+	struct stream *stream =3D input_streams + token->pos.stream;
+	char filename[PATH_MAX];
+	int expect =3D 0;
+	int val =3D 0;
+
+	if (!match_op(lparen, '(')) {
+		sparse_error(token->pos, "expected '(' after %s",
+			     show_token(token));
+		return false;
+	}
+	next =3D scan_next(&lparen->next);
+	if (match_op(next, '<')) {
+		expect =3D '>';
+		next =3D next->next;
+		if (!collect_angle_filename(&next, filename, sizeof(filename),
+					    token->pos))
+			goto err;
+	} else if (token_type(next) =3D=3D TOKEN_STRING) {
+		if (!extract_string_filename(&next, filename, sizeof(filename)))
+			goto err;
+	} else {
+		struct token **p =3D &lparen->next;
+		struct token *rparen =3D scan_next(p);
+		int depth =3D 1;
+
+		while (!eof_token(rparen)) {
+			if (match_op(rparen, '('))
+				depth++;
+			else if (match_op(rparen, ')') && !--depth)
+				break;
+			p =3D &rparen->next;
+			rparen =3D scan_next(p);
+		}
+		if (!match_op(rparen, ')')) {
+			sparse_error(rparen->pos, "expected ')'");
+			token->next =3D rparen;
+			return false;
+		}
+		*p =3D &eof_token_entry;
+		expand_list(&lparen->next);
+		p =3D &lparen->next;
+		while (!eof_token(*p))
+			p =3D &(*p)->next;
+		*p =3D rparen;
+		next =3D lparen->next;
+		if (match_op(next, '<')) {
+			expect =3D '>';
+			next =3D next->next;
+			if (!collect_angle_filename(&next, filename,
+						    sizeof(filename),
+						    token->pos))
+				goto err;
+		} else if (token_type(next) =3D=3D TOKEN_STRING) {
+			if (!extract_string_filename(&next, filename,
+						     sizeof(filename)))
+				goto err;
+		} else {
+			sparse_error(next->pos,
+				     "expected \"FILENAME\" or <FILENAME>");
+			goto err;
+		}
+	}
+	next =3D scan_next(&next);
+	if (!match_op(next, ')')) {
+		sparse_error(next->pos, "expected ')'");
+		goto err;
+	}
+	next =3D next->next;
+
+	val =3D check_has_include(stream, filename, expect, how);
+	replace_with_bool(token, val);
+	token->next =3D next;
+	return true;
+
+err:
+	token->next =3D skip_balanced_parens(lparen);
+	return false;
+}
+
 static int free_preprocessor_line(struct token *token)
 {
 	while (token_type(token) !=3D TOKEN_EOF) {
@@ -1645,6 +1910,7 @@ static int expression_value(struct token **where)
 	long long value;
 	int state =3D 0;
=20
+	in_cond_expr++;
 	while (!eof_token(p =3D scan_next(list))) {
 		switch (state) {
 		case 0:
@@ -1655,6 +1921,18 @@ static int expression_value(struct token **where)
 				beginning =3D list;
 				break;
 			}
+			if (p->ident =3D=3D &__has_include_ident) {
+				if (parse_has_include(list, 0))
+					continue;
+				replace_with_bool(p, 0);
+				break;
+			}
+			if (p->ident =3D=3D &__has_include_next_ident) {
+				if (parse_has_include(list, 1))
+					continue;
+				replace_with_bool(p, 0);
+				break;
+			}
 			if (!expand_one_symbol(list))
 				continue;
 			if (token_type(p) !=3D TOKEN_IDENT)
@@ -1700,6 +1978,7 @@ static int expression_value(struct token **where)
 	if (!eof_token(p))
 		sparse_error(p->pos, "garbage at end: %s", show_token_sequence(p, 0));
 	value =3D get_expression_value(expr);
+	in_cond_expr--;
 	return value !=3D 0;
 }
=20
@@ -2230,17 +2509,19 @@ static void init_preprocessor(void)
 		void (*expand_simple)(struct token *);
 		bool (*expand)(struct token *, struct arg *args);
 	} dynamic[] =3D {
-		{ "__LINE__",		expand_line },
-		{ "__FILE__",		expand_file },
-		{ "__BASE_FILE__",	expand_basefile },
-		{ "__DATE__",		expand_date },
-		{ "__TIME__",		expand_time },
-		{ "__COUNTER__",	expand_counter },
-		{ "__INCLUDE_LEVEL__",	expand_include_level },
-		{ "__has_attribute",	NULL, expand_has_attribute },
-		{ "__has_builtin",	NULL, expand_has_builtin },
-		{ "__has_extension",	NULL, expand_has_extension },
-		{ "__has_feature",	NULL, expand_has_feature },
+		{ "__LINE__", expand_line },
+		{ "__FILE__", expand_file },
+		{ "__BASE_FILE__", expand_basefile },
+		{ "__DATE__", expand_date },
+		{ "__TIME__", expand_time },
+		{ "__COUNTER__", expand_counter },
+		{ "__INCLUDE_LEVEL__", expand_include_level },
+		{ "__has_attribute", NULL, expand_has_attribute },
+		{ "__has_builtin", NULL, expand_has_builtin },
+		{ "__has_extension", NULL, expand_has_extension },
+		{ "__has_feature", NULL, expand_has_feature },
+		{ "__has_include", NULL, NULL },
+		{ "__has_include_next", NULL, NULL },
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(normal); i++) {
diff --git a/validation/preprocessor/c23-has-include-error.c b/validation=
/preprocessor/c23-has-include-error.c
new file mode 100644
index 000000000000..931eb47998a7
--- /dev/null
+++ b/validation/preprocessor/c23-has-include-error.c
@@ -0,0 +1,18 @@
+int outside =3D __has_include(<stdio.h>);
+
+#if __has_include("")
+#endif
+
+#if __has_include(<>)
+#endif
+
+/*
+ * check-name: c23-has-include-error
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ *
+ * check-error-start
+preprocessor/c23-has-include-error.c:1:15: error: '__has_include' used o=
utside of preprocessing directive
+preprocessor/c23-has-include-error.c:3:19: error: empty filename
+preprocessor/c23-has-include-error.c:6:5: error: empty filename
+ * check-error-end
+ */
diff --git a/validation/preprocessor/c23-has-include.c b/validation/prepr=
ocessor/c23-has-include.c
new file mode 100644
index 000000000000..fa32cc9d4992
--- /dev/null
+++ b/validation/preprocessor/c23-has-include.c
@@ -0,0 +1,51 @@
+#if defined(__has_include)
+int has_macro =3D 1;
+#endif
+
+#if __has_include(<stdio.h>)
+int has_stdio =3D 1;
+#else
+int has_stdio =3D 0;
+#endif
+
+#if __has_include("options.h")
+int has_options =3D 1;
+#endif
+
+#if __has_include(<nonexistent_header_12345.h>)
+int has_nonexistent =3D 1;
+#else
+int has_nonexistent =3D 0;
+#endif
+
+#define HEADER <stdio.h>
+#if __has_include(HEADER)
+int has_macro_header =3D 1;
+#endif
+
+#define HAS_INC __has_include
+#if HAS_INC(<stdio.h>) && HAS_INC("options.h")
+int has_aliased_op =3D 1;
+#endif
+
+#if __has_include("this_is_an_extremely_long_path_name_that_tests_bounds=
_checking_1234567890_abcdefghijklmnopqrstuvwxyz.h")
+int has_long =3D 1;
+#else
+int has_long =3D 0;
+#endif
+
+/*
+ * check-name: c23-has-include
+ * check-command: sparse -std=3Dc23 -E -I.. $file
+ *
+ * check-output-start
+
+int has_macro =3D 1;
+int has_stdio =3D 1;
+int has_options =3D 1;
+int has_nonexistent =3D 0;
+int has_macro_header =3D 1;
+int has_aliased_op =3D 1;
+int has_long =3D 0;
+ * check-output-end
+ */
