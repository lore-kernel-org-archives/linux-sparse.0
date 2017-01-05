From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] C11: teach sparse about '_Alignas()'
Date: Thu,  5 Jan 2017 04:22:19 +0100
Message-ID: <20170105032220.7339-5-luc.vanoostenryck@gmail.com>
References: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33934 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937571AbdAED3j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 4 Jan 2017 22:29:39 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so56117682wmi.1
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 19:29:38 -0800 (PST)
In-Reply-To: <20170105032220.7339-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is quite similar to GCC's 'attribute(aligned(..))' but defined
as a new specifier and also accepting a typename as argument.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 parse.c                  | 43 +++++++++++++++++++++++++++++++++++++++++++
 validation/c11-alignas.c | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 validation/c11-alignas.c

diff --git a/parse.c b/parse.c
index f131d0e6..6eca5686 100644
--- a/parse.c
+++ b/parse.c
@@ -128,6 +128,12 @@ static struct symbol_op noreturn_op = {
 	.declarator = noreturn_specifier,
 };
 
+static declarator_t alignas_specifier;
+static struct symbol_op alignas_op = {
+	.type = KW_MODIFIER,
+	.declarator = alignas_specifier,
+};
+
 static struct symbol_op auto_op = {
 	.type = KW_MODIFIER,
 	.declarator = auto_specifier,
@@ -440,6 +446,8 @@ static struct init_keyword {
 
 	{ "_Noreturn",	NS_TYPEDEF, .op = &noreturn_op },
 
+	{ "_Alignas",	NS_TYPEDEF, .op = &alignas_op },
+
 	/* Ignored for now.. */
 	{ "restrict",	NS_TYPEDEF, .op = &restrict_op},
 	{ "__restrict",	NS_TYPEDEF, .op = &restrict_op},
@@ -1382,6 +1390,41 @@ static struct token *noreturn_specifier(struct token *next, struct decl_state *c
 	return next;
 }
 
+static struct token *alignas_specifier(struct token *token, struct decl_state *ctx)
+{
+	int alignment = 0;
+
+	if (!match_op(token, '(')) {
+		sparse_error(token->pos, "expected '(' after _Alignas");
+		return token;
+	}
+	if (lookup_type(token->next)) {
+		struct symbol *sym = NULL;
+		token = typename(token->next, &sym, NULL);
+		sym = examine_symbol_type(sym);
+		alignment = sym->ctype.alignment;
+		token = expect(token, ')', "after _Alignas(...");
+	} else {
+		struct expression *expr = NULL;
+		token = parens_expression(token, &expr, "after _Alignas");
+		if (!expr)
+			return token;
+		alignment = const_expression_value(expr);
+	}
+
+	if (alignment < 0) {
+		warning(token->pos, "non-positive alignment");
+		return token;
+	}
+	if (alignment & (alignment-1)) {
+		warning(token->pos, "non-power-of-2 alignment");
+		return token;
+	}
+	if (alignment > ctx->ctype.alignment)
+		ctx->ctype.alignment = alignment;
+	return token;
+}
+
 static struct token *const_qualifier(struct token *next, struct decl_state *ctx)
 {
 	apply_qualifier(&next->pos, &ctx->ctype, MOD_CONST);
diff --git a/validation/c11-alignas.c b/validation/c11-alignas.c
new file mode 100644
index 00000000..4b264a5d
--- /dev/null
+++ b/validation/c11-alignas.c
@@ -0,0 +1,40 @@
+static _Alignas(8)	int v;
+static _Alignas(long)	int t;
+static _Alignas(void *)	int p;
+static _Alignas(int[4])	int a;
+static _Alignas(0)	int z;
+static _Alignas(3)	int bnpow2;
+static _Alignas(-1)	int bneg;
+static _Alignas(-2)	int bnegpow2;
+static _Alignas(v)	int bnc;
+static _Alignas(+)	int bsyn;
+
+static int check(void)
+{
+	if (_Alignof(v) != 8)
+		return -1;
+	if (_Alignof(t) != _Alignof(long))
+		return -1;
+	if (_Alignof(p) != _Alignof(void *))
+		return -1;
+	if (_Alignof(a) != _Alignof(int))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * check-name: c11-alignas
+ * check-command: test-linearize -std=c11 $file
+ *
+ * check-error-start
+c11-alignas.c:6:25: warning: non-power-of-2 alignment
+c11-alignas.c:7:25: warning: non-positive alignment
+c11-alignas.c:8:25: warning: non-positive alignment
+c11-alignas.c:9:17: error: bad constant expression
+c11-alignas.c:10:17: error: Syntax error in unary expression
+ * check-error-end
+ *
+ * check-output-ignore
+ * check-output-contains: ret\\.32 *\$0
+ */
-- 
2.11.0

