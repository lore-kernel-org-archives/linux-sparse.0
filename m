From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] do not report bad types twice or more
Date: Tue, 19 Sep 2017 04:13:34 +0200
Message-ID: <20170919021335.5881-5-luc.vanoostenryck@gmail.com>
References: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38810 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdISCNp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 22:13:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id x17so2472747wmd.5
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 19:13:44 -0700 (PDT)
In-Reply-To: <20170919021335.5881-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The type 'bad_ctype' is only used after an error has been detected.
Since this error has also been reported, there is no reasons
to issue more errors when a 'bad_ctype' is involved. This allow
to focus on the root cause of the error.

Fix this by checking in bad_expr_type() if one of the operands
is already a 'bad_ctype' and do not issue an diagnostic message
in this case.

Note: the kernel has a bunch of these situation where sometimes
      the exact same warning is given several times in a row,
      sometimes as much as a dozen time.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 0394dcbb9..c16ee9624 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -400,15 +400,20 @@ static inline int is_string_type(struct symbol *type)
 
 static struct symbol *bad_expr_type(struct expression *expr)
 {
-	sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 	switch (expr->type) {
 	case EXPR_BINOP:
 	case EXPR_COMPARE:
+		if (!valid_expr_subtype(expr))
+			break;
+		sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 		info(expr->pos, "   left side has type %s", show_typename(expr->left->ctype));
 		info(expr->pos, "   right side has type %s", show_typename(expr->right->ctype));
 		break;
 	case EXPR_PREOP:
 	case EXPR_POSTOP:
+		if (!valid_type(expr->unop->ctype))
+			break;
+		sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 		info(expr->pos, "   argument has type %s", show_typename(expr->unop->ctype));
 		break;
 	default:
@@ -887,6 +892,8 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 			if (Waddress)
 				warning(expr->pos, "the address of %s will always evaluate as true", "an array");
 		} else if (!is_scalar_type(ctype)) {
+			if (!valid_type(ctype))
+				return NULL;
 			sparse_error(expr->pos, "incorrect type in conditional");
 			info(expr->pos, "   got %s", show_typename(ctype));
 			ctype = NULL;
-- 
2.14.0

