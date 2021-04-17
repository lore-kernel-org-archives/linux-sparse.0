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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3A1C433ED
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 13:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452EE61207
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 13:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhDQNc0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 09:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhDQNc0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 09:32:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24257C061574
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 06:32:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g5so39409581ejx.0
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 06:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRP88v0LdahBvgEHsgE/NFO4PODy1OZmCPjGb0bkT0k=;
        b=XUqLuEeN12lhn41qG9pLfYXfh7gIBcxdfY3u2KzBLy/iWaRN80Qz2DrGuUcALQeIl4
         XvIXHbz1pJoDT2UuGT8s9uYyLIkmIIHGrrzUh8dxp9esTkNVf1iTqbrPKloaYbFgm8kP
         zuGvKRzY9Fe5jELbgDgpymmX9ZfAFkN12SY7lPnJsPGNBTx3qqy9KDhbd0qhhCIKF3M3
         w6j1CPORfmky5gr6D9HgNt+h5v+NirQu+6XeIMVfFPujDGBlZk1dqjZADZU8EoT1l2wX
         JKG5iKHhRFklh1WGb6hF67BgmKceIBq7EQGG3a0dwplZ/vq9O21LHvMhGlVr/pGcwM/n
         07ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YRP88v0LdahBvgEHsgE/NFO4PODy1OZmCPjGb0bkT0k=;
        b=BWIuRKDox/hjvLdHcRWgNRni8Eu+ReimP6csT62q0M3fAP8XqIHAl05U2RsimL5rW0
         MTwxquuBzY/5fhra3XLYIp9M8nEYAOWgM/aupUK6qdWD6DyqSMScGsuQpm7o5jk5dBKx
         4do5tSn6EJ4o8tWY6HTX0w3fdIxbCxXLg5GfrWTYmyIjAJYOrDAYThI4lHqCkNP+vJLf
         wz5AUOX5Qo3+YVF9udZL5PaLxMo2Hmq/GBWkSDrCsYbo7lmMUj9IBA5/mVlVxPtAFUcK
         UVmh82VNe/UBiHOVcCLEwKgQBP/Ez1oRDmIwkWVcN8bQlK/hrMWE7mBCNR3nWmOYgVwz
         1NJg==
X-Gm-Message-State: AOAM531s0m45+kgB/ahWXSus5xEq/H5v+aOVB4XQ+IbtwsDtS4ZmE+Hg
        mVfZ2Jdoiqk8mtBzBUpUt82PwxsRddw=
X-Google-Smtp-Source: ABdhPJzgKq6fFMYpEZWpIbPnidSLIOqUCG51j35LiE54HJfe7U777qssXTI6J7rUBjcWnYx4O6O09Q==
X-Received: by 2002:a17:907:1624:: with SMTP id hb36mr12888442ejc.273.1618666318924;
        Sat, 17 Apr 2021 06:31:58 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8963:a610:329c:c1f5])
        by smtp.gmail.com with ESMTPSA id ca1sm8298459edb.76.2021.04.17.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 06:31:58 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] no needs to use MARK_CURRENT_DELETED() for multi-jumps
Date:   Sat, 17 Apr 2021 15:31:54 +0200
Message-Id: <20210417133154.53987-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

MARK_CURRENT_DELETED() was added for the case(s) where an element
must be removed from the list but the address of the other elements
must not be changed. In this case of effectively removing the
element from it list, the element is 'marked' as deleted in the list
and the list walking macros will later take this in account.

However, this is not never needed for multi-jumps.

So, use the usual DELETE_CURRENT_PTR() for them.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 simplify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/simplify.c b/simplify.c
index 9e3514d838a9..30d053f708e3 100644
--- a/simplify.c
+++ b/simplify.c
@@ -2651,7 +2651,7 @@ static int simplify_cgoto(struct instruction *insn)
 				continue;
 			remove_bb_from_list(&jmp->target->parents, bb, 1);
 			remove_bb_from_list(&bb->children, jmp->target, 1);
-			MARK_CURRENT_DELETED(jmp);
+			DELETE_CURRENT_PTR(jmp);
 		} END_FOR_EACH_PTR(jmp);
 		kill_use(&insn->src);
 		insn->opcode = OP_BR;
-- 
2.31.1

