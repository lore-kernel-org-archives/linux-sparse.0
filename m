From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] make for-loop statement simpler
Date: Wed, 28 Jun 2017 22:49:18 +0200
Message-ID: <20170628204918.25853-3-luc.vanoostenryck@gmail.com>
References: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34147 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751650AbdF1Utf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Jun 2017 16:49:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so8803271wmg.1
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 13:49:30 -0700 (PDT)
In-Reply-To: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The for-statement needs a lot of fields in struct statement, much
more than any other statement. This is due to the complexity of
the for-statement.

However part of this complexity can be removed by processing the
'pre-' statement separately from the loop. This is equivalent to
transform a single-statement for-loop like:
	for (pre; cond; post)
		body
into a compound statement like:
	pre;
	for (;cond; post)
		body;

Note: The motivation for this change is to make struct statement
      smaller. The change also make further processing slightly
      simpler since we don't have to process the 'pre-' statement
      separately.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ast-inspect.c  |  2 --
 compile-i386.c |  2 --
 dissect.c      |  1 -
 evaluate.c     |  1 -
 expand.c       |  1 -
 inline.c       |  1 -
 linearize.c    |  2 --
 parse.c        | 10 +++++++++-
 parse.h        |  1 -
 show-parse.c   |  2 --
 10 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/ast-inspect.c b/ast-inspect.c
index 24d4a4a65..e25e9d097 100644
--- a/ast-inspect.c
+++ b/ast-inspect.c
@@ -59,8 +59,6 @@ void inspect_statement(AstNode *node)
 		case STMT_ITERATOR:
 			ast_append_child(node, "break:", stmt->iterator_break, inspect_symbol);
 			ast_append_child(node, "continue:", stmt->iterator_continue, inspect_symbol);
-			ast_append_child(node, "pre_statement:", stmt->iterator_pre_statement,
-					 inspect_statement);
 			ast_append_child(node, "statement:", stmt->iterator_statement,
 					 inspect_statement);
 			ast_append_child(node, "post_statement:", stmt->iterator_post_statement,
diff --git a/compile-i386.c b/compile-i386.c
index de252c8f9..c5e2309ce 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1913,7 +1913,6 @@ static int loopstk_continue(void)
 
 static void emit_loop(struct statement *stmt)
 {
-	struct statement  *pre_statement = stmt->iterator_pre_statement;
 	struct expression *pre_condition = stmt->iterator_pre_condition;
 	struct statement  *statement = stmt->iterator_statement;
 	struct statement  *post_statement = stmt->iterator_post_statement;
@@ -1926,7 +1925,6 @@ static void emit_loop(struct statement *stmt)
 	loop_continue = new_label();
 	loopstk_push(loop_continue, loop_bottom);
 
-	x86_statement(pre_statement);
 	if (!post_condition || post_condition->type != EXPR_VALUE || post_condition->value) {
 		loop_top = new_label();
 		emit_label(loop_top, "loop top");
diff --git a/dissect.c b/dissect.c
index 9f823980d..fb3ae9167 100644
--- a/dissect.c
+++ b/dissect.c
@@ -494,7 +494,6 @@ static struct symbol *do_statement(usage_t mode, struct statement *stmt)
 	}
 
 	break; case STMT_ITERATOR:
-		do_statement(U_VOID, stmt->iterator_pre_statement);
 		do_expression(U_R_VAL, stmt->iterator_pre_condition);
 		do_statement(U_VOID, stmt->iterator_post_statement);
 		do_statement(U_VOID, stmt->iterator_statement);
diff --git a/evaluate.c b/evaluate.c
index e5b3b5904..a2e356f0b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3281,7 +3281,6 @@ static void evaluate_iterator(struct statement *stmt)
 {
 	evaluate_conditional(stmt->iterator_pre_condition, 1);
 	evaluate_conditional(stmt->iterator_post_condition,1);
-	evaluate_statement(stmt->iterator_pre_statement);
 	evaluate_statement(stmt->iterator_statement);
 	evaluate_statement(stmt->iterator_post_statement);
 }
diff --git a/expand.c b/expand.c
index 5f908c971..27df8baf9 100644
--- a/expand.c
+++ b/expand.c
@@ -1180,7 +1180,6 @@ static int expand_statement(struct statement *stmt)
 	case STMT_ITERATOR:
 		expand_expression(stmt->iterator_pre_condition);
 		expand_expression(stmt->iterator_post_condition);
-		expand_statement(stmt->iterator_pre_statement);
 		expand_statement(stmt->iterator_statement);
 		expand_statement(stmt->iterator_post_statement);
 		return SIDE_EFFECTS;
diff --git a/inline.c b/inline.c
index dec07a25c..a5ae22c2b 100644
--- a/inline.c
+++ b/inline.c
@@ -421,7 +421,6 @@ static struct statement *copy_one_statement(struct statement *stmt)
 		stmt = dup_statement(stmt);
 		stmt->iterator_break = copy_symbol(stmt->pos, stmt->iterator_break);
 		stmt->iterator_continue = copy_symbol(stmt->pos, stmt->iterator_continue);
-		stmt->iterator_pre_statement = copy_one_statement(stmt->iterator_pre_statement);
 		stmt->iterator_pre_condition = copy_expression(stmt->iterator_pre_condition);
 
 		stmt->iterator_statement = copy_one_statement(stmt->iterator_statement);
diff --git a/linearize.c b/linearize.c
index 6d0695a18..f0057bec0 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1994,13 +1994,11 @@ static pseudo_t linearize_switch(struct entrypoint *ep, struct statement *stmt)
 
 static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt)
 {
-	struct statement  *pre_statement = stmt->iterator_pre_statement;
 	struct expression *pre_condition = stmt->iterator_pre_condition;
 	struct statement  *statement = stmt->iterator_statement;
 	struct statement  *post_statement = stmt->iterator_post_statement;
 	struct expression *post_condition = stmt->iterator_post_condition;
 	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
-	linearize_statement(ep, pre_statement);
 
 	loop_body = loop_top = alloc_basic_block(ep, stmt->pos);
 	loop_continue = alloc_basic_block(ep, stmt->pos);
diff --git a/parse.c b/parse.c
index e063dae99..ea8e3de19 100644
--- a/parse.c
+++ b/parse.c
@@ -2284,6 +2284,7 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 {
 	struct expression *e2, *e3;
 	struct statement *iterator;
+	struct statement *compound;
 	struct statement *pre = NULL;
 
 	token = expect(token->next, '(', "after 'for'");
@@ -2303,6 +2304,14 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 		pre = make_statement(e1);
 	}
 
+	if (pre) {
+		compound = stmt;
+		compound->type = STMT_COMPOUND;
+		stmt = alloc_statement(token->pos, STMT_ITERATOR);
+		add_statement(&compound->stmts, pre);
+		add_statement(&compound->stmts, stmt);
+	}
+
 	start_iterator(stmt);
 	token = parse_expression(token, &e2);
 	token = expect(token, ';', "in 'for'");
@@ -2310,7 +2319,6 @@ static struct token *parse_for_statement(struct token *token, struct statement *
 	token = expect(token, ')', "in 'for'");
 	token = statement(token, &iterator);
 
-	stmt->iterator_pre_statement = pre;
 	stmt->iterator_pre_condition = e2;
 	stmt->iterator_post_statement = make_statement(e3);
 	stmt->iterator_post_condition = NULL;
diff --git a/parse.h b/parse.h
index e01497096..5220f3af0 100644
--- a/parse.h
+++ b/parse.h
@@ -88,7 +88,6 @@ struct statement {
 		struct /* iterator_struct */ {
 			struct symbol *iterator_break;
 			struct symbol *iterator_continue;
-			struct statement  *iterator_pre_statement;
 			struct expression *iterator_pre_condition;
 
 			struct statement  *iterator_statement;
diff --git a/show-parse.c b/show-parse.c
index 6801a68e2..cbd93b21c 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -626,14 +626,12 @@ int show_statement(struct statement *stmt)
 		break;
 
 	case STMT_ITERATOR: {
-		struct statement  *pre_statement = stmt->iterator_pre_statement;
 		struct expression *pre_condition = stmt->iterator_pre_condition;
 		struct statement  *statement = stmt->iterator_statement;
 		struct statement  *post_statement = stmt->iterator_post_statement;
 		struct expression *post_condition = stmt->iterator_post_condition;
 		int val, loop_top = 0, loop_bottom = 0;
 
-		show_statement(pre_statement);
 		if (pre_condition) {
 			if (pre_condition->type == EXPR_VALUE) {
 				if (!pre_condition->value) {
-- 
2.13.0

