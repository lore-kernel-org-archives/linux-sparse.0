Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B03DC4363D
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCCF20853
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIEwtmcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgJEXEJ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgJEXEJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:04:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3730BC0613CE
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:04:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id b12so11305978edz.11
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94xFU3A6dhj02lfoUhD4GZc8HefRU0z48EvnOL5km3k=;
        b=sIEwtmccXyOaQkHIYsLSUwowGsaCv2Pzt82HZlDrxmeygSUHz1TgrJHfN5OW55w4xe
         mXXZxAcMF/pKumpc4WvU85fdF5hg58kRpiopsQDgdECdy/XcpDe/KsJSnv1DXZzj/vci
         rQS2dCYyU5Xdd808mvGI4yrPhGdTkpbHPCXyOmbTKgO0xbuHfIl+OAyGaqOM/SvWHw+j
         YdgFVifjXpYq1RMyI9UehU1bWkjCytb+DtiqiViSeSUikBoTOKeEP1bsbJwSdle4KPs3
         oiR3loTSy/8cyuimT8rwhphLfDkGhY6A1TSELBDGUe9JJ7/h/oakyy+KKNAChJHU/+vb
         oC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94xFU3A6dhj02lfoUhD4GZc8HefRU0z48EvnOL5km3k=;
        b=FBh6mGALAA/lE2DdvWzDyetbLzO/vyM4qmDrhMQvK68k7Ft0fz8isryVmHUI1kvT9A
         02O4vWH4BrAZqOEoCFupnB8FxUmIxQt8JH97eWmlcn8NNJrkUmZSL46Q81IJFl7yblln
         NT/5iLxHHlA4r892YMFULUKwi1RW87fT5Xkvb1UoIgj3nd6nPubkMyM9B3GjCoDyxzZs
         S0U8TsqYBtwtVFFLqSGS2CnB2ktwHQ6OuCfr8UBKQnrzxeOGm+txMU5ZkBEmGp2jEFbd
         NhDBvbs6LJdU/jsrdLmm6aVVdRPAE+EN9S6A62Qs1Z3fBdbAQaoCr+uWl3XrCgKOyFs3
         jNzg==
X-Gm-Message-State: AOAM530RHC26TV7JMeysrguuGcALICYOCf50VWD/GCPR5RpfAKfu2ZUU
        hPX2JaZM2VDOzQFlzmj1SstQ2Kr7abo=
X-Google-Smtp-Source: ABdhPJzSoAWSUvQssQW+cwVYZaZi9pq9foaV+NdSJaKLvaUk5fPRxwJ/KBN0dijpmT8HGz5q2zlwZQ==
X-Received: by 2002:a05:6402:1fb:: with SMTP id i27mr2167123edy.379.1601939045467;
        Mon, 05 Oct 2020 16:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id r9sm673546ejc.102.2020.10.05.16.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:04:04 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] fix usual conversion of integers
Date:   Tue,  6 Oct 2020 01:03:57 +0200
Message-Id: <20201005230401.74777-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

The current implementation of the usual conversion doesn't handle
correctly the case of 'long' + 'unsigned int' on a 32-bit arch.
The resulting type is 'unsigned int' instead of 'unsigned long'.

Fix this by following closely the C99's wording.
This now gives the expected result for C89 & C99 on 32 & 64-bit archs
(as tested with the GCC testsuite).

Luc Van Oostenryck (4):
  add builtin type pointer to bool: bool_ptr_ctype
  fix prototype of __sync_bool_compare_and_swap()
  fix evaluation of pointer to bool conversions
  fix usual conversion of integers

 builtin.c                          |  2 +-
 evaluate.c                         | 67 ++++++++++++++++--------------
 symbol.c                           |  2 +
 symbol.h                           |  1 +
 validation/linear/bool-cast-lp32.c |  1 -
 5 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.28.0

