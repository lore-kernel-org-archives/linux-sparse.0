From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] vector parsing (take II)
Date: Fri, 23 Mar 2007 16:14:02 -0700
Message-ID: <20070323231402.GE27992@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322083634.GB22151@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([63.240.77.82]:60001 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbXCWXwb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 19:52:31 -0400
Content-Disposition: inline
In-Reply-To: <20070322083634.GB22151@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

Any one want to try this patch on PowerPC for vector
support? I surely don't have one.

Chris


Sparse will take "-maltivec" into account and turn on
vector parsing accordingly.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/symbol.c
===================================================================
--- sparse.orig/symbol.c	2007-03-23 12:45:11.000000000 -0700
+++ sparse/symbol.c	2007-03-23 13:48:02.000000000 -0700
@@ -425,6 +425,9 @@ struct symbol *examine_symbol_type(struc
 	case SYM_FOULED:
 		examine_base_type(sym);
 		return sym;
+	case SYM_VECTOR:
+		examine_base_type(sym);
+		return sym;
 	default:
 		sparse_error(sym->pos, "Examining unknown symbol type %d", sym->type);
 		break;
Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-23 12:45:11.000000000 -0700
+++ sparse/parse.c	2007-03-23 15:33:28.000000000 -0700
@@ -34,6 +34,9 @@ static struct symbol_list **function_sym
 struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
+static struct symbol *alloc_indirect_symbol(struct position pos, struct ctype *ctype, int type);
+static struct token *declaration_specifiers(struct token *next, struct ctype *ctype, int qual);
+
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct ctype *ctype);
 
@@ -42,6 +45,7 @@ static struct token *union_specifier(str
 static struct token *enum_specifier(struct token *token, struct ctype *ctype);
 static struct token *attribute_specifier(struct token *token, struct ctype *ctype);
 static struct token *typeof_specifier(struct token *token, struct ctype *ctype);
+static struct token *vector_specifier(struct token *token, struct ctype *ctype);
 
 static struct token *parse_if_statement(struct token *token, struct statement *stmt);
 static struct token *parse_return_statement(struct token *token, struct statement *stmt);
@@ -103,6 +107,9 @@ static struct symbol_op enum_op = {
 	.declarator = enum_specifier,
 };
 
+static struct symbol_op vector_op = {
+	.declarator = vector_specifier,
+};
 
 
 static struct symbol_op if_op = {
@@ -225,6 +232,8 @@ static struct init_keyword {
 	{ "union", 	NS_TYPEDEF, .op = &union_op },
 	{ "enum", 	NS_TYPEDEF, .op = &enum_op },
 
+	{ "vector", 	NS_TYPEDEF, .op = &vector_op },
+
 	{ "inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
 	{ "__inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
 	{ "__inline__",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
@@ -382,6 +391,7 @@ static int apply_modifiers(struct positi
 		case SYM_ARRAY:
 		case SYM_BITFIELD:
 		case SYM_PTR:
+		case SYM_VECTOR:
 			ctype = &base->ctype;
 			continue;
 		}
@@ -720,6 +730,21 @@ static struct token *enum_specifier(stru
 	return ret;
 }
 
+static struct token *vector_specifier(struct token *token, struct ctype *ctype)
+{
+	struct token *next;
+	struct symbol *vector;
+
+	if (!maltivec)
+		return NULL;
+
+	next = declaration_specifiers(token, ctype, 0);
+	vector = alloc_indirect_symbol(token->pos, ctype, SYM_VECTOR);
+	vector->bit_size = bits_in_vector;
+	vector->ctype.alignment = vector_alignment;
+	return next;
+}
+
 static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 {
 	struct symbol *sym;
@@ -1046,6 +1071,8 @@ static struct token *declaration_specifi
 		}
 		if (s->type == SYM_KEYWORD && s->op->declarator) {
 			next = s->op->declarator(next, &thistype);
+			if (!next)
+				break;
 			mod = thistype.modifiers;
 		}
 		type = thistype.base_type;
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-23 12:45:11.000000000 -0700
+++ sparse/symbol.h	2007-03-23 13:48:02.000000000 -0700
@@ -54,6 +54,7 @@ enum type {
 	SYM_LABEL,
 	SYM_RESTRICT,
 	SYM_FOULED,
+	SYM_VECTOR,
 	SYM_KEYWORD,
 	SYM_BAD,
 };
@@ -178,7 +179,8 @@ struct symbol {
 #define MOD_LONG	0x0400
 #define MOD_LONGLONG	0x0800
 
-#define MOD_TYPEDEF	0x1000
+#define MOD_VECTOR	0x1000
+#define MOD_TYPEDEF	0x2000
 
 #define MOD_INLINE	0x40000
 #define MOD_ADDRESSABLE	0x80000
Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-03-22 14:11:40.000000000 -0700
+++ sparse/lib.c	2007-03-23 15:29:44.000000000 -0700
@@ -208,6 +208,8 @@ int Wuninitialized = 1;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
+int maltivec = 0;
+
 int preprocess_only;
 char *include;
 
@@ -321,6 +323,9 @@ static char **handle_switch_m(char *arg,
 		max_int_alignment = 8;
 		bits_in_pointer = 64;
 		pointer_alignment = 8;
+	} else if (!strcmp(arg, "maltivec")) {
+		maltivec = 1;
+		add_pre_buffer("#define __VEC__\n");
 	}
 	return next;
 }
Index: sparse/target.h
===================================================================
--- sparse.orig/target.h	2006-12-05 16:17:39.000000000 -0800
+++ sparse/target.h	2007-03-23 14:53:26.000000000 -0700
@@ -42,4 +42,10 @@ extern int pointer_alignment;
 extern int bits_in_enum;
 extern int enum_alignment;
 
+/*
+ * Vector data types.
+ */
+extern int bits_in_vector;
+extern int vector_alignment;
+
 #endif
Index: sparse/expression.h
===================================================================
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-03-23 12:45:11.000000000 -0700
+++ sparse/evaluate.c	2007-03-23 13:48:02.000000000 -0700
@@ -349,6 +349,7 @@ enum {
 	TYPE_PTR = 16,
 	TYPE_COMPOUND = 32,
 	TYPE_FOULED = 64,
+	TYPE_VECTOR = 128,
 };
 
 static inline int classify_type(struct symbol *type, struct symbol **base)
@@ -362,6 +363,7 @@ static inline int classify_type(struct s
 		[SYM_BITFIELD] = TYPE_NUM | TYPE_BITFIELD,
 		[SYM_RESTRICT] = TYPE_NUM | TYPE_RESTRICT,
 		[SYM_FOULED] = TYPE_NUM | TYPE_RESTRICT | TYPE_FOULED,
+		[SYM_VECTOR] = TYPE_VECTOR | TYPE_NUM, 
 	};
 	if (type->type == SYM_NODE)
 		type = type->ctype.base_type;
@@ -556,6 +558,9 @@ static struct symbol *evaluate_arith(str
 	if (!(lclass & rclass & TYPE_NUM))
 		goto Bad;
 
+	if ((lclass ^ rclass) & TYPE_VECTOR)
+		goto Bad;
+
 	if (!float_ok && (lclass | rclass) & TYPE_FLOAT)
 		goto Bad;
 
@@ -2086,6 +2091,7 @@ static void evaluate_initializer(struct 
 		switch (ctype->type) {
 		case SYM_ARRAY:
 		case SYM_PTR:
+		case SYM_VECTOR:
 			evaluate_array_initializer(get_base_type(ctype), expr);
 			return;
 		case SYM_UNION:
Index: sparse/target.c
===================================================================
--- sparse.orig/target.c	2006-12-05 16:17:39.000000000 -0800
+++ sparse/target.c	2007-03-23 14:51:51.000000000 -0700
@@ -43,3 +43,10 @@ int pointer_alignment = 4;
  */
 int bits_in_enum = 32;
 int enum_alignment = 4;
+
+/*
+ * Vector data types.
+ */
+int bits_in_vector = 128;
+int vector_alignment = 16;
+
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-03-22 14:11:40.000000000 -0700
+++ sparse/lib.h	2007-03-23 14:50:04.000000000 -0700
@@ -99,6 +99,8 @@ extern int Wcast_truncate;
 extern int Wdo_while;
 extern int Wuninitialized;
 
+extern int maltivec;
+
 extern int dbg_entry;
 extern int dbg_dead;
 
Index: sparse/validation/vector2.c
===================================================================
--- sparse.orig/validation/vector2.c	2007-03-23 13:48:01.000000000 -0700
+++ sparse/validation/vector2.c	2007-03-23 15:19:11.000000000 -0700
@@ -0,0 +1,10 @@
+
+typedef vector signed char unative_t;
+
+int vector;
+
+#define NBYTES(x) ((vector signed char) {x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
+#define NSIZE	sizeof(unative_t)
+
+unative_t zv = NBYTES(0);
+
Index: sparse/validation/vector3.c
===================================================================
--- sparse.orig/validation/vector3.c	2007-03-23 15:19:34.000000000 -0700
+++ sparse/validation/vector3.c	2007-03-23 15:19:47.000000000 -0700
@@ -0,0 +1,2 @@
+int vector;
+
Index: sparse/validation/vector.c
===================================================================
--- sparse.orig/validation/vector.c	2007-03-23 13:48:01.000000000 -0700
+++ sparse/validation/vector.c	2007-03-23 15:41:32.000000000 -0700
@@ -0,0 +1,33 @@
+#ifndef __VEC__
+#error Use "-maltivec" flag to enable PowerPC AltiVec support.
+#endif
+
+typedef vector signed char unative_t;
+
+#define NBYTES(x) ((vector signed char) {x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
+#define NSIZE	sizeof(unative_t)
+
+#define __attribute_const__		__attribute__((__const__))
+
+extern unative_t vec_add(unative_t a, unative_t b);
+extern unative_t vec_cmpgt(unative_t a, unative_t b);
+
+static inline __attribute_const__ unative_t SHLBYTE(unative_t v)
+{
+	return vec_add(v,v);
+}
+
+static inline __attribute_const__ unative_t MASK(unative_t v)
+{
+	unative_t zv = NBYTES(0);
+
+	/* vec_cmpgt returns a vector bool char; thus the need for the cast */
+	return (unative_t)vec_cmpgt(zv, v);
+}
+
+unative_t foo(void)
+{
+	unative_t i = NBYTES(1);
+	return SHLBYTE(i) + MASK(i);
+}
+
