From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] avoid crash with test-linearize -vv
Date: Sun, 19 Mar 2017 19:01:18 +0100
Message-ID: <20170319180118.83953-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36148 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbdCSSJo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 19 Mar 2017 14:09:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id l37so15379576wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 19 Mar 2017 11:09:43 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When verbose is set to 2 or higher, show_instruction()
also display removed instructions. Some of these instructions
can have their associated symbol removed and set to NULL
which will cause a crash with 'test-linearize -vv'.

Fix this by avoiding to dereference symbol's details of
removed instructions.
---
 linearize.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linearize.c b/linearize.c
index 4ebd6d6d8..1bbada887 100644
--- a/linearize.c
+++ b/linearize.c
@@ -319,6 +319,8 @@ const char *show_instruction(struct instruction *insn)
 		struct symbol *sym = insn->symbol->sym;
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
 
+		if (!insn->bb && !sym)
+			break;
 		if (sym->bb_target) {
 			buf += sprintf(buf, ".L%u", sym->bb_target->nr);
 			break;
-- 
2.12.0

