Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0334D394
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644476; cv=none; b=QiuAftutqv9oFHEEXiUMXtICwxbTLXFAmNfOu+o/ADp3TWD+NxdU6Ugfl/xl9FCOvJuDIDH6m4oZNYVvJgATSPSl4LTpO1iK/ydxsIthSoJ5NJdV9b33lAoR0wWeNkKy1qC6+O3YRlV3rO+L8m4TH+HnTIrQ4caJf1qsLFKeXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644476; c=relaxed/simple;
	bh=WR2erK6mWZ8gyh965CvhJ89BnEQK/M8caQQKzM4hBTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRV18xnLofwt8chsynpTy4/whXgzWy89GUvJ7duI3YZGYaYATxQnv8lSjT4aYpPmpubuYrhBZxAwtfUvhrVHfLic1ZCeOUEVVu7Fulvfh9FDXLqyVPbm6K12GcFRcOB5AecQ+tRfYjgqe7eIG4SM7+IN1oL1UryJmxH2+GXf6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nyWz4m3e; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nyWz4m3e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=AXaRvTdFXBj8k4Yl4JBn+BKnlb85cx9DwkxZ7w9obg8=; b=nyWz4m3ecmmcnygcmShqzZZ5tf
	BYS1rLuxTbqePFGBR74auUVQzNWb7ZtdGvhNO8qoO00keCESeQNZZhyJVCyu4gsY1b+M9sCUUkohX
	ZXO+jW9nJQ2DLOsgB85uibxnloGRDWoM3cTdU7DTDPar0GltRDJ9tjwqXDMRFmTPiBKJuRcNbmqGt
	/T1vPMB+nsRtSNK3cyCzWkd90m2Il3OEJ/AQTeyg61hvNcshUcLD07ZfZxdAJLI/nOAnWMMx+Zx7Y
	hTjLi5tlnB6lzZIsDcRyx80R3hr+LGfU5cg/UP4BTgKADogwTVaHyUXEzHK+IUQn5XoYb0koo8MdO
	R8YYoYXA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E3N-3Htb;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 16/21] __VA_OPT__: parsing
Date: Mon, 16 Mar 2026 07:04:10 +0000
Message-ID: <20260316070415.768839-16-viro@zeniv.linux.org.uk>
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

va-opt-replacement can occur in any place where a macro argument of a
vararg macro might.  It consists of identifier __VA_OPT__, followed by
'(', a sequence of pp-tokens with balanced parentheses (body of that
va-opt-replacement) and finally a ')'.

Body of va-opt-replacement may not contain __VA_OPT__ and may not begin
or end with a ##.

At the expansion time va-opt-replacement is handled at the same stage as
argument substitution.  What happens depends upon the value of __VA_ARGS__
- if it would expand to an empty token sequence, each va-opt-replacement
in the body is treated the same way as an occurrence of an empty argument
(replaced by an empty string literal if preceded by a # operator and by
placemarker token otherwise).

If __VA_ARGS__ does *not* expand to an empty token sequence, the body of
va-opt-replacement is subjected to argument substitution and # processing,
as if it had been the entire macro body.  Leading and trailing whitespace
is stripped from the result.  If va-opt-replacement is not preceded by
a # operator, the resulting list is substituted in its place.  If it
*is* preceded by a # operator, the resulting list is subjected to ##
processing/placemarker removal and converted into a string literal token.
That token is substituted in place of # va-opt-replacement combination.

All of that is followed by usual processing of remaining ## operators and
placemarker removal (we are, of course, allowed to calculate the individual
token concatenations earlier, provided that end result is the same).

For non-stringified instances it's _almost_ the same as if all
va-opt-replacements had been replaced with their bodies in case when
__VA_ARGS__ expands to non-empty sequence of tokens; the only difference
is that ## next to va-opt-replacement does not suppress expansion of
arguments inside; for example
	#define FOO BAR
	#define A(X) X ## 1			// X is not expanded
	#define B(X,...) __VA_OPT__(X) ## 1	// X is expanded
	A(FOO)
	B(FOO,_)
	B(FOO)
yields
	FOO1
	BAR1
	1
Any ## inside the va-opt-replacement still have the usual effect on the
adjacent macro arguments.

In other words, for non-stringified __VA_OPT__ we can simply
	* parse its body as if it had been an entire macro (with the
usual handling of arguments)
	* when substitute() gets to va-opt-replacement, check if expansion
of __VA_ARGS__ is empty
	* if it is, just do what we do when seeing an empty argument,
otherwise switch to taking tokens to interpret from the body of that
va-opt-replacement until we reach its end, then proceed to interpret
the rest of the body of our macro.

For stringified __VA_OPT__ we need to save the state of interpreter (body,
list, state), switch to (body of va-opt-replacement, private list, Normal)
and once we are done stringify the private list, restore the saved state
and add the string token we've got to the main list, same as usual.

Note on whitespace handling: whitespace in front of the first token
coming from va-opt-replacement is _not_ affected by whatever whitespace
we might have between __VA_OPT__ and '(' or '(' and the body; only
the whitespace preceding the __VA_OPT__ itself matters.

Representation:

* new token types: TOKEN_VA_OPT and TOKEN_VA_OPT_STR; va-opt-replacement
and # va-opt-replacement resp. get converted to that, with the body +
surrounding parentheses stripped from the list and reference to the
opening parenthesis stored into ->va_opt_linkage of the converted __VA_OPT__
token.

Closing parenthesis is converted to TOKEN_VA_OPT; its ->next points to
eof_token_entry to make it distinguishable from the normal TOKEN_VA_OPT
and its ->va_opt_linkage points back to the originating TOKEN_VA_OPT or
TOKEN_VA_OPT_STR - basically, that will serve as return instruction.
We could add a separate token type for that, but that would only make
things more inconvenient at expansion time.

Note that in all cases ->va_opt_linkage points to the token immediately
preceding the ones we should proceed to; that will simplify life at
expansion time.

This commit contains the parser side of the things.  Substitution side
is done in the next one.

* check_arg() taught to recognize and parse __VA_OPT__(...); returns -1
on failure and 0 (not an argument of macro) on success.  Callers updated.

* dump_macro() and token_list_different() taught to handle those.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ident-list.h                             |   1 +
 pre-process.c                            | 233 ++++++++++++++++++-----
 token.h                                  |   3 +
 validation/preprocessor/dump-macro.c     |   4 +-
 validation/preprocessor/va_opt_compare.c |  28 +++
 validation/preprocessor/va_opt_parse.c   |  37 ++++
 6 files changed, 258 insertions(+), 48 deletions(-)
 create mode 100644 validation/preprocessor/va_opt_compare.c
 create mode 100644 validation/preprocessor/va_opt_parse.c

diff --git a/ident-list.h b/ident-list.h
index 3c08e8ca..556d4050 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -65,6 +65,7 @@ IDENT(c_generic_selections);
 IDENT(c_static_assert);
 __IDENT(pragma_ident, "__pragma__", 0);
 __IDENT(__VA_ARGS___ident, "__VA_ARGS__", 0);
+__IDENT(__VA_OPT___ident, "__VA_OPT__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
diff --git a/pre-process.c b/pre-process.c
index 51ad916c..0f0dbc56 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -640,6 +640,11 @@ static struct token *do_argument(const struct token *body,
 	return arg;	// ARG_QUOTED
 }
 
+static bool is_end_va_opt(const struct token *token)
+{
+	return eof_token(token->next);
+}
+
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
@@ -996,6 +1001,8 @@ static int handle_argv_include(struct stream *stream, struct token **list, struc
 	return handle_include_path(stream, list, token, 2);
 }
 
+static int token_list_different(struct token *, struct token *);
+
 static int token_different(struct token *t1, struct token *t2)
 {
 	int different;
@@ -1039,6 +1046,29 @@ static int token_different(struct token *t1, struct token *t2)
 		different = memcmp(s1->data, s2->data, s1->length);
 		break;
 	}
+	case TOKEN_VA_OPT:
+		if (is_end_va_opt(t1)) {
+			/*
+			 * t1 is a return (at the end of __VA_OPT__ body);
+			 * the same should be true for t2 and that's it.
+			 */
+			different = !is_end_va_opt(t2);
+			break;
+		}
+		/*
+		 * t1 is a real __VA_OPT__; the same should be true for
+		 * t2...
+		 */
+		if (is_end_va_opt(t2)) {
+			different = 1;
+			break;
+		}
+		/* ... and their bodies should not be different */
+		/* fall-through */
+	case TOKEN_VA_OPT_STR:
+		different = token_list_different(t1->va_opt_linkage,
+						 t2->va_opt_linkage);
+		break;
 	default:
 		different = 1;
 		break;
@@ -1083,6 +1113,13 @@ Eargs:
 	return false;
 }
 
+static void misplaced_va_xxx(struct token *arg)
+{
+	sparse_error(arg->pos,
+	     "%s can only appear in the expansion of a C99 variadic macro",
+	     show_token(arg));
+}
+
 static struct token *parse_arguments(struct token *list)
 {
 	struct token *arg = list->next, *next = list;
@@ -1091,7 +1128,8 @@ static struct token *parse_arguments(struct token *list)
 		return arg;
 
 	while (token_type(arg) == TOKEN_IDENT) {
-		if (arg->ident == &__VA_ARGS___ident)
+		if (arg->ident == &__VA_ARGS___ident ||
+		    arg->ident == &__VA_OPT___ident)
 			goto Eva_args;
 		if (!macro_add_arg(arg->pos, arg->ident))
 			return NULL;
@@ -1156,7 +1194,7 @@ Enotclosed:
 	sparse_error(arg->pos, "missing ')' in macro parameter list");
 	return NULL;
 Eva_args:
-	sparse_error(arg->pos, "__VA_ARGS__ can only appear in the expansion of a C99 variadic macro");
+	misplaced_va_xxx(arg);
 	return NULL;
 }
 
@@ -1166,24 +1204,84 @@ struct arg_state {
 	struct token *needs_str;
 };
 
+static bool in_va_opt;
+
+static struct token **parse_body(struct token **list, struct arg_state args[]);
+
+static int parse_va_opt(struct token *token, struct arg_state args[])
+{
+	struct token **p = &token->next;
+	struct token *next = *p;
+	int nesting = 0;
+
+	if (macro_vararg < 0)
+		goto Evararg;
+	if (in_va_opt)
+		goto Enested;
+
+	if (!match_op(next, '('))
+		goto Eunterminated;
+	token_type(token) = TOKEN_VA_OPT;
+	token->va_opt_linkage = next;
+	next->next->pos.whitespace = token->pos.whitespace;
+	for (; !eof_token(next); p = &next->next, next = *p) {
+		if (token_type(next) != TOKEN_SPECIAL)
+			continue;
+		if (next->special == ')') {
+			if (!--nesting) {
+				*p = &eof_token_entry; // cut prior to that ')'
+				in_va_opt = true;
+				p = parse_body(&token->va_opt_linkage->next, args);
+				in_va_opt = false;
+				if (!p)
+					return -1;
+				// strip everything up to ')' from the list
+				token->next = next->next;
+				// convert the ')' into return
+				token_type(next) = TOKEN_VA_OPT;
+				next->va_opt_linkage = token;
+				next->next = &eof_token_entry;
+				// and reattach it to the end of body
+				*p = next;
+				return 0;
+			}
+		} else if (next->special == '(')
+			nesting++;
+	}
+Eunterminated:
+	sparse_error(token->pos, "unterminated __VA_OPT__");
+	return -1;
+
+Enested:
+	sparse_error(token->pos, "__VA_OPT__ may not appear in a __VA_OPT__");
+	return -1;
+Evararg:
+	misplaced_va_xxx(token);
+	return -1;
+}
+
 static int check_arg(struct token *token, struct arg_state args[])
 {
-	struct ident *ident = token->ident;
+	struct ident *ident;
 	int nr;
 
-	if (!macro_funclike || token_type(token) != TOKEN_IDENT)
+	if (!macro_nargs || token_type(token) != TOKEN_IDENT)
 		return 0;
 
+	ident = token->ident;
 	for (nr = 0; nr < macro_nargs && macro_arg_name[nr] != ident; nr++)
 		;
 
-	if (nr == macro_nargs)
-		return 0;
+	if (nr < macro_nargs) {
+		nr = nr == macro_vararg ? 0 : nr + 1;
+		token->argnum = nr << ARGNUM_BITS_STOLEN;
+		token_type(token) = TOKEN_MACRO_ARGUMENT;
+		return nr + 1;
+	}
 
-	nr = nr == macro_vararg ? 0 : nr + 1;
-	token->argnum = nr << ARGNUM_BITS_STOLEN;
-	token_type(token) = TOKEN_MACRO_ARGUMENT;
-	return nr + 1;
+	if (ident != &__VA_OPT___ident)
+		return 0;
+	return parse_va_opt(token, args);
 }
 
 static void seen_arg(struct token *token, enum arg_kind kind, struct arg_state args[], int nr)
@@ -1210,13 +1308,19 @@ static struct token *handle_hash(struct token **p, struct arg_state args[])
 	struct token *token = *p;
 	if (macro_funclike) {
 		struct token *next = token->next;
-		int nr = check_arg(next, args);
-
-		if (!nr)
-			goto Equote;
+		int nr;
 
-		seen_arg(next, ARG_STR, args, nr - 1);
 		next->pos.whitespace = token->pos.whitespace;
+
+		nr = check_arg(next, args);
+		if (nr < 0)
+			return NULL;
+		if (token_type(next) == TOKEN_MACRO_ARGUMENT)
+			seen_arg(next, ARG_STR, args, nr - 1);
+		else if (token_type(next) == TOKEN_VA_OPT)
+			token_type(next) = TOKEN_VA_OPT_STR;
+		else
+			goto Equote;
 		__free_token(token);
 		token = *p = next;
 	} else {
@@ -1259,6 +1363,8 @@ static struct token *handle_hashhash(struct token *token, struct arg_state args[
 		}
 
 		nr = check_arg(t, args);
+		if (nr < 0)
+			return NULL;
 		if (nr > 0)
 			seen_arg(t, ARG_QUOTED, args, nr - 1);
 
@@ -1284,24 +1390,24 @@ Econcat:
 	return NULL;
 }
 
-static struct token *parse_expansion(struct token *expansion, struct ident *name)
+static struct token **parse_body(struct token **list, struct arg_state args[])
 {
-	int slots = macro_nargs + (macro_vararg < 0);
-	struct arg_state args[slots] = {};
-	struct token *token = expansion;
-	struct token **p;
-	int nr;
+	struct token *token = *list;
 
 	if (match_op(token, SPECIAL_HASHHASH))
 		goto Econcat;
 
-	for (p = &expansion; !eof_token(token); p = &token->next, token = *p) {
+	while (!eof_token(token)) {
+		int nr;
+
 		if (match_op(token, '#')) {
-			token = handle_hash(p, args);
+			token = handle_hash(list, args);
 			if (!token)
 				return NULL;
 		}
 		nr = check_arg(token, args);
+		if (nr < 0)
+			return NULL;
 		if (match_op(token->next, SPECIAL_HASHHASH)) {
 			if (nr > 0)
 				seen_arg(token, ARG_QUOTED, args, nr - 1);
@@ -1312,7 +1418,26 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 			if (nr > 0)
 				seen_arg(token, ARG_NORMAL, args, nr - 1);
 		}
+		list = &token->next;
+		token = *list;
 	}
+	return list;
+
+Econcat:
+	sparse_error(token->pos, "'##' cannot appear at the ends of macro expansion");
+	return NULL;
+}
+
+static struct token *parse_expansion(struct token *expansion, struct ident *name)
+{
+	int slots = macro_nargs + (macro_vararg < 0);
+	struct arg_state args[slots] = {};
+	struct token **tail;
+	struct token *token;
+
+	tail = parse_body(&expansion, args);
+	if (!tail)
+		return NULL;
 	for (int i = 0; i < slots; i++) {
 		if (args[i].needs_str)
 			args[i].needs_str->argnum |= 1 << ARGNUM_CONSUME;
@@ -1329,13 +1454,9 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 	token = alloc_token(&expansion->pos);
 	token_type(token) = TOKEN_UNTAINT;
 	token->ident = name;
-	token->next = *p;
-	*p = token;
+	token->next = &eof_token_entry;
+	*tail = token;
 	return expansion;
-
-Econcat:
-	sparse_error(token->pos, "'##' cannot appear at the ends of macro expansion");
-	return NULL;
 }
 
 static int do_define(struct position pos, struct token *token, struct ident *name,
@@ -2279,6 +2400,40 @@ struct token * preprocess(struct token *token)
 	return token;
 }
 
+static void dump_body(struct token *token, struct ident *args[])
+{
+	bool first = true;
+	while (!eof_token(token) && token_type(token) != TOKEN_UNTAINT) {
+		struct token *next = token->next;
+		if (!first && token->pos.whitespace)
+			putchar(' ');
+		first = false;
+		switch (token_type(token)) {
+		case TOKEN_CONCAT:
+			printf("##");
+			break;
+		case TOKEN_MACRO_ARGUMENT:
+			if (argkind(token) == ARG_STR)
+				printf("#");
+			printf("%s", show_ident(args[argnum(token)]));
+			break;
+		default:
+			printf("%s", show_token(token));
+			break;
+		case TOKEN_VA_OPT_STR:
+			printf("#");
+			/* fall-through */
+		case TOKEN_VA_OPT:
+			if (is_end_va_opt(token))
+				break;
+			printf("__VA_OPT__(");
+			dump_body(token->va_opt_linkage->next, args);
+			printf(")");
+		}
+		token = next;
+	}
+}
+
 static void dump_macro(struct symbol *sym)
 {
 	int fixed_args = sym->fixed_args;
@@ -2298,26 +2453,10 @@ static void dump_macro(struct symbol *sym)
 			}
 		}
 	}
+	putchar(' ');
 
 	token = sym->expansion;
-	while (token_type(token) != TOKEN_UNTAINT) {
-		struct token *next = token->next;
-		if (token->pos.whitespace)
-			putchar(' ');
-		switch (token_type(token)) {
-		case TOKEN_CONCAT:
-			printf("##");
-			break;
-		case TOKEN_MACRO_ARGUMENT:
-			if (argkind(token) == ARG_STR)
-				printf("#");
-			printf("%s", show_ident(args[argnum(token)]));
-			break;
-		default:
-			printf("%s", show_token(token));
-		}
-		token = next;
-	}
+	dump_body(token, args);
 	putchar('\n');
 }
 
diff --git a/token.h b/token.h
index e469e02d..3edf4ce1 100644
--- a/token.h
+++ b/token.h
@@ -102,6 +102,8 @@ enum token_type {
 	TOKEN_MACRO_ARGUMENT,
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
+	TOKEN_VA_OPT,
+	TOKEN_VA_OPT_STR,
 	TOKEN_UNTAINT,
 	TOKEN_IF,
 	TOKEN_SKIP_GROUPS,
@@ -199,6 +201,7 @@ struct token {
 		unsigned int special;
 		struct string *string;
 		int argnum;
+		struct token *va_opt_linkage;
 		char embedded[4];
 	};
 };
diff --git a/validation/preprocessor/dump-macro.c b/validation/preprocessor/dump-macro.c
index 710c1027..b0085840 100644
--- a/validation/preprocessor/dump-macro.c
+++ b/validation/preprocessor/dump-macro.c
@@ -1,11 +1,13 @@
 #define A(X,Y,...) __VA_ARGS__,Y,X
 #define B(X,Y...) Y
+#define C(...) __VA_OPT__(1 #__VA_ARGS__) #__VA_OPT__(1 __VA_ARGS__)
 /*
  * check-name: -dM handling of varargs
- * check-command: sparse -E -dM $file | tail -2
+ * check-command: sparse -E -dM $file | tail -3
  *
  * check-output-start
 #define A(X,Y,...) __VA_ARGS__,Y,X
 #define B(X,Y...) Y
+#define C(...) __VA_OPT__(1 #__VA_ARGS__) #__VA_OPT__(1 __VA_ARGS__)
  * check-output-end
  */
diff --git a/validation/preprocessor/va_opt_compare.c b/validation/preprocessor/va_opt_compare.c
new file mode 100644
index 00000000..ad15cabe
--- /dev/null
+++ b/validation/preprocessor/va_opt_compare.c
@@ -0,0 +1,28 @@
+#define OK1(X,...) __VA_OPT__(X =)
+#define OK1(X,...) __VA_OPT__(X =)
+#define OK2(X,...) #__VA_OPT__(X =)
+#define OK2(X,...) #__VA_OPT__(X =)
+#define BAD1(X,...) __VA_OPT__(X)
+#define BAD1(X,...) __VA_OPT__(_)
+#define BAD2(X,...) __VA_OPT__(,)
+#define BAD2(X,...) ,
+#define BAD3(X,...) __VA_OPT__(,)
+#define BAD3(X,...) #__VA_OPT__(,)
+/*
+ * check-name: __VA_OPT__ comparison
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/va_opt_compare.c:6:9: warning: preprocessor token BAD1 redefined
+preprocessor/va_opt_compare.c:5:9: this was the original definition
+preprocessor/va_opt_compare.c:8:9: warning: preprocessor token BAD2 redefined
+preprocessor/va_opt_compare.c:7:9: this was the original definition
+preprocessor/va_opt_compare.c:10:9: warning: preprocessor token BAD3 redefined
+preprocessor/va_opt_compare.c:9:9: this was the original definition
+ * check-error-end
+ */
diff --git a/validation/preprocessor/va_opt_parse.c b/validation/preprocessor/va_opt_parse.c
new file mode 100644
index 00000000..4eb8675d
--- /dev/null
+++ b/validation/preprocessor/va_opt_parse.c
@@ -0,0 +1,37 @@
+#define A(__VA_OPT__)
+#define B(X) __VA_OPT__(_)
+#define C(X,...) __VA_OPT__(__VA_OPT__(_))
+#define D(X,...) __VA_OPT__
+#define E(X,...) __VA_OPT__(_
+#define OK(X,...) __VA_OPT__()
+#define OK2(X,...) __VA_OPT__(,(,,),)
+#define F(X,...) __VA_OPT__(,(,,,)
+#define OK3(X,...) __VA_OPT__(,(,,),))
+#define G1(...) __VA_OPT__(##)
+#define G2(...) __VA_OPT__(##,)
+#define G3(...) __VA_OPT__(,##)
+#define H(...) __VA_OPT__(#1)
+#define OK4(X,...) __VA_OPT__(__VA_ARGS__,#X)
+#define OK5(X,...) #__VA_OPT__(__VA_ARGS__,#X)
+/*
+ * check-name: __VA_OPT__ parsing
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/va_opt_parse.c:1:11: error: __VA_OPT__ can only appear in the expansion of a C99 variadic macro
+preprocessor/va_opt_parse.c:2:14: error: __VA_OPT__ can only appear in the expansion of a C99 variadic macro
+preprocessor/va_opt_parse.c:3:29: error: __VA_OPT__ may not appear in a __VA_OPT__
+preprocessor/va_opt_parse.c:4:18: error: unterminated __VA_OPT__
+preprocessor/va_opt_parse.c:5:18: error: unterminated __VA_OPT__
+preprocessor/va_opt_parse.c:8:18: error: unterminated __VA_OPT__
+preprocessor/va_opt_parse.c:10:28: error: '##' cannot appear at the ends of macro expansion
+preprocessor/va_opt_parse.c:11:28: error: '##' cannot appear at the ends of macro expansion
+preprocessor/va_opt_parse.c:12:29: error: '##' cannot appear at the ends of macro expansion
+preprocessor/va_opt_parse.c:13:27: error: '#' is not followed by a macro parameter
+ * check-error-end
+ */
-- 
2.47.3

