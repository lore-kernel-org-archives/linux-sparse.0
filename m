From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 7] Adding the interrupt checker
Date: Fri, 9 Feb 2007 16:26:04 -0800
Message-ID: <20070210002604.GA20748@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([204.127.200.84]:51647 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946812AbXBJAyl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 9 Feb 2007 19:54:41 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

Changelog:
 - Using the new inline function calling annotation to find
   out the irq related call. It now works both inline and
   external functions. Bonus is no more x86 asm any more.
 - The noise level of interrupt check drop considerably.
   I think it is less nosier than the context checking.

Signed-off-by: Christopher Li<sparse@chrisli.org>

Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2007-02-09 14:14:33.000000000 -0800
+++ sparse/lib.c	2007-02-09 14:15:08.000000000 -0800
@@ -191,6 +191,7 @@ int Wenum_mismatch = 1;
 int Wdo_while = 1;
 int Wuninitialized = 1;
 int Wmalloc = 1;
+int Winterrupt = 1;
 
 int dbg_entry = 0;
 int dbg_dead = 0;
@@ -341,6 +342,7 @@ static const struct warning {
 	{ "do-while", &Wdo_while },
 	{ "uninitialized", &Wuninitialized },
 	{ "malloc", &Wmalloc},
+	{ "interrupt", &Winterrupt},
 };
 
 enum {
Index: sparse/Makefile
===================================================================
--- sparse.orig/Makefile	2007-02-09 14:14:33.000000000 -0800
+++ sparse/Makefile	2007-02-09 14:15:08.000000000 -0800
@@ -34,7 +34,7 @@ LIB_OBJS= target.o parse.o tokenize.o pr
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o \
-	  blobhash.o check-nullptr.o
+	  blobhash.o check-nullptr.o check-interrupt.o
 
 LIB_FILE= libsparse.a
 SLIB_FILE= libsparse.so
@@ -139,6 +139,7 @@ dissect.o: $(LIB_H)
 graph.o: $(LIB_H)
 blobstate.o: $(LIB_H)
 check-nullptr.o: $(LIB_H)
+check-interrupt.o: $(LIB_H)
 
 compat-linux.o: compat/strtold.c compat/mmap-blob.c \
 	$(LIB_H)
Index: sparse/checker.h
===================================================================
--- sparse.orig/checker.h	2007-02-09 14:14:53.000000000 -0800
+++ sparse/checker.h	2007-02-09 14:15:27.000000000 -0800
@@ -137,6 +137,8 @@ static inline int match_call_function(st
 
 extern void check_null_ptr_init(void);
 extern void check_null_ptr(struct entrypoint *ep);
+extern void check_interrupt(struct entrypoint *ep);
+extern void check_interrupt_init(void);
 
 #endif
 
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2007-02-09 14:14:33.000000000 -0800
+++ sparse/lib.h	2007-02-09 14:15:08.000000000 -0800
@@ -97,6 +97,7 @@ extern int Wcast_truncate;
 extern int Wdo_while;
 extern int Wuninitialized;
 extern int Wmalloc;
+extern int Winterrupt;
 
 extern int dbg_entry;
 extern int dbg_dead;
Index: sparse/sparse.c
===================================================================
--- sparse.orig/sparse.c	2007-02-09 14:14:33.000000000 -0800
+++ sparse/sparse.c	2007-02-09 14:15:08.000000000 -0800
@@ -273,6 +273,8 @@ static void check_symbols(struct symbol_
 			check_context(ep);
 			if (Wmalloc)
 				check_null_ptr(ep);
+			if (Winterrupt)
+				check_interrupt(ep);
 		}
 	} END_FOR_EACH_PTR(sym);
 }
Index: sparse/check-interrupt.c
===================================================================
--- sparse.orig/check-interrupt.c	2007-02-09 14:15:08.000000000 -0800
+++ sparse/check-interrupt.c	2007-02-09 14:15:08.000000000 -0800
@@ -0,0 +1,210 @@
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
+static struct ptr_list *irq_enable_list;
+static struct ptr_list *irq_disable_list;
+static struct ptr_list *irq_restore_list;
+
+enum {
+	OP_IRQ_ENABLE = OP_LAST,
+	OP_IRQ_DISABLE,
+	OP_IRQ_RESTORE,
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
+		warning(insn->pos, "checker function %s double enable",
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
+		warning(insn->pos, "checker function %s exit with interrupt disabled",
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
+		case OP_IRQ_DISABLE:
+			execute_disable(insn);
+			break;
+		case OP_IRQ_ENABLE:
+		case OP_IRQ_RESTORE:
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
+static inline void scan_call_instruction(struct bb_state *bbs, struct instruction *insn)
+{
+	pseudo_t fn = insn->func;
+	struct ident *name;
+
+	if (fn->type != PSEUDO_SYM)
+		return;
+ 	name = fn->sym->ident;
+	if (find_ptr_in_list(irq_enable_list, name))
+		add_instruction(&bbs->insns, checker_instruction(insn, OP_IRQ_ENABLE, NULL));
+	else if (find_ptr_in_list(irq_disable_list, name))
+		add_instruction(&bbs->insns, checker_instruction(insn, OP_IRQ_DISABLE, NULL));
+	else if (find_ptr_in_list(irq_restore_list, name))
+		add_instruction(&bbs->insns, checker_instruction(insn, OP_IRQ_RESTORE, NULL));
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
+void check_interrupt_init(void)
+{
+	static const char *enable[] = {
+		"raw_local_irq_enable",
+		"raw_safe_halt",
+		"_spin_unlock_irq",
+		"_read_unlock_irq",
+		"_write_unlock_irq",
+		"schedule",		// XXX: is it always true?
+	};
+	static const char *disable[] = {
+		"raw_local_irq_disable",
+		"_spin_lock_irq",
+		"task_rq_lock",
+		"_spin_lock_irqsave",
+		"_read_lock_irq",
+		"_read_lock_irqsave",
+		"_write_lock_irq",
+		"_write_lock_irqsave",
+		"lock_timer_base",
+		"lock_timer",
+	};
+	static const char *restore[] = {
+		"raw_local_irq_restore",
+		"_spin_unlock_irqrestore",
+		"_read_unlock_irqrestore",
+		"_write_unlock_irqrestore",
+	};
+	
+	irq_enable_list = build_ident_list(enable);
+	irq_disable_list = build_ident_list(disable);
+	irq_restore_list = build_ident_list(restore);
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
