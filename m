Return-Path: <SRS0=VjVX=AZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89644C433E3
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5546521941
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Jul 2020 00:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKszolTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgGNAAh (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNAAg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Jul 2020 20:00:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0416DC061755
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so9894783edt.10
        for <linux-sparse@vger.kernel.org>; Mon, 13 Jul 2020 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufgWJP2hcUCSPEk4Mp7bCHS93UD48OtzJLTLHKtXav8=;
        b=JKszolToiQY4USIzH0Mc4VD6V9dmR1JIh0/j5CfMU9IP9Ptd+rd6XxHa/bjszSPKbF
         CxvSjGlXvf9H3SlZNqhPaAe37HImLWG2l0+VJRFxmCKd0iyA++3G60lOVY3g9iycdw+P
         IkvsDjnpJS0qaWG8d+KLQT7XHdVm1w1JwoWaHyeYEj0XSnF+LQbNXoFfZDBnmbsoJZiO
         rWOJH71ViyK++Hr/NjILdchhmOQc0nXM7C4gAsKsTb0i3LiwjtW8Mo+rw0Yp4UKTZ2j7
         FNLaoMPB/cTAmPRwP+IHUAlXjWavfSodS8oyjwIh0Dfs5YEV+5MNzMbPrwpf34hXilbN
         DuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ufgWJP2hcUCSPEk4Mp7bCHS93UD48OtzJLTLHKtXav8=;
        b=b5zENMOKBIL4LFsMJPHfm/0Vz9mkGuHb/IUj5FIBXsjKThroR43NuEi2eX036/ewcB
         A5PYUgqKyGe0bUjC5RIMleCRxgbQGr4C766p8pbMjD52HtJpyH3vQK0caI6Dzb5cRgPn
         7jglMlsySSZ+2SPVsUey3Wtb6X5hRmeQEODLz1K2lDqvwqifi+rsf0J0+sN35Wth4nDk
         MYgJlXkcUowQgqwHgix0GtLHZ91FmlAibThv2rm/p+TJp5rOfyvTjUztMWNbSAcZr7rQ
         ZgTBjuQYNMOoK7JDqdrQ2oggwHr4f3ks7TFKgUBLKaOc4IOVsuheBtUtz3H2LG4Tsjhn
         ClNg==
X-Gm-Message-State: AOAM531iSXOvP4dbw53H+7w0Uy0T4vV60gjXDZjtDTYWI/3ZtiAwPGCy
        hL+ZLq3xEavLs7g90PhaYRF+ACe4
X-Google-Smtp-Source: ABdhPJxu9sJy5lfl6ItPXyhIF09bCIfP2mbYXC6HtWo44prLFHix0Nr8qF+petuQQgWd3x0nVoJ3Qg==
X-Received: by 2002:aa7:d78b:: with SMTP id s11mr1867310edq.319.1594684834477;
        Mon, 13 Jul 2020 17:00:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:5931:bb22:b701:e8f6])
        by smtp.gmail.com with ESMTPSA id z5sm7959443ejw.114.2020.07.13.17.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 17:00:33 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] warn on empty expressions
Date:   Tue, 14 Jul 2020 02:00:27 +0200
Message-Id: <20200714000030.85886-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse silently accepts empty assignments and empty initializers.
This series makes them an error.

Luc Van Oostenryck (3):
  add testcase for incorrect empty expressions
  warn on empty assignments
  warn on empty initializations

 expression.c                   |  6 +++++-
 parse.c                        |  5 ++++-
 validation/bad-assignment.c    |  1 +
 validation/empty-assign.c      | 13 +++++++++++++
 validation/empty-initializer.c |  9 +++++++++
 5 files changed, 32 insertions(+), 2 deletions(-)
 create mode 100644 validation/empty-assign.c
 create mode 100644 validation/empty-initializer.c


base-commit: c9676a3b0349a1053c673243af52a2ef1b272bd7
-- 
2.27.0

