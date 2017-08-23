From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 26/48] mem2reg: ignore all killed instructions
Date: Wed, 23 Aug 2017 22:15:32 +0200
Message-ID: <20170823201554.90551-27-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33757 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932629AbdHWUQv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id b79so663068wmf.0
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:51 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index a9bf78ed4..7096a4bf2 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -253,14 +253,15 @@ static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
 		struct instruction *insn = pu->insn;
 
+		if (!insn->bb)
+			continue;
+
 		switch (insn->opcode) {
 		case OP_STORE:
 			break;
 		case OP_LOAD:
 			break;
 		case OP_SYMADDR:
-			if (!insn->bb)
-				continue;
 			return MOD_ADDRESSABLE;
 		case OP_NOP:
 		case OP_SNOP:
-- 
2.14.0

