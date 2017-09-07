From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Another code snippet that Sparse has problems with
Date: Thu, 7 Sep 2017 03:31:03 +0200
Message-ID: <20170907013101.f6d4eeftkolbsjr5@ltop.local>
References: <CACXZuxeoG1v1y8Jm6kHSrFEad0WJo-kaoWk_QbWAM8hn1R_BwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33626 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbdIGBbJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 21:31:09 -0400
Received: by mail-wm0-f53.google.com with SMTP id f145so19375773wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 18:31:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxeoG1v1y8Jm6kHSrFEad0WJo-kaoWk_QbWAM8hn1R_BwQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 07, 2017 at 12:05:58AM +0100, Dibyendu Majumdar wrote:
> Hi,
> 
> I recently found another test case that fails:
> 
> static int test_do(void) {
>     int a = 0;
>     int count = 27;
>     switch (count % 8) {
>     case 0: do {  a++;
>     case 7:       a++;
>     case 6:       a++;
>     case 5:       a++;
>     case 4:       a++;
>     case 3:       a++;
>     case 2:       a++;
>     case 1:       a++;
>             } while ((count -= 8) > 0);
>     }
>     if (27 != a) return 1;
>     return 0;
> }


Ah, a Duff device with a constant. A smart compiler could
optimize it away entirely.

In our case, the simplification of the switch (called once
and with a constant value) leave all the case's phi-node
incorrect (but the one for 3).

The following patch should solve it but I would like to have a
better way to do the matching between the BB and the phi-operands.

With this I get the follwing result, which look correct:
	foo:
	.L0:
		<entry-point>
		phisrc.32   %phi13(a) <- $0
		phisrc.32   %phi21(count) <- $27
		br          .L7
	
	.L6:
		add.32      %r12 <- %r18, $5
		phisrc.32   %phi14(a) <- %r12
		phisrc.32   %phi32(count) <- %r21
		br          .L7
	
	.L7:
		phi.32      %r34(a) <- %phi13(a), %phi14(a)
		phi.32      %r37(count) <- %phi21(count), %phi32(count)
		add.32      %r18 <- %r34(a), $3
		add.32      %r21 <- %r37(count), $-8
		setgt.32    %r23 <- %r21, $0
		cbr         %r23, .L6, .L1
	
	.L1:
		setne.32    %r25 <- %r18, $27
		ret.32      %r25


------------------------------------------------------------------------

From 275d1ae2c2e187783d1d095d5f9f5950bc360be9 Mon Sep 17 00:00:00 2001
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Thu, 7 Sep 2017 03:18:30 +0200
Subject: [PATCH] fix remove_parent()

---
 linearize.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index eabf8575a..eb6b53a0a 100644
--- a/linearize.c
+++ b/linearize.c
@@ -649,9 +649,53 @@ static void set_activeblock(struct entrypoint *ep, struct basic_block *bb)
 		add_bb(&ep->bbs, bb);
 }
 
+
+static void remove_nth_phisource(struct instruction *insn, int nth)
+{
+	pseudo_t src;
+	int i = 0;
+
+	FOR_EACH_PTR(insn->phi_list, src) {
+		if (++i < nth)
+			continue;
+		*THIS_ADDRESS(src) = VOID;
+		return;
+	} END_FOR_EACH_PTR(src);
+	assert(0);
+}
+
+static void remove_nth_phisources(struct basic_block *bb, int nth)
+{
+	struct instruction *insn;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		if (insn->opcode != OP_PHI)
+			break;
+
+		remove_nth_phisource(insn, nth);
+	} END_FOR_EACH_PTR(insn);
+}
+
 static void remove_parent(struct basic_block *child, struct basic_block *parent)
 {
-	remove_bb_from_list(&child->parents, parent, 1);
+	struct basic_block *bb;
+	int nth = 0;
+
+	FOR_EACH_PTR(child->parents, bb) {
+		nth++;
+
+		if (bb != parent)
+			continue;
+
+		DELETE_CURRENT_PTR(bb);
+		goto found;
+	} END_FOR_EACH_PTR(bb);
+	assert(0);	// should never be reached
+
+found:
+	remove_nth_phisources(child, nth);
 	if (!child->parents)
 		repeat_phase |= REPEAT_CFG_CLEANUP;
 }
-- 
2.14.0

