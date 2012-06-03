From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] check missing or duplicate goto labels
Date: Sun,  3 Jun 2012 16:01:46 -0400
Message-ID: <1338753706-24520-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45228 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab2FCUBy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 3 Jun 2012 16:01:54 -0400
Received: by qcro28 with SMTP id o28so1860551qcr.19
        for <linux-sparse@vger.kernel.org>; Sun, 03 Jun 2012 13:01:54 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Xi Wang <xi.wang@gmail.com>

This patch sets ->stmt of a SYM_LABEL to the corresponding label
statement.  If ->stmt was already set, it is a duplicate label.

On the other hand, if ->stmt of a goto label is not set during
evaluation, the label was never declared.
---
See a new test validation/goto-label.c for examples.
---
 evaluate.c              |   12 +++++++++++-
 parse.c                 |    6 +++++-
 validation/goto-label.c |   29 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)
 create mode 100644 validation/goto-label.c

diff --git a/evaluate.c b/evaluate.c
index bebe968..0987a5e 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3312,6 +3312,16 @@ static void evaluate_switch_statement(struct statement *stmt)
 	} END_FOR_EACH_PTR(sym);
 }
 
+static void evaluate_goto_statement(struct statement *stmt)
+{
+	struct symbol *label = stmt->goto_label;
+
+	if (label && !label->stmt && !lookup_keyword(label->ident, NS_KEYWORD))
+		sparse_error(stmt->pos, "label '%s' was not declared", show_ident(label->ident));
+
+	evaluate_expression(stmt->goto_expression);
+}
+
 struct symbol *evaluate_statement(struct statement *stmt)
 {
 	if (!stmt)
@@ -3370,7 +3380,7 @@ struct symbol *evaluate_statement(struct statement *stmt)
 	case STMT_LABEL:
 		return evaluate_statement(stmt->label_statement);
 	case STMT_GOTO:
-		evaluate_expression(stmt->goto_expression);
+		evaluate_goto_statement(stmt);
 		return NULL;
 	case STMT_NONE:
 		break;
diff --git a/parse.c b/parse.c
index f8ade3e..8fbba6b 100644
--- a/parse.c
+++ b/parse.c
@@ -2276,8 +2276,12 @@ static struct token *statement(struct token *token, struct statement **tree)
 			return s->op->statement(token, stmt);
 
 		if (match_op(token->next, ':')) {
+			struct symbol *s = label_symbol(token);
 			stmt->type = STMT_LABEL;
-			stmt->label_identifier = label_symbol(token);
+			stmt->label_identifier = s;
+			if (s->stmt)
+				sparse_error(stmt->pos, "label '%s' redefined", show_ident(token->ident));
+			s->stmt = stmt;
 			token = skip_attributes(token->next->next);
 			return statement(token, &stmt->label_statement);
 		}
diff --git a/validation/goto-label.c b/validation/goto-label.c
new file mode 100644
index 0000000..1196fde
--- /dev/null
+++ b/validation/goto-label.c
@@ -0,0 +1,29 @@
+void foo(void)
+{
+	goto a;
+a:
+a:
+	return;
+}
+
+void g(void)
+{
+	goto a;
+a:
+	return;
+}
+
+void bar(void)
+{
+	goto neverland;
+}
+
+/*
+ * check-name: goto labels
+ *
+ * check-error-start
+goto-label.c:5:1: error: label 'a' redefined
+goto-label.c:18:9: error: label 'neverland' was not declared
+ * check-error-end
+ */
+
-- 
1.7.9.5

