From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/15] cleanup: move parsing helpers to parse.c
Date: Sun,  5 Jul 2020 15:02:19 +0200
Message-ID: <20200705130220.26230-15-luc.vanoostenryck@gmail.com>
References: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGENCn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305BCC08C5DE
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:43 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so39548121ejd.13
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:43 -0700 (PDT)
In-Reply-To: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

lib.c contains 2-3 helpers for parsing. Move them to parse.c.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.c   | 38 --------------------------------------
 parse.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib.c b/lib.c
index fd1fe6cb3ba5..f512be2e1a43 100644
--- a/lib.c
+++ b/lib.c
@@ -50,44 +50,6 @@
 #include "bits.h"
 
 
-struct token *skip_to(struct token *token, int op)
-{
-	while (!match_op(token, op) && !eof_token(token))
-		token = token->next;
-	return token;
-}
-
-static struct token bad_token = { .pos.type = TOKEN_BAD };
-struct token *expect(struct token *token, int op, const char *where)
-{
-	if (!match_op(token, op)) {
-		if (token != &bad_token) {
-			bad_token.next = token;
-			sparse_error(token->pos, "Expected %s %s", show_special(op), where);
-			sparse_error(token->pos, "got %s", show_token(token));
-		}
-		if (op == ';')
-			return skip_to(token, op);
-		return &bad_token;
-	}
-	return token->next;
-}
-
-///
-// issue an error message on new parsing errors
-// @token: the current token
-// @errmsg: the error message
-// If the current token is from a previous error, an error message
-// has already been issued, so nothing more is done.
-// Otherwise, @errmsg is displayed followed by the current token.
-void unexpected(struct token *token, const char *errmsg)
-{
-	if (token == &bad_token)
-		return;
-	sparse_error(token->pos, "%s", errmsg);
-	sparse_error(token->pos, "got %s", show_token(token));
-}
-
 unsigned int hexval(unsigned int c)
 {
 	int retval = 256;
diff --git a/parse.c b/parse.c
index 70d8b237ce5e..cea208395090 100644
--- a/parse.c
+++ b/parse.c
@@ -655,6 +655,44 @@ void init_parser(int stream)
 }
 
 
+struct token *skip_to(struct token *token, int op)
+{
+	while (!match_op(token, op) && !eof_token(token))
+		token = token->next;
+	return token;
+}
+
+static struct token bad_token = { .pos.type = TOKEN_BAD };
+struct token *expect(struct token *token, int op, const char *where)
+{
+	if (!match_op(token, op)) {
+		if (token != &bad_token) {
+			bad_token.next = token;
+			sparse_error(token->pos, "Expected %s %s", show_special(op), where);
+			sparse_error(token->pos, "got %s", show_token(token));
+		}
+		if (op == ';')
+			return skip_to(token, op);
+		return &bad_token;
+	}
+	return token->next;
+}
+
+///
+// issue an error message on new parsing errors
+// @token: the current token
+// @errmsg: the error message
+// If the current token is from a previous error, an error message
+// has already been issued, so nothing more is done.
+// Otherwise, @errmsg is displayed followed by the current token.
+void unexpected(struct token *token, const char *errmsg)
+{
+	if (token == &bad_token)
+		return;
+	sparse_error(token->pos, "%s", errmsg);
+	sparse_error(token->pos, "got %s", show_token(token));
+}
+
 // Add a symbol to the list of function-local symbols
 static void fn_local_symbol(struct symbol *sym)
 {
-- 
2.27.0
