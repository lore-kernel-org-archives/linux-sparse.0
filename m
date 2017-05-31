From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/9] div0: warn on integer divide by 0 also when the lhs is not constant
Date: Wed, 31 May 2017 05:22:01 +0200
Message-ID: <20170531032207.95830-4-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34785 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaDWU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id 6so305283wrb.1
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:19 -0700 (PDT)
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
 expand.c                 |  8 ++------
 validation/div-by-zero.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 6 deletions(-)
 create mode 100644 validation/div-by-zero.c

diff --git a/expand.c b/expand.c
index 5f908c971..0b528ea5a 100644
--- a/expand.c
+++ b/expand.c
@@ -181,6 +181,8 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	if (right->type != EXPR_VALUE)
 		return 0;
 	r = right->value;
+	if (!r && (expr->op == '/' || expr->op == '%'))
+		goto Div;
 	if (expr->op == SPECIAL_LEFTSHIFT || expr->op == SPECIAL_RIGHTSHIFT) {
 		if (r >= ctype->bit_size) {
 			if (conservative)
@@ -235,28 +237,22 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 		break;
 
 	case SIGNED('/'):
-		if (!r)
-			goto Div;
 		if (l == mask && sr == -1)
 			goto Overflow;
 		v = sl / sr;
 		break;
 
 	case UNSIGNED('/'):
-		if (!r) goto Div;
 		v = l / r; 
 		break;
 
 	case SIGNED('%'):
-		if (!r)
-			goto Div;
 		if (l == mask && sr == -1)
 			goto Overflow;
 		v = sl % sr;
 		break;
 
 	case UNSIGNED('%'):
-		if (!r) goto Div;
 		v = l % r;
 		break;
 
diff --git a/validation/div-by-zero.c b/validation/div-by-zero.c
new file mode 100644
index 000000000..786e48298
--- /dev/null
+++ b/validation/div-by-zero.c
@@ -0,0 +1,43 @@
+int  scdiv(int a) { return 2 / 0; }
+int iscdiv(int a) { return 2 / (int) 0; }
+int lscdiv(int a) { return 2 / (long) 0; }
+int uscdiv(int a) { return 2 / (unsigned int) 0; }
+
+int  svdiv(int a) { return a / 0; }
+int isvdiv(int a) { return a / (int) 0; }
+int lsvdiv(int a) { return a / (long) 0; }
+int usvdiv(int a) { return a / (unsigned int) 0; }
+
+int  scmod(int a) { return 2 % 0; }
+int iscmod(int a) { return 2 % (int) 0; }
+int lscmod(int a) { return 2 % (long) 0; }
+int uscmod(int a) { return 2 % (unsigned int) 0; }
+
+int  svmod(int a) { return a % 0; }
+int isvmod(int a) { return a % (int) 0; }
+int lsvmod(int a) { return a % (long) 0; }
+int usvmod(int a) { return a % (unsigned int) 0; }
+
+/*
+ * check-name: div-by-zero.c
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-error-start
+div-by-zero.c:1:30: warning: division by zero
+div-by-zero.c:2:30: warning: division by zero
+div-by-zero.c:3:30: warning: division by zero
+div-by-zero.c:4:30: warning: division by zero
+div-by-zero.c:6:30: warning: division by zero
+div-by-zero.c:7:30: warning: division by zero
+div-by-zero.c:8:30: warning: division by zero
+div-by-zero.c:9:30: warning: division by zero
+div-by-zero.c:11:30: warning: division by zero
+div-by-zero.c:12:30: warning: division by zero
+div-by-zero.c:13:30: warning: division by zero
+div-by-zero.c:14:30: warning: division by zero
+div-by-zero.c:16:30: warning: division by zero
+div-by-zero.c:17:30: warning: division by zero
+div-by-zero.c:18:30: warning: division by zero
+div-by-zero.c:19:30: warning: division by zero
+ * check-error-end
+ */
-- 
2.13.0

