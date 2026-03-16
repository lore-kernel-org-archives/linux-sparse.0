Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40834346FC0
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644473; cv=none; b=Q/sRUqceiBGs/Mg45dgMY8wzx/hrNNK+5FcEhYhXZ8nix9Ow6MGLcPr2Ah+5Y2Om8xDJIex8Zj7AMLPDfXgwzsy61D0K1D6m4XPALvTJB/XQe/VyLZtfluTN6Zsr9nsu0qJkB+BdS9K2isGCA2ZB6iDXNUtJxNcanYKRgUrvjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644473; c=relaxed/simple;
	bh=QVZRoLqsDMeY+1R3kxteBBTpHesDAZiugSpzWxGDkSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esV1DJbQtyeQ0U2pM2e6UI3SQlWj/3aNDugZpBMC3dE18yIEih++U6NMhnWFA6/2LvPIaKOVTnuUycBw8sKRvRGbNdLYWmUqee8KQBspRUmd+m8U2uC8S0IyIUN6Az2VFy0M9x35b+iTJ+O2WdY73GXEnKkpiakyy+CyOASkH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jiuu5AWf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jiuu5AWf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dcExsREeoVQ1rGc9q2RjHkUAjkEvM41aFQKwcuxADkA=; b=Jiuu5AWfx895pU0EnhFEvMw8uE
	YKmrwbZhXgcAZ6+k0cfKTQPkzcdohkro6V9y0XHc1DelW8yJJZlNIp5sirUEakKdn9xTLiH9ZdO7e
	v6fBxOYWGUdkEit+6Ad2oiENUFnxjxwbLUuUucImprKHnaGGPb+LPSeLlD0XmRr3GHPCSsWwtHof4
	NBTnt/2+ynHC/pBhAwdHbbtFQjcY9J05PyByikXKS8Sgf4ekH4618L8WYun4rUctaB7zOHDv9+DCQ
	fkW6+OVmSf8FPegt2NNt8UJWZjeFdZPimrT84tiTbfVfH1hujtXxM7NKkzxjWsxX55OEFKvJe3pAY
	QOGbwiHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zs-00000003E1A-3ZwK;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 06/21] try_arg(): don't use arglist for argument name lookups
Date: Mon, 16 Mar 2026 07:04:00 +0000
Message-ID: <20260316070415.768839-6-viro@zeniv.linux.org.uk>
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

Just store them into a global array and search there.  That allows to
get rid of mangling ... in the arglist along with the is_VA_ARGS_token()
kludge.  For now we still need to access the arglist in try_arg(),
but that's going away as soon as we get rid of the use counters...

Added a check for duplicate argument names, while we are at it - we
didn't do that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c                        | 90 ++++++++++++++--------------
 validation/preprocessor/bad-args.c   | 18 ++++++
 validation/preprocessor/dump-macro.c |  9 +++
 3 files changed, 72 insertions(+), 45 deletions(-)
 create mode 100644 validation/preprocessor/bad-args.c
 create mode 100644 validation/preprocessor/dump-macro.c

diff --git a/pre-process.c b/pre-process.c
index 25990dfa..17ed7f85 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1078,16 +1078,24 @@ static int token_list_different(struct token *list1, struct token *list2)
 	}
 }
 
+static struct ident *macro_arg_name[1024];
 static int macro_nargs = 0;
 static int macro_vararg = -1;
 static bool macro_funclike = false;
 
 static bool macro_add_arg(struct position pos, struct ident *ident)
 {
+	for (int i = 0; i < macro_nargs; i++) {
+		if (ident == macro_arg_name[i])
+			goto Edup_arg;
+	}
 	if (macro_nargs == 1024)
 		goto Eargs;
-	macro_nargs++;
+	macro_arg_name[macro_nargs++] = ident;
 	return true;
+Edup_arg:
+	sparse_error(pos, "duplicate macro parameter \"%s\"", show_ident(ident));
+	return false;
 Eargs:
 	sparse_error(pos, "too many arguments in macro definition");
 	return false;
@@ -1157,8 +1165,6 @@ static struct token *parse_arguments(struct token *list)
 
 	if (match_op(arg, SPECIAL_ELLIPSIS)) {
 		next = arg->next;
-		token_type(arg) = TOKEN_IDENT;
-		arg->ident = &__VA_ARGS___ident;
 		if (!match_op(next, ')'))
 			goto Enotclosed;
 		if (!macro_add_arg(arg->pos, &__VA_ARGS___ident))
@@ -1198,41 +1204,41 @@ Eva_args:
 static int try_arg(struct token *token, enum token_type type, struct token *arglist)
 {
 	struct ident *ident = token->ident;
-	int nr;
+	int nr, n;
 
 	if (!macro_funclike || token_type(token) != TOKEN_IDENT)
 		return 0;
 
-	arglist = arglist->next;
+	for (nr = 0; nr < macro_nargs && macro_arg_name[nr] != ident; nr++)
+		;
 
-	for (nr = 0; !eof_token(arglist); nr++, arglist = arglist->next->next) {
-		if (arglist->ident == ident) {
-			struct argcount *count = &arglist->next->count;
-			int n;
+	if (nr == macro_nargs)
+		return 0;
 
-			token->argnum = nr;
-			token_type(token) = type;
-			switch (type) {
-			case TOKEN_MACRO_ARGUMENT:
-				n = ++count->normal;
-				break;
-			case TOKEN_QUOTED_ARGUMENT:
-				n = ++count->quoted;
-				break;
-			default:
-				n = ++count->str;
-			}
-			if (n)
-				return nr == macro_vararg ? 2 : 1;
-			/*
-			 * XXX - need saner handling of that
-			 * (>= 1024 instances of argument)
-			 */
-			token_type(token) = TOKEN_ERROR;
-			return -1;
-		}
+	arglist = arglist->next;
+	for (int i = 0; i < nr; i++)
+		arglist = arglist->next->next;
+
+	token->argnum = nr;
+	token_type(token) = type;
+	switch (type) {
+	case TOKEN_MACRO_ARGUMENT:
+		n = ++arglist->next->count.normal;
+		break;
+	case TOKEN_QUOTED_ARGUMENT:
+		n = ++arglist->next->count.quoted;
+		break;
+	default:
+		n = ++arglist->next->count.str;
 	}
-	return 0;
+	if (n)
+		return nr == macro_vararg ? 2 : 1;
+	/*
+	 * XXX - need saner handling of that
+	 * (>= 1024 instances of argument)
+	 */
+	token_type(token) = TOKEN_ERROR;
+	return -1;
 }
 
 static struct token *handle_hash(struct token **p, struct token *arglist)
@@ -2304,16 +2310,10 @@ struct token * preprocess(struct token *token)
 	return token;
 }
 
-static int is_VA_ARGS_token(struct token *token)
-{
-	return (token_type(token) == TOKEN_IDENT) &&
-		(token->ident == &__VA_ARGS___ident);
-}
-
 static void dump_macro(struct symbol *sym)
 {
 	int nargs = sym->fixed_args + sym->vararg;
-	struct token *args[nargs];
+	struct ident *args[nargs];
 	struct token *token;
 
 	printf("#define %s", show_ident(sym->ident));
@@ -2325,13 +2325,13 @@ static void dump_macro(struct symbol *sym)
 		for (; !eof_token(token); token = token->next) {
 			if (token_type(token) == TOKEN_ARG_COUNT)
 				continue;
-			if (is_VA_ARGS_token(token))
-				printf("%s...", sep);
-			else
-				printf("%s%s", sep, show_token(token));
-			args[narg++] = token;
+			printf("%s%s", sep, show_token(token));
+			if (token_type(token) == TOKEN_IDENT)
+				args[narg++] = token->ident;
 			sep = ",";
 		}
+		if (narg < nargs)
+			args[narg] = &__VA_ARGS___ident;
 		putchar(')');
 	}
 
@@ -2349,8 +2349,8 @@ static void dump_macro(struct symbol *sym)
 			/* fall-through */
 		case TOKEN_QUOTED_ARGUMENT:
 		case TOKEN_MACRO_ARGUMENT:
-			token = args[token->argnum];
-			/* fall-through */
+			printf("%s", show_ident(args[token->argnum]));
+			break;
 		default:
 			printf("%s", show_token(token));
 		}
diff --git a/validation/preprocessor/bad-args.c b/validation/preprocessor/bad-args.c
new file mode 100644
index 00000000..3dbb6f92
--- /dev/null
+++ b/validation/preprocessor/bad-args.c
@@ -0,0 +1,18 @@
+#define A(1)
+#define B(__VA_ARGS__)
+#define C(X,Y,X)
+/*
+ * check-name: macro arguments validation
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+
+ * check-output-end
+ *
+ * check-error-start
+preprocessor/bad-args.c:1:11: error: "1" may not appear in macro parameter list
+preprocessor/bad-args.c:2:11: error: __VA_ARGS__ can only appear in the expansion of a C99 variadic macro
+preprocessor/bad-args.c:3:15: error: duplicate macro parameter "X"
+ * check-error-end
+ */
diff --git a/validation/preprocessor/dump-macro.c b/validation/preprocessor/dump-macro.c
new file mode 100644
index 00000000..46d70b34
--- /dev/null
+++ b/validation/preprocessor/dump-macro.c
@@ -0,0 +1,9 @@
+#define A(X,Y,...) __VA_ARGS__,Y,X
+/*
+ * check-name: -dM handling of varargs
+ * check-command: sparse -E -dM $file | tail -1
+ *
+ * check-output-start
+#define A(X,Y,...) __VA_ARGS__,Y,X
+ * check-output-end
+ */
-- 
2.47.3

