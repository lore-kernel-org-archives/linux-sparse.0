From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/16] missing NULL checks in initializer handling
Date: Sun, 24 Jun 2007 09:03:21 +0100
Message-ID: <E1I2N45-0003be-5J@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34681 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbXFXIDW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 24 Jun 2007 04:03:22 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I2N45-0003be-5J
	for linux-sparse@vger.kernel.org; Sun, 24 Jun 2007 09:03:21 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 evaluate.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index b0c67a1..bf923f7 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2039,6 +2039,10 @@ static struct expression *check_designators(struct expression *e,
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
@@ -2052,6 +2056,10 @@ static struct expression *check_designators(struct expression *e,
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
@@ -2213,9 +2221,9 @@ found:
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
@@ -2284,6 +2292,9 @@ static int handle_simple_initializer(struct expression **ep, int nested,
 	struct expression *e = *ep, *p;
 	struct symbol *type;
 
+	if (!e)
+		return 0;
+
 	/* scalar */
 	if (!(class & TYPE_COMPOUND)) {
 		e = handle_scalar(e, nested);
-- 
1.5.0-rc2.GIT
