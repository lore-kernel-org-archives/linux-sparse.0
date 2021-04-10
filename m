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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F8C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4ED961185
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 15:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhDJPQw (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 11:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJPQw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 11:16:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7189BC06138A
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 08:16:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z1so9895620edb.8
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYjZLC97ibaDg5zAKc9aaGv4F4I9VPERVnfrziDw09o=;
        b=iwakoV/Ww+MOIS4GDwgYO98w6i2f5S0BKORZGeP0Wo2be+Cr6c6LQDZmIKeRYhIf7w
         dIX2OvzG3Yd7ekhWfEwpT5B8Uj552O31YUMfDlFl5mzp2kC6Ry5xKZBJNAgT7/8BnL0o
         unejc5343nrIvojxD3CA4V1WER3EMdwnPhKUK9AMHmyCtnRz/Cy/ZjpfVK1rBpDw7yHS
         n4dX81CqGDs6RKDpdIJvdJBZfjlvCoSl3724SDcEGQYgqN4Rb4/e7ImBn3ZPoi21tMx1
         Zka3X0s3JZ4Bx6bhw99zs/svaonmvWQ2+yzBrX15eMyq+7dYfshn+irXhXf7SX4qjpBf
         Vj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rYjZLC97ibaDg5zAKc9aaGv4F4I9VPERVnfrziDw09o=;
        b=t6jh4Y2hR0YqYU1FSdaAvPfU7KXan3au27+J8YNLwZrrxGyyIluWl3rmurOHj18eqU
         n93DMvRdw2do/gO5sFYPedgfxoaD7+47MFDUp/fhOHJG0l53WjCBDIW3MmpXPdXtUzXV
         v6gYxBHonCLrnxPT2ZnU1DN0189IDMccP8nn/5c6QNpZLvibVkC1hcOJ4cFMGiA3m3F0
         4MmE9dljrt47SnGMF+pVQkeWw0N8dUWNyVfCVLrwYtkDKCjeWuYfUjUEj1P3wktYAsvU
         vY397/4cfFgaSZTFKqFY88rz7lstZRVOQDxpsG6Ckbu0JO6ta+U4Xo1iqtfIQ0lZbu2X
         X2mg==
X-Gm-Message-State: AOAM530VYxd3pSV2ASnx6/MqJOWm/RVPmUPrkdXycC2wGkdk7d7mDt18
        roTO4ZMAsr+s9XKlQT1i8kO9D/C4jFU=
X-Google-Smtp-Source: ABdhPJy4NkKpa8QaeSV/pz/vlJXWce7x0oz38sLhdiYDFa38iNH1UQX2wGzsjq4N/KS8TPCxpdgh7g==
X-Received: by 2002:a05:6402:17af:: with SMTP id j15mr22394621edy.50.1618067796226;
        Sat, 10 Apr 2021 08:16:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:51b1:b3a4:3dfe:8baf])
        by smtp.gmail.com with ESMTPSA id o26sm2729352ejx.90.2021.04.10.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:16:35 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] linear: only allocate call instructions when needed
Date:   Sat, 10 Apr 2021 17:16:32 +0200
Message-Id: <20210410151632.55221-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

When linearizing a call expression, the corresponding instruction is
allocated very early:
- before the valdity are done
- before the linearization is handled to one of the specific methods
In both case it means that the allocated instruction is not used.

Fix this by doing the allocation only once it's needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linearize.c b/linearize.c
index 7248fa56b2ef..cf87545c7a18 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1533,7 +1533,7 @@ static pseudo_t linearize_assignment(struct entrypoint *ep, struct expression *e
 static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expression *expr)
 {
 	struct expression *arg, *fn;
-	struct instruction *insn = alloc_typed_instruction(OP_CALL, expr->ctype);
+	struct instruction *insn;
 	pseudo_t retval, call;
 	struct ctype *ctype = NULL;
 	struct symbol *fntype;
@@ -1554,6 +1554,7 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 
 	ctype = &fntype->ctype;
 
+	insn = alloc_typed_instruction(OP_CALL, expr->ctype);
 	add_symbol(&insn->fntypes, fntype);
 	FOR_EACH_PTR(expr->args, arg) {
 		pseudo_t new = linearize_expression(ep, arg);
-- 
2.31.1

