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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BADC433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FCE61947
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhCURJG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhCURI3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:29 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522EC061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h10so16529437edt.13
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlKgS8okPEknJRnDBRtjMVSR0o1/pphCbVaJfk7IUEE=;
        b=Sh5bo4oPPPP+cPRkoCzbT2faUdSLOcjYcgBuQTZeLfam3FXqkCvJ8IhdQYioEPu48s
         yJr1RtDiq6x3Y3/VlgwtYPs+Yh+rwcrIw9L22Qy067Q4wjDXW+ibkrZBOa0MnqPZ1MSd
         BavF5s3w/jhcGOGgmtLWqdPbMXDrNMdSMWBurPgFxGZLgr8fzkQPj8FNmKHFBFKzTYwz
         HujtFZ2WS8naszs++wMz9SUgFotqtFpHd8UJgOD/Rt4ku+0L+OW7R+tSxwzRBWnKq/AL
         tcJcSklPXQOz9OcI9ow0V2+7Im0aTtqwFNGNI47uRqgtlXLMzuLRewipN1dVglza+jse
         +A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlKgS8okPEknJRnDBRtjMVSR0o1/pphCbVaJfk7IUEE=;
        b=gAsedBr+uPMjGii91MbxLDpVwU9+vtDm6ZQ/OlrL6M9+WgMxhg+mvbY+PuwCMnT6SV
         vpGhG2xpMLuu45Po6C/GlmcXFZy7fK2UYISO9E0M4OKJQVSKZA5RzL4HhFIdr4gEJl9e
         0/kxcePOiBweR7tCQoXFP8Wmem1GNg1wb/NGqanXg0KaQGvgKfyct2q5ke2svjO6hEn5
         C1q9GOmDN2lm82EXGL7DVMmyWTbpGABwfTc/xSsdvodpT4ZtnxCRY8E+Jp2dLnS4vMAe
         kOcneoww9rp9CexU6DwrMfJfrkaI6uOwznrCpjnP1J0FwbAAEHw2KxSvrnOEYXbiZoeZ
         YwCQ==
X-Gm-Message-State: AOAM5320GkcYUnihMXUfNMID/qwac5yARoMOAZu7aeHh54btBcD875pF
        p2UBzPoMU4TddOhLvqIiIldvRVtkYRY=
X-Google-Smtp-Source: ABdhPJx5dlYIRS2fyIzWq9gHK+T3KS4B788ErrGpxC4rVqTjd4D5B9pI9mLUkrpsv8s8kCi/e8CShg==
X-Received: by 2002:aa7:d813:: with SMTP id v19mr21543890edq.213.1616346508333;
        Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:28 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] memops: remove obsolete comment
Date:   Sun, 21 Mar 2021 18:08:19 +0100
Message-Id: <20210321170822.46854-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
References: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The comment above rewrite_load_instruction(), about comparing phi-lists
for equality, was (most probably) written when there was some intention
to do CSE on phi-nodes or phi-sources.

However, such CSE is currently not an objective at all.

So, remove this comment.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 memops.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/memops.c b/memops.c
index 753eb3a7a914..5386c5a1f416 100644
--- a/memops.c
+++ b/memops.c
@@ -17,10 +17,6 @@
 #include "simplify.h"
 #include "flow.h"
 
-/*
- * We should probably sort the phi list just to make it easier to compare
- * later for equality.
- */
 static void rewrite_load_instruction(struct instruction *insn, struct pseudo_list *dominators)
 {
 	pseudo_t new, phi;
-- 
2.31.0

