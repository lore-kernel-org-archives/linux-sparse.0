From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 08/21] expression, evaluate: add support for tagging address constants
Date: Mon, 01 Feb 2016 03:36:18 +0100
Message-ID: <87mvrli2cd.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32773 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbcBACgV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:36:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id r129so7031880wmr.0
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:36:21 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Address constants [6.6(9)] constitute one of the types of constant
expressions allowed in initializers [6.6(7)] for static storage
duration objects [6.7.8(4)].

Introduce a new flag CONSTEXPR_ADDR_CONSTANT for tagging expressions
which qualify as being an address constant.

Make sure not to carry over the address constant attribute from
subexpressions for operators that never yield address constants, i.e.
most arithmetic ones, logical ones etc.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c   | 27 ++++++++++++++++++++++-----
 expression.h |  2 ++
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 03db2c3..dd44cd5 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -880,7 +880,8 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	expr->ctype = &int_ctype;
 	expr->constexpr_flags = expr->left->constexpr_flags &
 		expr->right->constexpr_flags &
-		~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+		~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+		~CONSTEXPR_FLAG_ADDR_CONST;
 	return &int_ctype;
 }
 
@@ -999,7 +1000,8 @@ static struct symbol *evaluate_compare(struct expression *expr)
 	const char *typediff;
 
 	expr->constexpr_flags = left->constexpr_flags &
-		right->constexpr_flags & ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+		right->constexpr_flags & ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+		~CONSTEXPR_FLAG_ADDR_CONST;
 
 	/* Type types? */
 	if (is_type_type(ltype) && is_type_type(rtype))
@@ -1115,10 +1117,15 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 		true = &expr->cond_true;
 	}
 
+	/*
+	 * A conditional operator never yields an address constant
+	 * [6.6(9)].
+	 */
 	expr->constexpr_flags = (expr->conditional->constexpr_flags &
 				(*true)->constexpr_flags &
 				expr->cond_false->constexpr_flags &
-				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK);
+				~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+				~CONSTEXPR_FLAG_ADDR_CONST);
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -1850,8 +1857,13 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
+		/*
+		 * A logical negation never yields an address constant
+		 * [6.6(9)].
+		 */
 		expr->constexpr_flags = expr->unop->constexpr_flags &
-			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+			~CONSTEXPR_FLAG_ADDR_CONST;
 		if (is_safe_type(ctype))
 			warning(expr->pos, "testing a 'safe expression'");
 		if (is_float_type(ctype)) {
@@ -2731,8 +2743,13 @@ static struct symbol *evaluate_cast(struct expression *expr)
 	class1 = classify_type(ctype, &t1);
 
 	if (class1 & TYPE_NUM) {
+		/*
+		 * Casts to numeric types never result in address
+		 * constants [6.6(9)].
+		 */
 		expr->constexpr_flags = target->constexpr_flags &
-			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;
+			~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+			~CONSTEXPR_FLAG_ADDR_CONST;
 		/*
 		 * Cast to float type -> not an integer constant
 		 * expression [6.6(6)].
diff --git a/expression.h b/expression.h
index b85f1b1..285c18c 100644
--- a/expression.h
+++ b/expression.h
@@ -97,9 +97,11 @@ enum constexpr_flag {
 	 * A constant expression in the sense of [6.6]:
 	 * - integer constant expression [6.6(6)]
 	 * - arithmetic constant expression [6.6(8)]
+	 * - address constant [6.6(9)]
 	 */
 	CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),
 	CONSTEXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
+	CONSTEXPR_FLAG_ADDR_CONST = (1 << 6),
 };
 
 /* integer constant expression => arithmetic constant expression */
-- 
2.7.0

