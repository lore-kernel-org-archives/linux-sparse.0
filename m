From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: kill return_type
Date: Fri, 7 Feb 2020 11:32:13 +0100
Message-ID: <20200207103213.GA17010@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726890AbgBGKcS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Feb 2020 05:32:18 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Now that we have dissect_ctx do_statement(STMT_RETURN) can use
base_type(dissect_ctx->ctype.base_type) instead.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/dissect.c b/dissect.c
index b48cd85..85489a2 100644
--- a/dissect.c
+++ b/dissect.c
@@ -54,7 +54,6 @@ typedef unsigned usage_t;
 struct symbol *dissect_ctx;
 
 static struct reporter *reporter;
-static struct symbol *return_type;
 
 static void do_sym_list(struct symbol_list *list);
 
@@ -489,8 +488,10 @@ static struct symbol *do_statement(usage_t mode, struct statement *stmt)
 	break; case STMT_EXPRESSION:
 		ret = do_expression(mode, stmt->expression);
 
-	break; case STMT_RETURN:
-		do_expression(u_lval(return_type), stmt->expression);
+	break; case STMT_RETURN: {
+		struct symbol *type = dissect_ctx->ctype.base_type;
+		do_expression(u_lval(base_type(type)), stmt->expression);
+	}
 
 	break; case STMT_ASM:
 		do_expression(U_R_VAL, stmt->asm_string);
@@ -617,11 +618,9 @@ static inline struct symbol *do_symbol(struct symbol *sym)
 				show_ident(sym->ident));
 
 		dissect_ctx = sym;
-		return_type = base_type(type);
 		do_sym_list(type->arguments);
 		do_statement(U_VOID, stmt);
 		dissect_ctx = dctx;
-		return_type = NULL;
 	}
 
 	return type;
-- 
2.5.0
