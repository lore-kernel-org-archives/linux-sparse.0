From: Al Viro <viro@ftp.linux.org.uk>
Subject: Braino in attribute_packed()
Date: Wed, 11 Mar 2009 15:45:47 +0000
Message-ID: <E1LhQct-0006sH-5W@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34401 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZCKPpt (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 Mar 2009 11:45:49 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LhQct-0006sH-5W
	for linux-sparse@vger.kernel.org; Wed, 11 Mar 2009 15:45:47 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


D'oh...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index f16d321..e2b47e3 100644
--- a/parse.c
+++ b/parse.c
@@ -943,7 +943,7 @@ static struct token *ignore_attribute(struct token *token, struct symbol *attr,
 
 static struct token *attribute_packed(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
-	if (!&ctx->ctype.alignment)
+	if (!ctx->ctype.alignment)
 		ctx->ctype.alignment = 1;
 	return token;
 }
-- 
1.5.6.5

