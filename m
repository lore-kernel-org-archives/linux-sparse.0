From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 08/48] ret-void: return nothing only for void functions
Date: Wed, 23 Aug 2017 22:15:14 +0200
Message-ID: <20170823201554.90551-9-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37041 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbdHWUQQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id v186so630144wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:15 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Only void functions should return nothing.
Others functions should return something and if not
we want to be able to emit a diagnostic.

Fix this by testing the return type instead of the size
of the return type.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 298991dcd..69e4f3e8f 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2218,7 +2218,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		struct symbol *ret_type = base_type->ctype.base_type;
 		struct instruction *insn = alloc_typed_instruction(OP_RET, ret_type);
 
-		if (type_size(ret_type) > 0)
+		if (!is_void_type(ret_type))
 			use_pseudo(insn, result, &insn->src);
 		add_one_insn(ep, insn);
 	}
-- 
2.14.0

