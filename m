From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 3/18] Fix braino in which_kind()
Date: Mon, 09 Mar 2009 07:10:38 +0000
Message-ID: <E1LgZdG-0000rw-0M@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43726 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbZCIHKj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 03:10:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgZdG-0000rw-0M
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 07:10:38 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index 74a8103..08de424 100644
--- a/parse.c
+++ b/parse.c
@@ -1260,7 +1260,7 @@ static enum kind which_kind(struct token *token, struct token **p,
 	}
 
 	if (token_type(next) != TOKEN_SPECIAL)
-		return dont_nest ? Bad_Nested : Bad_Func;
+		return !dont_nest ? Bad_Nested : Bad_Func;
 
 	if (next->special == ')') {
 		/* don't complain about those */
-- 
1.5.6.5


