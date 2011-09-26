From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: [PATCH 2/2] sparse, llvm: Add support for logical ops
Date: Mon, 26 Sep 2011 17:47:24 +0300
Message-ID: <1317048444-1772-2-git-send-email-penberg@cs.helsinki.fi>
References: <1317048444-1772-1-git-send-email-penberg@cs.helsinki.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42350 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab1IZOrp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Sep 2011 10:47:45 -0400
Received: by bkbzt4 with SMTP id zt4so5870860bkb.19
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2011 07:47:43 -0700 (PDT)
In-Reply-To: <1317048444-1772-1-git-send-email-penberg@cs.helsinki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>

From: Pekka Enberg <penberg@kernel.org>

The generated asm for logical-ops.c test case looks as follows on x86-64:

GCC 4.6:

  0000000000000000 <and_bool>:
     0:	31 c0                	xor    %eax,%eax
     2:	85 f6                	test   %esi,%esi
     4:	0f 95 c0             	setne  %al
     7:	31 d2                	xor    %edx,%edx
     9:	85 ff                	test   %edi,%edi
     b:	0f 95 c2             	setne  %dl
     e:	21 d0                	and    %edx,%eax
    10:	c3                   	retq

  0000000000000020 <uand_bool>:
    20:	31 c0                	xor    %eax,%eax
    22:	85 f6                	test   %esi,%esi
    24:	0f 95 c0             	setne  %al
    27:	31 d2                	xor    %edx,%edx
    29:	85 ff                	test   %edi,%edi
    2b:	0f 95 c2             	setne  %dl
    2e:	21 d0                	and    %edx,%eax
    30:	c3                   	retq

  0000000000000040 <or_bool>:
    40:	09 fe                	or     %edi,%esi
    42:	0f 95 c0             	setne  %al
    45:	0f b6 c0             	movzbl %al,%eax
    48:	c3                   	retq

  0000000000000050 <uor_bool>:
    50:	09 fe                	or     %edi,%esi
    52:	0f 95 c0             	setne  %al
    55:	0f b6 c0             	movzbl %al,%eax
    58:	c3                   	retq

Sparse/LLVM:

  0000000000000000 <and_bool>:
     0:	85 f6                	test   %esi,%esi
     2:	0f 95 c0             	setne  %al
     5:	85 ff                	test   %edi,%edi
     7:	0f 95 c1             	setne  %cl
     a:	20 c1                	and    %al,%cl
     c:	0f b6 c1             	movzbl %cl,%eax
     f:	c3                   	retq

  0000000000000010 <uand_bool>:
    10:	85 f6                	test   %esi,%esi
    12:	0f 95 c0             	setne  %al
    15:	85 ff                	test   %edi,%edi
    17:	0f 95 c1             	setne  %cl
    1a:	20 c1                	and    %al,%cl
    1c:	0f b6 c1             	movzbl %cl,%eax
    1f:	c3                   	retq

  0000000000000020 <or_bool>:
    20:	09 f7                	or     %esi,%edi
    22:	0f 95 c0             	setne  %al
    25:	0f b6 c0             	movzbl %al,%eax
    28:	c3                   	retq

  0000000000000030 <uor_bool>:
    30:	09 f7                	or     %esi,%edi
    32:	0f 95 c0             	setne  %al
    35:	0f b6 c0             	movzbl %al,%eax
    38:	c3                   	retq

Cc: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 sparse-llvm.c                    |   23 +++++++++++++++++++----
 validation/backend/logical-ops.c |    2 --
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index b015ea3..a85dfea 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -375,12 +375,27 @@ static void output_op_binary(struct function *fn, struct instruction *insn)
 		assert(!symbol_is_fp_type(insn->type));
 		target = LLVMBuildXor(fn->builder, lhs, rhs, target_name);
 		break;
-	case OP_AND_BOOL:
-		assert(0);
+	case OP_AND_BOOL: {
+		LLVMValueRef x, y;
+
+		assert(!symbol_is_fp_type(insn->type));
+
+		y = LLVMBuildICmp(fn->builder, LLVMIntNE, lhs, LLVMConstInt(LLVMTypeOf(lhs), 0, 0), "y");
+		x = LLVMBuildICmp(fn->builder, LLVMIntNE, rhs, LLVMConstInt(LLVMTypeOf(rhs), 0, 0), "x");
+
+		target = LLVMBuildAnd(fn->builder, y, x, target_name);
 		break;
-	case OP_OR_BOOL:
-		assert(0);
+	}
+	case OP_OR_BOOL: {
+		LLVMValueRef tmp;
+
+		assert(!symbol_is_fp_type(insn->type));
+
+		tmp = LLVMBuildOr(fn->builder, rhs, lhs, "tmp");
+
+		target = LLVMBuildICmp(fn->builder, LLVMIntNE, tmp, LLVMConstInt(LLVMTypeOf(tmp), 0, 0), target_name);
 		break;
+	}
 
 	/* Binary comparison */
 	case OP_SET_EQ:
diff --git a/validation/backend/logical-ops.c b/validation/backend/logical-ops.c
index 1a0e924..8b2a6a8 100644
--- a/validation/backend/logical-ops.c
+++ b/validation/backend/logical-ops.c
@@ -1,4 +1,3 @@
-#if 0
 static int and_bool(int x, int y)
 {
 	return x && y;
@@ -18,7 +17,6 @@ static unsigned int uor_bool(unsigned int x, unsigned int y)
 {
 	return x || y;
 }
-#endif
 
 /*
  * check-name: Logical operator code generation
-- 
1.7.6.2

