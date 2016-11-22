From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] OP_SWITCH should use 'insn->cond' instead of 'insn->target'
Date: Tue, 22 Nov 2016 17:32:33 +0100
Message-ID: <20161122163233.3765-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36166 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755695AbcKVQeR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Nov 2016 11:34:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id m203so4943533wma.3
        for <linux-sparse@vger.kernel.org>; Tue, 22 Nov 2016 08:32:39 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

From: Luc Van Oostenryck <luc.vanoostenryck@looxix.net>

show_instruction() uses the field 'target' to display OP_SWITCH
instruction instead of 'cond' like OP_BR does.
It doesn't change anything since these two fields use the same
storage inside struct instruction but better to use the right field
to keep consistent.
---
 linearize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index c6ada1e8..31d2a6cd 100644
--- a/linearize.c
+++ b/linearize.c
@@ -357,7 +357,7 @@ const char *show_instruction(struct instruction *insn)
 	}
 	case OP_SWITCH: {
 		struct multijmp *jmp;
-		buf += sprintf(buf, "%s", show_pseudo(insn->target));
+		buf += sprintf(buf, "%s", show_pseudo(insn->cond));
 		FOR_EACH_PTR(insn->multijmp_list, jmp) {
 			if (jmp->begin == jmp->end)
 				buf += sprintf(buf, ", %d -> .L%p", jmp->begin, jmp->target);
-- 
2.10.2

