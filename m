From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] avoid some struct symbol member for for-statements
Date: Wed, 28 Jun 2017 22:49:17 +0200
Message-ID: <20170628204918.25853-2-luc.vanoostenryck@gmail.com>
References: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36215 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbdF1UtY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Jun 2017 16:49:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id y5so13624007wmh.3
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 13:49:24 -0700 (PDT)
In-Reply-To: <20170628204918.25853-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The for-statement needs a lot of fields in struct statement, much
more than any other statement. This is due to the complexity of
the for-statement.

The possibility in C99 to declare variables in the initialization
part of the statement add yet another field to hold the declared
symbols. However, these symbols doesn't need a lis of their own,
they can simply be put in the list of a STMT_DECLARATION used
as the 'pre-' statement of a classic for-statement.

Merge the symbols list with the pre-statement.

Note: The motivation for this change is to make struct statement
      smaller. The change also make further processing slightly
      simpler since we don't have to process the declaration
      separately.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compile-i386.c |  1 -
 dissect.c      |  1 -
 evaluate.c     |  1 -
 inline.c       |  2 --
 linearize.c    |  6 ------
 parse.c        | 22 +++++++++++++++-------
 parse.h        |  1 -
 show-parse.c   |  1 -
 8 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 24e408baa..de252c8f9 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -1926,7 +1926,6 @@ static void emit_loop(struct statement *stmt)
 	loop_continue = new_label();
 	loopstk_push(loop_continue, loop_bottom);
 
-	x86_symbol_decl(stmt->iterator_syms);
 	x86_statement(pre_statement);
 	if (!post_condition || post_condition->type != EXPR_VALUE || post_condition->value) {
 		loop_top = new_label();
diff --git a/dissect.c b/dissect.c
index 5f067eb4c..9f823980d 100644
--- a/dissect.c
+++ b/dissect.c
@@ -494,7 +494,6 @@ static struct symbol *do_statement(usage_t mode, struct statement *stmt)
 	}
 
 	break; case STMT_ITERATOR:
-		do_sym_list(stmt->iterator_syms);
 		do_statement(U_VOID, stmt->iterator_pre_statement);
 		do_expression(U_R_VAL, stmt->iterator_pre_condition);
 		do_statement(U_VOID, stmt->iterator_post_statement);
diff --git a/evaluate.c b/evaluate.c
index cf3cf244d..e5b3b5904 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3279,7 +3279,6 @@ static void evaluate_if_statement(struct statement *stmt)
 
 static void evaluate_iterator(struct statement *stmt)
 {
-	evaluate_symbol_list(stmt->iterator_syms);
 	evaluate_conditional(stmt->iterator_pre_condition, 1);
 	evaluate_conditional(stmt->iterator_post_condition,1);
 	evaluate_statement(stmt->iterator_pre_statement);
diff --git a/inline.c b/inline.c
index a3002c6bd..dec07a25c 100644
--- a/inline.c
+++ b/inline.c
@@ -421,8 +421,6 @@ static struct statement *copy_one_statement(struct statement *stmt)
 		stmt = dup_statement(stmt);
 		stmt->iterator_break = copy_symbol(stmt->pos, stmt->iterator_break);
 		stmt->iterator_continue = copy_symbol(stmt->pos, stmt->iterator_continue);
-		stmt->iterator_syms = copy_symbol_list(stmt->iterator_syms);
-
 		stmt->iterator_pre_statement = copy_one_statement(stmt->iterator_pre_statement);
 		stmt->iterator_pre_condition = copy_expression(stmt->iterator_pre_condition);
 
diff --git a/linearize.c b/linearize.c
index 7313e72d8..6d0695a18 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2000,12 +2000,6 @@ static pseudo_t linearize_iterator(struct entrypoint *ep, struct statement *stmt
 	struct statement  *post_statement = stmt->iterator_post_statement;
 	struct expression *post_condition = stmt->iterator_post_condition;
 	struct basic_block *loop_top, *loop_body, *loop_continue, *loop_end;
-	struct symbol *sym;
-
-	FOR_EACH_PTR(stmt->iterator_syms, sym) {
-		linearize_one_symbol(ep, sym);
-	} END_FOR_EACH_PTR(sym);
-	concat_symbol_list(stmt->iterator_syms, &ep->syms);
 	linearize_statement(ep, pre_statement);
 
 	loop_body = loop_top = alloc_basic_block(ep, stmt->pos);
diff --git a/parse.c b/parse.c
index 214547904..e063dae99 100644
--- a/parse.c
+++ b/parse.c
@@ -2282,36 +2282,44 @@ static void validate_for_loop_decl(struct symbol *sym)
 
 static struct token *parse_for_statement(struct token *token, struct statement *stmt)
 {
-	struct symbol_list *syms;
-	struct expression *e1, *e2, *e3;
+	struct expression *e2, *e3;
 	struct statement *iterator;
+	struct statement *pre = NULL;
 
-	start_iterator(stmt);
 	token = expect(token->next, '(', "after 'for'");
 
-	syms = NULL;
-	e1 = NULL;
 	/* C99 variable declaration? */
 	if (lookup_type(token)) {
+		struct symbol_list *syms = NULL;
+		struct position pos = token->pos;
+		start_symbol_scope();
 		token = external_declaration(token, &syms, validate_for_loop_decl);
+		pre = alloc_statement(pos, STMT_DECLARATION);
+		pre->declaration = syms;
 	} else {
+		struct expression *e1 = NULL;
 		token = parse_expression(token, &e1);
 		token = expect(token, ';', "in 'for'");
+		pre = make_statement(e1);
 	}
+
+	start_iterator(stmt);
 	token = parse_expression(token, &e2);
 	token = expect(token, ';', "in 'for'");
 	token = parse_expression(token, &e3);
 	token = expect(token, ')', "in 'for'");
 	token = statement(token, &iterator);
 
-	stmt->iterator_syms = syms;
-	stmt->iterator_pre_statement = make_statement(e1);
+	stmt->iterator_pre_statement = pre;
 	stmt->iterator_pre_condition = e2;
 	stmt->iterator_post_statement = make_statement(e3);
 	stmt->iterator_post_condition = NULL;
 	stmt->iterator_statement = iterator;
 	end_iterator(stmt);
 
+	if (pre && pre->type == STMT_DECLARATION)
+		end_symbol_scope();
+
 	return token;
 }
 
diff --git a/parse.h b/parse.h
index 26227a387..e01497096 100644
--- a/parse.h
+++ b/parse.h
@@ -88,7 +88,6 @@ struct statement {
 		struct /* iterator_struct */ {
 			struct symbol *iterator_break;
 			struct symbol *iterator_continue;
-			struct symbol_list *iterator_syms;
 			struct statement  *iterator_pre_statement;
 			struct expression *iterator_pre_condition;
 
diff --git a/show-parse.c b/show-parse.c
index 5e3e13165..6801a68e2 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -633,7 +633,6 @@ int show_statement(struct statement *stmt)
 		struct expression *post_condition = stmt->iterator_post_condition;
 		int val, loop_top = 0, loop_bottom = 0;
 
-		show_symbol_decl(stmt->iterator_syms);
 		show_statement(pre_statement);
 		if (pre_condition) {
 			if (pre_condition->type == EXPR_VALUE) {
-- 
2.13.0

