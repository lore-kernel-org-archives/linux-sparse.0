From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 12/25] constexpr: recognize static objects as address constants
Date: Fri, 31 Mar 2017 03:44:46 +0200
Message-ID: <20170331014459.9351-13-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35181 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934997AbdCaBql (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id p52so16621478wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:40 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

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
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                            |  3 ++-
 expression.c                          |  8 ++++++++
 validation/constexpr-addr-of-static.c | 36 +++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 validation/constexpr-addr-of-static.c

diff --git a/evaluate.c b/evaluate.c
index 726ec15d3..c111f6d19 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -70,9 +70,11 @@ static struct symbol *evaluate_symbol_expression(struct expression *expr)
 	addr->symbol = sym;
 	addr->symbol_name = expr->symbol_name;
 	addr->ctype = &lazy_ptr_ctype;	/* Lazy evaluation: we need to do a proper job if somebody does &sym */
+	addr->flags = expr->flags;
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
 	expr->unop = addr;
+	expr->flags = CEF_NONE;
 
 	/* The type of a symbol is the symbol itself! */
 	expr->ctype = sym;
@@ -1689,7 +1691,6 @@ static struct symbol *evaluate_addressof(struct expression *expr)
 	}
 	ctype = op->ctype;
 	*expr = *op->unop;
-	expr->flags = CEF_NONE;
 
 	if (expr->type == EXPR_SYMBOL) {
 		struct symbol *sym = expr->symbol;
diff --git a/expression.c b/expression.c
index 7f1eff306..00edd1f99 100644
--- a/expression.c
+++ b/expression.c
@@ -435,6 +435,14 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		}
 		expr->symbol_name = token->ident;
 		expr->symbol = sym;
+
+		/*
+		 * A pointer to an lvalue designating a static storage
+		 * duration object is an address constant [6.6(9)].
+		 */
+		if (sym && (sym->ctype.modifiers & (MOD_TOPLEVEL | MOD_STATIC)))
+			expr->flags = CEF_ADDR;
+
 		token = next;
 		break;
 	}
diff --git a/validation/constexpr-addr-of-static.c b/validation/constexpr-addr-of-static.c
new file mode 100644
index 000000000..a3af99ae7
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
2.12.0

