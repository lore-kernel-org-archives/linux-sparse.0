From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add missing braces around FOR_EACH_PTR loop
Date: Fri, 17 Feb 2017 01:23:32 +0100
Message-ID: <20170217002332.12245-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34890 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdBQAZk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Feb 2017 19:25:40 -0500
Received: by mail-wr0-f194.google.com with SMTP id q39so3745226wrb.2
        for <linux-sparse@vger.kernel.org>; Thu, 16 Feb 2017 16:25:40 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Oleg Nesterov <oleg@redhat.com>

Stricto sensu, these braces are not needed but are used
everywhere else around FOR_EACH_PTR and friends loops.
Their lack can also bite you when doing experiments with
the ptrlist macros ...

CC: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 dissect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 67428ec64..5f067eb4c 100644
--- a/dissect.c
+++ b/dissect.c
@@ -541,7 +541,7 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 
 	break; case EXPR_INITIALIZER:
 		m_addr = 0;
-		FOR_EACH_PTR(expr->expr_list, m_expr)
+		FOR_EACH_PTR(expr->expr_list, m_expr) {
 			if (type->type == SYM_ARRAY) {
 				m_type = base_type(type);
 				if (m_expr->type == EXPR_INDEX)
@@ -567,7 +567,7 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 			}
 			do_initializer(m_type, m_expr);
 			m_addr++;
-		END_FOR_EACH_PTR(m_expr);
+		} END_FOR_EACH_PTR(m_expr);
 	}
 
 	return type;
-- 
2.11.0

