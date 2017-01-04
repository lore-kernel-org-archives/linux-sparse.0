From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix value of label statement
Date: Wed,  4 Jan 2017 05:45:33 +0100
Message-ID: <20170104044533.32555-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33080 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdADExo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 3 Jan 2017 23:53:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id u144so89661606wmu.0
        for <linux-sparse@vger.kernel.org>; Tue, 03 Jan 2017 20:53:44 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Normaly a label statement is not also an expression but it could be
in GCC's statement expression like : ({ ...; label: <expression>; })

Currently, during linearization sparse discards the return value
of the linearization of the label's sub-statement, thus also
discarding the value of such statement-expressions.

Trivialy fix this by not discarding the return value but returning
it instead, like other statements that also are an expression and
thus have a value.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c             |  3 +--
 validation/label-expr.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)
 create mode 100644 validation/label-expr.c

This patch can also be found as 'sent/fix-label-statement-value' on
	git://github.com/lucvoo/sparse.git

diff --git a/linearize.c b/linearize.c
index 725eafe7..8bd78777 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2029,8 +2029,7 @@ pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stmt)
 		if (label->used) {
 			add_label(ep, label);
 		}
-		linearize_statement(ep, stmt->label_statement);
-		break;
+		return linearize_statement(ep, stmt->label_statement);
 	}
 
 	case STMT_GOTO: {
diff --git a/validation/label-expr.c b/validation/label-expr.c
new file mode 100644
index 00000000..e578ed00
--- /dev/null
+++ b/validation/label-expr.c
@@ -0,0 +1,17 @@
+int foo(void);
+int foo(void)
+{
+	int r;
+
+	r = ({ label: 1; });
+	return r;
+}
+
+/*
+ * check-name: label-expr
+ * check-command: test-linearize $file
+ * check-output-ignore
+ *
+ * check-output-excludes: ret\\.32\$
+ * check-output-contains: ret\\.32 *\\$1
+ */
-- 
2.11.0

