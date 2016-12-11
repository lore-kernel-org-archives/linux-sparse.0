From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] fix cast to bool
Date: Sun, 11 Dec 2016 22:13:26 +0100
Message-ID: <20161211211328.26735-2-luc.vanoostenryck@gmail.com>
References: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33039 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbcLKVQC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Dec 2016 16:16:02 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so7106934wmu.0
        for <linux-sparse@vger.kernel.org>; Sun, 11 Dec 2016 13:16:01 -0800 (PST)
In-Reply-To: <20161211211328.26735-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Section 6.3.1.2 of the C standard requires that cast to bool
to be done differently than casting to others integer types:
    The casted value need to be compared against '0',
    if it compares equal the result is 0, otherwise the result is 1.

But currently, it's treated as the others integer casts: the value is
truncated, keeping only the least significant bit.

For example, when using test-linearize on the following code:
	_Bool foo(int a) { return (_Bool) a; }

this instruction is emitted:
	scast.1     %r2 <- (32) %arg1
while the correct one is:
	setne.1     %r2 <- %arg1, $0

Fix this for explicit and implicit casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                      | 32 ++++++++++++++++++++++++++++++++
 validation/bool-cast-bad.c      | 27 +++++++++++++++++++++++++++
 validation/bool-cast-explicit.c | 26 ++++++++++++++++++++++++++
 validation/bool-cast-implicit.c | 28 ++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+)
 create mode 100644 validation/bool-cast-bad.c
 create mode 100644 validation/bool-cast-explicit.c
 create mode 100644 validation/bool-cast-implicit.c

diff --git a/evaluate.c b/evaluate.c
index e350c0c0..61fc8f06 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -273,6 +273,8 @@ warn_for_different_enum_types (struct position pos,
 	}
 }
 
+static struct symbol *cast_to_bool(struct expression *expr);
+
 /*
  * This gets called for implicit casts in assignments and
  * integer promotion. We often want to try to move the
@@ -327,6 +329,10 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
 	expr->ctype = type;
 	expr->cast_type = type;
 	expr->cast_expression = old;
+
+	if (is_bool_type(type))
+		cast_to_bool(expr);
+
 	return expr;
 }
 
@@ -2686,6 +2692,28 @@ static void evaluate_initializer(struct symbol *ctype, struct expression **ep)
 		expression_error(*ep, "invalid initializer");
 }
 
+static struct symbol *cast_to_bool(struct expression *expr)
+{
+	struct expression *old = expr->cast_expression;
+	struct expression *zero;
+	struct symbol *otype;
+	int oclass = classify_type(degenerate(old), &otype);
+	struct symbol *ctype;
+
+	if (oclass & TYPE_COMPOUND)
+		return NULL;
+
+	zero = alloc_const_expression(expr->pos, 0);
+	expr->op = SPECIAL_NOTEQUAL;
+	ctype = usual_conversions(expr->op, old, zero,
+			oclass, TYPE_NUM, otype, zero->ctype);
+	expr->type = EXPR_COMPARE;
+	expr->left = cast_to(old, ctype);
+	expr->right = cast_to(zero, ctype);
+
+	return expr->ctype;
+}
+
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
@@ -2814,6 +2842,10 @@ static struct symbol *evaluate_cast(struct expression *expr)
 			}
 		}
 	}
+
+	if (t1 == &bool_ctype)
+		cast_to_bool(expr);
+
 out:
 	return ctype;
 }
diff --git a/validation/bool-cast-bad.c b/validation/bool-cast-bad.c
new file mode 100644
index 00000000..b7e7c058
--- /dev/null
+++ b/validation/bool-cast-bad.c
@@ -0,0 +1,27 @@
+typedef unsigned short __attribute__((bitwise)) le16;
+struct s {
+	int a:2;
+	int b:2;
+	int c:2;
+};
+
+static _Bool fresi(le16 a)     { return a; }
+static _Bool frese(le16 a)     { return (_Bool)a; }
+static _Bool fstsi(struct s a) { return a; }
+static _Bool fstse(struct s a) { return (_Bool)a; }
+
+/*
+ * check-name: bool-cast-bad.c
+ * check-command: sparse $file
+ *
+ * check-error-start
+bool-cast-bad.c:8:41: warning: incorrect type in return expression (different base types)
+bool-cast-bad.c:8:41:    expected bool
+bool-cast-bad.c:8:41:    got restricted le16 [usertype] a
+bool-cast-bad.c:9:42: warning: cast from restricted le16
+bool-cast-bad.c:10:41: warning: incorrect type in return expression (different base types)
+bool-cast-bad.c:10:41:    expected bool
+bool-cast-bad.c:10:41:    got struct s a
+bool-cast-bad.c:11:42: warning: cast from non-scalar
+ * check-error-end
+ */
diff --git a/validation/bool-cast-explicit.c b/validation/bool-cast-explicit.c
new file mode 100644
index 00000000..6f9c4d46
--- /dev/null
+++ b/validation/bool-cast-explicit.c
@@ -0,0 +1,26 @@
+typedef unsigned int	u32;
+typedef          int	s32;
+typedef void *vdp;
+typedef int  *sip;
+typedef double dbl;
+typedef unsigned short __attribute__((bitwise)) le16;
+
+static _Bool fs32(s32 a) { return (_Bool)a; }
+static _Bool fu32(u32 a) { return (_Bool)a; }
+static _Bool fvdp(vdp a) { return (_Bool)a; }
+static _Bool fsip(sip a) { return (_Bool)a; }
+static _Bool fdbl(dbl a) { return (_Bool)a; }
+static _Bool ffun(void)  { return (_Bool)ffun; }
+
+static _Bool fres(le16 a) { return (_Bool)a; }
+
+/*
+ * check-name: bool-cast-explicit
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-output-excludes: cast\\.
+ *
+ * check-error-start
+bool-cast-explicit.c:15:37: warning: cast from restricted le16
+ * check-error-end
+ */
diff --git a/validation/bool-cast-implicit.c b/validation/bool-cast-implicit.c
new file mode 100644
index 00000000..0e0e69a4
--- /dev/null
+++ b/validation/bool-cast-implicit.c
@@ -0,0 +1,28 @@
+typedef unsigned int	u32;
+typedef          int	s32;
+typedef void *vdp;
+typedef int  *sip;
+typedef double dbl;
+typedef unsigned short __attribute__((bitwise)) le16;
+
+static _Bool fs32(s32 a) { return a; }
+static _Bool fu32(u32 a) { return a; }
+static _Bool fvdp(vdp a) { return a; }
+static _Bool fsip(sip a) { return a; }
+static _Bool fdbl(dbl a) { return a; }
+static _Bool ffun(void)  { return ffun; }
+
+static _Bool fres(le16 a) { return a; }
+
+/*
+ * check-name: bool-cast-implicit
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-output-excludes: cast\\.
+ *
+ * check-error-start
+bool-cast-implicit.c:15:36: warning: incorrect type in return expression (different base types)
+bool-cast-implicit.c:15:36:    expected bool
+bool-cast-implicit.c:15:36:    got restricted le16 [usertype] a
+ * check-error-end
+ */
-- 
2.10.2

