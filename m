Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256438;
	b=45gutIHs5amZgq2aWNsxx5ZQsmYqZr+xkJMgwwA0QyUFlTbuaTCRZ9cD4uAEuDLLHFb+
	 shOfOSqR2a1GuwF+Ns24NcBVDOrArwyH26nJiszvwGZrP+iL2nEV6okuVy0GyNBHFXC0i
	 0ATAu/FqDQkZoZRlVOwx65EClnqf6gqYUYdFW8XjbH5Mm7VOKkgi9lMY7lHzsLZS9a8pI
	 E6t73YFbgUd7kkXoc/U3AshBbgDK989QWR3A34umPQxuNBxiwD+FK5JpLspWQ4QGOaKxJ
	 YEHY1rl3v1lCH+/veXzWUmVRs8uwppyG0fAsALglBeeiS1R/Vbe/06V+1iRGpx7KWnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/gxczXZNJoEkxzhl+9Oc6vus4WUohhMyzyam9+HVM8A=;
	b=1GBMu+Z4yvtMfLixbs13nOFwNQgrDFe68ANN1Kim0fzY7KiX7Y+qv2Eqgbclxo4/5F5S
	 bT1tj4Q/FkGistNVWROfVM76tFDZGpyEHYt/4rXzxghAO5s/86FZ7XDURrZh3RuNyAgw8
	 lrLoHoDlfLVQFArv4JPuehcrLGQsWhl9O8ngRGFPiZ1NU9CEirzNcsXM/yhhXQ14OQMzX
	 FJ04gdvbiVbjihSnQR02OxxBm2U0DQVg83aPGG28qC/Dw8d60SO7Nygkehos4IoML6tJv
	 Dgu8XCbqpJSkRroVH6nt4fPlp0Ozrca2y/HbLOh8NHnuvq4cT/y6M6YuMZ8W/evPPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DqW3Jb3j;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10BB606A330
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10BB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=DqW3Jb3j
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhML1Tm3z1XMYJM;
	Mon,  9 Nov 2026 20:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1794256418; x=1796848419; bh=/gxcz
	XZNJoEkxzhl+9Oc6vus4WUohhMyzyam9+HVM8A=; b=DqW3Jb3j45L4sHCr+abKc
	W9MKtFj420GqpyDuCLK9johNSiTLnLFTKjgFiMGWpr6U5oBlpRDqV7D55w1Zvc2K
	5FQUeBGIgbAyYanXlhqX7RmaH+9HY4liCWhAA0Uhy4OpEdvtIfLAbObyePPQDTwD
	9EfjlUcBD50pUW7ezT6I66yxeeQAyVSuC9IUOiRt0X7cRfufDenDGVw2K0/tSatJ
	cEsnWzFWnYHatDuLreV1Uwc/Tk1z4suSdP8gM56TqFaxG5mDQDdvO1wl9cXvHoew
	MMfW7hVeOw3vLMq12k4QrxOGF/J/K3N1fREC3zkvRC2CoT7zj/mlFXZ9ZqfOves5
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ESJV84hetUEX; Mon,  9 Nov 2026 20:33:38 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhM51RpNz1XLX7h;
	Mon,  9 Nov 2026 20:33:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 58/73] preprocessor: Add support for __VA_OPT__
Date: Mon,  9 Nov 2026 12:32:44 -0800
Message-ID: <20261109203259.362845-59-bvanassche@acm.org>
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

Add support for the __VA_OPT__ functional macro replacement operator
introduced in C23. Expand the contents of __VA_OPT__(...) if and only if
variable arguments are passed to the variadic macro, eliminating trailing
delimiter issues in variadic macro expansion portably.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 ident-list.h                               |   1 +
 pre-process.c                              | 331 ++++++++++++++++++---
 token.h                                    |   3 +
 tokenize.c                                 |  10 +
 validation/c23-va-opt.c                    |  36 +++
 validation/preprocessor/c23-va-opt-error.c |  31 ++
 validation/preprocessor/c23-va-opt.c       |  73 +++++
 7 files changed, 446 insertions(+), 39 deletions(-)
 create mode 100644 validation/c23-va-opt.c
 create mode 100644 validation/preprocessor/c23-va-opt-error.c
 create mode 100644 validation/preprocessor/c23-va-opt.c

diff --git a/ident-list.h b/ident-list.h
index 3340f11641fa..b4e01e0a423c 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -80,6 +80,7 @@ IDENT(c_generic_selections);
 IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
+__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
diff --git a/pre-process.c b/pre-process.c
index 9ebf09cffbdd..8eb70ca7a1a4 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -640,7 +640,7 @@ static struct token *dup_token(const struct token *to=
ken, struct position *strea
 static struct token **copy(struct token **where, struct token *list, int=
 *count)
 {
 	int need_copy =3D --*count;
-	while (!eof_token(list)) {
+	do {
 		struct token *token;
 		if (need_copy)
 			token =3D dup_token(list, &list->pos);
@@ -651,7 +651,7 @@ static struct token **copy(struct token **where, stru=
ct token *list, int *count)
 		*where =3D token;
 		where =3D &token->next;
 		list =3D list->next;
-	}
+	} while (!eof_token(list));
 	*where =3D &eof_token_entry;
 	return where;
 }
@@ -677,11 +677,26 @@ static int handle_kludge(const struct token **p, st=
ruct arg *args)
 	}
 }
=20
-static struct token **substitute(struct token **list, const struct token=
 *body, struct arg *args)
+static inline int arg_empty(struct arg *arg)
+{
+	struct token *t =3D arg->expanded;
+
+	if (!t)
+		return 1;
+	while (token_type(t) =3D=3D TOKEN_UNTAINT)
+		t =3D t->next;
+	return eof_token(t);
+}
+
+static struct token **substitute_tokens(struct token **list,
+					struct position *base_pos,
+					const struct token *body,
+					struct arg *args, int vararg_num)
 {
-	struct position *base_pos =3D &(*list)->pos;
 	int *count;
+	int one;
 	enum {Normal, Placeholder, Concat} state =3D Normal;
+	int extra_whitespace =3D 0;
=20
 	for (; !eof_token(body); body =3D body->next) {
 		struct token *added, *arg;
@@ -712,9 +727,57 @@ static struct token **substitute(struct token **list=
, const struct token *body,
 			tail =3D &added->next;
 			break;
=20
+		case TOKEN_STR_VA_OPT: {
+			struct token *inner =3D &eof_token_entry;
+
+			if (vararg_num >=3D 0 && !arg_empty(&args[vararg_num]))
+				substitute_tokens(&inner, base_pos,
+						  body->target, args,
+						  vararg_num);
+			added =3D stringify(inner);
+			added->pos.stream =3D base_pos->stream;
+			added->pos.line =3D base_pos->line;
+			added->pos.pos =3D base_pos->pos;
+			added->pos.newline =3D body->pos.newline;
+			added->pos.whitespace =3D
+				body->pos.whitespace || extra_whitespace;
+			extra_whitespace =3D 0;
+			tail =3D &added->next;
+			break;
+		}
+
+		case TOKEN_VA_OPT: {
+			struct token *inner =3D &eof_token_entry;
+
+			if (vararg_num >=3D 0 && !arg_empty(&args[vararg_num]))
+				substitute_tokens(&inner, base_pos,
+						  body->target, args,
+						  vararg_num);
+			if (eof_token(inner)) {
+				if (body->pos.whitespace && state !=3D Concat &&
+				    token_type(body->next) !=3D TOKEN_CONCAT)
+					extra_whitespace =3D 1;
+				if (state =3D=3D Concat)
+					state =3D Normal;
+				else if (token_type(body->next) =3D=3D TOKEN_CONCAT)
+					state =3D Placeholder;
+				else
+					state =3D Normal;
+				continue;
+			}
+			arg =3D inner;
+			one =3D 1;
+			count =3D &one;
+			goto copy_arg;
+		}
+
 		case TOKEN_STR_ARGUMENT:
 			arg =3D args[body->argnum].str;
 			count =3D &args[body->argnum].n_str;
+			if (eof_token(arg)) {
+				state =3D Normal;
+				continue;
+			}
 			goto copy_arg;
=20
 		case TOKEN_QUOTED_ARGUMENT:
@@ -740,6 +803,10 @@ static struct token **substitute(struct token **list=
, const struct token *body,
 			tail =3D copy(&added, arg, count);
 			added->pos.newline =3D body->pos.newline;
 			added->pos.whitespace =3D body->pos.whitespace;
+			if (extra_whitespace) {
+				added->pos.whitespace =3D 1;
+				extra_whitespace =3D 0;
+			}
 			break;
=20
 		case TOKEN_CONCAT:
@@ -754,6 +821,10 @@ static struct token **substitute(struct token **list=
, const struct token *body,
 			if (token_type(body) =3D=3D TOKEN_IDENT &&
 			    added->ident->tainted)
 				added->pos.noexpand =3D 1;
+			if (extra_whitespace) {
+				added->pos.whitespace =3D 1;
+				extra_whitespace =3D 0;
+			}
 			tail =3D &added->next;
 			break;
 		}
@@ -776,6 +847,14 @@ static struct token **substitute(struct token **list=
, const struct token *body,
 	return list;
 }
=20
+static struct token **substitute(struct token **list, const struct token=
 *body,
+				 struct arg *args, int vararg_num)
+{
+	struct position base_pos =3D (*list)->pos;
+
+	return substitute_tokens(list, &base_pos, body, args, vararg_num);
+}
+
 static bool parse_has_include(struct token **list, int how);
 static bool parse_has_embed(struct token **list);
=20
@@ -811,8 +890,14 @@ static int expand(struct token **list, struct symbol=
 *sym)
 	struct token **tail;
 	struct token *expansion =3D sym->expansion;
 	int nargs =3D sym->arglist ? sym->arglist->count.normal : 0;
+	int vararg_num =3D (sym->arglist && sym->arglist->count.vararg) ?
+				 (sym->arglist->count.normal - 1) :
+				 -1;
 	struct arg args[nargs ? nargs : 1];
=20
+	if (nargs)
+		memset(args, 0, nargs * sizeof(args[0]));
+
 	if (expanding->tainted) {
 		token->pos.noexpand =3D 1;
 		return 1;
@@ -855,7 +940,7 @@ static int expand(struct token **list, struct symbol =
*sym)
 	expanding->tainted =3D 1;
=20
 	last =3D token->next;
-	tail =3D substitute(list, expansion, args);
+	tail =3D substitute(list, expansion, args, vararg_num);
 	/*
 	 * Note that it won't be eof - at least TOKEN_UNTAINT will be there.
 	 * We still can lose the newline flag if the sucker expands to nothing,
@@ -2147,6 +2232,8 @@ static int handle_argv_include(struct stream *strea=
m, struct token **list, struc
 	return handle_include_path(stream, list, token, 2);
 }
=20
+static int token_list_different(struct token *list1, struct token *list2=
);
+
 static int token_different(struct token *t1, struct token *t2)
 {
 	int different;
@@ -2164,6 +2251,10 @@ static int token_different(struct token *t1, struc=
t token *t2)
 	case TOKEN_GNU_KLUDGE:
 		different =3D 0;
 		break;
+	case TOKEN_VA_OPT:
+	case TOKEN_STR_VA_OPT:
+		different =3D token_list_different(t1->target, t2->target);
+		break;
 	case TOKEN_NUMBER:
 		different =3D strcmp(t1->number, t2->number);
 		break;
@@ -2240,6 +2331,8 @@ static struct token *parse_arguments(struct token *=
list)
 	while (token_type(arg) =3D=3D TOKEN_IDENT) {
 		if (arg->ident =3D=3D &__VA_ARGS___ident)
 			goto Eva_args;
+		if (arg->ident =3D=3D &__VA_OPT___ident)
+			goto Eva_opt;
 		if (!++count->normal)
 			goto Eargs;
 		next =3D arg->next;
@@ -2263,6 +2356,7 @@ static struct token *parse_arguments(struct token *=
list)
 			if (match_op(next->next, ')')) {
 				set_arg_count(next);
 				next->count.vararg =3D 1;
+				count->vararg =3D 1;
 				next =3D next->next;
 				arg->next->next =3D &eof_token_entry;
 				return next->next;
@@ -2290,6 +2384,7 @@ static struct token *parse_arguments(struct token *=
list)
 			goto Eargs;
 		set_arg_count(next);
 		next->count.vararg =3D 1;
+		count->vararg =3D 1;
 		next =3D next->next;
 		arg->next->next =3D &eof_token_entry;
 		return next;
@@ -2315,6 +2410,10 @@ Ebadstuff:
 Enotclosed:
 	sparse_error(arg->pos, "missing ')' in macro parameter list");
 	return NULL;
+Eva_opt:
+	sparse_error(arg->pos,
+		     "__VA_OPT__ cannot appear in a macro parameter list");
+	return NULL;
 Eva_args:
 	sparse_error(arg->pos, "__VA_ARGS__ can only appear in the expansion of=
 a C99 variadic macro");
 	return NULL;
@@ -2363,11 +2462,26 @@ static int try_arg(struct token *token, enum toke=
n_type type, struct token *argl
 	return 0;
 }
=20
+static struct token *handle_va_opt(struct token **p, struct token *argli=
st);
+static int parse_expansion_tokens(struct token **expansion_p,
+				  struct token *arglist);
+
 static struct token *handle_hash(struct token **p, struct token *arglist=
)
 {
 	struct token *token =3D *p;
 	if (arglist) {
 		struct token *next =3D token->next;
+		if (token_type(next) =3D=3D TOKEN_IDENT &&
+		    next->ident =3D=3D &__VA_OPT___ident) {
+			next =3D handle_va_opt(&token->next, arglist);
+			if (!next)
+				return NULL;
+			token_type(next) =3D TOKEN_STR_VA_OPT;
+			next->pos.whitespace =3D token->pos.whitespace;
+			__free_token(token);
+			*p =3D next;
+			return next;
+		}
 		if (!try_arg(next, TOKEN_STR_ARGUMENT, arglist))
 			goto Equote;
 		next->pos.whitespace =3D token->pos.whitespace;
@@ -2412,6 +2526,11 @@ static struct token *handle_hashhash(struct token =
*token, struct token *arglist)
 			t =3D handle_hash(&concat->next, arglist);
 			if (!t)
 				return NULL;
+		} else if (token_type(t) =3D=3D TOKEN_IDENT &&
+			   t->ident =3D=3D &__VA_OPT___ident) {
+			t =3D handle_va_opt(&concat->next, arglist);
+			if (!t)
+				return NULL;
 		}
=20
 		is_arg =3D try_arg(t, TOKEN_QUOTED_ARGUMENT, arglist);
@@ -2437,43 +2556,146 @@ Econcat:
 	return NULL;
 }
=20
-static struct token *parse_expansion(struct token *expansion, struct tok=
en *arglist, struct ident *name)
+static struct token *handle_va_opt(struct token **p, struct token *argli=
st)
 {
-	struct token *token =3D expansion;
+	struct token *token =3D *p;
+	struct token *lparen =3D token->next;
+	struct token *cur, *prev, *body;
+	int nesting =3D 1;
+
+	if (!arglist || !arglist->count.vararg) {
+		sparse_error(
+			token->pos,
+			"__VA_OPT__ can only appear in the expansion of a variadic macro");
+		return NULL;
+	}
+	if (!match_op(lparen, '(')) {
+		sparse_error(token->pos, "expected '(' after __VA_OPT__");
+		return NULL;
+	}
+	if (standard < STANDARD_C23 && Wpedantic)
+		warning(token->pos, "__VA_OPT__ is a C23 feature");
+
+	for (cur =3D arglist->next; !eof_token(cur); cur =3D cur->next->next) {
+		if (cur->next->count.vararg) {
+			if (!++cur->next->count.normal) {
+				sparse_error(
+					token->pos,
+					"too many instances of argument in body");
+				return NULL;
+			}
+			break;
+		}
+	}
+
+	prev =3D lparen;
+	for (cur =3D lparen->next; !eof_token(cur); prev =3D cur, cur =3D cur->=
next) {
+		if (token_type(cur) =3D=3D TOKEN_IDENT &&
+		    cur->ident =3D=3D &__VA_OPT___ident) {
+			sparse_error(
+				cur->pos,
+				"__VA_OPT__ cannot appear within __VA_OPT__");
+			return NULL;
+		}
+		if (match_op(cur, '('))
+			nesting++;
+		else if (match_op(cur, ')')) {
+			if (!--nesting)
+				break;
+		}
+	}
+	if (nesting) {
+		sparse_error(token->pos, "unterminated __VA_OPT__");
+		return NULL;
+	}
+
+	/* cur is ')' */
+	if (lparen->next !=3D cur && match_op(lparen->next, SPECIAL_HASHHASH)) =
{
+		sparse_error(
+			lparen->next->pos,
+			"'##' cannot appear at the beginning of __VA_OPT__");
+		return NULL;
+	}
+	if (prev !=3D lparen && match_op(prev, SPECIAL_HASHHASH)) {
+		sparse_error(prev->pos,
+			     "'##' cannot appear at the end of __VA_OPT__");
+		return NULL;
+	}
+
+	if (lparen->next =3D=3D cur) {
+		body =3D &eof_token_entry;
+	} else {
+		body =3D lparen->next;
+		prev->next =3D &eof_token_entry;
+		if (parse_expansion_tokens(&body, arglist) < 0)
+			return NULL;
+	}
+
+	token_type(token) =3D TOKEN_VA_OPT;
+	token->target =3D body;
+	token->next =3D cur->next;
+	__free_token(lparen);
+	__free_token(cur);
+	return token;
+}
+
+static int parse_expansion_tokens(struct token **expansion_p,
+				  struct token *arglist)
+{
+	struct token *token =3D *expansion_p;
 	struct token **p;
=20
 	if (match_op(token, SPECIAL_HASHHASH))
 		goto Econcat;
=20
-	for (p =3D &expansion; !eof_token(token); p =3D &token->next, token =3D=
 *p) {
+	for (p =3D expansion_p; !eof_token(token); p =3D &token->next, token =3D=
 *p) {
 		if (match_op(token, '#')) {
 			token =3D handle_hash(p, arglist);
 			if (!token)
-				return NULL;
+				return -1;
+		} else if (token_type(token) =3D=3D TOKEN_IDENT &&
+			   token->ident =3D=3D &__VA_OPT___ident) {
+			token =3D handle_va_opt(p, arglist);
+			if (!token)
+				return -1;
 		}
 		if (match_op(token->next, SPECIAL_HASHHASH)) {
 			token =3D handle_hashhash(token, arglist);
 			if (!token)
-				return NULL;
-		} else {
+				return -1;
+		} else if (token_type(token) =3D=3D TOKEN_IDENT) {
 			try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
 		}
 		if (token_type(token) =3D=3D TOKEN_ERROR)
 			goto Earg;
 	}
+	return 0;
+
+Econcat:
+	sparse_error(token->pos,
+		     "'##' cannot appear at the ends of macro expansion");
+	return -1;
+Earg:
+	sparse_error(token->pos, "too many instances of argument in body");
+	return -1;
+}
+
+static struct token *parse_expansion(struct token *expansion, struct tok=
en *arglist, struct ident *name)
+{
+	struct token *token;
+	struct token **p;
+
+	if (parse_expansion_tokens(&expansion, arglist) < 0)
+		return NULL;
+
+	for (p =3D &expansion; !eof_token(*p); p =3D &(*p)->next)
+		;
 	token =3D alloc_token(&expansion->pos);
 	token_type(token) =3D TOKEN_UNTAINT;
 	token->ident =3D name;
 	token->next =3D *p;
 	*p =3D token;
 	return expansion;
-
-Econcat:
-	sparse_error(token->pos, "'##' cannot appear at the ends of macro expan=
sion");
-	return NULL;
-Earg:
-	sparse_error(token->pos, "too many instances of argument in body");
-	return NULL;
 }
=20
 static int do_define(struct position pos, struct token *token, struct id=
ent *name,
@@ -2482,6 +2704,12 @@ static int do_define(struct position pos, struct t=
oken *token, struct ident *nam
 	struct symbol *sym;
 	int ret =3D 1;
=20
+	if (name =3D=3D &__VA_ARGS___ident || name =3D=3D &__VA_OPT___ident) {
+		sparse_error(pos, "\"%s\" cannot be used as a macro name",
+			     show_ident(name));
+		return 1;
+	}
+
 	expansion =3D parse_expansion(expansion, arglist, name);
 	if (!expansion)
 		return 1;
@@ -2656,6 +2884,13 @@ static int do_handle_undef(struct stream *stream, =
struct token **line, struct to
 		return 1;
 	}
=20
+	if (left->ident =3D=3D &__VA_ARGS___ident ||
+	    left->ident =3D=3D &__VA_OPT___ident) {
+		warning(token->pos, "undefining \"%s\"",
+			show_ident(left->ident));
+		return 1;
+	}
+
 	sym =3D lookup_symbol(left->ident, NS_MACRO | NS_UNDEF);
 	if (sym) {
 		if (attr < sym->attr)
@@ -3597,6 +3832,44 @@ static int is_VA_ARGS_token(struct token *token)
 		(token->ident =3D=3D &__VA_ARGS___ident);
 }
=20
+static void dump_macro_tokens(struct token *token, struct token **args,
+			      bool top_level)
+{
+	bool first =3D !top_level;
+
+	while (top_level ? token_type(token) !=3D TOKEN_UNTAINT :
+			   !eof_token(token)) {
+		struct token *next =3D token->next;
+
+		if (!first && token->pos.whitespace)
+			putchar(' ');
+		first =3D false;
+		switch (token_type(token)) {
+		case TOKEN_CONCAT:
+			printf("##");
+			break;
+		case TOKEN_STR_VA_OPT:
+			printf("#");
+			/* fall-through */
+		case TOKEN_VA_OPT:
+			printf("__VA_OPT__(");
+			dump_macro_tokens(token->target, args, false);
+			putchar(')');
+			break;
+		case TOKEN_STR_ARGUMENT:
+			printf("#");
+			/* fall-through */
+		case TOKEN_QUOTED_ARGUMENT:
+		case TOKEN_MACRO_ARGUMENT:
+			token =3D args[token->argnum];
+			/* fall-through */
+		default:
+			printf("%s", show_token(token));
+		}
+		token =3D next;
+	}
+}
+
 static void dump_macro(struct symbol *sym)
 {
 	int nargs =3D sym->arglist ? sym->arglist->count.normal : 0;
@@ -3622,27 +3895,7 @@ static void dump_macro(struct symbol *sym)
 		putchar(')');
 	}
=20
-	token =3D sym->expansion;
-	while (token_type(token) !=3D TOKEN_UNTAINT) {
-		struct token *next =3D token->next;
-		if (token->pos.whitespace)
-			putchar(' ');
-		switch (token_type(token)) {
-		case TOKEN_CONCAT:
-			printf("##");
-			break;
-		case TOKEN_STR_ARGUMENT:
-			printf("#");
-			/* fall-through */
-		case TOKEN_QUOTED_ARGUMENT:
-		case TOKEN_MACRO_ARGUMENT:
-			token =3D args[token->argnum];
-			/* fall-through */
-		default:
-			printf("%s", show_token(token));
-		}
-		token =3D next;
-	}
+	dump_macro_tokens(sym->expansion, args, true);
 	putchar('\n');
 }
=20
diff --git a/token.h b/token.h
index b421f166f1f7..998d83a123c9 100644
--- a/token.h
+++ b/token.h
@@ -110,6 +110,8 @@ enum token_type {
 	TOKEN_QUOTED_ARGUMENT,
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
+	TOKEN_VA_OPT,
+	TOKEN_STR_VA_OPT,
 	TOKEN_UNTAINT,
 	TOKEN_ARG_COUNT,
 	TOKEN_IF,
@@ -200,6 +202,7 @@ struct token {
 		int argnum;
 		struct argcount count;
 		char embedded[4];
+		struct token *target;
 	};
 };
=20
diff --git a/tokenize.c b/tokenize.c
index 4ac40e9e1506..775c54667af7 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -265,6 +265,12 @@ const char *show_token(const struct token *token)
 		sprintf(buffer, "<argcnt>");
 		return buffer;
=20
+	case TOKEN_VA_OPT:
+		return "__VA_OPT__(...)";
+
+	case TOKEN_STR_VA_OPT:
+		return "#__VA_OPT__(...)";
+
 	case TOKEN_GNU_KLUDGE:
 		return ",";
=20
@@ -321,6 +327,10 @@ const char *quote_token(const struct token *token)
 	case TOKEN_UTF8_STRING:
 		return quote_char(token->string->data,
 				  token->string->length - 1, "u8", '"');
+	case TOKEN_VA_OPT:
+		return "__VA_OPT__(...)";
+	case TOKEN_STR_VA_OPT:
+		return "#__VA_OPT__(...)";
 	case TOKEN_GNU_KLUDGE:
 		return ",";
 	default:
diff --git a/validation/c23-va-opt.c b/validation/c23-va-opt.c
new file mode 100644
index 000000000000..bef475812fdd
--- /dev/null
+++ b/validation/c23-va-opt.c
@@ -0,0 +1,36 @@
+#define EMPTY
+#define COUNT_VA(...) 0 __VA_OPT__(+1)
+static_assert(COUNT_VA() =3D=3D 0, "empty");
+static_assert(COUNT_VA(EMPTY) =3D=3D 0, "empty macro");
+static_assert(COUNT_VA(x) =3D=3D 1, "one");
+static_assert(COUNT_VA(x, y) =3D=3D 1, "two");
+
+#define ADD_OPT(x, ...) (x __VA_OPT__(+__VA_ARGS__))
+static_assert(ADD_OPT(10) =3D=3D 10, "add 1");
+static_assert(ADD_OPT(10, 20) =3D=3D 30, "add 2");
+
+#define STR_OPT(...) #__VA_OPT__(__VA_ARGS__)
+static_assert(sizeof(STR_OPT()) =3D=3D 1, "str empty");
+static_assert(sizeof(STR_OPT(EMPTY)) =3D=3D 1, "str empty macro");
+static_assert(sizeof(STR_OPT(abc)) =3D=3D 4, "str abc");
+
+#define PASTE_OPT(p, ...) p ## __VA_OPT__(_ok)
+enum { val =3D 10, val_ok =3D 20 };
+static_assert(PASTE_OPT(val) =3D=3D 10, "paste empty");
+static_assert(PASTE_OPT(val, 1) =3D=3D 20, "paste non-empty");
+
+static int foo(int a, ...)
+{
+	return a;
+}
+
+#define CALL_FOO(...) foo(0 __VA_OPT__(, __VA_ARGS__))
+static int test(void)
+{
+	return CALL_FOO() + CALL_FOO(1) + CALL_FOO(1, 2);
+}
+
+/*
+ * check-name: c23-va-opt-compile
+ * check-command: sparse -std=3Dc23 -Wno-decl $file
+ */
diff --git a/validation/preprocessor/c23-va-opt-error.c b/validation/prep=
rocessor/c23-va-opt-error.c
new file mode 100644
index 000000000000..c494bc6f2a16
--- /dev/null
+++ b/validation/preprocessor/c23-va-opt-error.c
@@ -0,0 +1,31 @@
+#define BAD0 __VA_OPT__(1)
+#define BAD1(x) __VA_OPT__(x)
+#define BAD2(...) __VA_OPT__
+#define BAD3(...) __VA_OPT__(1
+#define BAD4(...) __VA_OPT__(__VA_OPT__(1))
+#define BAD5(...) __VA_OPT__(##x)
+#define BAD6(...) __VA_OPT__(x##)
+#define BAD7(__VA_OPT__) 1
+#define __VA_OPT__ 1
+
+/*
+ * check-name: c23-va-opt-error
+ * check-command: sparse -std=3Dc23 -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/c23-va-opt-error.c:1:14: error: __VA_OPT__ can only appear =
in the expansion of a variadic macro
+preprocessor/c23-va-opt-error.c:2:17: error: __VA_OPT__ can only appear =
in the expansion of a variadic macro
+preprocessor/c23-va-opt-error.c:3:19: error: expected '(' after __VA_OPT=
__
+preprocessor/c23-va-opt-error.c:4:19: error: unterminated __VA_OPT__
+preprocessor/c23-va-opt-error.c:5:30: error: __VA_OPT__ cannot appear wi=
thin __VA_OPT__
+preprocessor/c23-va-opt-error.c:6:30: error: '##' cannot appear at the b=
eginning of __VA_OPT__
+preprocessor/c23-va-opt-error.c:7:31: error: '##' cannot appear at the e=
nd of __VA_OPT__
+preprocessor/c23-va-opt-error.c:8:14: error: __VA_OPT__ cannot appear in=
 a macro parameter list
+preprocessor/c23-va-opt-error.c:9:9: error: "__VA_OPT__" cannot be used =
as a macro name
+ * check-error-end
+ */
diff --git a/validation/preprocessor/c23-va-opt.c b/validation/preprocess=
or/c23-va-opt.c
new file mode 100644
index 000000000000..b2318faf298f
--- /dev/null
+++ b/validation/preprocessor/c23-va-opt.c
@@ -0,0 +1,73 @@
+#define LOG(fmt, ...) printf(fmt __VA_OPT__(, __VA_ARGS__))
+LOG("empty")
+LOG("empty", )
+LOG("one", 1)
+LOG("two", 1, 2)
+
+#define M(...) __VA_OPT__(1) 2 __VA_OPT__(3)
+M()
+M(a)
+
+#define N(...) __VA_OPT__(foo(bar(baz)))
+N()
+N(1)
+
+#define G(a, b, ...) a b __VA_OPT__(c)
+G(1, 2)
+G(1, 2, )
+G(1, 2, 3)
+
+#define EMPTY
+#define VA_ORDER1(...) __VA_ARGS__ __VA_OPT__(opt)
+#define VA_ORDER2(...) __VA_OPT__(opt) __VA_ARGS__
+VA_ORDER1()
+VA_ORDER2()
+VA_ORDER1(EMPTY)
+VA_ORDER2(EMPTY)
+
+#define K 42
+#define X hello
+#define S(a, ...) #__VA_OPT__(a K __VA_ARGS__)
+S(X)
+S(X, Y)
+S(X, K)
+
+#define PASTE_L(x, ...) x ## __VA_OPT__(_suffix)
+#define PASTE_R(y, ...) __VA_OPT__(prefix_) ## y
+PASTE_L(foo)
+PASTE_L(foo, 1)
+PASTE_R(bar)
+PASTE_R(bar, 1)
+
+#define FN(v) ((v) + 1)
+#define CALL(...) __VA_OPT__(FN)(10)
+CALL()
+CALL(1)
+
+/*
+ * check-name: c23-va-opt
+ * check-command: sparse -std=3Dc23 -E $file
+ *
+ * check-output-start
+
+printf("empty" )
+printf("empty" )
+printf("one" , 1)
+printf("two" , 1, 2)
+2
+1 2 3
+foo(bar(baz))
+1 2
+1 2
+1 2 c
+""
+"hello K Y"
+"hello K 42"
+foo
+foo_suffix
+bar
+prefix_bar
+(10)
+((10) + 1)
+ * check-output-end
+ */
