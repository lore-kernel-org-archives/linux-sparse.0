From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 21/25] constexpr: support compound literals as address constants
Date: Fri, 31 Mar 2017 03:44:55 +0200
Message-ID: <20170331014459.9351-22-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34287 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934699AbdCaBqu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so16583460wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:48 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Toplevel compound literals have got static storage duration
[6.5.2.5(6)].

This implies that
1. their addresses are address constants [6.6(9)] and
2. their initializers must contain constant expressions only
   [6.5.2.5(3), 6.7.8(4)] .

Flag the anonymous symbol created at expression parsing time as having
static storage duration if the compound literal occurs at top level
scope.

Flag the whole expression as being an address constant at evaluation
time if its corresponding anonymous symbol had been previously marked
as having static storage duration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                              |  2 ++
 expression.c                            |  2 ++
 validation/constexpr-compound-literal.c | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 validation/constexpr-compound-literal.c

diff --git a/evaluate.c b/evaluate.c
index 022c7b5f3..1ae370c7b 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2841,6 +2841,8 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
 		addr->symbol = sym;
+		if (sym->ctype.modifiers & MOD_TOPLEVEL)
+			addr->flags |= CEF_ADDR;
 
 		expr->type = EXPR_PREOP;
 		expr->op = '*';
diff --git a/expression.c b/expression.c
index 3f1ea2141..e4b770fc0 100644
--- a/expression.c
+++ b/expression.c
@@ -711,6 +711,8 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 			cast->cast_type = sym;
 			token = expect(token, ')', "at end of cast operator");
 			if (match_op(token, '{')) {
+				if (toplevel(block_scope))
+					sym->ctype.modifiers |= MOD_TOPLEVEL;
 				if (is_force)
 					warning(sym->pos,
 						"[force] in compound literal");
diff --git a/validation/constexpr-compound-literal.c b/validation/constexpr-compound-literal.c
new file mode 100644
index 000000000..d7f21ad7a
--- /dev/null
+++ b/validation/constexpr-compound-literal.c
@@ -0,0 +1,19 @@
+static int *a = &(int){ 1 };	// OK
+static int *b = &(int){ *a };	// KO
+
+static void foo(void)
+{
+	int *b = &(int){ 1 };		// OK
+	int *c = &(int){ *a };		// OK
+	static int *d = &(int){ 1 };	// KO
+}
+
+/*
+ * check-name: compound literal address constness verification
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-compound-literal.c:2:25: warning: non-constant initializer for static object
+constexpr-compound-literal.c:8:27: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.12.0

