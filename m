From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] simplify '(x % 1)' into '0'
Date: Wed,  7 Dec 2016 16:46:55 +0100
Message-ID: <20161207154655.98109-6-luc.vanoostenryck@gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33769 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932177AbcLGPrK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:10 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so50544974wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:09 -0800 (PST)
In-Reply-To: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

For completeness, add the dual simplification 'x * 1 => x'
for modulo: 'x % 1 => 0'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                       | 5 +++++
 validation/optim/muldiv-by-one.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/simplify.c b/simplify.c
index e3e5ff6e..9a6222c9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -365,6 +365,11 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_ASR:
 		return simplify_asr(insn, insn->src1, value);
 
+	case OP_MODU: case OP_MODS:
+		if (value == 1)
+			return replace_with_pseudo(insn, value_pseudo(0));
+		return 0;
+
 	case OP_DIVU: case OP_DIVS:
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
diff --git a/validation/optim/muldiv-by-one.c b/validation/optim/muldiv-by-one.c
index f6dd7cb2..5d9b458e 100644
--- a/validation/optim/muldiv-by-one.c
+++ b/validation/optim/muldiv-by-one.c
@@ -5,6 +5,8 @@ si smul1(si a) {  return a * 1; }
 ui umul1(ui a) {  return a * 1; }
 si sdiv1(si a) {  return a / 1; }
 ui udiv1(ui a) {  return a / 1; }
+si smod1(si a) {  return a % 1; }
+ui umod1(ui a) {  return a % 1; }
 
 /*
  * check-name: muldiv-by-one
@@ -13,4 +15,5 @@ ui udiv1(ui a) {  return a / 1; }
  *
  * check-output-excludes: mul[us]\\.
  * check-output-excludes: div[us]\\.
+ * check-output-excludes: mod[us]\\.
  */
-- 
2.10.2

