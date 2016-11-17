From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] explicitely ignore killing OP_ENTRY
Date: Thu, 17 Nov 2016 15:35:06 +0100
Message-ID: <20161117143507.3598-8-luc.vanoostenryck@gmail.com>
References: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36247 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbcKQQ5g (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 11:57:36 -0500
Received: by mail-wm0-f67.google.com with SMTP id m203so22987089wma.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 08:57:36 -0800 (PST)
In-Reply-To: <20161117143507.3598-1-luc.vanoostenryck@gmail.com>
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
index 1be9b3d0..afbbb7b6 100644
--- a/simplify.c
+++ b/simplify.c
@@ -232,6 +232,10 @@ void kill_instruction(struct instruction *insn)
 		if (insn->cond)
 			kill_use(&insn->cond);
 		return;
+
+	case OP_ENTRY:
+		/* ignore */
+		return;
 	}
 }
 
-- 
2.10.2

