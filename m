From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH 2/2] [RFC] dissect.c
Date: Mon, 19 Dec 2005 21:36:10 +0300
Message-ID: <43A6FD9A.D63247CF@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.tv-sign.ru ([213.234.233.51]:50361 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932233AbVLSRUk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 19 Dec 2005 12:20:40 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org

I completely forgot to re-send this patch, sorry. Nothing was changed,
except now ->r_symdef() is called for NS_STRUCT symbols too, to report
a struct/union definition.

 Makefile       |    9 
 dissect.h      |   40 +++
 dissect.c      |  574 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-dissect.c |   95 +++++++++
 4 files changed, 716 insertions(+), 2 deletions(-)

This patch adds dissect.{h,c} files to the sparse distribution.
From dissect.h:

	struct reporter
	{
		void (*r_symdef)(struct symbol*);

		void (*r_symbol)(unsigned mode, struct position*, struct symbol*);
		void (*r_member)(unsigned mode, struct position*, struct symbol*, struct symbol*);
	};

	extern void dissect(struct symbol_list*, struct reporter*);

dissect() walks the output of the sparse_file() and calls reporter's
callbacks.

->r_symdef() is called when the symbol (variable or function) is defined.

->r_symbol() - when the symbol is used in any way. The 'mode' parameter
denotes how this symbol was used. It is a bitmask of possible flags:

	FLAG:		Code example:

	U_R_VAL		return VAR;
	U_W_VAL		VAR = 0;

	U_R_PTR		return *VAR;
	U_W_PTR		*VAR = 0;

	U_R_AOF		const void *... = &VAR;
	U_W_AOF		memset(&VAR, ...);

->r_member() tracks the use of members of structures in the same way.

This patch also adds test-dissect.c, a simple and stupid example. It
prints the 'mode' parameter in a human readable format along with the
storage info, variable's name (or struct_name.member_name), and it's
type.

The 'mode' is dumped as a 3-letter string. The first letter denotes
AOF part, 2-nd - VAL, 3-rd - PTR.

	0			-> '-'
	U_R_xxx			-> 'r'
	U_W_xxx			-> 'w'
	U_R_xxx | U_W_xxx	-> 'm'

Example:
	$ cat -n T.c
	     1  int var;
	     2
	     3  static void func(void)
	     4  {
	     5          int *ptr;
	     6
	     7          ptr = &var;
	     8          *ptr = var;
	     9
	    10          var = *++ptr;
	    11  }

	$ ./test-dissect T.c

	FILE: T.c

	   1:5   g def  var                              int
	   3:13  s def  func                             void (  )( ... )
	   5:6   l def  ptr                              int *
	   7:2   l -w-  ptr                              int *
	   7:9   g m--  var                              int
	   8:3   l --w  ptr                              int *
	   8:9   g -r-  var                              int
	  10:2   g -w-  var                              int
	  10:11  l -mr  ptr                              int *


Note that '*ptr' does not add U_R_VAL flag, this is a feature, not a bug,
even if technically wrong.

dissect() does not check the code for correctness, for example:

	0 = X = Y;

gives this output:

   5:6   g -w-  X                                bad type
   5:10  g -r-  Y                                bad type

Again, X has no U_R_VAL, notabug.


Members of structures usage:

	task_t *tsk;
	tsk->parent->real_parent->pid++;

output:

   7:2   l --r  tsk                              struct task_struct [usertype] *
   7:5   g --r  task_struct.parent               struct task_struct *
   7:13  g --m  task_struct.real_parent          struct task_struct *
   7:26  g -m-  task_struct.pid                  int


dissect() tries to de-anonymize unnamed structures/unions:

     1  struct T {
     2          struct {
     3                  int x, y;
     4          } m;
     5  } t = {
     6          { undeclared }
     7  };

output:

   5:3   g def  t                                struct T
   5:3   g -w-  t                                struct T
   6:2   s -w-  T.m                              struct T:m
   6:4   s -w-  T:m.x                            int
   6:4   g -r-  undeclared                       bad type


When entire struct is overwritten, ->r_member() is called with mem == NULL,
this reported as struct_name.*, example:

	*new_vma = *vma;

output:

2028:5   l --w  new_vma                          struct vm_area_struct *
2028:13  g -w-  vm_area_struct.*                 struct vm_area_struct
2028:13  g -w-  pgprot_t.*                       struct pgprot_t
2028:13  g -w-  rb_node.*                        struct rb_node
2028:13  g -w-  vm_area_struct:shared.*          union vm_area_struct:shared
2028:13  g -w-  vm_area_struct:shared:vm_set.*   struct vm_area_struct:shared:vm_set
2028:13  g -w-  list_head.*                      struct list_head
2028:13  g -w-  raw_prio_tree_node.*             struct raw_prio_tree_node
2028:13  g -w-  list_head.*                      struct list_head
2028:16  l --r  vma                              struct vm_area_struct *


Function calls use U_R_PTR bit:

     5          func();
     6          pf = func;
     7          pf();

   5:2   g --r  func                             void (  )( ... )
   6:2   l -w-  pf                               void ( * )( ... )
   6:7   g r--  func                             void (  )( ... )
   7:2   l --r  pf                               void ( * )( ... )


BUGS:

1. dissect() confuses array-in-container with a pointer:

     3          struct T { int ary[]; } t;
     4
     5          t.ary[0] = 0;

output:

   5:2   l -r-  t     /* BUG, should be -w- */   struct T
   5:3   s -w-  T.ary                            int [0]

2. It can't detect the case when the address is taken only for writing,
eg: *(&i + 1) = 0, so U_W_AOF always implies U_R_AOF.

3. It does not support "flat" initializers without braces:

     3          struct O {
     4                  struct I {
     5                          int x, y;
     6                  } a, b;
     7          };
     8
     9          struct O o1 = { 1, 2, 3 };

buggy output:

   9:11  l -w-  o1                               struct O
   9:18  s -w-  O.a                              struct I
   9:21  s -w-  O.b                              struct I
   9:24  s -w-  O.?                              bad type

This is ok:

    11          struct O o2 = { { 1 }, .b = { .y = 0 } };

  11:11  l -w-  o2                               struct O
  11:18  s -w-  O.a                              struct I
  11:20  s -w-  I.x                              int
  11:30  s -w-  O.b                              struct I
  11:37  s -w-  I.y                              int

4. The implementation is far from perfect. It was really done
in "add some code + printf and see what happens" manner, without
studying the sources first. However I beleive it may be useful
for others, that is why I am posting it.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- git-snapshot-20051210/Makefile~2_DISSECT	2005-11-28 04:40:51.000000000 +0300
+++ git-snapshot-20051210/Makefile	2005-12-19 23:35:40.000000000 +0300
@@ -21,7 +21,7 @@ CFLAGS += -DDEBUG
 
 PREFIX=$(HOME)
 BINDIR=$(PREFIX)/bin
-PROGRAMS=test-lexing test-parsing obfuscate check compile test-linearize example test-unssa
+PROGRAMS=test-lexing test-parsing obfuscate check compile test-linearize example test-unssa test-dissect
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
@@ -30,7 +30,7 @@ LIB_H=    token.h parse.h lib.h symbol.h
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -83,6 +83,9 @@ example: example.o $(LIBS)
 test-unssa: test-unssa.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
+test-dissect: test-dissect.o $(LIBS)
+	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
 
@@ -111,6 +114,7 @@ target.o: $(LIB_H)
 test-lexing.o: $(LIB_H)
 test-parsing.o: $(LIB_H)
 test-linearize.o: $(LIB_H)
+test-dissect.o: $(LIB_H) dissect.h
 compile.o: $(LIB_H) compile.h
 compile-i386.o: $(LIB_H) compile.h
 tokenize.o: $(LIB_H)
@@ -118,6 +122,7 @@ check.o: $(LIB_H)
 obfuscate.o: $(LIB_H)
 example.o: $(LIB_H)
 storage.o: $(LIB_H) storage.h
+dissect.o: $(LIB_H) dissect.h
 
 compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 	$(LIB_H)
--- /dev/null	2000-01-01 03:00:00.000000000 +0300
+++ git-snapshot-20051210/dissect.h	2005-09-04 06:52:02.000000000 +0400
@@ -0,0 +1,40 @@
+#ifndef	DISSECT_H
+#define	DISSECT_H
+
+#include <stdio.h>
+#include "parse.h"
+#include "expression.h"
+
+#define	U_SHIFT		8
+
+#define	U_R_AOF		0x01
+#define	U_W_AOF		0x02
+
+#define	U_R_VAL		0x04
+#define	U_W_VAL		0x08
+
+#define	U_R_PTR		(U_R_VAL << U_SHIFT)
+#define	U_W_PTR		(U_W_VAL << U_SHIFT)
+
+struct reporter
+{
+	void (*r_symdef)(struct symbol*);
+
+	void (*r_symbol)(unsigned, struct position*, struct symbol*);
+	void (*r_member)(unsigned, struct position*, struct symbol*, struct symbol*);
+};
+
+extern void dissect(struct symbol_list*, struct reporter*);
+
+#define	MK_IDENT(s)	({				\
+	static struct {					\
+		struct ident ident;			\
+		char __[sizeof(s)];			\
+	} ident = {{					\
+		.len  = sizeof(s)-1,			\
+		.name = s,				\
+	}};						\
+	&ident.ident;					\
+})
+
+#endif
--- /dev/null	2000-01-01 03:00:00.000000000 +0300
+++ git-snapshot-20051210/dissect.c	2005-12-19 21:07:43.000000000 +0300
@@ -0,0 +1,574 @@
+/*
+ * sparse/dissect.c
+ *
+ * Started by Oleg Nesterov <oleg@tv-sign.ru>
+ *
+ * Licensed under the Open Software License version 1.1
+ */
+
+#include "dissect.h"
+
+#define	U_VOID	 0x00
+#define	U_SELF	((1 << U_SHIFT) - 1)
+#define	U_MASK	(U_R_VAL | U_W_VAL | U_R_AOF)
+
+#define	DO_LIST(l__, p__, expr__)		\
+	do {					\
+		typeof(l__->list[0]) p__;	\
+		FOR_EACH_PTR(l__, p__)		\
+			expr__;			\
+		END_FOR_EACH_PTR(p__);		\
+	} while (0)
+
+#define	DO_2_LIST(l1__,l2__, p1__,p2__, expr__)	\
+	do {					\
+		typeof(l1__->list[0]) p1__;	\
+		typeof(l2__->list[0]) p2__;	\
+		PREPARE_PTR_LIST(l1__, p1__);	\
+		FOR_EACH_PTR(l2__, p2__)	\
+			expr__;			\
+			NEXT_PTR_LIST(p1__);	\
+		END_FOR_EACH_PTR(p2__);		\
+		FINISH_PTR_LIST(p1__);		\
+	} while (0)
+
+
+typedef unsigned usage_t;
+
+static struct reporter *reporter;
+static struct symbol *return_type;
+
+static void do_sym_list(struct symbol_list *list);
+
+static struct symbol
+	*base_type(struct symbol *sym),
+	*do_initializer(struct symbol *type, struct expression* expr),
+	*do_expression(usage_t mode, struct expression *expr),
+	*do_statement(usage_t mode, struct statement *stmt);
+
+static inline int is_ptr(struct symbol *type)
+{
+	return type->type == SYM_PTR || type->type == SYM_ARRAY;
+}
+
+static inline usage_t u_rval(usage_t mode)
+{
+	return mode & (U_R_VAL | (U_MASK << U_SHIFT))
+		? U_R_VAL : 0;
+}
+
+static inline usage_t u_addr(usage_t mode)
+{
+	return mode = mode & U_MASK
+		? U_R_AOF | (mode & U_W_AOF) : 0;
+}
+
+static usage_t u_lval(struct symbol *type)
+{
+	int wptr = is_ptr(type) && !(type->ctype.modifiers & MOD_CONST);
+	return wptr || type == &bad_ctype
+		? U_W_AOF | U_R_VAL : U_R_VAL;
+}
+
+static usage_t fix_mode(struct symbol *type, usage_t mode)
+{
+	mode &= (U_SELF | (U_SELF << U_SHIFT));
+
+	switch (type->type) {
+		case SYM_BASETYPE:
+			if (!type->ctype.base_type)
+				break;
+		case SYM_ENUM:
+		case SYM_BITFIELD:
+			if (mode & U_MASK)
+				mode &= U_SELF;
+		default:
+
+		break; case SYM_FN:
+			if (mode & U_R_VAL)
+				mode |= U_R_AOF;
+			mode &= ~(U_R_VAL | U_W_AOF);
+
+		break; case SYM_ARRAY:
+			if (mode & (U_MASK << U_SHIFT))
+				mode >>= U_SHIFT;
+			else if (mode != U_W_VAL)
+				mode = u_addr(mode);
+	}
+
+	if (!(mode & U_R_AOF))
+		mode &= ~U_W_AOF;
+
+	return mode;
+}
+
+static inline struct symbol *no_member(struct ident *name)
+{
+	static struct symbol sym = {
+		.type = SYM_BAD,
+	};
+
+	sym.ctype.base_type = &bad_ctype;
+	sym.ident = name;
+
+	return &sym;
+}
+
+static struct symbol *report_member(mode_t mode, struct position *pos,
+					struct symbol *type, struct symbol *mem)
+{
+	struct symbol *ret = mem->ctype.base_type;
+
+	if (reporter->r_member)
+		reporter->r_member(fix_mode(ret, mode), pos, type, mem);
+
+	return ret;
+}
+
+static void report_implicit(usage_t mode, struct position *pos, struct symbol *type)
+{
+	if (type->type != SYM_STRUCT && type->type != SYM_UNION)
+		return;
+
+	if (reporter->r_member) {
+		reporter->r_member(mode, pos, type, NULL);
+
+		DO_LIST(type->symbol_list, mem,
+			report_implicit(mode, pos, base_type(mem)));
+	}
+}
+
+static inline struct symbol *expr_symbol(struct expression *expr)
+{
+	struct symbol *sym = expr->symbol;
+
+	if (!sym) {
+		sym = lookup_symbol(expr->symbol_name, NS_SYMBOL);
+
+		if (!sym) {
+			sym = alloc_symbol(expr->pos, SYM_BAD);
+			bind_symbol(sym, expr->symbol_name, NS_SYMBOL);
+			sym->ctype.modifiers = MOD_EXTERN;
+		}
+	}
+
+	if (!sym->ctype.base_type)
+		sym->ctype.base_type = &bad_ctype;
+
+	return sym;
+}
+
+static struct symbol *report_symbol(usage_t mode, struct expression *expr)
+{
+	struct symbol *sym = expr_symbol(expr);
+	struct symbol *ret = base_type(sym);
+
+	if (0 && ret->type == SYM_ENUM)
+		return report_member(mode, &expr->pos, ret, expr->symbol);
+
+	if (reporter->r_symbol)
+		reporter->r_symbol(fix_mode(ret, mode), &expr->pos, sym);
+
+	return ret;
+}
+
+static inline struct ident *mk_name(struct ident *root, struct ident *node)
+{
+	char name[256];
+
+	snprintf(name, sizeof(name), "%.*s:%.*s",
+			root ? root->len : 0, root->name,
+			node ? node->len : 0, node->name);
+
+	return built_in_ident(name);
+}
+
+static void examine_sym_node(struct symbol *node, struct ident *root)
+{
+	struct symbol *base;
+	struct ident *name;
+
+	if (node->examined)
+		return;
+
+	node->examined = 1;
+	name = node->ident;
+
+	while ((base = node->ctype.base_type) != NULL)
+		switch (base->type) {
+		case SYM_TYPEOF:
+			node->ctype.base_type =
+				do_expression(U_VOID, base->initializer);
+			break;
+
+		case SYM_ARRAY:
+			do_expression(U_R_VAL, base->array_size);
+		case SYM_PTR: case SYM_FN:
+			node = base;
+			break;
+
+		case SYM_STRUCT: case SYM_UNION: //case SYM_ENUM:
+			if (base->evaluated)
+				return;
+			if (!base->ident && name)
+				base->ident = mk_name(root, name);
+			if (!base->ident || !base->symbol_list)
+				return;
+			if (reporter->r_symdef)
+				reporter->r_symdef(base);
+			base->evaluated = 1;
+		default:
+			return;
+		}
+}
+
+static struct symbol *base_type(struct symbol *sym)
+{
+	if (!sym)
+		return &bad_ctype;
+
+	if (sym->type == SYM_NODE)
+		examine_sym_node(sym, NULL);
+
+	return sym->ctype.base_type	// builtin_fn_type
+		?: &bad_ctype;
+}
+
+static struct symbol *__lookup_member(struct symbol *type, struct ident *name, int *p_addr)
+{
+	struct symbol *node;
+	int addr = 0;
+
+	FOR_EACH_PTR(type->symbol_list, node)
+		if (!name) {
+			if (addr == *p_addr)
+				return node;
+		}
+		else if (node->ident == NULL) {
+			node = __lookup_member(node->ctype.base_type, name, NULL);
+			if (node)
+				goto found;
+		}
+		else if (node->ident == name) {
+found:
+			if (p_addr)
+				*p_addr = addr;
+			return node;
+		}
+		addr++;
+	END_FOR_EACH_PTR(node);
+
+	return NULL;
+}
+
+static struct symbol *lookup_member(struct symbol *type, struct ident *name, int *addr)
+{
+	struct symbol *node = __lookup_member(type, name, addr);
+
+	if (node != NULL)
+		examine_sym_node(node, type->ident);
+	else
+		node = no_member(name);
+
+	return node;
+}
+
+static struct expression *peek_preop(struct expression *expr, int op)
+{
+	do {
+		if (expr->type != EXPR_PREOP)
+			break;
+		if (expr->op == op)
+			return expr->unop;
+		if (expr->op == '(')
+			expr = expr->unop;
+		else
+			break;
+	} while (expr);
+
+	return NULL;
+}
+
+static struct symbol *do_expression(usage_t mode, struct expression *expr)
+{
+	struct symbol *ret = &int_ctype;
+
+again:
+	if (expr) switch (expr->type) {
+	default:
+		warning(expr->pos, "bad expr->type: %d", expr->type);
+
+	case EXPR_TYPE:		// [struct T]; Why ???
+	case EXPR_VALUE:
+	case EXPR_FVALUE:
+
+	break; case EXPR_LABEL:
+		ret = &label_ctype;
+
+	break; case EXPR_STRING:
+		ret = &string_ctype;
+
+	break; case EXPR_STATEMENT:
+		ret = do_statement(mode, expr->statement);
+
+	break; case EXPR_SIZEOF: case EXPR_ALIGNOF: case EXPR_PTRSIZEOF:
+		do_expression(U_VOID, expr->cast_expression);
+
+	break; case EXPR_COMMA:
+		do_expression(U_VOID, expr->left);
+		ret = do_expression(mode, expr->right);
+
+	break; case EXPR_CAST: //case EXPR_IMPLIED_CAST:
+		ret = base_type(expr->cast_type);
+		do_initializer(ret, expr->cast_expression);
+
+	break; case EXPR_COMPARE: case EXPR_LOGICAL:
+		mode = u_rval(mode);
+		do_expression(mode, expr->left);
+		do_expression(mode, expr->right);
+
+	break; case EXPR_CONDITIONAL: //case EXPR_SELECT:
+		do_expression(expr->cond_true
+					? U_R_VAL : U_R_VAL | mode,
+				expr->conditional);
+		ret = do_expression(mode, expr->cond_true);
+		ret = do_expression(mode, expr->cond_false);
+
+	break; case EXPR_CALL:
+		ret = do_expression(U_R_PTR, expr->fn);
+		if (is_ptr(ret))
+			ret = ret->ctype.base_type;
+		DO_2_LIST(ret->arguments, expr->args, arg, val,
+			do_expression(u_lval(base_type(arg)), val));
+		ret = ret->type == SYM_FN ? base_type(ret)
+			: &bad_ctype;
+
+	break; case EXPR_ASSIGNMENT:
+		mode |= U_W_VAL | U_R_VAL;
+		if (expr->op == '=')
+			mode &= ~U_R_VAL;
+		ret = do_expression(mode, expr->left);
+		report_implicit(mode, &expr->pos, ret);
+		mode = expr->op == '='
+			? u_lval(ret) : U_R_VAL;
+		do_expression(mode, expr->right);
+
+	break; case EXPR_BINOP: {
+		struct symbol *l, *r;
+		mode |= u_rval(mode);
+		l = do_expression(mode, expr->left);
+		r = do_expression(mode, expr->right);
+		if (expr->op != '+' && expr->op != '-')
+			;
+		else if (!is_ptr_type(r))
+			ret = l;
+		else if (!is_ptr_type(l))
+			ret = r;
+	}
+
+	break; case EXPR_PREOP: case EXPR_POSTOP: {
+		struct expression *unop = expr->unop;
+
+		switch (expr->op) {
+		case SPECIAL_INCREMENT:
+		case SPECIAL_DECREMENT:
+			mode |= U_W_VAL | U_R_VAL;
+		default:
+			mode |= u_rval(mode);
+		case '(':
+			ret = do_expression(mode, unop);
+
+		break; case '&':
+			if ((expr = peek_preop(unop, '*')))
+				goto again;
+			ret = alloc_symbol(unop->pos, SYM_PTR);
+			ret->ctype.base_type =
+				do_expression(u_addr(mode), unop);
+
+		break; case '*':
+			if ((expr = peek_preop(unop, '&')))
+				goto again;
+			if (mode & (U_MASK << U_SHIFT))
+				mode |= U_R_VAL;
+			mode <<= U_SHIFT;
+			if (mode & (U_R_AOF << U_SHIFT))
+				mode |= U_R_VAL;
+			if (mode & (U_W_VAL << U_SHIFT))
+				mode |= U_W_AOF;
+			ret = do_expression(mode, unop);
+			ret = is_ptr(ret) ? base_type(ret)
+				: &bad_ctype;
+		}
+	}
+
+	break; case EXPR_DEREF: {
+		struct symbol *p_type;
+		usage_t p_mode;
+
+		p_mode = mode & U_SELF;
+		if (!(mode & U_MASK) && (mode & (U_MASK << U_SHIFT)))
+			p_mode = U_R_VAL;
+		p_type = do_expression(p_mode, expr->deref);
+
+		ret = report_member(mode, &expr->pos, p_type,
+			lookup_member(p_type, expr->member, NULL));
+	}
+
+	break; case EXPR_SYMBOL:
+		ret = report_symbol(mode, expr);
+	}
+
+	return ret;
+}
+
+static void do_asm_xputs(usage_t mode, struct expression_list *xputs)
+{
+	int nr = 0;
+
+	DO_LIST(xputs, expr,
+		if (++nr % 3 == 0)
+			do_expression(U_W_AOF | mode, expr));
+}
+
+static struct symbol *do_statement(usage_t mode, struct statement *stmt)
+{
+	struct symbol *ret = &void_ctype;
+
+	if (stmt) switch (stmt->type) {
+	default:
+		warning(stmt->pos, "bad stmt->type: %d", stmt->type);
+
+	case STMT_NONE:
+	case STMT_RANGE:
+	case STMT_CONTEXT:
+
+	break; case STMT_EXPRESSION:
+		ret = do_expression(mode, stmt->expression);
+
+	break; case STMT_RETURN:
+		do_expression(u_lval(return_type), stmt->expression);
+
+	break; case STMT_ASM:
+		do_expression(U_R_VAL, stmt->asm_string);
+		do_asm_xputs(U_W_VAL, stmt->asm_outputs);
+		do_asm_xputs(U_R_VAL, stmt->asm_inputs);
+
+	break; case STMT_COMPOUND: {
+		int count;
+
+		do_sym_list(stmt->syms);
+		count = statement_list_size(stmt->stmts);
+		DO_LIST(stmt->stmts, st,
+			ret = do_statement(--count ? U_VOID : mode, st));
+	}
+
+	break; case STMT_ITERATOR:
+		do_sym_list(stmt->iterator_syms);
+		do_statement(U_VOID, stmt->iterator_pre_statement);
+		do_expression(U_R_VAL, stmt->iterator_pre_condition);
+		do_statement(U_VOID, stmt->iterator_post_statement);
+		do_statement(U_VOID, stmt->iterator_statement);
+		do_expression(U_R_VAL, stmt->iterator_post_condition);
+
+	break; case STMT_IF:
+		do_expression(U_R_VAL, stmt->if_conditional);
+		do_statement(U_VOID, stmt->if_true);
+		do_statement(U_VOID, stmt->if_false);
+
+	break; case STMT_SWITCH:
+		do_expression(U_R_VAL, stmt->switch_expression);
+		do_statement(U_VOID, stmt->switch_statement);
+
+	break; case STMT_CASE:
+		do_expression(U_R_VAL, stmt->case_expression);
+		do_expression(U_R_VAL, stmt->case_to);
+		do_statement(U_VOID, stmt->case_statement);
+
+	break; case STMT_GOTO:
+		do_expression(U_R_PTR, stmt->goto_expression);
+
+	break; case STMT_LABEL:
+		do_statement(mode, stmt->label_statement);
+
+	}
+
+	return ret;
+}
+
+static struct symbol *do_initializer(struct symbol *type, struct expression* expr)
+{
+	struct symbol *m_type;
+	struct expression *m_expr;
+	int m_addr;
+
+	if (expr) switch (expr->type) {
+	default:
+		do_expression(u_lval(type), expr);
+
+	break; case EXPR_INITIALIZER:
+		m_addr = 0;
+		FOR_EACH_PTR(expr->expr_list, m_expr)
+			if(type->type == SYM_ARRAY) {
+				m_type = base_type(type);
+				if (m_expr->type == EXPR_INDEX)
+					m_expr = m_expr->idx_expression;
+			} else {
+				struct position *pos = &m_expr->pos;
+				struct ident *m_name = NULL;
+
+				if (m_expr->type == EXPR_IDENTIFIER) {
+					m_name = m_expr->expr_ident;
+					m_expr = m_expr->ident_expression;
+				}
+
+				m_type = report_member(U_W_VAL, pos, type,
+						lookup_member(type, m_name, &m_addr));
+				if (m_expr->type != EXPR_INITIALIZER)
+					report_implicit(U_W_VAL, pos, m_type);
+			}
+			do_initializer(m_type, m_expr);
+			m_addr++;
+		END_FOR_EACH_PTR(m_expr);
+	}
+
+	return type;
+}
+
+static inline struct symbol *do_symbol(struct symbol *sym)
+{
+	struct symbol *type;
+
+	type = base_type(sym);
+
+	if (reporter->r_symdef)
+		reporter->r_symdef(sym);
+
+	switch (type->type) {
+	default:
+		if (!sym->initializer)
+			break;
+		if (reporter->r_symbol)
+			reporter->r_symbol(U_W_VAL, &sym->pos, sym);
+		do_initializer(type, sym->initializer);
+
+	break; case SYM_FN:
+		do_sym_list(type->arguments);
+		return_type = base_type(type);
+		do_statement(U_VOID, sym->ctype.modifiers & MOD_INLINE
+					? type->inline_stmt
+					: type->stmt);
+	}
+
+	return type;
+}
+
+static void do_sym_list(struct symbol_list *list)
+{
+	DO_LIST(list, sym, do_symbol(sym));
+}
+
+void dissect(struct symbol_list *list, struct reporter *rep)
+{
+	reporter = rep;
+	do_sym_list(list);
+}
--- /dev/null	2000-01-01 03:00:00.000000000 +0300
+++ git-snapshot-20051210/test-dissect.c	2005-12-19 23:21:50.000000000 +0300
@@ -0,0 +1,95 @@
+#include "dissect.h"
+
+static unsigned dotc_stream;
+
+static inline char storage(struct symbol *sym)
+{
+	int t = sym->type;
+	unsigned m = sym->ctype.modifiers;
+
+	if (m & MOD_INLINE || t == SYM_STRUCT || t == SYM_UNION /*|| t == SYM_ENUM*/)
+		return sym->pos.stream == dotc_stream ? 's' : 'g';
+
+	return (m & MOD_STATIC) ? 's' : (m & MOD_NONLOCAL) ? 'g' : 'l';
+}
+
+static inline const char *show_mode(unsigned mode)
+{
+	static char str[3];
+
+	if (mode == -1)
+		return "def";
+
+#define	U(u_r)	"-rwm"[(mode / u_r) & 3]
+	str[0] = U(U_R_AOF);
+	str[1] = U(U_R_VAL);
+	str[2] = U(U_R_PTR);
+#undef	U
+
+	return str;
+}
+
+static void print_usage(struct position *pos, struct symbol *sym, unsigned mode)
+{
+	static unsigned curr_stream = -1;
+
+	if (curr_stream != pos->stream) {
+		curr_stream = pos->stream;
+		printf("\nFILE: %s\n\n", stream_name(curr_stream));
+	}
+
+	printf("%4d:%-3d %c %-5.3s",
+		pos->line, pos->pos, storage(sym), show_mode(mode));
+}
+
+static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
+{
+	print_usage(pos, sym, mode);
+
+	if (!sym->ident)
+		sym->ident = MK_IDENT("__asm__");
+
+	printf("%-32.*s %s\n",
+		sym->ident->len, sym->ident->name,
+		show_typename(sym->ctype.base_type));
+}
+
+static void r_member(unsigned mode, struct position *pos, struct symbol *sym, struct symbol *mem)
+{
+	struct ident *ni, *si, *mi;
+
+	print_usage(pos, sym, mode);
+
+	ni = MK_IDENT("?");
+	si = sym->ident ?: ni;
+	/* mem == NULL means entire struct accessed */
+	mi = mem ? (mem->ident ?: ni) : MK_IDENT("*");
+
+	printf("%.*s.%-*.*s %s\n",
+		si->len, si->name,
+		32-1 - si->len, mi->len, mi->name,
+		show_typename(mem ? mem->ctype.base_type : sym));
+}
+
+static void r_symdef(struct symbol *sym)
+{
+	r_symbol(-1, &sym->pos, sym);
+}
+
+int main(int argc, char **argv)
+{
+	static struct reporter reporter = {
+		.r_symdef = r_symdef,
+		.r_symbol = r_symbol,
+		.r_member = r_member,
+	};
+
+	sparse_initialize(argc, argv);
+
+	while (*argv) {
+		dotc_stream = input_stream_nr;
+		dissect(__sparse(argv), &reporter);
+	}
+
+	return 0;
+}
