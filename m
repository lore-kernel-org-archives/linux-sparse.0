From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] allow to normalize the pseudos
Date: Sat,  3 Jun 2017 09:34:16 +0200
Message-ID: <20170603073416.66808-4-luc.vanoostenryck@gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36424 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdFCHed (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 3 Jun 2017 03:34:33 -0400
Received: by mail-wm0-f65.google.com with SMTP id k15so22056139wmh.3
        for <linux-sparse@vger.kernel.org>; Sat, 03 Jun 2017 00:34:32 -0700 (PDT)
In-Reply-To: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Using the output of test-linearize for testing is not
ideal because some details of this output are very dependent
to small changes in linearization or optimization while the
test in itself may very well not concerned about those changes.

One of the things that are particulary sensitive to these changes
is the number of the pseudos (%r123, ...).

Make these tests much less sensitive to these changes by adding
a normalization phase called just before emitting the output.
This normalization will renumber all the pseudos sequentially,
restarting at %r1 at each functions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile         |   1 +
 lib.c            |   2 +
 lib.h            |   1 +
 linearize.h      |   1 +
 norm-pseudo.c    | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 test-linearize.c |   2 +
 test-unssa.c     |   2 +
 7 files changed, 126 insertions(+)
 create mode 100644 norm-pseudo.c

diff --git a/Makefile b/Makefile
index b32fc96ea..dee432e0e 100644
--- a/Makefile
+++ b/Makefile
@@ -106,6 +106,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  expression.o show-parse.o evaluate.o expand.o inline.o linearize.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
+	  norm-pseudo.o \
 	  stats.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
diff --git a/lib.c b/lib.c
index a38a6f622..4f5d06849 100644
--- a/lib.c
+++ b/lib.c
@@ -255,6 +255,7 @@ int dbg_dead = 0;
 
 int fmem_report = 0;
 int fdump_linearize;
+int fnormalize_pseudos = 0;
 
 int preprocess_only;
 
@@ -709,6 +710,7 @@ err:
 
 static struct flag fflags[] = {
 	{ "mem-report", &fmem_report },
+	{ "normalize-pseudos", &fnormalize_pseudos },
 };
 
 static char **handle_switch_f(char *arg, char **next)
diff --git a/lib.h b/lib.h
index 2c8529f93..b6cb34308 100644
--- a/lib.h
+++ b/lib.h
@@ -142,6 +142,7 @@ extern int dbg_dead;
 
 extern int fmem_report;
 extern int fdump_linearize;
+extern int fnormalize_pseudos;
 
 extern int arch_m64;
 
diff --git a/linearize.h b/linearize.h
index bac82d7ff..cbd66187f 100644
--- a/linearize.h
+++ b/linearize.h
@@ -341,6 +341,7 @@ void show_entry(struct entrypoint *ep);
 const char *show_pseudo(pseudo_t pseudo);
 void show_bb(struct basic_block *bb);
 const char *show_instruction(struct instruction *insn);
+void normalize_pseudos(struct entrypoint *ep);
 
 #endif /* LINEARIZE_H */
 
diff --git a/norm-pseudo.c b/norm-pseudo.c
new file mode 100644
index 000000000..920841c49
--- /dev/null
+++ b/norm-pseudo.c
@@ -0,0 +1,117 @@
+#include "linearize.h"
+
+static int pseudo_nr;
+
+static void norm_pseudo(pseudo_t pseudo, int init)
+{
+	if (!pseudo)
+		return;
+	if (pseudo->type != PSEUDO_REG)
+		return;
+	if (init) {
+		if (!pseudo->nr)
+			return;
+		pseudo->nr = 0;
+	} else {
+		if (pseudo->nr)
+			return;
+		pseudo->nr = ++pseudo_nr;
+	}
+}
+
+static void norm_asm_constraints(struct asm_constraint_list *list, int init)
+{
+	struct asm_constraint *entry;
+
+	FOR_EACH_PTR(list, entry) {
+		norm_pseudo(entry->pseudo, init);
+	} END_FOR_EACH_PTR(entry);
+}
+
+static void norm_insn(struct instruction *insn, int init)
+{
+	switch (insn->opcode) {
+	case OP_SEL:
+	case OP_RANGE:
+		norm_pseudo(insn->src3, init);
+		/* fall through */
+
+	case OP_BINARY ... OP_BINARY_END:
+	case OP_BINCMP ... OP_BINCMP_END:
+		norm_pseudo(insn->src2, init);
+		/* fall through */
+
+	case OP_LOAD: case OP_LNOP:
+	case OP_STORE: case OP_SNOP:
+	case OP_CAST:
+	case OP_SCAST:
+	case OP_FPCAST:
+	case OP_PTRCAST:
+	case OP_NOT: case OP_NEG:
+	case OP_COPY:
+	case OP_PHISOURCE:
+	case OP_RET:
+	case OP_SLICE:
+		norm_pseudo(insn->src, init);
+		/* fall through */
+
+	case OP_PHI:
+	case OP_SYMADDR:
+	case OP_SETVAL:
+	case OP_DEATHNOTE:
+	case OP_CBR:
+	case OP_SWITCH:
+	case OP_COMPUTEDGOTO:
+		norm_pseudo(insn->target, init);
+		break;
+
+	case OP_INLINED_CALL:
+	case OP_CALL: {
+		struct pseudo *arg;
+		FOR_EACH_PTR(insn->arguments, arg) {
+			norm_pseudo(arg, init);
+		} END_FOR_EACH_PTR(arg);
+		norm_pseudo(insn->target, init);
+		break;
+	}
+
+	case OP_ASM:
+		if (!insn->asm_rules)
+			break;
+		norm_asm_constraints(insn->asm_rules->outputs, init);
+		norm_asm_constraints(insn->asm_rules->inputs, init);
+		norm_asm_constraints(insn->asm_rules->clobbers, init);
+		break;
+
+	case OP_NOP:
+		break;
+
+	default:
+		break;
+	}
+}
+
+static void norm_ep(struct entrypoint *ep, int init)
+{
+	struct basic_block *bb;
+	struct instruction *insn;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		if (!bb->ep)
+			continue;
+		FOR_EACH_PTR(bb->insns, insn) {
+			if (!insn->bb)
+				continue;
+			norm_insn(insn, init);
+		} END_FOR_EACH_PTR(bb);
+	} END_FOR_EACH_PTR(bb);
+}
+
+void normalize_pseudos(struct entrypoint *ep)
+{
+	if (!ep)
+		return;
+	norm_ep(ep, 1);
+	pseudo_nr = 0;
+	norm_ep(ep, 0);
+}
diff --git a/test-linearize.c b/test-linearize.c
index fe0673bef..2bcfb9833 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -47,6 +47,8 @@ static void clean_up_symbols(struct symbol_list *list)
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
+		if (fnormalize_pseudos)
+			normalize_pseudos(ep);
 		if (ep)
 			show_entry(ep);
 	} END_FOR_EACH_PTR(sym);
diff --git a/test-unssa.c b/test-unssa.c
index 240d99601..900163aa4 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -37,6 +37,8 @@ static void output_fn(struct entrypoint *ep)
 		printf("\n\n.globl %s\n%s:\n", name, name);
 
 	unssa(ep);
+	if (fnormalize_pseudos)
+		normalize_pseudos(ep);
 
 	FOR_EACH_PTR(ep->bbs, bb) {
 		if (bb->generation == generation)
-- 
2.13.0

