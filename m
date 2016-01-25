From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v2 12/13] expression, evaluate: support compound literals as address constants
Date: Mon, 25 Jan 2016 16:04:28 +0100
Message-ID: <87egd5em4j.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35347 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcAYPEb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 10:04:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so11825829wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 07:04:30 -0800 (PST)
In-Reply-To: <87twm1g1go.fsf@gmail.com> (Nicolai Stange's message of "Mon, 25
	Jan 2016 15:47:51 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Nicolai Stange <nicstange@gmail.com>, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
---
 evaluate.c                              |  2 ++
 expression.c                            |  2 ++
 validation/constexpr-compound-literal.c | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 validation/constexpr-compound-literal.c

diff --git a/evaluate.c b/evaluate.c
index 2b60294..ec19fe4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2770,6 +2770,8 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
 		addr->symbol = sym;
+		if (sym->ctype.modifiers & MOD_TOPLEVEL)
+			expr_set_flag(&addr->flags, EXPR_FLAG_ADDR_CONST_EXPR);
 
 		expr->type = EXPR_PREOP;
 		expr->op = '*';
diff --git a/expression.c b/expression.c
index 4ecc865..789353a 100644
--- a/expression.c
+++ b/expression.c
@@ -713,6 +713,8 @@ static struct token *cast_expression(struct token *token, struct expression **tr
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
index 0000000..0892183
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
+ * check-command: sparse -Wstatic-initializer-not-const $file
+ *
+ * check-error-start
+constexpr-compound-literal.c:2:25: warning: initializer for static storage duration object is not a constant expression
+constexpr-compound-literal.c:8:27: warning: initializer for static storage duration object is not a constant expression
+ * check-error-end
+ */
-- 
2.7.0

