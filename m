From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix typing error in compound assignment
Date: Wed,  7 Dec 2016 15:33:42 +0100
Message-ID: <20161207143342.88825-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34338 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbcLGOef (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 09:34:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id g23so28267988wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 06:33:58 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

A compound assignment like, for example:
	x += a;
should have the same effect as the operation followed by the
assignment except that the left side should only be evaluated
once. So the statement above (assuming 'x' free of side-effects)
should have the same effect as:
	x = x + a;

In particular, the usual conversions should applied. So, if
the type of 'x' and 'a' is, respectively, 'int' and 'long',
the statement above should be equivalent to:
	x = (int) ((long) x + a);

But what is really done currently is something like:
	x = x + (typeof(x)) a;
In other words, the left-hand side is casted to the same type as the
rhs and the operation is always done with this type, neglecting the
usual conversions and thus forcing the operation to always be done
with the rhs type, here 'int' instead of 'long'.

The patch fix this by first calculating the type corresponding to
the usual conversion and then casting the right-hand side to this
type, which is fine, since it's a rvalue anyway.
Later steps will then use the rhs type when doing the operation.
On the example above, the cast will be a no-op and the operation will
be done with the correct type:
	x = x + (long) a;
which, at linearization, will become:
	x = (int) ((long) x + (long) a);

If the types where in the other order, the result will also be done
with the correct type:
	long a;
	int x;
	...
	a += x;
will become:
	a = a + (long) x;
and, at linearization:
	a = (int) ((long) a + (long) x);

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        |  5 ++++-
 linearize.c                       | 10 ++++++----
 validation/compound-assign-type.c | 15 +++++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 validation/compound-assign-type.c

diff --git a/evaluate.c b/evaluate.c
index e350c0c0..0ea3e866 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1258,7 +1258,7 @@ static int evaluate_assign_op(struct expression *expr)
 			if (!restricted_value(expr->right, t))
 				return 1;
 		} else if (!(sclass & TYPE_RESTRICT))
-			goto Cast;
+			goto usual;
 		/* source and target would better be identical restricted */
 		if (t == s)
 			return 1;
@@ -1281,6 +1281,9 @@ static int evaluate_assign_op(struct expression *expr)
 	expression_error(expr, "invalid assignment");
 	return 0;
 
+usual:
+	target = usual_conversions(op, expr->left, expr->right,
+				tclass, sclass, target, source);
 Cast:
 	expr->right = cast_to(expr->right, target);
 	return 1;
diff --git a/linearize.c b/linearize.c
index c6ada1e8..e0166128 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1154,6 +1154,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 	struct access_data ad = { NULL, };
 	struct expression *target = expr->left;
 	struct expression *src = expr->right;
+	struct symbol *ctype;
 	pseudo_t value;
 
 	value = linearize_expression(ep, src);
@@ -1179,10 +1180,11 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 		if (!src)
 			return VOID;
 
-		oldvalue = cast_pseudo(ep, oldvalue, src->ctype, expr->ctype);
-		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], src->ctype);
-		dst = add_binary_op(ep, src->ctype, opcode, oldvalue, value);
-		value = cast_pseudo(ep, dst, expr->ctype, src->ctype);
+		ctype = src->ctype;
+		oldvalue = cast_pseudo(ep, oldvalue, target->ctype, ctype);
+		opcode = opcode_sign(op_trans[expr->op - SPECIAL_BASE], ctype);
+		dst = add_binary_op(ep, ctype, opcode, oldvalue, value);
+		value = cast_pseudo(ep, dst, ctype, expr->ctype);
 	}
 	value = linearize_store_gen(ep, value, &ad);
 	finish_address_gen(ep, &ad);
diff --git a/validation/compound-assign-type.c b/validation/compound-assign-type.c
new file mode 100644
index 00000000..8e7efb4a
--- /dev/null
+++ b/validation/compound-assign-type.c
@@ -0,0 +1,15 @@
+static int foo(int x, long a)
+{
+	x += a;
+	return x;
+}
+
+/*
+ * check-name: compound-assign-type
+ * check-command: test-linearize -m64 $file
+ * check-output-ignore
+ *
+ * check-output-excludes: add\\.32
+ * check-output-contains: add\\.64
+ * check-output-contains: scast\\.64
+ */
-- 
2.10.2

