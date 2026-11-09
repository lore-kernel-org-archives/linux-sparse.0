Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256435;
	b=Zi/Z++oP/EYhX20YlW3OgwPSmWNNVcXzJ73gzZmtHU/TyIE/ERRfDKQLFMYwDpVESqDM
	 okZJiuJ3pj2wqoMJRp68UxCWi8DGP30iTlUV1PFRAhb1VaEwXmNtNnUIA5tLHKIh9Fq6i
	 RGYVOLhwRizaRV3HtJnoyZuXmmDaED9Svum3ZeWeEitxUlXbfGYQk+MS9Wqzrax7QpV83
	 xKx90ouqWwwUogowLRf9cp6a/78ChfUwUaaq6nZyuVSMc0EDw9WJkeTxVxitZlnNPXKqt
	 NRJfsGWC1xJ4JOwQn3c2Nx58hLf+xzuV2tHj1RRmqwBPiJ/q052cm2hBfV6H/QEm26Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=EQuri2RcPVGIrgW8jf4hjF/4wK/KGwQlcALCG7uw6y8=;
	b=ylnlBHVfZxgA6FtzlYyMRG4P5sab/ZCjOY9zN8jzFuzEDLCpgjer3zTnbipCETA0xF7t
	 jLzq/LFngQf1dkMjiiCIt+dCNDvyJ8o2+M3hbiYqcVDPqO+xTz2P00QEe/qLTYx0kp8s6
	 Hkx7+u7cfko0KQL0g6vbQ8++tXSvGfGHjCrHOMyBl/Yru0MJhE3YydXGdnm3wfg1PJ+2H
	 YfXeB5GXcIgq3bFaQwNIr7LO2gGrqlwC35beaqdRtXLqJkFC5pzDKfz6ya9Ugfe3sHevH
	 E1+hS3zVcBXI/51jdu5hP0ksuTYl+NWkRwcvpVgEIYRYBNC7wIXa2eYzLnImecvSmzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3u9mXNLg;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BE9606A325
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82BE9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=3u9mXNLg
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhMH28Lmz1XMG4K;
	Mon,  9 Nov 2026 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=EQuri
	2RcPVGIrgW8jf4hjF/4wK/KGwQlcALCG7uw6y8=; b=3u9mXNLgrbGX+9pgz2BeY
	osnUq6yXTAVDsaA2K3HMHE5dAJSqw9m6Xa6srTfOzBjh4uSKvJGMRl/WXzWwAjYR
	spm+tSk1CgOlLis9+e3OCL5fcRKE3lXQ1grWpKxoWReYRHgZ7o+e3Z9oFcyDZfW8
	Nnd7mSTzRTNhaRNj6jHIw4GsTTMhD1u8rBkdnBelxzvDzOLxEvoPFG0WPjSP9fT9
	HKjqai7cXGJzjB91vBWWPCvq23rdjGMSHVxR4V9Oi5Q0pJIfdlPrbHu274V0Ihb+
	ko0CLKpDtRoTzmuMAlM47CZVpJj7evwNQJxMkJsIRkGcmHctTnjEQZoq9dqBOQhK
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GNBNLHDr3X3l; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM43s8Bz1XMG4F;
	Mon,  9 Nov 2026 20:33:36 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 55/73] preprocessor: Add support for __has_embed
Date: Mon,  9 Nov 2026 12:32:41 -0800
Message-ID: <20261109203259.362845-56-bvanassche@acm.org>
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

Add support for the C23 __has_embed preprocessor operator to check resour=
ce
availability and parameters prior to inclusion via #embed. Predefine the
__STDC_EMBED_NOT_FOUND__, __STDC_EMBED_FOUND__, and __STDC_EMBED_EMPTY__
constants to allow portable feature detection in preprocessor expressions=
.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ident-list.h                            |   9 +
 pre-process.c                           | 445 +++++++++++++++++++++++-
 predefine.c                             |   3 +
 validation/preprocessor/c23-has-embed.c |  69 ++++
 4 files changed, 522 insertions(+), 4 deletions(-)
 create mode 100644 validation/preprocessor/c23-has-embed.c

diff --git a/ident-list.h b/ident-list.h
index bc5df947913a..f51f2048f5ca 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -84,6 +84,15 @@ __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
 __IDENT(__has_include_ident, "__has_include", 0);
 __IDENT(__has_include_next_ident, "__has_include_next", 0);
+__IDENT(__has_embed_ident, "__has_embed", 0);
+IDENT(limit);
+IDENT(prefix);
+IDENT(suffix);
+IDENT(if_empty);
+__IDENT(__limit___ident, "__limit__", 0);
+__IDENT(__prefix___ident, "__prefix__", 0);
+__IDENT(__suffix___ident, "__suffix__", 0);
+__IDENT(__if_empty___ident, "__if_empty__", 0);
=20
 /* Sparse commands */
 IDENT_RESERVED(__context__);
diff --git a/pre-process.c b/pre-process.c
index aac194cf4c01..e8b3511c225e 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -764,6 +764,7 @@ static struct token **substitute(struct token **list,=
 const struct token *body,
 }
=20
 static bool parse_has_include(struct token **list, int how);
+static bool parse_has_embed(struct token **list);
=20
 static void reject_outside_directive(struct token *token)
 {
@@ -805,7 +806,8 @@ static int expand(struct token **list, struct symbol =
*sym)
 	}
=20
 	if (expanding =3D=3D &__has_include_ident ||
-	    expanding =3D=3D &__has_include_next_ident) {
+	    expanding =3D=3D &__has_include_next_ident ||
+	    expanding =3D=3D &__has_embed_ident) {
 		bool ok;
=20
 		if (!in_cond_expr) {
@@ -814,8 +816,10 @@ static int expand(struct token **list, struct symbol=
 *sym)
 		}
 		if (expanding =3D=3D &__has_include_ident)
 			ok =3D parse_has_include(list, 0);
-		else
+		else if (expanding =3D=3D &__has_include_next_ident)
 			ok =3D parse_has_include(list, 1);
+		else
+			ok =3D parse_has_embed(list);
 		if (!ok)
 			replace_with_bool(token, 0);
 		return 0;
@@ -1099,7 +1103,7 @@ static bool collect_angle_filename(struct token **n=
ext_p, char *buf,
 	struct token *t =3D *next_p;
 	char *ptr =3D buf;
=20
-	while (!eof_token(t) && !match_op(t, '>')) {
+	while (!eof_token(t =3D scan_next(&t)) && !match_op(t, '>')) {
 		const char *s =3D (token_type(t) =3D=3D TOKEN_STRING) ?
 					t->string->data :
 					show_token(t);
@@ -1123,7 +1127,7 @@ static bool collect_angle_filename(struct token **n=
ext_p, char *buf,
 		sparse_error(pos, "empty filename");
 		return false;
 	}
-	*next_p =3D t->next;
+	*next_p =3D scan_next(&t->next);
 	return true;
 }
=20
@@ -1231,6 +1235,432 @@ err:
 	return false;
 }
=20
+static void replace_with_int(struct token *token, int val)
+{
+	static const char *const digits[] =3D { "0", "1", "2" };
+	token_type(token) =3D TOKEN_NUMBER;
+	token->number =3D (val >=3D 0 && val <=3D 2) ? digits[val] : "0";
+}
+
+#define MAX_EMBED_SIZE (16 * 1024 * 1024)
+
+enum embed_param_kind {
+	EMBED_PARAM_NONE =3D 0,
+	EMBED_PARAM_LIMIT =3D 1 << 0,
+	EMBED_PARAM_PREFIX =3D 1 << 1,
+	EMBED_PARAM_SUFFIX =3D 1 << 2,
+	EMBED_PARAM_IF_EMPTY =3D 1 << 3,
+};
+
+static enum embed_param_kind classify_embed_param(struct ident *id)
+{
+	if (id =3D=3D &limit_ident || id =3D=3D &__limit___ident)
+		return EMBED_PARAM_LIMIT;
+	if (id =3D=3D &prefix_ident || id =3D=3D &__prefix___ident)
+		return EMBED_PARAM_PREFIX;
+	if (id =3D=3D &suffix_ident || id =3D=3D &__suffix___ident)
+		return EMBED_PARAM_SUFFIX;
+	if (id =3D=3D &if_empty_ident || id =3D=3D &__if_empty___ident)
+		return EMBED_PARAM_IF_EMPTY;
+	return EMBED_PARAM_NONE;
+}
+
+static struct token *dup_token_range(struct token *start, struct token *=
end)
+{
+	struct token *head =3D &eof_token_entry;
+	struct token **tail =3D &head;
+	struct token *p;
+
+	if (!start || !end)
+		return &eof_token_entry;
+	for (p =3D start;; p =3D p->next) {
+		struct token *t =3D __alloc_token(0);
+		*t =3D *p;
+		*tail =3D t;
+		tail =3D &t->next;
+		if (p =3D=3D end)
+			break;
+	}
+	*tail =3D &eof_token_entry;
+	return head;
+}
+
+static bool eval_embed_limit_expr(struct position pos, struct token *pst=
art,
+				  struct token *pend,
+				  unsigned long long *limit_val)
+{
+	struct token *copy =3D dup_token_range(pstart, pend);
+	struct expression *expr =3D NULL;
+	long long sval;
+
+	if (eof_token(copy)) {
+		sparse_error(pos, "expected expression in #embed limit");
+		return false;
+	}
+	in_cond_expr++;
+	expand_list(&copy);
+	for (struct token *t =3D copy; !eof_token(t); t =3D t->next) {
+		if (token_type(t) !=3D TOKEN_IDENT)
+			continue;
+		if (standard >=3D STANDARD_C23 && t->ident =3D=3D &true_ident) {
+			replace_with_bool(t, 1);
+		} else if (standard >=3D STANDARD_C23 &&
+			   t->ident =3D=3D &false_ident) {
+			replace_with_bool(t, 0);
+		} else if (t->ident =3D=3D &defined_ident) {
+			in_cond_expr--;
+			sparse_error(t->pos,
+				     "'defined' cannot appear in #embed limit");
+			return false;
+		} else {
+			token_type(t) =3D TOKEN_ZERO_IDENT;
+		}
+	}
+	in_cond_expr--;
+	copy =3D constant_expression(copy, &expr);
+	if (!expr || !eof_token(copy)) {
+		sparse_error(pos, "invalid #embed limit");
+		return false;
+	}
+	sval =3D get_expression_value(expr);
+	if (!expr->ctype || expr->type !=3D EXPR_VALUE)
+		return false;
+	if (sval < 0 && !(expr->ctype->ctype.modifiers & MOD_UNSIGNED)) {
+		sparse_error(expr->pos, "negative #embed limit");
+		return false;
+	}
+	*limit_val =3D (unsigned long long)sval;
+	return true;
+}
+
+static int test_embed_file(const char *path, const char *filename,
+			   int has_limit, unsigned long long limit_val,
+			   unsigned long long *size)
+{
+	int fd;
+	struct stat st;
+	size_t plen =3D strlen(path);
+	size_t flen =3D strlen(filename);
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
+	fd =3D open(fullname, O_RDONLY | O_NONBLOCK);
+	if (fd < 0)
+		return 0;
+	if (fstat(fd, &st) < 0 || S_ISDIR(st.st_mode)) {
+		close(fd);
+		return 0;
+	}
+	if (S_ISREG(st.st_mode)) {
+		unsigned long long eff =3D st.st_size;
+
+		close(fd);
+		if (has_limit && limit_val < eff)
+			eff =3D limit_val;
+		if (eff > MAX_EMBED_SIZE)
+			return 0;
+		*size =3D eff;
+		return 1;
+	}
+	if (S_ISCHR(st.st_mode)) {
+		unsigned char b;
+		ssize_t r;
+
+		if (has_limit && limit_val =3D=3D 0) {
+			close(fd);
+			*size =3D 0;
+			return 1;
+		}
+		if (has_limit && limit_val > MAX_EMBED_SIZE) {
+			close(fd);
+			return 0;
+		}
+		r =3D read(fd, &b, 1);
+		close(fd);
+		if (r =3D=3D 0) {
+			*size =3D 0;
+			return 1;
+		}
+		if (r > 0 && has_limit) {
+			*size =3D 1;
+			return 1;
+		}
+		return 0;
+	}
+	close(fd);
+	return 0;
+}
+
+static int check_has_embed(struct stream *stream, const char *filename,
+			   int expect, int has_limit,
+			   unsigned long long limit_val,
+			   unsigned long long *size)
+{
+	const char **path;
+
+	/* Absolute path? */
+	if (filename[0] =3D=3D '/')
+		return test_embed_file("", filename, has_limit, limit_val,
+				       size);
+
+	set_stream_include_path(stream);
+	path =3D expect ? angle_includepath : quote_includepath;
+	if (!path)
+		return 0;
+	while (*path !=3D NULL) {
+		if (test_embed_file(*path++, filename, has_limit, limit_val,
+				    size))
+			return 1;
+	}
+	return 0;
+}
+
+static bool parse_has_embed(struct token **list)
+{
+	struct token *token =3D *list;
+	struct token *lparen =3D scan_next(&token->next);
+	struct token *next;
+	struct token *params, **param_p, *rparen, *after_rparen;
+	struct stream *stream =3D input_streams + token->pos.stream;
+	char filename[PATH_MAX];
+	int expect =3D 0;
+	int val =3D 0;
+	unsigned long long filesize =3D 0;
+	int has_limit =3D 0;
+	unsigned long long limit_val =3D ~0ULL;
+	unsigned int seen_params =3D 0;
+	int supported =3D 1;
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
+		int depth =3D 1;
+
+		rparen =3D scan_next(p);
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
+
+	/* Isolate optional parameters before matching ')' */
+	params =3D next;
+	{
+		struct token **p =3D &params;
+		int depth =3D 1;
+
+		rparen =3D scan_next(p);
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
+		after_rparen =3D rparen->next;
+		*p =3D &eof_token_entry;
+	}
+
+	param_p =3D &params;
+	while (!eof_token(next =3D scan_next(param_p))) {
+		if (token_type(next) =3D=3D TOKEN_IDENT) {
+			struct ident *id;
+			struct position id_pos;
+			enum embed_param_kind kind;
+
+			if (!expand_one_symbol(param_p))
+				continue;
+			next =3D *param_p;
+			if (token_type(next) !=3D TOKEN_IDENT) {
+				supported =3D 0;
+				param_p =3D &next->next;
+				continue;
+			}
+			id =3D next->ident;
+			id_pos =3D next->pos;
+			if (match_op(next->next, ':') &&
+			    match_op(next->next->next, ':')) {
+				struct token *attr =3D next->next->next->next;
+
+				if (token_type(attr) !=3D TOKEN_IDENT) {
+					sparse_error(attr->pos,
+						     "identifier expected");
+					token->next =3D after_rparen;
+					return false;
+				}
+				supported =3D 0;
+				next =3D attr->next;
+				if (match_op(next, '(')) {
+					int depth =3D 1;
+
+					next =3D next->next;
+					while (!eof_token(next) && depth > 0) {
+						if (match_op(next, '('))
+							depth++;
+						else if (match_op(next, ')'))
+							depth--;
+						next =3D next->next;
+					}
+				}
+				param_p =3D &next;
+				continue;
+			}
+
+			kind =3D classify_embed_param(id);
+			if (kind !=3D EMBED_PARAM_NONE) {
+				struct token *pstart, *pend =3D NULL;
+				int depth =3D 1;
+
+				if (seen_params & kind) {
+					sparse_error(
+						id_pos,
+						"duplicate embed parameter '%s'",
+						show_ident(id));
+					token->next =3D after_rparen;
+					return false;
+				}
+				seen_params |=3D kind;
+
+				next =3D scan_next(&next->next);
+				if (!match_op(next, '(')) {
+					sparse_error(
+						id_pos,
+						"expected '(' after '%s'",
+						show_ident(id));
+					token->next =3D after_rparen;
+					return false;
+				}
+				pstart =3D next->next;
+				next =3D next->next;
+				while (!eof_token(next) && depth > 0) {
+					if (match_op(next, '('))
+						depth++;
+					else if (match_op(next, ')') &&
+						 !--depth)
+						break;
+					pend =3D next;
+					next =3D next->next;
+				}
+				if (!match_op(next, ')')) {
+					sparse_error(id_pos, "expected ')'");
+					token->next =3D after_rparen;
+					return false;
+				}
+				next =3D next->next;
+				if (kind =3D=3D EMBED_PARAM_LIMIT) {
+					if (!eval_embed_limit_expr(
+						    id_pos, pstart, pend,
+						    &limit_val)) {
+						token->next =3D after_rparen;
+						return false;
+					}
+					has_limit =3D 1;
+				}
+				param_p =3D &next;
+				continue;
+			}
+
+			/* Unknown non-prefixed parameter */
+			supported =3D 0;
+			next =3D scan_next(&next->next);
+			if (match_op(next, '(')) {
+				int depth =3D 1;
+
+				next =3D next->next;
+				while (!eof_token(next) && depth > 0) {
+					if (match_op(next, '('))
+						depth++;
+					else if (match_op(next, ')'))
+						depth--;
+					next =3D next->next;
+				}
+			}
+			param_p =3D &next;
+			continue;
+		}
+		supported =3D 0;
+		param_p =3D &next->next;
+	}
+
+	if (!supported) {
+		val =3D 0;
+	} else if (!check_has_embed(stream, filename, expect, has_limit,
+				    limit_val, &filesize)) {
+		val =3D 0;
+	} else if (filesize =3D=3D 0 || (has_limit && limit_val =3D=3D 0)) {
+		val =3D 2;
+	} else {
+		val =3D 1;
+	}
+
+	replace_with_int(token, val);
+	token->next =3D after_rparen;
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
@@ -1933,6 +2363,12 @@ static int expression_value(struct token **where)
 				replace_with_bool(p, 0);
 				break;
 			}
+			if (p->ident =3D=3D &__has_embed_ident) {
+				if (parse_has_embed(list))
+					continue;
+				replace_with_bool(p, 0);
+				break;
+			}
 			if (!expand_one_symbol(list))
 				continue;
 			if (token_type(p) !=3D TOKEN_IDENT)
@@ -2598,6 +3034,7 @@ static void init_preprocessor(void)
 		{ "__has_feature", NULL, expand_has_feature },
 		{ "__has_include", NULL, NULL },
 		{ "__has_include_next", NULL, NULL },
+		{ "__has_embed", NULL, NULL },
 	};
=20
 	for (i =3D 0; i < ARRAY_SIZE(normal); i++) {
diff --git a/predefine.c b/predefine.c
index d6ab0785abad..5639fc6862e3 100644
--- a/predefine.c
+++ b/predefine.c
@@ -123,6 +123,9 @@ void predefined_macros(void)
 		predefine("__STDC_NO_COMPLEX__", 1, "1");
 		predefine("__STDC_NO_THREADS__", 1, "1");
 	}
+	predefine("__STDC_EMBED_NOT_FOUND__", 1, "0");
+	predefine("__STDC_EMBED_FOUND__", 1, "1");
+	predefine("__STDC_EMBED_EMPTY__", 1, "2");
=20
 	predefine("__CHAR_BIT__", 1, "%d", bits_in_char);
 	if (funsigned_char)
diff --git a/validation/preprocessor/c23-has-embed.c b/validation/preproc=
essor/c23-has-embed.c
new file mode 100644
index 000000000000..8ae7bb1d081f
--- /dev/null
+++ b/validation/preprocessor/c23-has-embed.c
@@ -0,0 +1,69 @@
+#if defined(__has_embed)
+int has_macro =3D 1;
+#endif
+
+#if __has_embed("options.h") =3D=3D __STDC_EMBED_FOUND__
+int found_options =3D 1;
+#endif
+
+#if __has_embed("options.h" limit(0)) =3D=3D __STDC_EMBED_EMPTY__
+int limit_zero_empty =3D 1;
+#endif
+
+#if __has_embed("options.h" __limit__(0)) =3D=3D __STDC_EMBED_EMPTY__
+int dunder_limit_zero_empty =3D 1;
+#endif
+
+#if __has_embed("options.h" limit(5)) =3D=3D __STDC_EMBED_FOUND__
+int limit_five_found =3D 1;
+#endif
+
+#if __has_embed("nonexistent_embed_12345.bin") =3D=3D __STDC_EMBED_NOT_F=
OUND__
+int not_found =3D 1;
+#endif
+
+#if __has_embed("options.h" prefix(1) suffix(2)) =3D=3D __STDC_EMBED_FOU=
ND__ && \
+    __has_embed("options.h" __prefix__(1) __suffix__(2) __if_empty__(3))=
 =3D=3D \
+	__STDC_EMBED_FOUND__
+int standard_params =3D 1;
+#endif
+
+#if __has_embed("options.h" unknown_vendor::param(1)) =3D=3D \
+	__STDC_EMBED_NOT_FOUND__
+int unknown_param =3D 1;
+#endif
+
+#define HAS_EMB __has_embed
+#if HAS_EMB("options.h") =3D=3D __STDC_EMBED_FOUND__
+int aliased_has_embed =3D 1;
+#endif
+
+#if __has_embed("/dev/null") =3D=3D __STDC_EMBED_EMPTY__
+int dev_null_empty =3D 1;
+#endif
+
+#if __has_embed("options.h" limit(1ULL << 63)) =3D=3D __STDC_EMBED_FOUND=
__ && \
+    __has_embed("options.h" limit(0xffffffffffffffffULL)) =3D=3D \
+	__STDC_EMBED_FOUND__
+int large_unsigned_limit =3D 1;
+#endif
+
+/*
+ * check-name: c23-has-embed
+ * check-command: sparse -std=3Dc23 -E -I.. $file
+ *
+ * check-output-start
+
+int has_macro =3D 1;
+int found_options =3D 1;
+int limit_zero_empty =3D 1;
+int dunder_limit_zero_empty =3D 1;
+int limit_five_found =3D 1;
+int not_found =3D 1;
+int standard_params =3D 1;
+int unknown_param =3D 1;
+int aliased_has_embed =3D 1;
+int dev_null_empty =3D 1;
+int large_unsigned_limit =3D 1;
+ * check-output-end
+ */
