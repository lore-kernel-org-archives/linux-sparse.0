From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 01/14] don't output value of anonymous symbol's pointer
Date: Sat, 25 Mar 2017 00:14:08 +0100
Message-ID: <20170324231421.14869-2-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34145 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbdCXXOb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id u132so786431wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:29 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
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
index 5199b6b02..686cb9deb 100644
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
@@ -326,7 +326,7 @@ const char *show_instruction(struct instruction *insn)
 			buf += sprintf(buf, "%s", show_ident(sym->ident));
 			break;
 		}
-		buf += sprintf(buf, "<anon symbol:%p>", sym);
+		buf += sprintf(buf, "<anon symbol:%p>", verbose ? sym : NULL);
 		break;
 	}
 		
-- 
2.12.0

