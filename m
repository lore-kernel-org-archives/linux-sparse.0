From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 21/63] llvm: extract get_sym_value() from pseudo_to_value()
Date: Tue, 21 Mar 2017 01:15:25 +0100
Message-ID: <20170321001607.75169-22-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34308 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbdCUAQn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id u48so20449467wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:42 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
