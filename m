From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] llvm: default init of arrays & structs
Date: Thu, 28 Dec 2017 23:30:26 +0100
Message-ID: <20171228223026.39089-3-luc.vanoostenryck@gmail.com>
References: <20171228223026.39089-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38508 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1Was (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:30:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id 64so45644015wme.3
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:30:47 -0800 (PST)
In-Reply-To: <20171228223026.39089-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Linearization of arrays & structs default initialization is done
as if these objects would be an integer as large as the object.
This integer is then simply zero-initialized.
(This may be objectionable and will be done differently).

However, sparse-llvm is not ready to handle this situation where
a non-scalar is initialized with a scalar value.

Workaround this by using LLVMConstNull() when possible.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 4c64f1aaa..a1a48fd0f 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -354,6 +354,12 @@ static LLVMValueRef constant_value(unsigned long long val, LLVMTypeRef dtype)
 	case LLVMIntegerTypeKind:
 		result = LLVMConstInt(dtype, val, 1);
 		break;
+	case LLVMArrayTypeKind:
+	case LLVMStructTypeKind:
+		if (val != 0)
+			return NULL;
+		result = LLVMConstNull(dtype);
+		break;
 	default:
 		return NULL;
 	}
-- 
2.15.0

