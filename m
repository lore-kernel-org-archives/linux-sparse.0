From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 2/2] initial work on check for identical exprs on both sides of '&&'; needs more
Date: Wed, 10 Aug 2011 21:07:15 +1200
Message-ID: <1312967235-23817-3-git-send-email-chrisf@ijw.co.nz>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:64086 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab1HJJHx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Aug 2011 05:07:53 -0400
Received: by iye16 with SMTP id 16so813465iye.1
        for <linux-sparse@vger.kernel.org>; Wed, 10 Aug 2011 02:07:52 -0700 (PDT)
In-Reply-To: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

---
 evaluate.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index f8343c2..af0be59 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -853,8 +853,67 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 	return ctype;
 }
 
+static int are_equivalent_expr(struct expression *lhs, struct expression *rhs)
+{
+	/* recursively determine if lhs ~ rhs. */
+	if (!lhs ^ !rhs) return 0;
+
+	if (lhs->type != rhs->type) return 0;
+	if (lhs->flags != rhs->flags) return 0;
+	if (lhs->op != rhs->op) return 0;
+	if (lhs->ctype != rhs->ctype) return 0;
+
+	switch( lhs->type ) {
+	case EXPR_VALUE:
+		if (lhs->value != rhs->value) return 0;
+		if (lhs->taint != rhs->taint) return 0;
+		break;
+	case EXPR_FVALUE:
+		if (lhs->fvalue != rhs->fvalue) return 0;
+		break;
+	case EXPR_STRING:
+		if (lhs->wide != rhs->wide) return 0;
+		if (lhs->string->length != rhs->string->length) return 0;
+		if (memcmp(lhs->string->data, rhs->string->data,
+			lhs->string->length)) return 0;
+		break;
+/*	case EXPR_UNOP:	*/	/* this is mentioned in the union, but doesn't
+				actually exist */
+	case EXPR_PREOP:
+	case EXPR_POSTOP:
+		if (!are_equivalent_expr(lhs->unop, rhs->unop)) return 0;
+		if (lhs->op_value != rhs->op_value) return 0;
+		break;
+	case EXPR_SYMBOL:
+	case EXPR_TYPE:
+		if (lhs->symbol != rhs->symbol) return 0;
+		break;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+	case EXPR_ASSIGNMENT:
+		if (!are_equivalent_expr(lhs->left, rhs->left)) return 0;
+		if (!are_equivalent_expr(lhs->right, rhs->right)) return 0;
+		break;
+
+		/* blah, more... */
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
+	if (expr->op == SPECIAL_LOGICAL_AND &&
+		are_equivalent_expr(expr->left, expr->right)) {
+		warning(expr->pos, "identical expressions on both "
+			"sides of '&&'");
+	}
+
 	if (!evaluate_conditional(expr->left, 0))
 		return NULL;
 	if (!evaluate_conditional(expr->right, 0))
-- 
1.7.4.1

