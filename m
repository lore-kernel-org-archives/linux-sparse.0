Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256434;
	b=B43+g4C5DzgjPxjsMnXAzIxQBSgzwjaFldPNrSKyv6nqWC32n4pRYKUScePwo3o0JU0B
	 XqaEQn0o2oBG7ILn+FDsmTp7Nk8jiCMLae58NnCLFqLJ+cLnqX/WBaEpC9ZVv+l0PmT92
	 NKbHmXmgztilk0JdBGnV3FJuDxwH13QaDmNS8Vwl/OsSxi1YghWQBApbbO1Wy6LiIIz0a
	 F+ojM0Eq5gmob4l3d0QzN3KxyyuNJECOdpehXrU1/CMn7iKS7vDWHf0Av2L9sFbkIuJTd
	 NFcpMqUjBoTFacIB3aWqQd9wzKT8z+sQvNVacnh28du4a+fEs68jfxEeRa9S3FHowFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=D8sM2ZRynU90xRnBlGAshgVvo3nZTfHwU5GvzTwSb0Q=;
	b=Y+jberJp3uEWsWqHNhAAGrOL12lAa8KC8YAG33tjo8kdkSOP0Wx1gwJGFjP0LDJvDbDq
	 DlDOSPmrFUULm+NdmgVmNp4TIY60TszLMCE/nTXHsNj9GG7CHAwkf6DCzJYBTUQq/dPQI
	 W39uJbSX4eR07OkleLG/3+EUBoIMBCVQ8WkJR0fADjZ3vsrRAXLED8ozjUJLZhYUhZbkc
	 sXcNPn9nBRkQvDtovO+8JZvlxjAStbo112mMYtJvOMStiuAgY0XxG1qexK3D8OrkgHkv7
	 kFenpWUGhr0NMF5qFlq2l5chUUDqb509Lv7T6bpfsiDWATofK7ficAoDAJalFjjQRHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xkjqDVTR;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE9606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AACE9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=xkjqDVTR
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMG6nxzz1XM6JG;
	Mon,  9 Nov 2026 20:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=D8sM2
	ZRynU90xRnBlGAshgVvo3nZTfHwU5GvzTwSb0Q=; b=xkjqDVTRnDepU9UBHmI3R
	zE/M8Qr+nm5ahg3PDV9TExMgRnNOWSaplcpC/DQSUrI5se70jB1uTUiaHepvgHbY
	G+0jgjFyrvptQTcPBbH1XcH6kjxN7fWaX40uDH32nZnjt/vWY2nQ2Gq3Q9KTuYPw
	i21V8O+tueQlRERoU9LIV8AmYJrCJDcpoCvXeg18VJCGuSnrLO8MzZgzjGw1d5SR
	v07Tq/qU8q6/IHlgXj2F5DBVt66bImYSA4Fb+1jBfwe8bwyll7Lk/Hx8qSZzUerD
	/B0RLLGcSsk4BiUeWtWSDecrNeGGS0xLnmDsJufdXPXjaY5qhcEUOHzB1K9LIAfC
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gs5VqXItsKef; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM45QP6z1XM5kD;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 56/73] preprocessor: Add support for #embed directive
Date: Mon,  9 Nov 2026 12:32:42 -0800
Message-ID: <20261109203259.362845-57-bvanassche@acm.org>
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

Add support for the C23 #embed preprocessor directive to embed binary
resource files into source code as comma-delimited integer constant
sequences, supporting the standard limit, prefix, suffix, and if_empty
parameters.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 pre-process.c                                | 396 +++++++++++++++++++
 validation/preprocessor/c23-embed-error.c    |  19 +
 validation/preprocessor/c23-embed-pedantic.c |  12 +
 validation/preprocessor/c23-embed.c          |  72 ++++
 4 files changed, 499 insertions(+)
 create mode 100644 validation/preprocessor/c23-embed-error.c
 create mode 100644 validation/preprocessor/c23-embed-pedantic.c
 create mode 100644 validation/preprocessor/c23-embed.c

diff --git a/pre-process.c b/pre-process.c
index e8b3511c225e..428b96f990fb 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -35,6 +35,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <time.h>
+#include <errno.h>
 #include <sys/stat.h>
=20
 #include "lib.h"
@@ -1661,6 +1662,400 @@ err:
 	return false;
 }
=20
+static int open_embed_file(struct stream *stream, const char *filename,
+			   int expect)
+{
+	char fullname[PATH_MAX];
+	const char **path;
+	size_t flen =3D strlen(filename);
+
+	if (filename[0] =3D=3D '/')
+		return open(filename, O_RDONLY);
+
+	set_stream_include_path(stream);
+	path =3D expect ? angle_includepath : quote_includepath;
+	if (!path)
+		return -1;
+	while (*path !=3D NULL) {
+		const char *p =3D *path++;
+		size_t plen =3D strlen(p);
+		if (plen + flen + 2 > sizeof(fullname))
+			continue;
+		memcpy(fullname, p, plen);
+		if (plen && p[plen - 1] !=3D '/') {
+			fullname[plen] =3D '/';
+			plen++;
+		}
+		memcpy(fullname + plen, filename, flen + 1);
+		int fd =3D open(fullname, O_RDONLY);
+		if (fd >=3D 0)
+			return fd;
+	}
+	return -1;
+}
+
+static int free_preprocessor_line(struct token *token);
+
+static int handle_embed(struct stream *stream, struct token **line,
+			struct token *token)
+{
+	char filename[PATH_MAX];
+	int expect =3D 0;
+	struct token *next =3D token->next;
+	struct token **param_p;
+	struct token *prefix_start =3D NULL, *prefix_end =3D NULL;
+	struct token *suffix_start =3D NULL, *suffix_end =3D NULL;
+	struct token *if_empty_start =3D NULL, *if_empty_end =3D NULL;
+	int has_limit =3D 0;
+	unsigned long long limit_val =3D ~0ULL;
+	unsigned int seen_params =3D 0;
+	int fd;
+	struct stat st;
+	unsigned char *buf =3D NULL;
+	ssize_t bytes_read =3D 0;
+	struct token *head =3D NULL, **tail =3D &head;
+	static char num_strs[256][4];
+	static int num_strs_inited =3D 0;
+
+	if (standard < STANDARD_C23 && Wpedantic)
+		warning(token->pos, "#embed before C23 is an extension");
+
+	next =3D scan_next(&token->next);
+	if (match_op(next, '<')) {
+		expect =3D '>';
+		next =3D next->next;
+		if (!collect_angle_filename(&next, filename, sizeof(filename),
+					    token->pos))
+			return 1;
+	} else if (token_type(next) =3D=3D TOKEN_STRING) {
+		if (!extract_string_filename(&next, filename, sizeof(filename)))
+			return 1;
+	} else {
+		while (token_type(next =3D scan_next(&token->next)) =3D=3D
+			       TOKEN_IDENT &&
+		       !expand_one_symbol(&token->next))
+			;
+		next =3D scan_next(&token->next);
+		if (match_op(next, '<')) {
+			struct token **p =3D &next->next;
+			struct token *t;
+
+			while (!eof_token(t =3D scan_next(p)) &&
+			       !match_op(t, '>')) {
+				if (token_type(t) !=3D TOKEN_IDENT ||
+				    expand_one_symbol(p))
+					p =3D &t->next;
+			}
+			expect =3D '>';
+			next =3D next->next;
+			if (!collect_angle_filename(&next, filename,
+						    sizeof(filename),
+						    token->pos))
+				return 1;
+		} else if (token_type(next) =3D=3D TOKEN_STRING) {
+			if (!extract_string_filename(&next, filename,
+						     sizeof(filename)))
+				return 1;
+		} else {
+			sparse_error(next->pos,
+				     "expected \"FILENAME\" or <FILENAME>");
+			return 1;
+		}
+	}
+
+	param_p =3D &next;
+	while (!eof_token(next =3D scan_next(param_p))) {
+		if (token_type(next) =3D=3D TOKEN_IDENT) {
+			struct ident *id;
+			struct position id_pos;
+			enum embed_param_kind kind;
+			struct token *pstart, *pend =3D NULL;
+			int depth =3D 1;
+
+			if (!expand_one_symbol(param_p))
+				continue;
+			next =3D *param_p;
+			if (token_type(next) !=3D TOKEN_IDENT) {
+				sparse_error(next->pos,
+					     "unexpected token in #embed");
+				return 1;
+			}
+			id =3D next->ident;
+			id_pos =3D next->pos;
+			if (match_op(next->next, ':') &&
+			    match_op(next->next->next, ':')) {
+				struct token *attr =3D next->next->next->next;
+
+				if (token_type(attr) =3D=3D TOKEN_IDENT)
+					sparse_error(
+						id_pos,
+						"unknown embed parameter '%s::%s'",
+						show_ident(id),
+						show_ident(attr->ident));
+				else
+					sparse_error(attr->pos,
+						     "identifier expected");
+				return 1;
+			}
+
+			kind =3D classify_embed_param(id);
+			if (kind =3D=3D EMBED_PARAM_NONE) {
+				sparse_error(id_pos,
+					     "unknown embed parameter '%s'",
+					     show_ident(id));
+				return 1;
+			}
+			if (seen_params & kind) {
+				sparse_error(id_pos,
+					     "duplicate embed parameter '%s'",
+					     show_ident(id));
+				return 1;
+			}
+			seen_params |=3D kind;
+
+			next =3D scan_next(&next->next);
+			if (!match_op(next, '(')) {
+				sparse_error(id_pos, "expected '(' after '%s'",
+					     show_ident(id));
+				return 1;
+			}
+			pstart =3D next->next;
+			next =3D next->next;
+			while (!eof_token(next) && depth > 0) {
+				if (match_op(next, '('))
+					depth++;
+				else if (match_op(next, ')') && !--depth)
+					break;
+				pend =3D next;
+				next =3D next->next;
+			}
+			if (!match_op(next, ')')) {
+				sparse_error(id_pos, "expected ')'");
+				return 1;
+			}
+			next =3D next->next;
+			if (kind =3D=3D EMBED_PARAM_LIMIT) {
+				if (!eval_embed_limit_expr(id_pos, pstart, pend,
+							   &limit_val))
+					return 1;
+				has_limit =3D 1;
+			} else if (kind =3D=3D EMBED_PARAM_PREFIX) {
+				prefix_start =3D pstart;
+				prefix_end =3D pend;
+			} else if (kind =3D=3D EMBED_PARAM_SUFFIX) {
+				suffix_start =3D pstart;
+				suffix_end =3D pend;
+			} else if (kind =3D=3D EMBED_PARAM_IF_EMPTY) {
+				if_empty_start =3D pstart;
+				if_empty_end =3D pend;
+			}
+			param_p =3D &next;
+			continue;
+		}
+		sparse_error(next->pos, "unexpected token in #embed");
+		return 1;
+	}
+
+	fd =3D open_embed_file(stream, filename, expect);
+	if (fd < 0) {
+		sparse_error(token->pos, "unable to open '%s'", filename);
+		return 1;
+	}
+
+	if (fstat(fd, &st) < 0) {
+		close(fd);
+		sparse_error(token->pos, "unable to stat '%s'", filename);
+		return 1;
+	}
+	if (S_ISDIR(st.st_mode)) {
+		close(fd);
+		sparse_error(token->pos, "'%s' is a directory", filename);
+		return 1;
+	}
+
+	if (S_ISREG(st.st_mode) || has_limit) {
+		unsigned long long to_read =3D
+			S_ISREG(st.st_mode) ? (unsigned long long)st.st_size :
+					      limit_val;
+
+		if (has_limit && limit_val < to_read)
+			to_read =3D limit_val;
+		if (to_read > MAX_EMBED_SIZE) {
+			sparse_error(
+				token->pos,
+				"'%s' is too large to embed (%llu bytes, max %d bytes)",
+				filename, to_read, MAX_EMBED_SIZE);
+			close(fd);
+			return 1;
+		}
+		buf =3D malloc(to_read ? to_read : 1);
+		if (!buf) {
+			sparse_error(
+				token->pos,
+				"out of memory allocating #embed buffer for '%s'",
+				filename);
+			close(fd);
+			return 1;
+		}
+		if (to_read > 0) {
+			size_t total =3D 0;
+
+			while (total < to_read) {
+				ssize_t r =3D
+					read(fd, buf + total, to_read - total);
+				if (r < 0) {
+					if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
+						continue;
+					sparse_error(token->pos,
+						     "error reading '%s': %s",
+						     filename, strerror(errno));
+					free(buf);
+					close(fd);
+					return 1;
+				}
+				if (r =3D=3D 0)
+					break;
+				total +=3D r;
+			}
+			bytes_read =3D total;
+		}
+	} else {
+		size_t cap =3D 4096;
+		size_t total =3D 0;
+
+		buf =3D malloc(cap);
+		if (!buf) {
+			sparse_error(
+				token->pos,
+				"out of memory allocating #embed buffer for '%s'",
+				filename);
+			close(fd);
+			return 1;
+		}
+		for (;;) {
+			ssize_t r;
+
+			if (total =3D=3D cap) {
+				size_t new_cap =3D cap * 2;
+				unsigned char *nbuf;
+
+				if (new_cap > MAX_EMBED_SIZE + 1)
+					new_cap =3D MAX_EMBED_SIZE + 1;
+				nbuf =3D realloc(buf, new_cap);
+				if (!nbuf) {
+					sparse_error(
+						token->pos,
+						"out of memory allocating #embed buffer for '%s'",
+						filename);
+					free(buf);
+					close(fd);
+					return 1;
+				}
+				buf =3D nbuf;
+				cap =3D new_cap;
+			}
+			r =3D read(fd, buf + total, cap - total);
+			if (r < 0) {
+				if (errno =3D=3D EINTR || errno =3D=3D EAGAIN)
+					continue;
+				sparse_error(token->pos,
+					     "error reading '%s': %s",
+					     filename, strerror(errno));
+				free(buf);
+				close(fd);
+				return 1;
+			}
+			if (r =3D=3D 0)
+				break;
+			total +=3D r;
+			if (total > MAX_EMBED_SIZE) {
+				sparse_error(
+					token->pos,
+					"'%s' is too large to embed (max %d bytes)",
+					filename, MAX_EMBED_SIZE);
+				free(buf);
+				close(fd);
+				return 1;
+			}
+		}
+		bytes_read =3D total;
+	}
+	close(fd);
+
+	if (bytes_read =3D=3D 0) {
+		if (if_empty_start && if_empty_end) {
+			struct token *p =3D if_empty_start;
+			while (p) {
+				struct token *t =3D dup_token(p, &token->pos);
+				*tail =3D t;
+				tail =3D &t->next;
+				if (p =3D=3D if_empty_end)
+					break;
+				p =3D p->next;
+			}
+			*tail =3D *line;
+			*line =3D head;
+		}
+		free(buf);
+		free_preprocessor_line(token);
+		return 0;
+	}
+
+	if (prefix_start && prefix_end) {
+		struct token *p =3D prefix_start;
+		while (p) {
+			struct token *t =3D dup_token(p, &token->pos);
+			*tail =3D t;
+			tail =3D &t->next;
+			if (p =3D=3D prefix_end)
+				break;
+			p =3D p->next;
+		}
+	}
+
+	if (!num_strs_inited) {
+		for (unsigned int i =3D 0; i < 256; i++)
+			snprintf(num_strs[i], sizeof(num_strs[i]), "%u",
+				 i & 0xff);
+		num_strs_inited =3D 1;
+	}
+
+	for (ssize_t i =3D 0; i < bytes_read; i++) {
+		if (i > 0) {
+			struct token *comma =3D alloc_token(&token->pos);
+			token_type(comma) =3D TOKEN_SPECIAL;
+			comma->special =3D ',';
+			*tail =3D comma;
+			tail =3D &comma->next;
+		}
+		struct token *num =3D alloc_token(&token->pos);
+		token_type(num) =3D TOKEN_NUMBER;
+		num->number =3D num_strs[buf[i]];
+		*tail =3D num;
+		tail =3D &num->next;
+	}
+
+	if (suffix_start && suffix_end) {
+		struct token *p =3D suffix_start;
+		while (p) {
+			struct token *t =3D dup_token(p, &token->pos);
+			*tail =3D t;
+			tail =3D &t->next;
+			if (p =3D=3D suffix_end)
+				break;
+			p =3D p->next;
+		}
+	}
+
+	if (head) {
+		*tail =3D *line;
+		*line =3D head;
+	}
+	free(buf);
+	free_preprocessor_line(token);
+	return 0;
+}
+
 static int free_preprocessor_line(struct token *token)
 {
 	while (token_type(token) !=3D TOKEN_EOF) {
@@ -2993,6 +3388,7 @@ static void init_preprocessor(void)
 		{ "error",		handle_error },
 		{ "include",		handle_include },
 		{ "include_next",	handle_include_next },
+		{ "embed",		handle_embed },
 		{ "pragma",		handle_pragma },
 		{ "line",		handle_line },
 		{ "ident",		handle_ident },
diff --git a/validation/preprocessor/c23-embed-error.c b/validation/prepr=
ocessor/c23-embed-error.c
new file mode 100644
index 000000000000..26bfd4bc40c7
--- /dev/null
+++ b/validation/preprocessor/c23-embed-error.c
@@ -0,0 +1,19 @@
+int outside =3D __has_embed("options.h");
+
+#if __has_embed("options.h" limit(1) limit(2))
+#endif
+
+#embed "options.h" limit(1) __limit__(2)
+#embed "options.h" vendor::param(1)
+
+/*
+ * check-name: c23-embed-error
+ * check-command: sparse -std=3Dc23 -Wno-decl -I.. $file
+ *
+ * check-error-start
+preprocessor/c23-embed-error.c:1:15: error: '__has_embed' used outside o=
f preprocessing directive
+preprocessor/c23-embed-error.c:3:38: error: duplicate embed parameter 'l=
imit'
+preprocessor/c23-embed-error.c:6:29: error: duplicate embed parameter '_=
_limit__'
+preprocessor/c23-embed-error.c:7:20: error: unknown embed parameter 'ven=
dor::param'
+ * check-error-end
+ */
diff --git a/validation/preprocessor/c23-embed-pedantic.c b/validation/pr=
eprocessor/c23-embed-pedantic.c
new file mode 100644
index 000000000000..8e78aa4121da
--- /dev/null
+++ b/validation/preprocessor/c23-embed-pedantic.c
@@ -0,0 +1,12 @@
+static const unsigned char data[] =3D {
+#embed "options.h" limit(1)
+};
+
+/*
+ * check-name: c23-embed-pedantic
+ * check-command: sparse -std=3Dc11 -Wpedantic -I.. $file
+ *
+ * check-error-start
+preprocessor/c23-embed-pedantic.c:2:2: warning: #embed before C23 is an =
extension
+ * check-error-end
+ */
diff --git a/validation/preprocessor/c23-embed.c b/validation/preprocesso=
r/c23-embed.c
new file mode 100644
index 000000000000..a4411847b9cb
--- /dev/null
+++ b/validation/preprocessor/c23-embed.c
@@ -0,0 +1,72 @@
+static const unsigned char data[] =3D {
+#embed "options.h" limit(4)
+};
+
+static const unsigned char with_params[] =3D {
+#embed "options.h" limit(2) prefix(10, 20, ) suffix(, 30, 40)
+};
+
+static const unsigned char dunder_params[] =3D {
+#embed "options.h" __limit__(2) __prefix__(10, ) __suffix__(, 20)
+};
+
+static const unsigned char empty_buf[] =3D {
+#embed "options.h" limit(0) if_empty(99)
+};
+
+static const unsigned char dev_null_buf[] =3D {
+#embed "/dev/null" __if_empty__(77)
+};
+
+static const unsigned char zero_buf[] =3D {
+#embed "/dev/zero" limit(4)
+};
+
+static const unsigned char nested_has_embed[] =3D {
+#embed "options.h" limit(__has_embed("options.h"))
+};
+
+static_assert(sizeof(data) =3D=3D 4, "size data");
+static_assert(sizeof(with_params) =3D=3D 6, "size with_params");
+static_assert(sizeof(dunder_params) =3D=3D 4, "size dunder_params");
+static_assert(sizeof(empty_buf) =3D=3D 1, "size empty_buf");
+static_assert(sizeof(dev_null_buf) =3D=3D 1, "size dev_null_buf");
+static_assert(sizeof(zero_buf) =3D=3D 4, "size zero_buf");
+static_assert(sizeof(nested_has_embed) =3D=3D 1, "size nested_has_embed"=
);
+
+static constexpr unsigned char p0 =3D
+#embed "options.h" limit(1) prefix(10 + ) suffix( + 5)
+	;
+static_assert(p0 =3D=3D 50, "p0");
+
+static constexpr unsigned char z0 =3D
+#embed "/dev/zero" limit(1)
+	;
+static_assert(z0 =3D=3D 0, "z0");
+
+static constexpr unsigned char b0 =3D
+#embed "options.h" limit(1)
+	;
+static_assert(b0 =3D=3D 35, "b0");
+
+#define EMBED_HDR "options.h"
+static const unsigned char macro_hdr_params[] =3D {
+#embed EMBED_HDR limit(2) if_empty(__COUNTER__) prefix(11, )
+};
+static_assert(__COUNTER__ =3D=3D 0, "if_empty not expanded when non-empt=
y");
+static_assert(sizeof(macro_hdr_params) =3D=3D 3, "size macro_hdr_params"=
);
+
+static constexpr unsigned char macro_hdr_p0 =3D
+#embed EMBED_HDR limit(1) if_empty(__COUNTER__) prefix(10 + )
+	;
+static_assert(macro_hdr_p0 =3D=3D 45, "macro_hdr_p0");
+
+static const unsigned char large_limit_buf[] =3D {
+#embed "options.h" limit(1ULL << 63)
+};
+static_assert(sizeof(large_limit_buf) > 4, "size large_limit_buf");
+
+/*
+ * check-name: c23-embed
+ * check-command: sparse -std=3Dc23 -Wno-decl -I.. $file
+ */
