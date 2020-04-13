From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/17] scope: move scope opening/ending inside compound_statement()
Date: Mon, 13 Apr 2020 18:15:58 +0200
Message-ID: <20200413161605.95900-11-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731411AbgDMQQu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3EBC0A3BE2
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so9822433wmj.1
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:49 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A compound statement starts and ends a block scope, so
it's better to start & end this scope inside the function
parsing the statement: compound_statement.
The only exception is for the body of a function where
the scope also enclose the parameter declaration but that
is fine since the function is special anyway.

Move the calls to start & close the block scope inside
compound_statement() and directly call statement_list()
for the function body.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c |  2 --
 parse.c      | 13 ++++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/expression.c b/expression.c
index 5b9bddfe456e..78e577cf10a1 100644
--- a/expression.c
+++ b/expression.c
@@ -71,9 +71,7 @@ struct token *parens_expression(struct token *token, struct expression **expr, c
 		struct statement *stmt = alloc_statement(token->pos, STMT_COMPOUND);
 		*expr = e;
 		e->statement = stmt;
-		start_symbol_scope();
 		token = compound_statement(token->next, stmt);
-		end_symbol_scope();
 		token = expect(token, '}', "at end of statement expression");
 	} else
 		token = parse_expression(token, expr);
diff --git a/parse.c b/parse.c
index a29c67c8cf41..5da314cd05ee 100644
--- a/parse.c
+++ b/parse.c
@@ -2547,11 +2547,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 	}
 
 	if (match_op(token, '{')) {
-		stmt->type = STMT_COMPOUND;
-		start_symbol_scope();
 		token = compound_statement(token->next, stmt);
-		end_symbol_scope();
-		
 		return expect(token, '}', "at end of compound statement");
 	}
 			
@@ -2658,7 +2654,10 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 
 struct token *compound_statement(struct token *token, struct statement *stmt)
 {
+	stmt->type = STMT_COMPOUND;
+	start_symbol_scope();
 	token = statement_list(token, &stmt->stmts);
+	end_symbol_scope();
 	return token;
 }
 
@@ -2810,15 +2809,15 @@ static struct token *parse_function_body(struct token *token, struct symbol *dec
 		decl->ctype.modifiers |= MOD_EXTERN;
 
 	stmt = start_function(decl);
-
 	*p = stmt;
+
 	FOR_EACH_PTR (base_type->arguments, arg) {
 		declare_argument(arg, base_type);
 	} END_FOR_EACH_PTR(arg);
 
-	token = compound_statement(token->next, stmt);
