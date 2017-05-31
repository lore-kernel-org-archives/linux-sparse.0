From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/9] div0: warn on float divide by 0 also when the lhs is not constant
Date: Wed, 31 May 2017 05:22:06 +0200
Message-ID: <20170531032207.95830-9-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36061 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdEaDWY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so1016715wmh.3
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:24 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The current code detects and warns on division by zero but
only when the left-hand side is a constant value.

Fix that by moving up the code which detect such divisions
before checking if the LHS is a constant.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                    | 18 ++++++++++--------
 validation/div-by-zero-fp.c | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)
 create mode 100644 validation/div-by-zero-fp.c

diff --git a/expand.c b/expand.c
index 8fd258e25..dacee7a76 100644
--- a/expand.c
+++ b/expand.c
@@ -325,19 +325,23 @@ static int simplify_float_binop(struct expression *expr)
 	unsigned long mod = expr->ctype->ctype.modifiers;
 	long double l, r, res;
 
-	if (left->type != EXPR_FVALUE || right->type != EXPR_FVALUE)
+	if (right->type != EXPR_FVALUE)
 		return 0;
 
-	l = left->fvalue;
 	r = right->fvalue;
+	if (!r && expr->op == '/')
+		goto Div;
+
+	if (left->type != EXPR_FVALUE)
+		return 0;
+	l = left->fvalue;
 
 	if (mod & MOD_LONGLONG) {
 		switch (expr->op) {
 		case '+':	res = l + r; break;
 		case '-':	res = l - r; break;
 		case '*':	res = l * r; break;
-		case '/':	if (!r) goto Div;
-				res = l / r; break;
+		case '/':	res = l / r; break;
 		default: return 0;
 		}
 	} else if (mod & MOD_LONG) {
@@ -345,8 +349,7 @@ static int simplify_float_binop(struct expression *expr)
 		case '+':	res = (double) l + (double) r; break;
 		case '-':	res = (double) l - (double) r; break;
 		case '*':	res = (double) l * (double) r; break;
-		case '/':	if (!r) goto Div;
-				res = (double) l / (double) r; break;
+		case '/':	res = (double) l / (double) r; break;
 		default: return 0;
 		}
 	} else {
@@ -354,8 +357,7 @@ static int simplify_float_binop(struct expression *expr)
 		case '+':	res = (float)l + (float)r; break;
 		case '-':	res = (float)l - (float)r; break;
 		case '*':	res = (float)l * (float)r; break;
-		case '/':	if (!r) goto Div;
-				res = (float)l / (float)r; break;
+		case '/':	res = (float)l / (float)r; break;
 		default: return 0;
 		}
 	}
diff --git a/validation/div-by-zero-fp.c b/validation/div-by-zero-fp.c
new file mode 100644
index 000000000..787af1636
--- /dev/null
+++ b/validation/div-by-zero-fp.c
@@ -0,0 +1,16 @@
+double fbad(double a) { return 2.0 / 0; }
+double gbad(double a) { return 2.0 / 0.0; }
+double fool(double a) { return a / 0; }
+double ffoo(double a) { return a / 0.0; }
+
+/*
+ * check-name: div-by-zero-fp.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+div-by-zero-fp.c:1:36: warning: division by zero
+div-by-zero-fp.c:2:36: warning: division by zero
+div-by-zero-fp.c:3:34: warning: division by zero
+div-by-zero-fp.c:4:34: warning: division by zero
+ * check-error-end
+ */
-- 
2.13.0

