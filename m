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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36935C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 24 Jan 2021 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E842E206BE
	for <linux-sparse@archiver.kernel.org>; Sun, 24 Jan 2021 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAXQaE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 24 Jan 2021 11:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbhAXQaD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 24 Jan 2021 11:30:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B20C061573
        for <linux-sparse@vger.kernel.org>; Sun, 24 Jan 2021 08:29:22 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j18so8517003wmi.3
        for <linux-sparse@vger.kernel.org>; Sun, 24 Jan 2021 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cn/MoD+LUqYoRUN1enlL+3wc5Ew4Pu63nsYVnBKEEtI=;
        b=ByQ7rEPuW71TRqW/TCmOt8NvnidToaUKbOB3ao2QztPbVnBCu/6mBtI5m3d3QTOtif
         rlucLxvF7lbdxYoFq1/i/jSO+/AebT2/KmOwoul3OIRbWmh/+z+8SBscEIiE6pvVyzOh
         dis14VBA4T/4jz11GbdDgk6AC3Es7h1bkkLwv8ZW9HFtd5Jlvmlsk6FkGYKucG3gHUpX
         N0T5ATDlA/VjntMLlcVZXymnBFCttN2+5cyWRkqXbDmlmSyCjUMF5sR7lgjSyaR/fd6T
         e/+/y19qXy6ddPonExvBWsYps//S6ZSGdehOas/farSFK/FrVf4EGCPNASCicCTLpHBH
         rh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cn/MoD+LUqYoRUN1enlL+3wc5Ew4Pu63nsYVnBKEEtI=;
        b=fRGEAuYi81jiWxCk/1SGjMPeI/GgvAgiEQtC11dl3JQ4Uj9lX1ZT+mCA+gvhv20BOJ
         ZwGQKzisDmrKsg6Lamnc2an+9zUj/eqbt/sxE3iLMj4Ah3QSvj07cW+t/jQo9TFtyrpB
         aEYpz6HC4/J/cJaCToVEzYYhVRMADBqVHFBw5pom45X5hv/yVhV0rxlmB0FbOtWzqA6E
         vqpqFPBTiRBuE1xkrUzSNhfvipjVdmiNQqIMMNgWvcF65BVwxiyrd1W19CmRVtYHwtDM
         Q1xKxdlCa8N01f1y3hETKnOO+sssHge7UQf6RwKK0IqzSkWogv5049t2QZb1HyaOQAXN
         GE7w==
X-Gm-Message-State: AOAM533kmbRAwBoV4V9TnP1l0Ox2YALsCE9PmZc++NRHaLuGxu9oonte
        XdYfxpxv0I2R67v7lbvamt5Mk4UkeE8=
X-Google-Smtp-Source: ABdhPJzHU3OrX9FdgHUexquH9STxBRbzWBe4du6zmDYVs1VLIY6lESqrtZslLtBoG+snqDFHc2c9uA==
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr1315284wmj.151.1611505761580;
        Sun, 24 Jan 2021 08:29:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:d8b4:6ee7:d046:9e07])
        by smtp.gmail.com with ESMTPSA id c2sm18628002wmd.10.2021.01.24.08.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 08:29:21 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix possible circular definition with can_move_to()
Date:   Sun, 24 Jan 2021 17:29:15 +0100
Message-Id: <20210124162915.9711-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

can_move_to() is used to test if it is safe for a given pseudo to
be used by some instruction. This is done by checking that the
pseudo is defined 'before' the instruction.

This should, of course, reject the cases where the pseudo is defined
by the instruction itself because it would create a circular definition.
However, this special case was not checked.

Fix this by adding the missing check.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/simplify.c b/simplify.c
index 1e7648486c49..0bb66bedf463 100644
--- a/simplify.c
+++ b/simplify.c
@@ -1606,6 +1606,8 @@ static inline bool can_move_to(pseudo_t src, struct instruction *dst)
 		return true;
 
 	def = src->def;
+	if (dst == def)
+		return false;
 	bbs = def->bb;
 	bbd = dst->bb;
 	if (bbs == bbd)
-- 
2.30.0

