From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] check for whitespace before object-like macro body
Date: Fri, 25 May 2007 04:57:39 +0100
Message-ID: <E1HrQvr-00018V-Ir@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58094 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbXEYD5k (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 24 May 2007 23:57:40 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1HrQvr-00018V-Ir
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 04:57:39 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


6.10.3(3) requires a whitespace between object-like macro
and its replacement list.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 pre-process.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/pre-process.c b/pre-process.c
index 2b9cecc..8fca383 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -1089,11 +1089,16 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 
 	arglist = NULL;
 	expansion = left->next;
-	if (!expansion->pos.whitespace && match_op(expansion, '(')) {
-		arglist = expansion;
-		expansion = parse_arguments(expansion);
-		if (!expansion)
-			return 1;
+	if (!expansion->pos.whitespace) {
+		if (match_op(expansion, '(')) {
+			arglist = expansion;
+			expansion = parse_arguments(expansion);
+			if (!expansion)
+				return 1;
+		} else if (!eof_token(expansion)) {
+			warning(expansion->pos,
+				"no whitespace before object-like macro body");
+		}
 	}
 
 	expansion = parse_expansion(expansion, arglist, name);
-- 
1.5.0-rc2.GIT
