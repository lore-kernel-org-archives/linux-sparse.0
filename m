From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Sun, 28 Aug 2011 15:14:18 +1200
Message-ID: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51746 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1H1DOe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 23:14:34 -0400
Received: by gxk21 with SMTP id 21so3930802gxk.19
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 20:14:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

Adds a warning when identical expressions are found on both sides of the '&&' operator. This is a common error resulting from copy & paste.

Excludes identical expressions found while preprocessing, so we don't get upset about #if defined(FOO) && defined(BAR), which happens all the time, and is perfectly valid.

Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
---
 evaluate.c                                |  133 +++++++++++++++++++++++++++++
 validation/check_identical_exprs_on_and.c |   30 +++++++
 2 files changed, 163 insertions(+), 0 deletions(-)
 create mode 100644 validation/check_identical_exprs_on_and.c

diff --git a/evaluate.c b/evaluate.c
index f7a5678..4914442 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -853,8 +853,141 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 	return ctype;
 }
 
+static int str_equal(struct string *a, struct string *b)
+{
+	return a->length == b->length &&
+		!memcmp(a->data, b->data, a->length);
+}
+
+static int ident_equal(struct ident *a, struct ident *b)
+{
+	/* only correct when used in the context of expr_equiv.
+		should compare symbols? for general case? */
+	return a->len == b->len &&
+		!memcmp(a->name, b->name, a->len);
+}
+
+/* expr_equiv and expr_list_equiv are mutually recursive */
+static int expr_equiv(struct expression *lhs, struct expression *rhs);
+
+static int expr_list_equiv(struct expression_list *lhs,
+			   struct expression_list *rhs)
+{
+	int l_length = expression_list_size(lhs);
+	int r_length = expression_list_size(rhs);
+	struct expression **l_items, **r_items;
+	int i;
+
+	if (l_length != r_length)
+		return 0;
+
+	l_items = alloca(sizeof( *l_items ) * l_length);
+	r_items = alloca(sizeof( *r_items ) * r_length);
+
+	linearize_ptr_list((struct ptr_list *)lhs, (void **)l_items, l_length);
+	linearize_ptr_list((struct ptr_list *)rhs, (void **)r_items, r_length);
+
+	for (i = 0; i < l_length; i++) {
+		if (!expr_equiv(l_items[i], r_items[i]))
+			return 0;
+	}
+
+	return 1;
+}
+
+int expr_equiv(struct expression *lhs, struct expression *rhs)
+{
+	/* recursively determine if lhs ~ rhs. */
+	if (!lhs || !rhs) return 0;
+
+	if (lhs->type != rhs->type) return 0;
+	if (lhs->flags != rhs->flags) return 0;
+	if (lhs->op != rhs->op) return 0;
+	if (lhs->ctype != rhs->ctype) return 0;
+
+	switch (lhs->type) {
+	case EXPR_VALUE:
+		return lhs->value == rhs->value &&
+			lhs->taint == rhs->taint;
+	case EXPR_FVALUE:
+		return lhs->fvalue == rhs->fvalue;
+	case EXPR_STRING:
+		return lhs->wide == rhs->wide &&
+			str_equal(lhs->string, rhs->string);
+/*	case EXPR_UNOP:	*/	/* this is mentioned in the union, but doesn't
+				actually exist */
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		return lhs->op_value == rhs->op_value &&
+			expr_equiv(lhs->unop, rhs->unop);
+	case EXPR_SYMBOL:
+	case EXPR_TYPE:
+		return lhs->symbol == rhs->symbol;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+	case EXPR_ASSIGNMENT:
+		return expr_equiv(lhs->left, rhs->left) &&
+			expr_equiv(lhs->right, rhs->right);
+	case EXPR_DEREF:
+		return expr_equiv(lhs->deref, rhs->deref) &&
+			ident_equal(lhs->member, rhs->member);
+	case EXPR_SLICE:
+		return expr_equiv(lhs->base, rhs->base) &&
+			lhs->r_bitpos == rhs->r_bitpos &&
+			lhs->r_nrbits == rhs->r_nrbits;
+	case EXPR_CAST:
+	case EXPR_SIZEOF:
+		return lhs->cast_type == rhs->cast_type &&
+			expr_equiv(lhs->cast_expression,
+				rhs->cast_expression);
+	case EXPR_CONDITIONAL:
+	case EXPR_SELECT:
+		return expr_equiv(lhs->conditional, rhs->conditional) &&
+			expr_equiv(lhs->cond_true, rhs->cond_true) &&
+			expr_equiv(lhs->cond_false, rhs->cond_false);
+	case EXPR_CALL:
+		return expr_equiv(lhs->fn, rhs->fn) &&
+			expr_list_equiv(lhs->args, rhs->args);
+	case EXPR_LABEL:
+		return lhs->label_symbol == rhs->label_symbol;
+	case EXPR_INITIALIZER:
+		return expr_list_equiv(lhs->expr_list, rhs->expr_list);
+	case EXPR_IDENTIFIER:
+		return ident_equal(lhs->expr_ident, rhs->expr_ident) &&
+			lhs->field == rhs->field &&
+			expr_equiv(lhs->ident_expression,
+				rhs->ident_expression);
+	case EXPR_INDEX:
+		return lhs->idx_from == rhs->idx_from &&
+			lhs->idx_to == rhs->idx_to &&
+			expr_equiv(lhs->idx_expression, rhs->idx_expression);
+	case EXPR_POS:
+		return lhs->init_offset == rhs->init_offset &&
+			lhs->init_nr == rhs->init_nr &&
+			expr_equiv(lhs->init_expr, rhs->init_expr);
+	case EXPR_OFFSETOF:
+		return lhs->in == rhs->in &&
+			expr_equiv(lhs->down, rhs->down);
+
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+
 static struct symbol *evaluate_logical(struct expression *expr)
 {
+	if (!preprocessing) {
+		if (expr->op == SPECIAL_LOGICAL_AND &&
+			expr_equiv(expr->left, expr->right)) {
+			warning(expr->pos, "identical expressions on both "
+				"sides of '&&'");
+		}
+	}
+
 	if (!evaluate_conditional(expr->left, 0))
 		return NULL;
 	if (!evaluate_conditional(expr->right, 0))
diff --git a/validation/check_identical_exprs_on_and.c b/validation/check_identical_exprs_on_and.c
new file mode 100644
index 0000000..6560429
--- /dev/null
+++ b/validation/check_identical_exprs_on_and.c
@@ -0,0 +1,30 @@
+extern void bar(void);
+
+static void foo(void *a, void *b, void *c)
+{
+	if (a && a)	/* should warn */
+		bar();
+
+	if (a && b)	/* should not warn */
+		bar();
+
+	if ((a == b) && (a == b))	/* should warn */
+		bar();
+
+	if ((a == b) && (b == c))	/* should not warn */
+		bar();
+}
+
+/* should not warn */
+#if defined(BLETCHEROUS_PLATFORM) && defined(BROKEN_VERSION_OF_SAME)
+	/* do something suitably bizarre */
+#endif
+
+/*
+ * check-name: A warning should be issued for identical expressions on both sides of the '&&' operator.
+ *
+ * check-error-start
+check_identical_exprs_on_and.c:5:15: warning: identical expressions on both sides of '&&'
+check_identical_exprs_on_and.c:11:22: warning: identical expressions on both sides of '&&'
+ * check-error-end
+ */
-- 
1.7.4.1

