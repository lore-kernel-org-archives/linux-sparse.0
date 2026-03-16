Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657C34D382
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644477; cv=none; b=oTguzBgnkhUeu91t0vK8QqNgpBamJKeNlxznptepEkR6RqLFutqgvovliYoLaXRj1jitI1+dT28Q4lSVA7+C8eQNBJQLMShrp73kLlTPxAPTcR5kWxdI8y4d+fcGWUxbVp81ZbGSuWcUIa27b7QsoNBS0d9/sAipgqGSPk/IeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644477; c=relaxed/simple;
	bh=tF0Oo3ialfFHftwN/chkJPPKResMiu7BAOFZciLFFMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G32fKouJ6OCfToibGf4FtRemW25EmLHkA1GGJ/usjlsEwp+KKrDJu7E/r+9mimgbEs/RhKkWk/X/hi8geQsj+LUv2oDlkD/0BGCECvz5f7UfEy1QpNFzcgoYWoVAUh5MImTG3JJDRT2PG/o6qjap6cKFyozbwMX86padpHW96/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cEcS7VNh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cEcS7VNh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aRq2sxnD60Oc2ZNfvh8ztbgaNvGH0Qju0uQmqrghQ0s=; b=cEcS7VNhLLsoEpNtEqtIpbvo5O
	qH/5xp03fKSLMiit0GhLHBB+mCT23bWwl44C9n6CQ/qM2VSBa8UveBzkN/C63P0LL1kzmgkl7SvaN
	4IoPwdxw0s603aOXj0+S1SXeH5EQU5vQ/BpJouOpt7hrYDeqAvgkhgIS/jhWhKohWiDEmsxrsz/ax
	SpSGbfoo6dxFdf8/5n1SQ6aWPbotucV02kiljNpe62Z+KlM08kMmeWBQRKQ52+yAqAUfuwpLxCEK5
	0i/qh0jQp6RTDrMwFDMuJ94xagMLLxGaE1K222Hfxk6QWeLxwTEKMxQv68FK/WqHRI7jIbsJihnho
	2dB9bhDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E2t-1rSv;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 13/21] deal with ## on arguments separately
Date: Mon, 16 Mar 2026 07:04:07 +0000
Message-ID: <20260316070415.768839-13-viro@zeniv.linux.org.uk>
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

Adding/concatenating the chunks to growing expansion is done in the end
of loop body in substitute(); preceding switch leaves the data for it in
two variables - 'added' is the first token of the next chunk and 'tail'
points to the forward pointer in the last token of that chunk.

The only case when we might be adding more than one token is macro
argument; forcing it to use the same path as everything else complicates
things for no good reason, especially when it comes to concatenation.

Let the TOKEN_MACRO_ARGUMENT case deal with that stuff on its own.
In case of concatenation let it merge the first token before
copying/inserting the rest; that simplifies the common case and it
simplifies the data flow for everyone since we don't need to bother with
'tail' anymore.

As a side benefit, merge() is no longer inlined, which reduces the spills.

That chunk could go after __VA_OPT__ handling, but having it done first
simplifies the things for __VA_OPT__ (and especially for #__VA_OPT__()),
so let's put that one first.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index a60ad687..16cec8e1 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -650,7 +650,7 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 	for (; !eof_token(body); body = body->next) {
 		struct token *added, *arg;
-		struct token **tail;
+		struct token **inserted_at;
 		const struct token *t;
 
 		switch (token_type(body)) {
@@ -674,7 +674,6 @@ static struct token **substitute(struct token **list, const struct token *body,
 			}
 			added = dup_token(t, base_pos);
 			token_type(added) = TOKEN_SPECIAL;
-			tail = &added->next;
 			break;
 
 		case TOKEN_MACRO_ARGUMENT:
@@ -686,13 +685,28 @@ static struct token **substitute(struct token **list, const struct token *body,
 					state = Placeholder;
 				continue;
 			}
+			if (state == Concat && merge(containing_token(list), arg)) {
+				arg = arg->next;
+				if (eof_token(arg)) {
+					// merged the sole token in
+					state = Normal;
+					continue;
+				}
+				inserted_at = NULL;
+			} else {
+				inserted_at = list;
+			}
 			if (body->argnum & (1 << ARGNUM_CONSUME))
-				tail = move_into(&added, arg);
+				list = move_into(list, arg);
 			else
-				tail = copy(&added, arg);
-			added->pos.newline = body->pos.newline;
-			added->pos.whitespace = body->pos.whitespace;
-			break;
+				list = copy(list, arg);
+			if (inserted_at) {
+				struct token *p = *inserted_at;
+				p->pos.whitespace = body->pos.whitespace;
+				p->pos.newline = 0;
+			}
+			state = Normal;
+			continue;
 
 		case TOKEN_CONCAT:
 			if (state == Placeholder)
@@ -703,7 +717,6 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 		default:
 			added = dup_token(body, base_pos);
-			tail = &added->next;
 			break;
 		}
 
@@ -711,17 +724,12 @@ static struct token **substitute(struct token **list, const struct token *body,
 		 * if we got to doing real concatenation, we already have
 		 * added something into the list, so containing_token() is OK.
 		 */
-		if (state == Concat && merge(containing_token(list), added)) {
-			*list = added->next;
-			if (tail != &added->next)
-				list = tail;
-		} else {
+		if (state != Concat || !merge(containing_token(list), added)) {
 			*list = added;
-			list = tail;
+			list = &added->next;
 		}
 		state = Normal;
 	}
-	*list = &eof_token_entry;
 	return list;
 }
 
-- 
2.47.3

