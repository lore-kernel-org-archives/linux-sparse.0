From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] vector parsing, was Re: sparse segfault on ppc64.
Date: Thu, 22 Mar 2007 01:36:34 -0700
Message-ID: <20070322083634.GB22151@chrisli.org>
References: <20070322063600.GD15364@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:33550 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030300AbXCVJOj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 22 Mar 2007 05:14:39 -0400
Content-Disposition: inline
In-Reply-To: <20070322063600.GD15364@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>

> /bin/sh: line 1: 22303 Segmentation fault      sparse-0.2/sparse -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise -m32 -D__po

I am still interest to get the segfault.

On the other hand, I hack up a patch for vector parsing.
Care to give it a try?

Chris

It add very basic vector parsing. Not heavily tested yet.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/parse.c
===================================================================
--- sparse.orig/parse.c	2007-03-22 00:57:02.000000000 -0700
+++ sparse/parse.c	2007-03-22 02:01:35.000000000 -0700
@@ -34,6 +34,8 @@ static struct symbol_list **function_sym
 struct symbol_list *function_computed_target_list;
 struct statement_list *function_computed_goto_list;
 
+static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *ctype, int type);
+
 static struct token *statement(struct token *token, struct statement **tree);
 static struct token *handle_attributes(struct token *token, struct ctype *ctype);
 
@@ -225,6 +227,8 @@ static struct init_keyword {
 	{ "union", 	NS_TYPEDEF, .op = &union_op },
 	{ "enum", 	NS_TYPEDEF, .op = &enum_op },
 
+	{ "vector", 	NS_TYPEDEF, MOD_VECTOR, .op = &modifier_op },
+
 	{ "inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
 	{ "__inline",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
 	{ "__inline__",	NS_TYPEDEF, MOD_INLINE, .op = &modifier_op },
@@ -382,6 +386,7 @@ static int apply_modifiers(struct positi
 		case SYM_ARRAY:
 		case SYM_BITFIELD:
 		case SYM_PTR:
+		case SYM_VECTOR:
 			ctype = &base->ctype;
 			continue;
 		}
@@ -412,6 +417,13 @@ static int apply_modifiers(struct positi
 		ctype->base_type = type;
 		create_fouled(type);
 	}
+	if (ctype->modifiers & MOD_VECTOR) {
+		struct symbol *vec;
+		ctype->modifiers &= ~MOD_VECTOR;
+		vec = alloc_indirect_symbol(pos, ctype, SYM_VECTOR);
+		/* XXX: correct the size and alignment of vector */
+
+	}
 	return 0;
 }
 
Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-03-22 00:57:02.000000000 -0700
+++ sparse/symbol.h	2007-03-22 01:36:43.000000000 -0700
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
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-03-19 16:16:29.000000000 -0700
+++ sparse/evaluate.c	2007-03-22 01:56:50.000000000 -0700
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
Index: sparse/validation/vector.c
===================================================================
--- sparse.orig/validation/vector.c	2007-03-22 00:51:11.000000000 -0700
+++ sparse/validation/vector.c	2007-03-22 01:07:00.000000000 -0700
@@ -0,0 +1,30 @@
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
+
+unative_t foo(void)
+{
+	unative_t i = NBYTES(1);
+	return SHLBYTE(i) + MASK(i);
+}
+
