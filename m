From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 22/51] llvm: ignore OP_INLINED_CALL
Date: Sat, 25 Mar 2017 00:20:28 +0100
Message-ID: <20170324232057.15033-23-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34926 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935315AbdCXXXt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so808586wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:48 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

