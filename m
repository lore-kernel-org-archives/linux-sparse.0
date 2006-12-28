From: Christopher Li <sparse@chrisli.org>
Subject: [RFC] [PATCH 4/4] adding the null pointer checking
Date: Thu, 28 Dec 2006 01:27:05 -0800
Message-ID: <20061228092705.GE6573@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:36260 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865AbWL1JpZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Dec 2006 04:45:25 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>, Dan Carpenter <error27@gmail.com>

This patch add the kmalloc null pointer checking. It also
try to track the double free as well. It knows a few kmalloc like
functions and kfree etc.

The interrupt checking is just a toy. Without cross function checking,
it is way too many false positive. 

BTW, I disable the branch optimization in expand stage because this type
of checking works best when different state follow different path.

Not a real patch submitting, I would love to heard some comment though.

Chris

Index: sparse/blobhash.c
===================================================================
--- sparse.orig/blobhash.c	2006-12-28 00:22:18.000000000 -0800
+++ sparse/blobhash.c	2006-12-28 00:22:18.000000000 -0800
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2006 Christopher Li <sparse@chrisli.org>
+ * Copyright (C) 2003 Transmeta Corp.
+ *               2003 Linus Torvalds
+ *
+ *  Licensed under the Open Software License version 1.1
+ */
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
+#include "linearize.h"
+#include "storage.h"
+#include "checker.h"
+
+/*
+ * steal from tokenize.c 
+ */
+#define BLOB_HASH_BITS (13)
+#define BLOB_HASH_SIZE (1<<BLOB_HASH_BITS)
+#define BLOB_HASH_MASK (BLOB_HASH_SIZE-1)
+
+#define blob_hash_init(c)		(c)
+#define blob_hash_add(oldhash,c)	((oldhash)*11 + (c))
+#define blob_hash_end(hash)		((((hash) >> BLOB_HASH_BITS) + (hash)) & BLOB_HASH_MASK)
+
+ALLOCATOR(blob, "pseudo state blob");
+ALLOCATOR(bb_state, "basic block state");
+ALLOCATOR(state, "one state");
+
+
+static struct blob_list *blob_hash_table[BLOB_HASH_SIZE];
+
+static unsigned long blob_hash(const unsigned char *data, int len)
+{
+	unsigned long hash;
+	const unsigned char *p = data;
+
+	hash = blob_hash_init(0);
+	while (len--) {
+		unsigned int i = *p++;
+		hash = blob_hash_add(hash, i);
+	}
+	return blob_hash_end(hash);
+}
+
+struct blob *lookup_blob(const unsigned char *data, int len)
+{
+	struct blob_list *list = blob_hash_table[blob_hash(data, len)];
+	struct blob *blob;
+
+	FOR_EACH_PTR(list, blob) {
+		if (blob->len == len && !memcmp(blob->data, data, len))
+			return blob;
+	} END_FOR_EACH_PTR(blob);
+	return NULL;
+}
+
+struct blob *create_hashed_blob(const unsigned char *data, int len)
+{
+	struct blob_list **list = blob_hash_table + blob_hash(data, len);
+	struct blob *blob;
+	FOR_EACH_PTR(*list, blob) {
+		if (blob->len == len && !memcmp(blob->data, data, len))
+			return blob;
+	} END_FOR_EACH_PTR(blob);
+	blob = alloc_blob(len);
+	memcpy(blob->data, data, len);
+	add_blob(list, blob);
+	return blob;
+}
+
+void free_blob(void)
+{
+	int i;
+
+	for (i = 0; i < BLOB_HASH_SIZE; i++) {
+		free_ptr_list(blob_hash_table + i);
+	}
+	clear_blob_alloc();
+}
+
Index: sparse/unssa.h
===================================================================
Index: sparse/unssa.c
===================================================================
--- sparse.orig/unssa.c	2006-12-28 00:22:10.000000000 -0800
+++ sparse/unssa.c	2006-12-28 00:22:35.000000000 -0800
@@ -24,8 +24,8 @@
  */
 
 #include "lib.h"
-#include "linearize.h"
 #include "allocate.h"
+#include "linearize.h"
 #include <assert.h>
 
 
Index: sparse/flow.c
===================================================================
Index: sparse/ptrlist.h
===================================================================
--- sparse.orig/ptrlist.h	2006-12-28 00:21:06.000000000 -0800
+++ sparse/ptrlist.h	2006-12-28 00:22:18.000000000 -0800
@@ -45,6 +45,8 @@ extern void concat_ptr_list(struct ptr_l
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
+extern int find_ptr_in_list(struct ptr_list* list, void *ptr);
+extern int find_ptr_index(struct ptr_list* list, void *ptr);
 
 /*
  * Hey, who said that you can't do overloading in C?
Index: sparse/Makefile
===================================================================
--- sparse.orig/Makefile	2006-12-28 00:21:06.000000000 -0800
+++ sparse/Makefile	2006-12-28 00:22:18.000000000 -0800
@@ -27,12 +27,13 @@ INST_PROGRAMS=sparse cgcc
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
-	  storage.h ptrlist.h dissect.h
+	  storage.h ptrlist.h dissect.h checker.h
 
 LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
-	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
+	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
+	  blobhash.o check-nullptr.o check-interrupt.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -131,6 +132,9 @@ example.o: $(LIB_H)
 storage.o: $(LIB_H)
 dissect.o: $(LIB_H)
 graph.o: $(LIB_H)
+blobstate.o: $(LIB_H)
+check-nullptr.o: $(LIB_H)
+check-interrupt.o: $(LIB_H)
 
 compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 	$(LIB_H)
Index: sparse/checker.h
===================================================================
--- sparse.orig/checker.h	2006-12-28 00:22:18.000000000 -0800
+++ sparse/checker.h	2006-12-28 00:22:18.000000000 -0800
@@ -0,0 +1,92 @@
+#ifndef _CHECKER_H_
+#define _CHECKER_H_
+
+struct blob {
+	int len;
+	unsigned char data[0];
+};
+
+struct bb_state;
+
+DECLARE_PTR_LIST(blob_list, struct blob);
+
+struct bb_state {
+	unsigned long generation;
+	struct instruction_list *insns;	// instruction relate to state.
+	struct blob_list *cached_state;
+	struct instruction *branch;
+	unsigned noret:1;
+};
+
+struct state {
+	unsigned char *statep;
+	unsigned long value;
+};
+
+DECLARE_ALLOCATOR(blob);
+DECLARE_ALLOCATOR(bb_state);
+DECLARE_ALLOCATOR(state);
+DECLARE_PTR_LIST(state_list, struct state);
+
+struct blob *lookup_blob(const unsigned char *data, int len);
+struct blob *create_hashed_blob(const unsigned char *data, int len);
+
+static inline struct blob* alloc_blob(int len)
+{
+	struct blob *blob = __alloc_blob(len);
+	blob->len = len;
+	return blob;
+}
+
+static inline void add_blob(struct blob_list **list, struct blob *blob)
+{
+	add_ptr_list(list, blob);
+}
+
+static inline struct bb_state* alloc_bb_state(void)
+{
+	return __alloc_bb_state(0);
+}
+
+#define new_state(list, p, v)						\
+	do {								\
+		typeof(p) __p = p;					\
+		struct state *__state = __alloc_state(0);		\
+		__state->statep = __p;					\
+		__state->value = *__p;					\
+		*__p = (v);						\
+		add_ptr_list(list, __state);				\
+	} while (0)
+
+
+#define revert_state(type, list, size)					\
+	do {								\
+		struct state *__state;					\
+		struct ptr_list **__list = (struct ptr_list **)(list);	\
+		type *__p;						\
+		while (ptr_list_size(*__list) > (size)) {		\
+			__state = undo_ptr_list_last(__list);		\
+			__p = __state->statep;				\
+			*__p = (type)__state->value;			\
+			__free_state(__state);				\
+		}							\
+	} while (0)
+
+
+static inline struct instruction *checker_instruction(struct instruction *insn, int opcode, pseudo_t src)
+{
+	struct instruction *new = __alloc_instruction(0);
+	new->opcode = opcode;
+	new->pos = insn->pos;
+	new->bb = insn->bb;
+	new->src = src;
+	new->offset = find_ptr_index((struct ptr_list *)insn->bb->insns, insn);
+	return new;
+}
+
+extern void init_check_null_ptr(void);
+extern void check_null_ptr(struct entrypoint *ep);
+extern void check_interrupt(struct entrypoint *ep);
+
+#endif
+
Index: sparse/token.h
===================================================================
Index: sparse/allocate.c
===================================================================
Index: sparse/simplify.c
===================================================================
Index: sparse/memops.c
===================================================================
Index: sparse/allocate.h
===================================================================
Index: sparse/expand.c
===================================================================
--- sparse.orig/expand.c	2006-12-28 00:21:06.000000000 -0800
+++ sparse/expand.c	2006-12-28 00:22:18.000000000 -0800
@@ -29,8 +29,8 @@
 /* Random cost numbers */
 #define SIDE_EFFECTS 10000	/* The expression has side effects */
 #define UNSAFE 100		/* The expression may be "infinitely costly" due to exceptions */
-#define SELECT_COST 20		/* Cut-off for turning a conditional into a select */
-#define BRANCH_COST 10		/* Cost of a conditional branch */
+#define SELECT_COST 0		/* Cut-off for turning a conditional into a select */
+#define BRANCH_COST 0		/* Cost of a conditional branch */
 
 static int expand_expression(struct expression *);
 static int expand_statement(struct statement *);
Index: sparse/ident-list.h
===================================================================
Index: sparse/lib.h
===================================================================
Index: sparse/sparse.c
===================================================================
--- sparse.orig/sparse.c	2006-12-28 00:21:06.000000000 -0800
+++ sparse/sparse.c	2006-12-28 00:22:18.000000000 -0800
@@ -23,6 +23,8 @@
 #include "symbol.h"
 #include "expression.h"
 #include "linearize.h"
+#include "storage.h"
+#include "checker.h"
 
 static int context_increase(struct basic_block *bb, int entry)
 {
@@ -170,29 +172,39 @@ struct checkfn {
 	void (*check)(struct instruction *insn);
 };
 
+static const struct checkfn* match_function(const struct checkfn* checklist, struct symbol *fn)
+{
+	struct ident *ident;
+	int i;
+
+	ident = fn->ident;
+	if (!ident)
+		return NULL;
+
+	for (i = 0; checklist[i].id; i++) {
+		if (checklist[i].id != ident)
+			continue;
+		return checklist + i;
+	}
+	return NULL;
+}
+
 static void check_call_instruction(struct instruction *insn)
 {
 	pseudo_t fn = insn->func;
-	struct ident *ident;
-	static const struct checkfn check_fn[] = {
+	static const struct checkfn *entry, check_fn[] = {
 		{ &memset_ident, check_memset },
 		{ &memcpy_ident, check_memcpy },
 		{ &copy_to_user_ident, check_ctu },
 		{ &copy_from_user_ident, check_cfu },
+		{ NULL },
 	};
-	int i;
 
 	if (fn->type != PSEUDO_SYM)
 		return;
-	ident = fn->sym->ident;
-	if (!ident)
-		return;
-	for (i = 0; i < sizeof(check_fn)/sizeof(struct checkfn) ; i++) {
-		if (check_fn[i].id != ident)
-			continue;
-		check_fn[i].check(insn);
-		break;
-	}
+	entry = match_function(check_fn, fn->sym);
+	if (entry)
+		entry->check(insn);
 }
 
 static void check_one_instruction(struct instruction *insn)
@@ -264,8 +276,11 @@ static void check_symbols(struct symbol_
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (ep)
+		if (ep) {
 			check_context(ep);
+			check_null_ptr(ep);
+			check_interrupt(ep);
+		}
 	} END_FOR_EACH_PTR(sym);
 }
 
@@ -276,6 +291,8 @@ int main(int argc, char **argv)
 
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
+
+	init_check_null_ptr();
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
Index: sparse/linearize.h
===================================================================
--- sparse.orig/linearize.h	2006-12-28 00:22:15.000000000 -0800
+++ sparse/linearize.h	2006-12-28 00:22:18.000000000 -0800
@@ -29,7 +29,9 @@ enum pseudo_type {
 
 struct pseudo {
 	int nr;
-	enum pseudo_type type;
+	enum pseudo_type type:8;
+	unsigned state_index:16;
+	unsigned tracking:1;
 	struct pseudo_user_list *users;
 	struct ident *ident;
 	union {
@@ -211,14 +213,19 @@ enum opcode {
 
 	/* Needed to translate SSA back to normal form */
 	OP_COPY,
+	OP_LAST,
 };
 
 struct basic_block_list;
 struct instruction_list;
+struct bb_state;
 
 struct basic_block {
 	struct position pos;
-	unsigned long generation;
+	union {
+		unsigned long generation;
+		struct bb_state *state;
+	};
 	int context;
 	struct entrypoint *ep;
 	struct basic_block_list *parents; /* sources */
Index: sparse/check-interrupt.c
===================================================================
--- sparse.orig/check-interrupt.c	2006-12-28 00:22:18.000000000 -0800
+++ sparse/check-interrupt.c	2006-12-28 00:22:18.000000000 -0800
@@ -0,0 +1,159 @@
+/*
+ * Copyright (C) 2006 Christopher Li <sparse@chrisli.org>
+ *
+ *  Licensed under the Open Software License version 1.1
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "linearize.h"
+#include "storage.h"
+#include "checker.h"
+
+
+static unsigned char current;
+static struct blob *hashed_state;
+static struct state_list *state_stack = NULL;
+
+enum {
+	OP_CLI = OP_LAST,
+	OP_STI,
+	OP_RESTORE,
+};
+
+enum {
+	INTR_ENABLE,
+	INTR_DISABLE,
+};
+
+static inline void execute_enable(struct instruction *insn)
+{
+	if (current == INTR_ENABLE) {
+		warning(insn->pos, "checker function %s double enable",
+			show_ident(insn->bb->ep->name->ident));
+		return;
+	}
+	new_state(&state_stack, &current, INTR_ENABLE); 
+	hashed_state = NULL;
+}
+
+static inline void execute_disable(struct instruction *insn)
+{
+	if (current == INTR_DISABLE) {
+		warning(insn->pos, "checker function %s double ensable",
+			show_ident(insn->bb->ep->name->ident));
+		return;
+	}
+	new_state(&state_stack, &current, INTR_DISABLE); 
+	hashed_state = NULL;
+}
+
+static inline void execute_ret(struct instruction *insn)
+{
+	if (current == INTR_DISABLE)
+		warning(insn->pos, "checker funcion %s exit with interrupt disabled",
+			show_ident(insn->bb->ep->name->ident));
+}
+
+static void check_bb(struct basic_block *bb)
+{
+	struct bb_state *bbs = bb->state;
+	struct instruction *insn;
+	int stacksize = ptr_list_size((struct ptr_list*)state_stack);
+	struct basic_block *child;
+
+	if (bbs->generation)
+		return;
+
+	if (!hashed_state)
+		hashed_state = create_hashed_blob(&current, 1);
+
+	/*
+	 * Try to find out if we execute the same state before. If the state is
+	 * same, there is not point try to execute it again.
+	 */
+	if (find_ptr_in_list((struct ptr_list*)bbs->cached_state, hashed_state))
+		return;
+
+	add_ptr_list(&bbs->cached_state, hashed_state);
+
+	bbs->generation = 1;
+
+	FOR_EACH_PTR(bbs->insns, insn) {
+		switch (insn->opcode) {
+		case OP_CLI:
+			execute_disable(insn);
+			break;
+		case OP_STI:
+		case OP_RESTORE:
+			execute_enable(insn);
+			break;
+		case OP_RET:
+			execute_ret(insn);
+			break;
+		}
+	} END_FOR_EACH_PTR(insn);
+
+	if (bbs->noret)
+		goto exit_bb;
+
+		
+	FOR_EACH_PTR(bb->children, child) {
+		check_bb(child);
+	} END_FOR_EACH_PTR(child);
+
+exit_bb:
+	if (ptr_list_size((struct ptr_list*)state_stack) > stacksize) {
+		revert_state(unsigned char, &state_stack, stacksize);
+		hashed_state = NULL;
+	}
+	bbs->generation = 0;
+}
+
+static inline void scan_interrupt_insn(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	struct instruction *insn;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct bb_state *bbs = bb->state;
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+			if (insn->opcode == OP_RET) {
+				add_instruction(&bbs->insns, insn);
+				continue;
+			}
+			else if (insn->opcode != OP_ASM)
+				continue;
+			if (!strcmp(insn->string, "cli"))
+				add_instruction(&bbs->insns, checker_instruction(insn, OP_CLI, NULL));
+			else if (!strcmp(insn->string, "sti"))
+				add_instruction(&bbs->insns, checker_instruction(insn, OP_STI, NULL));
+			else if (!strcmp(insn->string, "pushl %0 ; popfl"))
+				add_instruction(&bbs->insns, checker_instruction(insn, OP_RESTORE, NULL));
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
+}
+
+void check_interrupt(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		bb->state = alloc_bb_state();
+	} END_FOR_EACH_PTR(bb);
+
+	current = INTR_ENABLE;
+	hashed_state = NULL;
+	scan_interrupt_insn(ep);
+	check_bb(ep->entry->bb);
+}
+
Index: sparse/storage.h
===================================================================
Index: sparse/check-nullptr.c
===================================================================
--- sparse.orig/check-nullptr.c	2006-12-28 00:22:18.000000000 -0800
+++ sparse/check-nullptr.c	2006-12-28 00:22:18.000000000 -0800
@@ -0,0 +1,292 @@
+/*
+ * Copyright (C) 2006 Christopher Li <sparse@chrisli.org>
+ *
+ *  Licensed under the Open Software License version 1.1
+ */
+
+#include <stdio.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "linearize.h"
+#include "storage.h"
+#include "checker.h"
+
+
+static int state_count = 0;
+static struct ptr_list *malloc_ident_list = NULL;
+static struct ptr_list *free_ident_list = NULL;
+static struct ptr_list *noret_ident_list = NULL;
+
+static struct blob *current;
+static struct blob *hashed_state;
+static struct state_list *state_stack;
+static void check_bb(struct basic_block *bb);
+
+#define alloc_state() alloc_blob(state_count)
+#define reg_state(pseudo) ((current)->data[pseudo->state_index])
+
+#define PTR_NULL		1
+#define PTR_NOTNULL		2
+#define PTR_FREE		4
+
+enum {
+	OP_DEF_PTR = OP_LAST,
+	OP_USE_PTR,
+	OP_FREE_PTR
+};
+
+static int cmp_insn_pos(const void *a, const void *b)
+{
+	int a1 = ((struct instruction *)a)->offset, b1 = ((struct instruction *)b)->offset;
+	if (a1 == b1)
+		return 0;
+	return a1 > b1 ? 1 : -1;
+}
+
+static void check_bb_cond(struct basic_block *bb, pseudo_t cond, unsigned value)
+{
+	new_state(&state_stack, &reg_state(cond), value);
+	hashed_state = NULL;
+	check_bb(bb);
+}
+
+
+static inline void execute_pointer_define(struct instruction *insn)
+{
+	new_state(&state_stack, &reg_state(insn->src), PTR_NULL | PTR_NOTNULL); 
+	hashed_state = NULL;
+}
+
+static inline void execute_pointer_usage(struct instruction *insn)
+{
+	if (reg_state(insn->src) & PTR_NULL)
+		warning(insn->pos, "funcion %s possible using NULL pointer",
+			show_ident(insn->bb->ep->name->ident));
+	if (reg_state(insn->src) & PTR_FREE)
+		warning(insn->pos, "funcion %s possible using pointer after free",
+			show_ident(insn->bb->ep->name->ident));
+}
+
+static inline void execute_pointer_free(struct instruction *insn)
+{
+	if (reg_state(insn->src) & PTR_FREE)
+		warning(insn->pos, "funcion %s possible double free pointer",
+			show_ident(insn->bb->ep->name->ident));
+	new_state(&state_stack, &reg_state(insn->src), reg_state(insn->src) | PTR_FREE); 
+	hashed_state = NULL;
+
+}
+static void check_bb(struct basic_block *bb)
+{
+	struct bb_state *bbs = bb->state;
+	struct instruction *insn;
+	int stacksize = ptr_list_size((struct ptr_list*)state_stack);
+
+	if (bbs->generation)
+		return;
+
+	if (!hashed_state)
+		hashed_state = create_hashed_blob(current->data, state_count);
+
+	/*
+	 * Try to find out if we execute the same state before. If the state is
+	 * same, there is not point try to execute it again.
+	 */
+	if (find_ptr_in_list((struct ptr_list*)bbs->cached_state, hashed_state))
+		return;
+
+	add_ptr_list(&bbs->cached_state, hashed_state);
+
+	bbs->generation = 1;
+
+	FOR_EACH_PTR(bbs->insns, insn) {
+		switch (insn->opcode) {
+		case OP_DEF_PTR:
+			execute_pointer_define(insn);
+			break;
+		case OP_USE_PTR:
+			execute_pointer_usage(insn);
+			break;
+		case OP_FREE_PTR:
+			execute_pointer_free(insn);
+			break;
+		}
+	} END_FOR_EACH_PTR(insn);
+
+	if (bbs->noret)
+		goto exit_bb;
+
+	if (bbs->branch) {
+		struct instruction *br = bbs->branch;
+		unsigned char orig = reg_state(br->cond);
+		check_bb_cond(br->bb_true, br->cond, orig & ~PTR_NULL);
+		check_bb_cond(br->bb_false, br->cond, orig & ~PTR_NOTNULL);
+	} else {
+		struct basic_block *child;
+		
+		FOR_EACH_PTR(bb->children, child) {
+			check_bb(child);
+		} END_FOR_EACH_PTR(child);
+	}
+
+exit_bb:
+	if (ptr_list_size((struct ptr_list*)state_stack) > stacksize) {
+		revert_state(unsigned char, &state_stack, stacksize);
+		hashed_state = NULL;
+	}
+	bbs->generation = 0;
+}
+
+static inline int match_call_function(struct instruction *insn, struct ptr_list *list)
+{
+	struct ident *ident;
+	pseudo_t fn;
+
+	if (insn->opcode != OP_CALL)
+		return 0;
+	fn = insn->func;
+	if (fn->type != PSEUDO_SYM)
+		return 0;
+	ident = fn->sym->ident;
+	if (!ident)
+		return 0;
+	return find_ptr_in_list(list, ident);
+}
+
+static void follow_pointer_usage(struct instruction *insn, pseudo_t pseudo, int index)
+{
+	struct pseudo_user *pu;
+
+	pseudo->tracking = 1;
+	pseudo->state_index = index;
+
+	FOR_EACH_PTR(pseudo->users, pu) {
+		struct instruction *useri = pu->insn;
+		struct basic_block *bb = useri->bb;
+		struct bb_state *bb_state;
+		if (!bb)
+			continue;
+		bb_state = bb->state;
+
+		switch(useri->opcode) {
+		case OP_CAST: case OP_SCAST: case OP_PTRCAST:
+			/* cast a pointer does not change the pointer state, it is just alias */
+			follow_pointer_usage(useri, useri->target, index);
+			break;
+		case OP_STORE: case OP_SNOP:
+			if (pseudo == useri->src) {
+				struct instruction *use = checker_instruction(useri, OP_USE_PTR,
+									      pseudo);
+				add_instruction(&bb_state->insns, use);
+			}
+			break;
+		case OP_CALL:
+			if (match_call_function(useri, free_ident_list)) {
+				struct instruction *fr = checker_instruction(useri, OP_FREE_PTR,
+									      pseudo);
+				add_instruction(&bb_state->insns, fr);
+			}
+			break;
+		case OP_BR:
+			bb_state->branch = useri;
+			break;
+ 		case OP_SWITCH:
+			warning(insn->pos, "switch on pointer not implemented\n");
+			break;
+		}
+	} END_FOR_EACH_PTR(pu);
+}
+
+static inline void scan_pointer_define(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	struct instruction *insn;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+			if (match_call_function(insn, malloc_ident_list)) {
+				struct instruction *def = checker_instruction(insn, OP_DEF_PTR, insn->target);
+				add_instruction(&bb->state->insns, def);
+				follow_pointer_usage(insn, insn->target, state_count++);
+			}
+			if (match_call_function(insn, noret_ident_list)) {
+				bb->state->noret = 1;
+			}
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		sort_list((struct ptr_list **)&bb->state->insns, cmp_insn_pos);
+	} END_FOR_EACH_PTR(bb);
+}
+
+void check_null_ptr(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	state_count = 0;
+	
+	FOR_EACH_PTR(ep->bbs, bb) {
+		bb->state = alloc_bb_state();
+	} END_FOR_EACH_PTR(bb);
+
+	scan_pointer_define(ep);
+	current = alloc_state();
+	check_bb(ep->entry->bb);
+}
+
+void init_check_null_ptr(void)
+{
+	static const char *malloc_name[] = {
+		"malloc",
+		"__kmalloc",
+		"__kmalloc_node",
+		"__kzalloc",
+		"kmem_cache_alloc",
+		"kmem_cache_zalloc",
+		"kmem_cache_alloc_node",
+		"vmalloc",
+		"vmalloc_user",
+		"vmalloc_node",
+		"vmalloc_32",
+		"vmalloc_32_user",
+		"__vmalloc",
+		NULL,
+	};
+	static const char *free_name[] = {
+		"free",
+		"kfree",
+		"kmem_cache_free",
+		"vfree",
+		NULL,
+	};
+	static const char *noret[] = {
+		"panic",
+		NULL,
+	};
+	int i;
+
+	for (i = 0; malloc_name[i]; i++) {
+		void* id = (void*) built_in_ident(malloc_name[i]);
+		add_ptr_list(&malloc_ident_list, id);
+	}
+
+	for (i = 0; free_name[i]; i++) {
+		void* id = (void*) built_in_ident(free_name[i]);
+		add_ptr_list(&free_ident_list, id);
+	}
+
+	for (i = 0; noret[i]; i++) {
+		void* id = (void*) built_in_ident(noret[i]);
+		add_ptr_list(&noret_ident_list, id);
+	}
+
+}
+
Index: sparse/linearize.c
===================================================================
Index: sparse/ptrlist.c
===================================================================
--- sparse.orig/ptrlist.c	2006-12-28 00:21:06.000000000 -0800
+++ sparse/ptrlist.c	2006-12-28 00:22:18.000000000 -0800
@@ -243,3 +243,29 @@ void __free_ptr_list(struct ptr_list **l
 
 	*listp = NULL;
 }
+
+int find_ptr_in_list(struct ptr_list* list, void *ptr)
+{
+	void *p;
+	FOR_EACH_PTR(list, p) {
+		if (p == ptr)
+			return 1;
+	} END_FOR_EACH_PTR(p);
+	return 0;
+}
+
+int find_ptr_index(struct ptr_list* list, void *ptr)
+{
+	void *p;
+	int i = 0;
+	FOR_EACH_PTR(list, p) {
+		if (p == ptr)
+			return i;
+		i++;
+	} END_FOR_EACH_PTR(p);
+	return -1;
+}
+
+
+
+
