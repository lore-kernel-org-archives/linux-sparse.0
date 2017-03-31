From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 24/25] give default return type in evaluate_call()
Date: Fri, 31 Mar 2017 03:44:58 +0200
Message-ID: <20170331014459.9351-25-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33390 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934699AbdCaBqw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so16611953wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:51 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 0cec215ba..df6fd5adc 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -3030,11 +3030,11 @@ static struct symbol *evaluate_call(struct expression *expr)
 				     "too many arguments for function %s",
 				     show_ident(sym->ident));
 	}
+	expr->ctype = ctype->ctype.base_type;
 	if (sym->type == SYM_NODE) {
 		if (evaluate_symbol_call(expr))
 			return expr->ctype;
 	}
-	expr->ctype = ctype->ctype.base_type;
 	return expr->ctype;
 }
 
-- 
2.12.0

