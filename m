From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 2/5] simplify '(x / 1)' to 'x'
Date: Tue,  7 Feb 2017 20:00:25 +0100
Message-ID: <20170207190028.24343-3-luc.vanoostenryck@gmail.com>
References: <CANeU7QkOmqZH-X4C3Ma6b94jyx1LnjM=UEH2CjEt0SwgZ4Y2Kw@mail.gmail.com>
 <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33755 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754472AbdBGTAm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 14:00:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so29953430wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 11:00:42 -0800 (PST)
In-Reply-To: <20170207190028.24343-1-luc.vanoostenryck@gmail.com>
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
 simplify.c                       | 1 +
 validation/optim/muldiv-by-one.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/simplify.c b/simplify.c
index b242b64d6..91021dbb1 100644
--- a/simplify.c
+++ b/simplify.c
@@ -348,6 +348,7 @@ static int simplify_constant_rightside(struct instruction *insn)
 	case OP_ASR:
 		return simplify_asr(insn, insn->src1, value);
 
+	case OP_DIVU: case OP_DIVS:
 	case OP_MULU: case OP_MULS:
 		return simplify_mul_div(insn, value);
 
diff --git a/validation/optim/muldiv-by-one.c b/validation/optim/muldiv-by-one.c
index ac8ac95b2..f6dd7cb2c 100644
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
2.11.0

