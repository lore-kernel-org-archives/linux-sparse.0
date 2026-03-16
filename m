Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967CA349B1F
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644473; cv=none; b=JXlYoRvGx8KTIM7XEkKPRZEf4uCy4dogNfD+tHcWCpWqfcDVREx51MJfsIHNtznEsD9yEPoj+xT/SS/SrUL4VcCiyf2iTry6IkfwxDH0TRdL1L4m3ZbKmv+QfBQlfzYv8wwGq8/NvM75XEEMlYxCY3YYMVbZXDXe2XhBi5Dd3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644473; c=relaxed/simple;
	bh=r8fjeIE4RUby9/Uom+R1MOWJjoxk8ZfBSuSNOY++l/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfU/uJsKP/QmzocIhD/5frpAt1hgLoXnkkJ/UqT2P8Xyz84Kru+ujObp2QfgVP7vc+X7lzs5p0Ls7XaQvtlsLX4gCA1xJlic7jcR66bGOXsx/kMlQh7vYEJZ6w8AdewfpxBqOjG7pR2qYqhF96mY7nO/urybrUMSPyYq94DdfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=sVfoXMHd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="sVfoXMHd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WpyRoYiTKGcZWKFbXVzzPYE3TPoS9l3c+YsmRPuLOag=; b=sVfoXMHdNAH7e0q0n8JHQgUF1o
	e/I1FKGG0ZMYqzk+ceNJaWPV818VYK1hzT+JKQ3ITdODWH7chaH2Q+Imj09szTlaUsHYishIdmLoQ
	TTccv57InWmBD8UUGToQIFdbBjZ2mXh1ohvPK+HHwlH+MoxnsF0/0hcOhNdirY1wWvgzWv0KR5Pw2
	OIQLTkMLNypuOxi6fqVo/9NVxwkB6J3SexTZrfeKM0typpe4I8sHmFWyEVjaBGLFWmk1ea5vlP+fa
	5QXB2/4wx9G5x1B0OaRJe0HG+7y9WJuGfNdCtwFTRbK/yZV2kUHfDoUwPKb9GIOfHTUJSvDDxQHqj
	sDXS7AeQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zt-00000003E1n-1kQT;
	Mon, 16 Mar 2026 07:04:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 08/21] preparing to change argument number encoding for TOKEN_..._ARGUMENT
Date: Mon, 16 Mar 2026 07:04:02 +0000
Message-ID: <20260316070415.768839-8-viro@zeniv.linux.org.uk>
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

We want to steal some bits from TOKEN_..._ARGUMENT; it's not a problem,
seeing that payload is a 32bit number and we are *not* going to support
many millions of arguments in macros.  For now, wrap the accesses into
an inline helper (argnum(token)), to reduce the amount of noise in
subsequent patches.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 23 ++++++++++++++---------
 token.h       |  4 ++++
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 85662365..efb208e7 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -624,11 +624,16 @@ static struct token **copy(struct token **where, struct token *list)
 	return where;
 }
 
+static inline int argnum(const struct token *arg)
+{
+	return arg->argnum >> ARGNUM_BITS_STOLEN;
+}
+
 static int handle_kludge(const struct token **p, struct arg *args)
 {
 	const struct token *t = (*p)->next->next;
 	while (1) {
-		struct arg *v = &args[t->argnum];
+		struct arg *v = &args[argnum(t)];
 		if (token_type(t->next) != TOKEN_CONCAT) {
 			if (v->arg) {
 				/* ignore the first ## */
@@ -681,13 +686,13 @@ static struct token **substitute(struct token **list, const struct token *body,
 			break;
 
 		case TOKEN_STR_ARGUMENT:
-			arg = args[body->argnum].str;
-			count = &args[body->argnum].n_str;
+			arg = args[argnum(body)].str;
+			count = &args[argnum(body)].n_str;
 			goto copy_arg;
 
 		case TOKEN_QUOTED_ARGUMENT:
-			arg = args[body->argnum].arg;
-			count = &args[body->argnum].n_quoted;
+			arg = args[argnum(body)].arg;
+			count = &args[argnum(body)].n_quoted;
 			if (!arg || eof_token(arg)) {
 				if (state == Concat)
 					state = Normal;
@@ -698,8 +703,8 @@ static struct token **substitute(struct token **list, const struct token *body,
 			goto copy_arg;
 
 		case TOKEN_MACRO_ARGUMENT:
-			arg = args[body->argnum].expanded;
-			count = &args[body->argnum].n_normal;
+			arg = args[argnum(body)].expanded;
+			count = &args[argnum(body)].n_normal;
 			if (eof_token(arg)) {
 				state = Normal;
 				continue;
@@ -1219,7 +1224,7 @@ static int try_arg(struct token *token, enum token_type type, struct token *argl
 	for (int i = 0; i < nr; i++)
 		arglist = arglist->next->next;
 
-	token->argnum = nr;
+	token->argnum = nr << ARGNUM_BITS_STOLEN;
 	token_type(token) = type;
 	switch (type) {
 	case TOKEN_MACRO_ARGUMENT:
@@ -2356,7 +2361,7 @@ static void dump_macro(struct symbol *sym)
 			/* fall-through */
 		case TOKEN_QUOTED_ARGUMENT:
 		case TOKEN_MACRO_ARGUMENT:
-			printf("%s", show_ident(args[token->argnum]));
+			printf("%s", show_ident(args[argnum(token)]));
 			break;
 		default:
 			printf("%s", show_token(token));
diff --git a/token.h b/token.h
index 5dcd8594..fe7c7fe9 100644
--- a/token.h
+++ b/token.h
@@ -177,6 +177,10 @@ struct argcount {
 	unsigned str:10;
 };
 
+enum {
+	ARGNUM_BITS_STOLEN
+};
+
 /*
  * This is a very common data structure, it should be kept
  * as small as humanly possible. Big (rare) types go as
-- 
2.47.3

