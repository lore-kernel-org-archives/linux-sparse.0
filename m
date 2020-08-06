Return-Path: <SRS0=443P=BQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E845C433E0
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926192177B
	for <linux-sparse@archiver.kernel.org>; Thu,  6 Aug 2020 19:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHSzKwkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHFTaP (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHFTaN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Aug 2020 15:30:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F84C061574
        for <linux-sparse@vger.kernel.org>; Thu,  6 Aug 2020 12:30:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l4so51492521ejd.13
        for <linux-sparse@vger.kernel.org>; Thu, 06 Aug 2020 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2KLT2P0gVxhHIIS67YbEBfRVw1/h2MRZm4VFwGySns=;
        b=NHSzKwkxLqiW4WkhaM0N+zE95KJs9JEBl9fvkZrbaQmVO6GegEkuKXeRZIX01OOVdB
         DmpqZh7v78nJDsjF+9ymUbT0qr/rUKel9fxZpRyhKSDGwLtMCiKsrLYUrsnzE12kp7Gn
         lS1xxqjL1wPPFpsf6OBHBCJB1G7yeOJMcqB+0MqJOH9y5W5BspeQMygBVBpLqctMZw00
         aEYBibqrajLHl8QQN0aVoDO735wG7yUiQ+LR7njHDRwSUsP8bK0lQ9uYPoCvT5WRgHxL
         hJmMG8UqqbRKVIK5IlVF+97oWJueS+saA9PPMo7ombKf2gs6KEq/9E6wZXV2SsNYUfni
         rG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2KLT2P0gVxhHIIS67YbEBfRVw1/h2MRZm4VFwGySns=;
        b=UBk7EAab+5WSp9Pt7WePzXrAlp8NmGBtObYDvqlCbaGDy6NNmlFHEb5mPTDMpBBmQy
         UZUPH4Ijozfj+3roRMdWJBCkXcFgVIXTSg1RIi2hSktwPLxf3UwpHOzFn5/XRkOFpGFI
         Zw7JaTDa2Kwtiv9WcveoNxkMAyKeGELNijnSrlvjeQgBkuS1AEirKxFxRMIksr+HewNA
         BBXbJoAnvO1bsH1oY88ZyCn54VzRzDs1K4KFNAySzAx4aHjDp30TTorm70N+Fuoe37+k
         jPeU/rZn7POthLsGZFp4HO+8MyndVKDz3u/kGL/ywH4ZsfI+Zh2foBDiLFb+zzSgQsCy
         uL5A==
X-Gm-Message-State: AOAM531k4aAWAjBpgsdK1oprklhscjTC1JUWPfjp8AHbhAUICB05d3uM
        /uoafBILYlCWgdQdemyxn4o9EX1/
X-Google-Smtp-Source: ABdhPJz2ycCREzv0KVCZrSveaTK+WP/mlm9T/CAgRl8iCyFfBH8gn1jejHJQI1gDxf0TmdG4dZP6mQ==
X-Received: by 2002:a17:906:a081:: with SMTP id q1mr5643534ejy.499.1596742211641;
        Thu, 06 Aug 2020 12:30:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id t19sm4055972edw.63.2020.08.06.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:30:11 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     linux-sparse@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] Fix shifts-assigns and avoid warns on deadcode
Date:   Thu,  6 Aug 2020 21:29:59 +0200
Message-Id: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Sparse warns shifts by a negative or oversized amount but
it does this even on code that will not be executed. It's
annoying because such warnings are given for generic macros.

The strategy for these warnings is changed in patch 4:
they are delayed until after the elimination of deadcode.
This uncovered a bug in the type evaluation and the linearization
of shift-assigns which is now solved in patch 2 & 3.

Thanks to Stafford Horne to bring this back to my attention.

This series is available for testing & review at:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git bad-shift-equal


Luc Van Oostenryck (4):
  shift-assign: add more testcases for bogus linearization
  shift-assign: fix linearization of shift-assign
  shift-assign: restrict shift count to unsigned int
  bad-shift: wait dead code elimination to warn about bad shifts

 evaluate.c                         |  11 +-
 expand.c                           |  18 --
 linearize.c                        |  44 ++++
 simplify.c                         |  20 +-
 validation/expand/bad-shift.c      |   8 +-
 validation/linear/bug-assign-op0.c |   1 -
 validation/linear/shift-assign1.c  | 319 +++++++++++++++++++++++++++++
 validation/linear/shift-assign2.c  |  53 +++++
 validation/optim/shift-big.c       |  12 +-
 validation/shift-negative.c        |   4 +-
 validation/shift-undef-long.c      |   7 +-
 validation/shift-undef.c           |  52 ++---
 12 files changed, 462 insertions(+), 87 deletions(-)
 create mode 100644 validation/linear/shift-assign1.c
 create mode 100644 validation/linear/shift-assign2.c


base-commit: 4c6cbe557c48205f9b3d2aae4c166cd66446b240
-- 
2.28.0

