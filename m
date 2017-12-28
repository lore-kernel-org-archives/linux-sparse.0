From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] llvm: simplify emit of null pointers
Date: Thu, 28 Dec 2017 23:30:25 +0100
Message-ID: <20171228223026.39089-2-luc.vanoostenryck@gmail.com>
References: <20171228223026.39089-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42310 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdL1War (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:30:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id f21so2579939wmh.1
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:30:47 -0800 (PST)
In-Reply-To: <20171228223026.39089-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Most pointers with a constant value are simply null-pointers.
The only exception is when a known address is casted to pointer.

The current code only handle code for the general case:
emit code for a constant integer and then cast this to a pointer.
This obfuscate a bit the ouput, making it hard to read.

Change this by special handling the normal case of null-pointers
by directly using LLVM's LLVMConstPointerNull().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a8186df5b..4c64f1aaa 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -340,14 +340,16 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 
 static LLVMValueRef constant_value(unsigned long long val, LLVMTypeRef dtype)
 {
-	LLVMTypeRef itype;
 	LLVMValueRef result;
 
 	switch (LLVMGetTypeKind(dtype)) {
 	case LLVMPointerTypeKind:
-		itype = LLVMIntType(bits_in_pointer);
-		result = LLVMConstInt(itype, val, 1);
-		result = LLVMConstIntToPtr(result, dtype);
+		if (val != 0) {	 // for example: ... = (void*) 0x123;
+			LLVMTypeRef itype = LLVMIntType(bits_in_pointer);
+			result = LLVMConstInt(itype, val, 1);
+			result = LLVMConstIntToPtr(result, dtype);
+		}
+		result = LLVMConstPointerNull(dtype);
 		break;
 	case LLVMIntegerTypeKind:
 		result = LLVMConstInt(dtype, val, 1);
-- 
2.15.0

