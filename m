Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF891C433DB
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F6B61946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 12:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCUMfV (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUMfO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 08:35:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0219C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so16026430edt.13
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igDNTyjKfNsZiUmxaWl52W4u0zoV1VWZN5WBIATXUzc=;
        b=KCJz47T5Mwr4X9p6R5FxVN26JNA15Ww+e9K5iuDVSp12gxT5NH36QCD6Q+BptTmzqR
         a4H/fv3rKYvmY5I23ZZkA+K6JcuKyofghb687Ll8mclKTZo11ULMjN5uOEOfWVa7SVbJ
         zLvZcSdDgClXH6NvAqPFlCEKorLY7spkRTzeN0yj4uxf+70CtcLB2pHf8Qy/aecJDVri
         ZSexM9GsnyACqP2bcdz1i+PYp1LjMZKZJczUf3bvR9iAdDp0XAHpkyS7TjHtSHu1qWr2
         KqBkYSvJEOvd0w+XQdWClF47mA5Fi9pf75cFF91xQQB1LaJgmwhdMA4n9MFS+KTUs8Kn
         Npcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igDNTyjKfNsZiUmxaWl52W4u0zoV1VWZN5WBIATXUzc=;
        b=JERSL8bPwuhzgZvX2NNo2IWQpB84/zLn2s5nj42eZKaAg1lwTbjupWqOsBIra3nA/+
         ycX7QNUdio8VR/hKhflplTXsKWhm36iITXOgHb5MMBR90EiuLyBAm+tatCB79AEBbW3K
         swnd8H5xyPD4OA3yPLWKCguy8PT6ikq7TuUkEQoh37KZa2VczyYVXLfTF2ROLrxsPI+C
         NaR1d7YTPzH0Y4ek2qj6kKO1Sbxg2l6tsMWmr2ly6wYLucSrcXxQUxzSiRZwEP4zdime
         uuySl8zKaUNtAm4KzPDU5hQrSCCow+AwfgzGj7mH/9ETCjUh69vSjXzdWX5r02d0D0gN
         UCng==
X-Gm-Message-State: AOAM532Qyyh/Ubpjktqf206tQYVJAJZMW1nFjIYZ9sACpiN5sZHmZpRg
        DCUGyU+nEJhIm6TTBaRRVKLFXdpEr8g=
X-Google-Smtp-Source: ABdhPJxqlr7fy21sVHtGDi5N8GIjuzpUvmQ+BtVKA5AOa9wD51JqH10RZJ7Kjx3TodwTerPk2DyZHQ==
X-Received: by 2002:a05:6402:30a5:: with SMTP id df5mr20566040edb.24.1616330111678;
        Sun, 21 Mar 2021 05:35:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:b090:4406:df97:c155])
        by smtp.gmail.com with ESMTPSA id jv19sm6998641ejc.74.2021.03.21.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 05:35:10 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/13] remove phi-sources from removed branches
Date:   Sun, 21 Mar 2021 13:34:52 +0100
Message-Id: <20210321123505.27993-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series, after some related and preparatory patches, contains
fixes for the problem of phi-sources being left in place after their
corresponding branches have been removed. This results in situations,
for example, where a phi-node has 3 arguments/inputs/sources but only
2 parent BBs and create all sort of problems, like:
* some dead code is not removed
* some optimizations involving phi-nodes are blocked (if-conversions)
* more importantly, these phi-nodes are invalid/meaningless and so
  it's impossible to reason correctly about them.

Note: This series only fixes *some* of these problems. Other probably
      still exists, especially when rewrite_branch() is used.


Luc Van Oostenryck (13):
  Revert "simplify CBR-CBR on the same condition"
  add testcases to check if phi-sources from removed targets are removed
    too
  remove insert_branch() redundant arg
  simplify remove_parent()
  fold remove_parent() into insert_branch()
  let insert_branch() reuse the terminating instruction
  move insert_branch() to flow.c
  let insert_branch() return a status
  rename insert_branch() to convert_to_jump()
  add remove_phisources()
  fix phisources during CBR-BR conversion
  use convert_to_jump() when converting a CBR with same targets
  fix phisources during SWITCH-BR conversion

 flow.c                          | 205 +++++++++++++++-----------------
 flow.h                          |   3 +
 linearize.c                     |  36 ------
 linearize.h                     |   1 -
 simplify.c                      |  34 ++----
 validation/optim/bad-phisrc1.c  |  15 +++
 validation/optim/bad-phisrc1a.c |  23 ++++
 validation/optim/bad-phisrc2.c  |  16 +++
 validation/optim/bad-phisrc3.c  |  20 ++++
 9 files changed, 184 insertions(+), 169 deletions(-)
 create mode 100644 validation/optim/bad-phisrc1.c
 create mode 100644 validation/optim/bad-phisrc1a.c
 create mode 100644 validation/optim/bad-phisrc2.c
 create mode 100644 validation/optim/bad-phisrc3.c

-- 
2.31.0

