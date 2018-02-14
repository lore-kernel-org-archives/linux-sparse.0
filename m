From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] IR: let .cond unionize with .src and not .target
Date: Wed, 14 Feb 2018 02:08:42 +0100
Message-ID: <20180214010843.23651-5-luc.vanoostenryck@gmail.com>
References: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39646 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966225AbeBNBK7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 20:10:59 -0500
Received: by mail-wm0-f66.google.com with SMTP id b21so19129940wme.4
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 17:10:59 -0800 (PST)
In-Reply-To: <20180214010843.23651-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In struct instruction, .target is normally used to hold
the result. Its value is thus produced/defined by instructions.
On the contrary, .cond is used as an input value and is
thus used by instructions.

However, these two fields belong to the same union. This
creates slight complications for code, like liveness analysis
which care about which fields are used and which are defined
by the instructions.

Change this by unionizing .cond with .src, .src1 & friends instead
of with .target.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/IR.md | 2 +-
 linearize.h         | 7 +++----
 sparse-llvm.c       | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/IR.md b/Documentation/IR.md
index 27adc91a6..8f5827dfc 100644
--- a/Documentation/IR.md
+++ b/Documentation/IR.md
@@ -12,7 +12,7 @@ The common ones are:
 - .src: (pseudo_t) operand of unary ops (alias for .src1).
 - .target: (pseudo_t) result of unary, binary & ternary ops, is sometimes used
 	otherwise by some others instructions.
-- .cond: (pseudo_t) input operands for condition (alias .target!)
+- .cond: (pseudo_t) input operands for condition (alias .src/.src1)
 - .type: (symbol*) usually the type of .result, sometimes of the operands
 
 ### Terminators
diff --git a/linearize.h b/linearize.h
index 8ff40948c..7c3a0b645 100644
--- a/linearize.h
+++ b/linearize.h
@@ -74,18 +74,17 @@ struct instruction {
 	struct basic_block *bb;
 	struct position pos;
 	struct symbol *type;
-	union {
-		pseudo_t target;
-		pseudo_t cond;		/* for branch and switch */
-	};
+	pseudo_t target;
 	union {
 		struct /* entrypoint */ {
 			struct pseudo_list *arg_list;
 		};
 		struct /* branch */ {
+			pseudo_t cond;
 			struct basic_block *bb_true, *bb_false;
 		};
 		struct /* switch */ {
+			pseudo_t _cond;
 			struct multijmp_list *multijmp_list;
 		};
 		struct /* phi_node */ {
diff --git a/sparse-llvm.c b/sparse-llvm.c
index beb3a5f24..156bd02f3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -809,7 +809,7 @@ static void output_op_switch(struct function *fn, struct instruction *insn)
 			def = jmp->target;
 	} END_FOR_EACH_PTR(jmp);
 
-	sw_val = get_ioperand(fn, insn->type, insn->target);
+	sw_val = get_ioperand(fn, insn->type, insn->cond);
 	target = LLVMBuildSwitch(fn->builder, sw_val,
 				 def ? def->priv : NULL, n_jmp);
 
-- 
2.16.0

