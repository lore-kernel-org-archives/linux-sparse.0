From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] move evaluation & expansion of builtins in a separate file
Date: Mon, 23 Jan 2017 22:37:26 +0100
Message-ID: <20170123213728.89900-2-luc.vanoostenryck@gmail.com>
References: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35710 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdAWVhm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 23 Jan 2017 16:37:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so29658401wmd.2
        for <linux-sparse@vger.kernel.org>; Mon, 23 Jan 2017 13:37:42 -0800 (PST)
In-Reply-To: <20170123213728.89900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

No functional changes, just move some code around, and rename
'eval_init_table[]' to 'builtins_table[]'.
---
 Makefile  |   1 +
 builtin.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 expand.c  |  24 +------
 expand.h  |  34 ++++++++++
 symbol.c  | 160 +----------------------------------------------
 symbol.h  |   3 +-
 6 files changed, 248 insertions(+), 184 deletions(-)
 create mode 100644 builtin.c
 create mode 100644 expand.h

diff --git a/Makefile b/Makefile
index f59993f7c..76902b75e 100644
--- a/Makefile
+++ b/Makefile
@@ -105,6 +105,7 @@ LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
+	  builtin.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 LIB_FILE= libsparse.a
diff --git a/builtin.c b/builtin.c
new file mode 100644
index 000000000..c6c97ed85
--- /dev/null
+++ b/builtin.c
@@ -0,0 +1,210 @@
+/*
+ * builtin evaluation & expansion.
+ *
+ * Copyright (C) 2003 Transmeta Corp.
+ *               2003-2004 Linus Torvalds
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "expression.h"
+#include "expand.h"
+#include "symbol.h"
+
+static int evaluate_to_integer(struct expression *expr)
+{
+	expr->ctype = &int_ctype;
+	return 1;
+}
+
+static int evaluate_expect(struct expression *expr)
+{
+	/* Should we evaluate it to return the type of the first argument? */
+	expr->ctype = &int_ctype;
+	return 1;
+}
+
+static int arguments_choose(struct expression *expr)
+{
+	struct expression_list *arglist = expr->args;
+	struct expression *arg;
+	int i = 0;
+
+	FOR_EACH_PTR (arglist, arg) {
+		if (!evaluate_expression(arg))
+			return 0;
+		i++;
+	} END_FOR_EACH_PTR(arg);
+	if (i < 3) {
+		sparse_error(expr->pos,
+			     "not enough arguments for __builtin_choose_expr");
+		return 0;
+	} if (i > 3) {
+		sparse_error(expr->pos,
+			     "too many arguments for __builtin_choose_expr");
+		return 0;
+	}
+	return 1;
+}
+
+static int evaluate_choose(struct expression *expr)
+{
+	struct expression_list *list = expr->args;
+	struct expression *arg, *args[3];
+	int n = 0;
+
+	/* there will be exactly 3; we'd already verified that */
+	FOR_EACH_PTR(list, arg) {
+		args[n++] = arg;
+	} END_FOR_EACH_PTR(arg);
+
+	*expr = get_expression_value(args[0]) ? *args[1] : *args[2];
+
+	return 1;
+}
+
+static int expand_expect(struct expression *expr, int cost)
+{
+	struct expression *arg = first_ptr_list((struct ptr_list *) expr->args);
+
+	if (arg)
+		*expr = *arg;
+	return 0;
+}
+
+/*
+ * __builtin_warning() has type "int" and always returns 1,
+ * so that you can use it in conditionals or whatever
+ */
+static int expand_warning(struct expression *expr, int cost)
+{
+	struct expression *arg;
+	struct expression_list *arglist = expr->args;
+
+	FOR_EACH_PTR (arglist, arg) {
+		/*
+		 * Constant strings get printed out as a warning. By the
+		 * time we get here, the EXPR_STRING has been fully 
+		 * evaluated, so by now it's an anonymous symbol with a
+		 * string initializer.
+		 *
+		 * Just for the heck of it, allow any constant string
+		 * symbol.
+		 */
+		if (arg->type == EXPR_SYMBOL) {
+			struct symbol *sym = arg->symbol;
+			if (sym->initializer && sym->initializer->type == EXPR_STRING) {
+				struct string *string = sym->initializer->string;
+				warning(expr->pos, "%*s", string->length-1, string->data);
+			}
+			continue;
+		}
+
+		/*
+		 * Any other argument is a conditional. If it's
+		 * non-constant, or it is false, we exit and do
+		 * not print any warning.
+		 */
+		if (arg->type != EXPR_VALUE)
+			goto out;
+		if (!arg->value)
+			goto out;
+	} END_FOR_EACH_PTR(arg);
+out:
+	expr->type = EXPR_VALUE;
+	expr->value = 1;
+	expr->taint = 0;
+	return 0;
+}
+
+/* The arguments are constant if the cost of all of them is zero */
+static int expand_constant_p(struct expression *expr, int cost)
+{
+	expr->type = EXPR_VALUE;
+	expr->value = !cost;
+	expr->taint = 0;
+	return 0;
+}
+
+/* The arguments are safe, if their cost is less than SIDE_EFFECTS */
+static int expand_safe_p(struct expression *expr, int cost)
+{
+	expr->type = EXPR_VALUE;
+	expr->value = (cost < SIDE_EFFECTS);
+	expr->taint = 0;
+	return 0;
+}
+
+static struct symbol_op constant_p_op = {
+	.evaluate = evaluate_to_integer,
+	.expand = expand_constant_p
+};
+
+static struct symbol_op safe_p_op = {
+	.evaluate = evaluate_to_integer,
+	.expand = expand_safe_p
+};
+
+static struct symbol_op warning_op = {
+	.evaluate = evaluate_to_integer,
+	.expand = expand_warning
+};
+
+static struct symbol_op expect_op = {
+	.evaluate = evaluate_expect,
+	.expand = expand_expect
+};
+
+static struct symbol_op choose_op = {
+	.evaluate = evaluate_choose,
+	.args = arguments_choose,
+};
+
+
+/*
+ * Builtin functions
+ */
+static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
+static struct sym_init {
+	const char *name;
+	struct symbol *base_type;
+	unsigned int modifiers;
+	struct symbol_op *op;
+} builtins_table[] = {
+	{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
+	{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
+	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
+	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
+	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
+	{ NULL,		NULL,		0 }
+};
+
+void init_builtins(int stream)
+{
+	struct sym_init *ptr;
+
+	builtin_fn_type.variadic = 1;
+	for (ptr = builtins_table; ptr->name; ptr++) {
+		struct symbol *sym;
+		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_SYMBOL);
+		sym->ctype.base_type = ptr->base_type;
+		sym->ctype.modifiers = ptr->modifiers;
+		sym->op = ptr->op;
+	}
+}
diff --git a/expand.c b/expand.c
index 0f6720c44..7af12707e 100644
--- a/expand.c
+++ b/expand.c
@@ -41,12 +41,8 @@
 #include "symbol.h"
 #include "target.h"
 #include "expression.h"
+#include "expand.h"
 
-/* Random cost numbers */
-#define SIDE_EFFECTS 10000	/* The expression has side effects */
-#define UNSAFE 100		/* The expression may be "infinitely costly" due to exceptions */
-#define SELECT_COST 20		/* Cut-off for turning a conditional into a select */
-#define BRANCH_COST 10		/* Cost of a conditional branch */
 
 static int expand_expression(struct expression *);
 static int expand_statement(struct statement *);
@@ -784,24 +780,6 @@ static int expand_cast(struct expression *expr)
 	return cost + 1;
 }
 
-/* The arguments are constant if the cost of all of them is zero */
-int expand_constant_p(struct expression *expr, int cost)
-{
-	expr->type = EXPR_VALUE;
-	expr->value = !cost;
-	expr->taint = 0;
-	return 0;
-}
-
-/* The arguments are safe, if their cost is less than SIDE_EFFECTS */
-int expand_safe_p(struct expression *expr, int cost)
-{
-	expr->type = EXPR_VALUE;
-	expr->value = (cost < SIDE_EFFECTS);
-	expr->taint = 0;
-	return 0;
-}
-
 /*
  * expand a call expression with a symbol. This
  * should expand builtins.
diff --git a/expand.h b/expand.h
new file mode 100644
index 000000000..27e10c0a8
--- /dev/null
+++ b/expand.h
@@ -0,0 +1,34 @@
+#ifndef EXPAND_H
+#define EXPAND_H
+/*
+ * sparse/expand.h
+ *
+ * Copyright (C) 2003 Transmeta Corp.
+ *               2003 Linus Torvalds
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* Random cost numbers */
+#define SIDE_EFFECTS 10000	/* The expression has side effects */
+#define UNSAFE 100		/* The expression may be "infinitely costly" due to exceptions */
+#define SELECT_COST 20		/* Cut-off for turning a conditional into a select */
+#define BRANCH_COST 10		/* Cost of a conditional branch */
+
+#endif
diff --git a/symbol.c b/symbol.c
index 92a7a6253..5b6cb7fde 100644
--- a/symbol.c
+++ b/symbol.c
@@ -642,155 +642,6 @@ struct symbol *create_symbol(int stream, const char *name, int type, int namespa
 	return sym;
 }
 
-static int evaluate_to_integer(struct expression *expr)
-{
-	expr->ctype = &int_ctype;
-	return 1;
-}
-
-static int evaluate_expect(struct expression *expr)
-{
-	/* Should we evaluate it to return the type of the first argument? */
-	expr->ctype = &int_ctype;
-	return 1;
-}
-
-static int arguments_choose(struct expression *expr)
-{
-	struct expression_list *arglist = expr->args;
-	struct expression *arg;
-	int i = 0;
-
-	FOR_EACH_PTR (arglist, arg) {
-		if (!evaluate_expression(arg))
-			return 0;
-		i++;
-	} END_FOR_EACH_PTR(arg);
-	if (i < 3) {
-		sparse_error(expr->pos,
-			     "not enough arguments for __builtin_choose_expr");
-		return 0;
-	} if (i > 3) {
-		sparse_error(expr->pos,
-			     "too many arguments for __builtin_choose_expr");
-		return 0;
-	}
-	return 1;
-}
-
-static int evaluate_choose(struct expression *expr)
-{
-	struct expression_list *list = expr->args;
-	struct expression *arg, *args[3];
-	int n = 0;
-
-	/* there will be exactly 3; we'd already verified that */
-	FOR_EACH_PTR(list, arg) {
-		args[n++] = arg;
-	} END_FOR_EACH_PTR(arg);
-
-	*expr = get_expression_value(args[0]) ? *args[1] : *args[2];
-
-	return 1;
-}
-
-static int expand_expect(struct expression *expr, int cost)
-{
-	struct expression *arg = first_ptr_list((struct ptr_list *) expr->args);
-
-	if (arg)
-		*expr = *arg;
-	return 0;
-}
-
-/*
- * __builtin_warning() has type "int" and always returns 1,
- * so that you can use it in conditionals or whatever
- */
-static int expand_warning(struct expression *expr, int cost)
-{
-	struct expression *arg;
-	struct expression_list *arglist = expr->args;
-
-	FOR_EACH_PTR (arglist, arg) {
-		/*
-		 * Constant strings get printed out as a warning. By the
-		 * time we get here, the EXPR_STRING has been fully 
-		 * evaluated, so by now it's an anonymous symbol with a
-		 * string initializer.
-		 *
-		 * Just for the heck of it, allow any constant string
-		 * symbol.
-		 */
-		if (arg->type == EXPR_SYMBOL) {
-			struct symbol *sym = arg->symbol;
-			if (sym->initializer && sym->initializer->type == EXPR_STRING) {
-				struct string *string = sym->initializer->string;
-				warning(expr->pos, "%*s", string->length-1, string->data);
-			}
-			continue;
-		}
-
-		/*
-		 * Any other argument is a conditional. If it's
-		 * non-constant, or it is false, we exit and do
-		 * not print any warning.
-		 */
-		if (arg->type != EXPR_VALUE)
-			goto out;
-		if (!arg->value)
-			goto out;
-	} END_FOR_EACH_PTR(arg);
-out:
-	expr->type = EXPR_VALUE;
-	expr->value = 1;
-	expr->taint = 0;
-	return 0;
-}
-
-static struct symbol_op constant_p_op = {
-	.evaluate = evaluate_to_integer,
-	.expand = expand_constant_p
-};
-
-static struct symbol_op safe_p_op = {
-	.evaluate = evaluate_to_integer,
-	.expand = expand_safe_p
-};
-
-static struct symbol_op warning_op = {
-	.evaluate = evaluate_to_integer,
-	.expand = expand_warning
-};
-
-static struct symbol_op expect_op = {
-	.evaluate = evaluate_expect,
-	.expand = expand_expect
-};
-
-static struct symbol_op choose_op = {
-	.evaluate = evaluate_choose,
-	.args = arguments_choose,
-};
-
-/*
- * Builtin functions
- */
-static struct symbol builtin_fn_type = { .type = SYM_FN /* , .variadic =1 */ };
-static struct sym_init {
-	const char *name;
-	struct symbol *base_type;
-	unsigned int modifiers;
-	struct symbol_op *op;
-} eval_init_table[] = {
-	{ "__builtin_constant_p", &builtin_fn_type, MOD_TOPLEVEL, &constant_p_op },
-	{ "__builtin_safe_p", &builtin_fn_type, MOD_TOPLEVEL, &safe_p_op },
-	{ "__builtin_warning", &builtin_fn_type, MOD_TOPLEVEL, &warning_op },
-	{ "__builtin_expect", &builtin_fn_type, MOD_TOPLEVEL, &expect_op },
-	{ "__builtin_choose_expr", &builtin_fn_type, MOD_TOPLEVEL, &choose_op },
-	{ NULL,		NULL,		0 }
-};
-
 
 /*
  * Abstract types
@@ -825,22 +676,13 @@ struct symbol	zero_int;
 void init_symbols(void)
 {
 	int stream = init_stream("builtin", -1, includepath);
-	struct sym_init *ptr;
 
 #define __IDENT(n,str,res) \
 	hash_ident(&n)
 #include "ident-list.h"
 
 	init_parser(stream);
-
-	builtin_fn_type.variadic = 1;
-	for (ptr = eval_init_table; ptr->name; ptr++) {
-		struct symbol *sym;
-		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_SYMBOL);
-		sym->ctype.base_type = ptr->base_type;
-		sym->ctype.modifiers = ptr->modifiers;
-		sym->op = ptr->op;
-	}
+	init_builtins(stream);
 }
 
 #define MOD_ESIGNED (MOD_SIGNED | MOD_EXPLICITLY_SIGNED)
diff --git a/symbol.h b/symbol.h
index 9b3f1604e..f18306094 100644
--- a/symbol.h
+++ b/symbol.h
@@ -128,8 +128,6 @@ struct symbol_op {
 	int test, set, class;
 };
 
-extern int expand_safe_p(struct expression *expr, int cost);
-extern int expand_constant_p(struct expression *expr, int cost);
 
 #define SYM_ATTR_WEAK		0
 #define SYM_ATTR_NORMAL		1
@@ -289,6 +287,7 @@ extern const char * type_difference(struct ctype *c1, struct ctype *c2,
 extern struct symbol *lookup_symbol(struct ident *, enum namespace);
 extern struct symbol *create_symbol(int stream, const char *name, int type, int namespace);
 extern void init_symbols(void);
+extern void init_builtins(int stream);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
 extern void show_type(struct symbol *);
-- 
2.11.0

