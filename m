Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84C279324
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=KI2NKOwKOhxGUZSKPVlFzYwjEgjtFJEJotEjRIt84rvQ+l3ZsfURfdYJQBzrWtf9uocrRJTCjYrpf004lOYWJljiDuFsxPYpsjcj91N1ZdR9eJMr5ZiVDllXj0MK1Na14ZNuIf9MtyaZGV+WjCPTaLnOqrzZ/t8dODZM669DqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=aw9w9X33y61aK4oOrsvPtgHUrF+9+AG+8Shw+2ujbzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/eu//qhsbDrlsIpFfnjPxQ76eQa50po0wWiUffX1mwNlCjtqGY3O1ddGGBVszMs7oJyQgvXbef+RMEN070CIVdYShHf4koKvg6fSxGwcOBDYEn/S9cmX94++qM+5EE6ba0C8zMI2m7nuN5fq0h91rFkjWZUtKfcPA8y0ggGQGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ouVpHpgy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ouVpHpgy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2HrCHAMifHSgS4QBxXXEulvSp202+1RQW1ZXiJjqp4Y=; b=ouVpHpgykDXz++3DUQxkmP3pG+
	iWz+HVtjPvmk+ynNV4PNfRaJ5L2//casSt5AFzZd7xaEnVYIrCt62hyIt34wyeN4kuefQ6L+Yn13E
	WTqibDbd16brHEwwNoQrvlxZOS8tp2KC+WuiC9vBBEsKKfAHkHQii5lr1lhn7pe7sIcxO4M6g7BRA
	XNHxFXWyyoG1rAX1UwNpNXuuHAk75ZuRKNUrlVvnG6IlnP8VmriwAVQAmgNDlaNn/1BNyAbPpHBWY
	B1+P3cDTfZvgixu1By2MHptxD2LGtoYWwS1f3/3M0w9D50nSd4SaBT96XNUCYtt8yLjQXa5Xko76A
	CoOoJOnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E3H-30gL;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 15/21] pre-process.c: split try_arg()
Date: Mon, 16 Mar 2026 07:04:09 +0000
Message-ID: <20260316070415.768839-15-viro@zeniv.linux.org.uk>
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

more __VA_OPT__ preparations - we want to split the "parse the possible
variable" from the parts that are sensitive to the kind of variable
access (in particular, to subsequent ## being or not being there).
With __VA_OPT__ we'll have a possibility of relevant ## being a lot
further ahead than the next token and we won't find it until we'd parsed
the entire __VA_OPT__(.....).

We could check for __VA_OPT__ _before_ checking for arguments, but that
ends up screwing code generation a lot, slowing down the normal case
where we've not a single __VA_OPT__ in the input.

Replace try_arg() with two new primitives:
	* check_arg() - returns 0 if the next token is not an argument;
if the token is an argument, it gets converted to TOKEN_MACRO_ARGUMENT and
slot number + 1 is returned.  That function gets only token and arg_state
array - 'kind' is not known yet.  At the moment 'args' is not needed,
but it will be needed for __VA_OPT__ handling, so that argument stays.
Note that unlike try_arg() we don't need a special return value to tell
vararg from non-vararg argument - the slot number is sufficient now.
It's a vararg if and only if it occupies slot 0, i.e. if check_arg()
has returned 1.
	* seen_arg() - gets called only for TOKEN_MACRO_ARGUMENT token,
does the rest of what try_arg() used to do.  Returns void.

Calls of try_arg() are replaced with combinations of these two, the
first try_arg() in handle_hashhash() lifted into the only caller of
handle_hashhash() and its check_arg() folded with the one we do for non-##
case there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index fed3dc2a..51ad916c 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1166,7 +1166,7 @@ struct arg_state {
 	struct token *needs_str;
 };
 
-static int try_arg(struct token *token, enum arg_kind kind, struct arg_state args[])
+static int check_arg(struct token *token, struct arg_state args[])
 {
 	struct ident *ident = token->ident;
 	int nr;
@@ -1181,8 +1181,14 @@ static int try_arg(struct token *token, enum arg_kind kind, struct arg_state arg
 		return 0;
 
 	nr = nr == macro_vararg ? 0 : nr + 1;
-	token->argnum = (nr << ARGNUM_BITS_STOLEN) | kind;
+	token->argnum = nr << ARGNUM_BITS_STOLEN;
 	token_type(token) = TOKEN_MACRO_ARGUMENT;
+	return nr + 1;
+}
+
+static void seen_arg(struct token *token, enum arg_kind kind, struct arg_state args[], int nr)
+{
+	token->argnum |= kind;
 	switch (kind) {
 	case ARG_QUOTED:
 		args[nr].needs_raw = token;
@@ -1197,7 +1203,6 @@ static int try_arg(struct token *token, enum arg_kind kind, struct arg_state arg
 			args[nr].needs_raw = token;
 		args[nr].needs_str = token;
 	}
-	return nr == 0 ? 2 : 1;
 }
 
 static struct token *handle_hash(struct token **p, struct arg_state args[])
@@ -1205,8 +1210,12 @@ static struct token *handle_hash(struct token **p, struct arg_state args[])
 	struct token *token = *p;
 	if (macro_funclike) {
 		struct token *next = token->next;
-		if (!try_arg(next, ARG_STR, args))
+		int nr = check_arg(next, args);
+
+		if (!nr)
 			goto Equote;
+
+		seen_arg(next, ARG_STR, args, nr - 1);
 		next->pos.whitespace = token->pos.whitespace;
 		__free_token(token);
 		token = *p = next;
@@ -1226,12 +1235,10 @@ static struct token *handle_hashhash(struct token *token, struct arg_state args[
 	struct token *last = token;
 	struct token *concat;
 	int state = match_op(token, ',');
-	
-	try_arg(token, ARG_QUOTED, args);
+	int nr;
 
 	while (1) {
 		struct token *t;
-		int is_arg;
 
 		/* eat duplicate ## */
 		concat = token->next;
@@ -1251,10 +1258,13 @@ static struct token *handle_hashhash(struct token *token, struct arg_state args[
 				return NULL;
 		}
 
-		is_arg = try_arg(t, ARG_QUOTED, args);
+		nr = check_arg(t, args);
+		if (nr > 0)
+			seen_arg(t, ARG_QUOTED, args, nr - 1);
 
-		if (state == 1 && is_arg) {
-			state = is_arg;
+		if (state == 1 && nr > 0) {
+			if (nr == 1)
+				state = 2;
 		} else {
 			last = t;
 			state = match_op(t, ',');
@@ -1280,6 +1290,7 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 	struct arg_state args[slots] = {};
 	struct token *token = expansion;
 	struct token **p;
+	int nr;
 
 	if (match_op(token, SPECIAL_HASHHASH))
 		goto Econcat;
@@ -1290,12 +1301,16 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 			if (!token)
 				return NULL;
 		}
+		nr = check_arg(token, args);
 		if (match_op(token->next, SPECIAL_HASHHASH)) {
+			if (nr > 0)
+				seen_arg(token, ARG_QUOTED, args, nr - 1);
 			token = handle_hashhash(token, args);
 			if (!token)
 				return NULL;
 		} else {
-			try_arg(token, ARG_NORMAL, args);
+			if (nr > 0)
+				seen_arg(token, ARG_NORMAL, args, nr - 1);
 		}
 	}
 	for (int i = 0; i < slots; i++) {
-- 
2.47.3

