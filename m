From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH 1/4] more transparent dealing with tokens/position
Date: Tue, 12 Apr 2011 13:01:13 +0200
Message-ID: <4DA430F9.3070709@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep33.mx.upcmail.net ([62.179.121.51]:53762 "EHLO
	fep33.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab1DLLBY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Apr 2011 07:01:24 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Unify usage of `token_type'.

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 expression.h |    2 +-
 token.h      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/expression.h b/expression.h
index 9778de8..480079c 100644
--- a/expression.h
+++ b/expression.h
@@ -200,7 +200,7 @@ struct token *typename(struct token *, struct symbol **, int *);
 
 static inline int lookup_type(struct token *token)
 {
-	if (token->pos.type == TOKEN_IDENT) {
+	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL | NS_TYPEDEF);
 		return sym && (sym->namespace & NS_TYPEDEF);
 	}
diff --git a/token.h b/token.h
index a7ec77e..a3c194d 100644
--- a/token.h
+++ b/token.h
@@ -205,12 +205,12 @@ extern struct token *preprocess(struct token *);
 
 static inline int match_op(struct token *token, int op)
 {
-	return token->pos.type == TOKEN_SPECIAL && token->special == op;
+	return token_type(token) == TOKEN_SPECIAL && token->special == op;
 }
 
 static inline int match_ident(struct token *token, struct ident *id)
 {
-	return token->pos.type == TOKEN_IDENT && token->ident == id;
+	return token_type(token) == TOKEN_IDENT && token->ident == id;
 }
 
 #endif
-- 
1.7.1
