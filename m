Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFC3D75D2
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944241; cv=none; b=C9Rq7yELn32HjVRSbhJ5H76DiidLXhyktxAGgh86SaABeECzoWeNPIHPc58VZFkl2QqKhE7e1NwwNUU54O8U11GSUqq3vaWDfobW9hW4gJQgjTPp5T5gZvpyzGbuPgaCFpE7i377fk4DXcyFL2HssksR5Ui22Ek49pdOPlbdyIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944241; c=relaxed/simple;
	bh=oL/4IXPC/J0q6WL+/8sSzI7CrvwGgfYMoK7ZXRR6FP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqm0gu0KV5clr4iomZM8eKthf8tgbpTuEtNmIVp0HTxORMyj8dpxKbhP0z+1iKcUGB5ig+o5maWpCifQfN3DYTy+rXNXSzvxZVNX1fbJE7VrYBCkCWmLXrFDX58nmu+uU/alRXEbyZJv6kQExz6T1bfATFmRBZthXjfigI0BGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Kr/g4/lO; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Kr/g4/lO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=S6kO/KK6Qm1Xy9Bb+aqDgaXi9hndlTB5FJi4rLo/oRs=; b=Kr/g4/lOQE7Qu4IaqgesVozNaW
	L3MkcqETm1m2R3ABYRtI1okRkhxLpN70c910OjJH+AxSlQmi0o0/oWQml46YSq4r4ZtG4B1HE0Rxz
	es2qhVwhVf5Jm4JmMHYHts3o8tNI5DV8QJmfpCCNLuQaPKIqCM0dtYRgDQ09nVAT11MsfuCvv+n5u
	mfsQ82MLPETccWclYlxEPA9CB887mxd6VHEQhSc5Z+tUe74H6eaPWGdxV3ejL12yxO8RgG0bp1JzD
	dOFA/XmIXaHYkJLbFOL43RLfg8HbgDwDC/KkQWAGAsbqxgIzsA2SxIlaxML0XHSz93uw6E18m4UJk
	YO4WZk4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8I-00000005meI-3BUU;
	Tue, 31 Mar 2026 08:07:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 5/6] saner collect_arg() code generation
Date: Tue, 31 Mar 2026 09:07:28 +0100
Message-ID: <20260331080729.1378613-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
References: <20260331080631.GA1328137@ZenIV>
 <20260331080729.1378613-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

1) gently coax gcc code generator away from screwing the bitfields
handling it is so keen to do - pass struct position from the caller
by value, with .newline already cleared (with inlined helper that
does trimming), do *not* let collect_arg() see that it's always
setting ->pos.newline to 0 (otherwise the FPOS tries to peel the damn
thing apart, turning mask-then-or into a bleeding horror).

2) get rid of 'vararg' checks for commas by changing the way we
keep track of nesting parentheses - instead of
	number of '(' - number of ')'
use
	2 * number of '(' - 2 * number of ')' + vararg
That still recognizes the closing parenthesis of argument list
(counter gets negative there, vararg or no vararg) and it does
recognize an argument-terminating comma without having to look
at 'vararg' - just check if counter is zero.
Reduces spills nicely.

3) do *not* use eof_token() as loop termination condition, compare
token_type() with TOKEN_EOF instead.  Yes, it's faster to compare
the pointer with constant instead, but it is *not* going to match
that unless we have an unterminated argument list and we are going
to check for TOKEN_STREAM{BEGIN,END} immediately afterwards anyway,
with the same "leave the loop now" on match, so these checks combine
nicely.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index e62d6379..a368b9ed 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -255,42 +255,41 @@ static void expand_list(struct token **list)
 
 static void preprocessor_line(struct stream *stream, struct token **line);
 
-static struct token *collect_arg(struct token *prev, bool vararg, const struct position *pos)
+static struct token *collect_arg(struct token *prev, bool vararg, struct position pos)
 {
 	struct stream *stream = input_streams + prev->pos.stream;
 	struct token **p = &prev->next;
 	struct token *next;
-	int nesting = 0;
+	int nesting = vararg;
 
-	while (!eof_token(next = scan_next(p))) {
+	while (1) {
+		next = scan_next(p);
+		if (token_type(next) == TOKEN_STREAMBEGIN ||
+		    token_type(next) == TOKEN_STREAMEND ||
+		    token_type(next) == TOKEN_EOF)
+			break;
 		if (token_type(next) == TOKEN_DIRECTIVE) {
 			preprocessor_line(stream, p);
 			__free_token(next);	/* Free the '#' token */
 			continue;
 		}
-		switch (token_type(next)) {
-		case TOKEN_STREAMEND:
-		case TOKEN_STREAMBEGIN:
-			*p = &eof_token_entry;
-			return next;
-		}
 		if (false_nesting) {
 			*p = next->next;
 			__free_token(next);
 			continue;
 		}
 		if (match_op(next, '(')) {
-			nesting++;
+			nesting += 2;
 		} else if (match_op(next, ')')) {
-			if (!nesting--)
+			if ((nesting -= 2) < 0)
 				break;
-		} else if (match_op(next, ',') && !nesting && !vararg) {
+		} else if (match_op(next, ',') && !nesting) {
 			break;
 		}
-		next->pos.stream = pos->stream;
-		next->pos.line = pos->line;
-		next->pos.pos = pos->pos;
-		next->pos.newline = 0;
+		next->pos.stream = pos.stream;
+		next->pos.line = pos.line;
+		next->pos.pos = pos.pos;
+		next->pos.newline = pos.newline;
 		p = &next->next;
 	}
 	*p = &eof_token_entry;
@@ -305,6 +304,15 @@ struct arg {
 	struct token *arg[3];
 };
 
+static inline struct position location(const struct position *p)
+{
+	return (struct position) {
+		.stream = p->stream,
+		.line = p->line,
+		.pos = p->pos
+	};
+}
+
 static int collect_arguments(struct token *what, int fixed, bool vararg, struct arg *args)
 {
 	struct token *start = scan_next(&what->next);
@@ -317,7 +325,7 @@ static int collect_arguments(struct token *what, int fixed, bool vararg, struct
 	if (!match_op(start, '('))
 		return 0;
 	for (commas = 0; commas < fixed; commas++) {
-		next = collect_arg(start, false, &what->pos);
+		next = collect_arg(start, false, location(&what->pos));
 		if (token_type(next) != TOKEN_SPECIAL)
 			goto Eclosing;
 		args[commas + 1].arg[ARG_QUOTED] = start->next;
@@ -329,7 +337,7 @@ static int collect_arguments(struct token *what, int fixed, bool vararg, struct
 		start = next;
 	}
 	if (commas == fixed) {
-		next = collect_arg(start, true, &what->pos);
+		next = collect_arg(start, true, location(&what->pos));
 		if (token_type(next) != TOKEN_SPECIAL)
 			goto Eclosing;
 		v = start->next;
-- 
2.47.3

