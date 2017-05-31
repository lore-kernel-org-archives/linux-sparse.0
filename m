From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] div0: warn also during simplification
Date: Wed, 31 May 2017 05:22:05 +0200
Message-ID: <20170531032207.95830-8-luc.vanoostenryck@gmail.com>
References: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35588 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdEaDWX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 30 May 2017 23:22:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so1020270wmc.2
        for <linux-sparse@vger.kernel.org>; Tue, 30 May 2017 20:22:23 -0700 (PDT)
In-Reply-To: <20170531032207.95830-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

sparse now warn about divion by zero during linearization
but during simplification some expression can become constants
and so some new divisions by zero can appears.

Warn also on those new and to avoid to warn also here on the old
ones, mark the instructions for wich we have already be warned.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c              |  1 +
 simplify.c               | 12 ++++++++++++
 validation/div-by-zero.c |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/linearize.c b/linearize.c
index 604a67b82..51405539d 100644
--- a/linearize.c
+++ b/linearize.c
@@ -969,6 +969,7 @@ static void warn_undef_insn(struct instruction *insn, int warn)
 		if (is_pseudo_value(insn->src2, 0)) {
 			if (warn && Wdiv_by_zero)
 				warning(insn->pos, "division by zero");
+			insn->warned = 1;
 		}
 		break;
 	default:
diff --git a/simplify.c b/simplify.c
index a141ddd43..40e1c253b 100644
--- a/simplify.c
+++ b/simplify.c
@@ -404,6 +404,15 @@ static int simplify_asr(struct instruction *insn, pseudo_t pseudo, long long val
 	return 0;
 }
 
+static void check_divide_by_zero(struct instruction *insn, long long value)
+{
+	if (value != 0 || insn->warned)
+		return;
+	if (Wdiv_by_zero)
+		warning(insn->pos, "division by zero");
+	insn->warned = 1;
+}
+
 static int simplify_mul_div(struct instruction *insn, long long value)
 {
 	unsigned long long sbit = 1ULL << (insn->size - 1);
@@ -525,9 +534,12 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_MODU: case OP_MODS:
 		if (value == 1)
 			return replace_with_pseudo(insn, value_pseudo(0));
+		check_divide_by_zero(insn, value);
 		return 0;
 
 	case OP_DIVU: case OP_DIVS:
+		check_divide_by_zero(insn, value);
+		/* Fall through */
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
 
diff --git a/validation/div-by-zero.c b/validation/div-by-zero.c
index a06944a58..353c85889 100644
--- a/validation/div-by-zero.c
+++ b/validation/div-by-zero.c
@@ -49,7 +49,9 @@ div-by-zero.c:18:30: warning: division by zero
 div-by-zero.c:19:30: warning: division by zero
 div-by-zero.c:21:42: warning: division by zero
 div-by-zero.c:22:33: warning: division by zero
+div-by-zero.c:23:38: warning: division by zero
 div-by-zero.c:25:42: warning: division by zero
 div-by-zero.c:26:33: warning: division by zero
+div-by-zero.c:27:38: warning: division by zero
  * check-error-end
  */
-- 
2.13.0

