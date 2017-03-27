From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 29/52] llvm: make pseudo_name() more flexible
Date: Mon, 27 Mar 2017 23:23:53 +0200
Message-ID: <20170327212416.18536-30-luc.vanoostenryck@gmail.com>
References: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36721 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751629AbdC0V0y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 17:26:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id u1so17117710wra.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 14:26:53 -0700 (PDT)
In-Reply-To: <20170327212416.18536-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 sparse-llvm.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/sparse-llvm.c b/sparse-llvm.c
index 31411d9d1..4e4fb2ea5 100644
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

