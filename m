From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: teach do_expression() to handle EXPR_OFFSETOF
Date: Mon, 8 Feb 2016 14:26:57 +0100
Message-ID: <20160208132657.GA19007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38288 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442AbcBHN07 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 8 Feb 2016 08:26:59 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>
Cc: linux-sparse@vger.kernel.org

Starting from a194f3e0 "implement __builtin_offsetof()" sparse handles
offsetof() internally but dissect.c wasn't updated.

Test case:

	struct S { int m; };

	void func(void)
	{
		__builtin_offsetof(struct S, m);
	}

before this patch:

	3:6   g def  func                             void ( ... )
	T.c:5:38: warning: bad expr->type: 30

after:

	3:6   g def  func                             void ( ... )
	1:8   s def  S
	5:38  s ---  S.m                              int

While at it, update my email.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/dissect.c b/dissect.c
index d211bca..19f3276 100644
--- a/dissect.c
+++ b/dissect.c
@@ -1,7 +1,7 @@
 /*
  * sparse/dissect.c
  *
- * Started by Oleg Nesterov <oleg@tv-sign.ru>
+ * Started by Oleg Nesterov <oleg@redhat.com>
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -429,6 +429,20 @@ again:
 			lookup_member(p_type, expr->member, NULL));
 	}
 
+	break; case EXPR_OFFSETOF: {
+		struct symbol *in = base_type(expr->in);
+
+		do {
+			if (expr->op == '.') {
+				in = report_member(U_VOID, &expr->pos, in,
+					lookup_member(in, expr->ident, NULL));
+			} else {
+				do_expression(U_R_VAL, expr->index);
+				in = in->ctype.base_type;
+			}
+		} while ((expr = expr->down));
+	}
+
 	break; case EXPR_SYMBOL:
 		ret = report_symbol(mode, expr);
 	}
-- 
2.5.0


