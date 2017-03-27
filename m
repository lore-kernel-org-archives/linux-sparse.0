From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 40/52] llvm: fix mutated OP_RET
Date: Mon, 27 Mar 2017 23:24:04 +0200
Message-ID: <20170327212416.18536-41-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33627 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbdC0V1Y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:27:24 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so17044462wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:27:04 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index af540033d..9d8ece69d 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -690,9 +690,7 @@ static void output_op_ret(struct function *fn, struct instruction *insn)
 	pseudo_t pseudo = insn->src;
 
 	if (pseudo && pseudo != VOID) {
-		LLVMValueRef result = pseudo_to_value(fn, insn->type, pseudo);
