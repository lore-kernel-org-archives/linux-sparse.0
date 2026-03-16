Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECE25A655
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=owJbPw3U6fxyo87d+4iIv3QqJGXfn2l26pLR9cbtG6gPF3sv6bh8DWMFoIyrt3f3MykSxP1gTw7XCMdaqFR/VU4EaHRwTJsjjP8MtAkzUOmayhZ6fyhwl5cD1z58xLQGL81cYtbUJtU6G7YO2Skw9/qFfvJMo7VQejFszZRkJV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=Bd2qfgCj60M4dr7tRbcvOcnZVc28CJN0vIflq14W02g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UhitaWx69wGExAqotEp7lN/GMc2oMd7ADBHUTE4kWHoqhjGgo+pejF/YU3KgX5NLi+njl57dhveItmH9DowRD8lHvRMh8MMiCS/Wvge71mEObimQKPkmOQAsIkf/G534YOsxtCQeQPLjiZ7eYTaUR27Hr0MRYtkS2HhCbO/bmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eRZUb5Rc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eRZUb5Rc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r754PfI7A/eLzNZvm6Yucsa2Sca1baqogr62E/dtk08=; b=eRZUb5Rc5wKRJZLn3/J/yZOVwZ
	kMZykZLl8ahLgTiBilu61bM3QLW+gt2s8FX+829Qd8RuCr0ldgs+Mry4zXo7SrTaspXQ+6sBiSUyE
	aF5+8mEx9Ma3BS5DZuA4xvh2DdrMQY9oGRgb+PlQcepPh9OWDL9/ikb39DDShi7wKY4cpkI5rrWLc
	7ugea3vFWgGdK/O4gfsPWUBcCeudLETzWimDk2Ri7wJXBxuQ5cRj22W/OpcJXcduUZDUd2zyXymFL
	7zysOChxKwEVB0zQaTajdNmhShJO7n7Zm7CaRIw571mHqC3q9/+R9y6PupabatrKJlZhXhbCNEiom
	9biqiTmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zs-00000003E13-2EwJ;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 04/21] parsing #define: saner handling of argument count, part 1
Date: Mon, 16 Mar 2026 07:03:58 +0000
Message-ID: <20260316070415.768839-4-viro@zeniv.linux.org.uk>
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

Mangling arglist the way we do is a bad kludge and it limits what we
can do both at parsing a macro definition and at expansion time.

We use it to
	* store the number of arguments (gets stashed in the cannibalized
token of opening parenthesis)
	* store the number of times each argument is used expanded,
unexpanded and stringified (stashed in cannibalized token of comma or
closing parenthesis that follows an argument)
	* mark the vararg argument (ditto)

Total number of arguments would be better off in struct symbol, next
to arglist.  As the matter of fact, we'd be better off with number of
non-vararg arguments and "is there a vararg" stored separately.

Number of times each argument occurs expanded, etc. is used to find if
given occurrence of argument in the body is the last one of given sort
- by counting down as we process the body during expansion, no less.
Each counter runs down at the same token of the body every time we expand
the macro, and we can just as easily mark those tokens when we parse the
definition.  It is also used to tell whether we need to expand and/or
stringify the argument in the first place.  Again, easily expressed
as marking the tokens and we can easily steal bits for TOKEN_..._ARG
payload - we have a 32bit value that represents the argument's number.

"Is it a vararg argument" flag is used both at definition parsing time
(when we would be better off with "the index of vararg argument or -1
if there's none") and at expansion time, when we collect the arguments.
There we pass those values to collect_argument(), telling it whether it
should stop on (unprotected) commas.  The current logics is seriously
convoluted, especially around the error recovery.  Untangling that ends
up with a variant that wants to know the number of non-vararg arguments
along with "do we have a vararg at all" flag, upfront and not scattered
through the arglist.

As the first step, introduce sym->fixed_args and sym->vararg and have
them calculated when we parse a macro definition; stop storing the number
of arguments in the first token of arglist.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 64 +++++++++++++++++++++++++++++++++++----------------
 symbol.h      |  1 +
 2 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 320a5247..d591a183 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -312,9 +312,10 @@ struct arg {
 	int n_str;
 };
 
-static int collect_arguments(struct token *start, struct token *arglist, struct arg *args, struct token *what)
+static int collect_arguments(struct token *start, struct symbol *sym, struct arg *args, struct token *what)
 {
-	int wanted = arglist->count.normal;
+	struct token *arglist = sym->arglist;
+	int wanted = sym->fixed_args + sym->vararg;
 	struct token *next = NULL;
 	int count = 0;
 
@@ -760,7 +761,7 @@ static int expand(struct token **list, struct symbol *sym)
 	struct ident *expanding = token->ident;
 	struct token **tail;
 	struct token *expansion = sym->expansion;
-	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
+	int nargs = sym->fixed_args + sym->vararg;
 	struct arg args[nargs];
 
 	if (expanding->tainted) {
@@ -771,7 +772,7 @@ static int expand(struct token **list, struct symbol *sym)
 	if (sym->arglist) {
 		if (!match_op(scan_next(&token->next), '('))
 			return 1;
-		if (!collect_arguments(token->next, sym->arglist, args, token))
+		if (!collect_arguments(token->next, sym, args, token))
 			return 1;
 		expand_arguments(nargs, args);
 	}
@@ -1087,6 +1088,21 @@ static int token_list_different(struct token *list1, struct token *list2)
 	}
 }
 
+static int macro_nargs = 0;
+static int macro_vararg = -1;
+static bool macro_funclike = false;
+
+static bool macro_add_arg(struct position pos, struct ident *ident)
+{
+	if (macro_nargs == 1024)
+		goto Eargs;
+	macro_nargs++;
+	return true;
+Eargs:
+	sparse_error(pos, "too many arguments in macro definition");
+	return false;
+}
+
 static inline void set_arg_count(struct token *token)
 {
 	token_type(token) = TOKEN_ARG_COUNT;
@@ -1097,7 +1113,6 @@ static inline void set_arg_count(struct token *token)
 static struct token *parse_arguments(struct token *list)
 {
 	struct token *arg = list->next, *next = list;
-	struct argcount *count = &list->count;
 
 	set_arg_count(list);
 
@@ -1110,10 +1125,10 @@ static struct token *parse_arguments(struct token *list)
 	while (token_type(arg) == TOKEN_IDENT) {
 		if (arg->ident == &__VA_ARGS___ident)
 			goto Eva_args;
-		if (!++count->normal)
-			goto Eargs;
-		next = arg->next;
+		if (!macro_add_arg(arg->pos, arg->ident))
+			return NULL;
 
+		next = arg->next;
 		if (match_op(next, ',')) {
 			set_arg_count(next);
 			arg = next->next;
@@ -1132,6 +1147,7 @@ static struct token *parse_arguments(struct token *list)
 		if (match_op(next, SPECIAL_ELLIPSIS)) {
 			if (match_op(next->next, ')')) {
 				set_arg_count(next);
+				macro_vararg = macro_nargs - 1;
 				next->count.vararg = 1;
 				next = next->next;
 				arg->next->next = &eof_token_entry;
@@ -1156,9 +1172,10 @@ static struct token *parse_arguments(struct token *list)
 		arg->ident = &__VA_ARGS___ident;
 		if (!match_op(next, ')'))
 			goto Enotclosed;
-		if (!++count->normal)
-			goto Eargs;
+		if (!macro_add_arg(arg->pos, &__VA_ARGS___ident))
+			return NULL;
 		set_arg_count(next);
+		macro_vararg = macro_nargs - 1;
 		next->count.vararg = 1;
 		next = next->next;
 		arg->next->next = &eof_token_entry;
@@ -1188,9 +1205,6 @@ Enotclosed:
 Eva_args:
 	sparse_error(arg->pos, "__VA_ARGS__ can only appear in the expansion of a C99 variadic macro");
 	return NULL;
-Eargs:
-	sparse_error(arg->pos, "too many arguments in macro definition");
-	return NULL;
 }
 
 static int try_arg(struct token *token, enum token_type type, struct token *arglist)
@@ -1198,7 +1212,7 @@ static int try_arg(struct token *token, enum token_type type, struct token *argl
 	struct ident *ident = token->ident;
 	int nr;
 
-	if (!arglist || token_type(token) != TOKEN_IDENT)
+	if (!macro_funclike || token_type(token) != TOKEN_IDENT)
 		return 0;
 
 	arglist = arglist->next;
@@ -1221,7 +1235,7 @@ static int try_arg(struct token *token, enum token_type type, struct token *argl
 				n = ++count->str;
 			}
 			if (n)
-				return count->vararg ? 2 : 1;
+				return nr == macro_vararg ? 2 : 1;
 			/*
 			 * XXX - need saner handling of that
 			 * (>= 1024 instances of argument)
@@ -1236,7 +1250,7 @@ static int try_arg(struct token *token, enum token_type type, struct token *argl
 static struct token *handle_hash(struct token **p, struct token *arglist)
 {
 	struct token *token = *p;
-	if (arglist) {
+	if (macro_funclike) {
 		struct token *next = token->next;
 		if (!try_arg(next, TOKEN_STR_ARGUMENT, arglist))
 			goto Equote;
@@ -1354,7 +1368,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 
 	expansion = parse_expansion(expansion, arglist, name);
 	if (!expansion)
-		return 1;
+		goto out;
 
 	sym = lookup_symbol(name, NS_MACRO | NS_UNDEF);
 	if (sym) {
@@ -1388,6 +1402,8 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 	if (!ret) {
 		sym->expansion = expansion;
 		sym->arglist = arglist;
+		sym->vararg = macro_vararg >= 0;
+		sym->fixed_args = macro_nargs - sym->vararg;
 		if (token) /* Free the "define" token, but not the rest of the line */
 			__free_token(token);
 	}
@@ -1396,6 +1412,9 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 	sym->used_in = NULL;
 	sym->attr = attr;
 out:
+	macro_nargs = 0;
+	macro_vararg = -1;
+	macro_funclike = false;
 	return ret;
 }
 
@@ -1490,8 +1509,12 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 		if (match_op(expansion, '(')) {
 			arglist = expansion;
 			expansion = parse_arguments(expansion);
-			if (!expansion)
+			if (!expansion) {
+				macro_nargs = 0;
+				macro_vararg = -1;
 				return 1;
+			}
+			macro_funclike = true;
 		} else if (!eof_token(expansion)) {
 			warning(expansion->pos,
 				"no whitespace before object-like macro body");
@@ -2075,8 +2098,9 @@ static void create_arglist(struct symbol *sym, int count)
 
 	token = __alloc_token(0);
 	token_type(token) = TOKEN_ARG_COUNT;
-	token->count.normal = count;
 	sym->arglist = token;
+	sym->fixed_args = count;
+	sym->vararg = 0;
 	next = &token->next;
 
 	while (count--) {
@@ -2300,7 +2324,7 @@ static int is_VA_ARGS_token(struct token *token)
 
 static void dump_macro(struct symbol *sym)
 {
-	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
+	int nargs = sym->fixed_args + sym->vararg;
 	struct token *args[nargs];
 	struct token *token;
 
diff --git a/symbol.h b/symbol.h
index 3552d439..026dab6f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -168,6 +168,7 @@ struct symbol {
 			struct scope *used_in;
 			void (*expand_simple)(struct token *);
 			bool (*expand)(struct token *, struct arg *args);
+			int fixed_args, vararg;
 		};
 		struct /* NS_PREPROCESSOR */ {
 			int (*handler)(struct stream *, struct token **, struct token *);
-- 
2.47.3

