From: Phil Carmody <phil@dovecot.fi>
Subject: [PATCHv2 2/3] sparse: detect non-sign-extended masks created by '~'
Date: Tue, 10 Jun 2014 10:54:06 +0300
Message-ID: <1402386847-23477-3-git-send-email-phil@dovecot.fi>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-2-git-send-email-phil@dovecot.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:39521 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933692AbaFJHx7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Jun 2014 03:53:59 -0400
In-Reply-To: <1402386847-23477-2-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org, phil@dovecot.fi

Consider the operation of rounding up to the nearest multiple of a power of 2.
e.g.  #define ALLOC_SIZE(t) ((sizeof(t) + ASIZE - 1) & ~(ASIZE - 1))

If ASIZE is unfortunately defined as an unsigned type smaller than size_t,
then the ~ will not undergo sign-bit extension, and an incorrect mask will
be used. If used in a memory allocation context this could be fatal.

Warn about such dubious 'large op ~short' usage.

v2: pulled noisy repeated parts into a helper

Signed-off-by: Phil Carmody <phil@dovecot.fi>
---
 evaluate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/evaluate.c b/evaluate.c
index 9052962..a16aa45 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -886,6 +886,25 @@ static struct symbol *evaluate_logical(struct expression *expr)
 	return &int_ctype;
 }
 
+static int int_size_cmp(struct symbol *left, struct symbol *right)
+{
+	left = integer_promotion(left);
+	right = integer_promotion(right);
+
+	return (left->bit_size > right->bit_size) ? 1 :
+		(right->bit_size > left->bit_size) ? -1 : 0;
+}
+
+static void check_masking(struct expression *expr, int op, int is_l,
+			  struct expression *sexpr, struct symbol *stype)
+{
+	if ((sexpr->type == EXPR_PREOP)
+	    && (sexpr->op == '~')
+	    && (stype->ctype.modifiers & MOD_UNSIGNED))
+		warning(expr->pos, "dubious zero-extended '~': %sx %c %sy",
+			"~"+!is_l, op, "~"+!!is_l);
+}
+
 static struct symbol *evaluate_binop(struct expression *expr)
 {
 	struct symbol *ltype, *rtype, *ctype;
@@ -917,6 +936,7 @@ static struct symbol *evaluate_binop(struct expression *expr)
 			rtype = integer_promotion(rtype);
 		} else {
 			// The rest do usual conversions
+			int size_cmp;
 			int left_not  = expr->left->type == EXPR_PREOP
 					&& expr->left->op == '!';
 			int right_not = expr->right->type == EXPR_PREOP
@@ -927,6 +947,12 @@ static struct symbol *evaluate_binop(struct expression *expr)
 					op,
 					right_not ? "!" : "");
 
+			size_cmp = int_size_cmp(ltype, rtype);
+			if (size_cmp > 0)
+				check_masking(expr, op, 0, expr->right, rtype);
+			else if (size_cmp < 0)
+				check_masking(expr, op, 1, expr->left, ltype);
+
 			ltype = usual_conversions(op, expr->left, expr->right,
 						  lclass, rclass, ltype, rtype);
 			ctype = rtype = ltype;
-- 
2.0.0

