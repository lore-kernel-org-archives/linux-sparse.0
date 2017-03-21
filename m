From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 34/63] llvm: ignore OP_INLINED_CALL
Date: Tue, 21 Mar 2017 01:15:38 +0100
Message-ID: <20170321001607.75169-35-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33200 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755916AbdCUAQ5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so268474wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:56 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 87850d2be..e6134af29 100644
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

