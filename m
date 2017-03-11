From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 25/27] llvm: remove unneeded 'generation'
Date: Sat, 11 Mar 2017 10:07:04 +0100
Message-ID: <20170311090706.17171-26-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36471 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753648AbdCKJHt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:49 -0500
Received: by mail-wr0-f196.google.com with SMTP id l37so14058010wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:47 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's not needed here since there is no recursive access to BBs.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index e35ac01a2..4fc5777c7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1024,12 +1024,10 @@ static void output_insn(struct function *fn, struct instruction *insn)
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
@@ -1043,7 +1041,6 @@ static void output_bb(struct function *fn, struct basic_block *bb, unsigned long
 
 static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 {
-	unsigned long generation = ++bb_generation;
 	struct symbol *sym = ep->name;
 	struct symbol *base_type = sym->ctype.base_type;
 	struct symbol *ret_type = sym->ctype.base_type->ctype.base_type;
@@ -1088,9 +1085,6 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 
 	/* create the BBs */
 	FOR_EACH_PTR(ep->bbs, bb) {
-		if (bb->generation == generation)
-			continue;
-
 		LLVMBasicBlockRef bbr;
 		char bbname[32];
 		struct instruction *insn;
@@ -1121,12 +1115,9 @@ static void output_fn(LLVMModuleRef module, struct entrypoint *ep)
 	END_FOR_EACH_PTR(bb);
 
 	FOR_EACH_PTR(ep->bbs, bb) {
-		if (bb->generation == generation)
-			continue;
