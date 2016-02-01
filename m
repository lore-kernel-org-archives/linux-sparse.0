From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 02/21] expression: init constexpr_flags at expression allocation
Date: Mon, 01 Feb 2016 03:30:49 +0100
Message-ID: <87d1shjh5y.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36017 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbcBACaw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:30:52 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so7006454wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:30:51 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Currently, the expression evaluation code explicitly opts out from
constness at evaluation if certain criteria regarding the subexpressions
are not matched.

Instead of this active opt-out, we want to have subexpression constness
attributes to get propagated from child expressions to their parents in
the future.

A prerequisite is that each expression's ->constexpr_flags is in a defined
state at all times.

Set ->constexpr_flags to CONSTEXPR_FLAG_NONE at expression allocation time,
i.e. in alloc_expression() as well as in alloc_const_expression().

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 expression.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/expression.h b/expression.h
index 3725a73..8a943a4 100644
--- a/expression.h
+++ b/expression.h
@@ -255,6 +255,7 @@ static inline struct expression *alloc_expression(struct position pos, int type)
 	struct expression *expr = __alloc_expression(0);
 	expr->type = type;
 	expr->pos = pos;
+	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	return expr;
 }
 
@@ -265,6 +266,7 @@ static inline struct expression *alloc_const_expression(struct position pos, int
 	expr->pos = pos;
 	expr->value = value;
 	expr->ctype = &int_ctype;
+	expr->constexpr_flags = CONSTEXPR_FLAG_NONE;
 	return expr;
 }
 
-- 
2.7.0

