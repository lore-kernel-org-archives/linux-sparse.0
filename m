Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C3C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC4C6194C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCUMfW (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhCUMfO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DACC061762
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bx7so16045730edb.12
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4a5yyAK7LcFKaBUbRNQBjJkBua6gs1yXslDxHJ7gCzQ=;
        b=u6MTFBaoRyLwkj0fNs3yBBdnZz2Fsdi2ezlIO61SJPAGfjdReR1dQkMWWjBSqLKq6w
         OogsmXXjRAzcpt5XyWBmfZK6XGUAcDLV1uzmM2Y7jm3lL2qaJ/vgHE2qT/q0pYfeHrbX
         WH6KT/kR5g9fs0mi276b7vNoVv5JxCZxgWOOlEa795bLqLWMhiR1mE9b4ky5ybqN2cbL
         /NUCrOW3KpT2DTpRqbLJOrxsJ4lG/+oW8wopqmotTjIWJFOGT/dieDqnFlUh/BXUcdgu
         xRMGoR07eDUZZ1ZxiPkJ8svnlOy4hl2JG9BLrbWK3gTf9keA7dlHf8/AUhR0syPA33NP
         C6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4a5yyAK7LcFKaBUbRNQBjJkBua6gs1yXslDxHJ7gCzQ=;
        b=Ggu7JiC4dkGcK19FmMrMPxeMWruVG8CIagDJyjKI86INYGMcp7PPaWw94yHkz3SeRQ
         JOuOobA9lzu4r9JGe5ve7NPaD8cSfqxROcO9jGmoW5KRQyadC9T2+MOr/a2z6hSv0dKJ
         q+yNcGPQLmN2KMchwC146pKJOUeuiu84n7e3fbTIioMBzY4UWi6h8on1FS/wPpYvbIgI
         24Ll+pprLiw7wl0Ip5ru+ENk8nQ/3f3qp3vN/BBEjw8EE4h/0rUYSoNPAhYE1/46XrMW
         c4UgZ2SGgUlcglMeMHaPIVaVVO77ZdkW2uWzjfXe7yvd3H6PEf0abXRJcgH8ROwq0CE3
         AiSw==
X-Gm-Message-State: AOAM533TCw/jGfqoO8BTNI6PmUpU2mu0mOwcjPV1zLs7P3Q64cF7woJv
        wXqSk/oIlPjGIeC7Nbs0oi/BlgvKA+0=
X-Google-Smtp-Source: ABdhPJywj7gwzsdfjm2CRSGeybpNuW+19Znvc4Q+dAF/jhkdoIH26E4vLrkMFT0NaOgh2Kp17s3mBQ==
X-Received: by 2002:a05:6402:3595:: with SMTP id y21mr20087324edc.233.1616330112554;
        Sun, 21 Mar 2021 05:35:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:12 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/13] Revert "simplify CBR-CBR on the same condition"
Date:   Sun, 21 Mar 2021 13:34:53 +0100
Message-Id: <20210321123505.27993-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The commit 7cd2ce022575 ("simplify CBR-CBR on the same condition")
added a generalization of the existing CBR-CBR simplification
using the dominance tree.

The problem is that as soon as a change is made to the CFG, the
dominance tree become invalid and should be rebuilt (which is costly
to do for each CFG changes) or updated (which is quite complex).

So, for now, revert this commit.

Reverts: 7cd2ce022575fbd383bb39b54f1e0fa402919da2.
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c | 106 ---------------------------------------------------------
 1 file changed, 106 deletions(-)

diff --git a/flow.c b/flow.c
index c5319ae35ac4..6d77453a3554 100644
--- a/flow.c
+++ b/flow.c
@@ -19,7 +19,6 @@
 #include "simplify.h"
 #include "flow.h"
 #include "target.h"
-#include "flowgraph.h"
 
 unsigned long bb_generation;
 
@@ -69,34 +68,6 @@ static int pseudo_truth_value(pseudo_t pseudo)
 	}
 }
 
-///
-// check if the BB is empty or only contains phi-sources
-static int bb_is_trivial(struct basic_block *bb)
-{
-	struct instruction *insn;
-	int n = 0;
-
-	FOR_EACH_PTR(bb->insns, insn) {
-		if (!insn->bb)
-			continue;
-		switch (insn->opcode) {
-		case OP_TERMINATOR ... OP_TERMINATOR_END:
-			return n ? -1 : 1;
-		case OP_NOP:
-		case OP_INLINED_CALL:
-			continue;
-		case OP_PHISOURCE:
-			n++;
-			continue;
-		default:
-			goto out;
-		}
-	} END_FOR_EACH_PTR(insn);
-
-out:
-	return 0;
-}
-
 /*
  * Does a basic block depend on the pseudos that "src" defines?
  */
@@ -158,81 +129,6 @@ out:
 	return false;
 }
 
-///
-// do jump threading in dominated BBs
-// @dom: the BB which must dominate the modified BBs.
-// @old: the old target BB
-// @new: the new target BB
-// @return: 0 if no chnages have been made, 1 otherwise.
-//
-// In all BB dominated by @dom, rewrite branches to @old into branches to @new
-static int retarget_bb(struct basic_block *dom, struct basic_block *old, struct basic_block *new)
-{
-	struct basic_block *bb;
-	int changed = 0;
-
-	if (new == old)
-		return 0;
-
-restart:
-	FOR_EACH_PTR(old->parents, bb) {
-		struct instruction *last;
-		struct multijmp *jmp;
-
-		if (!domtree_dominates(dom, bb))
-			continue;
-		last = last_instruction(bb->insns);
-		switch (last->opcode) {
-		case OP_BR:
-			changed |= rewrite_branch(bb, &last->bb_true,  old, new);
-			break;
-		case OP_CBR:
-			changed |= rewrite_branch(bb, &last->bb_true,  old, new);
-			changed |= rewrite_branch(bb, &last->bb_false, old, new);
-			break;
-		case OP_SWITCH:
-		case OP_COMPUTEDGOTO:
-			FOR_EACH_PTR(last->multijmp_list, jmp) {
-				changed |= rewrite_branch(bb, &jmp->target, old, new);
-			} END_FOR_EACH_PTR(jmp);
-			break;
-		default:
-			continue;
-		}
-
-		// since rewrite_branch() will modify old->parents() the list
-		// iteration won't work correctly. Several solution exist for
-		// this but in this case the simplest is to restart the loop.
-		goto restart;
-	} END_FOR_EACH_PTR(bb);
-	return changed;
-}
-
-static int simplify_cbr_cbr(struct instruction *insn)
-{
-	struct instruction *last;
-	struct basic_block *bot = insn->bb;
-	struct basic_block *top = bot->idom;
-	int changed = 0;
-	int trivial;
-
-	if (!top)
-		return 0;
-
-	trivial = bb_is_trivial(bot);
-	if (trivial == 0)
-		return 0;
-	if (trivial < 0)
-		return 0;
-	last = last_instruction(top->insns);
-	if (last->opcode != OP_CBR || last->cond != insn->cond)
-		return 0;
-
-	changed |= retarget_bb(last->bb_true , bot, insn->bb_true);
-	changed |= retarget_bb(last->bb_false, bot, insn->bb_false);
-	return changed;
-}
-
 /*
  * When we reach here, we have:
  *  - a basic block that ends in a conditional branch and
@@ -380,8 +276,6 @@ static int simplify_one_branch(struct basic_block *bb, struct instruction *br)
 {
 	if (simplify_phi_branch(bb, br))
 		return 1;
-	if (simplify_cbr_cbr(br))
-		return 1;
 	return simplify_branch_branch(bb, br, &br->bb_true, 1) |
 	       simplify_branch_branch(bb, br, &br->bb_false, 0);
 }
-- 
2.31.0

