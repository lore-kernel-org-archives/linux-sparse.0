Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF6FC433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343C5610F9
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhDJWbP (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhDJWbP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0088C06138B
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hq27so14152278ejc.9
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJxSWNJXLP4Klq0CxC6W/eeVgYRJ+EWbn2Ev/1pbFlk=;
        b=PPkvztYQaUzmQnOdKYBnHTa8AKANf/QgzP1D3o3hAZZWjXksibF1GlDyDU/oZVh9og
         IaDgFVYvMoKkCcrpaZ3iSJNriNT9r08F8jvDxeeFeVBItK7L9Z/Yuabf7PNSbbV+fque
         qd075wy1ke3+i65C1BnolXJHuZ1qP8nyxP6ijlsdlF0UBsIHQnCXn7T6nFd2nUCGuc9Y
         zeG5KojdZQdsTl6m3tIATV/RvN2lqMPbRMJu4lEs9DsPRm3h7nR28Asf3BkgnhfQnuM+
         nSRIF0Din4Mp0i2zfYunDreROE80ptK1dlPiw9tnN605ZUUyrkSC+3nDef3khUe5wkwE
         ep0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJxSWNJXLP4Klq0CxC6W/eeVgYRJ+EWbn2Ev/1pbFlk=;
        b=XKenM4z5FxABDzd1QqVtAzhIEOkglSRBj1vlawbJOPRu6Xh88mPQUjxA9GAIX+2zuI
         nUfkzxNeWMQ1gtG9lCzKVIqm2pBWRk6Jnca7lB52cmsNEvG0rqo7KlLoXlynAmIishYK
         heaWTYzBJ9QKAFGvj7WgGkGBenJuDOaj1/JjiBmzQwzvArUoZj5B2uL6hCUzJj39ydxO
         gyqs4/J0/IOPGLO6UPJWXUAqv2KqdzyA9/cqmV6jta1eeLCEGinBiaa2Qtr9+Wol6nh0
         MfFI9CHrXcSNpVApp5BG76hUwk3/OScdHUf0v2Y5HJaDjc0ITKCRVcFpWRxkiCotYM44
         Dw3Q==
X-Gm-Message-State: AOAM532ncxCWp2NmeMoC/+496iihDCcAzMBW66xYiKnhoblm6pWwg4ro
        g7C4I3oLZZD8depTDbyUNiC1AVr3Kfk=
X-Google-Smtp-Source: ABdhPJzMF0HONG2MGZLaEyHDs6PdsM9E0XDI0etqp3Sz0cIPPp2reRFykHo9pbWLLtC5eXaCF+ZIbQ==
X-Received: by 2002:a17:906:4017:: with SMTP id v23mr15316086ejj.421.1618093858740;
        Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] kill parent's dead stores too
Date:   Sun, 11 Apr 2021 00:30:43 +0200
Message-Id: <20210410223044.86100-5-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
References: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

kill_dominated_stores() identify and remove dead stores
(stores unneeded because the same location is overwritten later
by another store) only when both stores are in the same basic block.

Slightly improve this by also handling the case when the dead store
is in a parent BB of the "live" store.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                                    | 16 ++++++++++++++++
 validation/memops/kill-dead-store-parent0.c |  1 -
 validation/memops/kill-dead-store-parent2.c |  1 -
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/memops.c b/memops.c
index 8020f2e6cf03..44d90754d279 100644
--- a/memops.c
+++ b/memops.c
@@ -231,6 +231,7 @@ static void kill_dominated_stores(struct basic_block *bb)
 		if (!insn->bb)
 			continue;
 		if (insn->opcode == OP_STORE) {
+			struct basic_block *par;
 			struct instruction *dom;
 			pseudo_t pseudo = insn->src;
 			int local;
@@ -249,6 +250,21 @@ static void kill_dominated_stores(struct basic_block *bb)
 			} END_FOR_EACH_PTR_REVERSE(dom);
 
 			/* OK, we should check the parents now */
+			FOR_EACH_PTR(bb->parents, par) {
+
+				if (bb_list_size(par->children) != 1)
+					goto next_parent;
+				FOR_EACH_PTR(par->insns, dom) {
+					if (!dom->bb)
+						continue;
+					if (dom == insn)
+						goto next_parent;
+					if (!try_to_kill_store(pseudo, insn, dom, local))
+						goto next_parent;
+				} END_FOR_EACH_PTR(dom);
+next_parent:
+				;
+			} END_FOR_EACH_PTR(par);
 		}
 next_store:
 		/* Do the next one */;
diff --git a/validation/memops/kill-dead-store-parent0.c b/validation/memops/kill-dead-store-parent0.c
index 1413134b8c23..c1b2466ca450 100644
--- a/validation/memops/kill-dead-store-parent0.c
+++ b/validation/memops/kill-dead-store-parent0.c
@@ -8,7 +8,6 @@ void foo(int *ptr, int p)
 /*
  * check-name: kill-dead-store-parent0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-pattern(1): store
diff --git a/validation/memops/kill-dead-store-parent2.c b/validation/memops/kill-dead-store-parent2.c
index b563fd31b669..4f7b9dd901d9 100644
--- a/validation/memops/kill-dead-store-parent2.c
+++ b/validation/memops/kill-dead-store-parent2.c
@@ -19,7 +19,6 @@ l20:
 /*
  * check-name: kill-dead-store-parent2
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-pattern(1): store
-- 
2.31.1

