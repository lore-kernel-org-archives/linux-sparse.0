From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 8] Adding spinlock checker
Date: Fri, 9 Feb 2007 16:28:58 -0800
Message-ID: <20070210002858.GF20644@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc15.comcast.net ([206.18.177.55]:63981 "EHLO
	alnrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946812AbXBJA5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:57:35 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

The spinlock checker is aim to replace the current sparse
spinlock context checking.

Current all the spinlock operation inside a function apply
to one checking state, because I have not good way to identify
the locking storage.  e.g.

spin_lock(current->xxx_lock);
/* do some thing */
spin_unlock(current->xxx_lock);

Unless we know current is a constant function here, we don't know
unlocking is using the same lock storage as locking.

Other than that, the spinlock checker is generating less warning than
the context checking because it known the non-inlined spinlock function
as well.

Index: sparse/check-spinlock.c
===================================================================
--- sparse.orig/check-spinlock.c	2007-02-09 14:13:45.000000000 -0800
+++ sparse/check-spinlock.c	2007-02-09 14:13:45.000000000 -0800
@@ -0,0 +1,233 @@
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
+/*
+ * There is no good way to identify which the locking variable for
+ * pairing unlock yet.
+ * 	e.g. current->xxx_lock is a function call.
+ * The current spinlock checker just mix all the spinlock operation
+ * into one spinlock level state.
+ */
+
+static int state_count = 0;
+
+static struct blob *current;
+static struct blob *hashed_state;
+static struct state_list *state_stack = NULL;
+static struct ptr_list *spin_lock_list;
+static struct ptr_list *spin_unlock_list;
+
+enum {
+	OP_LOCK = OP_LAST,
+	OP_UNLOCK,
+};
+
+enum {
+	SPIN_UNLOCKED,
+	SPIN_LOCKED,
+};
+
+#define alloc_state() alloc_blob(state_count)
+#define reg_state(pseudo) ((current)->data[0 /*pseudo->state_index */])
+
+
+static inline void execute_lock(struct instruction *insn)
+{
+	char level = reg_state(insn->src) + 1;
+	new_state(&state_stack, &reg_state(insn->src), level); 
+	hashed_state = NULL;
+}
+
+static inline void execute_unlock(struct instruction *insn)
+{
+	char level = reg_state(insn->src);
+	if (!level) {
+		warning(insn->pos, "checker-spinlock function %s unlock level below zero\n",
+			show_ident(insn->bb->ep->name->ident));
+		return;
+	}
+	level--;
+	new_state(&state_stack, &reg_state(insn->src), level); 
+	hashed_state = NULL;
+}
+
+static inline void execute_ret(struct instruction *insn)
+{
+	char level = current->data[0];
+
+	if (level) {
+		warning(insn->pos, "checker-spinlock function %s exit with locking",
+			show_ident(insn->bb->ep->name->ident));
+	}
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
+		case OP_LOCK:
+			execute_lock(insn);
+			break;
+		case OP_UNLOCK:
+			execute_unlock(insn);
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
+static inline pseudo_t spinlock_argument(struct pseudo_list *args)
+{
+	pseudo_t pseudo = first_pseudo(args);
+	if (pseudo && !pseudo->tracking) {
+		pseudo->tracking = 1;
+		pseudo->state_index = state_count++;
+	}
+	return pseudo;
+}
+
+static inline void scan_call_instruction(struct bb_state *bbs, struct instruction *insn)
+{
+	pseudo_t fn = insn->func;
+	struct ident *name;
+	int op = OP_BADOP;
+	pseudo_t pseudo;
+
+	if (fn->type != PSEUDO_SYM)
+		return;
+ 	name = fn->sym->ident;
+	if (find_ptr_in_list(spin_lock_list, name))
+		op = OP_LOCK;
+	else if (find_ptr_in_list(spin_unlock_list, name))
+		op = OP_UNLOCK;
+	else
+		return;
+	pseudo = spinlock_argument(insn->arguments);
+	if (!pseudo)
+		return;
+	add_instruction(&bbs->insns, checker_instruction(insn, op, pseudo));
+}
+
+static inline void scan_spinlock_insn(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+	struct instruction *insn;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		struct bb_state *bbs = bb->state;
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+
+			switch (insn->opcode) {
+			case OP_RET:
+				add_instruction(&bbs->insns, insn);
+				break;
+			case OP_INLINED_CALL:
+			case OP_CALL:
+				scan_call_instruction(bbs, insn);
+				break;
+			}
+		} END_FOR_EACH_PTR(insn);
+	} END_FOR_EACH_PTR(bb);
+}
+
+void check_spinlock_init(void)
+{
+	static const char *unlock[] = {
+		"_spin_unlock",
+		"__raw_spin_unlock",
+		"__raw_read_unlock",
+		"__raw_write_unlock",
+		"_spin_unlock_irqrestore",
+		"_read_unlock_irqrestore",
+		"_write_unlock_irqrestore",
+	};
+	static const char *lock[] = {
+		"__raw_spin_lock",
+		"_spin_lock",
+		"_spin_lock_irq",
+		"task_rq_lock",
+		"_spin_lock_irqsave",
+		"_read_lock_irq",
+		"_read_lock_irqsave",
+		"_write_lock_irq",
+		"_write_lock_irqsave",
+	};
+	
+	spin_lock_list = build_ident_list(lock);
+	spin_unlock_list = build_ident_list(unlock);
+}
+
+void check_spinlock(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	state_count = 0;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		bb->state = alloc_bb_state();
+	} END_FOR_EACH_PTR(bb);
+
+	hashed_state = NULL;
+	scan_spinlock_insn(ep);
+	current = alloc_state();
+	check_bb(ep->entry->bb);
+}
+
Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-02-09 14:13:37.000000000 -0800
+++ sparse/lib.c	2007-02-09 14:13:45.000000000 -0800
@@ -192,6 +192,7 @@ int Wdo_while = 1;
 int Wuninitialized = 1;
 int Wmalloc = 1;
 int Winterrupt = 1;
+int Wspinlock = 1;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
Index: sparse/Makefile
===================================================================
--- sparse.orig/Makefile	2007-02-09 14:13:37.000000000 -0800
+++ sparse/Makefile	2007-02-09 14:13:45.000000000 -0800
@@ -34,7 +34,7 @@ LIB_OBJS= target.o parse.o tokenize.o pr
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
-	  blobhash.o check-nullptr.o check-interrupt.o
+	  blobhash.o check-nullptr.o check-interrupt.o check-spinlock.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -140,6 +140,7 @@ graph.o: $(LIB_H)
 blobstate.o: $(LIB_H)
 check-nullptr.o: $(LIB_H)
 check-interrupt.o: $(LIB_H)
+check-spinlock.o: $(LIB_H)
 
 compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 	$(LIB_H)
Index: sparse/checker.h
===================================================================
--- sparse.orig/checker.h	2007-02-09 14:13:35.000000000 -0800
+++ sparse/checker.h	2007-02-09 14:13:57.000000000 -0800
@@ -139,6 +139,8 @@ extern void check_null_ptr_init(void);
 extern void check_null_ptr(struct entrypoint *ep);
 extern void check_interrupt(struct entrypoint *ep);
 extern void check_interrupt_init(void);
+extern void check_spinlock(struct entrypoint *ep);
+extern void check_spinlock_init(void);
 
 #endif
 
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-02-09 14:13:37.000000000 -0800
+++ sparse/lib.h	2007-02-09 14:13:45.000000000 -0800
@@ -98,6 +98,7 @@ extern int Wdo_while;
 extern int Wuninitialized;
 extern int Wmalloc;
 extern int Winterrupt;
+extern int Wspinlock;
 
 extern int dbg_entry;
 extern int dbg_dead;
Index: sparse/sparse.c
===================================================================
--- sparse.orig/sparse.c	2007-02-09 14:13:37.000000000 -0800
+++ sparse/sparse.c	2007-02-09 14:13:45.000000000 -0800
@@ -275,6 +275,8 @@ static void check_symbols(struct symbol_
 				check_null_ptr(ep);
 			if (Winterrupt)
 				check_interrupt(ep);
+			if (Wspinlock)
+				check_spinlock(ep);
 		}
 	} END_FOR_EACH_PTR(sym);
 }
@@ -289,6 +291,7 @@ int main(int argc, char **argv)
 
 	check_null_ptr_init();
 	check_interrupt_init();
+	check_spinlock_init();
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
 	} END_FOR_EACH_PTR_NOTAG(file);
Index: sparse/check-interrupt.c
===================================================================
