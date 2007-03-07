From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 2/5] Free up some special bits in modifiers.
Date: Wed, 7 Mar 2007 02:06:19 -0800
Message-ID: <20070307100619.GC10577@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([63.240.77.84]:52111 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbXCGKk5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 05:40:57 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

This change using symbol_op to contain the specifier parsing
function. It is easier to add new specifiers. We don't need
special bits any more.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.h
===================================================================
--- sparse.orig/parse.h	2007-03-05 00:27:18.000000000 -0800
+++ sparse/parse.h	2007-03-05 00:33:03.000000000 -0800
@@ -133,5 +133,6 @@ extern struct symbol *ctype_fp(unsigned 
 extern void copy_statement(struct statement *src, struct statement *dst);
 extern int inline_function(struct expression *expr, struct symbol *sym);
 extern void uninline(struct symbol *sym);
+extern void init_parser(int);
 
 #endif /* PARSE_H */
Index: sparse/symbol.c
===================================================================
--- sparse.orig/symbol.c	2007-03-05 00:27:18.000000000 -0800
+++ sparse/symbol.c	2007-03-05 00:33:03.000000000 -0800
@@ -678,43 +678,9 @@ static struct sym_init {
 	{ "__label__",	&label_ctype,	MOD_LABEL | MOD_UNSIGNED },
 	{ "_Bool",	&bool_ctype,	MOD_UNSIGNED },
 
-	/* Type qualifiers */
-	{ "const",	NULL,		MOD_CONST },
-	{ "__const",	NULL,		MOD_CONST },
-	{ "__const__",	NULL,		MOD_CONST },
-	{ "volatile",	NULL,		MOD_VOLATILE },
-	{ "__volatile",	NULL,		MOD_VOLATILE },
-	{ "__volatile__", NULL,		MOD_VOLATILE },
-
 	/* Predeclared types */
 	{ "__builtin_va_list", &int_type, 0 },
 
-	/* Typedef.. */
-	{ "typedef",	NULL,		MOD_TYPEDEF },
-
-	/* Extended types */
-	{ "typeof",	NULL,		MOD_TYPEOF },
-	{ "__typeof",	NULL,		MOD_TYPEOF },
-	{ "__typeof__",	NULL,		MOD_TYPEOF },
-
-#if 0
-	{ "attribute",	NULL,		MOD_ATTRIBUTE },
-#endif
-	{ "__attribute", NULL,		MOD_ATTRIBUTE },
-	{ "__attribute__", NULL,	MOD_ATTRIBUTE },
-
-	{ "struct",	NULL,		MOD_STRUCTOF },
-	{ "union",	NULL,		MOD_UNIONOF },
-	{ "enum",	NULL,		MOD_ENUMOF },
-
-	{ "inline",	NULL,		MOD_INLINE },
-	{ "__inline",	NULL,		MOD_INLINE },
-	{ "__inline__",	NULL,		MOD_INLINE },
-
-	/* Ignored for now.. */
-	{ "restrict",	NULL,		0 },
-	{ "__restrict",	NULL,		0 },
-
 	{ NULL,		NULL,		0 }
 };
 
@@ -794,6 +760,7 @@ void init_symbols(void)
 	hash_ident(&n)
 #include "ident-list.h"
 
+	init_parser(stream);
 	for (ptr = symbol_init_table; ptr->name; ptr++) {
 		struct symbol *sym;
 		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_TYPEDEF);
Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-05 00:32:57.000000000 -0800
+++ sparse/parse.c	2007-03-05 00:33:21.000000000 -0800
@@ -5,6 +5,7 @@
  *
  * Copyright (C) 2003 Transmeta Corp.
  *               2003-2004 Linus Torvalds
+ * Copyright (C) 2004 Christopher Li
  *
  *  Licensed under the Open Software License version 1.1
  */
@@ -36,6 +37,96 @@ struct statement_list *function_computed
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct ctype *ctype);
 
+static struct token *struct_specifier(struct token *token, struct ctype *ctype);
+static struct token *union_specifier(struct token *token, struct ctype *ctype);
+static struct token *enum_specifier(struct token *token, struct ctype *ctype);
+static struct token *attribute_specifier(struct token *token, struct ctype *ctype);
+static struct token *typeof_specifier(struct token *token, struct ctype *ctype);
+
+
+static struct symbol_op modifier_op = {
+	.type = KW_MODIFIER,
+};
+
+static struct symbol_op qualifier_op = {
+	.type = KW_QUALIFIER,
+};
+
+static struct symbol_op typeof_op = {
+	.type = KW_TYPEOF,
+	.declarator = typeof_specifier,
+};
+
+static struct symbol_op attribute_op = {
+	.type = KW_ATTRIBUTE,
+	.declarator = attribute_specifier,
+};
+
+static struct symbol_op struct_op = {
+	.type = KW_SPECIFIER,
+	.declarator = struct_specifier, 
+};
+
+static struct symbol_op union_op = {
+	.type = KW_SPECIFIER,
+	.declarator = union_specifier,
+};
+
+static struct symbol_op enum_op = {
+	.type = KW_SPECIFIER,
+	.declarator = enum_specifier,
+};
+
+static struct init_keyword {
+	const char *name;
+	enum namespace ns;
+	unsigned long modifiers;
+	struct symbol_op *op;
+} keyword_table[] = {
+	/* Type qualifiers */
+	{ "const",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
+	{ "__const",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
+	{ "__const__",	NS_TYPEDEF, MOD_CONST, .op = &qualifier_op },
+	{ "volatile",	NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
+	{ "__volatile",		NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
+	{ "__volatile__", 	NS_TYPEDEF, MOD_VOLATILE, .op = &qualifier_op },
+
+	/* Typedef.. */
+	{ "typedef",	NS_TYPEDEF, MOD_TYPEDEF, .op = &modifier_op },
+
+	/* Extended types */
+	{ "typeof", 	NS_TYPEDEF, .op = &typeof_op },
+	{ "__typeof", 	NS_TYPEDEF, .op = &typeof_op },
+	{ "__typeof__",	NS_TYPEDEF, .op = &typeof_op },
+
+	{ "__attribute",   NS_TYPEDEF, .op = &attribute_op },
+	{ "__attribute__", NS_TYPEDEF, .op = &attribute_op },
+
+	{ "struct",	NS_TYPEDEF, .op = &struct_op },
+	{ "union", 	NS_TYPEDEF, .op = &union_op },
+	{ "enum", 	NS_TYPEDEF, .op = &enum_op },
+
+	{ "inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
+	{ "__inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
+	{ "__inline__",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
+
+	/* Ignored for now.. */
+	{ "restrict",	NS_TYPEDEF, .op = &qualifier_op},
+	{ "__restrict",	NS_TYPEDEF, .op = &qualifier_op},
+};
+
+void init_parser(int stream)
+{
+	int i;
+	for (i = 0; i < sizeof keyword_table/sizeof keyword_table[0]; i++) {
+		struct init_keyword *ptr = keyword_table + i;
+		struct symbol *sym = create_symbol(stream, ptr->name, SYM_KEYWORD, ptr->ns);
+		sym->ident->keyword = 1;
+		sym->ctype.modifiers = ptr->modifiers;
+		sym->op = ptr->op;
+	}
+}
+
 // Add a symbol to the list of function-local symbols
 static void fn_local_symbol(struct symbol *sym)
 {
@@ -115,7 +206,7 @@ static int apply_modifiers(struct positi
 	return 0;
 }
 
-static struct symbol * indirect(struct position pos, struct ctype *ctype, int type)
+static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *ctype, int type)
 {
 	struct symbol *sym = alloc_symbol(pos, type);
 
@@ -207,11 +298,17 @@ static struct token *parse_struct_declar
 	return struct_declaration_list(token, &sym->symbol_list);
 }
 
-static struct token *struct_or_union_specifier(enum type type, struct token *token, struct ctype *ctype)
+static struct token *struct_specifier(struct token *token, struct ctype *ctype)
+{
+	return struct_union_enum_specifier(SYM_STRUCT, token, ctype, parse_struct_declaration);
+}
+
+static struct token *union_specifier(struct token *token, struct ctype *ctype)
 {
-	return struct_union_enum_specifier(type, token, ctype, parse_struct_declaration);
+	return struct_union_enum_specifier(SYM_UNION, token, ctype, parse_struct_declaration);
 }
 
+
 typedef struct {
 	int x;
 	unsigned long long y;
@@ -744,14 +841,11 @@ static void apply_ctype(struct position 
 static void check_modifiers(struct position *pos, struct symbol *s, unsigned long mod)
 {
 	unsigned long banned, wrong;
-	unsigned long this_mod = s->ctype.modifiers;
 	const unsigned long BANNED_SIZE = MOD_LONG | MOD_LONGLONG | MOD_SHORT;
 	const unsigned long BANNED_SIGN = MOD_SIGNED | MOD_UNSIGNED;
 
-	if (this_mod & (MOD_STRUCTOF | MOD_UNIONOF | MOD_ENUMOF))
-		banned = BANNED_SIZE | BANNED_SIGN;
-	else if (this_mod & MOD_SPECIALBITS)
-		banned = 0;
+	if (s->type == SYM_KEYWORD)
+		banned = s->op->type == KW_SPECIFIER ? (BANNED_SIZE | BANNED_SIGN) : 0;
 	else if (s->ctype.base_type == &fp_type)
 		banned = BANNED_SIGN;
 	else if (s->ctype.base_type == &int_type || !s->ctype.base_type || is_int_type (s))
@@ -790,19 +884,14 @@ static struct token *declaration_specifi
 			break;
 		thistype = s->ctype;
 		mod = thistype.modifiers;
-		if (qual && (mod & ~(MOD_ATTRIBUTE | MOD_CONST | MOD_VOLATILE)))
-			break;
-		if (mod & MOD_SPECIALBITS) {
-			if (mod & MOD_STRUCTOF)
-				next = struct_or_union_specifier(SYM_STRUCT, next, &thistype);
-			else if (mod & MOD_UNIONOF)
-				next = struct_or_union_specifier(SYM_UNION, next, &thistype);
-			else if (mod & MOD_ENUMOF)
-				next = enum_specifier(next, &thistype);
-			else if (mod & MOD_ATTRIBUTE)
-				next = attribute_specifier(next, &thistype);
-			else if (mod & MOD_TYPEOF)
-				next = typeof_specifier(next, &thistype);
+		if (qual) {
+			if (s->type != SYM_KEYWORD)
+				break;
+			if (!(s->op->type & (KW_ATTRIBUTE | KW_QUALIFIER)))
+				break;
+		}
+		if (s->type == SYM_KEYWORD && s->op->declarator) {
+			next = s->op->declarator(next, &thistype);
 			mod = thistype.modifiers;
 		}
 		type = thistype.base_type;
@@ -910,13 +999,13 @@ static struct token *direct_declarator(s
 				continue;
 			}
 
-			sym = indirect(token->pos, ctype, SYM_FN);
+			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 			token = parameter_type_list(next, sym, p);
 			token = expect(token, ')', "in function declarator");
 			continue;
 		}
 		if (token->special == '[') {
-			struct symbol *array = indirect(token->pos, ctype, SYM_ARRAY);
+			struct symbol *array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
 			token = abstract_array_declarator(token->next, array);
 			token = expect(token, ']', "in abstract_array_declarator");
 			ctype = &array->ctype;
@@ -932,7 +1021,7 @@ static struct token *pointer(struct toke
 	unsigned long modifiers;
 	struct symbol *base_type;
 
-	modifiers = ctype->modifiers & ~(MOD_TYPEDEF | MOD_ATTRIBUTE);
+	modifiers = ctype->modifiers & ~MOD_TYPEDEF;
 	base_type = ctype->base_type;
 	ctype->modifiers = modifiers;
 	
@@ -976,7 +1065,7 @@ static struct token *handle_bitfield(str
 		return conditional_expression(token->next, &expr);
 	}
 
-	bitfield = indirect(token->pos, ctype, SYM_BITFIELD);
+	bitfield = alloc_indirect_symbol(token->pos, ctype, SYM_BITFIELD);
 	token = conditional_expression(token->next, &expr);
 	width = get_expression_value(expr);
 	bitfield->bit_size = width;
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-05 00:27:18.000000000 -0800
+++ sparse/symbol.h	2007-03-05 00:33:21.000000000 -0800
@@ -33,6 +33,7 @@ enum namespace {
 	NS_ITERATOR = 32,
 	NS_PREPROCESSOR = 64,
 	NS_UNDEF = 128,
+	NS_KEYWORD = 256,
 };
 
 enum type {
@@ -53,9 +54,18 @@ enum type {
 	SYM_LABEL,
 	SYM_RESTRICT,
 	SYM_FOULED,
+	SYM_KEYWORD,
 	SYM_BAD,
 };
 
+enum keyword {
+	KW_SPECIFIER 	= 1 << 0,
+	KW_MODIFIER	= 1 << 1,
+	KW_QUALIFIER	= 1 << 2,
+	KW_ATTRIBUTE	= 1 << 3,
+	KW_TYPEOF	= 1 << 4,
+};
+
 struct context {
 	struct expression *context;
 	unsigned int in, out;
@@ -74,9 +84,13 @@ struct ctype {
 };
 
 struct symbol_op {
+	enum keyword type;
 	int (*evaluate)(struct expression *);
 	int (*expand)(struct expression *, int);
 	int (*args)(struct expression *);
+
+	/* keywrods */
+	struct token *(*declarator)(struct token *token, struct ctype *ctype);
 };	
 
 extern int expand_safe_p(struct expression *expr, int cost);
@@ -87,8 +101,8 @@ extern int expand_constant_p(struct expr
 #define SYM_ATTR_STRONG		2
 
 struct symbol {
-	enum namespace namespace:8;
 	enum type type:8;
+	enum namespace namespace:9;
 	unsigned char used:1, attr:2;
 	struct position pos;		/* Where this symbol was declared */
 	struct ident *ident;		/* What identifier this symbol is associated with */
@@ -159,12 +173,7 @@ struct symbol {
 #define MOD_LONGLONG	0x0800
 
 #define MOD_TYPEDEF	0x1000
-#define MOD_STRUCTOF	0x2000
-#define MOD_UNIONOF	0x4000
-#define MOD_ENUMOF	0x8000
 
-#define MOD_TYPEOF	0x10000
-#define MOD_ATTRIBUTE	0x20000
 #define MOD_INLINE	0x40000
 #define MOD_ADDRESSABLE	0x80000
 
@@ -185,7 +194,6 @@ struct symbol {
 
 #define MOD_NONLOCAL	(MOD_EXTERN | MOD_TOPLEVEL)
 #define MOD_STORAGE	(MOD_AUTO | MOD_REGISTER | MOD_STATIC | MOD_EXTERN | MOD_INLINE | MOD_TOPLEVEL)
-#define MOD_SPECIALBITS (MOD_STRUCTOF | MOD_UNIONOF | MOD_ENUMOF | MOD_ATTRIBUTE | MOD_TYPEOF)
 #define MOD_SIGNEDNESS	(MOD_SIGNED | MOD_UNSIGNED | MOD_EXPLICITLY_SIGNED)
 #define MOD_SPECIFIER	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG | MOD_SIGNEDNESS)
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
Index: sparse/lib.c
===================================================================
Index: sparse/token.h
===================================================================
--- sparse.orig/token.h	2007-03-05 00:27:18.000000000 -0800
+++ sparse/token.h	2007-03-05 00:33:03.000000000 -0800
@@ -54,7 +54,8 @@ struct ident {
 	struct symbol *symbols;	/* Pointer to semantic meaning list */
 	unsigned char len;	/* Length of identifier name */
 	unsigned char tainted:1,
-	              reserved:1;
+	              reserved:1,
+		      keyword:1;
 	char name[];		/* Actual identifier */
 };
 
