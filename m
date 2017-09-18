From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] llvm: gracefully catch impossible type/value
Date: Mon, 18 Sep 2017 11:30:11 +0200
Message-ID: <20170918093014.11878-3-luc.vanoostenryck@gmail.com>
References: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37772 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932580AbdIRJa1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 05:30:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so278775wmh.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 02:30:26 -0700 (PDT)
In-Reply-To: <20170918093014.11878-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Until now, in sparse-llvm, an assert(0) was used each time
something which was not yet handled was encountered.

This is doubly annoying because:
- the assert gave no info about the cause
- it also hide possible further issuses.

Fix this by:
- removing the asserts
- use a warnng explaining what's at hand
- try to continue with the following instructions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 3a68d09d9..9855ae403 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -353,18 +353,23 @@ static LLVMValueRef constant_value(unsigned long long val, LLVMTypeRef dtype)
 		result = LLVMConstInt(dtype, val, 1);
 		break;
 	default:
-		assert(0);
+		return NULL;
 	}
 	return result;
 }
 
 static LLVMValueRef val_to_value(unsigned long long val, struct symbol *ctype)
 {
+	LLVMValueRef result;
 	LLVMTypeRef dtype;
 
 	assert(ctype);
 	dtype = symbol_type(ctype);
-	return constant_value(val, dtype);
+	result = constant_value(val, dtype);
+	if (result)
+		return result;
+	sparse_error(ctype->pos, "no value possible for %s", show_typename(ctype));
+	return LLVMGetUndef(symbol_type(ctype));
 }
 
 static LLVMValueRef pseudo_to_value(struct function *fn, struct symbol *ctype, pseudo_t pseudo)
@@ -647,6 +652,8 @@ static void output_op_compare(struct function *fn, struct instruction *insn)
 		rhs = constant_value(insn->src2->value, LLVMTypeOf(lhs));
 	else
 		rhs = pseudo_to_value(fn, NULL, insn->src2);
+	if (!rhs)
+		rhs = LLVMGetUndef(symbol_type(insn->type));
 
 	pseudo_name(insn->target, target_name);
 
-- 
2.14.0

