From: Chris Forbes <chrisf@ijw.co.nz>
Subject: [PATCH 3/3] evaluate: warn on identical exprs on ?:
Date: Sun, 28 Aug 2011 10:26:55 +1200
Message-ID: <1314484015-7694-3-git-send-email-chrisf@ijw.co.nz>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46246 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718Ab1H0W1V (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Aug 2011 18:27:21 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6264861pzk.1
        for <linux-sparse@vger.kernel.org>; Sat, 27 Aug 2011 15:27:21 -0700 (PDT)
In-Reply-To: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Forbes <chrisf@ijw.co.nz>

Adds a warning when identical expressions are found on both the true and false branches of ?:. This is another common copy-paste error.

Signed-off-by: Chris Forbes <chrisf@ijw.co.nz>
---
 evaluate.c                                 |    8 +++++++-
 validation/check_identical_exprs_on_cond.c |   13 +++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)
 create mode 100644 validation/check_identical_exprs_on_cond.c

diff --git a/evaluate.c b/evaluate.c
index 11de7aa..c339e63 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -898,7 +898,7 @@ static int expr_list_equiv(struct expression_list *lhs,
 int expr_equiv(struct expression *lhs, struct expression *rhs)
 {
 	/* recursively determine if lhs ~ rhs. */
-	if (!lhs ^ !rhs) return 0;
+	if (!lhs || !rhs) return 0;
 
 	if (lhs->type != rhs->type) return 0;
 	if (lhs->flags != rhs->flags) return 0;
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

