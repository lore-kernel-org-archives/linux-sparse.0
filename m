From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/29] ret-void: return nothing only for void functions
Date: Wed, 16 Aug 2017 17:34:33 +0200
Message-ID: <20170816153455.97693-8-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33923 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdHPPfT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so3696812wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:19 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

