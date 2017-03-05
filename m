From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/13] llvm: add a helper to convert an integer to a ValueRef
Date: Sun,  5 Mar 2017 12:20:35 +0100
Message-ID: <20170305112047.3411-2-luc.vanoostenryck@gmail.com>
References: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36346 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbdCEL3a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Mar 2017 06:29:30 -0500
Received: by mail-wr0-f194.google.com with SMTP id l37so18339325wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 05 Mar 2017 03:29:29 -0800 (PST)
In-Reply-To: <20170305112047.3411-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This needs to take in account the fact that the value can have
a non-integer type, for example it can be an address constant.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9f362b3ed..41ee1fa1f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -303,6 +303,30 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	}
 }
 
+static LLVMValueRef val_to_value(struct function *fn, unsigned long long val, struct symbol *ctype)
+{
+	LLVMTypeRef dtype;
+	LLVMTypeRef itype;
+	LLVMValueRef result;
+
+	assert(ctype);
+	dtype = symbol_type(fn->module, ctype);
+	switch (LLVMGetTypeKind(dtype)) {
+	case LLVMPointerTypeKind:
+		itype = LLVMIntType(bits_in_pointer);
+		result = LLVMConstInt(itype, val, 1);
+		result = LLVMConstIntToPtr(result, dtype);
+		break;
+	case LLVMIntegerTypeKind:
+		result = LLVMConstInt(dtype, val, 1);
+		break;
+	default:
+		assert(0);
+	}
+
+	return result;
+}
+
 static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
 	LLVMValueRef result = NULL;
-- 
2.11.1

