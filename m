From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 28/30] llvm: adjust OP_RET's type
Date: Sun, 19 Mar 2017 02:42:25 +0100
Message-ID: <20170319014227.8833-29-luc.vanoostenryck@gmail.com>
References: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35332 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbdCSBnH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 21:43:07 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so13841500wrb.2
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 18:43:06 -0700 (PDT)
In-Reply-To: <20170319014227.8833-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    | 1 +
 validation/backend/pointer-sub.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 332a5e2a1..f320f7288 100644
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

