From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 22/52] llvm: ignore OP_INLINED_CALL
Date: Mon, 27 Mar 2017 23:23:46 +0200
Message-ID: <20170327212416.18536-23-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33421 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdC0V0s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:48 -0400
Received: by mail-wr0-f194.google.com with SMTP id 20so17043014wrx.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:46 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 9633941e7..c64bfe2f7 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -929,7 +929,6 @@ static void output_insn(struct function *fn, struct instruction *insn)
 		assert(0);
 		break;
 	case OP_INLINED_CALL:
-		assert(0);
 		break;
 	case OP_CALL:
 		output_op_call(fn, insn);
-- 
2.12.0

