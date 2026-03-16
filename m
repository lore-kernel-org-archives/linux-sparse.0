Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C734D4E0
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644475; cv=none; b=MBFJFXlUu0BdztrTlTm4q0Ja8N/XaZ5s91hP9GNw13v9eml+TCpXHykZViuHQCS2u4cKvZUn9kILXRKrUetKUUUlhmA1y8UZY0FnjC3trhOys66i7opVjDL9WK2hApys0sP9bZoq7gZVwZ156d+xXYWnjU4ew329PUFOeVf4y7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644475; c=relaxed/simple;
	bh=E6GrbsnyAhKXlqD/Ib2OFrNB63v/C/61clJcjZUGYns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoucOVGAafigSrF4cFWr2aLqsBd8NvOjfFOq254nyPVPLiR3idrEzBmoptDAC2/5sM/+vQimyYKJJ4YpMGOcvkDG1ZqH0zLP97pmRBOW0kCVJ4P77DIBO4mTD9QmYrFF6nsNg0Dn1TTWny9hXwU/d/tpIPr47NjfOml07rl2j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YHCC/wx0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YHCC/wx0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wMA1TuazBwWXE1R8PvdkvPg5aaukd0s1ygGkvQBMLhA=; b=YHCC/wx0sZ+0HbKU5ikYdJRZH7
	jh2DxL8L+CdThA0iTbu/0XCHBJY/VuLTDlxJQb7cme6pof03tqJCNJ4OEsuoNDMQsS0fgJgJqfJPZ
	0KdUY6e8DAPZOKGaLUl/x4QNRJbqCq4mULdfSyrIRXVl2YQN7PQcaO791CKzBhb/FCIannpZE8xrv
	Abkm1v5aDUBKJ6ZMKx+BzPkvDh5ReHUCWVG4bi9GN2X8l0YOeNCYxp5GaQ/yrRMdk1+O7G5XUJjHo
	gsb+mebtcpEJcDL3yR4T7iWHgARkH7m2n0uFDm9WbWjrCrdWB11bC97n9XUzm3InoehKjd2dZte77
	gUUO+ebA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zv-00000003E3p-0wBr;
	Mon, 16 Mar 2026 07:04:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 19/21] simplify the calling conventions of collect_arguments()
Date: Mon, 16 Mar 2026 07:04:13 +0000
Message-ID: <20260316070415.768839-19-viro@zeniv.linux.org.uk>
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

Currently we call that only after having verified that macro name is
followed by the (, with those two tokens passed as separate arguments.
What's more, collect_arguments() already can tell the caller "don't
expand that" if the arguments are malformed, so there's no reason not to
move the check for opening parenthesis into collect_arguments() - that
makes the calling conventions simpler and it does not incur any cost -
collect_arguments() is going to be inlined into its sole caller anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 352f02df..73f4d615 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -307,16 +307,17 @@ struct arg {
 	struct token *arg[3];
 };
 
-static int collect_arguments(struct token *start, struct symbol *sym, struct arg *args, struct token *what)
+static int collect_arguments(struct token *what, int fixed, bool vararg, struct arg *args)
 {
-	int fixed = sym->fixed_args;
-	bool vararg = sym->vararg;
+	struct token *start = scan_next(&what->next);
 	struct token *next = NULL, *v = NULL;
 	const char *err;
 	int commas;
 
 	memset(args, 0, sizeof(struct arg) * (fixed + 1));
 
+	if (!match_op(start, '('))
+		return 0;
 	for (commas = 0; commas < fixed; commas++) {
 		next = collect_arg(start, false, &what->pos);
 		if (token_type(next) != TOKEN_SPECIAL)
@@ -355,7 +356,7 @@ Eexcess:
 Eclosing:
 	err = "unterminated argument list invoking";
 out:
-	sparse_error(what->pos, "%s macro \"%s\"", err, show_ident(sym->ident));
+	sparse_error(what->pos, "%s macro \"%s\"", err, show_ident(what->ident));
 	what->next = next;
 	return 0;
 }
@@ -808,23 +809,20 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 static int expand(struct token **list, struct symbol *sym)
 {
-	struct token *last;
+	struct token *next;
 	struct token *token = *list;
 	struct token **tail;
 	struct token *expansion = sym->expansion;
 	struct arg args[sym->fixed_args + 1];
 
-	if (sym->arglist) {
-		if (!match_op(scan_next(&token->next), '('))
-			return 1;
-		if (!collect_arguments(token->next, sym, args, token))
-			return 1;
-	}
+	if (sym->arglist &&
+	    !collect_arguments(token, sym->fixed_args, sym->vararg, args))
+		return 1;
 
 	if (sym->expand)
 		return sym->expand(token, args) ? 0 : 1;
 
-	last = token->next;
+	next = token->next;
 	tail = substitute(list, expansion, args);
 	/*
 	 * Note that it won't be eof - at least TOKEN_UNTAINT will be there.
@@ -834,7 +832,7 @@ static int expand(struct token **list, struct symbol *sym)
 	 */
 	(*list)->pos.newline = token->pos.newline;
 	(*list)->pos.whitespace = token->pos.whitespace;
-	*tail = last;
+	*tail = next;
 
 	return 0;
 }
-- 
2.47.3

