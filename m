Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E54238166
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644473; cv=none; b=G0aUAYVZ3BpzBVT074dlDH9PcqjpYUMppIK3DbhrRhws3xIPgJ43I5kID3T09jDKJcotiNh14YbZ/zNdHBSVjU2a2bdWlQ3EXVy1Y8fq8xM/bkq680vhIPcNHSmSb7lKj1WJXizA6cRI+iChPE076gJE+YzzKoBd2brkVDzHdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644473; c=relaxed/simple;
	bh=7o1YgEsRc5o7VcxXdAsqdaLyjrr5TCV4RgGhVedhKxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGD+t7/UqWfewS/fFtVLXkU6hGpMJ51A9qAr9vXxYdqv1iuTuxTr+HbH03MbjCJblJ/TW5bKxxDCgp7b8/jZaJUJUiNZmt0kpLDp7QxN1duQxbtvRHpbogc3bT+M3acD3O/1w35ubiUsTPFTM8o1E9rsAjJrfILOnFK6yHSeaVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nmH0l3cl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nmH0l3cl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QK+r2YsgaMOmHEtZ/PhaoOsTsU5Re0y5D4wmD199WVw=; b=nmH0l3clIOKnkKdWoCSgCCCZ1s
	4uzf8oM8N7LZwCeNv6SZcmS9XeH/LQ+lqeIO5LYqDRnHFOzLKE31Y1pYJ1CslNaYT3yU0RrEyhEOs
	X6wE8PwcAenAYiOIfY46HdHXvuOQoDcxZLo3pfGRT00FSWAUoNWeV4ubzwaHVcKE84N2z83UhRF5q
	+A9m8FDfC+36FMSTtcUw9qvlU3g7q0xD2E4s+yP0wOTWH/wU1NBE3FPG6/FBCl7z0frBYeRI1AEDc
	zEc9kGRV+iwu05MHu3GIsWs5qsqaXOMjvivcuHoq/+A+aQLcnyZDAhdzr4/fEEGGWBwtCYKJfNk92
	9s0oMMXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zs-00000003E0y-13iH;
	Mon, 16 Mar 2026 07:04:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 02/21] expand and simplify the call of dup_token() in copy()
Date: Mon, 16 Mar 2026 07:03:56 +0000
Message-ID: <20260316070415.768839-2-viro@zeniv.linux.org.uk>
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

reducing ->pos handling helps there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index ae493dc2..e43061b2 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -613,10 +613,15 @@ static struct token **move_into(struct token **where, struct token *list)
 static struct token **copy(struct token **where, struct token *list)
 {
 	while (!eof_token(list)) {
-		struct token *token;
-		token = dup_token(list, &list->pos);
-		if (token_type(token) == TOKEN_IDENT && token->ident->tainted)
-			token->pos.noexpand = 1;
+		struct position pos = list->pos;
+		struct token *token = __alloc_token(0);
+
+		token->ident = list->ident;
+		if (pos.type == TOKEN_STRING || pos.type == TOKEN_WIDE_STRING)
+			list->string->immutable = 1;
+		if (pos.type == TOKEN_IDENT && list->ident->tainted)
+			pos.noexpand = 1;
+		token->pos = pos;
 		*where = token;
 		where = &token->next;
 		list = list->next;
-- 
2.47.3

