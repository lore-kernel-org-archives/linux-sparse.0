From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 1/2] unsigned multiplication is also associative
Date: Sun, 18 Feb 2018 10:15:18 +0100
Message-ID: <20180218091519.6708-2-luc.vanoostenryck@gmail.com>
References: <20180218091519.6708-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54088 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751238AbeBRJP3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Feb 2018 04:15:29 -0500
Received: by mail-wm0-f66.google.com with SMTP id t74so10080297wme.3
        for <linux-sparse@vger.kernel.org>; Sun, 18 Feb 2018 01:15:28 -0800 (PST)
In-Reply-To: <20180218091519.6708-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, only signed multiplication is considered as associative
but in truth both signed & unsigned are.

So, make unsigned multiplication associative too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index dbea438e7..a20cc7e7c 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1168,6 +1168,7 @@ int simplify_instruction(struct instruction *insn)
 		return 0;
 	switch (insn->opcode) {
 	case OP_ADD: case OP_MULS:
+	case OP_MULU:
 	case OP_AND: case OP_OR: case OP_XOR:
 	case OP_AND_BOOL: case OP_OR_BOOL:
 		canonicalize_commutative(insn);
@@ -1175,7 +1176,6 @@ int simplify_instruction(struct instruction *insn)
 			return REPEAT_CSE;
 		return simplify_associative_binop(insn);
 
-	case OP_MULU:
 	case OP_SET_EQ: case OP_SET_NE:
 		canonicalize_commutative(insn);
 		return simplify_binop(insn);
-- 
2.16.0

