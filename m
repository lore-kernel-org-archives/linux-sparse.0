From: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Subject: [PATCH] parse.c: "if(" -> "if (" adjustment
Date: Sat, 16 Apr 2011 13:29:18 +0200
Message-ID: <4DA97D8E.9000503@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fep14.mx.upcmail.net ([62.179.121.34]:49505 "EHLO
	fep14.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759313Ab1DPL3X (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 16 Apr 2011 07:29:23 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Signed-off-by: Jan Pokorny <pokorny_jan@seznam.cz>
---
 parse.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse.c b/parse.c
index 537055f..9e79ef0 100644
--- a/parse.c
+++ b/parse.c
@@ -2235,9 +2235,9 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 {
 	stmt->type = STMT_CONTEXT;
 	token = parse_expression(token->next, &stmt->expression);
-	if(stmt->expression->type == EXPR_PREOP
-	   && stmt->expression->op == '('
-	   && stmt->expression->unop->type == EXPR_COMMA) {
+	if (stmt->expression->type == EXPR_PREOP
+	    && stmt->expression->op == '('
+	    && stmt->expression->unop->type == EXPR_COMMA) {
 		struct expression *expr;
 		expr = stmt->expression->unop;
 		stmt->context = expr->left;
-- 
1.7.1

