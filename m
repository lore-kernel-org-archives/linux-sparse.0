From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 3/3] evaluate: warn on identical exprs on ?:
Date: Sun, 28 Aug 2011 15:14:20 +1200
Message-ID: <1314501260-27254-3-git-send-email-chrisf@ijw.co.nz>
References: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:42937 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab1H1DOj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 23:14:39 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6479251pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 20:14:39 -0700 (PDT)
In-Reply-To: <1314501260-27254-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

Adds a warning when identical expressions are found on both the true and false branches of ?:. This is another common copy-paste error.

Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
---
 evaluate.c                                 |    6 ++++++
 validation/check_identical_exprs_on_cond.c |   13 +++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100644 validation/check_identical_exprs_on_cond.c

diff --git a/evaluate.c b/evaluate.c
index 0e5d691..c339e63 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1220,6 +1220,12 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	const char * typediff;
 	int qual;
 
+	if (!preprocessing) {
+		if (expr_equiv(expr->cond_true, expr->cond_false))
+			warning(expr->pos, "identical expressions on both "
+				"branches of '?:'");
+	}
+
 	if (!evaluate_conditional(expr->conditional, 0))
 		return NULL;
 	if (!evaluate_expression(expr->cond_false))
diff --git a/validation/check_identical_exprs_on_cond.c b/validation/check_identical_exprs_on_cond.c
new file mode 100644
index 0000000..85a9938
--- /dev/null
+++ b/validation/check_identical_exprs_on_cond.c
@@ -0,0 +1,13 @@
+extern void bar(void);
+
+static void foo(void *a, void *b, void *c)
+{
+	void * d = a ? b : b; /* should warn */
+}
+/*
+ * check-name: A warning should be issued for identical expressions on both the true and false branches of the '?:' operator.
+ *
+ * check-error-start
+check_identical_exprs_on_cond.c:5:22: warning: identical expressions on both branches of '?:'
+ * check-error-end
+ */
-- 
1.7.4.1

