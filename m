From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 02/25] constexpr: init flags at expression allocation
Date: Fri, 31 Mar 2017 03:44:36 +0200
Message-ID: <20170331014459.9351-3-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34158 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934742AbdCaBqb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so16582540wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:30 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Currently, the expression evaluation code explicitly opts out from
constness at evaluation if certain criteria regarding the subexpressions
are not matched.

Instead of this active opt-out, we want to have subexpression constness
attributes to get propagated from child expressions to their parents in
the future.

A prerequisite is that each expression's ->flags is in a defined
state at all times.

Set ->flags to SET_INT or NONE at expression allocation time,
depending if the expression has a type or not
(alloc_const_expression() or alloc_expression()).

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/expression.h b/expression.h
index e02cb8584..ec94ff4a1 100644
--- a/expression.h
+++ b/expression.h
@@ -249,6 +249,7 @@ static inline struct expression *alloc_expression(struct position pos, int type)
 	struct expression *expr = __alloc_expression(0);
 	expr->type = type;
 	expr->pos = pos;
+	expr->flags = CEF_NONE;
 	return expr;
 }
 
@@ -259,6 +260,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
 	expr->pos = pos;
 	expr->value = value;
 	expr->ctype = &int_ctype;
+	expr->flags = CEF_SET_INT;
 	return expr;
 }
 
-- 
2.12.0

