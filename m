Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F3226D02
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644476; cv=none; b=fXYUql36GkWgoRE1jyC8o8pO4dl5tKExpEWCYFlpWlKZ6ZMeMQPB2FpW5R7fp8rLDB8lfvc5BaVjTTcaN9EbfDo00AnDN8oWii06gQ6vxS0L2zuQ2vg7Sz0gjIbXEekcPgfSp+g92ZmytKiNoVnTbyQdAgbtAMZhNlmhBNGn5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644476; c=relaxed/simple;
	bh=F9+aj+gaPicQph9cRgAc/U7LBr5vbjjMlY2wzAUGUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qy2RZZZFLDYogMp8nGQfp5zk7C7kry/Xd1rqByf/ohlqys2NXjLhkY7QgYiOZbAneACTRFf3xuYWqLZOQ3TYjfhTerVEsePleP0nnq4gVYRpluNzUg9uiViwTRGgrtmx5alMa/9jWNzw08fInr6AtmRHz5hucIa+XUW2NA9zNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pIsfwWoB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pIsfwWoB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tvPn/UObuw2u1VKsfm/cqGmmIcLNmzafSFmbnXBt1tE=; b=pIsfwWoBhlO3U6u8gdsKRGDPIE
	xoUzFyz+fg1jr3ZVGhDjxk8vm5Hp9/HRrb7lMvkYb1umISpkw19jZsrwoJLKRn/7/FvZOXYvKo4er
	uztu/HodhuwqDjk9803d7BBSThiCYMvJPLd3/EZwK2BdsMzJtBJzak9zIDJqVYYUL2bj7O0edtqYn
	HE/zvonYZIsZsNXoUti9sov3awFTYOw6Qr2lmZl4tcH4lLkh57tRSlx7GqKgtQYvIP2UdlX/9zRGL
	1Tcj9+1uOuFTLcKtxeFXUya9gZfqm5udgFYfaN9edpr2enNgo0pm9RONmJL0kn1DdRnhWJMUPXtyR
	4b5Ybniw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zv-00000003E42-1PJj;
	Mon, 16 Mar 2026 07:04:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 21/21] substitute(): convert switch() into cascade of ifs
Date: Mon, 16 Mar 2026 07:04:15 +0000
Message-ID: <20260316070415.768839-21-viro@zeniv.linux.org.uk>
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

Again, better code generation that way (and I'd like to use likely()
here); it *is* in a very hot loop.

Reorder the TOKEN_... a bit (move TOKEN_UNTAINT up, so that it's less than
TOKEN_MACRO_ARGUMENT) to get the default (and by far the most common case)
via single comparison.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 68 +++++++++++++++++++++++----------------------------
 token.h       |  3 ++-
 2 files changed, 33 insertions(+), 38 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 728feeb3..ea199a9a 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -682,34 +682,14 @@ static struct token **substitute(struct token **list, const struct token *body,
 	expanding->tainted = 1;
 
 	for (; !eof_token(body); body = body->next) {
-		struct token *added, *arg;
-		struct token **inserted_at;
-		const struct token *t;
+		struct token *added;
 
-		switch (token_type(body)) {
-		case TOKEN_GNU_KLUDGE:
-			/*
-			 * GNU kludge: if we had <comma>##<vararg>, behaviour
-			 * depends on whether we had enough arguments to have
-			 * a vararg.  If we did, ## is just ignored.  Otherwise
-			 * both , and ## are ignored.  Worse, there can be
-			 * an arbitrary number of ##<arg> in between; if all of
-			 * those are empty, we act as if they hadn't been there,
-			 * otherwise we act as if the kludge didn't exist.
-			 */
-			t = body;
-			if (handle_kludge(&body, args)) {
-				if (state == Concat)
-					state = Normal;
-				else
-					state = Placeholder;
-				continue;
-			}
-			added = dup_token(t, base_pos);
-			token_type(added) = TOKEN_SPECIAL;
-			break;
+		if (token_type(body) <= TOKEN_LAST_NORMAL) {
+			added = dup_token(body, base_pos);
+		} else if (token_type(body) == TOKEN_MACRO_ARGUMENT) {
+			struct token **inserted_at;
+			struct token *arg;
 
-		case TOKEN_MACRO_ARGUMENT:
 			arg = do_argument(body, args, expanding);
 			if (!arg || eof_token(arg)) {
 				if (state == Concat)
@@ -740,15 +720,33 @@ static struct token **substitute(struct token **list, const struct token *body,
 			}
 			state = Normal;
 			continue;
-
-		case TOKEN_CONCAT:
+		} else if (token_type(body) == TOKEN_CONCAT) {
 			if (state == Placeholder)
 				state = Normal;
 			else
 				state = Concat;
 			continue;
-
-		case TOKEN_VA_OPT:
+		} else if (token_type(body) == TOKEN_GNU_KLUDGE) {
+			const struct token *t = body;
+			/*
+			 * GNU kludge: if we had <comma>##<vararg>, behaviour
+			 * depends on whether we had enough arguments to have
+			 * a vararg.  If we did, ## is just ignored.  Otherwise
+			 * both , and ## are ignored.  Worse, there can be
+			 * an arbitrary number of ##<arg> in between; if all of
+			 * those are empty, we act as if they hadn't been there,
+			 * otherwise we act as if the kludge didn't exist.
+			 */
+			if (handle_kludge(&body, args)) {
+				if (state == Concat)
+					state = Normal;
+				else
+					state = Placeholder;
+				continue;
+			}
+			added = dup_token(t, base_pos);
+			token_type(added) = TOKEN_SPECIAL;
+		} else if (token_type(body) == TOKEN_VA_OPT) {
 			// entering va_opt?
 			if (!is_end_va_opt(body)) {
 				if (skip_va_opt(args, expanding)) {
@@ -774,9 +772,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 			}
 			list = saved_list;
 			state = saved_state;
-			break;
-
-		case TOKEN_VA_OPT_STR:
+		} else if (token_type(body) == TOKEN_VA_OPT_STR) {
 			// entering #va_opt
 			if (!skip_va_opt(args, expanding)) {
 				saved_state = state;
@@ -787,10 +783,8 @@ static struct token **substitute(struct token **list, const struct token *body,
 				continue;
 			}
 			added = empty_string(base_pos);
-			break;
-
-		default:
-			added = dup_token(body, base_pos);
+		} else {
+			sparse_error(body->pos, "bad token type(%d)", token_type(body));
 			break;
 		}
 
diff --git a/token.h b/token.h
index 3edf4ce1..5915d6a4 100644
--- a/token.h
+++ b/token.h
@@ -99,12 +99,13 @@ enum token_type {
 	TOKEN_SPECIAL,
 	TOKEN_STREAMBEGIN,
 	TOKEN_STREAMEND,
+	TOKEN_UNTAINT,
+	TOKEN_LAST_NORMAL = TOKEN_UNTAINT,
 	TOKEN_MACRO_ARGUMENT,
 	TOKEN_CONCAT,
 	TOKEN_GNU_KLUDGE,
 	TOKEN_VA_OPT,
 	TOKEN_VA_OPT_STR,
-	TOKEN_UNTAINT,
 	TOKEN_IF,
 	TOKEN_SKIP_GROUPS,
 	TOKEN_ELSE,
-- 
2.47.3

