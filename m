From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 26/52] llvm: adjust OP_RET's type
Date: Mon, 27 Mar 2017 23:23:50 +0200
Message-ID: <20170327212416.18536-27-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33464 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdC0V05 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:57 -0400
Received: by mail-wr0-f193.google.com with SMTP id 20so17043339wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:50 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    | 1 +
 validation/backend/pointer-sub.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index b89b04105..dad330443 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -660,6 +660,7 @@ static void output_op_ret(struct function *fn, struct instruction *insn)
 	if (pseudo && pseudo != VOID) {
 		LLVMValueRef result = pseudo_to_value(fn, insn, pseudo);
 
+		result = adjust_type(fn, insn->type, result);
 		LLVMBuildRet(fn->builder, result);
 	} else
 		LLVMBuildRetVoid(fn->builder);
diff --git a/validation/backend/pointer-sub.c b/validation/backend/pointer-sub.c
index 4017faf69..3cb8f5a9d 100644
--- a/validation/backend/pointer-sub.c
+++ b/validation/backend/pointer-sub.c
@@ -14,5 +14,4 @@ long subvx3(void *p, int   a) { return (p - ((void*)0)) ^ 3; }
 /*
  * check-name: pointer-sub
  * check-command: sparsec -Wno-decl -c $file -o tmp.o
- * check-known-to-fail
  */
-- 
2.12.0

