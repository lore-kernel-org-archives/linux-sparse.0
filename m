Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879234CFAD
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644474; cv=none; b=HKTAo+3X0IqpE8bg2A2ewYn8AALyzVZ8hqX/356ChIfnJ2x9GRyYFDtmXkk5xdR2BVUI5Qqp9PcJwiYTo8A5lvc5Lc+4kvTaKQ70NHsIAzM3Jdmewc9TCdJbXNwJp1/zPeui4u1/OQlDXDWx+HbKSVpT4A5OZt3XVk9/FillKlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644474; c=relaxed/simple;
	bh=1v0yh0DWtUcdi8PhKwJ8bfC/SmTmN7ab+Qjaaojek+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FabGt4dMLF4UsI6rhB5AC3PyQJYWuYPnHU98JoU+AUt3tsaC+08pfruipSyAGE8gpfJYEnSFaAI6ZXg1bQVkatZ4yXxhpN1j4JUhASvMHsDiaP9fT8odHSiQUgOk2gPerH5eHK9OshpPa5eyPvAMVjW74/gNE2mzek2lfetqpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qDKLzT47; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qDKLzT47"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4lGJjbr4IaqjqApnTP4AcEkT2aHAxI4b7yVxXtuOsSM=; b=qDKLzT47gJRQPmJuKhbq+et44h
	dMrAeiScKgQe8cfgFKZ3txwEGd8pHiZrKZKozddZ9ldgXM9+MJcZqG82gm/20m/u3qk3rSkqZH4cX
	c7yr+nr3ltQZ9Cw7BofV1SQfD841xVHQoR68hRmftVAuQEE1im7NR1E7mP+1rCbKH5TJyTFdJgwnd
	jl66+RLxmuAG3ZGlZyAEOOu4G26AQAt3SD09d9I88vcB5UP5GYnb77oOUiZnlbgUkKA1llsCkVo8w
	GvWcOf9FZbvE1uQM9v4uPAIWKIPiJz29dE4QonezkjGJFvQ9bAwgV5c0aoTQynkZDd06GNUEX/DPm
	3zS6gUEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E2h-0kOl;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 12/21] stop mangling arglist, get rid of TOKEN_ARG_COUNT
Date: Mon, 16 Mar 2026 07:04:06 +0000
Message-ID: <20260316070415.768839-12-viro@zeniv.linux.org.uk>
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

Now it can be done - we no longer store the counters in arglist, so
there's no reason to mangle it.  Just have it return the pointer to
closing ) on success and let the caller split the list at that point.
Simplifies both the parse_arguments() and dump_macro() and fixes
a bug in the latter - pre-C99 gcc vararg macros used to lose ... in
-dM output.  They did work correctly, but dump_macro() output had
produced #define A(X,Y) instead of correct #define A(X,Y...)
Testcase added.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c                        | 47 +++++++---------------------
 token.h                              |  9 ------
 tokenize.c                           |  4 ---
 validation/preprocessor/dump-macro.c |  4 ++-
 4 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index aaf60293..a60ad687 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1000,7 +1000,6 @@ static int token_different(struct token *t1, struct token *t2)
 	case TOKEN_IDENT:
 		different = t1->ident != t2->ident;
 		break;
-	case TOKEN_ARG_COUNT:
 	case TOKEN_UNTAINT:
 	case TOKEN_CONCAT:
 	case TOKEN_GNU_KLUDGE:
@@ -1077,22 +1076,12 @@ Eargs:
 	return false;
 }
 
-static inline void set_arg_count(struct token *token)
-{
-	token_type(token) = TOKEN_ARG_COUNT;
-}
-
 static struct token *parse_arguments(struct token *list)
 {
 	struct token *arg = list->next, *next = list;
 
-	set_arg_count(list);
-
-	if (match_op(arg, ')')) {
-		next = arg->next;
-		list->next = &eof_token_entry;
-		return next;
-	}
+	if (match_op(arg, ')'))
+		return arg;
 
 	while (token_type(arg) == TOKEN_IDENT) {
 		if (arg->ident == &__VA_ARGS___ident)
@@ -1102,26 +1091,18 @@ static struct token *parse_arguments(struct token *list)
 
 		next = arg->next;
 		if (match_op(next, ',')) {
-			set_arg_count(next);
 			arg = next->next;
 			continue;
 		}
 
-		if (match_op(next, ')')) {
-			set_arg_count(next);
-			next = next->next;
-			arg->next->next = &eof_token_entry;
+		if (match_op(next, ')'))
 			return next;
-		}
 
 		/* normal cases are finished here */
 
 		if (match_op(next, SPECIAL_ELLIPSIS)) {
 			if (match_op(next->next, ')')) {
-				set_arg_count(next);
 				macro_vararg = macro_nargs - 1;
-				next = next->next;
-				arg->next->next = &eof_token_entry;
 				return next->next;
 			}
 
@@ -1143,10 +1124,7 @@ static struct token *parse_arguments(struct token *list)
 			goto Enotclosed;
 		if (!macro_add_arg(arg->pos, &__VA_ARGS___ident))
 			return NULL;
-		set_arg_count(next);
 		macro_vararg = macro_nargs - 1;
-		next = next->next;
-		arg->next->next = &eof_token_entry;
 		return next;
 	}
 
@@ -1483,14 +1461,19 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 	expansion = left->next;
 	if (!expansion->pos.whitespace) {
 		if (match_op(expansion, '(')) {
-			arglist = expansion;
-			expansion = parse_arguments(expansion);
-			if (!expansion) {
+			struct token *last = parse_arguments(expansion);
+			if (!last) {
 				macro_nargs = 0;
 				macro_vararg = -1;
 				return 1;
 			}
+			// last points to ) at the end of arguments,
+			// expansion starts right after that,
+			// everything up to that point is arglist.
 			macro_funclike = true;
+			arglist = expansion;
+			expansion = last->next;
+			last->next = &eof_token_entry;
 		} else if (!eof_token(expansion)) {
 			warning(expansion->pos,
 				"no whitespace before object-like macro body");
@@ -2281,20 +2264,14 @@ static void dump_macro(struct symbol *sym)
 	printf("#define %s", show_ident(sym->ident));
 	token = sym->arglist;
 	if (token) {
-		const char *sep = "";
 		int narg = 0;
-		putchar('(');
 		for (; !eof_token(token); token = token->next) {
-			if (token_type(token) == TOKEN_ARG_COUNT)
-				continue;
-			printf("%s%s", sep, show_token(token));
+			printf("%s", show_token(token));
 			if (token_type(token) == TOKEN_IDENT)
 				args[narg++] = token->ident;
-			sep = ",";
 		}
 		if (narg < nargs)
 			args[narg] = &__VA_ARGS___ident;
-		putchar(')');
 	}
 
 	token = sym->expansion;
diff --git a/token.h b/token.h
index b28ac2ca..e469e02d 100644
--- a/token.h
+++ b/token.h
@@ -103,7 +103,6 @@ enum token_type {
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
 	TOKEN_UNTAINT,
-	TOKEN_ARG_COUNT,
 	TOKEN_IF,
 	TOKEN_SKIP_GROUPS,
 	TOKEN_ELSE,
@@ -168,13 +167,6 @@ struct string {
 	char data[];
 };
 
-/* will fit into 32 bits */
-struct argcount {
-	unsigned normal:10;
-	unsigned quoted:10;
-	unsigned str:10;
-};
-
 enum arg_kind {
 	ARG_QUOTED = 0,
 	ARG_NORMAL = 1,
@@ -207,7 +199,6 @@ struct token {
 		unsigned int special;
 		struct string *string;
 		int argnum;
-		struct argcount count;
 		char embedded[4];
 	};
 };
diff --git a/tokenize.c b/tokenize.c
index 54ea348c..85bc3f49 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -241,10 +241,6 @@ const char *show_token(const struct token *token)
 		sprintf(buffer, "<untaint>");
 		return buffer;
 
-	case TOKEN_ARG_COUNT:
-		sprintf(buffer, "<argcnt>");
-		return buffer;
-
 	default:
 		sprintf(buffer, "unhandled token type '%d' ", token_type(token));
 		return buffer;
diff --git a/validation/preprocessor/dump-macro.c b/validation/preprocessor/dump-macro.c
index 46d70b34..710c1027 100644
--- a/validation/preprocessor/dump-macro.c
+++ b/validation/preprocessor/dump-macro.c
@@ -1,9 +1,11 @@
 #define A(X,Y,...) __VA_ARGS__,Y,X
+#define B(X,Y...) Y
 /*
  * check-name: -dM handling of varargs
- * check-command: sparse -E -dM $file | tail -1
+ * check-command: sparse -E -dM $file | tail -2
  *
  * check-output-start
 #define A(X,Y,...) __VA_ARGS__,Y,X
+#define B(X,Y...) Y
  * check-output-end
  */
-- 
2.47.3

