From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 8/8] fix: cast of OP_AND only valid if it's an OP_CAST
Date: Mon,  7 Aug 2017 21:12:05 +0200
Message-ID: <20170807191205.86590-9-luc.vanoostenryck@gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37353 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbdHGTMU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id t138so2044144wmt.4
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 12:12:19 -0700 (PDT)
In-Reply-To: <20170807191205.86590-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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
index cdc244c17..4da8edfde 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1044,7 +1044,7 @@ static int simplify_cast(struct instruction *insn)
 	}
 
 	/* A cast of a "and" might be a no-op.. */
-	if (def_opcode(src) == OP_AND) {
+	if (insn->opcode == OP_CAST && def_opcode(src) == OP_AND) {
 		struct instruction *def = src->def;
 		if (def->size >= size) {
 			pseudo_t val = def->src2;
-- 
2.13.2

