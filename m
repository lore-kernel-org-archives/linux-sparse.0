From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 08/25] constexpr: add support for tagging address constants
Date: Fri, 31 Mar 2017 03:44:42 +0200
Message-ID: <20170331014459.9351-9-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36001 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934785AbdCaBqh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:37 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6so15309732wre.3
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:36 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Address constants [6.6(9)] constitute one of the types of constant
expressions allowed in initializers [6.6(7)] for static storage
duration objects [6.7.8(4)].

Introduce a new flag for tagging expressions which qualify as
being an address constant.

Make sure not to carry over the address constant attribute from
subexpressions for operators that never yield address constants,
i.e.  most arithmetic ones, logical ones etc.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c   | 19 ++++++++++++++++++-
 expression.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 6d6e462cd..68a2d5ebf 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -890,7 +890,7 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	/* the result is int [6.5.13(3), 6.5.14(3)] */
 	expr->ctype = &int_ctype;
 	expr->flags = expr->left->flags & expr->right->flags;
-	expr->flags &= ~CEF_CONST_MASK;
+	expr->flags &= ~(CEF_CONST_MASK | CEF_ADDR);
 	return &int_ctype;
 }
 
@@ -1007,6 +1007,7 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	const char *typediff;
 
 	expr->flags = left->flags & right->flags & ~CEF_CONST_MASK;
+	expr->flags &= ~CEF_ADDR;
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
@@ -1124,6 +1125,11 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 
 	expr->flags = (expr->conditional->flags & (*true)->flags &
 			expr->cond_false->flags & ~CEF_CONST_MASK);
+	/*
+	 * A conditional operator never yields an address constant
+	 * [6.6(9)].
+	 */
+	expr->flags &= ~CEF_ADDR;
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -1858,6 +1864,12 @@ static struct symbol *evaluate_preop(struct expression *expr)
 
 	case '!':
 		expr->flags = expr->unop->flags & ~CEF_CONST_MASK;
+		/*
+		 * A logical negation never yields an address constant
+		 * [6.6(9)].
+		 */
+		expr->flags &= ~CEF_ADDR;
+
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
@@ -2719,6 +2731,11 @@ static int cast_flags(struct expression *expr, struct expression *old)
 	class = classify_type(expr->ctype, &t);
 	if (class & TYPE_NUM) {
 		flags = old->flags & ~CEF_CONST_MASK;
+		/*
+		 * Casts to numeric types never result in address
+		 * constants [6.6(9)].
+		 */
+		flags &= ~CEF_ADDR;
 		/*
 		 * Cast to float type -> not an integer constant
 		 * expression [6.6(6)].
diff --git a/expression.h b/expression.h
index 67b6a83e3..960f16005 100644
--- a/expression.h
+++ b/expression.h
@@ -97,9 +97,11 @@ enum constexpr_flag {
 	 * A constant expression in the sense of [6.6]:
 	 * - integer constant expression [6.6(6)]
 	 * - arithmetic constant expression [6.6(8)]
+	 * - address constant [6.6(9)]
 	 */
 	CEF_ICE = (1 << 4),
 	CEF_ACE = (1 << 5),
+	CEF_ADDR = (1 << 6),
 
 	/* integer constant expression => arithmetic constant expression */
 	CEF_SET_ICE = (CEF_ICE | CEF_ACE),
-- 
2.12.0

