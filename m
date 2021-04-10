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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E6BC433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F61861027
	for <linux-sparse@archiver.kernel.org>; Sat, 10 Apr 2021 22:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbhDJWbR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 10 Apr 2021 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhDJWbQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Apr 2021 18:31:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C620C06138B
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:31:00 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so14189592ejc.4
        for <linux-sparse@vger.kernel.org>; Sat, 10 Apr 2021 15:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4CotMeQ5qPPDYqW9tfxhbyxy84tUItExmb2zJwdXgv8=;
        b=ocJhGLjVP+DiyyESfBdwlPjp+aqeScWSV01m8A8PBLe1jqlbYT96jXpXRB2mzeXum7
         4i3XlfrlQy5adg5oGuhOlyHHYEQko0ShqlLDe1NxVNJecpGI/dEU7DL+zFUiBFYW3Vp3
         JVZHtE5wvepRH/gMo9CvsT3p/eovs74MAi+PZqxR86F/0B79vtA9k+9reikuiHRwlHF9
         hcd1y5hTPSJrUITyDzz+49pD0Yfn4LEkak2SlLl9qzlBx9HvK8rQBcH06pipl2roS+Rl
         EZIwsX2xuW48mcZC/2cWWbJhRfd0SXdSqLpvHEeC9BXVONWAVuy/XK+q/DRoCGHcEs92
         kTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4CotMeQ5qPPDYqW9tfxhbyxy84tUItExmb2zJwdXgv8=;
        b=ljdJLKAnzMzzmytxsTFP5FGXFTpRQTQtfJG4pFxT4KjUPrU1kw0TySgSaZNZSxBSAr
         zFmJ2PRmnpBHYza5y3lTlZ1LJ/p0/smBoW+Xjv2Q5jwW1sQmSKAhRihik8ysPE17wWxF
         62+YJvEI/vEhsm+4UdB5AS3oJsQhIp7NMNhmahmS24WOBL1RL+/M/7Hk+dD9fXduERbl
         EaSbcWwc6nEO+5RW5wYe4x8Qw5IZsTDDuvV43LDhMXmrAwHFGWUN7gQV/u+apIeAl3J5
         2Sd7ik+nMDzvvoHgv5nr3r8zxxGw3UtrrP6MXdXDiExcOhcNBOprNkaMC+8YUsJOq7cx
         UIoQ==
X-Gm-Message-State: AOAM531QyY/VEuQ+O+w6GbJbDVtWC3UnhicFFD7vKmllAbhJsSJLq+hn
        f8x8MHdMm6n4PCcbNsNFDs18sJ14wVQ=
X-Google-Smtp-Source: ABdhPJwYfQ12zUeXfHLiMAGCfmtLXXVuqYlqgKQi9LVeyCiTgSHx6ZOKcFl0H1o9RgjtBt8D5+Y2Xg==
X-Received: by 2002:a17:906:3643:: with SMTP id r3mr21010921ejb.527.1618093859458;
        Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9597:4a1:b5b6:4666])
        by smtp.gmail.com with ESMTPSA id q18sm3701372edr.26.2021.04.10.15.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 15:30:59 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 5/5] kill redundant stores (local)
Date:   Sun, 11 Apr 2021 00:30:44 +0200
Message-Id: <20210410223044.86100-6-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
References: <20210410223044.86100-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

A store is called 'redundant' when the corresponding location
already contains the value that will be stored.

This patch removes such stores in the case where the memops
which make them redundant is in the same basic block.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c                                  | 5 +++++
 validation/memops/kill-redundant-store0.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/memops.c b/memops.c
index 44d90754d279..f734f6eb7398 100644
--- a/memops.c
+++ b/memops.c
@@ -213,6 +213,11 @@ static bool try_to_kill_store(pseudo_t pseudo, struct instruction *insn,
 		/* possible partial dominance? */
 		if (dominance < 0)
 			return false;
+		if (insn->target == dom->target && insn->bb == dom->bb) {
+			// found a memop which makes the store redundant
+			kill_instruction_force(insn);
+			return false;
+		}
 		if (dom->opcode == OP_LOAD)
 			return false;
 		if (dom->is_volatile)
diff --git a/validation/memops/kill-redundant-store0.c b/validation/memops/kill-redundant-store0.c
index e911166dd953..8819938fe763 100644
--- a/validation/memops/kill-redundant-store0.c
+++ b/validation/memops/kill-redundant-store0.c
@@ -7,7 +7,6 @@ void foo(int *ptr)
 /*
  * check-name: kill-redundant-store0
  * check-command: test-linearize -Wno-decl $file
- * check-known-to-fail
  *
  * check-output-ignore
  * check-output-excludes: store
-- 
2.31.1

