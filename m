From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/17] scope: give a scope for labels & gotos
Date: Mon, 13 Apr 2020 18:16:03 +0200
Message-ID: <20200413161605.95900-16-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731401AbgDMQQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C38BC008748
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:26 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a25so10742577wrd.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:26 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

One way of detecting gotos inside an statement expression
is to use a new kind of scope for the gotos & labels.
Since gotos don't need to have their label predeclared,
nothing can be checked at parsing time but later it can
be checked that a goto doesn't jump inside one of the
label scope created by statement expressions.

So, add additional scope information to gotos and labels
to allow such check to be done.

Note: the label's symbols are still created in the function
      scope since they belong to a single namespace.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c  | 2 ++
 parse.h  | 1 +
 symbol.h | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/parse.c b/parse.c
index 1a2c7af22ff4..244991c1c4f5 100644
--- a/parse.c
+++ b/parse.c
@@ -2481,6 +2481,7 @@ static struct token *parse_goto_statement(struct token *token, struct statement
 		add_statement(&function_computed_goto_list, stmt);
 	} else if (token_type(token) == TOKEN_IDENT) {
 		stmt->goto_label = label_symbol(token);
+		stmt->goto_scope = label_scope;
 		token = token->next;
 	} else {
 		sparse_error(token->pos, "Expected identifier or goto expression");
@@ -2533,6 +2534,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 
 		if (match_op(token->next, ':')) {
 			struct symbol *s = label_symbol(token);
+			s->label_scope = label_scope;
 			token = skip_attributes(token->next->next);
 			if (s->stmt) {
 				sparse_error(stmt->pos, "label '%s' redefined", show_ident(s->ident));
diff --git a/parse.h b/parse.h
index 0742a2a87e9d..5995eb56849f 100644
--- a/parse.h
+++ b/parse.h
@@ -99,6 +99,7 @@ struct statement {
 		};
 		struct /* goto_struct */ {
 			struct symbol *goto_label;
+			struct scope *goto_scope;
 
 			/* computed gotos have these: */
 			struct expression *goto_expression;
diff --git a/symbol.h b/symbol.h
index de13d60b8b75..f9d7bcaa997f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -167,6 +167,9 @@ struct symbol {
 			int (*handler)(struct stream *, struct token **, struct token *);
 			int normal;
 		};
+		struct /* NS_LABEL */ {
+			struct scope *label_scope;
+		};
 		struct /* NS_SYMBOL */ {
 			unsigned long	offset;
 			int		bit_size;
-- 
2.26.0
