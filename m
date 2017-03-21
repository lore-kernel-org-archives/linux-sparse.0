From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 01/63] only output internal pointer value when verbose is set
Date: Tue, 21 Mar 2017 01:15:05 +0100
Message-ID: <20170321001607.75169-2-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33234 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753724AbdCUAQW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:16:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id g10so20440781wrg.0
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:16:20 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

