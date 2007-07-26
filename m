From: ricknu-0@student.ltu.se
Subject: [PATCH] parse.c: Adding va_end().
Date: Fri, 27 Jul 2007 01:28:22 +0200
Message-ID: <1185492502.46a92e16f26bf@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from gepetto.dc.ltu.se ([130.240.42.40]:61129 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbXGZX2Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 26 Jul 2007 19:28:24 -0400
Received: from localhost (wc-special5.dc.ltu.se [130.240.42.175])
	by gepetto.dc.ltu.se (8.12.5/8.12.5) with ESMTP id l6QNSNmn009186
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jul 2007 01:28:23 +0200 (MEST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Adding va_end().

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
According to the manual, it needs a va_end() in the same function.
Now it seems to be as many of va_end() as va_start().

diff --git a/parse.c b/parse.c
index bae12ec..dfb922f 100644
--- a/parse.c
+++ b/parse.c
@@ -366,18 +366,18 @@ static void fn_local_symbol(struct symbol *sym)
 static int SENTINEL_ATTR match_idents(struct token *token, ...)
 {
 	va_list args;
+	struct ident * next;
 
 	if (token_type(token) != TOKEN_IDENT)
 		return 0;
 
 	va_start(args, token);
-	for (;;) {
-		struct ident * next = va_arg(args, struct ident *);
-		if (!next)
-			return 0;
-		if (token->ident == next)
-			return 1;
-	}
+	do {
+		next = va_arg(args, struct ident *);
+	} while (next && token->ident != next);
+	va_end(args);
+
+	return next && token->ident == next;
 }
 
 
