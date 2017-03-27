From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 46/52] llvm: fix get value from initialized symbol
Date: Mon, 27 Mar 2017 23:24:10 +0200
Message-ID: <20170327212416.18536-47-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33691 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbdC0V1V (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:21 -0400
Received: by mail-wr0-f195.google.com with SMTP id 20so17045017wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:15 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 8b170b4bf..65b859f4b 100644
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

