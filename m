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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF33C63798
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E49B2244C
	for <linux-sparse@archiver.kernel.org>; Mon, 16 Nov 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBzQJ+QJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKPW3i (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 16 Nov 2020 17:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgKPW3h (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 16 Nov 2020 17:29:37 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919DEC0613D2
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:37 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id me8so26668763ejb.10
        for <linux-sparse@vger.kernel.org>; Mon, 16 Nov 2020 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UXXUGks/KJZwsWK+aJN+A937y2MkUQYrMzq6SrXlG0k=;
        b=FBzQJ+QJnRbRpKw7ETjDHRU1g7WEZv4Cu72Ps0s89WFHIbPZtrdPMkYK8JhbNlW4lB
         EvlC23LpA5cx13tyR6QKz96STfRRqhIjBGpMaywZSsa8Cz6cEruimZmEuicgd6ZuLLTc
         dn6oO1sQYG3vFV/AnTmHzA9EX+/g7aQV/rXSeJoo4aT9BJqw6nk6rLbcGjHVamyOOAts
         hfZmpSARWtceDz9LyPZwpyMNwKOca3KMFgBB3QOmJyQzRsrsjxhjGfTUFLUBP1BYUETu
         bEXpLFnTPvQXHAmoKzP9l0qP8oKztsYvJZfleUeya3JaNGFPswOBaTuP/8B/Y21xEUrl
         48lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UXXUGks/KJZwsWK+aJN+A937y2MkUQYrMzq6SrXlG0k=;
        b=nL+NMfabw+y0P1oTSAWz5PiKRqJZXBctlKHuvN9E42+byBunhSmPoEjOXjLAyoGMB0
         0kZ9/wobhG+DBcEzPC+o3fGbYMP/EdpzEFGr1p71x6bgQuk0M43mwZW1MtC5nXxNFo1H
         2liwg6P3L/yBFdOkJQ99z1KYtYg9/Wiu5q+shzN1p9hGYjFk/6sta6nLAYpI8s+88JMT
         /lvKFexZnFAo7/tPmp23rIH1sbgyyo0CjtJlWubH+hCBGUa+mm4Mu6t4vtTed2MZX1tF
         cCVoRlY3PliyXRAac5egxFyJOAR207TKKua4Rx4OvOYmUzzFDFluS/yE1Nk9rYO2uf16
         Cyrw==
X-Gm-Message-State: AOAM531mHF4VftNjakIeCEOsuiKPU1Ag2WxXnyelfGhqM7CikOwhCICj
        ai7+l2NtZB5e9Xp2qbNYnvsD4YiBcCw=
X-Google-Smtp-Source: ABdhPJxVjkffvX9IdxdaLiOnpDvszjWFEWfxncCHDN366Z3B5Ftv65djn02SCSKeBcv3XN5fyETp4g==
X-Received: by 2002:a17:906:b003:: with SMTP id v3mr17272815ejy.290.1605565776021;
        Mon, 16 Nov 2020 14:29:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:a141:d91b:1f47:d972])
        by smtp.gmail.com with ESMTPSA id bn25sm10805446ejb.76.2020.11.16.14.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:29:35 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/8] cfg: adjust phi-sources when merging BBs
Date:   Mon, 16 Nov 2020 23:29:23 +0100
Message-Id: <20201116222927.51939-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
References: <20201116222927.51939-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When merging two basic blocks, it may happen that both of theses
blocks contain a phi-source for the same phi-node. In this case,
only the phi-source from the bottom BB must be taken in account,
it kinda overwrites the value from the top BB and the phi-source
from the top BB must be ignored, in fact it must be removed.

However, it is not the case and this extra phi-source creates
different kind of problems. Among other things, it hinders
further simplifications. For example, the following code:

	extern int array[2];
	static inline int stupid_select(int idx)
	{
		if (idx)
			idx = 0;
		return array[idx];
	}
	int select(void)
	{
		int d = stupid_select(-1);
		return d;
	}

should boil down to a simple dereference of the array with
an index of zero, like:
	select:
		load.32     %r8 <- 0[array]
		ret.32      %r8

but currently gives:
	select:
		phisrc.32   %phi3(idx) <- $0xffffffff
		phisrc.32   %phi4(idx) <- $0
		phi.32      %r12(idx) <- %phi3(idx), %phi4(idx)
		sext.64     %r5 <- (32) %r12(idx)
		mul.64      %r6 <- %r5, $4
		add.64      %r7 <- %r6, array
		load.32     %r8 <- 0[%r7]
		ret.32      %r8

This patch takes care of the problem by:
* when merging 2 BBs, check when reaching a phi-source in the bottom BB
* if one is found, look after sibling phi-sources
* remove such sibling if belonging to the top BB.
With this change, the code above gives:
	select:
		phisrc.32   %phi4(idx) <- $0
		phi.32      %r12(idx) <- %phi4(idx)
		sext.64     %r5 <- (32) %r12(idx)
		mul.64      %r6 <- %r5, $4
		add.64      %r7 <- %r6, array
		load.32     %r8 <- 0[%r7]
		ret.32      %r8

which can the be simplified into the expected result.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c                                  | 42 +++++++++++++++++++++++++
 validation/optim/merge_bbe-adjust_phi.c |  1 -
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index 9ae8612a2312..e9c8f6b7355e 100644
--- a/flow.c
+++ b/flow.c
@@ -43,6 +43,25 @@ static int rewrite_branch(struct basic_block *bb,
 	return 1;
 }
 
+///
+// returns the phi-node corresponding to a phi-source
+static struct instruction *get_phinode(struct instruction *phisrc)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(phisrc->target->users, pu) {
+		struct instruction *user;
+
+		if (!pu)
+			continue;
+		user = pu->insn;
+		assert(user->opcode == OP_PHI);
+		return user;
+	} END_FOR_EACH_PTR(pu);
+	assert(0);
+}
+
+
 /*
  * Return the known truth value of a pseudo, or -1 if
  * it's not known.
@@ -723,6 +742,24 @@ void vrfy_flow(struct entrypoint *ep)
 	assert(!entry);
 }
 
+static void adjust_phisrc(struct basic_block *top, struct instruction *insn)
+{
+	struct instruction *user = get_phinode(insn);
+	pseudo_t phi;
+
+	FOR_EACH_PTR(user->phi_list, phi) {
+		struct instruction *phisrc;
+
+		if (phi == VOID)
+			continue;
+		phisrc = phi->def;
+		if (phisrc->bb != top)
+			continue;
+		REPLACE_CURRENT_PTR(phi, VOID);
+		kill_instruction(phisrc);
+	} END_FOR_EACH_PTR(phi);
+}
+
 ///
 // merge two BBs
 // @top: the first BB to be merged
@@ -748,6 +785,11 @@ static int merge_bb(struct basic_block *top, struct basic_block *bot)
 		if (!insn->bb)
 			continue;
 		assert(insn->bb == bot);
+		switch (insn->opcode) {
+		case OP_PHISOURCE:
+			adjust_phisrc(top, insn);
+			break;
+		}
 		insn->bb = top;
 		add_instruction(&top->insns, insn);
 	} END_FOR_EACH_PTR(insn);
diff --git a/validation/optim/merge_bbe-adjust_phi.c b/validation/optim/merge_bbe-adjust_phi.c
index de4c54cc6d49..6a8ebb73a62d 100644
--- a/validation/optim/merge_bbe-adjust_phi.c
+++ b/validation/optim/merge_bbe-adjust_phi.c
@@ -16,7 +16,6 @@ int select(void)
 /*
  * check-name: merge_bbe-adjust_phi
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: phisrc\\.
-- 
2.29.2

