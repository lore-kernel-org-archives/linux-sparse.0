From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 58/63] llvm: fix get value from initialized symbol
Date: Tue, 21 Mar 2017 01:16:02 +0100
Message-ID: <20170321001607.75169-59-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33368 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756075AbdCUARX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11so269465wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:22 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6e6d49bf2..73ca96cce 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -295,6 +295,8 @@ static const char *pseudo_name(pseudo_t pseudo, char *buf)
 
 static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 {
+	const char *name = show_ident(sym->ident);
+	LLVMTypeRef type = symbol_type(sym);
 	LLVMValueRef result = NULL;
 	struct expression *expr;
 
@@ -314,7 +316,7 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 			LLVMSetInitializer(data, LLVMConstString(strdup(s), strlen(s) + 1, true));
 
 			result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
-			break;
+			return result;
 		}
 		case EXPR_SYMBOL: {
 			struct symbol *sym = expr->symbol;
@@ -324,21 +326,18 @@ static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
 			break;
 		}
 		default:
-			assert(0);
+			break;
 		}
-	} else {
-		const char *name = show_ident(sym->ident);
-		LLVMTypeRef type = symbol_type(sym);
+	}
 
-		if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
-			result = LLVMGetNamedFunction(fn->module, name);
-			if (!result)
-				result = LLVMAddFunction(fn->module, name, type);
-		} else {
-			result = LLVMGetNamedGlobal(fn->module, name);
-			if (!result)
-				result = LLVMAddGlobal(fn->module, type, name);
-		}
+	if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
+		result = LLVMGetNamedFunction(fn->module, name);
+		if (!result)
+			result = LLVMAddFunction(fn->module, name, type);
+	} else {
+		result = LLVMGetNamedGlobal(fn->module, name);
+		if (!result)
+			result = LLVMAddGlobal(fn->module, type, name);
 	}
 
 	return result;
-- 
2.12.0

