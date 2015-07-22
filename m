From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 02/13] expression: examine constness of casts at evaluation only
Date: Thu, 23 Jul 2015 01:12:47 +0200
Message-ID: <87mvynkcr4.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34739 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbGVXMu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:12:50 -0400
Received: by wibud3 with SMTP id ud3so435106wib.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:12:49 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id fs8sm4604049wjb.7.2015.07.22.16.12.47
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:12:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c                  | 45 +++++++++++++++++++++++++++++++++------------
 expression.c                | 18 ------------------
 validation/constexpr-cast.c | 25 +++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 30 deletions(-)
 create mode 100644 validation/constexpr-cast.c

diff --git a/evaluate.c b/evaluate.c
index 7324fb4..90d6da0 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -323,7 +323,6 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	}
 
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
-	expr->flags = old->flags;
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
@@ -2739,18 +2738,40 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	/* cast to non-numeric type -> not an arithmetic expression */
-	if (!(class1 & TYPE_NUM))
+	if (!(class1 & TYPE_NUM)) {
+		/*
+		 * Casts of integer literals to pointer type yield
+		 * address constants [6.6(9)].
+		 */
+		if (class1 & TYPE_PTR &&
+			(target->flags & EXPR_FLAG_INT_CONST)) {
+			expr->flags |=
+				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
+
+		}
+	} else {
+		expr->flags |= expr_flags_decay_consts(target->flags);
+		/*
+		 * Casts to numeric types never result in address
+		 * constants [6.6(9)].
+		 */
 		expr->flags &=
-			~expr_clear_flag_mask(EXPR_FLAG_ARITH_CONST_EXPR);
-	/* cast to float type -> not an integer constant expression */
-	else if (class1 & TYPE_FLOAT)
-		expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
-	/* if argument turns out to be not an integer constant expression *and*
-	   it was not a floating literal to start with -> too bad */
-	else if (!(target->flags &
-			(EXPR_FLAG_INT_CONST_EXPR | EXPR_FLAG_FP_CONST)))
-		expr->flags &= ~expr_clear_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+			~expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
+		/*
+		 * Cast to float type -> not an integer constant
+		 * expression [6.6(6)].
+		 */
+		if (class1 & TYPE_FLOAT)
+			expr->flags &=
+				~expr_clear_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+		/*
+		 * Casts of float literals to integer type results in
+		 * a constant integer expression [6.6(6)].
+		 */
+		else if (target->flags & EXPR_FLAG_FP_CONST)
+			expr->flags |=
+				expr_set_flag_mask(EXPR_FLAG_INT_CONST_EXPR);
+	}
 
 	/*
 	 * You can always throw a value away by casting to
diff --git a/expression.c b/expression.c
index 8582dc9..9a0cd8c 100644
--- a/expression.c
+++ b/expression.c
@@ -724,24 +724,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-
-			cast->flags = expr_flags_decay_consts(v->flags);
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
2.4.5

