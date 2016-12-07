From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] simplify '(x / -1)' to '-x' (but only for signed division)
Date: Wed,  7 Dec 2016 16:46:54 +0100
Message-ID: <20161207154655.98109-5-luc.vanoostenryck@gmail.com>
References: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f195.google.com ([209.85.210.195]:33762 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbcLGPrJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Dec 2016 10:47:09 -0500
Received: by mail-wj0-f195.google.com with SMTP id kp2so50544893wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 07 Dec 2016 07:47:08 -0800 (PST)
In-Reply-To: <20161207154655.98109-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A previous patch added the simplification for multiply by -1
but we can do the same for the signed divide.

This patch add this simplification
Also add the corresponding test cases.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c                          | 3 ++-
 validation/optim/muldiv-minus-one.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 6c7c79e9..e3e5ff6e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -324,6 +324,8 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 		if (value == 0)
 			return replace_with_pseudo(insn, insn->src2);
 
+	/* Fall through */
+	case OP_DIVS:
 		if (!(value & sbit))	// positive
 			break;
 
@@ -333,7 +335,6 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 			return REPEAT_CSE;
 		}
 	/* Fall through */
-	case OP_DIVS:
 	case OP_DIVU:
 		break;
 	}
diff --git a/validation/optim/muldiv-minus-one.c b/validation/optim/muldiv-minus-one.c
index 729b7344..05a5f915 100644
--- a/validation/optim/muldiv-minus-one.c
+++ b/validation/optim/muldiv-minus-one.c
@@ -2,6 +2,7 @@ typedef	unsigned int u32;
 
 int smulm1(int a) { return a * -1; }
 u32 umulm1(u32 a) { return a * (u32) -1; }
+int sdivm1(int a) { return a * -1; }
 
 /*
  * check-name: muldiv-minus-one
@@ -9,5 +10,6 @@ u32 umulm1(u32 a) { return a * (u32) -1; }
  * check-output-ignore
  *
  * check-output-excludes: mul[us]\\.
+ * check-output-excludes: divs\\.
  * check-output-contains: neg\\.
  */
-- 
2.10.2

