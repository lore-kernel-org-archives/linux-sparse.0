Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96EC63777
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72C482468D
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 01:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6n+yPxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgKQBLF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 20:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbgKQBLF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 20:11:05 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D09C0613CF
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 17:11:04 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id q16so5512300edv.10
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 17:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/09FSWIzpL5xsYSy/Ze3njCPZzHIsRIcaRLmbGQUqs=;
        b=E6n+yPxC35ksch3ZxSH16GtP+pdHSzlHGEFa60/FNwEOE7R3cV6ckJ3yIF6YOvqJQV
         MUofVkWnpy5SIVoOt8QcHVs6BnwHqB8mdqqatthkEneiWjXsk96gofYHQV0/Pp42JHrM
         09HpiYuXedw0Jjp9c4M4EQBJbQDBSK0cF8+3cqJHWIIHiscp1KTYzmdCkbo7Ed6rvLz4
         sBCtpAkPQ6qdxD2/UaRFrjsKO0vRWfgE5DvrpyMomFT1tJKSH3pWQ2tggG+Rk6WZHGtE
         Je7vZzpkwF+pxlAXjQny6CZAUY36ZjMNwHI4pc19VV85yXr6cIN7jQHgrImQjVKhFHip
         zG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/09FSWIzpL5xsYSy/Ze3njCPZzHIsRIcaRLmbGQUqs=;
        b=MTtDQsVX2eb1AM8AXsVdlS4RXNB2FdwQG1c8VCQNQPpQj3y4DdiIYsBoRmAcUDk+88
         XXxtRDdcev8xMF85sBQ1WSNCKPHmmcK4/FXBXuJYSwr7ihcbJ145A0kWrnkttBB6m1Lp
         jCPJREMiqNfexA21fNnG2uLpm/fSD63U0wfY5KS9xXQ+H+FCjSx/LgIymoQzcANyxtQo
         eWgfI7DqH69bWGDkacse82bEdMThBpOfNJLQGY5zfKJlwC0pP6oyefDmE4+TQuWemyeS
         fd0KgFNIyVM/BJOx3JvlHqIISncX4sx8QR6AW+Ap2lp/FRTbKV3HBxP18lUs6kpzSUyC
         Hh3w==
X-Gm-Message-State: AOAM532ifT6lS0IFBwp09Wz6LRrO3iuhHe1YhcHOMx1iKkB4ZJy+3M9/
        sGwWSONP5RpMUt1ek+G6GkaVrpa9pbg=
X-Google-Smtp-Source: ABdhPJwtPFttri2niH2BvtZJS/OKtyjllx2rnXQVrsKEalhZMgZYyWGzgdFOX6MILOCW5Wnzw5+F0g==
X-Received: by 2002:aa7:c30e:: with SMTP id l14mr18615373edq.315.1605575463213;
        Mon, 16 Nov 2020 17:11:03 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id e9sm11231812edn.30.2020.11.16.17.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 17:11:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] simplify CBR-CBR on the same condition
Date:   Tue, 17 Nov 2020 02:10:58 +0100
Message-Id: <20201117011058.53995-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117011058.53995-1-luc.vanoostenryck@gmail.com>
References: <20201117011058.53995-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

In situations like:
		...
		cbr	<cond>, L1, L2

	L1:		L2:
	...		...

		L3:
		cbr	<cond>, L4, L5

since the conditions are the same and L3 is empty but the CBR,
all branches to L3 in L1 can be changed to branches to L4
(idem with L5 in L2). The same can be done in all BB 'in the
path between L1 and L3', more exactly in all BB dominated by L1,
this guarantee that the changes is only done on the BB where
the conditions match.

Note: This simplification kinda generalizes the current
      simplify_branch_branch() but should itself generalized
      to handle the presence of phi-sources in L3.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/flow.c b/flow.c
index f56e72db470c..88e0014c75ac 100644
--- a/flow.c
+++ b/flow.c
@@ -17,6 +17,7 @@
 #include "linearize.h"
 #include "flow.h"
 #include "target.h"
+#include "flowgraph.h"
 
 unsigned long bb_generation;
 
@@ -85,6 +86,34 @@ static int pseudo_truth_value(pseudo_t pseudo)
 	}
 }
 
+///
+// check if the BB is empty or only contains phi-sources
+static int bb_is_trivial(struct basic_block *bb)
+{
+	struct instruction *insn;
+	int n = 0;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!insn->bb)
+			continue;
+		switch (insn->opcode) {
+		case OP_TERMINATOR ... OP_TERMINATOR_END:
+			return n ? -1 : 1;
+		case OP_NOP:
+		case OP_INLINED_CALL:
+			continue;
+		case OP_PHISOURCE:
+			n++;
+			continue;
+		default:
+			goto out;
+		}
+	} END_FOR_EACH_PTR(insn);
+
+out:
+	return 0;
+}
+
 /*
  * Does a basic block depend on the pseudos that "src" defines?
  */
@@ -146,6 +175,81 @@ out:
 	return false;
 }
 
+///
+// do jump threading in dominated BBs
+// @dom: the BB which must dominate the modified BBs.
+// @old: the old target BB
+// @new: the new target BB
+// @return: 0 if no chnages have been made, 1 otherwise.
+//
+// In all BB dominated by @dom, rewrite branches to @old into branches to @new
+static int retarget_bb(struct basic_block *dom, struct basic_block *old, struct basic_block *new)
+{
+	struct basic_block *bb;
+	int changed = 0;
+
+	if (new == old)
+		return 0;
+
+restart:
+	FOR_EACH_PTR(old->parents, bb) {
+		struct instruction *last;
+		struct multijmp *jmp;
+
+		if (!domtree_dominates(dom, bb))
+			continue;
+		last = last_instruction(bb->insns);
+		switch (last->opcode) {
+		case OP_BR:
+			changed |= rewrite_branch(bb, &last->bb_true,  old, new);
+			break;
+		case OP_CBR:
+			changed |= rewrite_branch(bb, &last->bb_true,  old, new);
+			changed |= rewrite_branch(bb, &last->bb_false, old, new);
+			break;
+		case OP_SWITCH:
+		case OP_COMPUTEDGOTO:
+			FOR_EACH_PTR(last->multijmp_list, jmp) {
+				changed |= rewrite_branch(bb, &jmp->target, old, new);
+			} END_FOR_EACH_PTR(jmp);
+			break;
+		default:
+			continue;
+		}
+
+		// since rewrite_branch() will modify old->parents() the list
+		// iteration won't work correctly. Several solution exist for
+		// this but in this case the simplest is to restart the loop.
+		goto restart;
+	} END_FOR_EACH_PTR(bb);
+	return changed;
+}
+
+static int simplify_cbr_cbr(struct instruction *insn)
+{
+	struct instruction *last;
+	struct basic_block *bot = insn->bb;
+	struct basic_block *top = bot->idom;
+	int changed = 0;
+	int trivial;
+
+	if (!top)
+		return 0;
+
+	trivial = bb_is_trivial(bot);
+	if (trivial == 0)
+		return 0;
+	if (trivial < 0)
+		return 0;
+	last = last_instruction(top->insns);
+	if (last->opcode != OP_CBR || last->cond != insn->cond)
+		return 0;
+
+	changed |= retarget_bb(last->bb_true , bot, insn->bb_true);
+	changed |= retarget_bb(last->bb_false, bot, insn->bb_false);
+	return changed;
+}
+
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -293,6 +397,8 @@ static int simplify_one_branch(struct basic_block *bb, struct instruction *br)
 {
 	if (simplify_phi_branch(bb, br))
 		return 1;
+	if (simplify_cbr_cbr(br))
+		return 1;
 	return simplify_branch_branch(bb, br, &br->bb_true, 1) |
 	       simplify_branch_branch(bb, br, &br->bb_false, 0);
 }
-- 
2.29.2

