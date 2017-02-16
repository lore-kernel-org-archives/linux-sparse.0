From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] CSE: avoid hashing removed instructions
Date: Fri, 17 Feb 2017 00:12:30 +0100
Message-ID: <20170216231231.5781-4-luc.vanoostenryck@gmail.com>
References: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35531 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbdBPXOn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 18:14:43 -0500
Received: by mail-wr0-f195.google.com with SMTP id q39so3648570wrb.2
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 15:14:42 -0800 (PST)
In-Reply-To: <20170216231231.5781-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cse.c b/cse.c
index 5380f4ccd..0d3815c5a 100644
--- a/cse.c
+++ b/cse.c
@@ -43,6 +43,8 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 		return;
 	assert(insn->bb == bb);
 	repeat_phase |= simplify_instruction(insn);
+	if (!insn->bb)
+		return;
 	hash = (insn->opcode << 3) + (insn->size >> 3);
 	switch (insn->opcode) {
 	case OP_SEL:
-- 
2.11.0

