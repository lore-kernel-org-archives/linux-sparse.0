From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/16] kill_instruction() may need to be forced or not
Date: Thu, 16 Feb 2017 05:57:00 +0100
Message-ID: <20170216045708.50661-9-luc.vanoostenryck@gmail.com>
References: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33946 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbdBPE5X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Feb 2017 23:57:23 -0500
Received: by mail-wr0-f193.google.com with SMTP id c4so636903wrd.1
        for <linux-sparse@vger.kernel.org>; Wed, 15 Feb 2017 20:57:22 -0800 (PST)
In-Reply-To: <20170216045708.50661-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

There is essentially three cases where kill_instruction() is
called:
1) when implicitely removing an instruction via
   kill_use()/remove_usage() once all users of (the target of)
   this instruction have been removed and so this instruction
   become unneeded.
2) when explicitely removing a specific instruction.
3) when explicitely removing all instructions in a basic block
   because it became unreachable.

For 'pure' instructions, like the arithmetic operators, these
three cases can be handled exactly the same but for instructions
having side-effects, special care is needed.
For them case 1) should do nothing while cases 2) & 3) should
remove the instruction and adjust the usage of its operands like
for normal instructions.

To handle this gracefully:
- rename kill_instruction() into kill_insn()
- add a new argument ('force') to kill_insn()
- create kill_instruction() & kill_instruction_force() as inline
  functions calling kill_insn() with 'force' set respectively to 0 & 1.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c     |  3 +--
 flow.h     | 11 ++++++++++-
 simplify.c | 11 ++++++++++-
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/flow.c b/flow.c
index ef07b6db9..8409fac60 100644
--- a/flow.c
+++ b/flow.c
@@ -759,13 +759,12 @@ void kill_bb(struct basic_block *bb)
 	struct basic_block *child, *parent;
 
 	FOR_EACH_PTR(bb->insns, insn) {
-		kill_instruction(insn);
+		kill_instruction_force(insn);
 		kill_defs(insn);
 		/*
 		 * We kill unreachable instructions even if they
 		 * otherwise aren't "killable" (e.g. volatile loads)
 		 */
-		insn->bb = NULL;
 	} END_FOR_EACH_PTR(insn);
 	bb->insns = NULL;
 
diff --git a/flow.h b/flow.h
index 370aaddf1..31ed80d40 100644
--- a/flow.h
+++ b/flow.h
@@ -23,9 +23,18 @@ extern int simplify_instruction(struct instruction *);
 
 extern void kill_bb(struct basic_block *);
 extern void kill_use(pseudo_t *);
-extern void kill_instruction(struct instruction *);
 extern void kill_unreachable_bbs(struct entrypoint *ep);
 
+extern void kill_insn(struct instruction *, int force);
+static inline void kill_instruction(struct instruction *insn)
+{
+	kill_insn(insn, 0);
+}
+static inline void kill_instruction_force(struct instruction *insn)
+{
+	kill_insn(insn, 1);
+}
+
 void check_access(struct instruction *insn);
 void convert_load_instruction(struct instruction *, pseudo_t);
 void rewrite_load_instruction(struct instruction *, struct pseudo_list *);
diff --git a/simplify.c b/simplify.c
index 1fbad1060..b8944f0f7 100644
--- a/simplify.c
+++ b/simplify.c
@@ -182,7 +182,16 @@ static void kill_use_list(struct pseudo_list *list)
 	} END_FOR_EACH_PTR(p);
 }
 
-void kill_instruction(struct instruction *insn)
+/*
+ * kill an instruction:
+ * - remove it from its bb
+ * - remove the usage of all its operands
+ * If forse is zero, the normal case, the function only for
+ * instructions free of (possible) side-effects. Otherwise
+ * the function does that unconditionally (must only be used
+ * for unreachable instructions.
+ */
+void kill_insn(struct instruction *insn, int force)
 {
 	if (!insn || !insn->bb)
 		return;
-- 
2.11.0

