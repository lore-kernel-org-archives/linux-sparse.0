Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE1C433E6
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DED64EBE
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Feb 2021 22:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhBUWfi (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Feb 2021 17:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhBUWfi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Feb 2021 17:35:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86316C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id e13so22987575ejl.8
        for <linux-sparse@vger.kernel.org>; Sun, 21 Feb 2021 14:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5x1nLfWP0Vup/plTmgT3qro0B/XKuvCKJ/spykxgyI=;
        b=Haus3we85HE9vifDPjCYQuGvGorHLu4ehMjaiNZLhHh2ubKwGtdgnhK7n/dOXmpmt2
         u0dB+b2VQ6HX5mzV5m5ZZmCaMtkEbLRuAROsXUf0ZeHvKEgdBtJRgCgxgWcBtD+SRwNd
         FHEetMzh3eWWCoTsV0EI01tUNdxGRkpjkn3vMAiPn3NrHkRYXBU3N7PAgy9h8+CxenM4
         0uzA0cHNZ8UEQl7Hl9xe7WEgBqeSdrKH9ue7VAvhlDTXs56DDs50ws3gFsKfKOTWvyQs
         V7KOI0HkoJ9yvFoFVvTdhGmpblw1R7K22scOlQGWrpIri3WxqzQZAqWCZwPa8OgMqCS8
         yDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K5x1nLfWP0Vup/plTmgT3qro0B/XKuvCKJ/spykxgyI=;
        b=CHNJNhc5D7cGEj3WRP4Z1H4URA1zTnid0aKo8YQ+cIj54PBorjdlh5vwauuiFKGvDW
         WqSdyraigfES/8W/PsGFQswKrIDo2KC0SN+YRcCDfvEzDPLR7/QNhwOXyDOw0mps96Mw
         z4S6Bo6u+Q5GJtRxB8VnRWPq7RLlbDQIKTHNPxBZrUxdEbC5STpwYR959czwPeQks5LM
         9tmQ4OqGAWoQdqezexAs5toBBGSPTMOck0/fesbRoH3dJ9DMe/c2DOfgoFSfM/ZjF0Bh
         4/TLmQS4ezsCjm2K7XpdTiQYtNPd51I1tubjpCjLBD27udIUBvswZkxOuKGvNj1LYcJA
         ZlRA==
X-Gm-Message-State: AOAM530/ctLvudFPALwBiwpupqkx4IQmFUjAslf+hL/wiR9I4X1egbhK
        gtRAgjXCX76RnjzL4xV85ZMKa526HPA=
X-Google-Smtp-Source: ABdhPJwm65gZR4TJL5vMx4yGqiFgWxTCm/9hiYIzfcosurBJ3DmQQRhki8U9wV+52NRMo0RGcORpyw==
X-Received: by 2002:a17:907:3fa6:: with SMTP id hr38mr18509576ejc.24.1613946896375;
        Sun, 21 Feb 2021 14:34:56 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:9463:3f6a:e4eb:cf54])
        by smtp.gmail.com with ESMTPSA id p2sm10433622edm.94.2021.02.21.14.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 14:34:56 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] teach memory simplification about ASM instructions
Date:   Sun, 21 Feb 2021 23:34:47 +0100
Message-Id: <20210221223452.8075-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series fixes simplify_memops() which didn't took in account the
fact that ASM instructions can also modify the content of the memory:
either because it contains an output memory operand, or because
it explicetly clobbers memory in some other way.

Luc Van Oostenryck (5):
  reorg dominates()
  asm-mem: add testcase for missing reload after asm memops
  asm-mem: does it clobber memory?
  asm-mem: does it output to memory?
  asm-mem: teach dominates() about OP_ASM

 flow.c                           | 17 +++++++++++++----
 linearize.c                      |  9 ++++++++-
 linearize.h                      |  2 ++
 validation/mem2reg/asm-reload0.c | 14 ++++++++++++++
 4 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 validation/mem2reg/asm-reload0.c


base-commit: 2494587e823700458923052b17b0b981be92d776
-- 
2.30.0

