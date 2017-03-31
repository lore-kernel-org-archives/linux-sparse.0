From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 03/25] constexpr: examine constness of casts at evaluation only
Date: Fri, 31 Mar 2017 03:44:37 +0200
Message-ID: <20170331014459.9351-4-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34165 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934785AbdCaBqc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so16582640wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:31 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Move the whole calculation of cast expressions' constness flags to the
evaluation phase such that expressions like

  (int)__builtin_choose_expr(0, 0, 0)

can now be recognized as qualifying as integer constant expressions.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                  | 37 +++++++++++++++++++++++++++++--------
 expression.c                | 19 -------------------
 expression.h                |  7 +++++++
 validation/constexpr-cast.c | 25 +++++++++++++++++++++++++
 4 files changed, 61 insertions(+), 27 deletions(-)
 create mode 100644 validation/constexpr-cast.c

diff --git a/evaluate.c b/evaluate.c
index 18f1da8b3..5725e898f 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -271,6 +271,7 @@ warn_for_different_enum_types (struct position pos,
 	}
 }
 
+static int cast_flags(struct expression *expr, struct expression *target);
 static struct symbol *cast_to_bool(struct expression *expr);
 
 /*
@@ -323,10 +324,10 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	}
 
 	expr = alloc_expression(old->pos, EXPR_IMPLIED_CAST);
-	expr->flags = old->flags;
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
+	expr->flags = cast_flags(expr, old);
 
 	if (is_bool_type(type))
 		cast_to_bool(expr);
@@ -2720,6 +2721,32 @@ static struct symbol *cast_to_bool(struct expression *expr)
 	return expr->ctype;
 }
 
+static int cast_flags(struct expression *expr, struct expression *old)
+{
+	struct symbol *t;
+	int class;
+	int flags = CEF_NONE;
+
+	class = classify_type(expr->ctype, &t);
+	if (class & TYPE_NUM) {
+		flags = old->flags & ~CEF_CONST_MASK;
+		/*
+		 * Cast to float type -> not an integer constant
+		 * expression [6.6(6)].
+		 */
+		if (class & TYPE_FLOAT)
+			flags &= ~CEF_CLR_ICE;
+		/*
+		 * Casts of float literals to integer type results in
+		 * a constant integer expression [6.6(6)].
+		 */
+		else if (old->flags & CEF_FLOAT)
+			flags = CEF_SET_ICE;
+	}
+
+	return flags;
+}
+
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
@@ -2768,13 +2795,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 	class1 = classify_type(ctype, &t1);
 
-	/* cast to non-integer type -> not an integer constant expression */
-	if (!is_int(class1))
-		expr->flags = CEF_NONE;
-	/* if argument turns out to be not an integer constant expression *and*
-	   it was not a floating literal to start with -> too bad */
-	else if (expr->flags & CEF_ICE && !(target->flags & CEF_ICE))
-		expr->flags = CEF_NONE;
+	expr->flags = cast_flags(expr, target);
 
 	/*
 	 * You can always throw a value away by casting to
diff --git a/expression.c b/expression.c
index 4189e5f3a..3262cf22c 100644
--- a/expression.c
+++ b/expression.c
@@ -722,25 +722,6 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			if (!v)
 				return token;
 			cast->cast_expression = v;
-
-			cast->flags = v->flags & ~CEF_CONST_MASK;
-			/*
-			 * Up to now, we missed the (int).0 case here
-			 * which should really get a
-			 * CEF_ICE marker. Also,
-			 * conversion to non-numeric types is not
-			 * properly reflected up to this point.
-			 * However, we do not know until evaluation.
-			 * For the moment, in order to preserve
-			 * semantics, speculatively set
-			 * CEF_ICE if
-			 * CEF_FLOAT is
-			 * set. evaluate_cast() will unset
-			 * inappropriate flags again after examining
-			 * type information.
-			 */
-			if (v->flags & CEF_FLOAT)
-				cast->flags |= CEF_SET_ICE;
 			return token;
 		}
 	}
diff --git a/expression.h b/expression.h
index ec94ff4a1..c084783c8 100644
--- a/expression.h
+++ b/expression.h
@@ -120,6 +120,13 @@ enum constexpr_flag {
 	CEF_CONST_MASK = (CEF_INT | CEF_FLOAT | CEF_CHAR),
 };
 
+/*
+ * not an integer constant expression => neither of integer,
+ * enumeration and character constant
+ */
+#define CEF_CLR_ICE \
+	(CEF_ICE | CEF_INT | CEF_ENUM |	CEF_CHAR)
+
 enum {
 	Taint_comma = 1,
 }; /* for expr->taint */
diff --git a/validation/constexpr-cast.c b/validation/constexpr-cast.c
new file mode 100644
index 000000000..27069614c
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
2.12.0

