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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16D6C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F4A61946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCUMf4 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCUMfW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB736C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so16117757edc.0
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI+5XLOO0hisJjiz4RuWRMzTbKvIHVxn7TndTRh0yYE=;
        b=lGg2vZxH/fHpcbQnX2HdnHZGs9/kTeiw7DR7R0lViyNDqCdAritnI3M3ojAaLo3JHn
         RVNPtSDEyB2hIfqnUd85aKdBICOFXN3W8W+Ibvi2luDksFT7c79BwjUlPGRRFFhCETEV
         FMO3GjXk2QiE/aPG0b6vu8iycNfJJymNF7nQqHXK+eFwIBbE6WctLmNothssyuZ70THs
         TuEQbT4cEKeOn4P1tpVNZkhnhAH3csTExR8VgIUKGVFAsA4XUOKiZKgcIx2dqnzmNMi9
         L2Mrgg7vU5m8fFXy1rhUHg7ElAYFfqSLD2pnXCBPBLQp6DaAlUaQzFrJDtoa4mp3L+Yf
         HFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI+5XLOO0hisJjiz4RuWRMzTbKvIHVxn7TndTRh0yYE=;
        b=t457x2KAnoWrJS1xVrisUw8rH68cOZo71+jtTvR8T7iE4tyRvXBAAbY8NmhQBGlRYf
         wGxL18XRQ/KtQyQ2s0V0d2jkYtv9RC9STuAxE1tEhAYnnc9v0b1gnoD//qwLkMFpZGtx
         Qw7XteFFm39i+lh+RRTesLbHoUe9tQCTCUAinx4yHtbBQ+PirjQ+MxqDL5SB63I8u8j2
         IOQ/Qkh41mBIP1QSIVsX5hXg9sqeWXxl7Oa4PXK5hLiIaK5mVkFFwoxJA//Po+OMb7d9
         uLfOd3lEWI3j21qySjcJr0ncUQIfCEokpYjllTIkqoVoNte21Lk2kCGTJ9g0G3o9wzrz
         isrQ==
X-Gm-Message-State: AOAM532rGO5j+nV+LtXD9Zqoy8iA56p4C7Vnm/pJC5u8IJu1wqs/fg/j
        QsXrb0yokThYL7iA+zPv3elZN3xN/es=
X-Google-Smtp-Source: ABdhPJyfuWzMJV0LQrCbdOS4sJPTcZa8Zf5Dwzr7MITo+BH57blaHOkWWtWk6B5MVzcTlSG3PhjZWQ==
X-Received: by 2002:aa7:c709:: with SMTP id i9mr20533593edq.319.1616330120683;
        Sun, 21 Mar 2021 05:35:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:20 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/13] fix phisources during SWITCH-BR conversion
Date:   Sun, 21 Mar 2021 13:35:05 +0100
Message-Id: <20210321123505.27993-14-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Like for CBR-BR conversion, when a target BB containing one or several
phi-nodes is removed from an OP_SWITCH, the corresponding phi-source
must be removed from the phi-node.

However this is not done yet.

Changing this by adding some code to convert_to_jump() to remove all
phi-sources from the discarded targets if the converted instruction
is an OP_SWITCH.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                         | 20 ++++++++++++++++++++
 validation/optim/bad-phisrc3.c |  1 -
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index 69d95a98a512..cb94fcf20834 100644
--- a/flow.c
+++ b/flow.c
@@ -65,6 +65,23 @@ next: ;
 	return changed;
 }
 
+///
+// remove all phisources but the one corresponding to the given target
+static int remove_other_phisources(struct basic_block *bb, struct multijmp_list *list, struct basic_block *target)
+{
+	struct multijmp *jmp;
+	int changed = 0;
+
+	FOR_EACH_PTR(list, jmp) {
+		if (jmp->target == target) {
+			target = NULL;
+			continue;
+		}
+		changed |= remove_phisources(bb, jmp->target);
+	} END_FOR_EACH_PTR(jmp);
+	return changed;
+}
+
 /*
  * Dammit, if we have a phi-node followed by a conditional
  * branch on that phi-node, we should damn well be able to
@@ -764,6 +781,9 @@ int convert_to_jump(struct instruction *insn, struct basic_block *target)
 	case OP_CBR:
 		changed |= remove_phisources(insn->bb, insn->bb_true == target ? insn->bb_false : insn->bb_true);
 		break;
+	case OP_SWITCH:
+		changed |= remove_other_phisources(insn->bb, insn->multijmp_list, target);
+		break;
 	}
 	kill_use(&insn->cond);
 	insn->bb_true = target;
diff --git a/validation/optim/bad-phisrc3.c b/validation/optim/bad-phisrc3.c
index 6e437771b4b8..41537420d6fa 100644
--- a/validation/optim/bad-phisrc3.c
+++ b/validation/optim/bad-phisrc3.c
@@ -13,7 +13,6 @@ void foo(void)
 /*
  * check-name: bad-phisrc3
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-pattern(2): phisrc\\.
-- 
2.31.0

