From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 02/13] expression: examine constness of casts at evaluation only
Date: Mon, 25 Jan 2016 15:51:03 +0100
Message-ID: <87lh7dg1bc.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33251 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217AbcAYOvG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 09:51:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id u188so11756292wmu.0
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 06:51:06 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the propagation of expressions' constness flags through
cast expressions is done in two steps:
- Several flags are speculatively set at cast expression parsing time
- and possibly cleared again at evaluation time.

Set aside this unfortunate split of code, the early propagation of
constness flags is not able to recognize constant expressions such as
  (int)__builtin_choose_expr(0, 0, 0)
since the final expression to be thrown into the cast is known only
after evaluation.

Move the whole calculation of cast expressions' constness flags to the
evaluation phase.

Introduce support for tracking arithmetic constness propagation through
cast expressions.

Introduce support for recognizing address constants created by casting
an integer constant to pointer type.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                  | 42 ++++++++++++++++++++++++++++++------------
 expression.c                | 19 -------------------
 validation/constexpr-cast.c | 25 +++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 validation/constexpr-cast.c

diff --git a/evaluate.c b/evaluate.c
index 0cf85ae..11917ee 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -323,7 +323,6 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	}
 
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
-	expr->flags = old->flags;
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
@@ -2742,17 +2741,36 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	/* cast to non-numeric type -> not an arithmetic expression */
-	if (!(class1 & TYPE_NUM))
-		expr_clear_flag(&expr->flags, EXPR_FLAG_ARITH_CONST_EXPR);
-	/* cast to float type -> not an integer constant expression */
-	else if (class1 & TYPE_FLOAT)
-		expr_clear_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
-	/* if argument turns out to be not an integer constant expression *and*
-	   it was not a floating literal to start with -> too bad */
-	else if (!(target->flags &
-			(EXPR_FLAG_INT_CONST_EXPR | EXPR_FLAG_FP_CONST)))
-		expr_clear_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
+	if (!(class1 & TYPE_NUM)) {
+		/*
+		 * Casts of integer literals to pointer type yield
+		 * address constants [6.6(9)].
+		 */
+		if (class1 & TYPE_PTR &&
+			(target->flags & EXPR_FLAG_INT_CONST)) {
+			expr_set_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+		}
+	} else {
+		expr->flags = target->flags;
+		expr_flags_decay_consts(&expr->flags);
+		/*
+		 * Casts to numeric types never result in address
+		 * constants [6.6(9)].
+		 */
+		expr_clear_flag(&expr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
+		/*
+		 * Cast to float type -> not an integer constant
+		 * expression [6.6(6)].
+		 */
+		if (class1 & TYPE_FLOAT)
+			expr_clear_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
+		/*
+		 * Casts of float literals to integer type results in
+		 * a constant integer expression [6.6(6)].
+		 */
+		else if (target->flags & EXPR_FLAG_FP_CONST)
+			expr_set_flag(&expr->flags, EXPR_FLAG_INT_CONST_EXPR);
+	}
 
 	/*
 	 * You can always throw a value away by casting to
diff --git a/expression.c b/expression.c
index eccdb5a..33f4581 100644
--- a/expression.c
+++ b/expression.c
@@ -725,25 +725,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-
-			cast->flags = v->flags;
-			expr_flags_decay_consts(&cast->flags);
-			/*
-			 * Up to now, we missed the (int).0 case here
-			 * which should really get a
-			 * EXPR_FLAG_INT_CONST_EXPR marker. Also,
-			 * conversion to non-numeric types is not
-			 * properly reflected up to this point.
-			 * However, we do not know until evaluation.
-			 * For the moment, in order to preserve
-			 * semantics, speculatively set
-			 * EXPR_FLAG_INT_CONST_EXPR if
-			 * EXPR_FLAG_FP_CONST is set. evaluate_cast()
-			 * will unset inappropriate flags again after
-			 * examining type information.
-			 */
-			if (v->flags & EXPR_FLAG_FP_CONST)
-				cast->flags |= EXPR_FLAG_INT_CONST_EXPR;
 			return token;
 		}
 	}
diff --git a/validation/constexpr-cast.c b/validation/constexpr-cast.c
new file mode 100644
index 0000000..2706961
--- /dev/null
+++ b/validation/constexpr-cast.c
@@ -0,0 +1,25 @@
+static int a[] = {
+	[(int)0] = 0,		// OK
+	[(int)(int)0] = 0,	// OK
+	[(int)0.] = 0,		// OK
+	[(int)(int)0.] = 0,	// OK
+	[(int)__builtin_choose_expr(0, 0, 0)] = 0,	// OK
+	[(int)__builtin_choose_expr(0, 0, 0.)] = 0,	// OK
+
+	[(int)(float)0] = 0,	// KO
+	[(int)(float)0.] = 0,	// KO
+
+	[(int)(void*)0] = 0,	// KO
+	[(int)(void*)0.] = 0,	// KO
+
+};
+/*
+ * check-name: Expression constness propagation in casts
+ *
+ * check-error-start
+constexpr-cast.c:9:11: error: bad integer constant expression
+constexpr-cast.c:10:11: error: bad integer constant expression
+constexpr-cast.c:12:11: error: bad integer constant expression
+constexpr-cast.c:13:11: error: bad integer constant expression
+ * check-error-end
+ */
-- 
2.7.0

