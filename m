From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/8] do not report bad types twice
Date: Fri,  2 Feb 2018 13:17:34 +0100
Message-ID: <20180202121735.39621-8-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34184 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeBBMTy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21-v6so2317102wmh.1
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:53 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The type 'bad_ctype' is only used after an error has been detected.
Since this error has also been reported, there is no reasons
to issue more errors when a 'bad_ctype' is involved. This allow
to focus on the root cause of the error.

Fix this by checking in bad_expr_type() if one of the operands
is already a 'bad_ctype' and do not issue an diagnostic message
in this case.

Note: the kernel has a bunch of these situations where the
      exact same warning is given several times in a row,
      sometimes as much as a dozen time.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   | 7 ++++++-
 validation/bad-type-twice2.c | 1 -
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 14922017b..f63c0344d 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -404,15 +404,20 @@ static inline int is_string_type(struct symbol *type)
 
 static struct symbol *bad_expr_type(struct expression *expr)
 {
-	sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 	switch (expr->type) {
 	case EXPR_BINOP:
 	case EXPR_COMPARE:
+		if (!valid_subexpr_type(expr))
+			break;
+		sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 		info(expr->pos, "   left side has type %s", show_typename(expr->left->ctype));
 		info(expr->pos, "   right side has type %s", show_typename(expr->right->ctype));
 		break;
 	case EXPR_PREOP:
 	case EXPR_POSTOP:
+		if (!valid_expr_type(expr->unop))
+			break;
+		sparse_error(expr->pos, "incompatible types for operation (%s)", show_special(expr->op));
 		info(expr->pos, "   argument has type %s", show_typename(expr->unop->ctype));
 		break;
 	default:
diff --git a/validation/bad-type-twice2.c b/validation/bad-type-twice2.c
index 916e82028..0aadd7a30 100644
--- a/validation/bad-type-twice2.c
+++ b/validation/bad-type-twice2.c
@@ -7,7 +7,6 @@ int foo(int x, int y)
 
 /*
  * check-name: bad-type-twice2
- * check-known-to-fail
  *
  * check-error-start
 bad-type-twice2.c:1:8: warning: 'type_t' has implicit type
-- 
2.16.0

