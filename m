From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 10/21] expression, evaluate: recognize static objects as address constants
Date: Mon, 01 Feb 2016 03:38:24 +0100
Message-ID: <87egcxi28v.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33597 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcBACi1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:38:27 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so7036390wmr.0
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:38:26 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Introduce support for recognizing address constants created either
- explicitly by referencing a static storage duration object by means
  of the unary & operator,
- implicitly by the use of an expression of array or function type.

Initially tag an expression as being an address constant at the primary
expression level, i.e. upon encountering a symbol designating an object of
static storage duration in primary_expression().

Carry the address constant flag over to the *-preop wrapped expression
created by evaluate_symbol_expression().

When dereferencing such a *-preop wrapped expression, make
evaluate_addressof() keep any address constant flag for the unwrapped
expression.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                            |  3 ++-
 expression.c                          |  8 ++++++++
 validation/constexpr-addr-of-static.c | 36 +++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 validation/constexpr-addr-of-static.c

diff --git a/evaluate.c b/evaluate.c
index 300bfbe..91f89f4 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -70,9 +70,11 @@ static struct symbol *evaluate_symbol_expression(struct expression *expr)
 	addr->symbol = sym;
 	addr->symbol_name = expr->symbol_name;
 	addr->ctype = &lazy_ptr_ctype;	/* Lazy evaluation: we need to do a proper job if somebody does &sym */
+	addr->constexpr_flags = expr->constexpr_flags;
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
 	expr->unop = addr;
+	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 
 	/* The type of a symbol is the symbol itself! */
 	expr->ctype = sym;
@@ -1682,7 +1684,6 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
diff --git a/expression.c b/expression.c
index b2d5eb4..11fb9cd 100644
--- a/expression.c
+++ b/expression.c
@@ -440,6 +440,14 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		expr->symbol_name = token->ident;
 		expr->symbol = sym;
+
+		/*
+		 * A pointer to an lvalue designating a static storage
+		 * duration object is an address constant [6.6(9)].
+		 */
+		if(sym && (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)))
+			expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
+
 		token = next;
 		break;
 	}
diff --git a/validation/constexpr-addr-of-static.c b/validation/constexpr-addr-of-static.c
new file mode 100644
index 0000000..a3af99a
--- /dev/null
+++ b/validation/constexpr-addr-of-static.c
@@ -0,0 +1,36 @@
+static int a = 1;
+static int b[2] = {1, 1};
+static void c(void) {}
+
+static int *d = &a;		// OK
+static int *e = d;		// KO
+static int *f = b;		// OK
+
+static void (*g)(void) = c;	// OK
+static void (*h)(void) = &c;	// OK
+
+static int *i = &*&a;		// OK
+static int *j = &*b;		// OK
+static int *k = &*d;		// KO
+
+
+static void l(void) {
+	int a = 1;
+	static int *b = &a;	// KO
+}
+
+static void m(void) {
+	static int a = 1;
+	static int *b = &a;	// OK
+}
+
+/*
+ * check-name: address of static object constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+constexpr-addr-of-static.c:6:17: warning: non-constant initializer for static object
+constexpr-addr-of-static.c:14:19: warning: non-constant initializer for static object
+constexpr-addr-of-static.c:19:26: warning: non-constant initializer for static object
+ * check-error-end
+ */
-- 
2.7.0

