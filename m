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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C32C433E4
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71DA61946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhCUMfZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhCUMfP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C75C061764
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u5so16831329ejn.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+NYsJOnQXUgjbqubjpQl63dBFOuY021lMJSJDGajPA=;
        b=qhw/KA2xTpN4YNzO6mIg75KsuY3mbnK5C8gWYgph5XvCd7Cs2A+07xySDd56eygUfY
         YVdp48SeP4TVeZlmuYdod3d6YXhG1XEhe8PrbvYxewOMgN3EDhNzvMVuAWSU7V/sakD+
         bGr8wvATeCSUwCqsAEVElgvk9ihYDlvglqM9s41tcalPCYWXLMdXgcrp7E2w0c3A5Kdt
         ENdwdGhQ3Qg8+Xv3Gxf0Nl6gGTF9Jfs7ewCMIo3+pDSGFSFawNfxobHl+VrqbtzZthm1
         WuHiHp81X4gSKkSrZw79hpYIJtnhB5FMGqDDWYFy2p5DytMgYWTBtmxtT9b9XQ0vlKZN
         CZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+NYsJOnQXUgjbqubjpQl63dBFOuY021lMJSJDGajPA=;
        b=J/9PX6MomLEPswaSyEMEc2C0UT+bJhGKboxi+bzwM6n/OO+GeFaP1oHbIK4DQVZ6Ut
         OLmVcg2yfF6DWQy68339HXNyVP0CVq9K+opju6f1hFXOACH1Kwisbc9PBvqYFIb/hfVr
         wxHKiE4QWuyQF+y8unNJC6nFbcxtCa2ud/pnMtMPEmsuFh5E0MBF1jQLW/PwepEFHBzW
         COkWDJ7ObOYCvtFv8MXYRnWewHzXDMnd6+1ae+lyyfzXWGSrWovhNf5JFzpyjwm95s5z
         +a8h5hWEuiQhecrAZKYo0i6/pvdkPwzCz4qS3nh5XP/ZEUnqpqjXvvhNnkdEH3kxSH6F
         SaPw==
X-Gm-Message-State: AOAM5316GID0yB7XdjejpBtyc2Qof683M0P4wqVUkkuTTEniI8uJNt1L
        PKX1fiB+SDzaoHwqOqyhUj64m45BpXI=
X-Google-Smtp-Source: ABdhPJwudmE8obTCDoyDFaYSGhDCBMYfk2HCQTSIljE+bOaypIQrErEReCKVQLk4mvawt4C/Sch0IQ==
X-Received: by 2002:a17:907:7014:: with SMTP id wr20mr14455870ejb.179.1616330113768;
        Sun, 21 Mar 2021 05:35:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/13] remove insert_branch() redundant arg
Date:   Sun, 21 Mar 2021 13:34:55 +0100
Message-Id: <20210321123505.27993-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
References: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

insert_branch()'s first argument must be the BB of the instruction
given in the second argument.

So, remove it from the argument and simply use insn->bb instead.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c      | 2 +-
 linearize.c | 3 ++-
 linearize.h | 2 +-
 simplify.c  | 8 ++++----
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/flow.c b/flow.c
index 6d77453a3554..f85c2a30c3cb 100644
--- a/flow.c
+++ b/flow.c
@@ -268,7 +268,7 @@ try_to_rewrite_target:
 	 */
 	if (bb_list_size(target->parents) != 1)
 		return retval;
-	insert_branch(target, insn, final);
+	insert_branch(insn, final);
 	return 1;
 }
 
diff --git a/linearize.c b/linearize.c
index 7248fa56b2ef..ebb03217c9d9 100644
--- a/linearize.c
+++ b/linearize.c
@@ -700,8 +700,9 @@ static void remove_parent(struct basic_block *child, struct basic_block *parent)
 }
 
 /* Change a "switch" or a conditional branch into a branch */
-void insert_branch(struct basic_block *bb, struct instruction *jmp, struct basic_block *target)
+void insert_branch(struct instruction *jmp, struct basic_block *target)
 {
+	struct basic_block *bb = jmp->bb;
 	struct instruction *br, *old;
 	struct basic_block *child;
 
diff --git a/linearize.h b/linearize.h
index 7909b01f29c5..1bb9d77eba1f 100644
--- a/linearize.h
+++ b/linearize.h
@@ -319,7 +319,7 @@ struct entrypoint {
 };
 
 extern void insert_select(struct basic_block *bb, struct instruction *br, struct instruction *phi, pseudo_t if_true, pseudo_t if_false);
-extern void insert_branch(struct basic_block *bb, struct instruction *br, struct basic_block *target);
+extern void insert_branch(struct instruction *br, struct basic_block *target);
 
 struct instruction *alloc_phisrc(pseudo_t pseudo, struct symbol *type);
 struct instruction *alloc_phi_node(struct basic_block *bb, struct symbol *type, struct ident *ident);
diff --git a/simplify.c b/simplify.c
index 207af8edf28f..930c0fa7e83f 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2441,7 +2441,7 @@ static int simplify_branch(struct instruction *insn)
 
 	/* Constant conditional */
 	if (constant(cond)) {
-		insert_branch(insn->bb, insn, cond->value ? insn->bb_true : insn->bb_false);
+		insert_branch(insn, cond->value ? insn->bb_true : insn->bb_false);
 		return REPEAT_CSE;
 	}
 
@@ -2473,11 +2473,11 @@ static int simplify_branch(struct instruction *insn)
 				long long val1 = def->src2->value;
 				long long val2 = def->src3->value;
 				if (!val1 && !val2) {
-					insert_branch(insn->bb, insn, insn->bb_false);
+					insert_branch(insn, insn->bb_false);
 					return REPEAT_CSE;
 				}
 				if (val1 && val2) {
-					insert_branch(insn->bb, insn, insn->bb_true);
+					insert_branch(insn, insn->bb_true);
 					return REPEAT_CSE;
 				}
 				if (val2) {
@@ -2515,7 +2515,7 @@ static int simplify_switch(struct instruction *insn)
 	return 0;
 
 found:
-	insert_branch(insn->bb, insn, jmp->target);
+	insert_branch(insn, jmp->target);
 	return REPEAT_CSE;
 }
 
-- 
2.31.0

