Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2EBC433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE8322B40
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgLDRQv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgLDRQu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 12:16:50 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86975C0613D1
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 09:16:10 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id n26so9742002eju.6
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYT43gApx+COI5Ydq5+Mjbmsfbho5+vkN0i1J3yd8ok=;
        b=bHz5voalS5QGnD2anxXEHHuZ/im2yCCWHwXoDu7S+RZvDQGPbYD2/sFdqMDw9aykKI
         XNTRenC+nLsK+qjy3IJk3T21AVjAgRsjEzuiUnaPpi4GCPjjvSquT5aKFmSxjvwvnFUC
         Hxx9OchoO509eBSpX2CEqga33RLHHGNP/wsAnnPr6zukxx+E2Te6ooZFmg36n1YYk/wI
         7HbCg+WF+o/vPzPNoIVrnqSIG8ZnMPncKKmL3oD3Ck7+yCRpMQZrqJ0mN+WFYKCjtC7V
         1ubVAjBo+O2Iqo/k4aIdtPlNgJaVdqrgVQNrdl1+yIiXub2038adNpjdPho0My2XMLcH
         qXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MYT43gApx+COI5Ydq5+Mjbmsfbho5+vkN0i1J3yd8ok=;
        b=cd770jxMH9kMVX3C5pPLbtwD7ccXx+6iGILHGbRjeUAtUj9fIIYlclBXJsmCaEJTEx
         jVpaEUFuOhLTE/OusJvbWzQ9LKcu/xtgqHbc1wMJ5eIB6pzflkhTmqKB4lpm6Kn/SXvu
         N2zomXHg2yDpnZnVIV+tBLJzPFGIX4O4BArf7UDDPuteKkfUh0Rf9Gle6FlgMU8KufNg
         pnv4VqN/Fsm1lFBt3tx5oMELYLLot1Y83WmoPw+Z32vYdl723O9bOmJTIU/f8JXWseG9
         ANffonpEt9pxN0xH7UXp9kvtHPbTd8PqBAfgUgEDgf2JaziLDDX3eMZMu8ZKOAyv036X
         wB5w==
X-Gm-Message-State: AOAM533LzejgPCS00aqzZXbOMj8y/vF+KNx0bMmBY/nPfFwRayIgmAtZ
        tL/JzG0g2MaK5Js1qzYvEgdb7ukGP54=
X-Google-Smtp-Source: ABdhPJzXsvZqX9EsPLKwZtnbTUGGSmHBt+U7tZgdAtwlCMq8g+UVBYkU6Xpmumc3qnMTKLjhiy51Mg==
X-Received: by 2002:a17:907:2718:: with SMTP id w24mr7703648ejk.525.1607102168593;
        Fri, 04 Dec 2020 09:16:08 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id p35sm4024188edd.58.2020.12.04.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:16:07 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 0/2] cse: place common expressions in the Lowest Common Dominator
Date:   Fri,  4 Dec 2020 18:16:02 +0100
Message-Id: <20201204171604.69635-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series extend the current CSE by using the lowest common dominator
instead of the more limiting 'common single parent'.

It allows significantly more common expressions to be eliminated.
However, it has the annoying disadvantage of slightly making worse
the 'context imbalance' problem. As such, it's not intended to be
merged as-is.

Luc Van Oostenryck (2):
  flowgraph: add a function to calculate the Lowest Common Denominator
  cse: place common expressions in the Lowest Common Dominator

 cse.c       | 38 ++++++++++----------------------------
 flowgraph.c | 15 +++++++++++++++
 flowgraph.h |  4 ++++
 3 files changed, 29 insertions(+), 28 deletions(-)

-- 
2.29.2

