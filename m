From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 25/48] mem2reg: reorg externaly_visible() returns
Date: Wed, 23 Aug 2017 22:15:31 +0200
Message-ID: <20170823201554.90551-26-luc.vanoostenryck@gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37207 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932565AbdHWUQu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:16:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id v186so631934wmf.4
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:16:50 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 mem2reg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mem2reg.c b/mem2reg.c
index 6fe864df0..a9bf78ed4 100644
--- a/mem2reg.c
+++ b/mem2reg.c
@@ -247,7 +247,7 @@ static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 	struct pseudo_user *pu;
 
 	if (mod)
-		goto external_visibility;
+		return mod;
 
 	FOR_EACH_PTR(pseudo->users, pu) {
 		/* We know that the symbol-pseudo use is the "src" in the instruction */
@@ -261,8 +261,7 @@ static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 		case OP_SYMADDR:
 			if (!insn->bb)
 				continue;
-			mod |= MOD_ADDRESSABLE;
-			goto external_visibility;
+			return MOD_ADDRESSABLE;
 		case OP_NOP:
 		case OP_SNOP:
 		case OP_LNOP:
@@ -273,8 +272,7 @@ static unsigned long externaly_visible(struct symbol *sym, unsigned long mod)
 		}
 	} END_FOR_EACH_PTR(pu);
 
-external_visibility:
-	return mod;
+	return 0;
 }
 
 static void promote_symbol(struct entrypoint *ep, struct symbol *sym)
-- 
2.14.0

