From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 4/5] simplify '(x / -1)' to '-x' (but only for signed division)
Date: Tue,  7 Feb 2017 21:50:27 +0100
Message-ID: <20170207205028.35869-5-luc.vanoostenryck@gmail.com>
References: <CANeU7Q=67iWdgssXLEQyX0Saoe8iCf17jDCh7PWwwpeAuEhVAQ@mail.gmail.com>
 <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35177 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755156AbdBGUxS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Feb 2017 15:53:18 -0500
Received: by mail-wj0-f193.google.com with SMTP id i7so4819759wjf.2
        for <linux-sparse@vger.kernel.org>; Tue, 07 Feb 2017 12:52:38 -0800 (PST)
In-Reply-To: <20170207205028.35869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A previous patch added the simplification for multiply by -1
but we can do the same for the signed divide.

This patch add this simplification
Also add the corresponding test cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 2 ++
 validation/optim/muldiv-minus-one.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/simplify.c b/simplify.c
index 363cc5ad7..86d2f5da9 100644
--- a/simplify.c
+++ b/simplify.c
@@ -323,6 +323,8 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	case OP_MULU:
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
+	/* Fall through */
+	case OP_DIVS:
 		if (!(value & sbit))	// positive
 			break;
 
diff --git a/validation/optim/muldiv-minus-one.c b/validation/optim/muldiv-minus-one.c
index 729b73443..42b086afd 100644
--- a/validation/optim/muldiv-minus-one.c
+++ b/validation/optim/muldiv-minus-one.c
@@ -2,6 +2,8 @@ typedef	unsigned int u32;
 
 int smulm1(int a) { return a * -1; }
 u32 umulm1(u32 a) { return a * (u32) -1; }
+int sdivm1(int a) { return a / -1; }
+u32 udivm1(u32 a) { return a / (u32) -1; }
 
 /*
  * check-name: muldiv-minus-one
@@ -9,5 +11,8 @@ u32 umulm1(u32 a) { return a * (u32) -1; }
  * check-output-ignore
  *
  * check-output-excludes: mul[us]\\.
+ * check-output-excludes: divs\\.
  * check-output-contains: neg\\.
+ * check-output-contains: divu\\.
+ * check-output-pattern-3-times: neg\\.
  */
-- 
2.11.0

