Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181E238166
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=Ua34KGAc14M5dM8g3OfzI8CZhfn5uzy8GrfL1+6L9N6WY1uTVwRF7B1uIKWNcoQj1q4g4XwboOfF/22VkCrHWpjLg5sRPHhCHuC+jbQYYzzNSAJaVILPIlFmN1SXH6H4kOEUm8JODvtQg6kuASB/XRzCr61k6IYyNBDUcyMIrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=kzqdv6Ebax1opX4FqiBr6WF8PAtgk6Y4tTbR9Pi5xpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2ZfuIaSJwdPo4RW+5C5MMQVV0nrft32JQwUKohJEbCrIpVXAH7AWCcptDgQfPiBD5/N+lgO0GAu4GEbCY3eAlT0Nku2SYFCb1wlu3zhKHlzDR8tt7gpdt+p5YyGLSsaizNvKf4SSeTX0jrPVoTwkvb+mogRvX/BdGED4+zo12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mWsRpHnn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mWsRpHnn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P4KMem6GS0h/N58ntD5TcV9Vtyq4v0QbuQlxFQUWy50=; b=mWsRpHnnnRL3oXSV6cNX77D6Sa
	cqcHlw3fHCGaWRepysWsCqcTzIJf9zu0XSbstPRCfOzdHYdRD1ofMynoa99UIOdvqS9/asPKu8m+m
	XDLE3CuIDQNmuZWmCYevsS/vwewZLJj8ySo16oHa7yjnDq4ggdk0H/GEt4j5VKls79WBiw4ZHH0Wy
	MTorOjnBwdflSnb4yiXzzy+D2zmLtPN1JOIrPBhQQbChoPGVEaASDaMaUBVHx7ORTnAQKblVFyZXz
	nE4ekLTVLevwym6iGCG8eVYy0a3COOb4IU1BXbXnSvcEr/zboYn96qv7Zn+QUvTR65FregtuJ58+j
	0prtO7Cg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E35-2Tad;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 14/21] preparations for __VA_OPT__ support: reshuffle argument slot assignments
Date: Mon, 16 Mar 2026 07:04:08 +0000
Message-ID: <20260316070415.768839-14-viro@zeniv.linux.org.uk>
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

Move the vararg to slot 0, with the non-vararg arguments in slots
1..fixed_args; for macros with vararg arguments leave slot 0 unused.

Rationale: handling of __VA_OPT__ at expansion time will need to locate
the vararg; having it always in the same slot makes life easier.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 16cec8e1..fed3dc2a 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -321,7 +321,7 @@ static int collect_arguments(struct token *start, struct symbol *sym, struct arg
 		next = collect_arg(start, false, &what->pos);
 		if (token_type(next) != TOKEN_SPECIAL)
 			goto Eclosing;
-		args[commas].arg[ARG_QUOTED] = start->next;
+		args[commas + 1].arg[ARG_QUOTED] = start->next;
 		if (!match_op(next, ',')) {
 			if (commas < fixed - 1)
 				goto Efew;
@@ -340,7 +340,7 @@ static int collect_arguments(struct token *start, struct symbol *sym, struct arg
 	if (v && !vararg)
 		goto Eexcess;
 	if (vararg)
-		args[fixed].arg[ARG_QUOTED] = v;
+		args[0].arg[ARG_QUOTED] = v;
 	what->next = next->next;
 	return 1;
 
@@ -740,8 +740,7 @@ static int expand(struct token **list, struct symbol *sym)
 	struct ident *expanding = token->ident;
 	struct token **tail;
 	struct token *expansion = sym->expansion;
-	int nargs = sym->fixed_args + sym->vararg;
-	struct arg args[nargs];
+	struct arg args[sym->fixed_args + 1];
 
 	if (expanding->tainted) {
 		token->pos.noexpand = 1;
@@ -1181,6 +1180,7 @@ static int try_arg(struct token *token, enum arg_kind kind, struct arg_state arg
 	if (nr == macro_nargs)
 		return 0;
 
+	nr = nr == macro_vararg ? 0 : nr + 1;
 	token->argnum = (nr << ARGNUM_BITS_STOLEN) | kind;
 	token_type(token) = TOKEN_MACRO_ARGUMENT;
 	switch (kind) {
@@ -1197,7 +1197,7 @@ static int try_arg(struct token *token, enum arg_kind kind, struct arg_state arg
 			args[nr].needs_raw = token;
 		args[nr].needs_str = token;
 	}
-	return nr == macro_vararg ? 2 : 1;
+	return nr == 0 ? 2 : 1;
 }
 
 static struct token *handle_hash(struct token **p, struct arg_state args[])
@@ -1276,7 +1276,8 @@ Econcat:
 
 static struct token *parse_expansion(struct token *expansion, struct ident *name)
 {
-	struct arg_state args[macro_nargs] = {};
+	int slots = macro_nargs + (macro_vararg < 0);
+	struct arg_state args[slots] = {};
 	struct token *token = expansion;
 	struct token **p;
 
@@ -1297,7 +1298,7 @@ static struct token *parse_expansion(struct token *expansion, struct ident *name
 			try_arg(token, ARG_NORMAL, args);
 		}
 	}
-	for (int i = 0; i < macro_nargs; i++) {
+	for (int i = 0; i < slots; i++) {
 		if (args[i].needs_str)
 			args[i].needs_str->argnum |= 1 << ARGNUM_CONSUME;
 		if (args[i].needs_expanded)
@@ -1975,7 +1976,7 @@ static int handle_nondirective(struct stream *stream, struct token **line, struc
 
 static struct token *first_arg(struct arg *args)
 {
-	struct token *arg = args[0].arg[ARG_QUOTED];
+	struct token *arg = args[1].arg[ARG_QUOTED];
 	expand_list(&arg);
 	return arg;
 }
@@ -2265,21 +2266,22 @@ struct token * preprocess(struct token *token)
 
 static void dump_macro(struct symbol *sym)
 {
-	int nargs = sym->fixed_args + sym->vararg;
-	struct ident *args[nargs];
+	int fixed_args = sym->fixed_args;
+	struct ident *args[fixed_args + 1];
 	struct token *token;
 
 	printf("#define %s", show_ident(sym->ident));
 	token = sym->arglist;
 	if (token) {
-		int narg = 0;
-		for (; !eof_token(token); token = token->next) {
+		args[0] = &__VA_ARGS___ident;
+		for (int n = 1; !eof_token(token); token = token->next) {
 			printf("%s", show_token(token));
-			if (token_type(token) == TOKEN_IDENT)
-				args[narg++] = token->ident;
+			if (token_type(token) == TOKEN_IDENT) {
+				args[n] = token->ident;
+				if (n++ == fixed_args)
+					n = 0;
+			}
 		}
-		if (narg < nargs)
-			args[narg] = &__VA_ARGS___ident;
 	}
 
 	token = sym->expansion;
-- 
2.47.3

