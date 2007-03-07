From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1/5] Moving statement parsing into smaller functions.
Date: Wed, 7 Mar 2007 02:03:08 -0800
Message-ID: <20070307100308.GB10577@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc13.comcast.net ([206.18.177.53]:51637 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbXCGKhp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 05:37:45 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


This is the preparation step for the keyword table driven
parsing. Those statement parsing function will later
turn into function call back.

The patch should not introduce any functional changes.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-02-28 16:41:57.000000000 -0800
+++ sparse/parse.c	2007-02-28 17:22:38.000000000 -0800
@@ -1118,6 +1118,7 @@ static struct token *parse_asm_clobbers(
 
 static struct token *parse_asm(struct token *token, struct statement *stmt)
 {
+	token = token->next;
 	stmt->type = STMT_ASM;
 	if (match_idents(token, &__volatile___ident, &__volatile_ident, &volatile_ident, NULL)) {
 		token = token->next;
@@ -1345,56 +1346,125 @@ static struct token *parse_do_statement(
 	return expect(token, ';', "after statement");
 }
 
+static struct token *parse_if_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_IF;
+	token = parens_expression(token->next, &stmt->if_conditional, "after if");
+	token = statement(token, &stmt->if_true);
+	if (token_type(token) != TOKEN_IDENT)
+		return token;
+	if (token->ident != &else_ident)
+		return token;
+	return statement(token->next, &stmt->if_false);
+}
+
+static inline struct token *case_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_CASE;
+	token = expect(token, ':', "after default/case");
+	add_case_statement(stmt);
+	return statement(token, &stmt->case_statement);
+}
+
+static struct token *parse_case_statement(struct token *token, struct statement *stmt)
+{
+	token = parse_expression(token->next, &stmt->case_expression);
+	if (match_op(token, SPECIAL_ELLIPSIS))
+		token = parse_expression(token->next, &stmt->case_to);
+	return case_statement(token, stmt);
+}
+
+static struct token *parse_default_statement(struct token *token, struct statement *stmt)
+{
+	return case_statement(token->next, stmt); 
+}
+
+static struct token *parse_loop_iterator(struct token *token, struct statement *stmt)
+{
+	struct symbol *target = lookup_symbol(token->ident, NS_ITERATOR);
+	stmt->type = STMT_GOTO;
+	stmt->goto_label = target;
+	if (!target)
+		sparse_error(stmt->pos, "break/continue not in iterator scope");
+	return expect(token->next, ';', "at end of statement");
+}
+
+static struct token *parse_switch_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_SWITCH;
+	start_switch(stmt);
+	token = parens_expression(token->next, &stmt->switch_expression, "after 'switch'");
+	token = statement(token, &stmt->switch_statement);
+	end_switch(stmt);
+	return token;
+}
+
+static struct token *parse_goto_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_GOTO;
+	token = token->next;
+	if (match_op(token, '*')) {
+		token = parse_expression(token->next, &stmt->goto_expression);
+		add_statement(&function_computed_goto_list, stmt);
+	} else if (token_type(token) == TOKEN_IDENT) {
+		stmt->goto_label = label_symbol(token);
+		token = token->next;
+	} else {
+		sparse_error(token->pos, "Expected identifier or goto expression");
+	}
+	return expect(token, ';', "at end of statement");
+}
+
+static struct token *parse_context_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_CONTEXT;
+	token = parse_expression(token->next, &stmt->expression);
+	if(stmt->expression->type == EXPR_PREOP
+	   && stmt->expression->op == '('
+	   && stmt->expression->unop->type == EXPR_COMMA) {
+		struct expression *expr;
+		expr = stmt->expression->unop;
+		stmt->context = expr->left;
+		stmt->expression = expr->right;
+	}
+	return expect(token, ';', "at end of statement");
+}
+
+static struct token *parse_range_statement(struct token *token, struct statement *stmt)
+{
+	stmt->type = STMT_RANGE;
+	token = assignment_expression(token->next, &stmt->range_expression);
+	token = expect(token, ',', "after range expression");
+	token = assignment_expression(token, &stmt->range_low);
+	token = expect(token, ',', "after low range");
+	token = assignment_expression(token, &stmt->range_high);
+	return expect(token, ';', "after range statement");
+}
+
 static struct token *statement(struct token *token, struct statement **tree)
 {
 	struct statement *stmt = alloc_statement(token->pos, STMT_NONE);
 
 	*tree = stmt;
 	if (token_type(token) == TOKEN_IDENT) {
-		if (token->ident == &if_ident) {
-			stmt->type = STMT_IF;
-			token = parens_expression(token->next, &stmt->if_conditional, "after if");
-			token = statement(token, &stmt->if_true);
-			if (token_type(token) != TOKEN_IDENT)
-				return token;
-			if (token->ident != &else_ident)
-				return token;
-			return statement(token->next, &stmt->if_false);
-		}
+		if (token->ident == &if_ident)
+			return parse_if_statement(token, stmt);
 
 		if (token->ident == &return_ident)
 			return parse_return_statement(token, stmt);
 
-		if (token->ident == &break_ident || token->ident == &continue_ident) {
-			struct symbol *target = lookup_symbol(token->ident, NS_ITERATOR);
-			stmt->type = STMT_GOTO;
-			stmt->goto_label = target;
-			if (!target)
-				sparse_error(stmt->pos, "break/continue not in iterator scope");
-			return expect(token->next, ';', "at end of statement");
-		}
-		if (token->ident == &default_ident) {
-			token = token->next;
-			goto default_statement;
-		}
-		if (token->ident == &case_ident) {
-			token = parse_expression(token->next, &stmt->case_expression);
-			if (match_op(token, SPECIAL_ELLIPSIS))
-				token = parse_expression(token->next, &stmt->case_to);
-default_statement:
-			stmt->type = STMT_CASE;
-			token = expect(token, ':', "after default/case");
-			add_case_statement(stmt);
-			return statement(token, &stmt->case_statement);
-		}
-		if (token->ident == &switch_ident) {
-			stmt->type = STMT_SWITCH;
-			start_switch(stmt);
-			token = parens_expression(token->next, &stmt->switch_expression, "after 'switch'");
-			token = statement(token, &stmt->switch_statement);
-			end_switch(stmt);
-			return token;
-		}
+		if (token->ident == &break_ident || token->ident == &continue_ident)
+			return parse_loop_iterator(token, stmt);
+
+		if (token->ident == &default_ident)
+			return parse_default_statement(token, stmt);
+
+		if (token->ident == &case_ident)
+			return parse_case_statement(token, stmt);
+
+		if (token->ident == &switch_ident)
+			return parse_switch_statement(token, stmt);
+
 		if (token->ident == &for_ident)
 			return parse_for_statement(token, stmt);
 
@@ -1404,45 +1474,18 @@ default_statement:
 		if (token->ident == &do_ident)
 			return parse_do_statement(token, stmt);
 
-		if (token->ident == &goto_ident) {
-			stmt->type = STMT_GOTO;
-			token = token->next;
-			if (match_op(token, '*')) {
-				token = parse_expression(token->next, &stmt->goto_expression);
-				add_statement(&function_computed_goto_list, stmt);
-			} else if (token_type(token) == TOKEN_IDENT) {
-				stmt->goto_label = label_symbol(token);
-				token = token->next;
-			} else {
-				sparse_error(token->pos, "Expected identifier or goto expression");
-			}
-			return expect(token, ';', "at end of statement");
-		}
-		if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL)) {
-			return parse_asm(token->next, stmt);
-		}
-		if (token->ident == &__context___ident) {
-			stmt->type = STMT_CONTEXT;
-			token = parse_expression(token->next, &stmt->expression);
-			if(stmt->expression->type == EXPR_PREOP
-			   && stmt->expression->op == '('
-			   && stmt->expression->unop->type == EXPR_COMMA) {
-				struct expression *expr;
-				expr = stmt->expression->unop;
-				stmt->context = expr->left;
-				stmt->expression = expr->right;
-			}
-			return expect(token, ';', "at end of statement");
-		}
-		if (token->ident == &__range___ident) {
-			stmt->type = STMT_RANGE;
-			token = assignment_expression(token->next, &stmt->range_expression);
-			token = expect(token, ',', "after range expression");
-			token = assignment_expression(token, &stmt->range_low);
-			token = expect(token, ',', "after low range");
-			token = assignment_expression(token, &stmt->range_high);
-			return expect(token, ';', "after range statement");
-		}
+		if (token->ident == &goto_ident)
+			return parse_goto_statement(token, stmt);
+
+		if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL))
+			return parse_asm(token, stmt);
+
+		if (token->ident == &__context___ident)
+			return parse_context_statement(token, stmt);
+
+		if (token->ident == &__range___ident)
+			return parse_range_statement(token, stmt);
+
 		if (match_op(token->next, ':')) {
 			stmt->type = STMT_LABEL;
 			stmt->label_identifier = label_symbol(token);
@@ -1768,6 +1811,21 @@ static struct token *parse_k_r_arguments
 	return parse_function_body(token, decl, list);
 }
 
+static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list)
+{
+	struct symbol *anon = alloc_symbol(token->pos, SYM_NODE);
+	struct symbol *fn = alloc_symbol(token->pos, SYM_FN);
+	struct statement *stmt;
+
+	anon->ctype.base_type = fn;
+	stmt = alloc_statement(token->pos, STMT_NONE);
+	fn->stmt = stmt;
+	
+	token = parse_asm(token, stmt);
+
+	add_symbol(list, anon);
+	return token;
+}
 
 struct token *external_declaration(struct token *token, struct symbol_list **list)
 {
@@ -1778,20 +1836,8 @@ struct token *external_declaration(struc
 	int is_typedef;
 
 	/* Top-level inline asm? */
-	if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL)) {
-		struct symbol *anon = alloc_symbol(token->pos, SYM_NODE);
-		struct symbol *fn = alloc_symbol(token->pos, SYM_FN);
-		struct statement *stmt;
-
-		anon->ctype.base_type = fn;
-		stmt = alloc_statement(token->pos, STMT_NONE);
-		fn->stmt = stmt;
-		
-		token = parse_asm(token->next, stmt);
-
-		add_symbol(list, anon);
-		return token;
-	}
+	if (match_idents(token, &asm_ident, &__asm___ident, &__asm_ident, NULL))
+		return toplevel_asm_declaration(token, list);
 
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctype, 0);
