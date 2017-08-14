From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] llvm: only compare void pointers
Date: Mon, 14 Aug 2017 21:41:52 +0200
Message-ID: <20170814194152.36289-4-luc.vanoostenryck@gmail.com>
References: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36864 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdHNTmM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 15:42:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so15522104wmt.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 12:42:11 -0700 (PDT)
In-Reply-To: <20170814194152.36289-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

