Return-Path: <SRS0=/orK=BC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB55C433E4
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C8A20792
	for <linux-sparse@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQlst1MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGWXqr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGWXqr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:47 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF317C0619D3
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:46 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q4so2529341edv.13
        for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2020 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHsStjZagR4zVtTFsiqqqLBdH12EEkMBkcHUHiLCTm8=;
        b=rQlst1MQRpw1oPAivczaLMK+SqHNnrtM2pXYUBSDwr7WL/cUYPIJkusINz/J2roWPb
         DADe/nOh012rh0U4tDoAMur26TVaA54kZ8JHyy47k9tbu6nIlcCJX3RU30IcgFWf2Ien
         wtr8kF5SLDbYM+BxoTLT5ubGYYnlMyFr0Sw0otB1WwCtTYkoFXQKpEowrMRw75AOHJBT
         cRPkCB08suZP0jEHoL/v5lkrcvqvM8efLoFUducCP8lf9tpfBv3NuEBUZ6Ye3uEDGqKa
         K6rzdlZnScu+2nUG7ibKIMVLt1X2x0p6YKtxren9bVLW8Fk2SAb82iRX5a6J5i0g2oVG
         Agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHsStjZagR4zVtTFsiqqqLBdH12EEkMBkcHUHiLCTm8=;
        b=BnY4t7CdJzkPmQGPOZdVY3DZJc5ccre+fZyKD4xA0k9vcWkFtS2xKgUwgQ/VVmLH+C
         jAXXxepw0Xjxtdm7jf7g37dmCbhoOS33iLl0YXSvuQ6gOYhVS26rgAhgBqSxITdPqNK5
         2UafbxjNyxYDYO7NHjW4tCrinfZA7k/sfC83CvoBxRwiNSpiaKCyNHiUNDT1pRjhl280
         rGNtuMaUzQTa7yQcUw2a8NLhs48OUbKrMF5tTtEFF1Wtp8tVE5QLsMrbC1t3MErWZCvL
         jnkwcjXSJdvBoLojcZAC5kFZ4dL79NuLxbUqkozQCD/iju8L9vMAQkJolRetelSAI2yX
         ukyQ==
X-Gm-Message-State: AOAM532Tw7dhfc0HmUiai25ne53hMQAmqQtoxABM/NGWFDw0kPqyjOWE
        aiGFzfNan1ZERicGIxXowmNVZGLp
X-Google-Smtp-Source: ABdhPJyqnryHqu73AOD6c/X1PGhhawWbTqm3ynBu65dpz7gAp64hgd18GMs6oD1peGCgjaYpDlpixw==
X-Received: by 2002:aa7:d78b:: with SMTP id s11mr6745162edq.319.1595548005489;
        Thu, 23 Jul 2020 16:46:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:a981:5f61:c34f:8c32])
        by smtp.gmail.com with ESMTPSA id bq8sm3086975ejb.103.2020.07.23.16.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:46:44 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/6] fix parsing of C99's array declarators
Date:   Fri, 24 Jul 2020 01:46:35 +0200
Message-Id: <20200723234641.78462-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

C99's array declarators were only partially parsed.
This series completes and simplify this parsing.

Luc Van Oostenryck (6):
  add testcase for comma in array declarator
  do not accept comma expressions in array declarator
  add testcases for C99 array declarators
  simplify & fix parsing of array declarators
  remove now unused match_idents()
  allow [*] in array declarators

 parse.c                                      | 53 ++++++--------------
 symbol.h                                     |  2 +-
 validation/abstract-array-declarator-quals.c | 21 ++++++++
 validation/abstract-array-declarator-star.c  |  8 +++
 validation/abstract-array-declarator.c       | 11 ++++
 5 files changed, 57 insertions(+), 38 deletions(-)
 create mode 100644 validation/abstract-array-declarator-quals.c
 create mode 100644 validation/abstract-array-declarator-star.c
 create mode 100644 validation/abstract-array-declarator.c

-- 
2.27.0

