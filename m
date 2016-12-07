From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/5] simplify '(x / 1)' to 'x'
Date: Wed,  7 Dec 2016 16:46:52 +0100
Message-ID: <20161207154655.98109-3-luc.vanoostenryck@gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34609 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932346AbcLGPrH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so28664124wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:06 -0800 (PST)
In-Reply-To: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently we simplify multiplication by 1 but nothing
for the similar divide by 1.

This patch add the missing simplification together with
its test cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 5 +++++
 validation/optim/muldiv-by-one.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/simplify.c b/simplify.c
index b242b64d..5541fc4c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -320,6 +320,10 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	case OP_MULU:
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
+	/* Fall through */
+	case OP_DIVS:
+	case OP_DIVU:
+		break;
 	}
 
 	return 0;
@@ -348,6 +352,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_ASR:
 		return simplify_asr(insn, insn->src1, value);
 
+	case OP_DIVU: case OP_DIVS:
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
 
diff --git a/validation/optim/muldiv-by-one.c b/validation/optim/muldiv-by-one.c
index ac8ac95b..f6dd7cb2 100644
--- a/validation/optim/muldiv-by-one.c
+++ b/validation/optim/muldiv-by-one.c
@@ -3,6 +3,8 @@ typedef	         int si;
 
 si smul1(si a) {  return a * 1; }
 ui umul1(ui a) {  return a * 1; }
+si sdiv1(si a) {  return a / 1; }
+ui udiv1(ui a) {  return a / 1; }
 
 /*
  * check-name: muldiv-by-one
@@ -10,4 +12,5 @@ ui umul1(ui a) {  return a * 1; }
  * check-output-ignore
  *
  * check-output-excludes: mul[us]\\.
+ * check-output-excludes: div[us]\\.
  */
-- 
2.10.2

