Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130D3D75C5
	for <linux-sparse@vger.kernel.org>; Tue, 31 Mar 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944241; cv=none; b=NhHgf9/dQnoC5kjVyhGuJ2mq2dI+4l6IJpHjxmbp6bUYLFC3zp9K1GbTsq7Q1IFJwXsoB9PYM+1mceQD9qbMUJ6SpW0MY3znIgja4I6yrwD2YI56vkBT+VkfKv9A777bJe8QBKSEj5iAsrYZDPQYCeWevc8CoOJsqB/GsfXGSCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944241; c=relaxed/simple;
	bh=qezxJ3Ue8oJ8ZFoeklEJ68zwpJyXN8deLX3Lv3EnWgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnzgvsk/o0flGu38sszXE2M/RYmKPaAhCCWJBWQ/9QbBSbKEZ0RzWVWL4jTjgDA2ebT1dEOWg1AiIJ2LAW3k+EKe7I8o243SFFdo55y0SvLJv/polNBZ4yPYiFCg7tISLdAUB+skxpdZ8JuoYartkKqjh0r4jwbNtc0s6y+BC+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lDjZpp0U; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lDjZpp0U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=agRwhgta2hQ73g9zH4ZjZgJSBhNFLTFFU579Pj+rvjQ=; b=lDjZpp0Uc+5w6pgmj/HO0Ii/cW
	z2mcltrSo2Ci7en/ZIY2O+uuTmr0vXouDPVHXpWqXY5CUJu0LJj7sGTQXo5p2pn5/WWGwWSs1nezp
	0Hd/td0D40DUbGOyyDEks0yOF3s7iVUXRz5j4AdqqSfj3/ematoXUIAElnCqDm/SROEeIGIe19q9s
	rDHJXFIhlvG0r+3b6Lqjkh0W6nb4szNDcA5NWfMXO/DuihNR9BYtukTr2IDjT3Ny0r7dqPr1IQFh+
	BaGsttpA9CWem1tKeDOE7Z38iyKcl3I/ELNrO2BSxuSy5cD0YIpLfdTYc6gi1IfXU9+QLi9JTdWQl
	Yc4nB0Ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w7U8I-00000005meB-2fdB;
	Tue, 31 Mar 2026 08:07:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 4/6] TOKEN_DIRECTIVE: recognize directive-introducing # in tokenizer
Date: Tue, 31 Mar 2026 09:07:27 +0100
Message-ID: <20260331080729.1378613-4-viro@zeniv.linux.org.uk>
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

'#' acts as start of directive it had been the first token in its line
at the beginning of phase 4.  In other words, it must have come from
the input stream rather than from macro expansion (# may be present in
the body of object-like macro) and there must've been no token between
it and beginning of the line *before* any macro expansion had been
done (i.e. in
	#define EMPTY
	EMPTY #include <stdlib.h>
the # in front of include is *not* a beginning of directive).

Currently we handle that by hijacking 'noexpand' flag to mark the instances
of # coming from macro expansion and checking if the token we'd run into
might be a directive-starting # in do_preprocess() and in collect_arg().

It's actually simpler and faster to recognize those in tokenizer.  Just
have get_one_special() check if it's about to return a TOKEN_SPECIAL[#]
and if it's the first token in its line, return a token of new type
(TOKEN_DIRECTIVE).  Checks in the preprocessor get simpler and we get
rid of 'noexpand' abuse - there's no way for TOKEN_DIRECTIVE to end up
in the body of any macro.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 22 ++++++++--------------
 token.h       |  1 +
 tokenize.c    |  2 ++
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index ea199a9a..e62d6379 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -263,12 +263,10 @@ static struct token *collect_arg(struct token *prev, bool vararg, const struct p
 	int nesting = 0;
 
 	while (!eof_token(next = scan_next(p))) {
-		if (next->pos.newline && match_op(next, '#')) {
-			if (!next->pos.noexpand) {
-				preprocessor_line(stream, p);
-				__free_token(next);	/* Free the '#' token */
-				continue;
-			}
+		if (token_type(next) == TOKEN_DIRECTIVE) {
+			preprocessor_line(stream, p);
+			__free_token(next);	/* Free the '#' token */
+			continue;
 		}
 		switch (token_type(next)) {
 		case TOKEN_STREAMEND:
@@ -1402,8 +1400,6 @@ static struct token *handle_hash(struct token **p, struct arg_state args[])
 			goto Equote;
 		__free_token(token);
 		token = *p = next;
-	} else {
-		token->pos.noexpand = 1;
 	}
 	return token;
 
@@ -2427,12 +2423,10 @@ static void do_preprocess(struct token **list)
 	while (!eof_token(next = scan_next(list))) {
 		struct stream *stream = input_streams + next->pos.stream;
 
-		if (next->pos.newline && match_op(next, '#')) {
-			if (!next->pos.noexpand) {
-				preprocessor_line(stream, list);
-				__free_token(next);	/* Free the '#' token */
-				continue;
-			}
+		if (token_type(next) == TOKEN_DIRECTIVE) {
+			preprocessor_line(stream, list);
+			__free_token(next);	/* Free the '#' token */
+			continue;
 		}
 
 		switch (token_type(next)) {
diff --git a/token.h b/token.h
index 5915d6a4..7265bae5 100644
--- a/token.h
+++ b/token.h
@@ -109,6 +109,7 @@ enum token_type {
 	TOKEN_IF,
 	TOKEN_SKIP_GROUPS,
 	TOKEN_ELSE,
+	TOKEN_DIRECTIVE,
 };
 
 /* Combination tokens */
diff --git a/tokenize.c b/tokenize.c
index e6e071ae..9f7912c4 100644
--- a/tokenize.c
+++ b/tokenize.c
@@ -790,6 +790,8 @@ static int get_one_special(int c, stream_t *stream)
 	/* Pass it on.. */
 	token = stream->token;
 	token_type(token) = TOKEN_SPECIAL;
+	if (value == '#' && token->pos.newline)
+		token_type(token) = TOKEN_DIRECTIVE;
 	token->special = value;
 	add_token(stream);
 	return next;
-- 
2.47.3

