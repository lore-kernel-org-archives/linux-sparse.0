Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817734B1A1
	for <linux-sparse@vger.kernel.org>; Mon, 16 Mar 2026 07:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644474; cv=none; b=UP20Xv7E6s3kikk6+M/rb7PWMfbejJhZw3PznHrnbyGcs9HSg0IghcERgZaWjcyV29LshQVFUqnCgomdOfkn5PtKzGUEqMeUqK3tBZCHvcfeg6r3jxB7xPS68WSWxXMrzgSfVjnbk00gI+gtj5SmcJfDavdkCTIgocFwm/xST/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644474; c=relaxed/simple;
	bh=2Yl/wnxpD9zUfES/a4TwvTacCZj5n/jkEMxpwPavn/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gap1HemQeK5/dGJ0P9zz1zOSDi6aEH3V4WCufr70zE6GYdcWtE+Z1azpyrYtqtD6EIuqjqySco8P/E7EsDovcfJdf/W8Xl9oPNsWHB7F9k7+uL25G7Ig0VGOhQSMRgFeiwx6c5OQYpDJma2G5KSJereeuP9VPIZE83MCjyVhNGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SHOJltGx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SHOJltGx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UXDMJ8SBWzAs6gb/AzCVQpgrNIJ6f1eaRk2natjbWlc=; b=SHOJltGxKgxV3Y6XTeAfXjGYYI
	3JZHIBZz3tegMeNdUeWYBi1M8Cp2e2L/cOCzGwIS4gMqIpJw1h3OHMGicJAXERY9NvU/Ze49I/e1J
	E5ThmMfM7/bEfbpaoJhaXYcBH3GNCEIiCl1icKaDcRCAYEiBJAuC0nwdtSScPwhjKvaDd88sAxh3V
	tRR+5s9VhTzIXn3Gsn2PRXU7wwU4SHvtJVgy2UjmYq37WJki5YKi55GBn95xgTgx3D7bDwxjw/qT1
	Y9iz74++lptGtKzk0jvxcPt/S/e9kBKYvKPGo8pIGobxwqzXd2LUxah/Im7ON2FTsuJUIr5zaIz4H
	GFZZiaEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w21zu-00000003E2U-01Po;
	Mon, 16 Mar 2026 07:04:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-sparse@vger.kernel.org
Cc: chriscli@google.com,
	torvalds@linux-foundation.org,
	zxh@xh-zhang.com,
	ben.dooks@codethink.co.uk,
	dan.carpenter@linaro.org,
	rf@opensource.cirrus.com
Subject: [PATCH 11/21] kill create_arglist()
Date: Mon, 16 Mar 2026 07:04:05 +0000
Message-ID: <20260316070415.768839-11-viro@zeniv.linux.org.uk>
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

we don't need the fake arglist for __has_extension() and its ilk anymore;
just set the ->arglist to &eof_token_entry to indicate that arguments
are expected and set ->fixed_args and ->vararg to tell how much.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index bd049620..aaf60293 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -2071,36 +2071,6 @@ static bool expand_has_feature(struct token *token, struct arg *args)
 	return 1;
 }
 
-static void create_arglist(struct symbol *sym, int count)
-{
-	struct token *token;
-	struct token **next;
-
-	if (!count)
-		return;
-
-	token = __alloc_token(0);
-	token_type(token) = TOKEN_ARG_COUNT;
-	sym->arglist = token;
-	sym->fixed_args = count;
-	sym->vararg = 0;
-	next = &token->next;
-
-	while (count--) {
-		struct token *id, *uses;
-		id = __alloc_token(0);
-		token_type(id) = TOKEN_IDENT;
-		uses = __alloc_token(0);
-		token_type(uses) = TOKEN_ARG_COUNT;
-		uses->count.quoted = 1;
-
-		*next = id;
-		id->next = uses;
-		next = &uses->next;
-	}
-	*next = &eof_token_entry;
-}
-
 static void init_preprocessor(void)
 {
 	int i;
@@ -2172,8 +2142,11 @@ static void init_preprocessor(void)
 		struct symbol *sym;
 		sym = create_symbol(stream, dynamic[i].name, SYM_NODE, NS_MACRO);
 		sym->expand_simple = dynamic[i].expand_simple;
-		if ((sym->expand = dynamic[i].expand) != NULL)
-			create_arglist(sym, 1);
+		if ((sym->expand = dynamic[i].expand) != NULL) {
+			sym->fixed_args = 1;
+			sym->vararg = false;
+			sym->arglist = &eof_token_entry;
+		}
 	}
 
 	counter_macro = 0;
-- 
2.47.3

