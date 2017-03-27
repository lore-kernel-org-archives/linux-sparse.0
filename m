From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v6 03/15] use opcode table for compare_opcode()
Date: Mon, 27 Mar 2017 19:33:53 +0200
Message-ID: <20170327173405.11405-4-luc.vanoostenryck@gmail.com>
References: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34570 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdC0RhM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 13:37:12 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so12462051wrb.1
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 10:36:21 -0700 (PDT)
In-Reply-To: <20170327173405.11405-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

At the same time, change also the name of the function.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/simplify.c b/simplify.c
index 5d00937f1..c18a2268e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -403,30 +403,6 @@ static int simplify_mul_div(struct instruction *insn, long long value)
 	return 0;
 }
 
-static int compare_opcode(int opcode, int inverse)
-{
-	if (!inverse)
-		return opcode;
-
-	switch (opcode) {
-	case OP_SET_EQ:	return OP_SET_NE;
-	case OP_SET_NE:	return OP_SET_EQ;
-
-	case OP_SET_LT:	return OP_SET_GE;
-	case OP_SET_LE:	return OP_SET_GT;
-	case OP_SET_GT:	return OP_SET_LE;
-	case OP_SET_GE:	return OP_SET_LT;
-
-	case OP_SET_A:	return OP_SET_BE;
-	case OP_SET_AE:	return OP_SET_B;
-	case OP_SET_B:	return OP_SET_AE;
-	case OP_SET_BE:	return OP_SET_A;
-
-	default:
-		return opcode;
-	}
-}
