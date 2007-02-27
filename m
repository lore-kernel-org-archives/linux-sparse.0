From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Introduce expression_error
Date: Tue, 27 Feb 2007 00:58:22 -0800
Message-ID: <20070227085822.GA6059@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:34730 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161098AbXB0JbH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 27 Feb 2007 04:31:07 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>

Adding a new function expression_error, it works just like
sparse_error but it also install a bad_ctype on expression.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-02-26 03:31:23.000000000 -0800
+++ sparse/lib.c	2007-02-27 01:04:19.000000000 -0800
@@ -126,10 +126,9 @@ void warning(struct position pos, const 
 	va_end(args);
 }	
 
-void sparse_error(struct position pos, const char * fmt, ...)
+void do_error(struct position pos, const char * fmt, va_list args)
 {
 	static int errors = 0;
-	va_list args;
         die_if_error = 1;
 	show_info = 1;
 	/* Shut up warnings after an error */
@@ -143,12 +142,27 @@ void sparse_error(struct position pos, c
 		once = 1;
 	}
 
-	va_start(args, fmt);
 	do_warn("error: ", pos, fmt, args);
-	va_end(args);
 	errors++;
 }	
 
+void sparse_error(struct position pos, const char * fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_error(pos, fmt, args);
+	va_end(args);
+}
+
+void expression_error(struct expression *expr, const char *fmt, ...)
+{
+	va_list args;
+	va_start(args, fmt);
+	do_error(expr->pos, fmt, args);
+	va_end(args);
+	expr->ctype = &bad_ctype;
+}
+
 void error_die(struct position pos, const char * fmt, ...)
 {
 	va_list args;
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-02-26 03:31:23.000000000 -0800
+++ sparse/evaluate.c	2007-02-27 01:12:46.000000000 -0800
@@ -38,7 +38,7 @@ static struct symbol *evaluate_symbol_ex
 	struct symbol *base_type;
 
 	if (!sym) {
-		sparse_error(expr->pos, "undefined identifier '%s'", show_ident(expr->symbol_name));
+		expression_error(expr, "undefined identifier '%s'", show_ident(expr->symbol_name));
 		return NULL;
 	}
 
@@ -46,7 +46,7 @@ static struct symbol *evaluate_symbol_ex
 
 	base_type = get_base_type(sym);
 	if (!base_type) {
-		sparse_error(expr->pos, "identifier '%s' has no type", show_ident(expr->symbol_name));
+		expression_error(expr, "identifier '%s' has no type", show_ident(expr->symbol_name));
 		return NULL;
 	}
 
@@ -597,7 +597,7 @@ static struct symbol *evaluate_ptr_add(s
 	examine_symbol_type(ctype);
 
 	if (!ctype->ctype.base_type) {
-		sparse_error(expr->pos, "missing type information");
+		expression_error(expr, "missing type information");
 		return NULL;
 	}
 
@@ -855,7 +855,7 @@ static struct symbol *evaluate_ptr_sub(s
 	if (typediff) {
 		ctype = common_ptr_type(l, r);
 		if (!ctype) {
-			sparse_error(expr->pos, "subtraction of different types can't work (%s)", typediff);
+			expression_error(expr, "subtraction of different types can't work (%s)", typediff);
 			return NULL;
 		}
 	}
@@ -865,7 +865,7 @@ static struct symbol *evaluate_ptr_sub(s
 	if (ctype->type == SYM_NODE)
 		ctype = ctype->ctype.base_type;
 	if (ctype->type != SYM_PTR && ctype->type != SYM_ARRAY) {
-		sparse_error(expr->pos, "subtraction of functions? Share your drugs");
+		expression_error(expr, "subtraction of functions? Share your drugs");
 		return NULL;
 	}
 	ctype = get_base_type(ctype);
@@ -1106,7 +1106,7 @@ static struct symbol *evaluate_condition
 	typediff = type_difference(ltype, rtype, MOD_IGN, MOD_IGN);
 	if (!typediff)
 		goto out;
-	sparse_error(expr->pos, "incompatible types in conditional expression (%s)", typediff);
+	expression_error(expr, "incompatible types in conditional expression (%s)", typediff);
 	return NULL;
 
 out:
@@ -1135,12 +1135,12 @@ static int compatible_assignment_types(s
 
 	if (tclass & sclass & TYPE_NUM) {
 		if (tclass & TYPE_FLOAT && !compatible_float_op(op)) {
-			sparse_error(expr->pos, "invalid assignment");
+			expression_error(expr, "invalid assignment");
 			return 0;
 		}
 		if (tclass & TYPE_RESTRICT) {
 			if (!restricted_binop(op, target)) {
-				sparse_error(expr->pos, "bad restricted assignment");
+				expression_error(expr, "bad restricted assignment");
 				return 0;
 			}
 			/* allowed assignments unfoul */
@@ -1156,11 +1156,11 @@ static int compatible_assignment_types(s
 			return 1;
 		}
 		if (op != '=') {
-			sparse_error(expr->pos, "invalid pointer assignment");
+			expression_error(expr, "invalid pointer assignment");
 			return 0;
 		}
 	} else if (op != '=') {
-		sparse_error(expr->pos, "invalid assignment");
+		expression_error(expr, "invalid assignment");
 		return 0;
 	}
 
@@ -1234,7 +1234,7 @@ static void mark_assigned(struct express
 static void evaluate_assign_to(struct expression *left, struct symbol *type)
 {
 	if (type->ctype.modifiers & MOD_CONST)
-		sparse_error(left->pos, "assignment to const expression");
+		expression_error(left, "assignment to const expression");
 
 	/* We know left is an lvalue, so it's a "preop-*" */
 	mark_assigned(left->unop);
@@ -1247,7 +1247,7 @@ static struct symbol *evaluate_assignmen
 	struct symbol *ltype, *rtype;
 
 	if (!lvalue_expression(left)) {
-		sparse_error(expr->pos, "not an lvalue");
+		expression_error(expr, "not an lvalue");
 		return NULL;
 	}
 
@@ -1412,7 +1412,7 @@ static struct symbol *degenerate(struct 
 		}
 	case SYM_FN:
 		if (expr->op != '*' || expr->type != EXPR_PREOP) {
-			sparse_error(expr->pos, "strange non-value function or array");
+			expression_error(expr, "strange non-value function or array");
 			return &bad_ctype;
 		}
 		*expr = *expr->unop;
@@ -1430,7 +1430,7 @@ static struct symbol *evaluate_addressof
 	struct symbol *ctype;
 
 	if (op->op != '*' || op->type != EXPR_PREOP) {
-		sparse_error(expr->pos, "not addressable");
+		expression_error(expr, "not addressable");
 		return NULL;
 	}
 	ctype = op->ctype;
@@ -1474,7 +1474,7 @@ static struct symbol *evaluate_dereferen
 
 	switch (ctype->type) {
 	default:
-		sparse_error(expr->pos, "cannot dereference this type");
+		expression_error(expr, "cannot dereference this type");
 		return NULL;
 	case SYM_PTR:
 		node->ctype.modifiers = target->ctype.modifiers & MOD_SPECIFIER;
@@ -1483,7 +1483,7 @@ static struct symbol *evaluate_dereferen
 
 	case SYM_ARRAY:
 		if (!lvalue_expression(op)) {
-			sparse_error(op->pos, "non-lvalue array??");
+			expression_error(op, "non-lvalue array??");
 			return NULL;
 		}
 
@@ -1515,14 +1515,14 @@ static struct symbol *evaluate_postop(st
 	struct symbol *ctype = op->ctype;
 
 	if (!lvalue_expression(expr->unop)) {
-		sparse_error(expr->pos, "need lvalue expression for ++/--");
+		expression_error(expr, "need lvalue expression for ++/--");
 		return NULL;
 	}
 	if (is_restricted_type(ctype) && restricted_unop(expr->op, &ctype)) {
-		sparse_error(expr->pos, "bad operation on restricted");
+		expression_error(expr, "bad operation on restricted");
 		return NULL;
 	} else if (is_fouled_type(ctype) && restricted_unop(expr->op, &ctype)) {
-		sparse_error(expr->pos, "bad operation on restricted");
+		expression_error(expr, "bad operation on restricted");
 		return NULL;
 	}
 
@@ -1685,7 +1685,7 @@ static struct symbol *evaluate_member_de
 	if (!evaluate_expression(deref))
 		return NULL;
 	if (!ident) {
-		sparse_error(expr->pos, "bad member name");
+		expression_error(expr, "bad member name");
 		return NULL;
 	}
 
@@ -1698,7 +1698,7 @@ static struct symbol *evaluate_member_de
 		mod |= ctype->ctype.modifiers;
 	}
 	if (!ctype || (ctype->type != SYM_STRUCT && ctype->type != SYM_UNION)) {
-		sparse_error(expr->pos, "expected structure or union");
+		expression_error(expr, "expected structure or union");
 		return NULL;
 	}
 	examine_symbol_type(ctype);
@@ -1712,7 +1712,7 @@ static struct symbol *evaluate_member_de
 			name = ctype->ident->name;
 			namelen = ctype->ident->len;
 		}
-		sparse_error(expr->pos, "no member '%s' in %s %.*s",
+		expression_error(expr, "no member '%s' in %s %.*s",
 			show_ident(ident), type, namelen, name);
 		return NULL;
 	}
@@ -1804,7 +1804,7 @@ static struct symbol *evaluate_type_info
 	}
 	examine_symbol_type(sym);
 	if (is_bitfield_type(sym)) {
-		sparse_error(expr->pos, "trying to examine bitfield type");
+		expression_error(expr, "trying to examine bitfield type");
 		return NULL;
 	}
 	return sym;
@@ -1821,7 +1821,7 @@ static struct symbol *evaluate_sizeof(st
 
 	size = type->bit_size;
 	if ((size < 0) || (size & 7))
-		sparse_error(expr->pos, "cannot size expression");
+		expression_error(expr, "cannot size expression");
 	expr->type = EXPR_VALUE;
 	expr->value = size >> 3;
 	expr->ctype = size_t_ctype;
@@ -1849,7 +1849,7 @@ static struct symbol *evaluate_ptrsizeof
 		if (type)
 			break;
 	default:
-		sparse_error(expr->pos, "expected pointer expression");
+		expression_error(expr, "expected pointer expression");
 		return NULL;
 	}
 	size = type->bit_size;
@@ -1968,7 +1968,7 @@ static void evaluate_array_initializer(s
 static void evaluate_scalar_initializer(struct symbol *ctype, struct expression *expr)
 {
 	if (expression_list_size(expr->expr_list) != 1) {
-		sparse_error(expr->pos, "unexpected compound initializer");
+		expression_error(expr, "unexpected compound initializer");
 		return;
 	}
 	evaluate_array_initializer(ctype, expr);
@@ -1994,7 +1994,7 @@ static int evaluate_one_struct_initializ
 	unsigned long offset;
 
 	if (!sym) {
-		sparse_error(entry->pos, "unknown named initializer");
+		expression_error(entry, "unknown named initializer");
 		return -1;
 	}
 
@@ -2103,7 +2103,7 @@ static void evaluate_initializer(struct 
 		if (ctype->type == SYM_NODE)
 			ctype = ctype->ctype.base_type;
 		if (ctype->type != SYM_STRUCT && ctype->type != SYM_UNION) {
-			sparse_error(expr->pos, "expected structure or union for '%s' dereference", show_ident(expr->expr_ident));
+			expression_error(expr, "expected structure or union for '%s' dereference", show_ident(expr->expr_ident));
 			show_symbol(ctype);
 			return;
 		}
@@ -2115,7 +2115,7 @@ static void evaluate_initializer(struct 
 		if (ctype->type == SYM_NODE)
 			ctype = ctype->ctype.base_type;
 		if (ctype->type != SYM_ARRAY) {
-			sparse_error(expr->pos, "expected array");
+			expression_error(expr, "expected array");
 			return;
 		}
 		evaluate_one_array_initializer(ctype->ctype.base_type, ep, 0);
@@ -2247,7 +2247,7 @@ static struct symbol *evaluate_cast(stru
 
 	t2 = target->ctype;
 	if (!t2) {
-		sparse_error(expr->pos, "cast from unknown type");
+		expression_error(expr, "cast from unknown type");
 		goto out;
 	}
 	class2 = classify_type(t2, &t2);
@@ -2342,18 +2342,18 @@ static struct symbol *evaluate_call(stru
 		if (!evaluate_arguments(sym, ctype, arglist))
 			return NULL;
 		if (ctype->type != SYM_FN) {
-			sparse_error(expr->pos, "not a function %s",
+			expression_error(expr, "not a function %s",
 				     show_ident(sym->ident));
 			return NULL;
 		}
 		args = expression_list_size(expr->args);
 		fnargs = symbol_list_size(ctype->arguments);
 		if (args < fnargs)
-			sparse_error(expr->pos,
+			expression_error(expr,
 				     "not enough arguments for function %s",
 				     show_ident(sym->ident));
 		if (args > fnargs && !ctype->variadic)
-			sparse_error(expr->pos,
+			expression_error(expr,
 				     "too many arguments for function %s",
 				     show_ident(sym->ident));
 	}
@@ -2375,7 +2375,7 @@ struct symbol *evaluate_expression(struc
 	switch (expr->type) {
 	case EXPR_VALUE:
 	case EXPR_FVALUE:
-		sparse_error(expr->pos, "value expression without a type");
+		expression_error(expr, "value expression without a type");
 		return NULL;
 	case EXPR_STRING:
 		return evaluate_string(expr);
@@ -2450,10 +2450,10 @@ struct symbol *evaluate_expression(struc
 	case EXPR_IDENTIFIER:
 	case EXPR_INDEX:
 	case EXPR_POS:
-		sparse_error(expr->pos, "internal front-end error: initializer in expression");
+		expression_error(expr, "internal front-end error: initializer in expression");
 		return NULL;
 	case EXPR_SLICE:
-		sparse_error(expr->pos, "internal front-end error: SLICE re-evaluated");
+		expression_error(expr, "internal front-end error: SLICE re-evaluated");
 		return NULL;
 	}
 	return NULL;
@@ -2547,7 +2547,7 @@ static struct symbol *evaluate_return_ex
 	fntype = current_fn->ctype.base_type;
 	if (!fntype || fntype == &void_ctype) {
 		if (expr && ctype != &void_ctype)
-			sparse_error(expr->pos, "return expression in %s function", fntype?"void":"typeless");
+			expression_error(expr, "return expression in %s function", fntype?"void":"typeless");
 		return NULL;
 	}
 
@@ -2587,7 +2587,7 @@ static void verify_output_constraint(str
 	case '+':	/* Update */
 		break;
 	default:
-		sparse_error(expr->pos, "output constraint is not an assignment constraint (\"%s\")", constraint);
+		expression_error(expr, "output constraint is not an assignment constraint (\"%s\")", constraint);
 	}
 }
 
@@ -2596,7 +2596,7 @@ static void verify_input_constraint(stru
 	switch (*constraint) {
 	case '=':	/* Assignment */
 	case '+':	/* Update */
-		sparse_error(expr->pos, "input constraint with assignment (\"%s\")", constraint);
+		expression_error(expr, "input constraint with assignment (\"%s\")", constraint);
 	}
 }
 
@@ -2677,7 +2677,7 @@ static void evaluate_asm_statement(struc
 		}
 		if (expr->type == EXPR_STRING)
 			continue;
-		sparse_error(expr->pos, "asm clobber is not a string");
+		expression_error(expr, "asm clobber is not a string");
 	} END_FOR_EACH_PTR(expr);
 }
 
@@ -2732,7 +2732,7 @@ static void check_case_type(struct expre
 	return;
 
 Bad:
-	sparse_error(case_expr->pos, "incompatible types for 'case' statement");
+	expression_error(case_expr, "incompatible types for 'case' statement");
 }
 
 static void evaluate_switch_statement(struct statement *stmt)
Index: sparse/expand.c
===================================================================
--- sparse.orig/expand.c	2007-02-26 03:31:23.000000000 -0800
+++ sparse/expand.c	2007-02-27 01:04:49.000000000 -0800
@@ -765,7 +765,7 @@ static int expand_call(struct expression
 	cost = expand_arguments(expr->args);
 	sym = fn->ctype;
 	if (!sym) {
-		sparse_error(expr->pos, "function has no type");
+		expression_error(expr, "function has no type");
 		return SIDE_EFFECTS;
 	}
 	if (sym->type == SYM_NODE)
@@ -964,7 +964,7 @@ static int expand_expression(struct expr
 	case EXPR_SIZEOF:
 	case EXPR_PTRSIZEOF:
 	case EXPR_ALIGNOF:
-		sparse_error(expr->pos, "internal front-end error: sizeof in expansion?");
+		expression_error(expr, "internal front-end error: sizeof in expansion?");
 		return UNSAFE;
 	}
 	return SIDE_EFFECTS;
@@ -975,7 +975,7 @@ static void expand_const_expression(stru
 	if (expr) {
 		expand_expression(expr);
 		if (expr->type != EXPR_VALUE)
-			sparse_error(expr->pos, "Expected constant expression in %s", where);
+			expression_error(expr, "Expected constant expression in %s", where);
 	}
 }
 
@@ -1148,12 +1148,12 @@ long long get_expression_value(struct ex
 		return 0;
 	ctype = evaluate_expression(expr);
 	if (!ctype) {
-		sparse_error(expr->pos, "bad constant expression type");
+		expression_error(expr, "bad constant expression type");
 		return 0;
 	}
 	expand_expression(expr);
 	if (expr->type != EXPR_VALUE) {
-		sparse_error(expr->pos, "bad constant expression");
+		expression_error(expr, "bad constant expression");
 		return 0;
 	}
 
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-02-26 03:31:23.000000000 -0800
+++ sparse/lib.h	2007-02-27 01:16:07.000000000 -0800
@@ -76,6 +76,7 @@ extern void info(struct position, const 
 extern void warning(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void sparse_error(struct position, const char *, ...) FORMAT_ATTR(2);
 extern void error_die(struct position, const char *, ...) FORMAT_ATTR(2);
+extern void expression_error(struct expression *, const char *, ...) FORMAT_ATTR(2);
 #undef FORMAT_ATTR
 
 extern char **handle_switch(char *arg, char **next);
