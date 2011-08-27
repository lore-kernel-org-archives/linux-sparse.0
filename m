From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 2/3] evaluate: warn on identical exprs around '||'
Date: Sun, 28 Aug 2011 10:26:54 +1200
Message-ID: <1314484015-7694-2-git-send-email-chrisf@ijw.co.nz>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46246 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab1H0W1S (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 18:27:18 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6264861pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 15:27:18 -0700 (PDT)
In-Reply-To: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

Same as prev, but for || operator.

Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
---
 evaluate.c                               |    4 ++++
 validation/check_identical_exprs_on_or.c |   24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 validation/check_identical_exprs_on_or.c

diff --git a/evaluate.c b/evaluate.c
index 08f6ae6..11de7aa 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -985,6 +985,10 @@ static struct symbol *evaluate_logical(struct expression *expr)
 			expr_equiv(expr->left, expr->right)) {
 			warning(expr->pos, "identical expressions on both "
 				"sides of '&&'");
+		} else if (expr->op == SPECIAL_LOGICAL_OR &&
+			expr_equiv(expr->left, expr->right)) {
+			warning(expr->pos, "identical expressions on both "
+				"sides of '||'");
 		}
 	}
 
diff --git a/validation/check_identical_exprs_on_or.c b/validation/check_identical_exprs_on_or.c
new file mode 100644
index 0000000..74fe226
--- /dev/null
+++ b/validation/check_identical_exprs_on_or.c
@@ -0,0 +1,24 @@
+extern void bar(void);
+
+static void foo(void *a, void *b, void *c)
+{
+	if (a || a)	/* should warn */
+		bar();
+
+	if (a || b)	/* should not warn */
+		bar();
+
+	if ((a == b) || (a == b))	/* should warn */
+		bar();
+
+	if ((a == b) || (b == c))	/* should not warn */
+		bar();
+}
+/*
+ * check-name: A warning should be issued for identical expressions on both sides of the '||' operator.
+ *
+ * check-error-start
+check_identical_exprs_on_or.c:5:15: warning: identical expressions on both sides of '||'
+check_identical_exprs_on_or.c:11:22: warning: identical expressions on both sides of '||'
+ * check-error-end
+ */
-- 
1.7.4.1

