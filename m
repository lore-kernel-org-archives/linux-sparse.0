From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] fix: add missing degenerate() for logical not
Date: Thu,  7 Dec 2017 18:16:13 +0100
Message-ID: <20171207171613.34989-4-luc.vanoostenryck@gmail.com>
References: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36806 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756780AbdLGRU6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Dec 2017 12:20:58 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so14315038wmg.1
        for <linux-sparse@vger.kernel.org>; Thu, 07 Dec 2017 09:20:57 -0800 (PST)
In-Reply-To: <20171207171613.34989-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Expressions involving the logical-not '!' does not
call degenerate().

Since the result type is always 'int' and thus independent
of the expression being negated, this has no effect on the
type-checking but the linearization is wrong.
For example, code like:
	int foo(void)
	{
		if (!arr) return 1;
		return 0;
	}
generates:
	foo:
		load        %r6 <- 0[arr]
		seteq.32    %r7 <- VOID, $0
		ret.32      %r7
The 'load' being, obviously wrong.

Fix this by adding the missing degenerate().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                        | 1 +
 validation/linear/degen-log-not.c | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/evaluate.c b/evaluate.c
index 4bca13542..6b3e2c257 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -1914,6 +1914,7 @@ static struct symbol *evaluate_preop(struct expression *expr)
 		return evaluate_postop(expr);
 
 	case '!':
+		ctype = degenerate(expr->unop);
 		expr->flags = expr->unop->flags & ~CEF_CONST_MASK;
 		/*
 		 * A logical negation never yields an address constant
diff --git a/validation/linear/degen-log-not.c b/validation/linear/degen-log-not.c
index baa7d5366..a982e34b2 100644
--- a/validation/linear/degen-log-not.c
+++ b/validation/linear/degen-log-not.c
@@ -33,7 +33,6 @@ int test_fun_degen(int i)
 /*
  * check-name: degenerate logical-not
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: load
-- 
2.15.0

