From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 8/8] fix: cast of OP_AND only valid if it's an OP_CAST
Date: Wed,  9 Aug 2017 01:06:34 +0200
Message-ID: <20170808230634.16227-9-luc.vanoostenryck@gmail.com>
References: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36349 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdHHXHB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 8 Aug 2017 19:07:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so4904237wma.3
        for <linux-sparse@vger.kernel.org>; Tue, 08 Aug 2017 16:07:01 -0700 (PDT)
In-Reply-To: <20170808230634.16227-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A cast of an OP_AND can be simplified away if the mask
already 'cover' the value.
However this cannot be done if the cast is in fact
a sign-extension.

Fix this by adding the appropriate check of OP_CAST vs. OP_SCAST

Fixes: caeaf72d34d1e91aaea7340241232d1d877907b7
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 23cdd19ae..daf91d82b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1046,7 +1046,7 @@ static int simplify_cast(struct instruction *insn)
 	}
 
 	/* A cast of a "and" might be a no-op.. */
-	if (def_opcode(src) == OP_AND) {
+	if (insn->opcode == OP_CAST && def_opcode(src) == OP_AND) {
 		struct instruction *def = src->def;
 		if (def->size >= size) {
 			pseudo_t val = def->src2;
-- 
2.13.2

