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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF38C388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790712151B
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkqkfREy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKUWrF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKUWrE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 17:47:04 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F2C0613D1
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x13so5244879wmj.1
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KJkBydqq/QFK0CWM8A2gjdEyjJaMqP6HXYipIhFing=;
        b=AkqkfREyJrA6XLvZklwVRvu7Xum3oZwfgeBUKHZdXcWqKpkK5PZrgjHLDSSyNefr9E
         kB8bNEecoXFSxUUMhdw/GSMGxOBIU7CS2nJMBAMO/dCXK4oQqPzQInlKFoCmONrD9mU6
         tUDRRdHxmCxovKJtAL/BTmOcnEiZwwf6qzocaRVcYbddH8im0+PBt2K8a5pHkmN24HOk
         h4g4COe9RRKTcfuWl7QBTSNhoxwXI8s5nt/qPNN/n58mPmabRl/ALK75Xig4LERpzuBy
         VbjtNfopfDYjMAx2OH7bw6V/1VRtBnNv4wxGpgOY6ZOAnZuzZRSZ8jM/a45lJXZ/I/9s
         nKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KJkBydqq/QFK0CWM8A2gjdEyjJaMqP6HXYipIhFing=;
        b=Fa3zj6hW9sIRxlXf6VXElo5i+S6Ja0/fF1QfBk4PlRwqksuuoxFwNPPm3npuLae7es
         oc8olMVnlGy9ZvYrx7B4fWPGY7qmc3mTfo8CKPEVziIT+8voAd/7mlZ3MWV4euM09P/N
         dboioP86vYewMQG1f6i28mmJdVkPgVCfCvhyhclZSEIhA3r8fpObzHLPGc9F9cdBHAIE
         pSW1EZLUut+YQgvrnb9aEB1HSgq6IJNqeFEq3juHEbG2ly0Ov58KfM2unfevbTc0GD2B
         ej3GxrC5z5UGhh1LjkObevS2Eddkljs1g6KfisK1UIaMKSl4n2MG5cdPl/d9K57Jm2uJ
         QY/w==
X-Gm-Message-State: AOAM532w473pQGq9bgmFlqgDe5UX5ZExwPFxu7cFU/Z57kBPsCEbccNC
        wNA/hVUzJqHI0+aVD/4oVl5AzYl0/ZE=
X-Google-Smtp-Source: ABdhPJwyNcQmM32rOvoMzS/aoeSzi1yoMPWi1FNpJIe7V2qTPrxh4paATZUJ9nWdyWeXv48N/ntVqw==
X-Received: by 2002:a1c:dd8b:: with SMTP id u133mr890660wmg.107.1605998822937;
        Sat, 21 Nov 2020 14:47:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:4ce2:b4ff:20e6:17bc])
        by smtp.gmail.com with ESMTPSA id l14sm4830406wmi.33.2020.11.21.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 14:47:02 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] remove unneeded REPEAT_SYMBOL_CLEANUP
Date:   Sat, 21 Nov 2020 23:46:56 +0100
Message-Id: <20201121224657.96038-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121224657.96038-1-luc.vanoostenryck@gmail.com>
References: <20201121224657.96038-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Since simplify_memops() must be called unconditionally (see [1])
it's useless to set REPEAT_SYMBOL_CLEANUP (at the condition that
REPEAT_CSE is set instead).

So remove it's definition and set REPEAT_CSE instead when needed).

[1] 6b5e7cf5ac39 ("cfg: call simplify_memops() unconditionally.")

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 flow.c     | 3 +--
 flow.h     | 1 -
 simplify.c | 7 ++-----
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/flow.c b/flow.c
index 162c27346def..1a871df16bd5 100644
--- a/flow.c
+++ b/flow.c
@@ -457,7 +457,6 @@ void convert_load_instruction(struct instruction *insn, pseudo_t src)
 {
 	convert_instruction_target(insn, src);
 	kill_instruction(insn);
-	repeat_phase |= REPEAT_SYMBOL_CLEANUP;
 }
 
 static int overlapping_memop(struct instruction *a, struct instruction *b)
@@ -559,7 +558,7 @@ complex_phi:
 	insn->phi_list = dominators;
 
 end:
-	repeat_phase |= REPEAT_SYMBOL_CLEANUP;
+	repeat_phase |= REPEAT_CSE;
 }
 
 /* Kill a pseudo that is dead on exit from the bb */
diff --git a/flow.h b/flow.h
index 19a743c83b94..c3461c8c33bd 100644
--- a/flow.h
+++ b/flow.h
@@ -6,7 +6,6 @@
 extern unsigned long bb_generation;
 
 #define REPEAT_CSE		(1 << 0)
-#define REPEAT_SYMBOL_CLEANUP	(1 << 1)
 #define REPEAT_CFG_CLEANUP	(1 << 2)
 
 struct entrypoint;
diff --git a/simplify.c b/simplify.c
index 4d0adf444e17..465624f72677 100644
--- a/simplify.c
+++ b/simplify.c
@@ -259,8 +259,6 @@ out:
 static inline void rem_usage(pseudo_t p, pseudo_t *usep, int kill)
 {
 	if (has_use_list(p)) {
-		if (p->type == PSEUDO_SYM)
-			repeat_phase |= REPEAT_SYMBOL_CLEANUP;
 		delete_pseudo_user_list_entry(&p->users, usep, 1);
 		if (kill && !p->users)
 			kill_instruction(p->def);
@@ -338,7 +336,6 @@ int kill_insn(struct instruction *insn, int force)
 
 	case OP_SYMADDR:
 		kill_use(&insn->src);
-		repeat_phase |= REPEAT_SYMBOL_CLEANUP;
 		break;
 
 	case OP_CBR:
@@ -1715,7 +1712,7 @@ static int simplify_one_memop(struct instruction *insn, pseudo_t orig)
 		if (def->opcode == OP_SYMADDR && def->src) {
 			kill_use(&insn->src);
 			use_pseudo(insn, def->src, &insn->src);
-			return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
+			return REPEAT_CSE;
 		}
 		if (def->opcode == OP_ADD) {
 			new = def->src1;
@@ -1751,7 +1748,7 @@ offset:
 	}
 	insn->offset += off->value;
 	replace_pseudo(insn, &insn->src, new);
-	return REPEAT_CSE | REPEAT_SYMBOL_CLEANUP;
+	return REPEAT_CSE;
 }
 
 ///
-- 
2.29.2

