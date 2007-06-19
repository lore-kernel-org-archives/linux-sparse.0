From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Tue, 19 Jun 2007 23:33:17 +0100
Message-ID: <20070619223317.GO21478@ftp.linux.org.uk>
References: <20070619171236.GA5751@martell.zuzino.mipt.ru> <20070619172143.GM21478@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:50991 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158AbXFSWdS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Jun 2007 18:33:18 -0400
Content-Disposition: inline
In-Reply-To: <20070619172143.GM21478@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue, Jun 19, 2007 at 06:21:43PM +0100, Al Viro wrote:
> Gaack...  The fix is obvious (add e && into that condition and into
> e->type == EXPR_STRING a couple of lines below), but...  I wonder
> if adding EXPR_BAD and using it to deal with such crap in parser
> would be better.  Comments?

Anyway, brute-force patch follows.  I still suspect that long-term
we will be better off with explicit EXPR_BAD nodes and guaranteed
things like "->unop of EXPR_PREOP is never NULL", but that can be
done separately - a lot of checks for NULL will be possible to remove.

diff --git a/evaluate.c b/evaluate.c
--- a/evaluate.c
+++ b/evaluate.c
@@ -2029,6 +2029,10 @@ static struct expression *check_designators(struct expression *e,
 			e->ctype = ctype = type;
 			ctype = type;
 			last = e;
+			if (!e->idx_expression) {
+				err = "invalid";
+				break;
+			}
 			e = e->idx_expression;
 		} else if (e->type == EXPR_IDENTIFIER) {
 			if (ctype->type != SYM_STRUCT && ctype->type != SYM_UNION) {
@@ -2042,6 +2046,10 @@ static struct expression *check_designators(struct expression *e,
 			}
 			e->field = e->ctype = ctype;
 			last = e;
+			if (!e->ident_expression) {
+				err = "invalid";
+				break;
+			}
 			e = e->ident_expression;
 		} else if (e->type == EXPR_POS) {
 			err = "internal front-end error: EXPR_POS in";
@@ -2203,9 +2211,9 @@ found:
 static int is_string_literal(struct expression **v)
 {
 	struct expression *e = *v;
-	while (e->type == EXPR_PREOP && e->op == '(')
+	while (e && e->type == EXPR_PREOP && e->op == '(')
 		e = e->unop;
-	if (e->type != EXPR_STRING)
+	if (!e || e->type != EXPR_STRING)
 		return 0;
 	if (e != *v && Wparen_string)
 		warning(e->pos,
@@ -2274,6 +2282,9 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 	struct expression *e = *ep, *p;
 	struct symbol *type;
 
+	if (!e)
+		return 0;
+
 	/* scalar */
 	if (!(class & TYPE_COMPOUND)) {
 		e = handle_scalar(e, nested);
