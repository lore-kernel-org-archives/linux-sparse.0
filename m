From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] use show_pseudo() for OP_SYMADDR's symbol
Date: Wed, 14 Feb 2018 01:28:04 +0100
Message-ID: <20180214002804.22668-3-luc.vanoostenryck@gmail.com>
References: <20180214002804.22668-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56268 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966200AbeBNA2N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:28:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id a84so7919245wmi.5
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 16:28:13 -0800 (PST)
In-Reply-To: <20180214002804.22668-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In show_instruction(), what is done to display OP_SYMADDR's
symbol is very close to what is done to display a PSEUDO_SYM.
In fact, what is done by show_pseudo() is more complete and
more informative.

So simply use show_pseudo() to display this part. This will
also avoid crashes caused by a NULL symbol.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/linearize.c b/linearize.c
index c174d631f..4995d06ec 100644
--- a/linearize.c
+++ b/linearize.c
@@ -342,24 +342,11 @@ const char *show_instruction(struct instruction *insn)
 		buf += sprintf(buf, ".L%u", insn->bb_true->nr);
 		break;
 
-	case OP_SYMADDR: {
-		struct symbol *sym = insn->symbol->sym;
+	case OP_SYMADDR:
 		buf += sprintf(buf, "%s <- ", show_pseudo(insn->target));
