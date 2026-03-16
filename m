Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B541EDA32
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=Gvv74zmzPFtLAfVt5mMVwnvoOxeYv80S8s+8Bcs8IKvgbtMilimgiK9MvDLdI4352/uc2A8u2JZeALv2tdYCem0r0X78iGD8dAi7EqAEsLsWXhCS4JpKLAIwZzXGfR56CvP9wkFT0wLPpDLJR5e23Wye7C46EUG6C5eqhrbFDkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=zY0gso2EuMkoNiLCuLr9ja8iOtqgmuouGvxpSt9GQjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJKEsQHzwvVzfyyaPhMW8Xi6pjcHJ0PQiffU9i0+ZL9ZEBgXEeqJLgF63OrahCGTN6sksJuEC5sSCXmZT8ahxj1zPapoZY1graSeIfLwSezli8VdJBZv7UF2EEGV/t79yBNth6So6zLiogT1vhCgxs4vFMFwv0O6MYHyZ3QyuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZIcZ5Osc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZIcZ5Osc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jZCL6uny/YwFpCZM2yBwhLSQxtFK8bpH4+eTN+7bYBU=; b=ZIcZ5OscY5B0BT3pBo+0j0JQNF
	vfagggg1BG8de6M/ss1eZX2kfldmLYk10vpn/AZMIqnMgrBGeWwUNnqjQe3+zuW6EzxMesTtAYWiB
	cinuhRAjYm9YFCEaI4sMwZVMvemsv/yY1CEIEjvkRq5vbeeVM38tPxH4VXSrOHhIjxQ8c1SMImKXX
	0M85ScEVWhNeWE4r7iiFGUUqrsw+1gk6//gqAJX11S6kWbwJLekGJDmc9ZohTC2gqSa6tMAP3ZSp9
	E5j37DHdMEwgNf918OhU7rzJF+q7567YlezJMONH2MJ4WnjDuzUIzTLqphE7QY9g09R54rWTgmS1k
	bpn7aV8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zt-00000003E2F-328V;
	Mon, 16 Mar 2026 07:04:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 10/21] on-demand argument expansion
Date: Mon, 16 Mar 2026 07:04:04 +0000
Message-ID: <20260316070415.768839-10-viro@zeniv.linux.org.uk>
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

Instead of calculating expanded and stringified forms of arguments before
we get to interpolating them into the body, do that on demand.

There are several subtle points involved:

	* array of arguments ('args' in collect_arguments() and friends)
needs to be explicitly zeroed; then we can easily see whether we'd
already expanded or stringified the sucker.  Better done as an explicit
memset(), and it's better off in collect_arguments() than in expand()
itself - that way we don't need to bother with that for macros that
don't have arguments in the first place.  And yes, doing that as an
empty initializer in expand() where that VLA is declared does result in
a measurable slowdown...

	* anti-recursion rules do not apply to argument expansion;
something like
	#define A(x) x + 1
	A(A(1))
should result in x + 1 + 1, not A(1) + 1.  If expansion is done before
we mark 'A' and call substitute() that happens automatically; if we
delay it until substitute() runs into the first normal instance of an
argument, we need to remove the mark for duration of that expansion.
Not a problem, fortunately, since the set of marked symbols at the time
we get to TOKEN_MACRO_ARGUMENT will be the same as it used to be at the
time we enter substitute() - arguments can't contain any TOKEN_UNTAINT
(collect_arg() would eat all of those) and any taint added during
expand_list() will come with matching TOKEN_UNTAINT inserted into the
list.  All such TOKEN_UNTAINT will be consumed before expand_list()
returns, restoring the original conditions.  All we need to do is to
remove the taint from macro being substituted just before expanding an
argument and restore it right after that - it will do the right thing.
It makes sense to shift setting the taint from the caller of substitute()
where it's currently done into the very beginning of substitute() itself,
while we are at it.

	* instead of using counters to determine if this form of argument
is not needed after this place just mark the last place where given
form is needed when we are parsing the body - it's easy enough to do.
The only subtlety here is that unexpanded argument is needed to calculate
an expanded form, so in
	#define A(x) foo_##x = x
we can't cannibalize the unexpanded form of x until the second instance of
x in the body.  Rules for unexpanded form are
	1) it's needed for any unexpanded occurrence (obviously)
	2) it's needed for the first expanded occurrence
	3) it's needed for the first stringified occurrence
Fortunately, we don't need nothing non-trivial at #define time - no
separate passes, etc.  Note that in real world most of the macros seen
in given compile unit are never expanded in it, so we need to keep the
handling of #define light - trading the overhead at expansion time for
overhead at definition time is a bad idea.

	* since the counters are gone, we no longer need to pass arglist
all over the place; parsing side gets an array of struct arg_state,
which is where we keep the information about argument occurrences
through the parsing.  Expansion side doesn't need arglist anymore -
the last place that used to need it was collect_arguments(), and only
to copy the counters.  No more of that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 159 ++++++++++++++++++++++++--------------------------
 token.h       |   8 ++-
 2 files changed, 82 insertions(+), 85 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index b45688d5..bd049620 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -305,31 +305,23 @@ static struct token *collect_arg(struct token *prev, bool vararg, const struct p
 
 struct arg {
 	struct token *arg[3];
-	int count[3];
 };
 
 static int collect_arguments(struct token *start, struct symbol *sym, struct arg *args, struct token *what)
 {
 	int fixed = sym->fixed_args;
 	bool vararg = sym->vararg;
-	struct token *arglist = sym->arglist;
-	struct argcount *p;
 	struct token *next = NULL, *v = NULL;
 	const char *err;
 	int commas;
 
-	arglist = arglist->next;	/* skip counter */
+	memset(args, 0, sizeof(struct arg) * (fixed + 1));
 
 	for (commas = 0; commas < fixed; commas++) {
 		next = collect_arg(start, false, &what->pos);
 		if (token_type(next) != TOKEN_SPECIAL)
 			goto Eclosing;
-		p = &arglist->next->count;
-		arglist = arglist->next->next;
 		args[commas].arg[ARG_QUOTED] = start->next;
-		args[commas].count[ARG_NORMAL] = p->normal;
-		args[commas].count[ARG_QUOTED] = p->quoted;
-		args[commas].count[ARG_STR] = p->str;
 		if (!match_op(next, ',')) {
 			if (commas < fixed - 1)
 				goto Efew;
@@ -347,13 +339,8 @@ static int collect_arguments(struct token *start, struct symbol *sym, struct arg
 	}
 	if (v && !vararg)
 		goto Eexcess;
-	if (vararg) {
-		p = &arglist->next->count;
+	if (vararg)
 		args[fixed].arg[ARG_QUOTED] = v;
-		args[fixed].count[ARG_NORMAL] = p->normal;
-		args[fixed].count[ARG_QUOTED] = p->quoted;
-		args[fixed].count[ARG_STR] = p->str;
-	}
 	what->next = next->next;
 	return 1;
 
@@ -432,29 +419,6 @@ static struct token *stringify(struct token *arg)
 	return token;
 }
 
-static void expand_arguments(int count, struct arg *args)
-{
-	int i;
-	for (i = 0; i < count; i++) {
-		struct token *arg = args[i].arg[ARG_QUOTED];
-		if (!arg)
-			arg = &eof_token_entry;
-		if (args[i].count[ARG_STR])
-			args[i].arg[ARG_STR] = stringify(arg);
-		if (args[i].count[ARG_NORMAL]) {
-			if (!args[i].count[ARG_QUOTED]) {
-				args[i].arg[ARG_NORMAL] = arg;
-				args[i].arg[ARG_QUOTED] = NULL;
-			} else if (eof_token(arg)) {
-				args[i].arg[ARG_NORMAL] = arg;
-			} else {
-				args[i].arg[ARG_NORMAL] = dup_list(arg);
-			}
-			expand_list(&args[i].arg[ARG_NORMAL]);
-		}
-	}
-}
-
 /*
  * Possibly valid combinations:
  *  - ident + ident -> ident
@@ -651,11 +615,38 @@ static int handle_kludge(const struct token **p, struct arg *args)
 	}
 }
 
+static struct token *do_argument(const struct token *body,
+				 struct arg *args,
+				 struct ident *expanding)
+{
+	struct token *arg = args[argnum(body)].arg[argkind(body)];
+	if (arg)
+		return arg;
+	arg = args[argnum(body)].arg[ARG_QUOTED];
+	if (!arg)
+		arg = &eof_token_entry;
+	if (argkind(body) == ARG_NORMAL) {
+		if (!eof_token(arg)) {
+			if (!(body->argnum & (1 << ARGNUM_CONSUME_EXPAND)))
+				arg = dup_list(arg);
+			expanding->tainted = 0;
+			expand_list(&arg);
+			expanding->tainted = 1;
+		}
+		return args[argnum(body)].arg[ARG_NORMAL] = arg;
+	}
+	if (argkind(body) == ARG_STR)
+		return args[argnum(body)].arg[ARG_STR] = stringify(arg);
+	return arg;	// ARG_QUOTED
+}
+
 static struct token **substitute(struct token **list, const struct token *body, struct arg *args)
 {
 	struct position *base_pos = &(*list)->pos;
-	int *count;
 	enum {Normal, Placeholder, Concat} state = Normal;
+	struct ident *expanding = (*list)->ident;
+
+	expanding->tainted = 1;
 
 	for (; !eof_token(body); body = body->next) {
 		struct token *added, *arg;
@@ -687,8 +678,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			break;
 
 		case TOKEN_MACRO_ARGUMENT:
-			arg = args[argnum(body)].arg[argkind(body)];
-			count = &args[argnum(body)].count[argkind(body)];
+			arg = do_argument(body, args, expanding);
 			if (!arg || eof_token(arg)) {
 				if (state == Concat)
 					state = Normal;
@@ -696,7 +686,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 					state = Placeholder;
 				continue;
 			}
-			if (!--*count)
+			if (body->argnum & (1 << ARGNUM_CONSUME))
 				tail = move_into(&added, arg);
 			else
 				tail = copy(&added, arg);
@@ -755,14 +745,11 @@ static int expand(struct token **list, struct symbol *sym)
 			return 1;
 		if (!collect_arguments(token->next, sym, args, token))
 			return 1;
-		expand_arguments(nargs, args);
 	}
 
 	if (sym->expand)
 		return sym->expand(token, args) ? 0 : 1;
 
-	expanding->tainted = 1;
-
 	last = token->next;
 	tail = substitute(list, expansion, args);
 	/*
@@ -1093,8 +1080,6 @@ Eargs:
 static inline void set_arg_count(struct token *token)
 {
 	token_type(token) = TOKEN_ARG_COUNT;
-	token->count.normal = token->count.quoted =
-	token->count.str = 0;
 }
 
 static struct token *parse_arguments(struct token *list)
@@ -1190,10 +1175,16 @@ Eva_args:
 	return NULL;
 }
 
-static int try_arg(struct token *token, enum arg_kind kind, struct token *arglist)
+struct arg_state {
+	struct token *needs_raw;
+	struct token *needs_expanded;
+	struct token *needs_str;
+};
+
+static int try_arg(struct token *token, enum arg_kind kind, struct arg_state args[])
 {
 	struct ident *ident = token->ident;
-	int nr, n;
+	int nr;
 
 	if (!macro_funclike || token_type(token) != TOKEN_IDENT)
 		return 0;
@@ -1204,38 +1195,31 @@ static int try_arg(struct token *token, enum arg_kind kind, struct token *arglis
 	if (nr == macro_nargs)
 		return 0;
 
-	arglist = arglist->next;
-	for (int i = 0; i < nr; i++)
-		arglist = arglist->next->next;
-
 	token->argnum = (nr << ARGNUM_BITS_STOLEN) | kind;
 	token_type(token) = TOKEN_MACRO_ARGUMENT;
 	switch (kind) {
-	case ARG_NORMAL:
-		n = ++arglist->next->count.normal;
-		break;
 	case ARG_QUOTED:
-		n = ++arglist->next->count.quoted;
+		args[nr].needs_raw = token;
 		break;
-	default:
-		n = ++arglist->next->count.str;
+	case ARG_NORMAL:
+		if (!args[nr].needs_expanded)
+			args[nr].needs_raw = token;
+		args[nr].needs_expanded = token;
+		break;
+	default: // ARG_STR
+		if (!args[nr].needs_str)
+			args[nr].needs_raw = token;
+		args[nr].needs_str = token;
 	}
-	if (n)
-		return nr == macro_vararg ? 2 : 1;
-	/*
-	 * XXX - need saner handling of that
-	 * (>= 1024 instances of argument)
-	 */
-	token_type(token) = TOKEN_ERROR;
-	return -1;
+	return nr == macro_vararg ? 2 : 1;
 }
 
-static struct token *handle_hash(struct token **p, struct token *arglist)
+static struct token *handle_hash(struct token **p, struct arg_state args[])
 {
 	struct token *token = *p;
 	if (macro_funclike) {
 		struct token *next = token->next;
-		if (!try_arg(next, ARG_STR, arglist))
+		if (!try_arg(next, ARG_STR, args))
 			goto Equote;
 		next->pos.whitespace = token->pos.whitespace;
 		__free_token(token);
@@ -1251,13 +1235,13 @@ Equote:
 }
 
 /* token->next is ## */
-static struct token *handle_hashhash(struct token *token, struct token *arglist)
+static struct token *handle_hashhash(struct token *token, struct arg_state args[])
 {
 	struct token *last = token;
 	struct token *concat;
 	int state = match_op(token, ',');
 	
-	try_arg(token, ARG_QUOTED, arglist);
+	try_arg(token, ARG_QUOTED, args);
 
 	while (1) {
 		struct token *t;
@@ -1276,12 +1260,12 @@ static struct token *handle_hashhash(struct token *token, struct token *arglist)
 			goto Econcat;
 
 		if (match_op(t, '#')) {
-			t = handle_hash(&concat->next, arglist);
+			t = handle_hash(&concat->next, args);
 			if (!t)
 				return NULL;
 		}
 
-		is_arg = try_arg(t, ARG_QUOTED, arglist);
+		is_arg = try_arg(t, ARG_QUOTED, args);
 
 		if (state == 1 && is_arg) {
 			state = is_arg;
@@ -1304,8 +1288,9 @@ Econcat:
 	return NULL;
 }
 
-static struct token *parse_expansion(struct token *expansion, struct token *arglist, struct ident *name)
+static struct token *parse_expansion(struct token *expansion, struct ident *name)
 {
+	struct arg_state args[macro_nargs] = {};
 	struct token *token = expansion;
 	struct token **p;
 
@@ -1314,19 +1299,30 @@ static struct token *parse_expansion(struct token *expansion, struct token *argl
 
 	for (p = &expansion; !eof_token(token); p = &token->next, token = *p) {
 		if (match_op(token, '#')) {
-			token = handle_hash(p, arglist);
+			token = handle_hash(p, args);
 			if (!token)
 				return NULL;
 		}
 		if (match_op(token->next, SPECIAL_HASHHASH)) {
-			token = handle_hashhash(token, arglist);
+			token = handle_hashhash(token, args);
 			if (!token)
 				return NULL;
 		} else {
-			try_arg(token, ARG_NORMAL, arglist);
+			try_arg(token, ARG_NORMAL, args);
+		}
+	}
+	for (int i = 0; i < macro_nargs; i++) {
+		if (args[i].needs_str)
+			args[i].needs_str->argnum |= 1 << ARGNUM_CONSUME;
+		if (args[i].needs_expanded)
+			args[i].needs_expanded->argnum |= 1 << ARGNUM_CONSUME;
+		if (args[i].needs_raw) {
+			struct token *p = args[i].needs_raw;
+			if (argkind(p) == ARG_QUOTED)
+				p->argnum |= 1 << ARGNUM_CONSUME;
+			else if (argkind(p) == ARG_NORMAL)
+				p->argnum |= 1 << ARGNUM_CONSUME_EXPAND;
 		}
-		if (token_type(token) == TOKEN_ERROR)
-			goto Earg;
 	}
 	token = alloc_token(&expansion->pos);
 	token_type(token) = TOKEN_UNTAINT;
@@ -1338,9 +1334,6 @@ static struct token *parse_expansion(struct token *expansion, struct token *argl
 Econcat:
 	sparse_error(token->pos, "'##' cannot appear at the ends of macro expansion");
 	return NULL;
-Earg:
-	sparse_error(token->pos, "too many instances of argument in body");
-	return NULL;
 }
 
 static int do_define(struct position pos, struct token *token, struct ident *name,
@@ -1349,7 +1342,7 @@ static int do_define(struct position pos, struct token *token, struct ident *nam
 	struct symbol *sym;
 	int ret = 1;
 
-	expansion = parse_expansion(expansion, arglist, name);
+	expansion = parse_expansion(expansion, name);
 	if (!expansion)
 		goto out;
 
diff --git a/token.h b/token.h
index 273da39a..b28ac2ca 100644
--- a/token.h
+++ b/token.h
@@ -182,13 +182,17 @@ enum arg_kind {
 };
 
 enum {
-	ARGNUM_BITS_STOLEN = 2
+	ARGNUM_CONSUME = 2,
+	ARGNUM_CONSUME_EXPAND,
+	ARGNUM_BITS_STOLEN
 };
 
 enum {
-	ARGNUM_KIND_MASK = 3
+	ARGNUM_KIND_MASK = (1 << ARGNUM_CONSUME) - 1
 };
 
+// _Static_assert(ARGNUM_KIND_MASK >= ARG_STR)
+
 /*
  * This is a very common data structure, it should be kept
  * as small as humanly possible. Big (rare) types go as
-- 
2.47.3

