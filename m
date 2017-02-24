From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix usage in simplify_seteq_setne()
Date: Fri, 24 Feb 2017 07:54:34 +0100
Message-ID: <20170224065434.46976-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36629 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdBXG4m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Feb 2017 01:56:42 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so1467103wmd.3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Feb 2017 22:56:41 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The usage was removed before the new operands were used
which can lead to undefined pseudos.

Fix this by moving the call to remove_usage() where
it should always have been: after the call to use_pseudo().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/simplify.c b/simplify.c
index 3bc9985e8..76a599e50 100644
--- a/simplify.c
+++ b/simplify.c
@@ -432,7 +432,8 @@ static int compare_opcode(int opcode, int inverse)
 
 static int simplify_seteq_setne(struct instruction *insn, long long value)
 {
-	struct instruction *def = insn->src1->def;
+	pseudo_t old = insn->src1;
+	struct instruction *def = old->def;
 	pseudo_t src1, src2;
 	int inverse;
 	int opcode;
@@ -456,10 +457,10 @@ static int simplify_seteq_setne(struct instruction *insn, long long value)
 		// and similar for setne/eq ... 0/1
 		src1 = def->src1;
 		src2 = def->src2;
-		remove_usage(insn->src1, &insn->src1);
 		insn->opcode = compare_opcode(opcode, inverse);
 		use_pseudo(insn, src1, &insn->src1);
 		use_pseudo(insn, src2, &insn->src2);
+		remove_usage(old, &insn->src1);
 		return REPEAT_CSE;
 
 	default:
-- 
2.11.1

