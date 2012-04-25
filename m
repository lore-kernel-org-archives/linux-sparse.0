From: Konrad Eisele <eiselekd@gmail.com>
Subject: [PATCH] depend.c: build up a dependency tree from c entities downto  tokens: entries in the tree are: macro-depend: tree of #if nesting macro-expansions: possible macro expansion source of a token tok->macro-expansions->macro tok->macro-depend->macro c entities are linked in via [stmt|expr|sym]->start-end-token
Date: Wed, 25 Apr 2012 22:10:10 +0200
Message-ID: <1335384610-15047-1-git-send-email-eiselekd@gmail.de>
References: <4F967865.60809@gaisler.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37157 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758345Ab2DYUHK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Apr 2012 16:07:10 -0400
Received: by lahj13 with SMTP id j13so411509lah.19
        for <linux-sparse@vger.kernel.org>; Wed, 25 Apr 2012 13:07:08 -0700 (PDT)
In-Reply-To: <4F967865.60809@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, sparse@chrisli.org
Cc: eiselekd@gmail.com, sam@ravnborg.org, davem@davemloft.net, KE <eiselekd@gmx.de>

From: KE <eiselekd@gmx.de>

---
 Makefile      |    6 +-
 allocate.c    |    8 ++-
 allocate.h    |   10 ++-
 attr.c        |   67 ++++++++++++
 attr.h        |   18 +++
 depend.c      |  329 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 depend.h      |   91 ++++++++++++++++
 expand.c      |    1 +
 expression.c  |   60 +++++-----
 expression.h  |    8 ++
 inline.c      |   10 ++
 lib.c         |    8 ++
 parse.c       |   73 +++++++++----
 parse.h       |    1 +
 pre-process.c |  104 ++++++++++++------
 shrink.c      |  102 ++++++++++++++++++
 sparse.c      |    3 +
 symbol.h      |    9 ++
 token.h       |   10 ++
 19 files changed, 826 insertions(+), 92 deletions(-)
 create mode 100644 attr.c
 create mode 100644 attr.h
 create mode 100644 depend.c
 create mode 100644 depend.h
 create mode 100644 shrink.c

diff --git a/Makefile b/Makefile
index 79cadb0..833ec70 100644
--- a/Makefile
+++ b/Makefile
@@ -39,7 +39,8 @@ INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse \
-	 test-linearize example test-unssa test-dissect ctags
+	 test-linearize example test-unssa test-dissect ctags \
+	 shrink
 INST_PROGRAMS=sparse cgcc
 INST_MAN1=sparse.1 cgcc.1
 
@@ -70,7 +71,8 @@ LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
+	  depend.o attr.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
diff --git a/allocate.c b/allocate.c
index 5cc52a9..30378d3 100644
--- a/allocate.c
+++ b/allocate.c
@@ -26,6 +26,7 @@
 #include "scope.h"
 #include "expression.h"
 #include "linearize.h"
+#include "depend.h"
 
 void protect_allocations(struct allocator_struct *desc)
 {
@@ -125,5 +126,10 @@ ALLOCATOR(entrypoint, "entrypoint");
 ALLOCATOR(instruction, "instruction");
 ALLOCATOR(multijmp, "multijmp");
 ALLOCATOR(pseudo, "pseudo");
+ALLOCATOR(macro_dep, "macro dependency");
+ALLOCATOR(macro_expansion, "macro expansion");
 
-
+void token_allocator_nofree(void) 
+{
+	token_allocator.nofree = 1;
+}
diff --git a/allocate.h b/allocate.h
index 9f1dc8c..de85320 100644
--- a/allocate.h
+++ b/allocate.h
@@ -12,6 +12,7 @@ struct allocator_struct {
 	struct allocation_blob *blobs;
 	unsigned int alignment;
 	unsigned int chunking;
+	unsigned int nofree;
 	void *freelist;
 	/* statistics */
 	unsigned int allocations, total_bytes, useful_bytes;
@@ -22,6 +23,7 @@ extern void drop_all_allocations(struct allocator_struct *desc);
 extern void *allocate(struct allocator_struct *desc, unsigned int size);
 extern void free_one_entry(struct allocator_struct *desc, void *entry);
 extern void show_allocations(struct allocator_struct *);
+extern void token_allocator_nofree(void);
 
 #define __DECLARE_ALLOCATOR(type, x)		\
 	extern type *__alloc_##x(int);		\
@@ -42,7 +44,8 @@ extern void show_allocations(struct allocator_struct *);
 	}							\
 	void __free_##x(type *entry)				\
 	{							\
-		free_one_entry(&x##_allocator, entry);		\
+		if (!x##_allocator.nofree)			\
+			free_one_entry(&x##_allocator, entry);	\
 	}							\
 	void show_##x##_alloc(void)				\
 	{							\
@@ -50,7 +53,8 @@ extern void show_allocations(struct allocator_struct *);
 	}							\
 	void clear_##x##_alloc(void)				\
 	{							\
-		drop_all_allocations(&x##_allocator);		\
+		if (!x##_allocator.nofree)			\
+			drop_all_allocations(&x##_allocator);	\
 	}							\
 	void protect_##x##_alloc(void)				\
 	{							\
@@ -77,5 +81,7 @@ DECLARE_ALLOCATOR(instruction);
 DECLARE_ALLOCATOR(multijmp);
 DECLARE_ALLOCATOR(phi);
 DECLARE_ALLOCATOR(pseudo);
+DECLARE_ALLOCATOR(macro_dep);
+DECLARE_ALLOCATOR(macro_expansion);
 
 #endif
diff --git a/attr.c b/attr.c
new file mode 100644
index 0000000..54c4c21
--- /dev/null
+++ b/attr.c
@@ -0,0 +1,67 @@
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include "allocate.h"
+#include "compat.h"
+#include "attr.h"
+
+struct hash_v {
+	struct hash_v *n;
+	void *key;
+	enum attr_tags tag;
+	void *v;
+};
+
+__DECLARE_ALLOCATOR(struct hash_v, hash_v);
+__ALLOCATOR(struct hash_v, "hash value", hash_v);
+
+#define HASH_LEN (1024*4)
+struct hash {
+	struct hash_v *f;
+} h[HASH_LEN];
+
+void init_attr(void) {
+	memset(h, 0, sizeof(h));
+}
+
+static int hash_func(void *key, enum attr_tags tag) {
+	unsigned int k = ((unsigned int)key) >> 4;
+	return ((k) ^ (k >> 16) ^ (k >> 24) ^ tag) & (HASH_LEN-1);
+}
+
+void **lookup_attr(void *key, enum attr_tags tag, int create) {
+	int i = hash_func(key, tag);
+	struct hash *hp = &h[i];
+	struct hash_v *p;
+	struct hash_v **c = &hp->f;
+	while((p = *c)) {
+		if ((p ->tag == tag)
+		    && (p ->key == key)) {
+			return &p->v;
+		}
+		c = &p->n;
+	}
+	if (create) {
+		p = __alloc_hash_v(0);
+		p->key = key;
+		p->tag = tag;
+		p->v = 0;
+		*c = p;
+		return &p->v;
+	}
+	return 0;
+}
+
+void *set_attr(void *key, enum attr_tags tag, void *data) {
+	void **p = lookup_attr(key, tag, 1);
+	assert(p);
+	*p = data;
+	return data;
+}
+
+void *get_attr(void *key, enum attr_tags tag) {
+	void **p = lookup_attr(key, tag, 0);
+	if (!p)
+		return 0;
+	return *p;
+}
diff --git a/attr.h b/attr.h
new file mode 100644
index 0000000..aa5750c
--- /dev/null
+++ b/attr.h
@@ -0,0 +1,18 @@
+#ifndef _SPARSE_ATTR_H
+#define _SPARSE_ATTR_H
+
+enum attr_tags {
+	ATTR_TAG_MACRO_DEP = 1,
+	ATTR_TAG_FLAGS = 2,
+	ATTR_TAG_MACRO_EXP = 3
+};
+
+#define SET_MACRO_DEP(a,v) set_attr(a, ATTR_TAG_MACRO_DEP, v)
+#define GET_MACRO_DEP(a) ((struct macro_dep *)get_attr(a, ATTR_TAG_MACRO_DEP))
+#define NEW_MACRO_DEP() ((struct macro_dep *)attr_data(ATTR_TAG_MACRO_DEP))
+
+extern void *set_attr(void *key, enum attr_tags tag, void *data);
+extern void *get_attr(void *key, enum attr_tags tag);
+extern void *attr_data(enum attr_tags tag);
+
+#endif
diff --git a/depend.c b/depend.c
new file mode 100644
index 0000000..f36134a
--- /dev/null
+++ b/depend.c
@@ -0,0 +1,329 @@
+/*
+ * Build macros dependency tree 
+ * Copyright (C) 2012 Konrad Eisele <konrad@gaisler.com,eiselekd@gmail.com>
+ * BSD-License
+ * Redistribution and use in source and binary forms are permitted
+ * provided that the above copyright notice and this paragraph are
+ * duplicated in all such forms and that any documentation,
+ * advertising materials, and other materials related to such
+ * distribution and use acknowledge that the software was developed
+ * by the <organization>.  The name of the
+ * University may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <assert.h>
+#include "token.h"
+#include "allocate.h"
+#include "compat.h"
+#include "depend.h"
+#include "attr.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+
+__DECLARE_ALLOCATOR(struct dep_flags, dep_flags);
+__ALLOCATOR(struct dep_flags, "dependency flags", dep_flags);
+__DECLARE_ALLOCATOR(struct tok_macro_dep, tok_macro_dep);
+__ALLOCATOR(struct tok_macro_dep, "token macro expansion relation", tok_macro_dep);
+__DECLARE_ALLOCATOR(struct macro_dep_el, macro_dep_el);
+__ALLOCATOR(struct macro_dep_el, "macro dependency element", macro_dep_el);
+
+static void * push_dep(struct depend_if *dif, struct token *tok);
+static void * else_dep(struct depend_if *dif, struct token *tok);
+static void * pop_dep(struct depend_if *dif, struct token *tok);
+static void * push_sym(struct depend_if *dif, struct symbol *sym);
+static void * on_dep(struct depend_if *dif, void *p);
+static void * off_dep(struct depend_if *dif, void *p);
+static void * tag_dep(struct depend_if *dif,struct token *tok);
+static void * set_tok(struct depend_if *dif,void *p, struct token *tok);
+static void * end_tok(struct depend_if *dif,void *p, struct token *tok);
+static void * inherit_tok(struct depend_if *dif,void *a, void *b);
+static void * set_symlist(struct depend_if *dif,void *a, struct symbol_list * l);
+static void * macro_exp(struct depend_if *dif,struct token *tok, struct tok_macro_dep *m);
+
+static void depend_symbol_list(struct symbol_list *ptrlist);
+static void depend_expression(struct expression *expr);
+static void depend_statement(struct statement *stmt);
+
+struct depend_if d = {
+	.push_dep = push_dep,
+	.else_dep = else_dep,
+	.pop_dep = pop_dep,
+	.push_sym = push_sym,
+	.on = on_dep,
+	.off = off_dep,
+	.tag_dep = tag_dep,
+	.set_tok = set_tok,
+	.end_tok = end_tok,
+	.inherit_tok = inherit_tok,
+	.set_symlist = set_symlist,
+	.macro_exp = macro_exp,
+	.dep = &d.root_dep,
+};
+
+struct macro_dep *alloc_macro_dep(struct token *tok) {
+	struct macro_dep *e;
+	e = __alloc_macro_dep(0);
+	e->ppline = tok;
+	return e;
+}
+
+static int is_root(struct depend_if *dif) {
+	return dif->dep == &dif->root_dep ? 1 : 0;
+}
+
+static void *on_dep(struct depend_if *dif, void *p) {
+	dif->dep_use = dif->dep;
+	return 0;
+}
+
+static void *off_dep(struct depend_if *dif, void *p) {
+	dif->dep_use = 0;
+	return 0;
+}
+
+static void *push_dep(struct depend_if *dif, struct token *tok) {
+	struct macro_dep *e = alloc_macro_dep(tok);
+	e->up = dif->dep;
+	dif->dep = e;
+	on_dep(dif, 0);
+	return e;
+}
+
+/* push a macro_dep not on top of stack but one below, to reference <tok> */
+static void *else_dep(struct depend_if *dif, struct token *tok) {
+	struct macro_dep *e;
+	e = alloc_macro_dep(tok);
+	e->up = dif->dep->up;
+	dif->dep->up = e;
+	return e;
+}
+
+static void *pop_dep(struct depend_if *dif, struct token *tok) {
+	struct macro_dep *r = 0;
+	if (!is_root(dif)) {
+		dif->dep = dif->dep->up;
+	}
+	return r;
+}
+
+static void *push_sym(struct depend_if *dif, struct symbol *sym) {
+	
+	struct macro_dep_el *e = 0;
+	if (dif->dep_use) {
+		e = __alloc_macro_dep_el(0);
+		e->sym = sym;
+		e->n = dif->dep_use->f;
+		dif->dep_use->f = e;
+	}
+	return e;
+}
+
+static void * tag_dep(struct depend_if *dif,struct token *tok)
+{
+	struct macro_dep *a = 0, *c, *d = GET_MACRO_DEP(tok);
+	if (!eof_token(tok) && (a = dif->dep) && !is_root(dif)) {
+		if (d) {
+			c = alloc_macro_dep(0);
+			c->up = a;
+			c->same = d;
+			a = c;
+		}
+		SET_MACRO_DEP(tok, a);
+	}
+	return a;
+}
+
+void init_dep(void) {
+	dif = &d;
+	token_allocator_nofree();
+}
+
+struct dep_flags *depend_flags(void *p, int create) {
+	struct dep_flags *f;
+	if (!(f = (struct dep_flags *)get_attr(p, ATTR_TAG_FLAGS))) {
+		if (create) {
+			f = __alloc_dep_flags(0);
+			memset(f, 0, sizeof(struct dep_flags));
+			set_attr(p, ATTR_TAG_FLAGS, f);
+		}
+	}
+	return f;
+}
+
+struct dep_flags *depend_visited(void *p) {
+	struct dep_flags *f = 0; int r = 1;
+	if (p) {
+		f = depend_flags(p,1);
+		r = f->visited;
+		f->visited = 1;
+	}
+	return r ? 0 : f;
+}
+
+static void * set_tok(struct depend_if *dif,void *p, struct token *tok)
+{
+	struct dep_flags *f = depend_flags(p,1);
+	f->tok = tok;
+	return f;
+}
+
+static void * end_tok(struct depend_if *dif,void *p, struct token *tok)
+{
+	struct dep_flags *f = depend_flags(p,1);
+	f->end = tok;
+	return f;
+}
+
+static void * inherit_tok(struct depend_if *dif,void *a, void *b)
+{
+	struct dep_flags *af = depend_flags(a,1);
+	struct dep_flags *bf = depend_flags(b,1);
+	af->tok = bf->tok;
+	af->end = bf->end;
+	return af;
+}
+
+static void * set_symlist(struct depend_if *dif,void *a, struct symbol_list * l)
+{
+	struct dep_flags *f = depend_flags(a,1);
+	f->symlist = l;
+	return f;
+}
+
+static void * macro_exp(struct depend_if *dif, struct token *tok, struct tok_macro_dep *m) {
+	struct tok_macro_dep *p = 0;
+	if (tok && m) {
+		p  = __alloc_tok_macro_dep(0);
+		*p = *m;
+		set_attr(tok, ATTR_TAG_MACRO_EXP, p);
+		return p;
+	}
+	return p;
+}
+
+void depend_statement_list(struct ptr_list *ptrlist)
+{
+	void *ptr;
+	if (!ptrlist)
+		return;
+	FOR_EACH_PTR(ptrlist, ptr) {
+		depend_statement(ptr);
+	} END_FOR_EACH_PTR(ptr);
+}
+
+void depend_symbol_list(struct symbol_list *ptrlist)
+{
+	void *ptr;
+	if (!ptrlist) 
+		return;
+	FOR_EACH_PTR(((struct ptr_list *)ptrlist), ptr) {
+		depend_symbol(ptr);
+	} END_FOR_EACH_PTR(ptr);
+}
+
+void depend_statement(struct statement *stmt)
+{
+	struct dep_flags *f;
+	if (!(f = depend_visited(stmt)))
+		return;
+	
+	switch (stmt->type) {
+	case STMT_COMPOUND:
+		depend_statement_list((struct ptr_list *)stmt->stmts);
+		break;
+	case STMT_EXPRESSION:
+		depend_expression(stmt->expression);
+		break;
+	case STMT_IF:
+		depend_expression(stmt->if_conditional);
+		depend_statement(stmt->if_true);
+		depend_statement(stmt->if_false);
+		break;
+	case STMT_ITERATOR:
+		depend_symbol(stmt->iterator_break);
+		depend_symbol(stmt->iterator_continue);
+		depend_statement(stmt->iterator_pre_statement);
+		depend_statement(stmt->iterator_statement);
+		depend_statement(stmt->iterator_post_statement);
+		break;
+	case STMT_SWITCH:
+		depend_expression(stmt->switch_expression);
+		depend_statement(stmt->switch_statement);
+		depend_symbol(stmt->switch_break);
+		depend_symbol(stmt->switch_case);
+		break;
+	case STMT_CASE:
+		depend_expression(stmt->case_expression);
+		depend_expression(stmt->case_to);
+		depend_statement(stmt->case_statement);
+		depend_symbol(stmt->case_label);
+		break;
+	case STMT_RETURN:
+		depend_expression(stmt->ret_value);
+		depend_symbol(stmt->ret_target);
+		break;
+	default:
+		break;
+	}
+}
+
+void depend_expression(struct expression *expr)
+{
+	struct dep_flags *f;
+	if (!(f = depend_visited(expr)))
+		return;
+	switch (expr->type) {
+	case EXPR_STATEMENT:
+		depend_statement(expr->statement);
+		break;
+	case EXPR_BINOP:
+	case EXPR_COMMA:
+	case EXPR_COMPARE:
+	case EXPR_LOGICAL:
+	case EXPR_ASSIGNMENT:
+		depend_expression(expr->left);
+		depend_expression(expr->right);
+		break;
+	case EXPR_CAST:
+	case EXPR_FORCE_CAST:
+	case EXPR_IMPLIED_CAST:
+		depend_symbol(expr->cast_type);
+		depend_expression(expr->cast_expression);
+		break;
+	case EXPR_PREOP:
+		depend_expression(expr->unop);
+		break;
+	default:
+		break;
+	}
+}
+
+void depend_symbol(struct symbol *sym)
+{
+	struct dep_flags *f;
+	if (!(f = depend_visited(sym)))
+		return;
+	
+	depend_symbol(sym->ctype.base_type);
+	depend_symbol_list(f->symlist);
+
+	switch (sym->namespace) {
+	case NS_PREPROCESSOR:
+		break;
+	case NS_MACRO:
+		/*depend_macro_dep(sym->dep);*/
+	default:
+		/*use_line_fromto(sym->token, sym->endtoken);*/
+		depend_symbol_list(sym->arguments);
+		depend_symbol_list(sym->symbol_list);
+		depend_statement(sym->stmt);
+		break;
+	}
+}
diff --git a/depend.h b/depend.h
new file mode 100644
index 0000000..34a2159
--- /dev/null
+++ b/depend.h
@@ -0,0 +1,91 @@
+/*
+ * Build macros dependency tree 
+ * Copyright (C) 2012 Konrad Eisele <konrad@gaisler.com>
+ * BSD-License
+ * Redistribution and use in source and binary forms are permitted
+ * provided that the above copyright notice and this paragraph are
+ * duplicated in all such forms and that any documentation,
+ * advertising materials, and other materials related to such
+ * distribution and use acknowledge that the software was developed
+ * by the <organization>.  The name of the
+ * University may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ */
+
+#ifndef _SPARSE_DEPEND_H
+#define _SPARSE_DEPEND_H
+
+#include "attr.h"
+#include "token.h"
+
+struct macro_dep_el {
+	struct macro_dep_el *n;
+	struct symbol *sym;
+};
+
+struct macro_dep {
+	struct macro_dep *up, *same;
+	struct token *ppline;
+	struct macro_dep_el *f;
+	int visited : 1;
+};
+
+struct dep_flags {
+	struct token *tok;
+	struct token *end;
+	struct symbol_list *symlist;
+	unsigned int visited : 1;
+};
+
+struct macro_expansion {
+	int nargs;
+	struct symbol *sym;
+	struct token *m;
+	struct arg args[0];
+};
+
+struct tok_macro_dep {
+	struct macro_expansion *m;
+	unsigned int argi;
+	unsigned int isbody : 1;
+	unsigned int visited : 1;
+};
+
+struct depend_if {
+	/* ATTR_TAG_MACRO_DEP tagging */
+	void * (*push_dep)(struct depend_if *dif, struct token *tok);
+	void * (*else_dep)(struct depend_if *dif, struct token *tok);
+	void * (*pop_dep)(struct depend_if *dif, struct token *tok);
+	void * (*push_sym)(struct depend_if *dif, struct symbol *sym);
+	void * (*on)(struct depend_if *dif, void *p);
+	void * (*off)(struct depend_if *dif, void *p);
+	/* ATTR_TAG_FLAGS tagging */
+	void * (*tag_dep)(struct depend_if *dif,struct token *tok);
+	void * (*set_tok)(struct depend_if *dif,void *p, struct token *tok);
+	void * (*end_tok)(struct depend_if *dif,void *p, struct token *tok);
+	void * (*inherit_tok)(struct depend_if *dif,void *a, void *b);
+	void * (*set_symlist)(struct depend_if *dif,void *a, struct symbol_list * l);
+	/* ATTR_TAG_MACRO_EXP tagging */
+	void * (*macro_exp)(struct depend_if *dif, struct token *tok, struct tok_macro_dep *m);
+	
+	struct macro_dep *dep, *dep_use;
+	struct macro_dep root_dep;
+};
+
+#define DEPEN() (dif != 0)
+#define DEPCALL(f,v) if (DEPEN()) dif->f(dif,v)
+#define DEP_TOK(p,tok) if (DEPEN()) dif->set_tok(dif,p,tok)
+#define DEP_INHERIT(a,b) if (DEPEN()) dif->inherit_tok(dif,a,b)
+#define DEP_END(p,tok) if (DEPEN()) dif->end_tok(dif,p,tok)
+#define DEP_SYMLIST(p,l) if (DEPEN()) dif->set_symlist(dif,p,l)
+#define DEP_MACRO_EXP(p,m,i,b) if (DEPEN()) {		\
+		struct tok_macro_dep n = { m, i, b };	\
+		dif->macro_exp(dif,p,&n);		\
+	}
+
+extern void init_dep(void);
+extern void depend_symbol(struct symbol *sym);
+#endif
diff --git a/expand.c b/expand.c
index 63a9075..cf292e1 100644
--- a/expand.c
+++ b/expand.c
@@ -859,6 +859,7 @@ static int expand_pos_expression(struct expression *expr)
 						 * zero..
 						 */
 						reuse = alloc_expression(entry->pos, EXPR_POS);
+						DEP_INHERIT (reuse, entry);
 					}
 					reuse->type = EXPR_POS;
 					reuse->ctype = entry->ctype;
diff --git a/expression.c b/expression.c
index 0ae3a60..9ae8148 100644
--- a/expression.c
+++ b/expression.c
@@ -47,7 +47,7 @@ struct token *parens_expression(struct token *token, struct expression **expr, c
 {
 	token = expect(token, '(', where);
 	if (match_op(token, '{')) {
-		struct expression *e = alloc_expression(token->pos, EXPR_STATEMENT);
+		struct expression *e = alloc_expression_tok(token, EXPR_STATEMENT);
 		struct statement *stmt = alloc_statement(token->pos, STMT_COMPOUND);
 		*expr = e;
 		e->statement = stmt;
@@ -116,7 +116,7 @@ static int convert_function(struct token *next)
 static struct token *parse_type(struct token *token, struct expression **tree)
 {
 	struct symbol *sym;
-	*tree = alloc_expression(token->pos, EXPR_TYPE);
+	*tree = alloc_expression_tok(token, EXPR_TYPE);
 	(*tree)->flags = Int_const_expr; /* sic */
 	token = typename(token, &sym, NULL);
 	if (sym->ident)
@@ -130,8 +130,8 @@ static struct token *parse_type(struct token *token, struct expression **tree)
 static struct token *builtin_types_compatible_p_expr(struct token *token,
 						     struct expression **tree)
 {
-	struct expression *expr = alloc_expression(
-		token->pos, EXPR_COMPARE);
+	struct expression *expr = alloc_expression_tok(
+		token, EXPR_COMPARE);
 	expr->flags = Int_const_expr;
 	expr->op = SPECIAL_EQUAL;
 	token = token->next;
@@ -185,7 +185,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 		default:
 			return expect(token, ')', "at end of __builtin_offset");
 		case SPECIAL_DEREFERENCE:
-			e = alloc_expression(token->pos, EXPR_OFFSETOF);
+			e = alloc_expression_tok(token, EXPR_OFFSETOF);
 			e->flags = Int_const_expr;
 			e->op = '[';
 			*p = e;
@@ -193,7 +193,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			/* fall through */
 		case '.':
 			token = token->next;
-			e = alloc_expression(token->pos, EXPR_OFFSETOF);
+			e = alloc_expression_tok(token, EXPR_OFFSETOF);
 			e->flags = Int_const_expr;
 			e->op = '.';
 			if (token_type(token) != TOKEN_IDENT) {
@@ -205,7 +205,7 @@ static struct token *builtin_offsetof_expr(struct token *token,
 			break;
 		case '[':
 			token = token->next;
-			e = alloc_expression(token->pos, EXPR_OFFSETOF);
+			e = alloc_expression_tok(token, EXPR_OFFSETOF);
 			e->flags = Int_const_expr;
 			e->op = '[';
 			token = parse_expression(token, &e->index);
@@ -406,7 +406,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 	switch (token_type(token)) {
 	case TOKEN_CHAR:
 	case TOKEN_WIDE_CHAR:
-		expr = alloc_expression(token->pos, EXPR_VALUE);   
+		expr = alloc_expression_tok(token, EXPR_VALUE);   
 		expr->flags = Int_const_expr;
 		expr->ctype = token_type(token) == TOKEN_CHAR ? &int_ctype : &long_ctype;
 		expr->value = (unsigned char) token->character;
@@ -414,13 +414,13 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 		break;
 
 	case TOKEN_NUMBER:
-		expr = alloc_expression(token->pos, EXPR_VALUE);
+		expr = alloc_expression_tok(token, EXPR_VALUE);
 		get_number_value(expr, token); /* will see if it's an integer */
 		token = token->next;
 		break;
 
 	case TOKEN_ZERO_IDENT: {
-		expr = alloc_expression(token->pos, EXPR_SYMBOL);
+		expr = alloc_expression_tok(token, EXPR_SYMBOL);
 		expr->flags = Int_const_expr;
 		expr->ctype = &int_ctype;
 		expr->symbol = &zero_int;
@@ -445,7 +445,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 				break;
 			}
 		} else if (sym->enum_member) {
-			expr = alloc_expression(token->pos, EXPR_VALUE);
+			expr = alloc_expression_tok(token, EXPR_VALUE);
 			*expr = *sym->initializer;
 			/* we want the right position reported, thus the copy */
 			expr->pos = token->pos;
@@ -454,7 +454,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			break;
 		}
 
-		expr = alloc_expression(token->pos, EXPR_SYMBOL);
+		expr = alloc_expression_tok(token, EXPR_SYMBOL);
 
 		/*
 		 * We support types as real first-class citizens, with type
@@ -475,7 +475,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 	case TOKEN_STRING:
 	case TOKEN_WIDE_STRING: {
 	handle_string:
-		expr = alloc_expression(token->pos, EXPR_STRING);
+		expr = alloc_expression_tok(token, EXPR_STRING);
 		expr->wide = token_type(token) == TOKEN_WIDE_STRING;
 		token = string_expression(token, expr);
 		break;
@@ -483,7 +483,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 
 	case TOKEN_SPECIAL:
 		if (token->special == '(') {
-			expr = alloc_expression(token->pos, EXPR_PREOP);
+			expr = alloc_expression_tok(token, EXPR_PREOP);
 			expr->op = '(';
 			token = parens_expression(token, &expr->unop, "in expression");
 			if (expr->unop)
@@ -491,7 +491,7 @@ struct token *primary_expression(struct token *token, struct expression **tree)
 			break;
 		}
 		if (token->special == '[' && lookup_type(token->next)) {
-			expr = alloc_expression(token->pos, EXPR_TYPE);
+			expr = alloc_expression_tok(token, EXPR_TYPE);
 			expr->flags = Int_const_expr; /* sic */
 			token = typename(token->next, &expr->symbol, NULL);
 			token = expect(token, ']', "in type expression");
@@ -534,8 +534,8 @@ static struct token *postfix_expression(struct token *token, struct expression *
 	while (expr && token_type(token) == TOKEN_SPECIAL) {
 		switch (token->special) {
 		case '[': {			/* Array dereference */
-			struct expression *deref = alloc_expression(token->pos, EXPR_PREOP);
-			struct expression *add = alloc_expression(token->pos, EXPR_BINOP);
+			struct expression *deref = alloc_expression_tok(token, EXPR_PREOP);
+			struct expression *add = alloc_expression_tok(token, EXPR_BINOP);
 
 			deref->op = '*';
 			deref->unop = add;
@@ -549,7 +549,7 @@ static struct token *postfix_expression(struct token *token, struct expression *
 		}
 		case SPECIAL_INCREMENT:		/* Post-increment */
 		case SPECIAL_DECREMENT:	{	/* Post-decrement */
-			struct expression *post = alloc_expression(token->pos, EXPR_POSTOP);
+			struct expression *post = alloc_expression_tok(token, EXPR_POSTOP);
 			post->op = token->special;
 			post->unop = expr;
 			expr = post;
@@ -558,14 +558,14 @@ static struct token *postfix_expression(struct token *token, struct expression *
 		}
 		case SPECIAL_DEREFERENCE: {	/* Structure pointer member dereference */
 			/* "x->y" is just shorthand for "(*x).y" */
-			struct expression *inner = alloc_expression(token->pos, EXPR_PREOP);
+			struct expression *inner = alloc_expression_tok(token, EXPR_PREOP);
 			inner->op = '*';
 			inner->unop = expr;
 			expr = inner;
 		}
 		/* Fall through!! */
 		case '.': {			/* Structure member dereference */
-			struct expression *deref = alloc_expression(token->pos, EXPR_DEREF);
+			struct expression *deref = alloc_expression_tok(token, EXPR_DEREF);
 			deref->op = '.';
 			deref->deref = expr;
 			token = token->next;
@@ -580,7 +580,7 @@ static struct token *postfix_expression(struct token *token, struct expression *
 		}
 
 		case '(': {			/* Function call */
-			struct expression *call = alloc_expression(token->pos, EXPR_CALL);
+			struct expression *call = alloc_expression_tok(token, EXPR_CALL);
 			call->op = '(';
 			call->fn = expr;
 			token = expression_list(token->next, &call->args);
@@ -604,7 +604,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 static struct token *type_info_expression(struct token *token,
 	struct expression **tree, int type)
 {
-	struct expression *expr = alloc_expression(token->pos, type);
+	struct expression *expr = alloc_expression_tok(token, type);
 	struct token *p;
 
 	*tree = expr;
@@ -630,7 +630,7 @@ static struct token *type_info_expression(struct token *token,
 	 * of a typed initializer expression..
 	 */
 	if (match_op(token, '{')) {
-		struct expression *cast = alloc_expression(p->pos, EXPR_CAST);
+		struct expression *cast = alloc_expression_tok(p, EXPR_CAST);
 		cast->cast_type = expr->cast_type;
 		expr->cast_type = NULL;
 		expr->cast_expression = cast;
@@ -676,7 +676,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				*tree = NULL;
 				return next;
 			}
-			unary = alloc_expression(token->pos, EXPR_PREOP);
+			unary = alloc_expression_tok(token, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
 			*tree = unary;
@@ -694,7 +694,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				*tree = NULL;
 				return next;
 			}
-			unary = alloc_expression(token->pos, EXPR_PREOP);
+			unary = alloc_expression_tok(token, EXPR_PREOP);
 			unary->op = token->special;
 			unary->unop = unop;
 			unary->flags = unop->flags & Int_const_expr;
@@ -704,7 +704,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 		/* Gcc extension: &&label gives the address of a label */
 		if (match_op(token, SPECIAL_LOGICAL_AND) &&
 		    token_type(token->next) == TOKEN_IDENT) {
-			struct expression *label = alloc_expression(token->pos, EXPR_LABEL);
+			struct expression *label = alloc_expression_tok(token, EXPR_LABEL);
 			struct symbol *sym = label_symbol(token->next);
 			if (!(sym->ctype.modifiers & MOD_ADDRESSABLE)) {
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
@@ -733,7 +733,7 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 	if (match_op(token, '(')) {
 		struct token *next = token->next;
 		if (lookup_type(next)) {
-			struct expression *cast = alloc_expression(next->pos, EXPR_CAST);
+			struct expression *cast = alloc_expression_tok(next, EXPR_CAST);
 			struct expression *v;
 			struct symbol *sym;
 			int is_force;
@@ -789,7 +789,7 @@ static struct token *cast_expression(struct token *token, struct expression **tr
 									\
 			if (!(compare))					\
 				goto out;				\
-			top = alloc_expression(next->pos, type);	\
+			top = alloc_expression_tok(next, type);	\
 			next = inner(next->next, &right);		\
 			if (!right) {					\
 				sparse_error(next->pos, "No right hand side of '%s'-expression", show_special(op));	\
@@ -892,7 +892,7 @@ struct token *conditional_expression(struct token *token, struct expression **tr
 {
 	token = logical_or_expression(token, tree);
 	if (*tree && match_op(token, '?')) {
-		struct expression *expr = alloc_expression(token->pos, EXPR_CONDITIONAL);
+		struct expression *expr = alloc_expression_tok(token, EXPR_CONDITIONAL);
 		expr->op = token->special;
 		expr->left = *tree;
 		*tree = expr;
@@ -925,7 +925,7 @@ struct token *assignment_expression(struct token *token, struct expression **tre
 		int i, op = token->special;
 		for (i = 0; i < ARRAY_SIZE(assignments); i++)
 			if (assignments[i] == op) {
-				struct expression * expr = alloc_expression(token->pos, EXPR_ASSIGNMENT);
+				struct expression * expr = alloc_expression_tok(token, EXPR_ASSIGNMENT);
 				expr->left = *tree;
 				expr->op = op;
 				*tree = expr;
diff --git a/expression.h b/expression.h
index 9778de8..95edf0f 100644
--- a/expression.h
+++ b/expression.h
@@ -14,6 +14,7 @@
 #include "allocate.h"
 #include "lib.h"
 #include "symbol.h"
+#include "depend.h"
 
 struct expression_list;
 
@@ -185,6 +186,13 @@ static inline struct expression *alloc_expression(struct position pos, int type)
 	return expr;
 }
 
+static inline struct expression *alloc_expression_tok(struct token *tok, int type)
+{
+	struct expression *e = alloc_expression(tok->pos, type);
+	DEP_TOK(e, tok);
+	return e;
+}
+
 static inline struct expression *alloc_const_expression(struct position pos, int value)
 {
 	struct expression *expr = __alloc_expression(0);
diff --git a/inline.c b/inline.c
index 9ed4570..5ba1747 100644
--- a/inline.c
+++ b/inline.c
@@ -20,6 +20,7 @@
 static struct expression * dup_expression(struct expression *expr)
 {
 	struct expression *dup = alloc_expression(expr->pos, expr->type);
+	DEP_INHERIT (dup, expr);
 	*dup = *expr;
 	return dup;
 }
@@ -27,6 +28,7 @@ static struct expression * dup_expression(struct expression *expr)
 static struct statement * dup_statement(struct statement *stmt)
 {
 	struct statement *dup = alloc_statement(stmt->pos, stmt->type);
+	DEP_INHERIT (dup, stmt);
 	*dup = *stmt;
 	return dup;
 }
@@ -142,6 +144,7 @@ static struct expression * copy_expression(struct expression *expr)
 			expr = dup_expression(expr);
 			expr->cast_expression = copy_expression(cast);
 			expr->cast_type = alloc_symbol(sym->pos, sym->type);
+			DEP_INHERIT (expr->cast_type, sym);
 			*expr->cast_type = *sym;
 			break;
 		}
@@ -176,6 +179,7 @@ static struct expression * copy_expression(struct expression *expr)
 	/* Statement expression */
 	case EXPR_STATEMENT: {
 		struct statement *stmt = alloc_statement(expr->pos, STMT_COMPOUND);
+		DEP_INHERIT (stmt, expr);
 		copy_statement(expr->statement, stmt);
 		expr = dup_expression(expr);
 		expr->statement = stmt;
@@ -347,6 +351,7 @@ static struct statement *copy_one_statement(struct statement *stmt)
 	}
 	case STMT_COMPOUND: {
 		struct statement *new = alloc_statement(stmt->pos, STMT_COMPOUND);
+		DEP_INHERIT (new, stmt);
 		copy_statement(stmt, new);
 		stmt = new;
 		break;
@@ -469,6 +474,7 @@ static struct symbol *create_copy_symbol(struct symbol *orig)
 	struct symbol *sym = orig;
 	if (orig) {
 		sym = alloc_symbol(orig->pos, orig->type);
+		DEP_INHERIT (sym, orig);
 		*sym = *orig;
 		sym->bb_target = NULL;
 		sym->pseudo = NULL;
@@ -499,6 +505,7 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	struct symbol_list *name_list, *arg_decl;
 	struct symbol *name;
 	struct expression *arg;
+	DEP_INHERIT (stmt, expr);
 
 	if (!fn->inline_stmt) {
 		sparse_error(fn->pos, "marked inline, but without a definition");
@@ -521,6 +528,7 @@ int inline_function(struct expression *expr, struct symbol *sym)
 	PREPARE_PTR_LIST(name_list, name);
 	FOR_EACH_PTR(arg_list, arg) {
 		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
+		DEP_INHERIT (a, arg);
 
 		a->ctype.base_type = arg->ctype;
 		if (name) {
@@ -539,6 +547,7 @@ int inline_function(struct expression *expr, struct symbol *sym)
 
 	if (arg_decl) {
 		struct statement *decl = alloc_statement(expr->pos, STMT_DECLARATION);
+		DEP_INHERIT (decl, expr);
 		decl->declaration = arg_decl;
 		stmt->args = decl;
 	}
@@ -563,6 +572,7 @@ void uninline(struct symbol *sym)
 		p->replace = p;
 	} END_FOR_EACH_PTR(p);
 	fn->stmt = alloc_statement(fn->pos, STMT_COMPOUND);
+	DEP_INHERIT (fn->stmt, fn);
 	copy_statement(fn->inline_stmt, fn->stmt);
 	unset_replace_list(sym->symbol_list);
 	unset_replace_list(arg_list);
diff --git a/lib.c b/lib.c
index 396e9f1..d835870 100644
--- a/lib.c
+++ b/lib.c
@@ -213,6 +213,8 @@ int Wundef = 0;
 int Wuninitialized = 1;
 int Wdeclarationafterstatement = -1;
 
+int fnobuiltin = 0;
+
 int dbg_entry = 0;
 int dbg_dead = 0;
 
@@ -553,6 +555,9 @@ static char **handle_switch_f(char *arg, char **next)
 		arg += 3;
 	}
 	/* handle switch here.. */
+	if (!strncmp(arg, "builtin", 7)) {
+		fnobuiltin = 1;
+	}
 	return next;
 }
 
@@ -668,6 +673,9 @@ static char **handle_switch(char *arg, char **next)
 
 void declare_builtin_functions(void)
 {
+	if (fnobuiltin)
+		return;
+	
 	/* Gaah. gcc knows tons of builtin <string.h> functions */
 	add_pre_buffer("extern void *__builtin_memcpy(void *, const void *, __SIZE_TYPE__);\n");
 	add_pre_buffer("extern void *__builtin_mempcpy(void *, const void *, __SIZE_TYPE__);\n");
diff --git a/parse.c b/parse.c
index bd42180..f7bfc1c 100644
--- a/parse.c
+++ b/parse.c
@@ -652,9 +652,9 @@ static void apply_modifiers(struct position pos, struct decl_state *ctx)
 	
 }
 
-static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *ctype, int type)
+static struct symbol * alloc_indirect_symbol(struct token *tok, struct ctype *ctype, int type)
 {
-	struct symbol *sym = alloc_symbol(pos, type);
+	struct symbol *sym = alloc_symbol_tok(tok, type);
 
 	sym->ctype.base_type = ctype->base_type;
 	sym->ctype.modifiers = ctype->modifiers;
@@ -673,7 +673,7 @@ struct symbol *label_symbol(struct token *token)
 {
 	struct symbol *sym = lookup_symbol(token->ident, NS_LABEL);
 	if (!sym) {
-		sym = alloc_symbol(token->pos, SYM_LABEL);
+		sym = alloc_symbol_tok(token, SYM_LABEL);
 		bind_symbol(sym, token->ident, NS_LABEL);
 		fn_local_symbol(sym);
 	}
@@ -695,7 +695,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 		     (match_op(token->next,';') || match_op(token->next,'{')))) {
 			// Either a new symbol, or else an out-of-scope
 			// symbol being redefined.
-			sym = alloc_symbol(token->pos, type);
+			sym = alloc_symbol_tok(token, type);
 			bind_symbol(sym, token->ident, NS_STRUCT);
 		}
 		if (sym->type != type)
@@ -716,6 +716,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 			// Mark the structure as needing re-examination
 			sym->examined = 0;
 			sym->endpos = token->pos;
+			DEP_END (sym, token);
 		}
 		return token;
 	}
@@ -727,11 +728,12 @@ static struct token *struct_union_enum_specifier(enum type type,
 		return token;
 	}
 
-	sym = alloc_symbol(token->pos, type);
+	sym = alloc_symbol_tok(token, type);
 	token = parse(token->next, sym);
 	ctx->ctype.base_type = sym;
 	token =  expect(token, '}', "at end of specifier");
 	sym->endpos = token->pos;
+	DEP_END (sym, token);
 
 	return token;
 }
@@ -875,7 +877,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 			expr->ctype = ctype;
 		}
 
-		sym = alloc_symbol(token->pos, SYM_NODE);
+		sym = alloc_symbol_tok(token, SYM_NODE);
 		bind_symbol(sym, token->ident, NS_SYMBOL);
 		sym->ctype.modifiers &= ~MOD_ADDRESSABLE;
 		sym->initializer = expr;
@@ -926,6 +928,7 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 		token = next;
 
 		sym->endpos = token->pos;
+		DEP_END (sym, token);
 
 		if (!match_op(token, ','))
 			break;
@@ -988,10 +991,11 @@ static struct token *typeof_specifier(struct token *token, struct decl_state *ct
 		ctx->ctype.base_type = sym->ctype.base_type;
 		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
 	} else {
-		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
+		struct symbol *typeof_sym = alloc_symbol_tok(token, SYM_TYPEOF);
 		token = parse_expression(token->next, &typeof_sym->initializer);
 
 		typeof_sym->endpos = token->pos;
+		DEP_END (typeof_sym, token);
 		if (!typeof_sym->initializer) {
 			sparse_error(token->pos, "expected expression after the '(' token");
 			typeof_sym = &bad_ctype;
@@ -1440,6 +1444,8 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 						 NS_TYPEDEF | NS_SYMBOL);
 		if (!s || !(s->namespace & NS_TYPEDEF))
 			break;
+		if (DEPEN())
+			add_symbol (&ctx->dep, s);
 		if (s->type != SYM_KEYWORD) {
 			if (seen & Set_Any)
 				break;
@@ -1493,7 +1499,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
 			sparse_error(token->pos, "invalid modifier");
 			return token;
 		}
-		type = alloc_symbol(token->pos, SYM_BASETYPE);
+		type = alloc_symbol_tok(token, SYM_BASETYPE);
 		*type = *ctx->ctype.base_type;
 		type->ctype.modifiers &= ~MOD_SPECIFIER;
 		type->ctype.base_type = ctx->ctype.base_type;
@@ -1679,7 +1685,7 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 	if (match_op(token, '(')) {
 		enum kind kind = which_func(token, p, ctx->prefer_abstract);
 		struct symbol *fn;
-		fn = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
+		fn = alloc_indirect_symbol(token, ctype, SYM_FN);
 		token = token->next;
 		if (kind == K_R)
 			token = identifier_list(token, fn);
@@ -1687,15 +1693,17 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 			token = parameter_type_list(token, fn);
 		token = expect(token, ')', "in function declarator");
 		fn->endpos = token->pos;
+		DEP_END (fn, token);
 		return token;
 	}
 
 	while (match_op(token, '[')) {
 		struct symbol *array;
-		array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
+		array = alloc_indirect_symbol(token, ctype, SYM_ARRAY);
 		token = abstract_array_declarator(token->next, array);
 		token = expect(token, ']', "in abstract_array_declarator");
 		array->endpos = token->pos;
+		DEP_END (array, token);
 		ctype = &array->ctype;
 	}
 	return token;
@@ -1704,7 +1712,7 @@ static struct token *direct_declarator(struct token *token, struct decl_state *c
 static struct token *pointer(struct token *token, struct decl_state *ctx)
 {
 	while (match_op(token,'*')) {
-		struct symbol *ptr = alloc_symbol(token->pos, SYM_PTR);
+		struct symbol *ptr = alloc_symbol_tok(token, SYM_PTR);
 		ptr->ctype.modifiers = ctx->ctype.modifiers;
 		ptr->ctype.base_type = ctx->ctype.base_type;
 		ptr->ctype.as = ctx->ctype.as;
@@ -1717,6 +1725,8 @@ static struct token *pointer(struct token *token, struct decl_state *ctx)
 
 		token = handle_qualifiers(token->next, ctx);
 		ctx->ctype.base_type->endpos = token->pos;
+		DEP_END (ctx->ctype.base_type, token);
+
 	}
 	return token;
 }
@@ -1741,7 +1751,7 @@ static struct token *handle_bitfield(struct token *token, struct decl_state *ctx
 		return conditional_expression(token->next, &expr);
 	}
 
-	bitfield = alloc_indirect_symbol(token->pos, ctype, SYM_BITFIELD);
+	bitfield = alloc_indirect_symbol(token, ctype, SYM_BITFIELD);
 	token = conditional_expression(token->next, &expr);
 	width = const_expression_value(expr);
 	bitfield->bit_size = width;
@@ -1772,6 +1782,7 @@ static struct token *handle_bitfield(struct token *token, struct decl_state *ctx
 	}
 	bitfield->bit_size = width;
 	bitfield->endpos = token->pos;
+	DEP_END (bitfield, token);
 	return token;
 }
 
@@ -1785,7 +1796,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 	mod = storage_modifiers(&ctx);
 	saved = ctx.ctype;
 	for (;;) {
-		struct symbol *decl = alloc_symbol(token->pos, SYM_NODE);
+		struct symbol *decl = alloc_symbol_tok(token, SYM_NODE);
 		ctx.ident = &decl->ident;
 
 		token = declarator(token, &ctx);
@@ -1798,6 +1809,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
 		decl->endpos = token->pos;
+		DEP_END (decl, token);
 		add_symbol(list, decl);
 		if (!match_op(token, ','))
 			break;
@@ -1833,6 +1845,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol *s
 	sym->ctype = ctx.ctype;
 	sym->ctype.modifiers |= storage_modifiers(&ctx);
 	sym->endpos = token->pos;
+	DEP_END (sym, token);
 	return token;
 }
 
@@ -1840,13 +1853,14 @@ struct token *typename(struct token *token, struct symbol **p, int *forced)
 {
 	struct decl_state ctx = {.prefer_abstract = 1};
 	int class;
-	struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
+	struct symbol *sym = alloc_symbol_tok(token, SYM_NODE);
 	*p = sym;
 	token = declaration_specifiers(token, &ctx);
 	token = declarator(token, &ctx);
 	apply_modifiers(token->pos, &ctx);
 	sym->ctype = ctx.ctype;
 	sym->endpos = token->pos;
+	DEP_END (sym, token);
 	class = ctx.storage_class;
 	if (forced) {
 		*forced = 0;
@@ -1965,6 +1979,7 @@ static struct statement *make_statement(struct expression *expr)
 	if (!expr)
 		return NULL;
 	stmt = alloc_statement(expr->pos, STMT_EXPRESSION);
+	DEP_INHERIT (stmt, expr);
 	stmt->expression = expr;
 	return stmt;
 }
@@ -1984,8 +1999,10 @@ static void start_iterator(struct statement *stmt)
 
 	start_symbol_scope();
 	cont = alloc_symbol(stmt->pos, SYM_NODE);
+	DEP_INHERIT (cont, stmt);
 	bind_symbol(cont, &continue_ident, NS_ITERATOR);
 	brk = alloc_symbol(stmt->pos, SYM_NODE);
+	DEP_INHERIT (brk, stmt);
 	bind_symbol(brk, &break_ident, NS_ITERATOR);
 
 	stmt->type = STMT_ITERATOR;
@@ -2004,9 +2021,11 @@ static struct statement *start_function(struct symbol *sym)
 {
 	struct symbol *ret;
 	struct statement *stmt = alloc_statement(sym->pos, STMT_COMPOUND);
+	DEP_INHERIT (stmt, sym);
 
 	start_function_scope();
 	ret = alloc_symbol(sym->pos, SYM_NODE);
+	DEP_INHERIT (ret, sym);
 	ret->ctype = sym->ctype.base_type->ctype;
 	ret->ctype.modifiers &= ~(MOD_STORAGE | MOD_CONST | MOD_VOLATILE | MOD_TLS | MOD_INLINE | MOD_ADDRESSABLE | MOD_NOCAST | MOD_NODEREF | MOD_ACCESSED | MOD_TOPLEVEL);
 	ret->ctype.modifiers |= (MOD_AUTO | MOD_REGISTER);
@@ -2044,9 +2063,11 @@ static void start_switch(struct statement *stmt)
 
 	start_symbol_scope();
 	brk = alloc_symbol(stmt->pos, SYM_NODE);
+	DEP_INHERIT (brk, stmt);
 	bind_symbol(brk, &break_ident, NS_ITERATOR);
 
 	switch_case = alloc_symbol(stmt->pos, SYM_NODE);
+	DEP_INHERIT (switch_case, stmt);
 	bind_symbol(switch_case, &case_ident, NS_ITERATOR);
 	switch_case->stmt = stmt;
 
@@ -2076,6 +2097,7 @@ static void add_case_statement(struct statement *stmt)
 		return;
 	}
 	sym = alloc_symbol(stmt->pos, SYM_NODE);
+	DEP_INHERIT (sym, stmt);
 	add_symbol(&target->symbol_list, sym);
 	sym->stmt = stmt;
 	stmt->case_label = sym;
@@ -2266,6 +2288,7 @@ static struct token *parse_range_statement(struct token *token, struct statement
 static struct token *statement(struct token *token, struct statement **tree)
 {
 	struct statement *stmt = alloc_statement(token->pos, STMT_NONE);
+	DEP_TOK (stmt, token);
 
 	*tree = stmt;
 	if (token_type(token) == TOKEN_IDENT) {
@@ -2298,7 +2321,7 @@ static struct token *statement(struct token *token, struct statement **tree)
 static struct token *label_statement(struct token *token)
 {
 	while (token_type(token) == TOKEN_IDENT) {
-		struct symbol *sym = alloc_symbol(token->pos, SYM_LABEL);
+		struct symbol *sym = alloc_symbol_tok(token, SYM_LABEL);
 		/* it's block-scope, but we want label namespace */
 		bind_symbol(sym, token->ident, NS_SYMBOL);
 		sym->namespace = NS_LABEL;
@@ -2329,6 +2352,7 @@ static struct token * statement_list(struct token *token, struct statement_list
 				seen_statement = 0;
 			}
 			stmt = alloc_statement(token->pos, STMT_DECLARATION);
+			DEP_TOK (stmt, token);
 			token = external_declaration(token, &stmt->declaration);
 		} else {
 			seen_statement = Wdeclarationafterstatement;
@@ -2343,10 +2367,11 @@ static struct token *identifier_list(struct token *token, struct symbol *fn)
 {
 	struct symbol_list **list = &fn->arguments;
 	for (;;) {
-		struct symbol *sym = alloc_symbol(token->pos, SYM_NODE);
+		struct symbol *sym = alloc_symbol_tok(token, SYM_NODE);
 		sym->ident = token->ident;
 		token = token->next;
 		sym->endpos = token->pos;
+		DEP_END (sym, token);
 		sym->ctype.base_type = &incomplete_ctype;
 		add_symbol(list, sym);
 		if (!match_op(token, ',') ||
@@ -2371,7 +2396,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn)
 			break;
 		}
 
-		sym = alloc_symbol(token->pos, SYM_NODE);
+		sym = alloc_symbol_tok(token, SYM_NODE);
 		token = parameter_declaration(token, sym);
 		if (sym->ctype.base_type == &void_ctype) {
 			/* Special case: (void) */
@@ -2642,12 +2667,13 @@ static struct token *parse_k_r_arguments(struct token *token, struct symbol *dec
 
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list)
 {
-	struct symbol *anon = alloc_symbol(token->pos, SYM_NODE);
-	struct symbol *fn = alloc_symbol(token->pos, SYM_FN);
+	struct symbol *anon = alloc_symbol_tok(token, SYM_NODE);
+	struct symbol *fn = alloc_symbol_tok(token, SYM_FN);
 	struct statement *stmt;
 
 	anon->ctype.base_type = fn;
 	stmt = alloc_statement(token->pos, STMT_NONE);
+	DEP_TOK (stmt, token);
 	fn->stmt = stmt;
 
 	token = parse_asm_statement(token, stmt);
@@ -2660,7 +2686,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 {
 	struct ident *ident = NULL;
 	struct symbol *decl;
-	struct decl_state ctx = { .ident = &ident };
+	struct decl_state ctx = { .ident = &ident, .dep = 0 };
 	struct ctype saved;
 	struct symbol *base_type;
 	unsigned long mod;
@@ -2676,7 +2702,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	/* Parse declaration-specifiers, if any */
 	token = declaration_specifiers(token, &ctx);
 	mod = storage_modifiers(&ctx);
-	decl = alloc_symbol(token->pos, SYM_NODE);
+	decl = alloc_symbol_tok(token, SYM_NODE);
 	/* Just a type declaration? */
 	if (match_op(token, ';')) {
 		apply_modifiers(token->pos, &ctx);
@@ -2691,6 +2717,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	decl->ctype = ctx.ctype;
 	decl->ctype.modifiers |= mod;
 	decl->endpos = token->pos;
+	DEP_END (decl, token);
+	DEP_SYMLIST (decl, ctx.dep);
 
 	/* Just a type declaration? */
 	if (!ident) {
@@ -2755,7 +2783,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 
 		token = token->next;
 		ident = NULL;
-		decl = alloc_symbol(token->pos, SYM_NODE);
+		decl = alloc_symbol_tok(token, SYM_NODE);
 		ctx.ctype = saved;
 		token = handle_attributes(token, &ctx, KW_ATTRIBUTE);
 		token = declarator(token, &ctx);
@@ -2764,6 +2792,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		decl->ctype = ctx.ctype;
 		decl->ctype.modifiers |= mod;
 		decl->endpos = token->pos;
+		DEP_END (decl, token);
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
 			return token;
diff --git a/parse.h b/parse.h
index b26bd03..9ff6639 100644
--- a/parse.h
+++ b/parse.h
@@ -10,6 +10,7 @@
  */
 
 #include "symbol.h"
+#include "depend.h"
 
 enum statement_type {
 	STMT_NONE,
diff --git a/pre-process.c b/pre-process.c
index 8a16f8b..3dbbb11 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -27,7 +27,10 @@
 #include "symbol.h"
 #include "expression.h"
 #include "scope.h"
+#include "depend.h"
 
+/* interface to depend.c, if set */
+struct depend_if *dif; 
 static int false_nesting = 0;
 
 #define INCLUDEPATHS 300
@@ -111,6 +114,7 @@ static struct symbol *lookup_macro(struct ident *ident)
 	struct symbol *sym = lookup_symbol(ident, NS_MACRO | NS_UNDEF);
 	if (sym && sym->namespace != NS_MACRO)
 		sym = NULL;
+	DEPCALL(push_sym, sym);
 	return sym;
 }
 
@@ -244,15 +248,6 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
  * We store arglist as <counter> [arg1] <number of uses for arg1> ... eof
  */
 
-struct arg {
-	struct token *arg;
-	struct token *expanded;
-	struct token *str;
-	int n_normal;
-	int n_quoted;
-	int n_str;
-};
-
 static int collect_arguments(struct token *start, struct token *arglist, struct arg *args, struct token *what)
 {
 	int wanted = arglist->count.normal;
@@ -325,15 +320,22 @@ out:
 	return 0;
 }
 
-static struct token *dup_list(struct token *list)
+static struct token *dup_one(struct token *list)
+{
+	struct token *newtok = __alloc_token(0);
+	*newtok = *list;
+	return newtok;
+}
+
+static struct token *dup_list(struct token *list, struct macro_expansion *me, int argi)
 {
 	struct token *res = NULL;
 	struct token **p = &res;
 
 	while (!eof_token(list)) {
-		struct token *newtok = __alloc_token(0);
-		*newtok = *list;
+		struct token *newtok = dup_one(list);
 		*p = newtok;
+		DEP_MACRO_EXP(newtok, me, argi, 0);
 		p = &newtok->next;
 		list = list->next;
 	}
@@ -356,7 +358,7 @@ static struct token *stringify(struct token *arg)
 	return token;
 }
 
-static void expand_arguments(int count, struct arg *args)
+static void expand_arguments(int count, struct arg *args, struct macro_expansion *me)
 {
 	int i;
 	for (i = 0; i < count; i++) {
@@ -372,7 +374,7 @@ static void expand_arguments(int count, struct arg *args)
 			} else if (eof_token(arg)) {
 				args[i].expanded = arg;
 			} else {
-				args[i].expanded = dup_list(arg);
+				args[i].expanded = dup_list(arg,me,i);
 			}
 			expand_list(&args[i].expanded);
 		}
@@ -472,7 +474,7 @@ static int merge(struct token *left, struct token *right)
 	return 0;
 }
 
-static struct token *dup_token(struct token *token, struct position *streampos, struct position *pos)
+static struct token *dup_token(struct token *token, struct position *streampos, struct position *pos, struct macro_expansion *me)
 {
 	struct token *alloc = alloc_token(streampos);
 	token_type(alloc) = token_type(token);
@@ -480,16 +482,17 @@ static struct token *dup_token(struct token *token, struct position *streampos,
 	alloc->pos.whitespace = pos->whitespace;
 	alloc->number = token->number;
 	alloc->pos.noexpand = token->pos.noexpand;
-	return alloc;	
+	DEP_MACRO_EXP(token, me, 0, 1);
+	return alloc;
 }
 
-static struct token **copy(struct token **where, struct token *list, int *count)
+static struct token **copy(struct token **where, struct token *list, int *count, struct macro_expansion *me)
 {
 	int need_copy = --*count;
 	while (!eof_token(list)) {
 		struct token *token;
 		if (need_copy)
-			token = dup_token(list, &list->pos, &list->pos);
+			token = dup_token(list, &list->pos, &list->pos, me);
 		else
 			token = list;
 		if (token_type(token) == TOKEN_IDENT && token->ident->tainted)
@@ -502,7 +505,7 @@ static struct token **copy(struct token **where, struct token *list, int *count)
 	return where;
 }
 
-static struct token **substitute(struct token **list, struct token *body, struct arg *args)
+static struct token **substitute(struct token **list, struct token *body, struct arg *args, struct macro_expansion *me)
 {
 	struct token *token = *list;
 	struct position *base_pos = &token->pos;
@@ -526,7 +529,7 @@ static struct token **substitute(struct token **list, struct token *body, struct
 			 */
 			if (!args[body->next->argnum].arg)
 				continue;
-			added = dup_token(body, base_pos, pos);
+			added = dup_token(body, base_pos, pos, me);
 			token_type(added) = TOKEN_SPECIAL;
 			tail = &added->next;
 			break;
@@ -556,7 +559,7 @@ static struct token **substitute(struct token **list, struct token *body, struct
 				continue;
 			}
 		copy_arg:
-			tail = copy(&added, arg, count);
+			tail = copy(&added, arg, count, me);
 			added->pos.newline = pos->newline;
 			added->pos.whitespace = pos->whitespace;
 			break;
@@ -569,14 +572,14 @@ static struct token **substitute(struct token **list, struct token *body, struct
 			continue;
 
 		case TOKEN_IDENT:
-			added = dup_token(body, base_pos, pos);
+			added = dup_token(body, base_pos, pos, me);
 			if (added->ident->tainted)
 				added->pos.noexpand = 1;
 			tail = &added->next;
 			break;
 
 		default:
-			added = dup_token(body, base_pos, pos);
+			added = dup_token(body, base_pos, pos, me);
 			tail = &added->next;
 			break;
 		}
@@ -606,7 +609,16 @@ static int expand(struct token **list, struct symbol *sym)
 	struct ident *expanding = token->ident;
 	struct token **tail;
 	int nargs = sym->arglist ? sym->arglist->count.normal : 0;
-	struct arg args[nargs];
+	struct arg _args[nargs];
+	struct arg *args = _args;
+	struct macro_expansion *me = 0;
+
+	if (DEPEN()) {
+		me = __alloc_macro_expansion(sizeof(struct arg) * nargs);
+		me->m = token;
+		me->sym = sym;
+		args = me->args;
+	}
 
 	if (expanding->tainted) {
 		token->pos.noexpand = 1;
@@ -618,13 +630,13 @@ static int expand(struct token **list, struct symbol *sym)
 			return 1;
 		if (!collect_arguments(token->next, sym->arglist, args, token))
 			return 1;
-		expand_arguments(nargs, args);
+		expand_arguments(nargs, args, me);
 	}
 
 	expanding->tainted = 1;
 
 	last = token->next;
-	tail = substitute(list, sym->expansion, args);
+	tail = substitute(list, sym->expansion, args, me);
 	*tail = last;
 
 	return 0;
@@ -907,11 +919,18 @@ static inline void set_arg_count(struct token *token)
 	token->count.str = token->count.vararg = 0;
 }
 
-static struct token *parse_arguments(struct token *list)
+#define DUP(l) (DEPEN() ? dup_one(l) : (l))
+#define DUP_NEXT(l) (DEPEN() ? (l)->next = dup_one((l)->next) : (l)->next)
+
+static struct token *parse_arguments(struct token **arglist)
 {
-	struct token *arg = list->next, *next = list;
+	struct token *list = DUP(*arglist);
+	struct token *arg = DUP_NEXT(list), *next = list;
 	struct argcount *count = &list->count;
 
+	if (DEPEN())
+		*arglist = list;
+	
 	set_arg_count(list);
 
 	if (match_op(arg, ')')) {
@@ -925,11 +944,11 @@ static struct token *parse_arguments(struct token *list)
 			goto Eva_args;
 		if (!++count->normal)
 			goto Eargs;
-		next = arg->next;
+		next = DUP_NEXT(arg);
 
 		if (match_op(next, ',')) {
 			set_arg_count(next);
-			arg = next->next;
+			arg = DUP_NEXT(next);
 			continue;
 		}
 
@@ -964,7 +983,7 @@ static struct token *parse_arguments(struct token *list)
 	}
 
 	if (match_op(arg, SPECIAL_ELLIPSIS)) {
-		next = arg->next;
+		next = DUP_NEXT(arg);
 		token_type(arg) = TOKEN_IDENT;
 		arg->ident = &__VA_ARGS___ident;
 		if (!match_op(next, ')'))
@@ -1125,7 +1144,7 @@ static int do_handle_define(struct stream *stream, struct token **line, struct t
 	if (!expansion->pos.whitespace) {
 		if (match_op(expansion, '(')) {
 			arglist = expansion;
-			expansion = parse_arguments(expansion);
+			expansion = parse_arguments(&arglist);
 			if (!expansion)
 				return 1;
 		} else if (!eof_token(expansion)) {
@@ -1299,6 +1318,8 @@ static int expression_value(struct token **where)
 	long long value;
 	int state = 0;
 
+	DEPCALL(on, *list);
+	
 	while (!eof_token(p = scan_next(list))) {
 		switch (state) {
 		case 0:
@@ -1352,8 +1373,10 @@ static int expression_value(struct token **where)
 static int handle_if(struct stream *stream, struct token **line, struct token *token)
 {
 	int value = 0;
-	if (!false_nesting)
+	if (!false_nesting) {
+		DEPCALL(push_dep,token);
 		value = expression_value(&token->next);
+	}
 
 	dirty_stream(stream);
 	return preprocessor_if(stream, token, value);
@@ -1378,6 +1401,8 @@ static int handle_elif(struct stream * stream, struct token **line, struct token
 		return 1;
 	}
 
+	DEPCALL(else_dep,token);
+	
 	dirty_stream(stream);
 	if (token_type(top_if) != TOKEN_IF)
 		return 1;
@@ -1407,6 +1432,9 @@ static int handle_else(struct stream *stream, struct token **line, struct token
 		nesting_error(stream);
 		sparse_error(token->pos, "#else after #else");
 	}
+
+	DEPCALL(else_dep,token);
+	
 	if (false_nesting) {
 		if (token_type(top_if) == TOKEN_IF)
 			false_nesting = 0;
@@ -1428,6 +1456,9 @@ static int handle_endif(struct stream *stream, struct token **line, struct token
 	}
 	if (false_nesting)
 		false_nesting--;
+
+	DEPCALL(pop_dep,token);
+	
 	stream->top_if = top_if->next;
 	__free_token(top_if);
 	return 1;
@@ -1740,7 +1771,7 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 	int is_normal = 1;
 
 	if (eof_token(token))
-		return;
+		goto ret;
 
 	if (token_type(token) == TOKEN_IDENT) {
 		struct symbol *sym = lookup_symbol(token->ident, NS_PREPROCESSOR);
@@ -1762,10 +1793,12 @@ static void handle_preprocessor_line(struct stream *stream, struct token **line,
 			goto out;
 	}
 	if (!handler(stream, line, token))	/* all set */
-		return;
+		goto ret;
 
 out:
 	free_preprocessor_line(token);
+ret:
+	DEPCALL(off, token);
 }
 
 static void preprocessor_line(struct stream *stream, struct token **line)
@@ -1817,6 +1850,7 @@ static void do_preprocess(struct token **list)
 
 		default:
 			dirty_stream(stream);
+			DEPCALL(tag_dep, next);
 			if (false_nesting) {
 				*list = next->next;
 				__free_token(next);
diff --git a/shrink.c b/shrink.c
new file mode 100644
index 0000000..b7a4404
--- /dev/null
+++ b/shrink.c
@@ -0,0 +1,102 @@
+/*
+ * Build macros dependency tree 
+ * Copyright (C) 2012 Konrad Eisele <konrad@gaisler.com,eiselekd@gmail.com>
+ * BSD-License
+ * Redistribution and use in source and binary forms are permitted
+ * provided that the above copyright notice and this paragraph are
+ * duplicated in all such forms and that any documentation,
+ * advertising materials, and other materials related to such
+ * distribution and use acknowledge that the software was developed
+ * by the <organization>.  The name of the
+ * University may not be used to endorse or promote products derived
+ * from this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ */
+
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "depend.h"
+
+void  stream_print_line(FILE *io, struct stream *stream, int j);
+
+static void 
+expand_symbols(struct symbol_list *list)
+{
+	struct symbol *sym;
+	FOR_EACH_PTR(list, sym) {
+		expand_symbol(sym);
+		depend_symbol(sym);
+	} END_FOR_EACH_PTR(sym);
+}
+
+int 
+main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL; int i;
+	char *file; struct symbol_list *all_syms = 0;
+	
+	init_dep();
+	
+	expand_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		struct symbol_list *syms = sparse(file);
+		expand_symbols(syms);
+		concat_symbol_list(syms, &all_syms);
+	} END_FOR_EACH_PTR_NOTAG(file);
+	
+	for (i = 0; i < input_stream_nr; i++) {
+		/* struct stream *c; int j; */
+		/* c = input_streams + i; */
+		/* if (c->n && c->b) { */
+		/* 	for (j =  0; j < c->linenr; j++) { */
+		/* 		struct stream_line *l = c->n[j]; */
+		/* 		if (l->used) { */
+		/* 			stream_print_line(stdout, c, j); */
+		/* 		} */
+		/* 	} */
+		/* } */
+
+	}
+
+	return 0;
+}
+
+/* void  */
+/* stream_print_line(FILE *io, struct stream *stream, int j) */
+/* { */
+/* 	int k; */
+/* 	if (stream->b && j < stream->linenr) { */
+/* 		struct stream_line *l = stream->n[j]; */
+/* 		int f, t, len; */
+/* 		f = t = l->off; */
+/* 		if (j+1 < stream->linenr &&  */
+/* 		    stream->n[j+1] && */
+/* 		    stream->n[j+1]->off > t) { */
+/* 			t = stream->n[j+1]->off; */
+/* 		} */
+/* 		if (f > stream->bz) */
+/* 			f = stream->bz; */
+/* 		if (t > stream->bz) */
+/* 			t = stream->bz; */
+/* 		len = t - f; */
+/* 		/\*fprintf(io, "%s:%04d:",stream->name,j);*\/ */
+/* 		for (k = 0; k < len; k++) { */
+/* 			fprintf(io, "%c", stream->b[f + k]); */
+/* 		} */
+/* 		/\*fprintf(io, "\n");*\/ */
+/* 	} */
+/* } */
diff --git a/sparse.c b/sparse.c
index 67b7d9e..ffdd8d4 100644
--- a/sparse.c
+++ b/sparse.c
@@ -23,6 +23,7 @@
 #include "symbol.h"
 #include "expression.h"
 #include "linearize.h"
+#include "depend.h"
 
 static int context_increase(struct basic_block *bb, int entry)
 {
@@ -278,6 +279,8 @@ int main(int argc, char **argv)
 	struct string_list *filelist = NULL;
 	char *file;
 
+	init_dep();
+	
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
diff --git a/symbol.h b/symbol.h
index 1e74579..e7dcb82 100644
--- a/symbol.h
+++ b/symbol.h
@@ -11,6 +11,7 @@
 
 #include "token.h"
 #include "target.h"
+#include "depend.h"
 
 /*
  * An identifier with semantic meaning is a "symbol".
@@ -94,6 +95,7 @@ struct decl_state {
 	struct ident **ident;
 	struct symbol_op *mode;
 	unsigned char prefer_abstract, is_inline, storage_class, is_tls;
+	struct symbol_list *dep;
 };
 
 struct symbol_op {
@@ -294,6 +296,13 @@ extern void debug_symbol(struct symbol *);
 extern void merge_type(struct symbol *sym, struct symbol *base_type);
 extern void check_declaration(struct symbol *sym);
 
+static inline struct symbol *alloc_symbol_tok(struct token *tok, int type)
+{
+	struct symbol *e = alloc_symbol (tok->pos, type);
+	DEP_TOK(e, tok);
+	return e;
+}
+
 static inline struct symbol *get_base_type(const struct symbol *sym)
 {
 	return examine_symbol_type(sym->ctype.base_type);
diff --git a/token.h b/token.h
index cd29233..00518e5 100644
--- a/token.h
+++ b/token.h
@@ -152,6 +152,15 @@ struct argcount {
 	unsigned vararg:1;
 };
 
+struct arg {
+	struct token *arg;
+	struct token *expanded;
+	struct token *str;
+	int n_normal;
+	int n_quoted;
+	int n_str;
+};
+
 /*
  * This is a very common data structure, it should be kept
  * as small as humanly possible. Big (rare) types go as
@@ -203,6 +212,7 @@ extern struct token * tokenize_buffer(void *, unsigned long, struct token **);
 
 extern void show_identifier_stats(void);
 extern struct token *preprocess(struct token *);
+extern struct depend_if *dif;
 
 static inline int match_op(struct token *token, int op)
 {
-- 
1.7.4.4

