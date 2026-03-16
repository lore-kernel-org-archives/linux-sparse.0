Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F39269B1C
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644474; cv=none; b=N1tLUNqRWhD9ywBbG4AiO+GiKLxd2MzGO/eHdL/fdtHa5il22bKuvBqOpZVfJXNLCZXvNfRSHnEws3658xjSYrgSflisPJ8q7i1nfUNi5vN3tXkzfcGJIuO/4sVCx+w/p3cbzropNXwBxlfQpi8v1HansKF757qufTD3ruth5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644474; c=relaxed/simple;
	bh=xroPsff1elT2IfbX7gFES5YaPSkP1Eh5zZwDM88x9z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Go/+VeKMo+v0URM2jqpQebb/R8ap4zVas5mEaAQHQp3jC4sV33JABFybgW3dZ38W+nTuySVBAl1P7YcLtLlN5g/cRUme3J2XhHuZ/qEVBkIZzhmudggDooebMfZtSZqUtY9VFWWle4gBORGjpWNZ/2HkDz0IPut7SKRr34HA6/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wk+OTmPT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wk+OTmPT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HnrB2k1pxmHjYRzxSAzZqSLwQlUUqe6TPrPQSeyy8o0=; b=wk+OTmPT+r6cV2f8XyO8oBCH3b
	aUwui65OM3/E2SrNdi4/Ib3D9JHjRfDVUT9dbNucTatTSoaIoyONMc53LIwKs+yv3WfbBGG6hny9c
	GT5ApdJZTzBK/OS/LMZKm9yJwJGypvgwhW0giQy8j4hrQUCWlcWb7VybmvqLYAjUzQmZSxwwcqHRw
	cG5Mpff+w6qTyqavRs64m1iVSco8CQP40t2sykY5iH3YrxqI8BsOMFeoWCWvhNt8TdAzWd7uLgstb
	pGuPJGe1WFgPmLVUP1EkYBPuEJsYQPLQJgZApMd8gb8AXnelryjTlujj30HzticrWLbF/VTHL0p8b
	+bvhMQhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zs-00000003E16-2zWw;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 05/21] simplify collect_arguments() and fix error handling there
Date: Mon, 16 Mar 2026 07:03:59 +0000
Message-ID: <20260316070415.768839-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316070415.768839-1-viro@zeniv.linux.org.uk>
References: <20260316065622.GA607739@ZenIV>
 <20260316070415.768839-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The current logics is too convoluted.  We use collect_arg() to carve
an argument out; it takes a pointer to previous token (either opening
parenthesis or comma), finds how far does the argument extend, cuts the
list at its end and returns the token that follows it (normally either
closing parenthesis or the comma).  collect_arg() is told whether we
want a vararg argument or not - the difference is that normal arguments
terminate on commas.

When macro has N non-vararg arguments and V (0 or 1) vararg ones, we want
	* N calls of collect_arg() asking for non-vararg arguments;
all but the last one must be followed by commas.  The last one may be
followed either by comma or by closing parenthesis.
	* If we have seen exactly N commas, call collect_arg() asking
to collect everything until the closing parenthesis.  That will get us
to the end of arguments.

The only potential gotcha is that there is a case when "exactly N commas"
for non-vararg macro does _not_ mean excessive arguments - N = V = 0.
Not hard to account for - in that case we must look at the chunk carved
out by the last (and only) call of collect_arg(); that would be everything
between the parentheses.  If it's empty, we are fine, otherwise we've
excessive arguments.

Rather than trying to fold all of that into a single loop, separate
the handling of non-vararg arguments from the rest; the logics becomes
simpler that way, especially around the error recovery.

As a side benefit the 'vararg' bit in struct argcount becomes unused
and can be removed.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 104 ++++++++++++++++++++++----------------------------
 token.h       |   1 -
 2 files changed, 46 insertions(+), 59 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index d591a183..25990dfa 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -255,7 +255,7 @@ static void expand_list(struct token **list)
 
 static void preprocessor_line(struct stream *stream, struct token **line);
 
-static struct token *collect_arg(struct token *prev, int vararg, const struct position *pos)
+static struct token *collect_arg(struct token *prev, bool vararg, const struct position *pos)
 {
 	struct stream *stream = input_streams + prev->pos.stream;
 	struct token **p = &prev->next;
@@ -314,76 +314,66 @@ struct arg {
 
 static int collect_arguments(struct token *start, struct symbol *sym, struct arg *args, struct token *what)
 {
+	int fixed = sym->fixed_args;
+	bool vararg = sym->vararg;
 	struct token *arglist = sym->arglist;
-	int wanted = sym->fixed_args + sym->vararg;
-	struct token *next = NULL;
-	int count = 0;
+	struct argcount *p;
+	struct token *next = NULL, *v = NULL;
+	const char *err;
+	int commas;
 
 	arglist = arglist->next;	/* skip counter */
 
-	if (!wanted) {
-		next = collect_arg(start, 0, &what->pos);
-		if (eof_token(next))
+	for (commas = 0; commas < fixed; commas++) {
+		next = collect_arg(start, false, &what->pos);
+		if (token_type(next) != TOKEN_SPECIAL)
 			goto Eclosing;
-		if (!eof_token(start->next) || !match_op(next, ')')) {
-			count++;
-			goto Emany;
-		}
-	} else {
-		for (count = 0; count < wanted; count++) {
-			struct argcount *p = &arglist->next->count;
-			next = collect_arg(start, p->vararg, &what->pos);
-			if (eof_token(next))
-				goto Eclosing;
-			if (p->vararg && wanted == 1 && eof_token(start->next))
-				break;
-			arglist = arglist->next->next;
-			args[count].arg = start->next;
-			args[count].n_normal = p->normal;
-			args[count].n_quoted = p->quoted;
-			args[count].n_str = p->str;
-			if (match_op(next, ')')) {
-				count++;
-				break;
-			}
-			start = next;
-		}
-		if (count == wanted && !match_op(next, ')'))
-			goto Emany;
-		if (count == wanted - 1) {
-			struct argcount *p = &arglist->next->count;
-			if (!p->vararg)
+		p = &arglist->next->count;
+		arglist = arglist->next->next;
+		args[commas].arg = start->next;
+		args[commas].n_normal = p->normal;
+		args[commas].n_quoted = p->quoted;
+		args[commas].n_str = p->str;
+		if (!match_op(next, ',')) {
+			if (commas < fixed - 1)
 				goto Efew;
-			args[count].arg = NULL;
-			args[count].n_normal = p->normal;
-			args[count].n_quoted = p->quoted;
-			args[count].n_str = p->str;
+			break;
 		}
-		if (count < wanted - 1)
-			goto Efew;
+		start = next;
+	}
+	if (commas == fixed) {
+		next = collect_arg(start, true, &what->pos);
+		if (token_type(next) != TOKEN_SPECIAL)
+			goto Eclosing;
+		v = start->next;
+		if (fixed == 0 && eof_token(v))
+			v = NULL;
+	}
+	if (v && !vararg)
+		goto Eexcess;
+	if (vararg) {
+		p = &arglist->next->count;
+		args[fixed].arg = v;
+		args[fixed].n_normal = p->normal;
+		args[fixed].n_quoted = p->quoted;
+		args[fixed].n_str = p->str;
 	}
 	what->next = next->next;
 	return 1;
 
 Efew:
-	sparse_error(what->pos, "macro \"%s\" requires %d arguments, but only %d given",
-		show_token(what), wanted, count);
+	err = "too few arguments provided to";
+	next = next->next;
 	goto out;
-Emany:
-	while (match_op(next, ',')) {
-		next = collect_arg(next, 0, &what->pos);
-		count++;
-	}
-	if (eof_token(next))
-		goto Eclosing;
-	sparse_error(what->pos, "macro \"%s\" passed %d arguments, but takes just %d",
-		show_token(what), count, wanted);
+Eexcess:
+	err = "too many arguments provided to";
+	next = next->next;
 	goto out;
 Eclosing:
-	sparse_error(what->pos, "unterminated argument list invoking macro \"%s\"",
-		show_token(what));
+	err = "unterminated argument list invoking";
 out:
-	what->next = next->next;
+	sparse_error(what->pos, "%s macro \"%s\"", err, show_ident(sym->ident));
+	what->next = next;
 	return 0;
 }
 
@@ -1107,7 +1097,7 @@ static inline void set_arg_count(struct token *token)
 {
 	token_type(token) = TOKEN_ARG_COUNT;
 	token->count.normal = token->count.quoted =
-	token->count.str = token->count.vararg = 0;
+	token->count.str = 0;
 }
 
 static struct token *parse_arguments(struct token *list)
@@ -1148,7 +1138,6 @@ static struct token *parse_arguments(struct token *list)
 			if (match_op(next->next, ')')) {
 				set_arg_count(next);
 				macro_vararg = macro_nargs - 1;
-				next->count.vararg = 1;
 				next = next->next;
 				arg->next->next = &eof_token_entry;
 				return next->next;
@@ -1176,7 +1165,6 @@ static struct token *parse_arguments(struct token *list)
 			return NULL;
 		set_arg_count(next);
 		macro_vararg = macro_nargs - 1;
-		next->count.vararg = 1;
 		next = next->next;
 		arg->next->next = &eof_token_entry;
 		return next;
diff --git a/token.h b/token.h
index 9000e0cb..5dcd8594 100644
--- a/token.h
+++ b/token.h
@@ -175,7 +175,6 @@ struct argcount {
 	unsigned normal:10;
 	unsigned quoted:10;
 	unsigned str:10;
-	unsigned vararg:1;
 };
 
 /*
-- 
2.47.3

