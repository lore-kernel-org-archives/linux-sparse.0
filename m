From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 03/21] expression: examine constness of casts at evaluation only
Date: Mon, 01 Feb 2016 03:31:47 +0100
Message-ID: <878u35jh4c.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33806 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbcBACbu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:31:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so7013344wmp.1
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:31:49 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of cast expressions' constness flags to the
evaluation phase such that expressions like

  (int)__builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                  | 27 ++++++++++++++++++---------
 expression.c                | 21 ---------------------
 expression.h                | 10 ++++++++++
 validation/constexpr-cast.c | 25 +++++++++++++++++++++++++
 4 files changed, 53 insertions(+), 30 deletions(-)
 create mode 100644 validation/constexpr-cast.c

diff --git a/evaluate.c b/evaluate.c
index 7bce4fb..24a7f2f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -323,7 +323,6 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	}
 
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
-	expr->constexpr_flags = old->constexpr_flags;
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
@@ -2745,14 +2744,24 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	/* cast to non-integer type -> not an integer constant expression */
-	if (!is_int(class1))
-		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
-	/* if argument turns out to be not an integer constant expression *and*
-	   it was not a floating literal to start with -> too bad */
-	else if (expr->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR &&
-		!(target->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
-		expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
+	if (class1 & TYPE_NUM) {
+		expr->constexpr_flags = target->constexpr_flags &
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+		/*
+		 * Cast to float type -> not an integer constant
+		 * expression [6.6(6)].
+		 */
+		if (class1 & TYPE_FLOAT)
+			expr->constexpr_flags &=
+				~CONSTEXPR_FLAG_INT_CONST_EXPR_CLEAR_MASK;
+		/*
+		 * Casts of float literals to integer type results in
+		 * a constant integer expression [6.6(6)].
+		 */
+		else if (target->constexpr_flags & CONSTEXPR_FLAG_FP_CONST)
+			expr->constexpr_flags =
+				CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
+	}
 
 	/*
 	 * You can always throw a value away by casting to
diff --git a/expression.c b/expression.c
index f9adab6..759bee8 100644
--- a/expression.c
+++ b/expression.c
@@ -730,27 +730,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-
-			cast->constexpr_flags = v->constexpr_flags &
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
-			/*
-			 * Up to now, we missed the (int).0 case here
-			 * which should really get a
-			 * CONSTEXPR_FLAG_INT_CONST_EXPR marker. Also,
-			 * conversion to non-numeric types is not
-			 * properly reflected up to this point.
-			 * However, we do not know until evaluation.
-			 * For the moment, in order to preserve
-			 * semantics, speculatively set
-			 * CONSTEXPR_FLAG_INT_CONST_EXPR if
-			 * CONSTEXPR_FLAG_FP_CONST is
-			 * set. evaluate_cast() will unset
-			 * inappropriate flags again after examining
-			 * type information.
-			 */
-			if (v->constexpr_flags & CONSTEXPR_FLAG_FP_CONST)
-				cast->constexpr_flags |=
-					CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK;
 			return token;
 		}
 	}
diff --git a/expression.h b/expression.h
index 8a943a4..408382e 100644
--- a/expression.h
+++ b/expression.h
@@ -119,6 +119,16 @@ enum constexpr_flag {
 	(CONSTEXPR_FLAG_CHAR_CONST | CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK)
 
 /*
+ * not an integer constant expression => neither of integer,
+ * enumeration and character constant
+*/
+#define CONSTEXPR_FLAG_INT_CONST_EXPR_CLEAR_MASK \
+	(CONSTEXPR_FLAG_INT_CONST_EXPR |	 \
+		CONSTEXPR_FLAG_INT_CONST |	 \
+		CONSTEXPR_FLAG_ENUM_CONST |	 \
+		CONSTEXPR_FLAG_CHAR_CONST)
+
+/*
  * Remove any "Constant" [6.4.4] flag, but retain the "constant
  * expression" [6.6] flags.
  */
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

