From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 7/8] explicitely ignore killing OP_ENTRY
Date: Sun, 29 Jan 2017 11:48:07 +0100
Message-ID: <20170129104808.2500-8-luc.vanoostenryck@gmail.com>
References: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32896 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdA2KtA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 05:49:00 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so8887951wmv.0
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 02:48:59 -0800 (PST)
In-Reply-To: <20170129104808.2500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It doesn't change anything, it's more for documentation
purpose.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/simplify.c b/simplify.c
index 690fdc4e8..66550fa3d 100644
--- a/simplify.c
+++ b/simplify.c
@@ -231,6 +231,10 @@ void kill_instruction(struct instruction *insn)
 		if (insn->bb_true && insn->bb_false)
 			kill_use(&insn->cond);
 		return;
+
+	case OP_ENTRY:
+		/* ignore */
+		return;
 	}
 }
 
-- 
2.11.0

