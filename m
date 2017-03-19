From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 14/30] llvm: extract get_sym_value() from pseudo_to_value()
Date: Sun, 19 Mar 2017 02:42:11 +0100
Message-ID: <20170319014227.8833-15-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32827 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751315AbdCSBmx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:42:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so8916491wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:42:52 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 100 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 072cf2638..d7e8ee725 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -305,6 +305,57 @@ static void pseudo_name(pseudo_t pseudo, char *buf)
 	}
 }
 
+static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
+{
+	LLVMValueRef result = NULL;
+	struct expression *expr;
+
+	assert(sym->bb_target == NULL);
+
+	expr = sym->initializer;
+	if (expr) {
+		switch (expr->type) {
+		case EXPR_STRING: {
+			const char *s = expr->string->data;
+			LLVMValueRef indices[] = { LLVMConstInt(LLVMInt64Type(), 0, 0), LLVMConstInt(LLVMInt64Type(), 0, 0) };
+			LLVMValueRef data;
+
+			data = LLVMAddGlobal(fn->module, LLVMArrayType(LLVMInt8Type(), strlen(s) + 1), ".str");
+			LLVMSetLinkage(data, LLVMPrivateLinkage);
+			LLVMSetGlobalConstant(data, 1);
+			LLVMSetInitializer(data, LLVMConstString(strdup(s), strlen(s) + 1, true));
+
+			result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
+			break;
+		}
+		case EXPR_SYMBOL: {
+			struct symbol *sym = expr->symbol;
+
+			result = LLVMGetNamedGlobal(fn->module, show_ident(sym->ident));
+			assert(result != NULL);
+			break;
+		}
+		default:
+			assert(0);
+		}
+	} else {
+		const char *name = show_ident(sym->ident);
+		LLVMTypeRef type = symbol_type(sym);
+
+		if (LLVMGetTypeKind(type) == LLVMFunctionTypeKind) {
+			result = LLVMGetNamedFunction(fn->module, name);
+			if (!result)
+				result = LLVMAddFunction(fn->module, name, type);
+		} else {
+			result = LLVMGetNamedGlobal(fn->module, name);
+			if (!result)
+				result = LLVMAddGlobal(fn->module, type, name);
+		}
+	}
+
+	return result;
+}
+
 static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *insn, pseudo_t pseudo)
 {
 	LLVMValueRef result = NULL;
@@ -313,54 +364,9 @@ static LLVMValueRef pseudo_to_value(struct function *fn, struct instruction *ins
 	case PSEUDO_REG:
 		result = pseudo->priv;
 		break;
-	case PSEUDO_SYM: {
-		struct symbol *sym = pseudo->sym;
-		struct expression *expr;
-
-		assert(sym->bb_target == NULL);
-
-		expr = sym->initializer;
-		if (expr) {
-			switch (expr->type) {
-			case EXPR_STRING: {
-				const char *s = expr->string->data;
-				LLVMValueRef indices[] = { LLVMConstInt(LLVMInt64Type(), 0, 0), LLVMConstInt(LLVMInt64Type(), 0, 0) };
-				LLVMValueRef data;
-
-				data = LLVMAddGlobal(fn->module, LLVMArrayType(LLVMInt8Type(), strlen(s) + 1), ".str");
-				LLVMSetLinkage(data, LLVMPrivateLinkage);
-				LLVMSetGlobalConstant(data, 1);
-				LLVMSetInitializer(data, LLVMConstString(strdup(s), strlen(s) + 1, true));
-
-				result = LLVMConstGEP(data, indices, ARRAY_SIZE(indices));
-				break;
-			}
-			case EXPR_SYMBOL: {
-				struct symbol *sym = expr->symbol;
-
-				result = LLVMGetNamedGlobal(fn->module, show_ident(sym->ident));
-				assert(result != NULL);
-				break;
-			}
-			default:
-				assert(0);
-			}
-		} else {
-			const char *name = show_ident(sym->ident);
-			LLVMTypeRef type = symbol_type(sym);
