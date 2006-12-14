From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: [PATCH] dissect: fix multidimensional array initializer
Date: Fri, 15 Dec 2006 00:35:47 +0300
Message-ID: <20061214213547.GA422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.sgg.ru ([217.23.135.1]:41627 "EHLO mail.sgg.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbWLNXkk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 14 Dec 2006 18:40:40 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

dissect can't parse initializers like

	struct T { int i; } a[2][3] = { [0][0] = {123} };

, output is:

	   1:8   s def  T
	   1:21  g def  a                                struct T [3][2]
	   1:21  g -w-  a                                struct T [3][2]
	T.c:1:37: warning: bad expr->type: 25

with this patch applied:

	   1:8   s def  T
	   1:21  g def  a                                struct T [3][2]
	   1:21  g -w-  a                                struct T [3][2]
	   1:43  s -w-  T.i                              int

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- DS/dissect.c~	2006-04-20 03:03:33.000000000 +0400
+++ DS/dissect.c	2006-04-20 03:03:42.000000000 +0400
@@ -507,10 +507,13 @@ static struct symbol *do_initializer(str
 	default:
 		do_expression(u_lval(type), expr);
 
+	break; case EXPR_INDEX:
+		do_initializer(base_type(type), expr->idx_expression);
+
 	break; case EXPR_INITIALIZER:
 		m_addr = 0;
 		FOR_EACH_PTR(expr->expr_list, m_expr)
-			if(type->type == SYM_ARRAY) {
+			if (type->type == SYM_ARRAY) {
 				m_type = base_type(type);
 				if (m_expr->type == EXPR_INDEX)
 					m_expr = m_expr->idx_expression;
