From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 38/63] llvm: adjust OP_RET's type
Date: Tue, 21 Mar 2017 01:15:42 +0100
Message-ID: <20170321001607.75169-39-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33412 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755973AbdCUARC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id g10so20441845wrg.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:01 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c                    | 1 +
 validation/backend/pointer-sub.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 421e29251..b0ecc1972 100644
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

