Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA18DC433C1
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A68A61946
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Mar 2021 17:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCURJE (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Mar 2021 13:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhCURI2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Mar 2021 13:08:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6540C061574
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kt15so8017012ejb.12
        for <linux-sparse@vger.kernel.org>; Sun, 21 Mar 2021 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YS68xNFWhWPJ43I0fOP2a7ZV3ufcldfnEWle4zY8Gmk=;
        b=pmUPRFuaG9pKK9hvu19LesjezAwSpWjMbJQeK+EfFGwcV3/B9DW8DegHEG0trUVVrt
         haCYnilXdKuKXDXZfceXSZpvukaTivzGk/QvpXgdl+RUibcwjBxDQ0I1YskJFSlLH75i
         3GM0XmNxI9nE16pquRBrd5ZKz7ILFX1/n4jSammJ3rlYTc6/SW8tswTAdLLiS35RjaSM
         4VTsTLZr4XZeQQ8WOpIIrTMipavuVzyvvQd0YY0MvKL60BAe9DTppy378h0bqdijTMrT
         u276gabRa1Wp8RltS47vg2PHsrzVuX9W0Hs/cs/k8mt4m9BXqK11tRU4C2tXuZPtPjcs
         jk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YS68xNFWhWPJ43I0fOP2a7ZV3ufcldfnEWle4zY8Gmk=;
        b=nIIBN6cDIgjOTn92zCa7slGyNZZUzPjWYOTB5ZuNQIRh51xT+bUMn0+4/9ymXaFqdR
         sGlXz6plgc3K+uj+Zc0OV0lt6Bs2vBv/Ac69ZKRXFzYJHy8wtYkvao5cmT5/tkOjwoVx
         r+ft+fLg/Z/AiVNtuXevkF+ON9MqLLFMen+YepSTrM79n/e8RT6iMYhza6oe76wf810K
         GtUajfBbqOqs9OGwXXJLOoJCfaR0pyyGt4ikuaF6eBosBdB3mOajIO/H82KOHqcTY1BN
         DeKmcKBcmsri66DV4Vbe10IVtqugrfB8Ufx4V9i7zo+ZVscA6KkhYlQ4IQye+Pnkdao9
         etBg==
X-Gm-Message-State: AOAM531yTWWsjWzIcvmpxvhnOF4wRN881qdTUatjS1WSQs5dWQHpJDDc
        FJIZ8zbl3D8mRD0GK4kd5yOghCrOr/8=
X-Google-Smtp-Source: ABdhPJwCWiTcIYYF9m85ruw6D9DcHNfk3EsC8leamWLfL7JVdiwa5GWZOzSipEDmpEOBpqbtmXGNAA==
X-Received: by 2002:a17:907:1693:: with SMTP id hc19mr15120350ejc.28.1616346506408;
        Sun, 21 Mar 2021 10:08:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:dc34:259e:8292:82c0])
        by smtp.gmail.com with ESMTPSA id 90sm9108044edr.69.2021.03.21.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 10:08:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] memops: small cleanups
Date:   Sun, 21 Mar 2021 18:08:16 +0100
Message-Id: <20210321170822.46854-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

This series contains some small cleanups in preparation for
incoming changes concerning memops simplification

Luc Van Oostenryck (6):
  memops: dominates()s first arg is redundant
  memops: find_dominating_parents()s generation is redundant
  memops: remove obsolete comment
  memops: do not mess up with phisource's source ident
  memops: avoid using first_pseudo()
  memops: we can kill addresses unconditionally

 flow.c   |  4 ++--
 flow.h   |  2 +-
 memops.c | 39 ++++++++++++++++-----------------------
 3 files changed, 19 insertions(+), 26 deletions(-)


base-commit: 7b5cc7b6135733cbbce121cc94fdc4a5400f46b5
-- 
2.31.0

