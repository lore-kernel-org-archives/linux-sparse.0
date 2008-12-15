From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 15/15] Warning should be enough for an unhandled transparent
	union
Date: Mon, 15 Dec 2008 03:27:55 +0300
Message-ID: <20081215002755.16107.5254.stgit@zaytsev.su>
References: <20081215000849.16107.74332.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:63894 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbYLOASo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 14 Dec 2008 19:18:44 -0500
Received: by mu-out-0910.google.com with SMTP id g7so1293887muf.1
        for <linux-sparse@vger.kernel.org>; Sun, 14 Dec 2008 16:18:43 -0800 (PST)
In-Reply-To: <20081215000849.16107.74332.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Blue Swirl <blauwirbel@gmail.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, David Given <dg@cowlark.com>

An error would be issued if such union is actually used.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 parse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index 877414c..915ae20 100644
--- a/parse.c
+++ b/parse.c
@@ -987,7 +987,7 @@ static struct token *attribute_conditional_context(struct token *token, struct s
 static struct token *attribute_transparent_union(struct token *token, struct symbol *attr, struct ctype *ctype)
 {
 	if (Wtransparent_union)
-		sparse_error(token->pos, "ignoring attribute __transparent_union__");
+		warning(token->pos, "ignoring attribute __transparent_union__");
 	return token;
 }
 

