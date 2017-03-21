From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 41/63] llvm: make pseudo_name() more flexible
Date: Tue, 21 Mar 2017 01:15:45 +0100
Message-ID: <20170321001607.75169-42-luc.vanoostenryck@gmail.com>
References: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34408 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbdCUARF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Mar 2017 20:17:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id u48so20450003wrc.1
        for <linux-sparse@vger.kernel.org>; Mon, 20 Mar 2017 17:17:04 -0700 (PDT)
In-Reply-To: <20170321001607.75169-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index a64125fe8..bf76bbe77 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -270,31 +270,26 @@ static LLVMLinkage function_linkage(struct symbol *sym)
 
 #define MAX_PSEUDO_NAME 64
 
-static void pseudo_name(pseudo_t pseudo, char *buf)
+static const char *pseudo_name(pseudo_t pseudo, char *buf)
 {
 	switch (pseudo->type) {
 	case PSEUDO_REG:
 		snprintf(buf, MAX_PSEUDO_NAME, "R%d", pseudo->nr);
 		break;
-	case PSEUDO_SYM:
-		assert(0);
-		break;
-	case PSEUDO_VAL:
-		assert(0);
-		break;
-	case PSEUDO_ARG: {
-		assert(0);
-		break;
-	}
 	case PSEUDO_PHI:
 		snprintf(buf, MAX_PSEUDO_NAME, "PHI%d", pseudo->nr);
 		break;
+	case PSEUDO_SYM:
+	case PSEUDO_VAL:
+	case PSEUDO_ARG:
 	case PSEUDO_VOID:
 		buf[0] = '\0';
 		break;
 	default:
 		assert(0);
 	}
+
+	return buf;
 }
 
 static LLVMValueRef get_sym_value(struct function *fn, struct symbol *sym)
-- 
2.12.0

