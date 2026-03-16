Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA7279324
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644473; cv=none; b=ubza+oGee1Dl5zFSQRuuEnBOnb8ExHoS+QlCDMgTKqmuKS3xZ5deE6CTLmdZOLndzr9JsQkIX+7u5SbA/jxj476vgI4Kl/V/OobqEzprWGoeFnvYB/y+n0K68pyLcrdIs3NFxDBx5ANZw7eVBPT9RXEa/UPIi0bLmT0UXFnQwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644473; c=relaxed/simple;
	bh=sjoMD8QRybU8s9QRkd4KXYYAb6B6fpbGsldTT7LSohs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB0VpaU4Lnn2YYe+OhLngZGBcrfOP64KoyUNjX46pIxOGNghgEkRuSt1vW7ARla0lzVV8Udq6FIVPWjW/f+lQJidTiCf4pVT5D2xXMwv0UqBH0kJnsKC2NB108N70ULegkg929jtomzy7JCLgXrK2nxMdCzUa5zBjJ4+eUS8Aes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iJd+Jp/s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iJd+Jp/s"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/JjtE17wU59JPyObiBH06SKiuM6jw2zUCiqUdH6zreM=; b=iJd+Jp/sL9f0LR8BnrkhyAWtmP
	jQM73+0p5Br6thxSAWnRjrOrRpwGK0/o9MvOa2ASE5vrbNSXAVhrTpHJ8cM1AJwb0RsZ4YUDayLZ6
	P78qM1lXjFgFsAkMKyN5hx4A/YOGntg7cWOf/BEf6WpJzdBZRF+yGurCDyX8YrPBml3d4No9Nc19K
	KmcsXPDdyX2YZI/zybDl2/aj2N8u548Vs6PtIbgtpQkKbgM37FS6RlFfeawugny7z/qogrIWUPR6P
	8y31M+GzG5if5aeHGwP6UQZDXN8gNSNcoKpu1pVWpYuY6iLw7OZt+K2XB03Zhz+sdGQrBXLTJmhKH
	RtdjucMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zs-00000003E10-1gyv;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 03/21] more dup_token() optimizations
Date: Mon, 16 Mar 2026 07:03:57 +0000
Message-ID: <20260316070415.768839-3-viro@zeniv.linux.org.uk>
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

pull handling to tainted identifiers into dup_token(), eliminating reread
and resulting stall in there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index e43061b2..320a5247 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -583,18 +583,21 @@ static int merge(struct token *left, struct token *right)
 	return 0;
 }
 
-static struct token *dup_token(const struct token *token, struct position *streampos)
+static inline struct token *dup_token(const struct token *token, struct position *streampos)
 {
 	struct position pos = *streampos;
 	struct token *alloc = __alloc_token(0);
+	struct position pos2 = token->pos;
 
-	alloc->pos = token->pos;
-	alloc->number = token->number;
-	alloc->pos.stream = pos.stream;
-	alloc->pos.line = pos.line;
-	alloc->pos.pos = pos.pos;
-	if (token_type(alloc) == TOKEN_STRING || token_type(alloc) == TOKEN_WIDE_STRING)
+	alloc->ident = token->ident;
+	pos2.stream = pos.stream;
+	pos2.line = pos.line;
+	pos2.pos = pos.pos;
+	if (pos2.type == TOKEN_STRING || pos2.type == TOKEN_WIDE_STRING)
 		token->string->immutable = 1;
+	if (pos2.type == TOKEN_IDENT && token->ident->tainted)
+		pos2.noexpand = 1;
+	alloc->pos = pos2;
 	return alloc;	
 }
 
@@ -728,9 +731,6 @@ static struct token **substitute(struct token **list, const struct token *body,
 
 		default:
 			added = dup_token(body, base_pos);
-			if (token_type(body) == TOKEN_IDENT &&
-			    added->ident->tainted)
-				added->pos.noexpand = 1;
 			tail = &added->next;
 			break;
 		}
-- 
2.47.3

