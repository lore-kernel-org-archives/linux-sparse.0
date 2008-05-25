From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: [PATCH] Set *tree to NULL on error
Date: Sun, 25 May 2008 10:35:00 +0200
Message-ID: <20080525083500.GA4158@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:41086 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbYEYIfH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 May 2008 04:35:07 -0400
Received: by nf-out-0910.google.com with SMTP id d3so683176nfc.21
        for <linux-sparse@vger.kernel.org>; Sun, 25 May 2008 01:35:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Vegard Nossum <vegardno@ifi.uio.no>
Date: Sun, 25 May 2008 10:29:19 +0200
Subject: [PATCH] Set *tree to NULL on error

On "Syntax error in unary expression", the output parameter "tree" would be left
uninitialized and subsequently used in unary_expression(), leading to segfault.

Caught by valgrind and fixed by me ;-)

Signed-off-by: Vegard Nossum <vegardno@ifi.uio.no>
---
 expression.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/expression.c b/expression.c
index 289927a..f634b07 100644
--- a/expression.c
+++ b/expression.c
@@ -654,6 +654,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			next = cast_expression(token->next, &unop);
 			if (!unop) {
 				sparse_error(token->pos, "Syntax error in unary expression");
+				*tree = NULL;
 				return next;
 			}
 			unary = alloc_expression(token->pos, EXPR_PREOP);
@@ -671,6 +672,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 			next = cast_expression(token->next, &unop);
 			if (!unop) {
 				sparse_error(token->pos, "Syntax error in unary expression");
+				*tree = NULL;
 				return next;
 			}
 			unary = alloc_expression(token->pos, EXPR_PREOP);
-- 
1.5.4.1

