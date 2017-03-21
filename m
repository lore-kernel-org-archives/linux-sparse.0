From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 45/63] llvm: make value_to_pvalue() more flexible
Date: Tue, 21 Mar 2017 01:15:49 +0100
Message-ID: <20170321001607.75169-46-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34959 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbdCUARJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so259250wmb.2
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:08 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 238cf0f50..58bddf216 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -425,10 +425,19 @@ static LLVMValueRef value_to_ivalue(struct function *fn, LLVMValueRef val)
 
 static LLVMValueRef value_to_pvalue(struct function *fn, struct symbol *ctype, LLVMValueRef val)
 {
-	if (LLVMGetTypeKind(LLVMTypeOf(val)) == LLVMIntegerTypeKind) {
-		LLVMTypeRef dtype = symbol_type(ctype);
-		const char *name = LLVMGetValueName(val);
+	const char *name = LLVMGetValueName(val);
+	LLVMTypeRef dtype = symbol_type(ctype);
+
+	assert(is_ptr_type(ctype));
+	switch (LLVMGetTypeKind(LLVMTypeOf(val))) {
+	case LLVMIntegerTypeKind:
 		val = LLVMBuildIntToPtr(fn->builder, val, dtype, name);
+		break;
+	case LLVMPointerTypeKind:
+		val = LLVMBuildBitCast(fn->builder, val, dtype, name);
+		break;
+	default:
+		break;
 	}
 	return val;
 }
-- 
2.12.0

