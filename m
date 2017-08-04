From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 1/2] take comma expr in account for constant value
Date: Fri,  4 Aug 2017 18:06:21 +0200
Message-ID: <20170804160622.18260-2-luc.vanoostenryck@gmail.com>
References: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38116 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752242AbdHDQGc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 12:06:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id g32so3284468wrd.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 09:06:32 -0700 (PDT)
In-Reply-To: <20170804160622.18260-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's often the case that we simply need the expr's truth value.

To get the value of an expression or simply if we need to know
if it's a constant value we can use some functions like
get_expression_value() or const_expression_value() depending
on the type of warning needed if the expression is not constant
(for various definition of constant).

However none of these functions take in account the fact that
a comma expression can also have a value known at compile time.

In order to not introduce unwanted change elsewheer in the code,
introduce a new function expr_truth_value() which never warn
but will return -1 if the expr have no known boolean value.

Note: the whole set of functions should be unified to take comma
      expressions in account when needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c     | 30 ++++++++++++++++++++++++++++++
 expression.h |  1 +
 2 files changed, 31 insertions(+)

diff --git a/expand.c b/expand.c
index 5f908c971..f436b5b50 100644
--- a/expand.c
+++ b/expand.c
@@ -1281,6 +1281,36 @@ long long get_expression_value_silent(struct expression *expr)
 	return __get_expression_value(expr, 2);
 }
 
+int expr_truth_value(struct expression *expr)
+{
+	const int saved = conservative;
+	struct symbol *ctype;
+
+	if (!expr)
+		return 0;
+
+	ctype = evaluate_expression(expr);
+	if (!ctype)
+		return -1;
+
+	conservative = 1;
+	expand_expression(expr);
+	conservative = saved;
+
+redo:
+	switch (expr->type) {
+	case EXPR_COMMA:
+		expr = expr->right;
+		goto redo;
+	case EXPR_VALUE:
+		return expr->value != 0;
+	case EXPR_FVALUE:
+		return expr->fvalue != 0;
+	default:
+		return -1;
+	}
+}
+
 int is_zero_constant(struct expression *expr)
 {
 	const int saved = conservative;
diff --git a/expression.h b/expression.h
index 80b3be5f5..d0f3ac925 100644
--- a/expression.h
+++ b/expression.h
@@ -178,6 +178,7 @@ struct expression {
 
 /* Constant expression values */
 int is_zero_constant(struct expression *);
+int expr_truth_value(struct expression *expr);
 long long get_expression_value(struct expression *);
 long long const_expression_value(struct expression *);
 long long get_expression_value_silent(struct expression *expr);
-- 
2.13.2

