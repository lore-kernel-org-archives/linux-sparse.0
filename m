From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] fix SIGFPE caused by signed division overflow
Date: Fri, 10 May 2013 17:00:35 -0400
Message-ID: <1368219635-4524-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:36432 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab3EJVCA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 10 May 2013 17:02:00 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so3768876vbb.6
        for <linux-sparse@vger.kernel.org>; Fri, 10 May 2013 14:01:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

Avoid evaluating INT_MIN / -1 and INT_MIN % -1, which will trap on x86
and crash sparse.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 expand.c         |  2 ++
 simplify.c       |  4 ++++
 validation/div.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 validation/div.c

diff --git a/expand.c b/expand.c
index effd27b..2dfa5e5 100644
--- a/expand.c
+++ b/expand.c
@@ -239,6 +239,8 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	case SIGNED('%'):
 		if (!r)
 			goto Div;
+		if (l == mask && sr == -1)
+			goto Overflow;
 		v = sl % sr;
 		break;
 
diff --git a/simplify.c b/simplify.c
index bda4a5b..b5cd0ea 100644
--- a/simplify.c
+++ b/simplify.c
@@ -406,6 +406,8 @@ static int simplify_constant_binop(struct instruction *insn)
 	case OP_DIVS:
 		if (!right)
 			return 0;
+		if (left == mask && right == -1)
+			return 0;
 		res = left / right;
 		break;
 	case OP_MODU:
@@ -416,6 +418,8 @@ static int simplify_constant_binop(struct instruction *insn)
 	case OP_MODS:
 		if (!right)
 			return 0;
+		if (left == mask && right == -1)
+			return 0;
 		res = left % right;
 		break;
 	case OP_SHL:
diff --git a/validation/div.c b/validation/div.c
new file mode 100644
index 0000000..3dcbfd5
--- /dev/null
+++ b/validation/div.c
@@ -0,0 +1,29 @@
+#include <limits.h>
+
+static int xd = 1 / 0;
+static int xl = 1L / 0;
+static int xll = 1LL / 0;
+
+static int yd = INT_MIN / -1;
+static long yl = LONG_MIN / -1;
+static long long yll = LLONG_MIN / -1;
+
+static int zd = INT_MIN % -1;
+static long zl = LONG_MIN % -1;
+static long long zll = LLONG_MIN % -1;
+
+/*
+ * check-name: division constants
+ *
+ * check-error-start
+div.c:3:19: warning: division by zero
+div.c:4:20: warning: division by zero
+div.c:5:22: warning: division by zero
+div.c:7:25: warning: constant integer operation overflow
+div.c:8:27: warning: constant integer operation overflow
+div.c:9:34: warning: constant integer operation overflow
+div.c:11:25: warning: constant integer operation overflow
+div.c:12:27: warning: constant integer operation overflow
+div.c:13:34: warning: constant integer operation overflow
+ * check-error-end
+ */
-- 
1.8.1.2

