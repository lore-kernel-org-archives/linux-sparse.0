From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/8] use valid_type to avoid to warn twice on conditionals
Date: Fri,  2 Feb 2018 13:17:32 +0100
Message-ID: <20180202121735.39621-6-luc.vanoostenryck@gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33021 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeBBMTw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 2 Feb 2018 07:19:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id x4-v6so2309322wmc.0
        for <linux-sparse@vger.kernel.org>; Fri, 02 Feb 2018 04:19:51 -0800 (PST)
In-Reply-To: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

When evaluating a conditional, the expression is first evaluated
and some further verifications and processing are done if
the returned type is not NULL.

However, the returned type can also be 'bad_ctype' and if it is
the case, the additional verifications will just give meaningless
additional warnings.

Fix this by using the new helper valid_type() instead of just
testing for a null ctype.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                   | 2 +-
 validation/bad-type-twice1.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 1fc6111e4..3c4a25325 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -879,7 +879,7 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 		warning(expr->pos, "assignment expression in conditional");
 
 	ctype = evaluate_expression(expr);
-	if (!ctype)
+	if (!valid_type(ctype))
 		return NULL;
 	if (is_safe_type(ctype))
 		warning(expr->pos, "testing a 'safe expression'");
diff --git a/validation/bad-type-twice1.c b/validation/bad-type-twice1.c
index 2f4e2838f..95cfd9e01 100644
--- a/validation/bad-type-twice1.c
+++ b/validation/bad-type-twice1.c
@@ -7,7 +7,6 @@ static unsigned long foo(unsigned long val, void *ref)
 
 /*
  * check-name: bad-type-twice1
- * check-known-to-fail
  *
  * check-error-start
 bad-type-twice1.c:3:17: error: incompatible types for operation (>=)
-- 
2.16.0

