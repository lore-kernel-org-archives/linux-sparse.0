Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879934A3AC
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644474; cv=none; b=OdkFwy2WeER+LPt4V05+zQp/tWxcGFmYdMP/108O+22MVbYR0Ckp/eCRbZ6KlvkgsmKU03gMId/AmucrtAZZZvJMhp+eg2NR96Oro0U3xYLWEPi/JDB+edMsJk2cefoXH3HMW5NkM/1rYpNqNo1evofsxUoqb+gx7pq05bY9Bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644474; c=relaxed/simple;
	bh=njexgPSU7AiDO9A+BKGQUR7gBd9sK7p1c0ihEbKeZ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PoY61B5h/p1/kNfQapwonlwKkIq2lHBLWeHa3CcSioj8WTMlGwMUqyW/hX9NhI2G6L3qEifLSA2jCBZL/9B5jhCMY9nVZhW6klcbcNSwYKpsMN7kg67NRcOgBl66lfGyWTZXweM2dYjvcz80+CKK55gjZ9qVQ7sEQ9H35om3NV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X8tdk2KH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X8tdk2KH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YpGuTWQeGybU5LUoWbbE1r4FrVtQ+zmiS1nRs/u/+0g=; b=X8tdk2KHzAaDodV45jQHV0Tr3a
	IpYR35XKNBXiU1gHnHLcOXOCvqdBWrUO+yw7S3PAwsK/HEFdWWCPVFmZcLcgJciN1d7LeJ5tXjGLk
	So48pcmHvOLPXxeCAwYEZJzl5K5gxGp3XomZ4NQdIERxBkM6oHJdKk0WyQMxFsps9UqJzbG8ym/R+
	UDYRCvE3L76DyTP2vo5NosYRFpf62RMD47Wc70rEDCKkKjWrGnOBVxoLINKZL4pbhABkgL7kmyccL
	eHkDB7TVM/yzbA3iQpqqxibww45w1KW8lY9YoxQVBiE65Rhu5V4ziEYsuXg1LxS/Rbi07M7C386c4
	v9Hf/PUw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zt-00000003E22-2PxG;
	Mon, 16 Mar 2026 07:04:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 09/21] steal 2 bits from argnum for argument kind
Date: Mon, 16 Mar 2026 07:04:03 +0000
Message-ID: <20260316070415.768839-9-viro@zeniv.linux.org.uk>
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

We have 3 separate token types (TOKEN_{MACRO,QUOTED,STR}_ARGUMENT),
with fairly similar handling at expansion time.  Let's steal two bits
from ->argnum and use them to represent the kind of occurrence; that
simplifies substitute() and allows for better code generation there.

The object we use to store the argument state at expansion time (struct
arg) is already a structure with 3 pointers to token lists (unexpanded,
expanded and stringified forms of the argument) and 3 integer counters -
the number of remaining occurrencies of each kind.  Gather those into
3-element arrays indexed by the kind; counts will be gone soon, token
lists will remain.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 106 +++++++++++++++++++++-----------------------------
 token.h       |  14 +++++--
 2 files changed, 55 insertions(+), 65 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index efb208e7..b45688d5 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -304,12 +304,8 @@ static struct token *collect_arg(struct token *prev, bool vararg, const struct p
  */
 
 struct arg {
-	struct token *arg;
-	struct token *expanded;
-	struct token *str;
-	int n_normal;
-	int n_quoted;
-	int n_str;
+	struct token *arg[3];
+	int count[3];
 };
 
 static int collect_arguments(struct token *start, struct symbol *sym, struct arg *args, struct token *what)
@@ -330,10 +326,10 @@ static int collect_arguments(struct token *start, struct symbol *sym, struct arg
 			goto Eclosing;
 		p = &arglist->next->count;
 		arglist = arglist->next->next;
-		args[commas].arg = start->next;
-		args[commas].n_normal = p->normal;
-		args[commas].n_quoted = p->quoted;
-		args[commas].n_str = p->str;
+		args[commas].arg[ARG_QUOTED] = start->next;
+		args[commas].count[ARG_NORMAL] = p->normal;
+		args[commas].count[ARG_QUOTED] = p->quoted;
+		args[commas].count[ARG_STR] = p->str;
 		if (!match_op(next, ',')) {
 			if (commas < fixed - 1)
 				goto Efew;
@@ -353,10 +349,10 @@ static int collect_arguments(struct token *start, struct symbol *sym, struct arg
 		goto Eexcess;
 	if (vararg) {
 		p = &arglist->next->count;
-		args[fixed].arg = v;
-		args[fixed].n_normal = p->normal;
-		args[fixed].n_quoted = p->quoted;
-		args[fixed].n_str = p->str;
+		args[fixed].arg[ARG_QUOTED] = v;
+		args[fixed].count[ARG_NORMAL] = p->normal;
+		args[fixed].count[ARG_QUOTED] = p->quoted;
+		args[fixed].count[ARG_STR] = p->str;
 	}
 	what->next = next->next;
 	return 1;
@@ -440,21 +436,21 @@ static void expand_arguments(int count, struct arg *args)
 {
 	int i;
 	for (i = 0; i < count; i++) {
-		struct token *arg = args[i].arg;
+		struct token *arg = args[i].arg[ARG_QUOTED];
 		if (!arg)
 			arg = &eof_token_entry;
-		if (args[i].n_str)
-			args[i].str = stringify(arg);
-		if (args[i].n_normal) {
-			if (!args[i].n_quoted) {
-				args[i].expanded = arg;
-				args[i].arg = NULL;
+		if (args[i].count[ARG_STR])
+			args[i].arg[ARG_STR] = stringify(arg);
+		if (args[i].count[ARG_NORMAL]) {
+			if (!args[i].count[ARG_QUOTED]) {
+				args[i].arg[ARG_NORMAL] = arg;
+				args[i].arg[ARG_QUOTED] = NULL;
 			} else if (eof_token(arg)) {
-				args[i].expanded = arg;
+				args[i].arg[ARG_NORMAL] = arg;
 			} else {
-				args[i].expanded = dup_list(arg);
+				args[i].arg[ARG_NORMAL] = dup_list(arg);
 			}
-			expand_list(&args[i].expanded);
+			expand_list(&args[i].arg[ARG_NORMAL]);
 		}
 	}
 }
@@ -629,13 +625,18 @@ static inline int argnum(const struct token *arg)
 	return arg->argnum >> ARGNUM_BITS_STOLEN;
 }
 
+static inline enum arg_kind argkind(const struct token *arg)
+{
+	return arg->argnum & ARGNUM_KIND_MASK;
+}
+
 static int handle_kludge(const struct token **p, struct arg *args)
 {
 	const struct token *t = (*p)->next->next;
 	while (1) {
-		struct arg *v = &args[argnum(t)];
+		struct token *v = args[argnum(t)].arg[ARG_QUOTED];
 		if (token_type(t->next) != TOKEN_CONCAT) {
-			if (v->arg) {
+			if (v) {
 				/* ignore the first ## */
 				*p = (*p)->next;
 				return 0;
@@ -644,7 +645,7 @@ static int handle_kludge(const struct token **p, struct arg *args)
 			*p = t;
 			return 1;
 		}
-		if (v->arg && !eof_token(v->arg))
+		if (v && !eof_token(v))
 			return 0; /* no magic */
 		t = t->next->next;
 	}
@@ -685,14 +686,9 @@ static struct token **substitute(struct token **list, const struct token *body,
 			tail = &added->next;
 			break;
 
-		case TOKEN_STR_ARGUMENT:
-			arg = args[argnum(body)].str;
-			count = &args[argnum(body)].n_str;
-			goto copy_arg;
-
-		case TOKEN_QUOTED_ARGUMENT:
-			arg = args[argnum(body)].arg;
-			count = &args[argnum(body)].n_quoted;
+		case TOKEN_MACRO_ARGUMENT:
+			arg = args[argnum(body)].arg[argkind(body)];
+			count = &args[argnum(body)].count[argkind(body)];
 			if (!arg || eof_token(arg)) {
 				if (state == Concat)
 					state = Normal;
@@ -700,16 +696,6 @@ static struct token **substitute(struct token **list, const struct token *body,
 					state = Placeholder;
 				continue;
 			}
-			goto copy_arg;
-
-		case TOKEN_MACRO_ARGUMENT:
-			arg = args[argnum(body)].expanded;
-			count = &args[argnum(body)].n_normal;
-			if (eof_token(arg)) {
-				state = Normal;
-				continue;
-			}
-		copy_arg:
 			if (!--*count)
 				tail = move_into(&added, arg);
 			else
@@ -1040,8 +1026,6 @@ static int token_different(struct token *t1, struct token *t2)
 		different = t1->special != t2->special;
 		break;
 	case TOKEN_MACRO_ARGUMENT:
-	case TOKEN_QUOTED_ARGUMENT:
-	case TOKEN_STR_ARGUMENT:
 		different = t1->argnum != t2->argnum;
 		break;
 	case TOKEN_CHAR_EMBEDDED_0 ... TOKEN_CHAR_EMBEDDED_3:
@@ -1206,7 +1190,7 @@ Eva_args:
 	return NULL;
 }
 
-static int try_arg(struct token *token, enum token_type type, struct token *arglist)
+static int try_arg(struct token *token, enum arg_kind kind, struct token *arglist)
 {
 	struct ident *ident = token->ident;
 	int nr, n;
@@ -1224,13 +1208,13 @@ static int try_arg(struct token *token, enum token_type type, struct token *argl
 	for (int i = 0; i < nr; i++)
 		arglist = arglist->next->next;
 
-	token->argnum = nr << ARGNUM_BITS_STOLEN;
-	token_type(token) = type;
-	switch (type) {
-	case TOKEN_MACRO_ARGUMENT:
+	token->argnum = (nr << ARGNUM_BITS_STOLEN) | kind;
+	token_type(token) = TOKEN_MACRO_ARGUMENT;
+	switch (kind) {
+	case ARG_NORMAL:
 		n = ++arglist->next->count.normal;
 		break;
-	case TOKEN_QUOTED_ARGUMENT:
+	case ARG_QUOTED:
 		n = ++arglist->next->count.quoted;
 		break;
 	default:
@@ -1251,7 +1235,7 @@ static struct token *handle_hash(struct token **p, struct token *arglist)
 	struct token *token = *p;
 	if (macro_funclike) {
 		struct token *next = token->next;
-		if (!try_arg(next, TOKEN_STR_ARGUMENT, arglist))
+		if (!try_arg(next, ARG_STR, arglist))
 			goto Equote;
 		next->pos.whitespace = token->pos.whitespace;
 		__free_token(token);
@@ -1273,7 +1257,7 @@ static struct token *handle_hashhash(struct token *token, struct token *arglist)
 	struct token *concat;
 	int state = match_op(token, ',');
 	
-	try_arg(token, TOKEN_QUOTED_ARGUMENT, arglist);
+	try_arg(token, ARG_QUOTED, arglist);
 
 	while (1) {
 		struct token *t;
@@ -1297,7 +1281,7 @@ static struct token *handle_hashhash(struct token *token, struct token *arglist)
 				return NULL;
 		}
 
-		is_arg = try_arg(t, TOKEN_QUOTED_ARGUMENT, arglist);
+		is_arg = try_arg(t, ARG_QUOTED, arglist);
 
 		if (state == 1 && is_arg) {
 			state = is_arg;
@@ -1339,7 +1323,7 @@ static struct token *parse_expansion(struct token *expansion, struct token *argl
 			if (!token)
 				return NULL;
 		} else {
-			try_arg(token, TOKEN_MACRO_ARGUMENT, arglist);
+			try_arg(token, ARG_NORMAL, arglist);
 		}
 		if (token_type(token) == TOKEN_ERROR)
 			goto Earg;
@@ -2007,7 +1991,7 @@ static int handle_nondirective(struct stream *stream, struct token **line, struc
 
 static struct token *first_arg(struct arg *args)
 {
-	struct token *arg = args[0].arg;
+	struct token *arg = args[0].arg[ARG_QUOTED];
 	expand_list(&arg);
 	return arg;
 }
@@ -2356,11 +2340,9 @@ static void dump_macro(struct symbol *sym)
 		case TOKEN_CONCAT:
 			printf("##");
 			break;
-		case TOKEN_STR_ARGUMENT:
-			printf("#");
-			/* fall-through */
-		case TOKEN_QUOTED_ARGUMENT:
 		case TOKEN_MACRO_ARGUMENT:
+			if (argkind(token) == ARG_STR)
+				printf("#");
 			printf("%s", show_ident(args[argnum(token)]));
 			break;
 		default:
diff --git a/token.h b/token.h
index fe7c7fe9..273da39a 100644
--- a/token.h
+++ b/token.h
@@ -100,8 +100,6 @@ enum token_type {
 	TOKEN_STREAMBEGIN,
 	TOKEN_STREAMEND,
 	TOKEN_MACRO_ARGUMENT,
-	TOKEN_STR_ARGUMENT,
-	TOKEN_QUOTED_ARGUMENT,
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
 	TOKEN_UNTAINT,
@@ -177,8 +175,18 @@ struct argcount {
 	unsigned str:10;
 };
 
+enum arg_kind {
+	ARG_QUOTED = 0,
+	ARG_NORMAL = 1,
+	ARG_STR = 2,
+};
+
+enum {
+	ARGNUM_BITS_STOLEN = 2
+};
+
 enum {
-	ARGNUM_BITS_STOLEN
+	ARGNUM_KIND_MASK = 3
 };
 
 /*
-- 
2.47.3

