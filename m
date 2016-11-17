From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] add missing PACK_PTR_LIST()
Date: Thu, 17 Nov 2016 18:25:58 +0100
Message-ID: <20161117172559.29417-2-luc.vanoostenryck@gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35115 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934935AbcKQR0K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:26:10 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so23342618wme.2
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:26:09 -0800 (PST)
In-Reply-To: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

At two places in the code, DELETE_PTR() is called on soem list
but PACK_PTR_LIST() is not called at the end of the loop.
This potentially leave empty ptrlist 'blocks' which are not handled
by the usual list walking macros.

No concrete situation have been found where a real problem
occurs but better be safe than sorry and call PACK_PTR_LIST()
here too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c      | 1 +
 evaluate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/cse.c b/cse.c
index e8fbe344..71325a74 100644
--- a/cse.c
+++ b/cse.c
@@ -260,6 +260,7 @@ static struct instruction * cse_one_instruction(struct instruction *insn, struct
 				if (pu->insn == insn)
 					DELETE_CURRENT_PTR(pu);
 			} END_FOR_EACH_PTR(pu);
+			PACK_PTR_LIST(&phi->users);
 		} END_FOR_EACH_PTR(phi);
 	}
 
diff --git a/evaluate.c b/evaluate.c
index e350c0c0..d1383902 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2521,6 +2521,7 @@ found:
 		excess(e, lclass & TYPE_PTR ? "array" : "struct or union");
 
 	} END_FOR_EACH_PTR(e);
+	PACK_PTR_LIST(&expr->expr_list);
 
 	convert_designators(last);
 	expr->ctype = ctype;
-- 
2.10.2

