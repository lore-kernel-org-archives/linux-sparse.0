From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 4/9] evaluate/expand context expressions
Date: Thu, 29 May 2008 10:54:06 +0200
Message-ID: <20080529085515.274212000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45686 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbYE2I6e (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 04:58:34 -0400
Content-Disposition: inline; filename=005-bugfix-context-stmt.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

But still allow having a standalone symbol as the context
expression, also evaluate the context change/requirement
directly in the parser and pass them up as integers. Also
fixes a number of bugs e.g. in the expression copier and
a segfault when the default context is used as such:
   __context__(1,1);

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 evaluate.c           |    9 ++++++++-
 expand.c             |    2 +-
 inline.c             |   19 ++++++++++++-------
 linearize.c          |   17 +++--------------
 parse.c              |   22 +++++++++++++---------
 parse.h              |    6 ++++--
 validation/context.c |   28 ++++++++++++++++++++++++++++
 7 files changed, 69 insertions(+), 34 deletions(-)

--- sparse.orig/evaluate.c	2008-05-11 02:41:01.000000000 +0200
+++ sparse/evaluate.c	2008-05-29 10:21:27.000000000 +0200
@@ -3356,7 +3356,14 @@ struct symbol *evaluate_statement(struct
 		evaluate_asm_statement(stmt);
 		return NULL;
 	case STMT_CONTEXT:
-		evaluate_expression(stmt->expression);
+		/*
+		 * If this is an unknown symbol accept it as-is
+		 * as a context name.
+		 */
+		if (stmt->context &&
+		    (stmt->context->type != EXPR_SYMBOL ||
+		     stmt->context->symbol))
+			evaluate_expression(stmt->context);
 		return NULL;
 	case STMT_RANGE:
 		evaluate_expression(stmt->range_expression);
--- sparse.orig/expand.c	2008-05-11 02:41:01.000000000 +0200
+++ sparse/expand.c	2008-05-29 10:21:27.000000000 +0200
@@ -1169,7 +1169,7 @@ static int expand_statement(struct state
 		/* FIXME! Do the asm parameter evaluation! */
 		break;
 	case STMT_CONTEXT:
-		expand_expression(stmt->expression);
+		expand_expression(stmt->context);
 		break;
 	case STMT_RANGE:
 		expand_expression(stmt->range_expression);
--- sparse.orig/inline.c	2008-05-11 02:41:00.000000000 +0200
+++ sparse/inline.c	2008-05-29 10:21:27.000000000 +0200
@@ -328,7 +328,18 @@ static struct statement *copy_one_statem
 		stmt = newstmt;
 		break;
 	}
-	case STMT_CONTEXT:
+	case STMT_CONTEXT: {
+		struct expression *expr = copy_expression(stmt->context);
+		struct statement *newstmt;
+		if (expr == stmt->context)
+			break;
+		newstmt = dup_statement(stmt);
+		newstmt->context = expr;
+		newstmt->change = stmt->change;
+		newstmt->required = stmt->required;
+		stmt = newstmt;
+		break;
+	}
 	case STMT_EXPRESSION: {
 		struct expression *expr = copy_expression(stmt->expression);
 		struct statement *newstmt;
@@ -336,12 +347,6 @@ static struct statement *copy_one_statem
 			break;
 		newstmt = dup_statement(stmt);
 		newstmt->expression = expr;
-		if (stmt->required) {
-			expr = copy_expression(stmt->required);
-			if (expr == stmt->required)
-				break;
-			newstmt->required = expr;
-		}
 		stmt = newstmt;
 		break;
 	}
--- sparse.orig/linearize.c	2008-05-29 10:15:40.000000000 +0200
+++ sparse/linearize.c	2008-05-29 10:21:28.000000000 +0200
@@ -1753,22 +1753,11 @@ static pseudo_t linearize_inlined_call(s
 static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 {
 	struct instruction *insn = alloc_instruction(OP_CONTEXT, 0);
-	struct expression *expr = stmt->expression;
-	int value = 0;
 
-	if (expr->type == EXPR_VALUE)
-		value = expr->value;
+	insn->increment = stmt->change;
+	insn->inc_false = stmt->change;
 
-	insn->increment = value;
-	insn->inc_false = value;
-
-	expr = stmt->required;
-	value = 0;
-
-	if (expr && expr->type == EXPR_VALUE)
-		value = expr->value;
-
-	insn->required = value;
+	insn->required = stmt->required;
 	insn->exact = stmt->exact;
 
 	insn->context_expr = stmt->context;
--- sparse.orig/parse.c	2008-05-29 10:15:40.000000000 +0200
+++ sparse/parse.c	2008-05-29 10:21:28.000000000 +0200
@@ -1859,9 +1859,7 @@ static struct token *_parse_context_stat
 		token = token->next;
 	}
 
-	stmt->expression = args[0];
 	stmt->context = NULL;
-
 	stmt->exact = exact;
 
 	switch (argc) {
@@ -1869,21 +1867,27 @@ static struct token *_parse_context_stat
 		sparse_error(token->pos, "__context__ statement needs argument(s)");
 		return token;
 	case 1:
-		/* already done */
+		stmt->change = get_expression_value(args[0]);
 		break;
 	case 2:
-		if (args[0]->type != STMT_EXPRESSION) {
+		/*
+		 * We should actually check whether we can evalulate
+		 * it as a constant expression and if so use as the
+		 * 'change' value. I hope nobody gives a calculation
+		 * for the number.
+		 */
+		if (args[0]->type != EXPR_VALUE) {
 			stmt->context = args[0];
-			stmt->expression = args[1];
+			stmt->change = get_expression_value(args[1]);
 		} else {
-			stmt->expression = args[0];
-			stmt->required = args[1];
+			stmt->change = get_expression_value(args[0]);
+			stmt->required = get_expression_value(args[1]);
 		}
 		break;
 	case 3:
 		stmt->context = args[0];
-		stmt->expression = args[1];
-		stmt->required = args[2];
+		stmt->change = get_expression_value(args[1]);
+		stmt->required = get_expression_value(args[2]);
 		break;
 	default:
 		sparse_error(token->pos, "too many arguments for __context__ statement");
--- sparse.orig/parse.h	2008-05-29 10:15:40.000000000 +0200
+++ sparse/parse.h	2008-05-29 10:21:27.000000000 +0200
@@ -39,10 +39,12 @@ struct statement {
 			struct symbol *label;
 			struct statement *label_statement;
 		};
-		struct { /* __context__ */
+		struct { /* expression */
 			struct expression *expression;
+		};
+		struct { /* __context__ */
 			struct expression *context;
-			struct expression *required;
+			int change, required;
 			int exact;
 		};
 		struct /* return_statement */ {
--- sparse.orig/validation/context.c	2008-05-29 10:14:30.000000000 +0200
+++ sparse/validation/context.c	2008-05-29 10:18:23.000000000 +0200
@@ -395,6 +395,32 @@ static void good_require_caller(void)
     __context__(TEST,-1,1);
 }
 
+static void areq(void) __attribute__((context(1,2)))
+{
+	__context__(1,1);
+}
+
+static void good_reqlock(void)
+{
+	a();
+	areq();
+	r();
+	r();
+}
+
+static void warn_reqlock(void)
+{
+	areq();
+	r();
+}
+
+
+static void dummy1(void) __attribute__((context(p,0,1)))
+{
+        void *p;
+	__context__(p,1);
+}
+
 /*
  * check-name: Check -Wcontext
  *
@@ -433,5 +459,7 @@ context.c:360:10: warning: context probl
 context.c:360:10:    default context: wanted >= 1, got 0
 context.c:380:12: warning: context imbalance in 'warn_conditional': wrong count at exit
 context.c:380:12:    default context: wanted 0, got 1
+context.c:413:6: warning: context problem in 'warn_reqlock': 'areq' expected different context
+context.c:413:6:    default context: wanted >= 1, got 0
  * check-error-end
  */

-- 

