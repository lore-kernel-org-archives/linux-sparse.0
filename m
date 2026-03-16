Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE7226D02
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644474; cv=none; b=iUVEqoQJHQts4gQrWODjVatS3KErUsMwtVez+nrH2iGwHRVXsXDMnE9SSMzK4fiazRcGw0Vn5Bcj71uUeQl7IUIdH1nsdRz293AlmEv0fW/umewQLUh7Tni2Kr5Bbh1X5jNHyC0sfRKEjLyZR/Tm0RTG5Cnc4K2hk5/qoMpVLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644474; c=relaxed/simple;
	bh=QL73UEDC4bCUIv3kmSO5JYqeznxVcePrseqEoywakzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcNSj5KXvPEZcxKJsT/YkEmwDg5C5bxLB8p6TVaCZSY4xY91jTy5iUg0qqx+iB94dbucqiviFeq0bVZrYhKB7ZuzYWZcjJMLMmWSg5BMZGmGsN4+KdUkYzy0hxfKlSwyOqjSoLWepCWUoXbuSQ9XRY2fdaRQ2ws2GQPzOV/6dA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VnPY2pgR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VnPY2pgR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FaZKy6KeTcF4jpk3cY2OZf1eeEsVfCwNlwX9AgYe0Ug=; b=VnPY2pgRyLHOLBOGeOctV+ynSk
	MyBcP6wHC6OFV+hRgINPO4IZEplFG77Z3/XT1Z7Vr7P50DZA7snSovOGXoGcvdpZI2p8LsfSU4ssD
	1MJfMUeQzsAfBaZiX4q9IQ0KTcFYZc321quO22ccD4zBcwPgMwDHBSTOAWvlz4eRac9CHJT5oZZFE
	s6chKXYWLZ8rp2ah2F/8tq9mazcKEzGtJH00beebQHWzEhhd79+MtqEtXHFfgtm8WK6+jPhTW/r6S
	MP0c/lk2bVFbZiZ6Pigz+14WiYaQMrDWyGuJB2SG64ae4YFx/SsKsaTlv3B3wpsC1qHNZjVOkPF1G
	/2JrJB8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zr-00000003E0n-1Krm;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 01/21] split copy() into "need to copy" and "can move in place" cases
Date: Mon, 16 Mar 2026 07:03:55 +0000
Message-ID: <20260316070415.768839-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316065622.GA607739@ZenIV>
References: <20260316065622.GA607739@ZenIV>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

For one thing, rechecking the flag on each iteration of a loop is rather
silly, especially when there's very little in common between the "copy"
and "move" cases and the loop is pretty hot.

For another, it's better to have the counter-related logics lifted
into substitute().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 4e322855..ae493dc2 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -598,15 +598,23 @@ static struct token *dup_token(const struct token *token, struct position *strea
 	return alloc;	
 }
 
-static struct token **copy(struct token **where, struct token *list, int *count)
+static struct token **move_into(struct token **where, struct token *list)
+{
+	*where = list;
+	while (!eof_token(list)) {
+		if (token_type(list) == TOKEN_IDENT && list->ident->tainted)
+			list->pos.noexpand = 1;
+		where = &list->next;
+		list = *where;
+	}
+	return where;
+}
+
+static struct token **copy(struct token **where, struct token *list)
 {
-	int need_copy = --*count;
 	while (!eof_token(list)) {
 		struct token *token;
-		if (need_copy)
-			token = dup_token(list, &list->pos);
-		else
-			token = list;
+		token = dup_token(list, &list->pos);
 		if (token_type(token) == TOKEN_IDENT && token->ident->tainted)
 			token->pos.noexpand = 1;
 		*where = token;
@@ -698,7 +706,10 @@ static struct token **substitute(struct token **list, const struct token *body,
 				continue;
 			}
 		copy_arg:
-			tail = copy(&added, arg, count);
+			if (!--*count)
+				tail = move_into(&added, arg);
+			else
+				tail = copy(&added, arg);
 			added->pos.newline = body->pos.newline;
 			added->pos.whitespace = body->pos.whitespace;
 			break;
-- 
2.47.3

