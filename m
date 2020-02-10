From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/2] dissect: enforce sym->kind='f' when it looks like a
 function call
Date: Mon, 10 Feb 2020 17:20:38 +0100
Message-ID: <20200210162038.GA29643@redhat.com>
References: <20200210162018.GA29634@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727722AbgBJQUq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 10 Feb 2020 11:20:46 -0500
In-Reply-To: <20200210162018.GA29634@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

A separate change for documentation purposes.

dissect() tries to work even if the parsed code is buggy or incomplete,
thus it makes sense to change expr_symbol() to set kind = 'f' when it
likely looks like a function name.

We can safely abuse EXPR_SYMBOL->op to pass the hint to expr_symbol(),
it must be 0.

Test-case:

	void call(void)
	{
		func();
	}

before this patch

	1:14                   def f call                             void ( ... )
	3:17  call             --r v func                             bad type

after:

	1:14                   def f call                             void ( ... )
	3:17  call             --r f func                             bad type

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      | 4 +++-
 test-dissect.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/dissect.c b/dissect.c
index 20456b2..d9ca142 100644
--- a/dissect.c
+++ b/dissect.c
@@ -166,7 +166,7 @@ static inline struct symbol *expr_symbol(struct expression *expr)
 			sym = alloc_symbol(expr->pos, SYM_BAD);
 			bind_symbol(sym, expr->symbol_name, NS_SYMBOL);
 			sym->ctype.modifiers = MOD_EXTERN;
-			sym->kind = 'v';
+			sym->kind = expr->op ?: 'v'; /* see EXPR_CALL */
 		}
 	}
 
@@ -374,6 +374,8 @@ again:
 		ret = do_expression(mode, expr->cond_false);
 
 	break; case EXPR_CALL:
+		if (expr->fn->type == EXPR_SYMBOL)
+			expr->fn->op = 'f'; /* for expr_symbol() */
 		ret = do_expression(U_R_PTR, expr->fn);
 		if (is_ptr(ret))
 			ret = ret->ctype.base_type;
diff --git a/test-dissect.c b/test-dissect.c
index 81cc89d..ece2253 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -55,7 +55,7 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 		goto err;
 
 	case 'f':
-		if (sym->ctype.base_type->type != SYM_FN)
+		if (sym->type != SYM_BAD && sym->ctype.base_type->type != SYM_FN)
 			goto err;
 	case 'v':
 		if (sym->type == SYM_NODE || sym->type == SYM_BAD)
-- 
2.5.0
