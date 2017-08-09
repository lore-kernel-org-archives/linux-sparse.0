From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 9/9] fix: cast of OP_AND only valid if it's an OP_CAST
Date: Wed,  9 Aug 2017 21:38:06 +0200
Message-ID: <20170809193806.30975-10-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38250 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdHITjJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:39:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id y206so598669wmd.5
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:39:08 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index 370d4cb81..dc4fd457b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1036,7 +1036,7 @@ static int simplify_cast(struct instruction *insn)
 	}
 
 	/* A cast of a "and" might be a no-op.. */
-	if (def_opcode(src) == OP_AND) {
+	if (insn->opcode == OP_CAST && def_opcode(src) == OP_AND) {
 		struct instruction *def = src->def;
 		if (def->size >= size) {
 			pseudo_t val = def->src2;
-- 
2.14.0

