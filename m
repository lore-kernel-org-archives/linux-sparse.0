From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 8/8] div0: warn on float divide by 0 also when the lhs is not constant
Date: Sat,  3 Jun 2017 10:01:35 +0200
Message-ID: <20170603080135.46477-9-luc.vanoostenryck@gmail.com>
References: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36400 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbdFCIBv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 04:01:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id k15so22126499wmh.3
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 01:01:50 -0700 (PDT)
In-Reply-To: <20170603080135.46477-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The current code detects and warns on division by zero but
only when the left-hand side is a constant value.

Fix that by moving up the code which detect such divisions
before checking if the LHS is a constant.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c                    | 18 ++++++++++--------
 validation/div-by-zero-fp.c | 24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 8 deletions(-)
 create mode 100644 validation/div-by-zero-fp.c

diff --git a/expand.c b/expand.c
index 71fbf209c..6b0dbf656 100644
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
index 000000000..957bc732c
--- /dev/null
+++ b/validation/div-by-zero-fp.c
@@ -0,0 +1,24 @@
+double fbad(double a) { return 2.0 / 0; }
+double gbad(double a) { return 2.0 / 0.0; }
+double fool(double a) { return a / 0; }
+double ffoo(double a) { return a / 0.0; }
+
+double fbar(double a) { if (a && 0) a / 0.0; return 0; }
+double fbaz(double a) { return a /= 0.0; }
+double fquz(double a) { return a / (a && 0); }
+
+/*
+ * check-name: div-by-zero-fp.c
+ * check-command: sparse -Wno-decl $file
+ * check-known-to-fail
+ *
+ * check-error-start
+div-by-zero-fp.c:1:36: warning: division by zero
+div-by-zero-fp.c:2:36: warning: division by zero
+div-by-zero-fp.c:3:34: warning: division by zero
+div-by-zero-fp.c:4:34: warning: division by zero
+div-by-zero-fp.c:6:39: warning: division by zero
+div-by-zero-fp.c:7:34: warning: division by zero
+div-by-zero-fp.c:8:34: warning: division by zero
+ * check-error-end
+ */
-- 
2.13.0

