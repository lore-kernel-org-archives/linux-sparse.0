From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH RFC 12/13] expression, evaluate: support compound literals as address constants
Date: Thu, 23 Jul 2015 01:23:53 +0200
Message-ID: <87fv4fixo6.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34941 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbbGVXX5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Jul 2015 19:23:57 -0400
Received: by wibxm9 with SMTP id xm9so184374780wib.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Jul 2015 16:23:56 -0700 (PDT)
Received: from localhost.localdomain (x55b1cac6.dyn.telefonica.de. [85.177.202.198])
        by smtp.gmail.com with ESMTPSA id fs8sm4633809wjb.7.2015.07.22.16.23.54
        for <linux-sparse@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2015 16:23:55 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

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
 evaluate.c                              |  3 +++
 expression.c                            |  2 ++
 validation/constexpr-compound-literal.c | 18 ++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 validation/constexpr-compound-literal.c

diff --git a/evaluate.c b/evaluate.c
index ee5f18f..be239ab 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2769,6 +2769,9 @@ static struct symbol *evaluate_cast(struct expression *expr)
 
 		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
 		addr->symbol = sym;
+		if (sym->ctype.modifiers & MOD_TOPLEVEL)
+			addr->flags |=
+				expr_set_flag_mask(EXPR_FLAG_ADDR_CONST_EXPR);
 
 		expr->type = EXPR_PREOP;
 		expr->op = '*';
diff --git a/expression.c b/expression.c
index a4b6fa2..4c5cafa 100644
--- a/expression.c
+++ b/expression.c
@@ -715,6 +715,8 @@ static struct token *cast_expression(struct token *token, struct expression **tr
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
index 0000000..6019a18
--- /dev/null
+++ b/validation/constexpr-compound-literal.c
@@ -0,0 +1,18 @@
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
+ *
+ * check-error-start
+constexpr-compound-literal.c:2:25: warning: initializer for static storage duration object is not a constant expression
+constexpr-compound-literal.c:8:27: warning: initializer for static storage duration object is not a constant expression
+ * check-error-end
+ */
-- 
2.4.5

