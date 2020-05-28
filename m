From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add support for _Generic
Date: Thu, 28 May 2020 17:19:32 +0200
Message-ID: <20200528151932.25282-1-luc.vanoostenryck@gmail.com>
References: <20200527235442.GC1805@zn.tnic>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404171AbgE1PTk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 11:19:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A111C08C5C6
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 08:19:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id be9so416486edb.2
        for <linux-sparse@vger.kernel.org>; Thu, 28 May 2020 08:19:40 -0700 (PDT)
In-Reply-To: <20200527235442.GC1805@zn.tnic>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's slightly tested but is fine for the latest kernels
like https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/kcsan

Note: a known difference with GCC is that it doesn't make the
      distinction between 'signed char' and a plain 'char'
      (on platforms where plain char are signed) since it's using
      the usual type compatbility like used for assignements.

Reference: lore.kernel.org/r/20200527235442.GC1805@zn.tnic
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Given there is some emergency, exceptionally, I've directly
upstreamed this patch but of course comments are most welcome.

-- Luc

 evaluate.c                     |  36 ++++++++
 expand.c                       |   1 +
 expression.c                   |  40 +++++++++
 expression.h                   |  16 ++++
 show-parse.c                   |   3 +
 validation/generic-functions.c |  44 +++++++++
 validation/generic-schar.c     |  39 ++++++++
 validation/generic-typename.c  | 157 +++++++++++++++++++++++++++++++++
 8 files changed, 336 insertions(+)
 create mode 100644 validation/generic-functions.c
 create mode 100644 validation/generic-schar.c
 create mode 100644 validation/generic-typename.c

diff --git a/evaluate.c b/evaluate.c
index 63d75d9031d1..5f2b7d6fc4f1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3272,6 +3272,39 @@ static void check_label_declaration(struct position pos, struct symbol *label)
 	}
 }
 
+static int type_selection(struct symbol *ctrl, struct symbol *type)
+{
+	struct ctype c = { .base_type = ctrl };
+	struct ctype t = { .base_type = type };
+
+	return !type_difference(&c, &t, 0, 0);
+}
+
+struct symbol *evaluate_generic_selection(struct expression *expr)
+{
+	struct type_expression *map;
+	struct expression *res;
+	struct symbol *ctrl;
+
+	if (!(ctrl = evaluate_expression(expr->control)))
+		return NULL;
+
+	for (map = expr->map; map; map = map->next) {
+		if (!evaluate_symbol(map->type))
+			continue;
+		if (!type_selection(ctrl, map->type))
+			continue;
+
+		res = map->expr;
+		goto end;
+	}
+	res = expr->def;
+
+end:
+	*expr = *res;
+	return evaluate_expression(expr);
+}
+
 struct symbol *evaluate_expression(struct expression *expr)
 {
 	if (!expr)
@@ -3357,6 +3390,9 @@ struct symbol *evaluate_expression(struct expression *expr)
 	case EXPR_OFFSETOF:
 		return evaluate_offsetof(expr);
 
+	case EXPR_GENERIC:
+		return evaluate_generic_selection(expr);
+
 	/* These can not exist as stand-alone expressions */
 	case EXPR_INITIALIZER:
 	case EXPR_IDENTIFIER:
diff --git a/expand.c b/expand.c
index ab296c730efd..b07893318382 100644
--- a/expand.c
+++ b/expand.c
@@ -1180,6 +1180,7 @@ static int expand_expression(struct expression *expr)
 	case EXPR_POS:
 		return expand_pos_expression(expr);
 
+	case EXPR_GENERIC:
 	case EXPR_SIZEOF:
 	case EXPR_PTRSIZEOF:
 	case EXPR_ALIGNOF:
diff --git a/expression.c b/expression.c
index 99a6d7568222..1160cd9cc593 100644
--- a/expression.c
+++ b/expression.c
@@ -44,6 +44,8 @@
 #include "target.h"
 #include "char.h"
 
+ALLOCATOR(type_expression, "type-expr-maps");
+
 static int match_oplist(int op, ...)
 {
 	va_list args;
@@ -380,6 +382,40 @@ Enoint:
 	error_die(expr->pos, "constant %s is not a valid number", show_token(token));
 }
 
+static struct token *generic_selection(struct token *token, struct expression **tree)
+{
+	struct expression *expr = alloc_expression(token->pos, EXPR_GENERIC);
+	struct type_expression **last = &expr->map;
+
+	token = expect(token, '(', "after '_Generic'");
+	token = assignment_expression(token, &expr->control);
+	if (!match_op(token, ',')) {
+		goto end;
+	}
+	while (match_op(token, ',')) {
+		token = token->next;
+		if (lookup_type(token)) {
+			struct type_expression *map = __alloc_type_expression(0);
+			token = typename(token, &map->type, NULL);
+			token = expect(token, ':', "after typename");
+			token = assignment_expression(token, &map->expr);
+			*last = map;
+			last = &map->next;
+		} else if (match_ident(token, &default_ident)) {
+			if (expr->def) {
+				warning(token->pos, "multiple default in generic expression");
+				info(expr->def->pos, "note: previous was here");
+			}
+			token = token->next;
+			token = expect(token, ':', "after typename");
+			token = assignment_expression(token, &expr->def);
+		}
+	}
+end:
+	*tree = expr;
+	return expect(token, ')', "after expression");
+}
+
 struct token *primary_expression(struct token *token, struct expression **tree)
 {
 	struct expression *expr = NULL;
@@ -423,6 +459,10 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 				token = builtin_offsetof_expr(token, &expr);
 				break;
 			}
+			if (token->ident == &_Generic_ident) {
+				token = generic_selection(token->next, &expr);
+				break;
+			}
 		} else if (sym->enum_member) {
 			expr = alloc_expression(token->pos, EXPR_VALUE);
 			*expr = *sym->initializer;
diff --git a/expression.h b/expression.h
index 3b79e0f1134e..64aa1fc23309 100644
--- a/expression.h
+++ b/expression.h
@@ -64,6 +64,7 @@ enum expression_type {
 	EXPR_FVALUE,
 	EXPR_SLICE,
 	EXPR_OFFSETOF,
+	EXPR_GENERIC,
 };
 
 
@@ -147,6 +148,14 @@ struct asm_operand {
 	unsigned int is_memory:1;
 };
 
+struct type_expression {
+	struct symbol *type;
+	struct expression *expr;
+	struct type_expression *next;
+};
+
+DECLARE_ALLOCATOR(type_expression);
+
 struct expression {
 	enum expression_type type:8;
 	unsigned flags:8;
@@ -246,6 +255,13 @@ struct expression {
 				struct expression *index;
 			};
 		};
+		// EXPR_GENERIC
+		struct {
+			struct expression *control;
+			struct expression *def;
+			struct type_expression *map;
+			struct expression *result;
+		};
 	};
 };
 
diff --git a/show-parse.c b/show-parse.c
index eb71b6504be4..51a151911e3b 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -1180,6 +1180,9 @@ int show_expression(struct expression *expr)
 	case EXPR_TYPE:
 		warning(expr->pos, "unable to show type expression");
 		return 0;
+	case EXPR_GENERIC:
+		warning(expr->pos, "unable to show generic expression");
+		return 0;
 	}
 	return 0;
 }
diff --git a/validation/generic-functions.c b/validation/generic-functions.c
new file mode 100644
index 000000000000..61bfd99e2808
--- /dev/null
+++ b/validation/generic-functions.c
@@ -0,0 +1,44 @@
+void funf(float);
+void fund(double);
+void funl(long double);
+
+#define fung(X) _Generic(X,		\
+	float:		funf,		\
+	default:	fund,		\
+	long double:	funl) (X)
+
+#define TEST(name, T)	\
+static void test ## name(T a) { return fung(a); }
+
+TEST(f, float)
+TEST(d, double)
+TEST(l, long double)
+
+/*
+ * check-name: generic-functions
+ * check-command: test-linearize $file
+ *
+ * check-output-start
+testf:
+.L0:
+	<entry-point>
+	call        funf, %arg1
+	ret
+
+
+testd:
+.L2:
+	<entry-point>
+	call        fund, %arg1
+	ret
+
+
+testl:
+.L4:
+	<entry-point>
+	call        funl, %arg1
+	ret
+
+
+ * check-output-end
+ */
diff --git a/validation/generic-schar.c b/validation/generic-schar.c
new file mode 100644
index 000000000000..0b082f4f5edd
--- /dev/null
+++ b/validation/generic-schar.c
@@ -0,0 +1,39 @@
+#define typename(x) _Generic((x) 0,			\
+char:			"char",				\
+signed char:		"signed char",			\
+unsigned char:		"unsigned char",		\
+default:		"???")
+
+#define TEST(name, x)	\
+static const char *test_ ## name(void) { return typename(x); }
+
+TEST(char, char)
+TEST(schar, signed char)
+TEST(uchar, unsigned char)
+
+/*
+ * check-name: generic-schar
+ * check-command: test-linearize --arch=i386 -fsigned-char $file
+ * check-known-to-fail
+ *
+ * check-output-start
+test_char:
+.L0:
+	<entry-point>
+	ret.32      "char"
+
+
+test_schar:
+.L2:
+	<entry-point>
+	ret.32      "signed char"
+
+
+test_uchar:
+.L4:
+	<entry-point>
+	ret.32      "unsigned char"
+
+
+ * check-output-end
+ */
diff --git a/validation/generic-typename.c b/validation/generic-typename.c
new file mode 100644
index 000000000000..1e914c5768b3
--- /dev/null
+++ b/validation/generic-typename.c
@@ -0,0 +1,157 @@
+#define typename(x) _Generic((x) 0,			\
+_Bool:			"_Bool",			\
+char:			"char",				\
+unsigned char:		"unsigned char",		\
+short:			"short",			\
+unsigned short:		"unsigned short",		\
+int:			"int",				\
+unsigned int:		"unsigned int",			\
+long:			"long",				\
+unsigned long:		"unsigned long",		\
+long long:		"long long",			\
+unsigned long long:	"unsigned long long",		\
+float:			"float",			\
+double:			"double",			\
+long double:		"long double",			\
+void *:			"void *",			\
+char *:			"char *",			\
+int *:			"int *",			\
+default:		"???")
+
+#define TEST(name, x)	\
+static const char *test_ ## name(void) { return typename(x); }
+
+TEST(bool, _Bool)
+TEST(char, char)
+TEST(uchar, unsigned char)
+TEST(short, short)
+TEST(ushort, unsigned short)
+TEST(int, int)
+TEST(uint, unsigned int)
+TEST(long, long)
+TEST(ulong, unsigned long)
+TEST(llong, long long)
+TEST(ullong, unsigned long long)
+TEST(float, float)
+TEST(double, double)
+TEST(ldouble, long double)
+TEST(vptr, void *)
+TEST(cptr, char *)
+TEST(iptr, int *)
+TEST(int128, __int128)
+
+/*
+ * check-name: generic-typename
+ * check-command: test-linearize --arch=i386 -fsigned-char $file
+ *
+ * check-output-start
+test_bool:
+.L0:
+	<entry-point>
+	ret.32      "_Bool"
+
+
+test_char:
+.L2:
+	<entry-point>
+	ret.32      "char"
+
+
+test_uchar:
+.L4:
+	<entry-point>
+	ret.32      "unsigned char"
+
+
+test_short:
+.L6:
+	<entry-point>
+	ret.32      "short"
+
+
+test_ushort:
+.L8:
+	<entry-point>
+	ret.32      "unsigned short"
+
+
+test_int:
+.L10:
+	<entry-point>
+	ret.32      "int"
+
+
+test_uint:
+.L12:
+	<entry-point>
+	ret.32      "unsigned int"
+
+
+test_long:
+.L14:
+	<entry-point>
+	ret.32      "long"
+
+
+test_ulong:
+.L16:
+	<entry-point>
+	ret.32      "unsigned long"
+
+
+test_llong:
+.L18:
+	<entry-point>
+	ret.32      "long long"
+
+
+test_ullong:
+.L20:
+	<entry-point>
+	ret.32      "unsigned long long"
+
+
+test_float:
+.L22:
+	<entry-point>
+	ret.32      "float"
+
+
+test_double:
+.L24:
+	<entry-point>
+	ret.32      "double"
+
+
+test_ldouble:
+.L26:
+	<entry-point>
+	ret.32      "long double"
+
+
+test_vptr:
+.L28:
+	<entry-point>
+	ret.32      "void *"
+
+
+test_cptr:
+.L30:
+	<entry-point>
+	ret.32      "char *"
+
+
+test_iptr:
+.L32:
+	<entry-point>
+	ret.32      "int *"
+
+
+test_int128:
+.L34:
+	<entry-point>
+	ret.32      "???"
+
+
+ * check-output-end
+ */
-- 
2.26.2
