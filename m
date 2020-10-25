Return-Path: <SRS0=+N6z=EA=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63615C388F7
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218A5222B9
	for <linux-sparse@archiver.kernel.org>; Sun, 25 Oct 2020 13:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFW7cQmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416467AbgJYN7w (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 25 Oct 2020 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416466AbgJYN7w (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 25 Oct 2020 09:59:52 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3CC0613CE
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:59:52 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id 33so6692353edq.13
        for <linux-sparse@vger.kernel.org>; Sun, 25 Oct 2020 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rG5JGkbN/Y3fb3mMynx+fLU+r4TQWaPgC7GajnZ6Fv0=;
        b=UFW7cQmV5NyR5iveWjcD63oMF0uqKw4Q0hyP8phCCFNwmPR6/udigB2ux1dpLX5CoM
         dVs2qFOWt+nXv039UxEYnh009/Zj6/A8YccjJ9T7CiOv1WFzcQ5AhK32ZEl9EhNTHHWG
         vbbmOz2E6fUfwwLIzV5ID2toeK892v8UjfNyOX8q03Rj82syIAYrQe9FMo4MtWYtNb8W
         te0rdmmt4Y4hWe1ad81v9ivxgn90xACgqugbM4gAJLDvtPCsxu2MJsdHsH4IJ/Y6wKJa
         ++h86xmMjCjN1KplK44ZR28kvEp0Z+7pnUChix9TqidypZpx1qSq6NifwVI7UNRoU+XG
         WzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rG5JGkbN/Y3fb3mMynx+fLU+r4TQWaPgC7GajnZ6Fv0=;
        b=Q4jHBpGtTSLApEoIs119j1yOHHTSX97XFpuYRWaxQVBi1Md3x3vJoqrryTLcslhCrO
         2/nj+Hnhz12namfZav8mDgmcPsmbnRTl+4NC+TMVH5GHRr5QRobyIK0y6F0BFx2Ll2Fo
         zoZ5JO+cNXjz7IcEfU0mUSqyUJpOz3YUS3T1IB+dYOqGDCQYQc6GWZ3CVfqzQllXrKMs
         /rYEbPAH7zMZ3xhfq9wpdUUKMX0keL7uPdFrCpYYBl+2e2GKpwd9inBEJ7trobaN738J
         DqZ408vROe1SwLuIcGJinTdUJbF0NnGSoatKLpRG71OUp9YzWqg917zMzE7kzIXMt6na
         nqiQ==
X-Gm-Message-State: AOAM533UG7td6JzIM/9fk5NoKuy3UURCNk6gsBXk2khM9Jvr+fThZITU
        2CNlzyOq8RkM6N6BCDAbaxSYQw+TlKM=
X-Google-Smtp-Source: ABdhPJzoXsJ71uBt3BU1LUSqP/YbJ8D9+IFgNYmpMEloBlOsunhT+37dbTX9rnSDCTNZwodHiqFH1A==
X-Received: by 2002:a50:d69e:: with SMTP id r30mr11276137edi.383.1603634390578;
        Sun, 25 Oct 2020 06:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:f136:83e9:1c3d:13f2])
        by smtp.gmail.com with ESMTPSA id n3sm3638680edq.24.2020.10.25.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 06:59:50 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] replace nbr_users() by  multi_users()
Date:   Sun, 25 Oct 2020 14:59:47 +0100
Message-Id: <20201025135947.32822-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

During simplification, we're only interested to know if a pseudo
is used only once or more than once. This can be checked quicker
than getting the exact number of users.

So, replace the last call to nbr_users() by a call to multi_users().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 6caf6cbcf918..191c9e4928b2 100644
--- a/simplify.c
+++ b/simplify.c
@@ -871,7 +871,7 @@ static int simplify_shift(struct instruction *insn, pseudo_t pseudo, long long v
 				return replace_with_value(insn, 0);
 			if (nmask == mask)
 				return replace_pseudo(insn, &insn->src1, def->src1);
-			if (nbr_users(pseudo) > 1)
+			if (multi_users(pseudo))
 				break;
 			def->opcode = OP_LSR;
 			def->src2 = insn->src2;
-- 
2.29.0

