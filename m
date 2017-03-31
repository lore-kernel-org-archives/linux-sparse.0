From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 20/25] constexpr: relax some constant expression rules for pointer expressions
Date: Fri, 31 Mar 2017 03:44:54 +0200
Message-ID: <20170331014459.9351-21-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33361 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbdCaBqs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:48 -0400
Received: by mail-wr0-f196.google.com with SMTP id u18so16611762wrc.0
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:47 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

The official constraints on constant expressions [6.6] are insanely
strict in that they do not allow some constructs commonly used in the
wild.

Relax them by treating
- address constants cast to different pointer type as address constants
  again,
- address constants cast to arithmetic type as arithmetic constant
  expressions
- conditional expressions whose true and false branches both yield
  address constants as address constants,
- and conditional expressions whose condition is an address constant
  as an constant expression to the extent their true and false branches
  allow.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index be72b22b9..022c7b5f3 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1136,10 +1136,20 @@ static struct symbol *evaluate_conditional_expression(struct expression *expr)
 	expr->flags = (expr->conditional->flags & (*true)->flags &
 			expr->cond_false->flags & ~CEF_CONST_MASK);
 	/*
+	 * A conditional operator yields a particular constant
+	 * expression type only if all of its three subexpressions are
+	 * of that type [6.6(6), 6.6(8)].
+	 * As an extension, relax this restriction by allowing any
+	 * constant expression type for the condition expression.
+	 *
 	 * A conditional operator never yields an address constant
 	 * [6.6(9)].
+	 * However, as an extension, if the condition is any constant
+	 * expression, and the true and false expressions are both
+	 * address constants, mark the result as an address constant.
 	 */
-	expr->flags &= ~CEF_ADDR;
+	if (expr->conditional->flags & (CEF_ACE | CEF_ADDR))
+		expr->flags = (*true)->flags & expr->cond_false->flags & ~CEF_CONST_MASK;
 
 	lclass = classify_type(ltype, &ltype);
 	rclass = classify_type(rtype, &rtype);
@@ -2762,6 +2772,14 @@ static int cast_flags(struct expression *expr, struct expression *old)
 		 * constants [6.6(9)].
 		 */
 		flags &= ~CEF_ADDR;
+
+		/*
+		 * As an extension, treat address constants cast to
+		 * integer type as an arithmetic constant.
+		 */
+		if (old->flags & CEF_ADDR)
+			flags = CEF_ACE;
+
 		/*
 		 * Cast to float type -> not an integer constant
 		 * expression [6.6(6)].
@@ -2778,8 +2796,15 @@ static int cast_flags(struct expression *expr, struct expression *old)
 		/*
 		 * Casts of integer literals to pointer type yield
 		 * address constants [6.6(9)].
+		 *
+		 * As an extension, treat address constants cast to a
+		 * different pointer type as address constants again.
+		 *
+		 * As another extension, treat integer constant
+		 * expressions (in contrast to literals) cast to
+		 * pointer type as address constants.
 		 */
-		if (old->flags & CEF_INT)
+		if (old->flags & (CEF_ICE | CEF_ADDR))
 			flags = CEF_ADDR;
 	}
 
-- 
2.12.0

