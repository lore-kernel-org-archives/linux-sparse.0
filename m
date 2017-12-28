From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] fix: restore CSE on floating-point compares
Date: Thu, 28 Dec 2017 23:17:35 +0100
Message-ID: <20171228221735.38902-3-luc.vanoostenryck@gmail.com>
References: <20171228221735.38902-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45847 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbdL1WRw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 Dec 2017 17:17:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so45884373wme.4
        for <linux-sparse@vger.kernel.org>; Thu, 28 Dec 2017 14:17:51 -0800 (PST)
In-Reply-To: <20171228221735.38902-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Since commit "1c182507c (fix support of floating-point compare)",
CSE wasn't done anymore on floating-point compare.

Fix this by adding the two missing 'case OP_FPCMP ...'

Fixes: 1c182507c3981aa20193c68d7cfd32d750b571cf
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cse.c                       | 4 +++-
 validation/optim/cse-fcmp.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/cse.c b/cse.c
index d5da26fba..6987645c1 100644
--- a/cse.c
+++ b/cse.c
@@ -71,7 +71,8 @@ static void clean_up_one_instruction(struct basic_block *bb, struct instruction
 	case OP_SET_B:  case OP_SET_A:
 	case OP_SET_BE: case OP_SET_AE:
 
-	/* floating-point arithmetic */
+	/* floating-point arithmetic & comparison */
+	case OP_FPCMP ... OP_FPCMP_END:
 	case OP_FADD:
 	case OP_FSUB:
 	case OP_FMUL:
@@ -214,6 +215,7 @@ static int insn_compare(const void *_i1, const void *_i2)
 	case OP_SET_BE: case OP_SET_AE:
 
 	/* floating-point arithmetic */
+	case OP_FPCMP ... OP_FPCMP_END:
 	case OP_FADD:
 	case OP_FSUB:
 	case OP_FMUL:
diff --git a/validation/optim/cse-fcmp.c b/validation/optim/cse-fcmp.c
index 9e6872302..f2a73f57f 100644
--- a/validation/optim/cse-fcmp.c
+++ b/validation/optim/cse-fcmp.c
@@ -13,7 +13,6 @@ int foo(double a, double b)
 /*
  * check-name: cse-fcmp
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-pattern(1): fcmp
-- 
2.15.0

