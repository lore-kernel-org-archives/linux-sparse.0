Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E85349B1F
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644476; cv=none; b=R7IQGFxfxBISxF5TmHiFnxDuVWJhZkTeO9Mas36JGaC3P0Xtp0t890vJEVRlBzBGdbf8Rl+zwgOC8C3yGN4kJHDDieB49yGYbWaqYW5u+HE1mSsWQ67pYveQp7rXNqExkMcggGH4N0dD4wmfhwQL1a4DaT9iuweGsDTEOoypNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644476; c=relaxed/simple;
	bh=B4ddSIUt2pskZuTtpl/ZICmYMc/ESTMXgSWVcjNbkns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyJQOA/cZFTpGfrrnaKgFMHZ5LzCJP09jZ85vCao20gnWo6ggPi/IOXJ9vbH6CyYogXvYOrsjXg+zbIpPl4v2m/M2lCodJO87sgsisq50JrViu6bg5bRRVjHhRVUz4vJWq2pVRXF/lSq/o4fjkyMaPBqXk64f8CK8v/UbxZkUe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CwVOEXvc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CwVOEXvc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=P5P1YfvkRyFJeC/UkzauqOhIykBVz2SMj7SR21XZYHw=; b=CwVOEXvcOTspomigbhMJlmh7in
	A6QntF/440BPE7ujF2L27exuQ9/elg5tJyts47Cxja+jT5/5aFdUZonAHnNu8zwoTtrE0BJbniHPD
	V2BN6qoyzw9dXQ+KNWRUsUCZskFXaNFVFoSDFvlBcUeGkPCJiGPvdOzIDnW7jLRZTb1fFgQvWuNgR
	8LonKyG+hhp7YgUITFMKrFwyv79eLXB7CrxJnu446ByKSjcvmycYgFu6mrdgZJNK3+fcMI7kcgrtO
	z4L+X+x1DSRmjRGHoXS0v1oWDGj85kmMrW1f6pjBXF0SQEmlIO9rdsKj2Ht0xHTpGPyMsCNGfvMx4
	YUtdQ4Fw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zv-00000003E3i-0GR5;
	Mon, 16 Mar 2026 07:04:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 18/21] merge(): saner handling of ->noexpand
Date: Mon, 16 Mar 2026 07:04:12 +0000
Message-ID: <20260316070415.768839-18-viro@zeniv.linux.org.uk>
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

We only care about noexpand for identifiers and solitary #; the latter
can't occur in merge(), the former should just get ->noexpand set
according to ->ident->tainted.  That eliminates the last remaining
possibility of having expand() run into a token that has tainted
identifier - the regular noexpand check in the caller is sufficient now.
Should've done that all way back in 2004...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index eec0569c..352f02df 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -507,7 +507,7 @@ static int merge(struct token *left, struct token *right)
 	switch (res) {
 	case TOKEN_IDENT:
 		left->ident = built_in_ident(buffer);
-		left->pos.noexpand = 0;
+		left->pos.noexpand = left->ident->tainted;
 		return 1;
 
 	case TOKEN_NUMBER:
@@ -529,13 +529,11 @@ static int merge(struct token *left, struct token *right)
 	case TOKEN_WIDE_CHAR:
 	case TOKEN_WIDE_STRING:
 		token_type(left) = res;
-		left->pos.noexpand = 0;
 		left->string = right->string;
 		return 1;
 
 	case TOKEN_WIDE_CHAR_EMBEDDED_0 ... TOKEN_WIDE_CHAR_EMBEDDED_3:
 		token_type(left) = res;
-		left->pos.noexpand = 0;
 		memcpy(left->embedded, right->embedded, 4);
 		return 1;
 
@@ -812,16 +810,10 @@ static int expand(struct token **list, struct symbol *sym)
 {
 	struct token *last;
 	struct token *token = *list;
-	struct ident *expanding = token->ident;
 	struct token **tail;
 	struct token *expansion = sym->expansion;
 	struct arg args[sym->fixed_args + 1];
 
-	if (expanding->tainted) {
-		token->pos.noexpand = 1;
-		return 1;
-	}
-
 	if (sym->arglist) {
 		if (!match_op(scan_next(&token->next), '('))
 			return 1;
-- 
2.47.3

