Return-Path: <SRS0=IUSJ=DY=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A58C43457
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C3F20897
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Oct 2020 22:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+RCJnKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439819AbgJQW4m (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439817AbgJQW4m (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Oct 2020 18:56:42 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33647C0613CE
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lw21so8703784ejb.6
        for <linux-sparse@vger.kernel.org>; Sat, 17 Oct 2020 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmXXOQipFiOyBy+ls3pRruv7phhu/Q60AkM4ue3USKE=;
        b=V+RCJnKtzL7uzIOoaBK4vtCISIh+bRFmXBNNMLzEv4GYCnbMOou/CB974UHCtkFopJ
         kmrFHbGsuxT3HjYm0WsQ1T/XuZcA+D+A7yHHXpfIYAio+toMxrnxmK32GoOLFuBgx+R6
         a2N33NcbZSrePwDikKiAuVTGVCoEQVbjlEiAIiVH/6gAnbAP0/79CIuRV1Zr2HgKyBvL
         +YbmT9BjF3AKqeaS+r10hwi9VvUaAfc8RKuBq0hvth4XnLWU+o03Ve4w4/ek9eHN39Dc
         Re5zNcGGtZ7NQWVgTqfAN6ErwGN5OUJZb8HeMKjRSvr4bQbbHeMog1KQSr1sT9hW8ir8
         GQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VmXXOQipFiOyBy+ls3pRruv7phhu/Q60AkM4ue3USKE=;
        b=htcJRfJNV6aseDiUqd682jeiUJSPpIaZ1FXW71l6Yr9m/sTbkrSnS4Em6jYCYy2SBu
         oSFr7tSHMdTn0dMNzP/3I+2nDhrYfUF+K9qirgGmiW19QiCcmN8tHrdZNpBi1z/JgwYX
         DrkRRc0TV9Pa6wXwom/OKIvBJWhzJYBOSiztw7j7gCc0/1Hj13/EEW00/sWAD86Zm8kf
         w/3nJcBTduxTcal4bl/RczKutOZDI2PHYHPjSwFuMlt2urNYz1naNZcs35lT6q9hjCY7
         ro1VoyBYUwxTe9ZBsOvyn0gm3cR2q9SD29ajk/rm7aUN4VEim3TAVFE8/kahYaOOOLpB
         ml1g==
X-Gm-Message-State: AOAM532WX5JE+xSyYatTKhFmArw8NJMvVDUWvUOXzkrL2FDjUmR6JOa8
        jJ6bO4v0PvkHUfnjWatdDpns+7aXpFc=
X-Google-Smtp-Source: ABdhPJw88NzHhKqN2vv0WSFbTEjlxayTf2daB4WT/IakKu7UPDakYYfbobeqzE2geuznz0ONsaekQA==
X-Received: by 2002:a17:906:3a49:: with SMTP id a9mr10627616ejf.95.1602975398358;
        Sat, 17 Oct 2020 15:56:38 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:c81f:df9c:7723:c5a1])
        by smtp.gmail.com with ESMTPSA id k26sm6129311eji.22.2020.10.17.15.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 15:56:37 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/12] fix and complete the evaluation of atomic builtins
Date:   Sun, 18 Oct 2020 00:56:21 +0200
Message-Id: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse knew about the __sync_*() builtin functions but without real
type checking and nothing about the more commonly used __atomic_*().

This series fixes by adding the full type evaluation for both sets.


Luc Van Oostenryck (12):
  builtin: add generic .args method
  builtin: add builtin type for volatile void *
  builtin: make eval_sync_compare_and_swap() more generic
  builtin: evaluate __sync_*_fetch*()
  builtin: fix evaluation of __sync_lock_release
  builtin: __sync_synchronize() too is variadic
  builtin: add predefines for __ATOMIC_RELAXED & friends
  builtin: add support for __atomic_add_fetch(), ...
  builtin: add support for others generic atomic builtins
  builtin: add builtin type: [volatile] pointer to bool
  builtin: add support for __atomic_clear()
  builtin: add support for remaining atomic builtins

 builtin.c                         | 112 +++++++++++++++++++++---------
 predefine.c                       |   7 ++
 symbol.c                          |   6 ++
 symbol.h                          |   2 +
 validation/builtin-atomic-clear.c |  15 ++++
 validation/builtin-sync-fetch.c   |  24 +++++++
 6 files changed, 135 insertions(+), 31 deletions(-)
 create mode 100644 validation/builtin-atomic-clear.c
 create mode 100644 validation/builtin-sync-fetch.c


base-commit: 5192dc1ff23dae8644480a89ada8ff420ebb674a
-- 
2.28.0

