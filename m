From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 07/21] expression: add support for tagging arithmetic constant expressions
Date: Mon, 01 Feb 2016 03:35:27 +0100
Message-ID: <87r3gxi2ds.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35934 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbcBACf3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:35:29 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so7017327wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:35:29 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Arithmetic constant expressions may be either of (6.6(8)):
- integer constant expressions
- floating point constants
or any arithmetic expression build up from them.
Furthermore, casts with arithmetic destination types preserve arithmetic
constness.

Arithmetic constant expressions may be used as initializers for objects of
static storage duration.

Introduce a new constexpr_flag CONSTEXPR_FLAG_ARITH_CONST_EXPR.

Modify CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK and
CONSTEXPR_FLAG_FP_CONST_SET_MASK to also include that new bit.
Thus, whenever an integer constant expression or a floating point constant
is recognized, it is automatically tagged as an arithmetic constant
expression.

Note that everything has already been set up such that the new
CONSTEXPR_FLAG_ARITH_CONST_EXPR flag propagates nicely from subexpressions
to parent expressions at evaluation.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 expression.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/expression.h b/expression.h
index 408382e..b85f1b1 100644
--- a/expression.h
+++ b/expression.h
@@ -96,19 +96,23 @@ enum constexpr_flag {
 	/*
 	 * A constant expression in the sense of [6.6]:
 	 * - integer constant expression [6.6(6)]
+	 * - arithmetic constant expression [6.6(8)]
 	 */
 	CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),
+	CONSTEXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
 };
 
-#define CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK	\
-	(CONSTEXPR_FLAG_INT_CONST_EXPR)
+/* integer constant expression => arithmetic constant expression */
+#define CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK				\
+	(CONSTEXPR_FLAG_INT_CONST_EXPR | CONSTEXPR_FLAG_ARITH_CONST_EXPR)
 
 /* integer constant => integer constant expression */
 #define CONSTEXPR_FLAG_INT_CONST_SET_MASK			\
 	(CONSTEXPR_FLAG_INT_CONST | CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK)
 
-#define CONSTEXPR_FLAG_FP_CONST_SET_MASK	\
-	(CONSTEXPR_FLAG_FP_CONST)
+/* floating point constant => arithmetic constant expression */
+#define CONSTEXPR_FLAG_FP_CONST_SET_MASK				\
+	(CONSTEXPR_FLAG_FP_CONST | CONSTEXPR_FLAG_ARITH_CONST_EXPR)
 
 /* enumeration constant => integer constant expression */
 #define CONSTEXPR_FLAG_ENUM_CONST_SET_MASK				\
-- 
2.7.0

