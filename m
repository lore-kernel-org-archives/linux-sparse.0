From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 02/52] llvm: remove unneeded 'generation'
Date: Mon, 27 Mar 2017 23:23:26 +0200
Message-ID: <20170327212416.18536-3-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33181 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdC0V03 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so17041383wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:27 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not needed here since there is no recursive access to BBs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9b702863d..f41fbe6e3 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -911,12 +911,10 @@ static void output_insn(struct function *fn, struct instruction *insn)
 	}
 }
 
-static void output_bb(struct function *fn, struct basic_block *bb, unsigned long generation)
+static void output_bb(struct function *fn, struct basic_block *bb)
 {
 	struct instruction *insn;
 
-	bb->generation = generation;
-
 	FOR_EACH_PTR(bb->insns, insn) {
 		if (!insn->bb)
 			continue;
@@ -930,7 +928,6 @@ static void output_bb(struct function *fn, struct basic_block *bb, unsigned long
 
 static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 {
-	unsigned long generation = ++bb_generation;
 	struct symbol *sym = ep->name;
 	struct symbol *base_type = sym->ctype.base_type;
 	struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
@@ -964,9 +961,6 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	static int nr_bb;
 
 	FOR_EACH_PTR(ep->bbs, bb) {
-		if (bb->generation == generation)
-			continue;
-
 		LLVMBasicBlockRef bbr;
 		char bbname[32];
 		struct instruction *insn;
@@ -997,12 +991,9 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	END_FOR_EACH_PTR(bb);
 
 	FOR_EACH_PTR(ep->bbs, bb) {
-		if (bb->generation == generation)
-			continue;
