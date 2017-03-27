From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 33/52] llvm: make value_to_pvalue() more flexible
Date: Mon, 27 Mar 2017 23:23:57 +0200
Message-ID: <20170327212416.18536-34-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36769 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdC0V1D (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:03 -0400
Received: by mail-wr0-f193.google.com with SMTP id u1so17118033wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:57 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 884570e1d..57f662a79 100644
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

