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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5DDC388F9
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8242076E
	for <linux-sparse@archiver.kernel.org>; Thu, 12 Nov 2020 01:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gd7yX4ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKLBds (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgKKXwo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 11 Nov 2020 18:52:44 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9397C0613D6
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:42 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f20so5162151ejz.4
        for <linux-sparse@vger.kernel.org>; Wed, 11 Nov 2020 15:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gykk8oENS8LeP841rrJGoHp56EyOJvm2mZytIseKdn8=;
        b=Gd7yX4apIrbtFacvQRzUvkAGorHMMXHMj5L3VmSFAtWxTjpYRNLBXKYsOeoOfy1NZI
         NUMTsuS70BN6aZ4HnjuQqOHdBaxMec5A7xUTqX6FZNBo2QUIdgU6zYmdS3jJVue27u+K
         XqLAw2dw5xfnt7BHabUh6D0OuX3BiCtVS0JjL6+0MrHYKEp/3ePyR8xIR+Ip44MTiQPM
         25o/+1JGdoyLooCqioXCN+V+zlU4M/VKMxisaY7JFXaRWULFaZsMOygO3gGWo/izzOs7
         aTbKoduqCWNILbf74s1zmtX5/skkf8zS9GgbO9bn5afoFk7ecI+5IkPJvVBqqfJp/ETY
         RvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gykk8oENS8LeP841rrJGoHp56EyOJvm2mZytIseKdn8=;
        b=DSfytfBUgGmFDPt4VEUibDsUg0YeBhGuCWArh++kRlVPunA7GhhKsvOz7rIO6xA5qz
         NbhoUoMVvxudluXkcQbghYX3qKDjTGUl5ERtcNeQYqPpyNc4jXaRL6oBOgPu9XmutVOo
         llC3lijXvR3YiCv7837/Qhc9xoLZ6bUFcXIrlhxSKXBCU+LvLmOfadc7GGYTVlQA1TO8
         UuhyHXR9Gi3uo/sSlUK7WLW88MI+j4IOroVa2Tk7pL1POm+n/GBq8vAETlPZUbRfzrs2
         7fe7xox4HaG0ftD8GTblDEsl6Gvgo9Qg9ORWVv93JBhQzFwkuJT8WSjlIq7boWSE/DSw
         Aedg==
X-Gm-Message-State: AOAM530dq0cctFMJw4BSMgNUQFLKuIVOq0jV8iimFBJXeT0tr8IBfxi9
        StpFhWr8QsZgg5ox8nPoFf99awFdhl4=
X-Google-Smtp-Source: ABdhPJxi7Gi/g8aZYyVLIO4KXOX/q5eloZufSrB81fOY/ZqNFTnWWOA5cm/pgyqQPmCDsz4i8A8Meg==
X-Received: by 2002:a17:906:66c9:: with SMTP id k9mr28749474ejp.204.1605138761458;
        Wed, 11 Nov 2020 15:52:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:28a7:5fc2:f4ab:be33])
        by smtp.gmail.com with ESMTPSA id 1sm1391398ejt.107.2020.11.11.15.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:52:40 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] adjust phi-sources when merging BBs
Date:   Thu, 12 Nov 2020 00:52:32 +0100
Message-Id: <20201111235232.78450-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111235232.78450-1-luc.vanoostenryck@gmail.com>
References: <20201111235232.78450-1-luc.vanoostenryck@gmail.com>
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
 flow.c                                  | 28 +++++++++++++++++++++++++
 validation/optim/merge_bbe-adjust_phi.c |  1 -
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/flow.c b/flow.c
index ef8d04e5827f..a74769c37659 100644
--- a/flow.c
+++ b/flow.c
@@ -723,6 +723,32 @@ void vrfy_flow(struct entrypoint *ep)
 	assert(!entry);
 }
 
+static void adjust_phi(struct basic_block *top, struct instruction *insn)
+{
+	struct pseudo_user *pu;
+
+	FOR_EACH_PTR(insn->target->users, pu) {
+		struct instruction *user;
+		pseudo_t phi;
+
+		if (!pu)
+			continue;
+		user = pu->insn;
+		assert(user->opcode == OP_PHI);
+		FOR_EACH_PTR(user->phi_list, phi) {
+			struct instruction *phisrc;
+
+			if (phi == VOID)
+				continue;
+			phisrc = phi->def;
+			if (phisrc->bb != top)
+				continue;
+			REPLACE_CURRENT_PTR(phi, VOID);
+			kill_instruction(phisrc);
+		} END_FOR_EACH_PTR(phi);
+	} END_FOR_EACH_PTR(pu);
+}
+
 void pack_basic_blocks(struct entrypoint *ep)
 {
 	struct basic_block *bb;
@@ -804,6 +830,8 @@ out:
 			if (!insn->bb)
 				continue;
 			assert(insn->bb == bb);
+			if (insn->opcode == OP_PHISOURCE)
+				adjust_phi(parent, insn);
 			insn->bb = parent;
 			add_instruction(&parent->insns, insn);
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

