From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] univ-init: scalar initializer needs some additional checks
Date: Tue,  2 Jun 2020 18:33:36 +0200
Message-ID: <20200602163336.32667-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgFBQdn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 2 Jun 2020 12:33:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC49C05BD1E
        for <linux-sparse@vger.kernel.org>; Tue,  2 Jun 2020 09:33:43 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id q19so8106711eja.7
        for <linux-sparse@vger.kernel.org>; Tue, 02 Jun 2020 09:33:43 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, -Wno-universal-initializer is simply implemented
by simply replacing '{ 0 }' by '{ }'.

However, this is a bit too simple when it concerns scalars
initialized with '{ 0 }' because:
* sparse & GCC issued warnings for empty scalar initializers
* initializing a pointer with '{ }' is extra bad.

So, restore the old behaviour for scalar initializers.
This is done by leaving '{ 0 }' as-is at parse time and changing
it as '{ }' only at evaluation time for compound initializers.

Fixes: 537e3e2daebd37d69447e65535fc94e82b38fc18
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                 |  3 +++
 expression.h               |  1 +
 parse.c                    | 15 ++++++++-------
 validation/Wuniv-init-ko.c | 16 ++++++++++++++++
 validation/Wuniv-init-ok.c | 18 ++++++++++++++++++
 5 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 8d2e68692a48..16553eb3481b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2608,6 +2608,9 @@ static void handle_list_initializer(struct expression *expr,
 	struct expression *e, *last = NULL, *top = NULL, *next;
 	int jumped = 0;
 
+	if (expr->zero_init)
+		expr->expr_list = NULL;
+
 	FOR_EACH_PTR(expr->expr_list, e) {
 		struct expression **v;
 		struct symbol *type;
diff --git a/expression.h b/expression.h
index 64aa1fc23309..07fe8502e15e 100644
--- a/expression.h
+++ b/expression.h
@@ -159,6 +159,7 @@ DECLARE_ALLOCATOR(type_expression);
 struct expression {
 	enum expression_type type:8;
 	unsigned flags:8;
+	unsigned zero_init:1;
 	int op;
 	struct position pos;
 	struct symbol *ctype;
diff --git a/parse.c b/parse.c
index 687c8c0c235c..9569efdc68b3 100644
--- a/parse.c
+++ b/parse.c
@@ -2783,13 +2783,6 @@ static struct token *initializer_list(struct expression_list **list, struct toke
 {
 	struct expression *expr;
 
-	// '{ 0 }' is equivalent to '{ }' unless wanting all possible
-	// warnings about using '0' to initialize a null-pointer.
-	if (!Wuniversal_initializer) {
-		if (match_token_zero(token) && match_op(token->next, '}'))
-			token = token->next;
-	}
-
 	for (;;) {
 		token = single_initializer(&expr, token);
 		if (!expr)
@@ -2807,6 +2800,14 @@ struct token *initializer(struct expression **tree, struct token *token)
 	if (match_op(token, '{')) {
 		struct expression *expr = alloc_expression(token->pos, EXPR_INITIALIZER);
 		*tree = expr;
+		if (!Wuniversal_initializer) {
+			struct token *next = token->next;
+			// '{ 0 }' is equivalent to '{ }' except for some
+			// warnings, like using 0 to initialize a null-pointer.
+			if (match_token_zero(next) && match_op(next->next, '}'))
+				expr->zero_init = 1;
+		}
+
 		token = initializer_list(&expr->expr_list, token->next);
 		return expect(token, '}', "at end of initializer");
 	}
diff --git a/validation/Wuniv-init-ko.c b/validation/Wuniv-init-ko.c
index 315c211a5db6..bd77a0af55bd 100644
--- a/validation/Wuniv-init-ko.c
+++ b/validation/Wuniv-init-ko.c
@@ -4,11 +4,27 @@ struct s {
 
 
 static struct s s = { 0 };
+static int a = { 0 };
+static int b = { };
+static int c = { 1, 2 };
+static struct s *ptr = { 0 };
+
+struct o {
+	struct i {
+		int a;
+	};
+};
+
+static struct o o = { 0 };
 
 /*
  * check-name: univ-init-ko
  *
  * check-error-start
 Wuniv-init-ko.c:6:23: warning: Using plain integer as NULL pointer
+Wuniv-init-ko.c:8:16: error: invalid initializer
+Wuniv-init-ko.c:9:16: error: invalid initializer
+Wuniv-init-ko.c:10:26: warning: Using plain integer as NULL pointer
+Wuniv-init-ko.c:18:23: warning: missing braces around initializer
  * check-error-end
  */
diff --git a/validation/Wuniv-init-ok.c b/validation/Wuniv-init-ok.c
index c39647517323..1f0c3dcb0c02 100644
--- a/validation/Wuniv-init-ok.c
+++ b/validation/Wuniv-init-ok.c
@@ -4,8 +4,26 @@ struct s {
 
 
 static struct s s = { 0 };
+static int a = { 0 };
+static int b = { };
+static int c = { 1, 2 };
+static struct s *ptr = { 0 };
+
+struct o {
+	struct i {
+		int a;
+	};
+};
+
+static struct o o = { 0 };
 
 /*
  * check-name: univ-init-ok
  * check-command: sparse -Wno-universal-initializer $file
+ *
+ * check-error-start
+Wuniv-init-ok.c:8:16: error: invalid initializer
+Wuniv-init-ok.c:9:16: error: invalid initializer
+Wuniv-init-ok.c:10:26: warning: Using plain integer as NULL pointer
+ * check-error-end
  */
-- 
2.26.2
