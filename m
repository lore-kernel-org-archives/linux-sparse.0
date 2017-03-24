From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 33/51] llvm: make value_to_pvalue() more flexible
Date: Sat, 25 Mar 2017 00:20:39 +0100
Message-ID: <20170324232057.15033-34-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36183 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935549AbdCXXX7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so804799wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:58 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

