From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] use a specific struct for asm operands
Date: Sun, 17 Sep 2017 09:56:44 +0200
Message-ID: <20170917075644.63069-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37640 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdIQH4v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Sep 2017 03:56:51 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so3401381wrf.4
        for <linux-sparse@vger.kernel.org>; Sun, 17 Sep 2017 00:56:50 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

ASM operands have the following syntax:
	[<ident>] "<constraint>" '(' <expr> ')'
For some reasons, during parsing this is stored
as a sequence of 3 expressions. This has some serious
disadvantages though:
- <ident> has not the type of an expression
- it complicates processing when compared to having a specific
  struct for it (need to loop & maintain some state).
- <ident> is optional and stored as a null pointer when not present
  which is annoying, for example, if null pointers are used internally
  in ptr-lists to mark removed pointers.

Fix this by using a specific structure to store the 3 elements
of ASM operands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

This patch is also available for review & testing in the git repository at:

  git://github.com/lucvoo/sparse.git struct-asm-ops

 evaluate.c   | 82 +++++++++++++++++++++++++-----------------------------------
 expand.c     |  3 +++
 expression.h |  7 ++++++
 inline.c     | 19 ++++++--------
 linearize.c  | 42 +++----------------------------
 parse.c      | 14 ++++-------
 show-parse.c |  3 +++
 7 files changed, 63 insertions(+), 107 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 649e132b8..2ae5432f6 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3160,6 +3160,9 @@ struct symbol *evaluate_expression(struct expression *expr)
 	case EXPR_SLICE:
 		expression_error(expr, "internal front-end error: SLICE re-evaluated");
 		return NULL;
+	case EXPR_ASM_OPERAND:
+		expression_error(expr, "internal front-end error: ASM_OPERAND evaluated");
+		return NULL;
 	}
 	return NULL;
 }
@@ -3322,8 +3325,8 @@ static void verify_input_constraint(struct expression *expr, const char *constra
 static void evaluate_asm_statement(struct statement *stmt)
 {
 	struct expression *expr;
+	struct expression *op;
 	struct symbol *sym;
-	int state;
 
 	expr = stmt->asm_string;
 	if (!expr || expr->type != EXPR_STRING) {
@@ -3331,58 +3334,41 @@ static void evaluate_asm_statement(struct statement *stmt)
 		return;
 	}
 
-	state = 0;
-	FOR_EACH_PTR(stmt->asm_outputs, expr) {
-		switch (state) {
-		case 0: /* Identifier */
-			state = 1;
-			continue;
+	FOR_EACH_PTR(stmt->asm_outputs, op) {
+		/* Identifier */
 
-		case 1: /* Constraint */
-			state = 2;
-			if (!expr || expr->type != EXPR_STRING) {
-				sparse_error(expr ? expr->pos : stmt->pos, "asm output constraint is not a string");
-				*THIS_ADDRESS(expr) = NULL;
-				continue;
-			}
+		/* Constraint */
+		expr = op->constraint;
+		if (!expr || expr->type != EXPR_STRING) {
+			sparse_error(expr ? expr->pos : stmt->pos, "asm output constraint is not a string");
+			op->constraint = NULL;
+		} else
 			verify_output_constraint(expr, expr->string->data);
-			continue;
 
-		case 2: /* Expression */
-			state = 0;
-			if (!evaluate_expression(expr))
-				return;
-			if (!lvalue_expression(expr))
-				warning(expr->pos, "asm output is not an lvalue");
-			evaluate_assign_to(expr, expr->ctype);
-			continue;
-		}
-	} END_FOR_EACH_PTR(expr);
-
-	state = 0;
-	FOR_EACH_PTR(stmt->asm_inputs, expr) {
-		switch (state) {
-		case 0: /* Identifier */
-			state = 1;
-			continue;
-
-		case 1:	/* Constraint */
-			state = 2;
-			if (!expr || expr->type != EXPR_STRING) {
-				sparse_error(expr ? expr->pos : stmt->pos, "asm input constraint is not a string");
-				*THIS_ADDRESS(expr) = NULL;
-				continue;
-			}
+		/* Expression */
+		expr = op->expr;
+		if (!evaluate_expression(expr))
+			return;
+		if (!lvalue_expression(expr))
+			warning(expr->pos, "asm output is not an lvalue");
+		evaluate_assign_to(expr, expr->ctype);
+	} END_FOR_EACH_PTR(op);
+
+	FOR_EACH_PTR(stmt->asm_inputs, op) {
+		/* Identifier */
+
+		/* Constraint */
+		expr = op->constraint;
+		if (!expr || expr->type != EXPR_STRING) {
+			sparse_error(expr ? expr->pos : stmt->pos, "asm input constraint is not a string");
+			op->constraint = NULL;
+		} else
 			verify_input_constraint(expr, expr->string->data);
-			continue;
 
-		case 2: /* Expression */
-			state = 0;
-			if (!evaluate_expression(expr))
-				return;
-			continue;
-		}
-	} END_FOR_EACH_PTR(expr);
+		/* Expression */
+		if (!evaluate_expression(op->expr))
+			return;
+	} END_FOR_EACH_PTR(op);
 
 	FOR_EACH_PTR(stmt->asm_clobbers, expr) {
 		if (!expr) {
diff --git a/expand.c b/expand.c
index f436b5b50..3c6726aa2 100644
--- a/expand.c
+++ b/expand.c
@@ -1048,6 +1048,9 @@ static int expand_expression(struct expression *expr)
 	case EXPR_OFFSETOF:
 		expression_error(expr, "internal front-end error: sizeof in expansion?");
 		return UNSAFE;
+	case EXPR_ASM_OPERAND:
+		expression_error(expr, "internal front-end error: ASM_OPERAND in expansion?");
+		return UNSAFE;
 	}
 	return SIDE_EFFECTS;
 }
diff --git a/expression.h b/expression.h
index d0f3ac925..b7095640e 100644
--- a/expression.h
+++ b/expression.h
@@ -64,6 +64,7 @@ enum expression_type {
 	EXPR_FVALUE,
 	EXPR_SLICE,
 	EXPR_OFFSETOF,
+	EXPR_ASM_OPERAND,
 };
 
 enum {
@@ -173,6 +174,12 @@ struct expression {
 				struct expression *index;
 			};
 		};
+		// EXPR_ASM_OPERAND
+		struct {
+			struct ident *name;
+			struct expression *constraint;
+			struct expression *expr;
+		};
 	};
 };
 
diff --git a/inline.c b/inline.c
index a3002c6bd..012fb379a 100644
--- a/inline.c
+++ b/inline.c
@@ -271,6 +271,12 @@ static struct expression * copy_expression(struct expression *expr)
 		}
 		break;
 	}
+	case EXPR_ASM_OPERAND: {
+		expr = dup_expression(expr);
+		expr->constraint = copy_expression(expr->constraint);
+		expr->expr = copy_expression(expr->expr);
+		break;
+	}
 	default:
 		warning(expr->pos, "trying to copy expression type %d", expr->type);
 	}
@@ -281,20 +287,9 @@ static struct expression_list *copy_asm_constraints(struct expression_list *in)
 {
 	struct expression_list *out = NULL;
 	struct expression *expr;
-	int state = 0;
 
 	FOR_EACH_PTR(in, expr) {
-		switch (state) {
-		case 0: /* identifier */
-		case 1: /* constraint */
-			state++;
-			add_expression(&out, expr);
-			continue;
-		case 2: /* expression */
-			state = 0;
-			add_expression(&out, copy_expression(expr));
-			continue;
-		}
+		add_expression(&out, copy_expression(expr));
 	} END_FOR_EACH_PTR(expr);
 	return out;
 }
diff --git a/linearize.c b/linearize.c
index ba76397ea..905b473e7 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1805,12 +1805,10 @@ static void add_asm_output(struct entrypoint *ep, struct instruction *insn, stru
 
 static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement *stmt)
 {
-	int state;
 	struct expression *expr;
 	struct instruction *insn;
 	struct asm_rules *rules;
 	const char *constraint;
-	struct ident *ident;
 
 	insn = alloc_instruction(OP_ASM, 0);
 	expr = stmt->asm_string;
@@ -1824,49 +1822,17 @@ static pseudo_t linearize_asm_statement(struct entrypoint *ep, struct statement
 	insn->asm_rules = rules;
 
 	/* Gather the inputs.. */
-	state = 0;
-	ident = NULL;
-	constraint = NULL;
 	FOR_EACH_PTR(stmt->asm_inputs, expr) {
-		switch (state) {
-		case 0:	/* Identifier */
-			state = 1;
-			ident = (struct ident *)expr;
-			continue;
-
-		case 1:	/* Constraint */
-			state = 2;
-			constraint = expr ? expr->string->data : "";
-			continue;
-
-		case 2:	/* Expression */
-			state = 0;
-			add_asm_input(ep, insn, expr, constraint, ident);
-		}
+		constraint = expr->constraint ? expr->constraint->string->data : "";
+		add_asm_input(ep, insn, expr->expr, constraint, expr->name);
 	} END_FOR_EACH_PTR(expr);
 
 	add_one_insn(ep, insn);
 
 	/* Assign the outputs */
-	state = 0;
-	ident = NULL;
-	constraint = NULL;
 	FOR_EACH_PTR(stmt->asm_outputs, expr) {
-		switch (state) {
-		case 0:	/* Identifier */
-			state = 1;
-			ident = (struct ident *)expr;
-			continue;
-
-		case 1:	/* Constraint */
-			state = 2;
-			constraint = expr ? expr->string->data : "";
-			continue;
-
-		case 2:
-			state = 0;
-			add_asm_output(ep, insn, expr, constraint, ident);
-		}
+		constraint = expr->constraint ? expr->constraint->string->data : "";
+		add_asm_output(ep, insn, expr->expr, constraint, expr->name);
 	} END_FOR_EACH_PTR(expr);
 
 	return VOID;
diff --git a/parse.c b/parse.c
index 02a55a745..8407eb855 100644
--- a/parse.c
+++ b/parse.c
@@ -1929,24 +1929,20 @@ static struct token *expression_statement(struct token *token, struct expression
 static struct token *parse_asm_operands(struct token *token, struct statement *stmt,
 	struct expression_list **inout)
 {
-	struct expression *expr;
-
 	/* Allow empty operands */
 	if (match_op(token->next, ':') || match_op(token->next, ')'))
 		return token->next;
 	do {
-		struct ident *ident = NULL;
+		struct expression *op = alloc_expression(token->pos, EXPR_ASM_OPERAND);
 		if (match_op(token->next, '[') &&
 		    token_type(token->next->next) == TOKEN_IDENT &&
 		    match_op(token->next->next->next, ']')) {
-			ident = token->next->next->ident;
+			op->name = token->next->next->ident;
 			token = token->next->next->next;
 		}
-		add_expression(inout, (struct expression *)ident); /* UGGLEE!!! */
-		token = primary_expression(token->next, &expr);
-		add_expression(inout, expr);
-		token = parens_expression(token, &expr, "in asm parameter");
-		add_expression(inout, expr);
+		token = primary_expression(token->next, &op->constraint);
+		token = parens_expression(token, &op->expr, "in asm parameter");
+		add_expression(inout, op);
 	} while (match_op(token, ','));
 	return token;
 }
diff --git a/show-parse.c b/show-parse.c
index d365d737f..f97619e69 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -1169,6 +1169,9 @@ int show_expression(struct expression *expr)
 	case EXPR_TYPE:
 		warning(expr->pos, "unable to show type expression");
 		return 0;
+	case EXPR_ASM_OPERAND:
+		warning(expr->pos, "unable to show asm operand expression");
+		return 0;
 	}
 	return 0;
 }
-- 
2.14.0

