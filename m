From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] llvm: only compare void pointers
Date: Mon, 18 Sep 2017 11:30:14 +0200
Message-ID: <20170918093014.11878-6-luc.vanoostenryck@gmail.com>
References: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37790 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbdIRJaa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:30:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so278865wmh.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:30:29 -0700 (PDT)
In-Reply-To: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

LLVM use a stricter type system fro it's IR than sparse does.
In the present case, sparse allow to compare pointers regardless
of their types.

This create LLVM errors if we try to simply translate, instruction
by instruction, spasre compare instructions to LLVM compares.

Fix this by casting all pointers to void *, before comparing them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a68d09d9..9a0a76096 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -654,6 +654,10 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 
 	switch  (LLVMGetTypeKind(LLVMTypeOf(lhs))) {
 	case LLVMPointerTypeKind:
+		lhs = value_to_pvalue(fn, &ptr_ctype, lhs);
+		rhs = value_to_pvalue(fn, &ptr_ctype, rhs);
+		/* fall through */
+
 	case LLVMIntegerTypeKind: {
 		LLVMIntPredicate op = translate_op(insn->opcode);
 
-- 
2.14.0

