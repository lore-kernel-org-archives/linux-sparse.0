From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 29/51] llvm: make pseudo_name() more flexible
Date: Sat, 25 Mar 2017 00:20:35 +0100
Message-ID: <20170324232057.15033-30-luc.vanoostenryck@gmail.com>
References: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935856AbdCXXXz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:23:55 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so808840wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:23:54 -0700 (PDT)
In-Reply-To: <20170324232057.15033-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

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

