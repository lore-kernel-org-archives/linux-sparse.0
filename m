From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/9] div0: use -Wdiv-by-zero
Date: Wed, 31 May 2017 05:22:04 +0200
Message-ID: <20170531032207.95830-7-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34731 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbdEaDWW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so1025819wmf.1
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:22 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expand.c    | 4 ++--
 linearize.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/expand.c b/expand.c
index 0b528ea5a..8fd258e25 100644
--- a/expand.c
+++ b/expand.c
@@ -278,7 +278,7 @@ static int simplify_int_binop(struct expression *expr, struct symbol *ctype)
 	expr->taint = left->taint | right->taint;
 	return 1;
 Div:
-	if (!conservative)
+	if (!conservative && Wdiv_by_zero)
 		warning(expr->pos, "division by zero");
 	return 0;
 Overflow:
@@ -363,7 +363,7 @@ static int simplify_float_binop(struct expression *expr)
 	expr->fvalue = res;
 	return 1;
 Div:
-	if (!conservative)
+	if (!conservative && Wdiv_by_zero)
 		warning(expr->pos, "division by zero");
 	return 0;
 }
diff --git a/linearize.c b/linearize.c
index 7760ea996..604a67b82 100644
--- a/linearize.c
+++ b/linearize.c
@@ -967,7 +967,7 @@ static void warn_undef_insn(struct instruction *insn, int warn)
 	case OP_MODU:
 	case OP_MODS:
 		if (is_pseudo_value(insn->src2, 0)) {
-			if (warn)
+			if (warn && Wdiv_by_zero)
 				warning(insn->pos, "division by zero");
 		}
 		break;
-- 
2.13.0

