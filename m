From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 13/16] in case of compound literal we want to delay examining type
Date: Sun, 24 Jun 2007 09:05:21 +0100
Message-ID: <E1I2N61-0003eW-7e@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34708 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbXFXIFW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:05:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N61-0003eW-7e
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:05:21 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


... until we have initializer.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 60a11ff..e3b4940 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2433,7 +2433,7 @@ out:
 static struct symbol *evaluate_cast(struct expression *expr)
 {
 	struct expression *target = expr->cast_expression;
-	struct symbol *ctype = examine_symbol_type(expr->cast_type);
+	struct symbol *ctype;
 	struct symbol *t1, *t2;
 	int class1, class2;
 	int as1, as2;
@@ -2441,9 +2441,6 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	if (!target)
 		return NULL;
 
-	expr->ctype = ctype;
-	expr->cast_type = ctype;
-
 	/*
 	 * Special case: a cast can be followed by an
 	 * initializer, in which case we need to pass
@@ -2458,7 +2455,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		struct symbol *sym = expr->cast_type;
 		struct expression *addr = alloc_expression(expr->pos, EXPR_SYMBOL);
 
-		sym->initializer = expr->cast_expression;
+		sym->initializer = target;
 		evaluate_symbol(sym);
 
 		addr->ctype = &lazy_ptr_ctype;	/* Lazy eval */
@@ -2472,6 +2469,10 @@ static struct symbol *evaluate_cast(struct expression *expr)
 		return sym;
 	}
 
+	ctype = examine_symbol_type(expr->cast_type);
+	expr->ctype = ctype;
+	expr->cast_type = ctype;
+
 	evaluate_expression(target);
 	degenerate(target);
 
-- 
1.5.0-rc2.GIT
