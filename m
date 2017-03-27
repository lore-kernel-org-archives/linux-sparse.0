From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 01/15] don't output value of anonymous symbol's pointer
Date: Mon, 27 Mar 2017 19:33:51 +0200
Message-ID: <20170327173405.11405-2-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34541 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so12461847wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:19 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The value of this pointer is of no use unless you're
using a debugger (or just to see if two things are
identical or not) and it's presence produces noise
when comparing the output of two runs for testing.

Change this by issuing it only if 'verbose' is set.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linearize.c b/linearize.c
index 9c2d48aca..7dccf21d8 100644
--- a/linearize.c
+++ b/linearize.c
@@ -120,7 +120,7 @@ const char *show_pseudo(pseudo_t pseudo)
 			break;
 		}
 		expr = sym->initializer;
-		snprintf(buf, 64, "<anon symbol:%p>", sym);
+		snprintf(buf, 64, "<anon symbol:%p>", verbose ? sym : NULL);
 		if (expr) {
 			switch (expr->type) {
 			case EXPR_VALUE:
@@ -328,7 +328,7 @@ const char *show_instruction(struct instruction *insn)
 			buf += sprintf(buf, "%s", show_ident(sym->ident));
 			break;
 		}
-		buf += sprintf(buf, "<anon symbol:%p>", sym);
+		buf += sprintf(buf, "<anon symbol:%p>", verbose ? sym : NULL);
 		break;
 	}
 		
-- 
2.12.0

