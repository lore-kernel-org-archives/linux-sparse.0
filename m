From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 1/2] fix result type of relational and logical operators
Date: Fri, 24 May 2013 09:30:35 -0400
Message-ID: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ve0-f172.google.com ([209.85.128.172]:40793 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792Ab3EXNcS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 May 2013 09:32:18 -0400
Received: by mail-ve0-f172.google.com with SMTP id b10so3386777vea.31
        for <linux-sparse@vger.kernel.org>; Fri, 24 May 2013 06:32:17 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Xi Wang <xi.wang@gmail.com>, Pekka Enberg <penberg@kernel.org>

The result type of relational operators (e.g., x < y) and logical
operators (e.g., x && y) in C should be int, rather than bool.

For example, sparse incorrectly evaluates sizeof(x < y) to 1 (i.e.,
sizeof(int)), which should have been sizeof(int).

This patch fixes the result type of these operators in evaluation,
linearization, and the LLVM backend.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Pekka Enberg <penberg@kernel.org>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 evaluate.c              | 15 +++++++++------
 linearize.c             |  4 ++--
 sparse-llvm.c           | 29 ++++++++++++++++++-----------
 validation/cond_expr3.c | 17 +++++++++++++++++
 4 files changed, 46 insertions(+), 19 deletions(-)
 create mode 100644 validation/cond_expr3.c

diff --git a/evaluate.c b/evaluate.c
index 0dfa519..5d87444 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -860,12 +860,13 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	if (!evaluate_conditional(expr->right, 0))
 		return NULL;
 
-	expr->ctype = &bool_ctype;
+	/* the result is int [6.5.13(3), 6.5.14(3)] */
+	expr->ctype = &int_ctype;
 	if (expr->flags) {
 		if (!(expr->left->flags & expr->right->flags & Int_const_expr))
 			expr->flags = 0;
 	}
-	return &bool_ctype;
+	return &int_ctype;
 }
 
 static struct symbol *evaluate_binop(struct expression *expr)
@@ -1064,8 +1065,9 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	return NULL;
 
 OK:
-	expr->ctype = &bool_ctype;
-	return &bool_ctype;
+	/* the result is int [6.5.8(6), 6.5.9(3)]*/
+	expr->ctype = &int_ctype;
+	return &int_ctype;
 }
 
 /*
@@ -1805,14 +1807,15 @@ static struct symbol *evaluate_preop(struct expression *expr)
 			warning(expr->pos, "%s degrades to integer",
 				show_typename(ctype->ctype.base_type));
 		}
-		ctype = &bool_ctype;
+		/* the result is int [6.5.3.3(5)]*/
+		ctype = &int_ctype;
 		break;
 
 	default:
 		break;
 	}
 	expr->ctype = ctype;
-	return &bool_ctype;
+	return ctype;
 }
 
 static struct symbol *find_identifier(struct ident *ident, struct symbol_list *_list, int *offset)
diff --git a/linearize.c b/linearize.c
index 1d15cfd..c6ada1e 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1064,7 +1064,7 @@ static pseudo_t linearize_regular_preop(struct entrypoint *ep, struct expression
 		return pre;
 	case '!': {
 		pseudo_t zero = value_pseudo(0);
-		return add_binary_op(ep, expr->unop->ctype, OP_SET_EQ, pre, zero);
+		return add_binary_op(ep, expr->ctype, OP_SET_EQ, pre, zero);
 	}
 	case '~':
 		return add_uniop(ep, expr, OP_NOT, pre);
@@ -1418,7 +1418,7 @@ static pseudo_t linearize_compare(struct entrypoint *ep, struct expression *expr
 
 	pseudo_t src1 = linearize_expression(ep, expr->left);
 	pseudo_t src2 = linearize_expression(ep, expr->right);
-	pseudo_t dst = add_binary_op(ep, expr->left->ctype, cmpop[expr->op], src1, src2);
+	pseudo_t dst = add_binary_op(ep, expr->ctype, cmpop[expr->op], src1, src2);
 	return dst;
 }
 
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 6f2fbd6..6ee4c1d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -544,29 +544,34 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
 		break;
 	case OP_AND_BOOL: {
-		LLVMValueRef x, y;
+		LLVMValueRef lhs_nz, rhs_nz;
+		LLVMTypeRef dst_type;
 
-		assert(!symbol_is_fp_type(insn->type));
-
-		y = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, LLVMConstInt(LLVMTypeOf(lhs), 0, 0), "y");
-		x = LLVMBuildICmp(fn->builder, LLVMIntNE, rhs, LLVMConstInt(LLVMTypeOf(rhs), 0, 0), "x");
+		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
+		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
+		target = LLVMBuildAnd(fn->builder, lhs_nz, rhs_nz, target_name);
 
-		target = LLVMBuildAnd(fn->builder, y, x, target_name);
+		dst_type = insn_symbol_type(fn->module, insn);
+		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
 	case OP_OR_BOOL: {
-		LLVMValueRef tmp;
-
-		assert(!symbol_is_fp_type(insn->type));
+		LLVMValueRef lhs_nz, rhs_nz;
+		LLVMTypeRef dst_type;
 
-		tmp = LLVMBuildOr(fn->builder, rhs, lhs, "tmp");
+		lhs_nz = LLVMBuildIsNotNull(fn->builder, lhs, "");
+		rhs_nz = LLVMBuildIsNotNull(fn->builder, rhs, "");
+		target = LLVMBuildOr(fn->builder, lhs_nz, rhs_nz, target_name);
 
-		target = LLVMBuildICmp(fn->builder, LLVMIntNE, tmp, LLVMConstInt(LLVMTypeOf(tmp), 0, 0), target_name);
+		dst_type = insn_symbol_type(fn->module, insn);
+		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
 
 	/* Binary comparison */
 	case OP_BINCMP ... OP_BINCMP_END: {
+		LLVMTypeRef dst_type = insn_symbol_type(fn->module, insn);
+
 		if (LLVMGetTypeKind(LLVMTypeOf(lhs)) == LLVMIntegerTypeKind) {
 			LLVMIntPredicate op = translate_op(insn->opcode);
 
@@ -576,6 +581,8 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 
 			target = LLVMBuildFCmp(fn->builder, op, lhs, rhs, target_name);
 		}
+
+		target = LLVMBuildZExt(fn->builder, target, dst_type, target_name);
 		break;
 	}
 	default:
diff --git a/validation/cond_expr3.c b/validation/cond_expr3.c
new file mode 100644
index 0000000..748409e
--- /dev/null
+++ b/validation/cond_expr3.c
@@ -0,0 +1,17 @@
+static int icmp = 1 / (sizeof(int) - sizeof(1 > 0));
+static int fcmp = 1 / (sizeof(int) - sizeof(1.0 == 2.0 - 1.0));
+static int lnot = 1 / (sizeof(int) - sizeof(!!1.0));
+static int land = 1 / (sizeof(int) - sizeof(2 && 3));
+static int lor  = 1 / (sizeof(int) - sizeof('c' || 1.0f));
+
+/*
+ * check-name: result type of relational and logical operators
+ *
+ * check-error-start
+cond_expr3.c:1:21: warning: division by zero
+cond_expr3.c:2:21: warning: division by zero
+cond_expr3.c:3:21: warning: division by zero
+cond_expr3.c:4:21: warning: division by zero
+cond_expr3.c:5:21: warning: division by zero
+ * check-error-end
+ */
-- 
1.8.1.2

