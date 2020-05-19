From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 22/28] bad-goto: jumping inside a statemet expression is an error
Date: Tue, 19 May 2020 02:57:22 +0200
Message-ID: <20200519005728.84594-23-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgESA54 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060BCC061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h21so10388156ejq.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:55 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's invalid to jump inside a statement expression.

So, detect such jumps, issue an error message and mark the
function as useless for linearization since the resulting IR
would be invalid.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                                       | 30 ++++++++++++++++---
 parse.h                                       |  1 +
 validation/label-scope2.c                     |  1 -
 validation/label-stmt-expr0.c                 |  1 -
 validation/label-stmt-expr1.c                 |  1 -
 validation/label-stmt-expr2.c                 |  1 -
 .../linear/goto-stmt-expr-conditional.c       |  1 -
 .../linear/goto-stmt-expr-short-circuit.c     |  1 -
 8 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/parse.c b/parse.c
index bf45e3b0ea44..b9d4940e77fb 100644
--- a/parse.c
+++ b/parse.c
@@ -2480,6 +2480,27 @@ static struct token *parse_switch_statement(struct token *token, struct statemen
 	return token;
 }
 
+static void warn_label_usage(struct position def, struct position use, struct ident *ident)
+{
+	const char *id = show_ident(ident);
+	sparse_error(use, "label '%s' used outside statement expression", id);
+	info(def, "   label '%s' defined here", id);
+	current_fn->bogus_linear = 1;
+}
+
+void check_label_usage(struct symbol *label, struct position use_pos)
+{
+	struct statement *def = label->stmt;
+
+	if (def) {
+		if (!is_in_scope(def->label_scope, label_scope))
+			warn_label_usage(def->pos, use_pos, label->ident);
+	} else if (!label->label_scope) {
+		label->label_scope = label_scope;
+		label->label_pos = use_pos;
+	}
+}
+
 static struct token *parse_goto_statement(struct token *token, struct statement *stmt)
 {
 	stmt->type = STMT_GOTO;
@@ -2490,10 +2511,7 @@ static struct token *parse_goto_statement(struct token *token, struct statement
 	} else if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *label = label_symbol(token);
 		stmt->goto_label = label;
-		if (!label->stmt && !label->label_scope) {
-			label->label_scope = label_scope;
-			label->label_pos = stmt->pos;
-		}
+		check_label_usage(label, stmt->pos);
 		token = token->next;
 	} else {
 		sparse_error(token->pos, "Expected identifier or goto expression");
@@ -2555,6 +2573,10 @@ static struct token *statement(struct token *token, struct statement **tree)
 			stmt->type = STMT_LABEL;
 			stmt->label_identifier = s;
 			stmt->label_scope = label_scope;
+			if (s->label_scope) {
+				if (!is_in_scope(label_scope, s->label_scope))
+					warn_label_usage(stmt->pos, s->label_pos, s->ident);
+			}
 			s->stmt = stmt;
 			return statement(token, &stmt->label_statement);
 		}
diff --git a/parse.h b/parse.h
index daef243938b2..2cfdd872e621 100644
--- a/parse.h
+++ b/parse.h
@@ -125,6 +125,7 @@ extern struct statement_list *function_computed_goto_list;
 
 extern struct token *parse_expression(struct token *, struct expression **);
 extern struct symbol *label_symbol(struct token *token);
+extern void check_label_usage(struct symbol *label, struct position use_pos);
 
 extern int show_statement(struct statement *);
 extern void show_statement_list(struct statement_list *, const char *);
diff --git a/validation/label-scope2.c b/validation/label-scope2.c
index 8c04ac6525e5..448647528dc6 100644
--- a/validation/label-scope2.c
+++ b/validation/label-scope2.c
@@ -23,7 +23,6 @@ a:
 
 /*
  * check-name: label-scope2
- * check-known-to-fail
  *
  * check-error-start
 label-scope2.c:20:17: error: label 'a' used outside statement expression
diff --git a/validation/label-stmt-expr0.c b/validation/label-stmt-expr0.c
index 66a6490241bd..5fc452ab0d15 100644
--- a/validation/label-stmt-expr0.c
+++ b/validation/label-stmt-expr0.c
@@ -26,7 +26,6 @@ l:		 1;
 /*
  * check-name: label-stmt-expr0
  * check-command: sparse -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-start
 label-stmt-expr0.c:6:9: error: label 'l' used outside statement expression
diff --git a/validation/label-stmt-expr1.c b/validation/label-stmt-expr1.c
index 339217dcb999..32a89aad4e1f 100644
--- a/validation/label-stmt-expr1.c
+++ b/validation/label-stmt-expr1.c
@@ -18,7 +18,6 @@ l:
 
 /*
  * check-name: label-stmt-expr1
- * check-known-to-fail
  *
  * check-error-start
 label-stmt-expr1.c:3:9: error: label 'l' used outside statement expression
diff --git a/validation/label-stmt-expr2.c b/validation/label-stmt-expr2.c
index 7a38e3799c55..8c54477a4cc3 100644
--- a/validation/label-stmt-expr2.c
+++ b/validation/label-stmt-expr2.c
@@ -30,7 +30,6 @@ l:
 
 /*
  * check-name: label-stmt-expr2
- * check-known-to-fail
  *
  * check-error-start
 label-stmt-expr2.c:3:9: error: label 'l' used outside statement expression
diff --git a/validation/linear/goto-stmt-expr-conditional.c b/validation/linear/goto-stmt-expr-conditional.c
index 6576052b50ac..bbfcb3ebc039 100644
--- a/validation/linear/goto-stmt-expr-conditional.c
+++ b/validation/linear/goto-stmt-expr-conditional.c
@@ -20,7 +20,6 @@ a:
 /*
  * check-name: goto-stmt-expr-conditional
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-ignore
  * check-output-ignore
diff --git a/validation/linear/goto-stmt-expr-short-circuit.c b/validation/linear/goto-stmt-expr-short-circuit.c
index 426315e69fbd..a5953e73bc93 100644
--- a/validation/linear/goto-stmt-expr-short-circuit.c
+++ b/validation/linear/goto-stmt-expr-short-circuit.c
@@ -24,7 +24,6 @@ inside:
 /*
  * check-name: goto-stmt-expr-short-circuit
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-error-ignore
  * check-output-ignore
-- 
2.26.2
