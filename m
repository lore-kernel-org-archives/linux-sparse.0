From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 11/16] Evaluate/expand context expressions
Date: Fri, 19 Dec 2008 01:34:05 +0300
Message-ID: <20081218223355.23692.35.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:12371 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYLRWYu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:24:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so511368ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:24:50 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

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

diff --git a/evaluate.c b/evaluate.c
index f976645..0c86295 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3364,7 +3364,14 @@ struct symbol *evaluate_statement(struct statement *stmt)
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
diff --git a/expand.c b/expand.c
index 3e962d1..dece314 100644
--- a/expand.c
+++ b/expand.c
@@ -1169,7 +1169,7 @@ static int expand_statement(struct statement *stmt)
 		/* FIXME! Do the asm parameter evaluation! */
 		break;
 	case STMT_CONTEXT:
-		expand_expression(stmt->expression);
+		expand_expression(stmt->context);
 		break;
 	case STMT_RANGE:
 		expand_expression(stmt->range_expression);
diff --git a/inline.c b/inline.c
index 09d176a..3e984c3 100644
--- a/inline.c
+++ b/inline.c
@@ -328,7 +328,18 @@ static struct statement *copy_one_statement(struct statement *stmt)
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
@@ -336,12 +347,6 @@ static struct statement *copy_one_statement(struct statement *stmt)
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
diff --git a/linearize.c b/linearize.c
index 9f5628a..8e9775d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1755,22 +1755,11 @@ static pseudo_t linearize_inlined_call(struct entrypoint *ep, struct statement *
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
diff --git a/parse.c b/parse.c
index 2ac3d0e..fdb7efb 100644
--- a/parse.c
+++ b/parse.c
@@ -1860,9 +1860,7 @@ static struct token *_parse_context_statement(struct token *token, struct statem
 		token = token->next;
 	}
 
-	stmt->expression = args[0];
 	stmt->context = NULL;
-
 	stmt->exact = exact;
 
 	switch (argc) {
@@ -1870,21 +1868,27 @@ static struct token *_parse_context_statement(struct token *token, struct statem
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
diff --git a/parse.h b/parse.h
index ae50720..fe714b6 100644
--- a/parse.h
+++ b/parse.h
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
diff --git a/validation/context.c b/validation/context.c
index e8bb125..2c32ef3 100644
--- a/validation/context.c
+++ b/validation/context.c
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
@@ -433,5 +459,7 @@ context.c:360:10: warning: context problem in 'warn_huge_switch': 'r' expected d
 context.c:360:10:    default context: wanted >= 1, got 0
 context.c:380:12: warning: context imbalance in 'warn_conditional': wrong count at exit
 context.c:380:12:    default context: wanted 0, got 1
+context.c:413:6: warning: context problem in 'warn_reqlock': 'areq' expected different context
+context.c:413:6:    default context: wanted >= 1, got 0
  * check-error-end
  */

