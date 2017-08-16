From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 21/29] sssa: add basic implementation
Date: Wed, 16 Aug 2017 17:34:47 +0200
Message-ID: <20170816153455.97693-22-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38008 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdHPPfq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:46 -0400
Received: by mail-wr0-f196.google.com with SMTP id g32so3684483wrd.5
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:45 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This a direct implementation of the pseudo-code for the
new SSA construction method a described in it's paper:

  "Simple and Efficient Construction of Static Single Assignment Form"
	by Matthias Braun, Sebastian Buchwald, Sebastian Hack,
	   Roland Leissa, Christoph Mallon and Andreas Zwinkau.

[cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf]

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile |  1 +
 ssa.c    | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 ssa.c

diff --git a/Makefile b/Makefile
index 762aee505..bcd7ab7da 100644
--- a/Makefile
+++ b/Makefile
@@ -118,6 +118,7 @@ LIB_OBJS= target.o parse.o tokenize.o pre-process.o symbol.o lib.o scope.o \
 	  char.o sort.o allocate.o compat-$(OS).o ptrlist.o \
 	  builtin.o \
 	  ptrmap.o \
+	  ssa.o \
 	  stats.o \
 	  flow.o cse.o simplify.o memops.o liveness.o storage.o unssa.o dissect.o
 
diff --git a/ssa.c b/ssa.c
new file mode 100644
index 000000000..32e440669
--- /dev/null
+++ b/ssa.c
@@ -0,0 +1,98 @@
+/*
+ * This is an implementation of the SSA construction algorithm:
+ *	"Simple and Efficient Construction of Static Single Assignment Form"
+ * by Matthias Braun, Sebastian Buchwald, Sebastian Hack, Roland Leissa,
+ *    Christoph Mallon and Andreas Zwinkau.
+ * cfr. http://www.cdl.uni-saarland.de/papers/bbhlmz13cc.pdf
+ */
+
+#include "ssa.h"
+#include "linearize.h"
+#include "flow.h"
+#include "lib.h"
+#include <assert.h>
+
+
+// FIXME: -> common file
+static void append_instruction(struct basic_block *bb, struct instruction *insn)
+{
+	struct instruction *br = delete_last_instruction(&bb->insns);
+	insn->bb = bb;
+	add_instruction(&bb->insns, insn);
+	add_instruction(&bb->insns, br);
+}
+
+static pseudo_t add_phi_operand(struct symbol *var, pseudo_t phi)
+{
+	struct instruction *node = phi->def;
+	struct basic_block *parent;
+
+	FOR_EACH_PTR(node->bb->parents, parent) {
+		pseudo_t val = load_var(parent, var);
+		struct instruction *phisrc = alloc_phisrc(val, var);
+		pseudo_t src = phisrc->target;
+		append_instruction(parent, phisrc);
+		use_pseudo(node, src, add_pseudo(&node->phi_list, src));
+	} END_FOR_EACH_PTR(parent);
+	return phi;
+}
+
+static pseudo_t load_var_parents(struct basic_block *bb, struct symbol *var)
+{
+	pseudo_t val;
+
+	if (!bb->sealed) {	// incomplete CFG
+		val = insert_phi_node(bb, var);
+		val->def->var = var;
+		goto out;
+	}
+
+	switch (bb_list_size(bb->parents)) {
+	case 0:	// never defined
+		val = undef_pseudo();
+		break;
+	case 1: // no phi needed
+		val = load_var(first_basic_block(bb->parents), var);
+		break;
+	default:
+		val = insert_phi_node(bb, var);
+		store_var(bb, var, val);
+		val = add_phi_operand(var, val);
+	}
+
+out:
+	store_var(bb, var, val);
+	return val;
+}
+
+pseudo_t load_var(struct basic_block *bb, struct symbol *var)
+{
+	pseudo_t val = phi_map_lookup(var->phi_map, bb);
+	if (!val)
+		val = load_var_parents(bb, var);
+	return val;
+}
+
+void store_var(struct basic_block *bb, struct symbol *var, pseudo_t val)
+{
+	phi_map_update(&var->phi_map, bb, val);
+}
+
+void seal_bb(struct basic_block *bb)
+{
+	struct instruction *insn;
+	if (bb->sealed)
+		return;
+	FOR_EACH_PTR(bb->insns, insn) {
+		struct symbol *var;
+		if (!insn->bb)
+			continue;
+		if (insn->opcode != OP_PHI)
+			break;
+		var = insn->var;
+		assert(var);
+		insn->var = NULL;
+		add_phi_operand(var, insn->target);
+	} END_FOR_EACH_PTR(insn);
+	bb->sealed = 1;
+}
-- 
2.14.0

