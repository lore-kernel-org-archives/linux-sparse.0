From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 13/28] scope: move scope opening/ending inside compound_statement()
Date: Tue, 19 May 2020 02:57:13 +0200
Message-ID: <20200519005728.84594-14-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgESA5r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C823C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so10368319ejd.8
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:47 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 9e7b74f98638..e23c5b64e8be 100644
--- a/parse.c
+++ b/parse.c
@@ -2555,11 +2555,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 	}
 
 	if (match_op(token, '{')) {
-		stmt->type = STMT_COMPOUND;
-		start_symbol_scope();
 		token = compound_statement(token->next, stmt);
-		end_symbol_scope();
-		
 		return expect(token, '}', "at end of compound statement");
 	}
 			
@@ -2666,7 +2662,10 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 
 struct token *compound_statement(struct token *token, struct statement *stmt)
 {
+	stmt->type = STMT_COMPOUND;
+	start_symbol_scope();
 	token = statement_list(token, &stmt->stmts);
+	end_symbol_scope();
 	return token;
 }
 
@@ -2818,15 +2817,15 @@ static struct token *parse_function_body(struct token *token, struct symbol *dec
 		decl->ctype.modifiers |= MOD_EXTERN;
 
 	stmt = start_function(decl);
-
 	*p = stmt;
+
 	FOR_EACH_PTR (base_type->arguments, arg) {
 		declare_argument(arg, base_type);
 	} END_FOR_EACH_PTR(arg);
 
-	token = compound_statement(token->next, stmt);
