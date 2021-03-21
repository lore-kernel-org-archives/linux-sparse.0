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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C50C433E1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA3961937
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 16:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCUQS0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCUQSQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 12:18:16 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8960C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b9so17383918ejc.11
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iCsFKI9TUgdSg1jVahlz/s+ILL2yniqy6o05AhOsS0I=;
        b=RoKk+FdsGk00WzygtKkgCQvvj1Dt5h6PVh9M5rp840QP1Ev1PO9XBdRyBql6eGJhI1
         aFjd3+Vw5rKDyWoXtaMCYj0r2QifNgTH8IXYwn7qg0UBKV/JmUX8neHV5hv0AT3ZRiEv
         JTyR/QejzM6VXCz8+wQOB748+L3FgSyUxHGRmDa3SlfVRnZJC82l1ygpoaI4zKN0ekQ3
         QGCi1S0cN3nm/DfUssmLJskb077F+XN08SuwsaFENL8z6696qDohVxGSzECqTqObB4Hz
         785nQMb4EtUalAq4aRHjpL45zT6ZEv+pPDa74T9EL5QpYTQTE46/dWCxzTZaL20lyPRe
         qzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iCsFKI9TUgdSg1jVahlz/s+ILL2yniqy6o05AhOsS0I=;
        b=B/1Pd8swMbC+xykwCXxOQEsr5TzkppSLmDRCAU5tLwj++SCT2aZKV+iZFyp+/MJkaN
         1iJ7AfYVa8UIiRrtYnI+3fX5EBI8SbuBI0wi1mPtnJ9pgxS5O8V4a08wobz8Y5BunIx/
         /h8O3FALdqus0kDnJJK64VQJFlD4JlIRk+jmB+2aG7nU1LPvE2uL/mEpx0/7ipgg5i8f
         XQvPZOE0Sb/xkzWErE/Vvgg6PEbVCi5/x5amr+D4+dye7K2vaDnii2/c6sDZrrmQKAq3
         gUQx6+YS56o0H/W4MyTm7sWlGmGkexSwDNXMQqXGrBM8px3N920BfzPimrHDMzVVrAtG
         z9ww==
X-Gm-Message-State: AOAM5310iaqP5JvEyfKJyYxiOAN+TIbeXyYRJPlsL99fwHaut8qMInV+
        zAsrtZxqw7qI2egqKiOr/xiLRM6/IXU=
X-Google-Smtp-Source: ABdhPJwUuRApPPdcwX5uqFYYBjM5FcGUDsWSJLDJMN28y5KNyCNXKI08Uy3fLnux9K/l0liW92fabQ==
X-Received: by 2002:a17:907:9611:: with SMTP id gb17mr15458067ejc.325.1616343494407;
        Sun, 21 Mar 2021 09:18:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id c20sm7390295eja.22.2021.03.21.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:18:13 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/6] let insert_select() use insert_last_instruction()
Date:   Sun, 21 Mar 2021 17:16:06 +0100
Message-Id: <20210321161609.45905-4-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
References: <20210321161609.45905-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 linearize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/linearize.c b/linearize.c
index e6aa01f1b9fe..4787689b37b8 100644
--- a/linearize.c
+++ b/linearize.c
@@ -697,11 +697,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	pseudo_t target;
 	struct instruction *select;
 
-	/* Remove the 'br' */
-	delete_last_instruction(&bb->insns);
-
 	select = alloc_typed_instruction(OP_SEL, phi_node->type);
-	select->bb = bb;
 
 	assert(br->cond);
 	use_pseudo(select, br->cond, &select->src1);
@@ -714,8 +710,7 @@ void insert_select(struct basic_block *bb, struct instruction *br, struct instru
 	use_pseudo(select, if_true, &select->src2);
 	use_pseudo(select, if_false, &select->src3);
 
-	add_instruction(&bb->insns, select);
-	add_instruction(&bb->insns, br);
+	insert_last_instruction(bb, select);
 }
 
 static inline int bb_empty(struct basic_block *bb)
-- 
2.31.0

